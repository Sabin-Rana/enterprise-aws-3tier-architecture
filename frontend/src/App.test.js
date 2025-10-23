test('basic frontend test', () => {
  expect(true).toBe(true);
});

test('environment setup', () => {
  expect(process.env.NODE_ENV).toBeDefined();
});
