local wezterm = require 'wezterm'
local mux = wezterm.mux

local config = wezterm.config_builder()
local action = wezterm.action

wezterm.on("gui-startup", function()
  local tab, pane, window = mux.spawn_window {}
  local gui_window = window:gui_window();

  gui_window:perform_action(action.ToggleFullScreen, pane)
end)

config.font = wezterm.font({ family = "JetBrains Mono Regular", weight = "Regular" })
config.font_size = 12
config.font_rules = {
  {
    intensity = "Bold",
    italic = false,
    font = wezterm.font({ family = "JetBrains Mono Bold", weight = "Bold", italic = false }),
  },
  {
    intensity = "Normal",
    italic = true,
    font = wezterm.font({ family = "JetBrains Mono Italic", weight = 'Regular', italic = true }),
  },
  {
    intensity = "Bold",
    italic = true,
    font = wezterm.font({ family = "JetBrains Mono Bold Italic", weight = "Bold", italic = true }),
  }
}

config.leader = { key = 'q', mods = 'CTRL', timeout_milliseconds = 1000 }

config.color_scheme = 'ayu'
config.default_prog = { '/usr/bin/fish', '-l' }

config.default_cursor_style = 'BlinkingBar'
config.animation_fps = 1
config.line_height = 1.25
config.window_decorations = 'NONE'
config.max_fps = 144
-- config.enable_tab_bar = false
-- config.enable_scroll_bar = true
-- config.disable_default_key_bindings = true

-- Tab bar
config.show_tab_index_in_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true

config.keys = {
  { key = '-',          mods = 'LEADER',      action = action.SplitVertical },
  { key = '\\',         mods = 'LEADER',      action = action.SplitHorizontal },

  { key = 'F11',        mods = nil,           action = action.ToggleFullScreen },
  { key = 'z',          mods = 'LEADER',      action = action.TogglePaneZoomState },

  { key = 'LeftArrow',  mods = 'CTRL|SHIFT',  action = action.MoveTabRelative(-1) },
  { key = 'RightArrow', mods = 'CTRL|SHIFT',  action = action.MoveTabRelative(1) },

  { key = 'c',          mods = 'LEADER',      action = action.SpawnTab 'CurrentPaneDomain' },
  { key = 'x',          mods = 'LEADER',      action = action.CloseCurrentPane { confirm = true } },
  { key = 's',          mods = 'LEADER',      action = action.PaneSelect { alphabet = '1234567890' } },
  { key = ' ',          mods = 'LEADER',      action = action.QuickSelect },

  { key = 'h',          mods = 'LEADER|CTRL', action = action.AdjustPaneSize { 'Left', 5 } },
  { key = 'l',          mods = 'LEADER|CTRL', action = action.AdjustPaneSize { 'Right', 5 } },
  { key = 'k',          mods = 'LEADER|CTRL', action = action.AdjustPaneSize { 'Up', 5 } },
  { key = 'j',          mods = 'LEADER|CTRL', action = action.AdjustPaneSize { 'Down', 5 } },

  { key = 'h',          mods = 'LEADER',      action = action.ActivatePaneDirection 'Left' },
  { key = 'l',          mods = 'LEADER',      action = action.ActivatePaneDirection 'Right' },
  { key = 'k',          mods = 'LEADER',      action = action.ActivatePaneDirection 'Up' },
  { key = 'j',          mods = 'LEADER',      action = action.ActivatePaneDirection 'Down' },
  -- {
  --   key = 'j',
  --   mods = 'LEADER',
  --   action = wezterm.action_callback(function(window, panel) -- check if zoomed
  --     action.ActivatePaneDirection('Down')
  --   end)
  -- },
}

config.key_tables = {}

return config
