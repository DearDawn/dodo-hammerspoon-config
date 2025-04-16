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
-- hs.loadSpoon("ToggleScreenRotation")
-- spoon.ToggleScreenRotation.rotating_angles = {0, 270}
-- spoon.ToggleScreenRotation:bindHotkeys({
--     [SCREEN.K1] = {PUSH_KEY, "r"}
-- })

-- [插件] 自动重载配置文件
hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()
hs.alert("重载 Hammerspoon 配置文件")

-- [插件] 我的 -- 自动高亮当前显示器
-- hs.loadSpoon("D_HighlightFocus")

-- [开发] 软件启动后自动移到屏幕指定位置
function applicationWatcher(appName, eventType, appObject)
    if (eventType == hs.application.watcher.launched) then
        print(appName .. " 已启动")
        if (APP_LAYOUT[appName]) then
            Utils.printTable(APP_LAYOUT[appName])
            if (type(APP_LAYOUT[appName][1]) == 'string') then
                hs.layout.apply({ APP_LAYOUT[appName] })
            else
                hs.layout.apply({ APP_LAYOUT[appName][1][1] })
            end
        end
    end
    -- spoon.D_HighlightFocus:watch(appName, eventType, appObject)
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
hs.hotkey.bind(PUSH_KEY, "n", function()
    Utils.push(LAYOUT.left_top)
end) -- left side
hs.hotkey.bind(PUSH_KEY, "m", function()
    Utils.push(LAYOUT.right_top)
end) -- right side
hs.hotkey.bind(PUSH_KEY, ",", function()
    Utils.push(LAYOUT.left_bottom)
end) -- top half
hs.hotkey.bind(PUSH_KEY, ".", function()
    Utils.push(LAYOUT.right_bottom)
end) -- bottom half
hs.hotkey.bind(PUSH_KEY, "'", function()
    Utils.push(LAYOUT.middle)
end) -- bottom half

hs.hotkey.bind(PUSH_KEY, "/", function()
    Utils.push(LAYOUT.bottom_middle)
end)

-- FullSCREEN
hs.hotkey.bind(PUSH_KEY, ";", function()
    Utils.push(LAYOUT.full)
end)

-- 最小化窗口
-- hs.hotkey.bind(PUSH_KEY, "/", function()
-- hs.window.focusedWindow():minimize()
-- end)

-- -- Move active window to previous monitor
-- hs.hotkey.bind(PUSH_KEY, "u", function()
--     hs.window.focusedWindow():moveOneScreenNorth()
-- end)

-- -- Move active window to next monitor
-- hs.hotkey.bind(PUSH_KEY, "i", function()
--     hs.window.focusedWindow():moveOneScreenSouth()
-- end)

-- 三屏模式四区域
hs.hotkey.bind(PUSH_KEY, "up", function()
    hs.window.focusedWindow():moveOneScreenNorth()
end)

hs.hotkey.bind(PUSH_KEY, "down", function()
    hs.window.focusedWindow():moveOneScreenSouth()
end)

hs.hotkey.bind(PUSH_KEY, "left", function()
    if (hs.window.focusedWindow():screen():name() == SCREEN["MAC"]) then
        Utils.push(LAYOUT.left_5)
    else
        hs.window.focusedWindow():moveOneScreenWest()
    end
end)

hs.hotkey.bind(PUSH_KEY, "right", function()
    if (hs.window.focusedWindow():screen():name() == SCREEN["MAC"]) then
        Utils.push(LAYOUT.right_5)
    else
        hs.window.focusedWindow():moveOneScreenEast()
    end
end)

hs.hotkey.bind(PUSH_KEY, 'forwarddelete', function()
    hs.alert("重置布局")
    for k, v in pairs(APP_LAYOUT) do
        if (type(v[1]) == 'string') then
            hs.layout.apply({ v })
        else
            local app = hs.application.get(v[1][1])
            local appName = app:name();
            if app then
                -- 获取所有有效窗口
                local windows = app:allWindows()
                -- 遍历布局配置
                for _, layoutConfig in ipairs(APP_LAYOUT[appName]) do
                    local targetTitlePart = layoutConfig[2] or "" -- 获取配置中的标题部分
                    local found = false

                    -- 遍历窗口寻找匹配
                    for _, win in ipairs(windows) do
                        if not win:isMinimized() and win:isStandard() then
                            local actualTitle = win:title()
                            -- 模糊匹配逻辑（不区分大小写）
                            if string.find(actualTitle:lower(), targetTitlePart:lower(), 1, true) then
                                print("匹配到窗口: " .. actualTitle)
                                -- 动态生成布局配置
                                local dynamicLayout = {
                                    {
                                        layoutConfig[1], -- APP.Chrome
                                        actualTitle,     -- 使用实际完整标题
                                        layoutConfig[3], -- SCREEN
                                        layoutConfig[4], -- rect
                                        nil,
                                        nil
                                    }
                                }
                                hs.layout.apply(dynamicLayout)
                                found = true
                                break -- 每个配置项只匹配第一个符合条件的窗口
                            end
                        end
                    end

                    if not found then
                        print("未找到匹配 " .. targetTitlePart .. " 的窗口")
                    end
                end
            end
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

hs.hotkey.bind(PUSH_KEY, "W", function()
    hs.alert.show("Hello World!")
end)

hs.hotkey.bind(PUSH_KEY, "return", function()
    Config.envChange()
end)

-- 切换 Charles 是否代理 MAC
hs.hotkey.bind(PUSH_KEY, "P", function()
    Utils.toggle_charles_os_proxy()
end)

-- 查看 Charles 代理地址
hs.hotkey.bind(PUSH_KEY, "[", function()
    Utils.show_charles_os_addr()
end)

-- 切换 VPN 代理模式
hs.hotkey.bind(PUSH_KEY, "]", function()
    Utils.toggle_clashx_mode()
end)
