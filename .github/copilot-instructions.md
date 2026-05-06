# Copilot Instructions

## SketchyBar Icon Policy

- Use SF Symbols for all SketchyBar status icons (WiFi, battery, network, media, system state).
- Do not use emoji icons in SketchyBar plugins.
- Do not use Nerd Font icons for status modules unless explicitly requested by the user.
- Keep icons low-color and modern: icon glyph + neutral text label.

## Required Font Settings

- For SketchyBar items that render SF Symbols, set `icon.font="SF Pro:Semibold:14.0"` (or close size/weight equivalent).
- Keep text labels in JetBrainsMono Nerd Font unless a user asks to change typography.

## Preferred Symbol Examples

- WiFi online: `􀙇`
- WiFi offline: `􀙈`
- Battery charging: `􀢋`
- Battery: `􀛨`

## Sketchybar scripts

avoid polling where possible and instead subscribe to relevant events (e.g. `front_app_switched`, `space_change`, `aerospace_workspace_change`) to trigger updates in SketchyBar plugins.