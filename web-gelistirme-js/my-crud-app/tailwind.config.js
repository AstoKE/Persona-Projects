/** @type {import('tailwindcss').Config} */
export default {
  content: ['./index.html', './src/**/*.{js,jsx}'],
  theme: {
    extend: {
      colors: {
        primary: '#1565C0',
        accent:  '#0288D1',
      },
    },
  },
  plugins: [],
}
