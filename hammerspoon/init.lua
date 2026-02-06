-----------------------------------------
--  Paste without formatting in Teams ---
-----------------------------------------
local teamsHotkey = hs.hotkey.new({"cmd", "shift"}, "v", function()
    local plainText = hs.pasteboard.readString()
    if plainText then
        hs.pasteboard.setContents(plainText)
        local app = hs.application.frontmostApplication()
        app:selectMenuItem({"Edit", "Paste"})
    end
end)

local teamsWatcher = hs.application.watcher.new(function(appName, eventType, app)
    if appName == "Microsoft Teams" then
        if eventType == hs.application.watcher.activated then
            teamsHotkey:enable()
        elseif eventType == hs.application.watcher.deactivated then
            teamsHotkey:disable()
        end
    end
end)
teamsWatcher:start()

------------------------------------
--- Notify on thermal throttling ---
------------------------------------
local function checkThermals()
    local state = hs.host.thermalState()
    
    if state == "critical" then
        hs.notify.new({title = "Thermal Throttling", informativeText = "🔥 System is thermal throttling"}):send()
    end
end

thermalTimer = hs.timer.doEvery(30, checkThermals)
