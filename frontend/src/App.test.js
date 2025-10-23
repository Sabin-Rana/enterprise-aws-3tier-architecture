import { render, screen } from '@testing-library/react';
import App from './App';

test('renders without crashing', () => {
  render(<App />);
});

test('app component exists', () => {
  expect(App).toBeDefined();
});
