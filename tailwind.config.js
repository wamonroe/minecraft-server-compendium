const defaultConfg = require('tailwindcss/defaultConfig')

module.exports = {
  future: {
    removeDeprecatedGapUtilities: true,
    purgeLayersByDefault: true
  },
  experimental: {
    extendedSpacingScale: true,
    defaultLineHeights: true,
    uniformColorPalette: true
  },
  purge: [
    '**/*.html.erb',
    '**/*.js'
  ],
  theme: {
    extend: {},
    fontFamily: {
      'sans': ['Inter', ...defaultConfg.theme.fontFamily.sans]
    }
  },
  variants: {
    backgroundColor: [...defaultConfg.variants.backgroundColor, 'group-hover'],
    borderColor: [...defaultConfg.variants.borderColor, 'hover'],
    borderWidth: [...defaultConfg.variants.borderWidth, 'hover'],
    boxShadow: [...defaultConfg.variants.boxShadow, 'focus-within'],
    textColor: [...defaultConfg.variants.textColor, 'group-hover']
  },
  plugins: [
    require('@tailwindcss/custom-forms')
  ]
}
