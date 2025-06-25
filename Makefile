# ------------------------------
# Playwright E2E | Docker + K8s + CI/CD
# ------------------------------

# Load env
-include .env
export

IMAGE_NAME=$(DOCKER_USERNAME)/playwright-tests:latest
GHCR_IMAGE=ghcr.io/$(GITHUB_USER)/playwright-tests:latest
REPORT_DIR=tests/test-results
HTML_REPORT=$(REPORT_DIR)/report.html

.PHONY: help test report docker k8s-job k8s-report ci secrets clean

help:
	@echo ""
	@echo "🚀 Usage:"
	@echo "  make test         🔁 Run Playwright tests via Docker Compose"
	@echo "  make docker       🐳 Build Docker image"
	@echo "  make k8s-job      ☸️  Deploy test job to Kubernetes"
	@echo "  make k8s-report   📄 Show K8s job logs"
	@echo "  make report       📂 Open latest HTML test report"
	@echo "  make ci           🔄 Simulate CI build/push"
	@echo "  make secrets      🔐 Upload .env to GitHub Secrets"
	@echo "  make clean        🧹 Remove containers and reports"
	@echo ""

test:
	@echo "🔁 [TEST] Running Playwright via Docker Compose..."
	docker-compose --env-file .env up --build --abort-on-container-exit
	@echo "📄 [REPORT] Output: $(HTML_REPORT)"
	@echo "✅ [DONE] Tests finished."

report:
	@echo "📂 Opening HTML report..."
	@if [ -f $(HTML_REPORT) ]; then open $(HTML_REPORT); else echo "❌ No report found."; fi

docker:
	@echo "🐳 [DOCKER] Building Docker image..."
	docker build -t $(IMAGE_NAME) .

k8s-job:
	@echo "☸️  [K8S] Deploying Job & PVC..."
	kubectl apply -f k8s/pvc.yaml
	kubectl apply -f k8s/job.yaml

k8s-report:
	@echo "📦 [K8S LOGS] Fetching logs from K8s job..."
	kubectl logs job/playwright-tests

ci:
	@echo "🚀 [CI] Logging into registries..."
	docker login -u $(DOCKER_USERNAME) -p $(DOCKER_PASSWORD)
	@echo "📦 [CI] Building + pushing DockerHub image..."
	docker build -t $(IMAGE_NAME) .
	docker push $(IMAGE_NAME)
	@echo "📦 [CI] Tagging + pushing GHCR image..."
	docker tag $(IMAGE_NAME) $(GHCR_IMAGE)
	docker push $(GHCR_IMAGE)
	@echo "✅ [CI] Image pushed to DockerHub + GHCR."

secrets:
	@echo "🔐 Uploading .env vars to GitHub Secrets..."
	@read -p "Enter your GitHub repo (e.g. kufbreezy/project): " REPO; \
	for line in $$(grep -v '^#' .env); do \
		KEY=$$(echo $$line | cut -d '=' -f 1); \
		VAL=$$(echo $$line | cut -d '=' -f 2-); \
		echo "→ Setting $$KEY..."; \
		gh secret set $$KEY -b"$$VAL" -R $$REPO; \
	done

clean:
	@echo "🧹 Cleaning containers and reports..."
	docker-compose down
	rm -rf $(REPORT_DIR)
