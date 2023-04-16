const defaultConfg = require("tailwindcss/defaultConfig");

/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./app/assets/stylesheets/**/*.css",
    "./app/components/**/*.{rb,html.erb}",
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.js",
    "./app/views/**/*.html.erb",
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ["Roboto", ...defaultConfg.theme.fontFamily.sans],
      },
    },
  },
  plugins: [require("@tailwindcss/forms")],
};
