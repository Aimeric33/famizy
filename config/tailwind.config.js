const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}',
    './app/views/**/*.html.erb',
    './config/initializers/simple_form_tailwind.rb'
  ],
  theme: {
    container: {
      center: true,
      padding: '1rem',
    },
    extend: {
      colors: {
        primary: {
          50: '#D4D9EA',
          100: '#B7C0DC',
          200: '#93A0CA',
          300: '#7081B9',
          400: '#4C62A7',
          500: '#284296',
          600: '#21377D',
          700: '#1B2C64',
          800: '#14214B',
          900: '#0D1632',
        },
        secondary: {
          50: '#FEFDCC',
          100: '#FEFBAA',
          200: '#FEF980',
          300: '#FDF755',
          400: '#FDF52A',
          500: '#FCF300',
          600: '#D2CB00',
          700: '#A8A200',
          800: '#7E7A00',
          900: '#545100',
        }
      },
      fontFamily: {
        sans: ['Rubik', ...defaultTheme.fontFamily.sans],
      },
      boxShadow: {
        'xs': '0 0 4px 0 rgba(0, 0, 0, 0.15)',
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
