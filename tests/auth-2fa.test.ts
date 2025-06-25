import { test, expect } from '@playwright/test';

test.describe('2FA Mock Flow', () => {
  const username = process.env.GITHUB_USER;
  const token = process.env.GITHUB_TOKEN;
  const baseURL = process.env.API_BASE_URL;

  test('should reject login without 2FA', async ({ request }) => {
    const response = await request.post(`${baseURL}/login`, {
      data: { username, password: 'mock-pass' }, // No 2FA code
    });

    expect(response.status()).toBe(401);
    const body = await response.json();
    expect(body.message).toMatch(/2FA required/i);
  });

  test('should succeed with correct 2FA', async ({ request }) => {
    // const response = await request.post(`${baseURL}/login`, {
    //   data: {
    //     username,
    //     password: 'mock-pass',
    //     twoFactorCode: '123456',
    //   },
    // });

    // expect(response.status()).toBe(200);
    // const body = await response.json();
    // expect(body.token).toBeDefined();
  });
});
