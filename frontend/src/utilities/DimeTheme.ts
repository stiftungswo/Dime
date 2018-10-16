import {createMuiTheme} from "@material-ui/core"
import {red} from "@material-ui/core/colors"

export default createMuiTheme({
    palette: {
        primary: {
            main: '#1e7fb6'
        },
        secondary: {
            main: '#a0ce4e'
        },
        error: red,
        // Used by `getContrastText()` to maximize the contrast between the background and
        // the text.
        contrastThreshold: 3,
        // Used to shift a color's luminance by approximately
        // two indexes within its tonal palette.
        // E.g., shift from Red 500 to Red 300 or Red 700.
        tonalOffset: 0.2,
    },
});
