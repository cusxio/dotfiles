const foregroundColor = '#ebdbb2'
const backgroundColor = '#1d2021'
const black = '#282828'
const red = '#fb4934'
const green = '#b8bb26'
const yellow = '#fabd2f'
const blue = '#83a598'
const magenta = '#d3869b'
const cyan = '#8ec07c'
const white = '#fbf1c7'
const lightBlack = '#ebdbb2'
const lightRed = '#cc241d'
const lightGreen = '#98971a'
const lightYellow = '#d79921'
const lightBlue = '#458588'
const lightMagenta = '#b16286'
const lightCyan = '#689d6a'
const lightWhite = '#a89984'

module.exports = {
    config: {
        // default font size in pixels for all tabs
        fontSize: 14,

        // font family with optional fallbacks
        fontFamily: '"InputMono-ExtraLight", Menlo, "DejaVu Sans Mono", "Lucida Console", monospace',

        // terminal cursor background color and opacity (hex, rgb, hsl, hsv, hwb or cmyk)
        cursorColor: yellow,

        // `BEAM` for |, `UNDERLINE` for _, `BLOCK` for █
        cursorShape: 'BEAM',

        // color of the text
        foregroundColor: foregroundColor,

        // terminal background color
        backgroundColor: backgroundColor,

        // border color (window, tabs)
        borderColor: 'transparent',

        // custom css to embed in the main window
        css: `
        * {
            -webkit-font-smoothing: antialiased;
        }
        .tab_tab {
            border-bottom: 2px solid transparent !important;
            border-left: 0px solid transparent !important;
            border-right: 0px solid transparent !important;
            transition: border-color .4s ease !important;
        }
        .tabs_borderShim {
            border-color: transparent !important;
        }
        .tab_active {
            background-color: ${backgroundColor};
            border-color: transparent ${yellow} ${yellow} !important;
        }
        .tabs_title {
            color: #585858
        }
        .tab_textInner {
            transition: color .4s ease !important;
            color: #585858 !important;
        }
        .tab_active .tab_textInner {
            color: #7d7777 !important;
        }
        `,

        // custom css to embed in the terminal window
        termCSS: '',

        // custom padding (css format, i.e.: `top right bottom left`)
        padding: '12px 14px',

        // the full list. if you're going to provide the full color palette,
        // including the 6 x 6 color cubes and the grayscale map, just provide
        // an array here instead of a color map object
        colors: {
            black,
            red,
            green,
            yellow,
            blue,
            magenta,
            cyan,
            white,
            // light
            lightBlack,
            lightRed,
            lightGreen,
            lightYellow,
            lightBlue,
            lightMagenta,
            lightCyan,
            lightWhite,
        },

        // the shell to run when spawning a new session (i.e. /usr/local/bin/fish)
        // if left empty, your system's login shell will be used by default
        shell: '',

        // for setting shell arguments (i.e. for using interactive shellArgs: ['-i'])
        // by default ['--login'] will be used
        shellArgs: ['--login'],

        // for environment variables
        env: {},

        // set to false for no bell
        bell: 'SOUND',

        // if true, selected text will automatically be copied to the clipboard
        copyOnSelect: false

        // URL to custom bell
        // bellSoundURL: 'http://example.com/bell.mp3',

        // for advanced config flags please refer to https://hyper.is/#cfg,,
    },

    // a list of plugins to fetch and install from npm
    // format: [@org/]project[#version]
    // examples:
    //   `hyperpower`
    //   `@company/project`
    //   `project#1.0.1`
    plugins: [],

    // in development, you can create a directory under
    // `~/.hyper_plugins/local/` and include it here
    // to load it and avoid it being `npm install`ed
    localPlugins: []
};