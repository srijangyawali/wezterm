local wezterm = require("wezterm")
local act = wezterm.action
local config = {}

-- this is obtained from the list using the command wezterm ls-fonts --list-system
config.font = wezterm.font("JetBrainsMonoNL Nerd Font")

-- using the given colorscheme
config.color_scheme = "Catppuccin Mocha (Gogh)"

-- changing the opacity
config.window_background_opacity = 0.96

-- remvoing the top bar from the window
config.window_decorations = "RESIZE"

config.window_close_confirmation = "AlwaysPrompt"
config.scrollback_lines = 3000

config.default_workspace = "home"

-- Dim inactive panes
config.inactive_pane_hsb = {
	saturation = 0.77,
	brightness = 0.5,
}

-- Keys
config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1000 }

config.keys = {

	-- Send C-a when pressing C-a twice
	{ key = "b", mods = "LEADER", action = act.SendKey({ key = "b", mods = "CTRL" }) },
	{ key = "y", mods = "LEADER", action = act.ActivateCopyMode },

	-- Pane Keybindings
	{ key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },

	-- Shift is required because | is not obtained without using the SHIFT key
	{ key = "|", mods = "LEADER|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },

	-- Changing the active window
	{ key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
	{ key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
	{ key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
	{ key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },

	{ key = "d", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },

	-- Creating a separate mode for resizing the panes
	{ key = "r", mods = "LEADER", action = act.ActivateKeyTable({ name = "resize_panes", one_shot = false }) },

	-- Tabs Keybindings
	{ key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
	{ key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) },
	{ key = "i", mods = "LEADER", action = act.ShowTabNavigator },

	-- Creating a separate mode to move the tabs from one location to another
	{ key = "m", mods = "LEADER", action = act.ActivateKeyTable({ name = "move_tabs", one_shot = false }) },

	-- Now the workspace
	{ key = "w", mods = "LEADER", action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },
}
-- Rather than using navigator it is sometimes earier to move along that tabs using the index numbers,
for i = 1, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = act.ActivateTab(i - 1),
	})
end

config.key_tables = {
	resize_panes = {
		{ key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },
		{ key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },
		{ key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },
		{ key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },
		{ key = "Escape", action = "PopKeyTable" },
	},
	move_tabs = {
		{ key = "h", action = act.MoveTabRelative(-1) },
		{ key = "l", action = act.MoveTabRelative(1) },
		{ key = "j", action = act.MoveTabRelative(-1) },
		{ key = "k", action = act.MoveTabRelative(1) },
		{ key = "Escape", action = "PopKeyTable" },
	},
}

-- Changing the tab-bar
config.use_fancy_tab_bar = false
-- config.status_update_interval = 1000
-- wezterm.on("update-right-status", function(window, pane)
-- 	-- Workspace name
-- 	local stat = window:active_workspace()
-- 	-- Not displaying the workspace name alwyas
-- 	if window:active_key_table() then
-- 		stat = window:active_key_table()
-- 	end
-- 	if window:leader_is_active() then
-- 		stat = "LDR"
-- 	end
--
-- 	-- Current working directory
-- 	local basename = function(s)
-- 		return string.gsub(s, "(.*[/\\])(.*)", "%2")
-- 	end
-- 	--
-- 	local cwd = basename(pane:get_current_working_dir())
-- 	--
-- 	-- Time
-- 	local date_and_time = wezterm.strftime_utc("%H:%M")
--
-- 	-- -- Current command
-- 	local cmd = basename(pane:get_foreground_process_name())
--
-- 	window:set_right_status(wezterm.format({
-- 		-- Wezterm has build-in nerd fonts
-- 		{ Text = wezterm.nerdfonts.md_table .. "  " .. stat },
-- 		{ Text = " | " },
-- 		{ Text = wezterm.nerdfonts.md_table .. "  " .. cwd },
-- 		-- { Text = " | " },
-- 		{ Text = wezterm.nerdfonts.md_table .. "  " .. cmd },
-- 		-- { Text = " | " },
-- 		{ Text = wezterm.nerdfonts.md_clock .. "  " .. date_and_time },
-- 	}))
-- end)

return config
