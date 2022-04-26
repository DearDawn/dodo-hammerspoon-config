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

module.printTable = printTable
module.push = push
module.getHsRect = getHsRect
module.useless = useless

return module

-- DONE 获取键盘码 keycode
-- other_tap = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(e)
--     local keyboardIdentifier = e:getProperty(hs.eventtap.event.properties.keyboardEventKeyboardType)
--     local currentModifiers = e:getCharacters(true)
--     hs.alert(currentModifiers, keyboardIdentifier)
--     print(e:getKeyCode(), keyboardIdentifier, currentModifiers)
-- end)
-- other_tap:start()
