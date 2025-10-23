describe('Basic Tests', () => {
  test('environment is test', () => {
    expect(process.env.NODE_ENV).toBe('test');
  });

  test('basic math works', () => {
    expect(1 + 1).toBe(2);
  });
});
