FROM node:20

WORKDIR /app

# Install Playwright system dependencies for browsers
RUN apt-get update && apt-get install -y \
    libnss3 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdrm2 \
    libxkbcommon0 \
    libxcomposite1 \
    libxdamage1 \
    libxfixes3 \
    libxrandr2 \
    libgbm1 \
    libasound2 \
    && rm -rf /var/lib/apt/lists/*

# Copy package.json and package-lock.json
COPY package.json package-lock.json ./

# Install dependencies, including Playwright with browser binaries
RUN npm install --save-dev typescript @playwright/test
RUN npx playwright install --with-deps

# Copy the rest of the application
COPY . .

# Optional: Expose port (if your app runs a server, not typically needed for Playwright tests)
EXPOSE 3000

# Run Playwright tests
CMD ["npx", "playwright", "test"]