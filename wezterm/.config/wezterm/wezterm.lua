local wezterm = require 'wezterm';

return {
  font = wezterm.font_with_fallback({
      -- {family="FiraCode Nerd Font Mono" ,weight="Medium", stretch="Normal", italic=false},
      {family="JetBrainsMono Nerd Font Mono", weight="Medium", stretch="Normal", italic=false},
      {family="JetBrainsMono Pro Nerd Font Mono", weight="Medium", stretch="Normal", italic=true},
  }),
  font_size = 13.5,
  color_scheme = "Gruvbox Dark",
  use_fancy_tab_bar = true,
  tab_bar_at_bottom = true,
  window_background_opacity = 0.9,
  text_background_opacity = 0.6,
  hide_tab_bar_if_only_one_tab = true,
  audible_bell = "Disabled",
  window_frame = {
        font = wezterm.font("FiraCode Nerd Font Mono"),
        font_size = 10.0,
  },
  keys = {
    {key="t", mods="CTRL", action=wezterm.action{SpawnTab="CurrentPaneDomain"}},
  }
}
