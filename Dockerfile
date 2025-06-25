FROM node:20

WORKDIR /app

# Install dependencies
RUN npm install --save-dev typescript @playwright/test

# Add the rest of your app
COPY . .

# Optional: expose port
EXPOSE 3000

CMD ["npx", "playwright", "test"]
