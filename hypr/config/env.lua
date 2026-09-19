local apps = require("config.apps")

hl.env("XCURSOR_SIZE", apps.cursorSize)
hl.env("HYPRCURSOR_SIZE", apps.cursorSize)

hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
