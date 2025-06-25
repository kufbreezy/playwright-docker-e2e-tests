import { test, expect } from '@playwright/test';

test('API responds with user details when bearer token is valid', async ({ request }) => {
  const baseURL = process.env.API_BASE_URL;
  const token = process.env.GITHUB_TOKEN;

  const response = await request.get(`${baseURL}/user`, {
    headers: {
      Authorization: `Bearer ${token}`,
    },
  });

  expect(response.status()).toBe(200);
  const body = await response.json();
  expect(body).toHaveProperty('login');
});
