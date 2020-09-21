const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  future: {
    removeDeprecatedGapUtilities: true,
    purgeLayersByDefault: true
  },
  purge: [
    '**/*.html.erb',
    '**/*.js'
  ],
  theme: {
    extend: {
      extend: {
        fontFamily: {
          sans: ['Roboto', ...defaultTheme.fontFamily.sans]
        }
      }
    },
  },
  variants: {},
  plugins: [
    require('@tailwindcss/custom-forms')
  ]
}
