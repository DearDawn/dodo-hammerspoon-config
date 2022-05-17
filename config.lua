local Utils = require('utils')
module = {}

local ALT = {"⌥"}
local PUSH_KEY = {"⌃", "⌘", "⌥"}
local SCREEN = {
    ["MAC"] = "Built-in Retina Display",
    -- Built-in Retina Display, note the % to escape the hyphen repetition character
    ["_MAC"] = "Built%-in Retina Display",
    -- ["K4"] = "DELL U2720Q",
    ["K4"] = "PHL 245B9",
    ["K1"] = "DELL P2719HC"
}

local LAYOUT = {
    ["left_5"] = {0, 0, 0.5, 1},
    ["right_5"] = {0.5, 0, 0.5, 1},
    ["top_7"] = {0, 0, 1, 0.7},
    ["top_5"] = {0, 0, 1, 0.5},
    ["bottom_5"] = {0, 0.5, 1, 0.5},
    ["bottom_3"] = {0, 0.7, 1, 0.3},
    ["middle"] = {0.05, 0.05, 0.9, 0.9},
    ["full"] = {0, 0, 1, 1}
}

-- 带下划线的给布局用，不带的给快捷键唤醒用，这里不一致，怪难受的
local APP = {
    ["Charles"] = "Charles",
    ["iTerm2"] = "iTerm2",
    ["iTerm"] = "iTerm",
    ["Lark"] = "Lark",
    ["WeChat"] = "WeChat",
    ["_Lark"] = "飞书",
    ["Chrome"] = "Google Chrome",
    ["VSCode"] = "Visual Studio Code",
    ["_VSCode"] = "Code",
    ["Finder"] = "Finder",
    ["ChromeCanary"] = "Google Chrome Canary",
    ["DIDA"] = "TickTick",
    ["_DIDA"] = "滴答清单"
}

-- 配置应用快捷键
local APP_KEY = {
    [APP.Charles] = "c",
    [APP.iTerm] = "i",
    [APP.Finder] = "e",
    [APP.Lark] = "1",
    [APP.VSCode] = "2",
    [APP.Chrome] = "3",
    [APP.DIDA] = "4",
    [APP.WeChat] = "5"
}

local APP_LAYOUT = {
    [APP.Charles] = {APP.Charles, nil, SCREEN.K1, Utils.getHsRect(LAYOUT.bottom_3), nil, nil},
    [APP.iTerm2] = {APP.iTerm2, nil, SCREEN.K1, Utils.getHsRect(LAYOUT.bottom_3), nil, nil},
    [APP._VSCode] = {{APP._VSCode, nil, SCREEN.K4, hs.layout.maximized, nil, nil},
                     {APP._VSCode, "Assets", SCREEN.K1, Utils.getHsRect(LAYOUT.bottom_3), nil, nil}},
    [APP.ChromeCanary] = {APP.ChromeCanary, nil, SCREEN.K1, Utils.getHsRect(LAYOUT.top_7), nil, nil},
    [APP.Chrome] = {APP.Chrome, nil, SCREEN.K4, hs.layout.maximized, nil, nil},
    [APP._Lark] = {APP._Lark, nil, SCREEN.MAC, hs.layout.maximized, nil, nil},
    [APP._DIDA] = {APP._DIDA, nil, SCREEN.MAC, hs.layout.maximized, nil, nil},
    [APP.DIDA] = {APP.DIDA, nil, SCREEN.MAC, hs.layout.maximized, nil, nil}
}

module.ALT = ALT
module.PUSH_KEY = PUSH_KEY
module.SCREEN = SCREEN
module.LAYOUT = LAYOUT
module.APP = APP
module.APP_KEY = APP_KEY
module.APP_LAYOUT = APP_LAYOUT

return module
