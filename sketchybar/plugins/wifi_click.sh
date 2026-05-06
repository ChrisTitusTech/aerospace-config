#!/bin/bash

# Try to open the native Control Center Wi-Fi picker first.
osascript <<'APPLESCRIPT' >/dev/null 2>&1
tell application "System Events"
    if not (exists process "ControlCenter") then
        error "ControlCenter is not available"
    end if

    tell process "ControlCenter"
        set frontmost to true

        repeat with theItem in (menu bar items of menu bar 1)
            try
                if description of theItem is "Wi-Fi" then
                    click theItem
                    return
                end if
            end try
        end repeat

        error "Wi-Fi menu bar item was not found"
    end tell
end tell
APPLESCRIPT

# Fall back to Wi-Fi settings if UI scripting is blocked/unavailable.
if [ $? -ne 0 ]; then
  open "x-apple.systempreferences:com.apple.Network-Settings.extension"
fi
