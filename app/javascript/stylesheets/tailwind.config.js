module.exports = {
  theme: {
    fontFamily: {
      sans: ['Inter', 'Arial', 'sans-serif']
    },
    color : {
      transparent: 'transparent',
      black: '#000',
      white: '#fff',
      primary: {
        600: '#31aeb5', //#805AD5',
        700: '#2daeb7', //#6B46C1',
        800: '#258a91' //#553C9A',
      },
      status: {
        draft: '#D69E2E',
        planned: '#38B2AC',
        in_progress: '#3182CE',
        complete: '#553C9A'
      },
      alert: {
        info: {
          light: '#EBF8FF', //Blue 100
          dark: '#2B6CB0' //Blue 700
        },
        success: {
          light: '#F0FFF4', //Green 100
          dark: '#2F855A' //Green 700
        },
        warning: {
          light: '#FEEBC8', //Orange 200
          dark: '#DD6B20' //Orange 600
        },
        danger: {
          light: '#FFF5F5', //Red 100
          dark: '#C53030' //Red 700
        }
      }
    }
  },
  variants: {},
  plugins: [],
}