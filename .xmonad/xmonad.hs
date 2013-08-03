--
-- The beginning of my escapade into xmonad.
--

import XMonad
import XMonad.Hooks.EwmhDesktops

main = xmonad $ defaultConfig
    {
        terminal           = "terminator",
        borderWidth        = 1,
        normalBorderColor  = "#000000",
        focusedBorderColor = "#ff0000",
        handleEventHook    = fullscreenEventHook
    }
