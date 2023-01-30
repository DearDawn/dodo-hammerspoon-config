module = {}

-- Resize window for chunk of screen.
-- For x and y: use 0 to expand fully in that dimension, 0.5 to expand halfway
-- For w and h: use 1 for full, 0.5 for half
function push(arr)
    local x = arr[1]
    local y = arr[2]
    local w = arr[3]
    local h = arr[4]

    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = max.x + (max.w * x)
    f.y = max.y + (max.h * y)
    f.w = max.w * w
    f.h = max.h * h
    win:setFrame(f)
end

function printTable(t)
    for k, v in pairs(t) do
        print(k, v)
    end
end

-- Return hs.geometry.rect
function getHsRect(arr)
    printTable(arr)
    local x = arr[1]
    local y = arr[2]
    local w = arr[3]
    local h = arr[4]
    return hs.geometry.rect(x, y, w, h)
end

function useless()
    caffeine = hs.menubar.new()
    function setCaffeineDisplay(state)
        if state then
            caffeine:setTitle("小糖牛逼呀")
        else
            caffeine:setTitle("小糖怎么啦")
        end
    end

    function caffeineClicked()
        setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
    end

    if caffeine then
        caffeine:setClickCallback(caffeineClicked)
        setCaffeineDisplay(hs.caffeinate.get("displayIdle"))
    end

end

-- 切换 Charles 是否代理 MAC
function toggle_charles_os_proxy()
    local application = hs.application.frontmostApplication()
    hs.application.launchOrFocus("Charles")
    local charles = hs.appfinder.appFromName("Charles")
    local macOSProxyMenu = { "Proxy", "macOS Proxy" }
    local macOSProxy = charles:findMenuItem(macOSProxyMenu)

    if (macOSProxy) then
        charles:selectMenuItem(macOSProxyMenu)
        charles:selectMenuItem({ "Charles", "Hide Charles" })
        application:activate()
        if (macOSProxy["ticked"]) then
            hs.alert.show("关闭 Charles macOS 代理")
        else
            hs.alert.show("开启 Charles macOS 代理")
        end
    end
end

-- 看看 Charles 的代理地址
function show_charles_os_addr()
    hs.application.launchOrFocus("Charles")
    local charles = hs.appfinder.appFromName("Charles")
    local macOSProxyMenu = { "Help", "SSL Proxying",
        "Install Charles Root Certificate on a Mobile Device or Remote Browser" }
    local macOSProxy = charles:findMenuItem(macOSProxyMenu)

    if (macOSProxy) then
        charles:selectMenuItem(macOSProxyMenu)
    end
end

module.printTable = printTable
module.push = push
module.getHsRect = getHsRect
module.useless = useless
module.toggle_charles_os_proxy = toggle_charles_os_proxy
module.show_charles_os_addr = show_charles_os_addr

-- DONE 获取键盘码 keycode
-- other_tap = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(e)
--     local keyboardIdentifier = e:getProperty(hs.eventtap.event.properties.keyboardEventKeyboardType)
--     local currentModifiers = e:getCharacters(true)
--     hs.alert(currentModifiers, keyboardIdentifier)
--     print(e:getKeyCode(), keyboardIdentifier, currentModifiers)
-- end)
-- other_tap:start()

return module
