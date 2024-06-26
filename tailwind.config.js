module.exports = {
  content: ['./src/**/*.{html,js,svelte,ts}'],
  theme: {
    extend: {
      fontFamily: {
        'inter': ['"Inter Tight Variable"', 'sans-serif'],
      },
      height: {
        'nav-small': '80px',
        'nav': '80px',
        'nav-large': '110px',
      },
      colors: {
        white: {
          DEFAULT: '#ffffff',
          1: '#f8f9fa',
          2: '#e9ecef',
        },
        grey: {
          DEFAULT: '#dee2e6',
          2: '#ced4da',
          3: '#adb5bd',
          4: '#6c757d',
          5: '#495057',
          6: '#343a40',
        },
        black: '#212529',
        purple: {
          DEFAULT: '#651FFF',
          2: '#7C4DFF',
          3: '#B99AFF',
          4: '#E8DEFF',
          5: '#F5F0FF',
        },
        blue: {
          DEFAULT: '#2979FF',
          'opaque': '#2978ff24',
          2: '#448AFF',
          3: '#91C2FF',
          4: '#DEEAFF',
          5: {
            DEFAULT: '#F0F5FF',
            'opaque': '#f0f5fff6',
          },
        },
        'black-blue': 'rgb(49, 52, 60)',
        orange: {
          DEFAULT: '#FF6F00',
          2: '#FF8426',
          3: '#FFA159',
          4: '#FFDBBF',
          5: '#FFF5E8',
        },
        yellow: {
          DEFAULT: '#FFAB00',
          2: '#FFB726',
          3: '#FFD98C',
          4: '#FFF3D9',
          5: '#FFFBE8',
        },
        green: {
          DEFAULT: '#00BFA5',
          2: '#26C8B2',
          3: '#59D5C4',
          4: '#BFEFE8',
          5: '#F2FCFA',
        },
      },
      boxShadow: {
        'a': 'rgba(0, 0, 0, .16) 0px 1px 4px',
        'b': 'rgba(0, 0, 0, .1) 0px 1px 3px 0px, rgba(0, 0, 0, .06) 0px 1px 2px 0px',
        'c': 'rgba(67, 71, 85, .27) 0px 0px .25em, rgba(90, 125, 188, .05) 0px .25em 1em',
        'd': 'rgba(17, 17, 26, .1) 0px 0px 16px',
      },
      transitionTimingFunction: {
        'out-quint': 'cubic-bezier(.23, 1, .32, 1)',
      },
    }
  },
  plugins: [],
}
