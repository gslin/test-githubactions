const sum = require('./sum');

test('smoke', () => {
  sum(0, 0);
});

test('1 + 2', () => {
  expect(sum(1, 2)).toBe(3);
});
