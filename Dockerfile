FROM node:20

WORKDIR /app

# Install dependencies
COPY package.json package-lock.json ./
RUN npm ci

# Add the rest of your app
COPY . .

# Optional: expose port
EXPOSE 3000

CMD ["npx", "playwright", "test"]
