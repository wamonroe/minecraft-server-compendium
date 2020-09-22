const defaultConfg = require('tailwindcss/defaultConfig')

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
      spacing: {
        '28': '7rem',
        '72': '20rem'
      }
    },
    fontFamily: {
      'sans': ['Roboto', ...defaultConfg.theme.fontFamily.sans]
    }
  },
  variants: {
    backgroundColor: [...defaultConfg.variants.backgroundColor, 'group-hover'],
    textColor: [...defaultConfg.variants.textColor, 'group-hover']
  },
  plugins: [
    require('@tailwindcss/custom-forms')
  ]
}
