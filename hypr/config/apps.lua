local apps = {}

---------------------
---- MY PROGRAMS ----
---------------------
apps.terminal = "ghostty"
apps.fastFetch = 'ghostty -e "fastfetch ; exec $SHELL"'
apps.tmuxTerminal = 'ghostty -e "tmux ; exec $SHELL"'
apps.fileManager = apps.terminal .. " -e yazi"
-- local secondFileManager =

apps.browser = "zen-browser"
apps.secondBrowser = "firefox"

apps.nvim = apps.terminal .. " -e nvim"
apps.learnin = apps.nvim .. " ~/Learnin/ "
apps.coding = apps.nvim .. " ~/Coding2/ "

apps.vsCode = "code"
apps.vsCodeCoding = apps.vsCode .. " ~/Coding2/ "
apps.vsCodeLearnin = apps.vsCode .. " ~/Learnin/ "

apps.menu = "rofi"
apps.appMenu = apps.menu .. " -show drun -show-iscons"
apps.cmdMenu = apps.menu .. " -show run"

-- Desantize from hardcoded name at some point
apps.hyprConfigPath = " /home/gumusbulut/.config/hypr"
apps.qsConfigPath = " /home/gumusbulut/.config/quickshell/"
apps.ghosttyConfigPath = " /home/gumusbulut/.config/ghostty/config.ghostty"

---------------------
--------RICE--------=
---------------------

apps.bar = "qs"
apps.idle = "hypridle"
apps.wallpaper = "hyprpaper"
apps.cursor = "Bibata-Modern-Classic"
apps.cursorSize = "24"

return apps
