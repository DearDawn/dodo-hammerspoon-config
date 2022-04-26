local Utils = require('utils')
local Config = require('config')

Utils.useless()

local ALT = Config.ALT
local PUSH_KEY = Config.PUSH_KEY
local SCREEN = Config.SCREEN
local LAYOUT = Config.LAYOUT
local APP_KEY = Config.APP_KEY
local APP_LAYOUT = Config.APP_LAYOUT

-- [插件] 鼠标自动居中
hs.loadSpoon("MouseFollowsFocus")
spoon.MouseFollowsFocus:start()

-- [插件] 屏幕自动旋转，不然三屏模式下，我的左侧竖屏有点小问题
hs.loadSpoon("ToggleScreenRotation")
spoon.ToggleScreenRotation.rotating_angles = {0, 270}
spoon.ToggleScreenRotation:bindHotkeys({
    [SCREEN.K1] = {PUSH_KEY, "r"}
})

-- [插件] 自动重载配置文件
hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()
hs.alert("重载 Hammerspoon 配置文件")

-- [开发] 软件启动后自动移到屏幕指定位置
function applicationWatcher(appName, eventType, appObject)
    if (eventType == hs.application.watcher.launched) then
        print(appName .. " 已启动")
        if (APP_LAYOUT[appName]) then
            Utils.printTable(APP_LAYOUT[appName])
            if (type(APP_LAYOUT[appName][1]) == 'string') then
                hs.layout.apply({APP_LAYOUT[appName]})
            else
                hs.layout.apply(APP_LAYOUT[appName])
            end
        end
    end
end
appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()

-- [开发] 窗口操作
-- None of this animation shit:
hs.window.animationDuration = 0

-- init grid
hs.grid.MARGINX = 0
hs.grid.MARGINY = 0
hs.grid.GRIDWIDTH = 7
hs.grid.GRIDHEIGHT = 3

-- Show grid
hs.hotkey.bind(PUSH_KEY, "g", hs.grid.show)

-- Push to SCREEN edge
hs.hotkey.bind(PUSH_KEY, "h", function()
    Utils.push(LAYOUT.left_5)
end) -- left side
hs.hotkey.bind(PUSH_KEY, "l", function()
    Utils.push(LAYOUT.right_5)
end) -- right side
hs.hotkey.bind(PUSH_KEY, "j", function()
    Utils.push(LAYOUT.top_5)
end) -- top half
hs.hotkey.bind(PUSH_KEY, "k", function()
    Utils.push(LAYOUT.bottom_5)
end) -- bottom half

-- Center window with some room to see the desktop
hs.hotkey.bind(PUSH_KEY, "m", function()
    Utils.push(LAYOUT.middle)
end)

-- FullSCREEN
hs.hotkey.bind(PUSH_KEY, ";", function()
    Utils.push(LAYOUT.full)
end)

-- Move active window to previous monitor
hs.hotkey.bind(PUSH_KEY, "u", function()
    hs.window.focusedWindow():moveOneScreenWest()
end)

-- Move active window to next monitor
hs.hotkey.bind(PUSH_KEY, "i", function()
    hs.window.focusedWindow():moveOneScreenEast()
end)

-- 三屏模式四区域
hs.hotkey.bind(PUSH_KEY, "up", function()
    hs.window.focusedWindow():moveToScreen(SCREEN.K1)
    Utils.push(LAYOUT.top_7)
end)

hs.hotkey.bind(PUSH_KEY, "down", function()
    hs.window.focusedWindow():moveToScreen(SCREEN.K1)
    Utils.push(LAYOUT.bottom_3)
end)

hs.hotkey.bind(PUSH_KEY, "left", function()
    hs.window.focusedWindow():moveToScreen(SCREEN.K4)
    Utils.push(LAYOUT.full)
end)

hs.hotkey.bind(PUSH_KEY, "right", function()
    hs.window.focusedWindow():moveToScreen(SCREEN._MAC)
    Utils.push(LAYOUT.full)
end)

hs.hotkey.bind(PUSH_KEY, 'forwarddelete', function()
    hs.alert("重置布局")
    for k, v in pairs(APP_LAYOUT) do
        if (type(v) == 'string') then
            hs.layout.apply({v})
        else
            hs.layout.apply(v)
        end
    end
end)

hs.hotkey.bind(PUSH_KEY, "q", function()
    helpstr = [[Hello
World!]]

    hs.alert.show(helpstr)
    hs.notify.new({
        title = "Hammerspoon",
        informativeText = "Hello World"
    }):send()
end)

-- 应用快捷键挂载
for k, v in pairs(APP_KEY) do
    hs.hotkey.bind(ALT, v, function()
        hs.application.launchOrFocus(k)
    end)
end

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
    hs.alert.show("Hello World!")
end)
