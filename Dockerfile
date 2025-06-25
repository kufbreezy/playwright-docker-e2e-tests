# Use official Playwright base image
FROM mcr.microsoft.com/playwright:v1.43.1-jammy

# Set working directory
WORKDIR /tests

# Copy tests into container
COPY tests/ /tests/

# Install dependencies if needed (example only)
# RUN npm install

# Run Playwright tests by default
CMD ["npx", "playwright", "test"]
