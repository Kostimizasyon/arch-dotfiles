local apps = require("config.apps")

---------------------
---- KEYBINDINGS ----
---------------------
local mainMod = "SUPER"
local secondMod = mainMod .. "+ SHIFT"
local thirdMod = secondMod .. "+ ALT"

---- APP LAUNCH ----

-- Nvim into config paths
hl.bind(mainMod .. " + C + H", hl.dsp.exec_cmd(apps.nvim .. apps.hyprConfigPath))
hl.bind(mainMod .. " + C + Q", hl.dsp.exec_cmd(apps.nvim .. apps.qsConfigPath))
hl.bind(mainMod .. " + C + G", hl.dsp.exec_cmd(apps.nvim .. apps.ghosttyConfigPath))

-- Launch apps
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(apps.terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(apps.fileManager))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(apps.browser))

hl.bind(secondMod .. " + B", hl.dsp.exec_cmd(apps.secondBrowser))
hl.bind(secondMod .. " + T", hl.dsp.exec_cmd(apps.tmuxTerminal))
hl.bind(secondMod .. " + F", hl.dsp.exec_cmd(apps.fastFetch))

hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(apps.coding))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(apps.vsCodeCoding))

--App launchers
hl.bind(mainMod .. " + space", hl.dsp.exec_cmd(apps.appMenu))
hl.bind(secondMod .. " + space", hl.dsp.exec_cmd(apps.cmdMenu))

-- Close window
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind("ALT + F4", hl.dsp.window.close())

-- Suspend pc
hl.bind(secondMod .. " + L", hl.dsp.exec_cmd("systemctl suspend-then-hibernate && hyprlock"))
hl.bind(
	thirdMod .. "+ F4",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
)

-- Screenshot
hl.bind("Print", hl.dsp.exec_cmd('grim -g "$(slurp)" - | tee ~/Pictures/grim/$(date +%Y-%m-%d_%H-%M).png | wl-copy'))
hl.bind(
	secondMod .. " + S",
	hl.dsp.exec_cmd('grim -g "$(slurp)" - | tee ~/Pictures/grim/$(date +%Y-%m-%d_%H-%M).png | wl-copy')
)

---- WINDOW SETUP ----

-- hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
-- hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + S", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

---- WORKSPACE MANAGEMENT ---
local vimDir = { "h", "l", "k", "j" }
-- Move focus with mainMod + arrow keys + vim keys
for i, direction in ipairs({ "left", "right", "up", "down" }) do
	hl.bind(mainMod .. " + " .. direction, hl.dsp.focus({ direction = direction }))
	hl.bind(mainMod .. " + " .. vimDir[i], hl.dsp.focus({ direction = direction }))
end

for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	-- Switch workspaces with mainMod + [0-9]
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	-- Move active window to a workspace with mainMod + SHIFT + [0-9]
	hl.bind(secondMod .. " + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
-- hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

---- FUNCTION ROW ----

-- Laptop multimedia keys for volume and LCD brightness
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
