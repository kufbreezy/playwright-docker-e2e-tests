import { test, expect } from '@playwright/test';

test('basic login form validation', async ({ page }) => {
  await page.goto('https://example.com/login');
  await page.fill('#username', 'testuser');
  await page.fill('#password', 'testpass');
  await page.click('button[type="submit"]');
  await expect(page).toHaveURL(/dashboard|home/);
});
