# 🧪 Playwright Docker E2E Testing Suite

**“Automating the boring. Securing the important.”**

This project showcases a full-stack QA automation pipeline designed to run **browser-based tests**, **2FA auth flows**, and **secure API checks** in a **Kubernetes environment**, with results reported to **Slack** and stored as **GitHub Artifacts**.

---

## 🚀 Tech Stack

| Layer        | Tools Used                             |
|--------------|-----------------------------------------|
| Test Runner  | [Playwright](https://playwright.dev)    |
| Auth Flow    | Mock 2FA Login                          |
| DevOps       | Docker, Kubernetes, GitHub Actions      |
| Reporting    | HTML Test Reports + Slack Notifications |
| CI/CD        | GitHub Actions → Kubernetes Integration |

---

## 🔧 What This Repo Demonstrates

✅ End-to-end browser test automation  
✅ 2FA login flow simulation  
✅ Dockerized environment  
✅ Kubernetes job, cronjob & deployment handling  
✅ GitHub Actions CI pipeline with secrets  
✅ Slack alerts on test success/failure  
✅ HTML test reporting and artifact uploads

---

## 📁 Folder Structure

```
.
├── Dockerfile
├── .dockerignore
├── docker-compose.yml
├── README.md
│
├── tests/
│   ├── auth-2fa.test.ts             # ✅ 2FA test flow with error/success cases
│   └── api.test.ts                  # ✅ Bearer token-secured API tests
│
├── k8s/
│   ├── pvc.yaml                     # PVC to persist test files
│   ├── job.yaml                     # K8s job to run the tests
│   ├── cronjob.yaml                 # Optional scheduled job
│   └── deployment.yaml             # Optional for long-running services
│
├── .github/
│   └── workflows/
│       └── build-and-deploy.yml    # ✅ CI/CD: Build image + Push to DockerHub & GHCR + Deploy K8s Job + Slack
│
└── reports/
    └── (auto-generated test HTML & logs on run)
```

---

## ⚙️ Quick Start

### 🐳 Run Locally

```bash
docker run -it --rm -v $(pwd)/tests:/tests mcr.microsoft.com/playwright:v1.43.1-jammy bash
npx playwright test
```

### ☸️ Run in Kubernetes

```bash
kubectl apply -f k8s/pvc.yaml
kubectl apply -f k8s/job.yaml
kubectl logs job/playwright-tests
```

### 💬 Slack Alerts Setup

Add this to your GitHub Secrets:

```
SLACK_WEBHOOK=<your_slack_webhook_url>
KUBECONFIG=<your_base64_encoded_kubeconfig>
```

---

## 📊 Sample Test Output

- ✅ `tests/report.html` → HTML visual test results
- 📩 Delivered as GitHub Artifact
- 🔔 Slack alert sent on job completion

---

## 👨🏽‍💻 Author

**Kufre Usanga**  
Automation Scripter | DevSecOps QA  
📫 kufre@engineer.com  
🌍 [github.com/kufre](https://github.com/kufre)  
🧠 *“Automating the boring. Securing the important.”*
