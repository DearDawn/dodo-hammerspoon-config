local Utils = require('utils')
module = {}

local ALT = { "⌥" }
local PUSH_KEY = { "⌃", "⌘", "⌥" }
local SCREEN = {
    ["MAC"] = "Built-in Retina Display",
    -- Built-in Retina Display, note the % to escape the hyphen repetition character
    ["_MAC"] = "Built%-in Retina Display",
    ["K4"] = "DELL U2720Q",
    ["K4_WORK"] = "PHL 241B8Q", -- 公司的显示器
    ["K4_HOME"] = "PHL 245B9",  -- 家里的显示器
    ["K1"] = "DELL P2719HC",
    ["XL"] = "Sculptor",
    ["XXL"] = "VG2481-4K"
}

local is_home = false

function envChange()
    is_home = not is_home
    hs.alert.show(is_home and "Bye World!" or 'Hello World!')
    if is_home then
        SCREEN.K4 = SCREEN.K4_HOME
    else
        SCREEN.K4 = SCREEN.K4_WORK
    end
end

function isHome()
    return is_home
end

local LAYOUT = {
    ["left_5"] = { 0, 0, 0.5, 1 },
    ["left_top"] = { 0, 0, 0.5, 0.5 },
    ["left_bottom"] = { 0, 0.5, 0.5, 0.5 },
    ["right_5"] = { 0.5, 0, 0.5, 1 },
    ["right_top"] = { 0.5, 0, 0.5, 0.5 },
    ["right_bottom"] = { 0.5, 0.5, 0.5, 0.5 },
    ["left_4"] = { 0, 0, 0.4, 1 },
    ["right_6"] = { 0.4, 0, 0.6, 1 },
    ["top_5"] = { 0, 0, 1, 0.5 },
    ["bottom_5"] = { 0, 0.5, 1, 0.5 },
    ["bottom_3"] = { 0, 0.7, 1, 0.3 },
    ["bottom_middle"] = { 0.2, 0.4, 0.6, 0.6 },
    ["middle"] = { 0.15, 0.15, 0.7, 0.7 },
    ["full"] = { 0, 0, 1, 1 } -- Utils.getHsRect(LAYOUT.full)
}

-- 带下划线的给布局用，不带的给快捷键唤醒用，这里不一致，怪难受的
local APP = {
    ["Charles"] = "Charles",
    ["iTerm2"] = "iTerm2",
    ["iTerm"] = "iTerm",
    ["Lark"] = "Lark",
    ["Knock"] = "Knock",
    ["Whalek"] = "Whalek",
    ["_Lark"] = "飞书",
    ["WeChat"] = "WeChat",
    ["_WeChat"] = "微信",
    ["Chrome"] = "Google Chrome",
    ["VSCode"] = "Visual Studio Code",
    ["_VSCode"] = "Code",
    ["Finder"] = "Finder",
    ["ChromeCanary"] = "Google Chrome Canary",
    ["DIDA"] = "TickTick",
    ["_DIDA"] = "滴答清单",
    ["TXT"] = "TextEdit",
    ["_TXT"] = "文本编辑",
    ["Typora"] = "Typora",
    ["_Finder"] = "访达",
    ["Safari"] = "Safari",
    ["Settings"] = "System Settings.app", -- 系统设置
    ["WYY"] = "NeteaseMusic"              -- 网易云音乐
}

-- 配置应用快捷键
local APP_KEY = {
    [APP.Charles] = "c",
    [APP.iTerm] = "i",
    [APP.Finder] = "e",
    [APP.Lark] = "0",
    [APP.Knock] = "4",
    [APP.Whalek] = "1",
    [APP.VSCode] = "2",
    [APP.Chrome] = "3",
    [APP.DIDA] = "z",
    [APP.WeChat] = "w",
    [APP.Typora] = "t",
    [APP.Settings] = "s",
    [APP.Safari] = "f",
    [APP.WYY] = "y"
}

local APP_LAYOUT = {
    [APP.Charles] = { APP.Charles, nil, SCREEN["MAC"], Utils.getHsRect(LAYOUT["bottom_middle"]), nil, nil },
    [APP.Whalek] = { APP.Whalek, nil, SCREEN["MAC"], Utils.getHsRect(LAYOUT["left_5"]), nil, nil },
    [APP.iTerm2] = { APP.iTerm2, nil, SCREEN["MAC"], Utils.getHsRect(LAYOUT["right_5"]), nil, nil },
    [APP._VSCode] = {
        { APP._VSCode, nil, SCREEN["XL"], Utils.getHsRect(LAYOUT.full), nil, nil },
        -- { nil,         "Assets", SCREEN.K1,    Utils.getHsRect(LAYOUT.left_4), nil, nil }
    },
    [APP.Chrome] = {
        { APP.Chrome, 'DEV',  SCREEN['XXL'], Utils.getHsRect(LAYOUT["left_5"]),        nil, nil },
        { APP.Chrome, 'WORK', SCREEN['XXL'], Utils.getHsRect(LAYOUT["right_5"]),       nil, nil },
        { APP.Chrome, 'DAWN', SCREEN['XL'],  Utils.getHsRect(LAYOUT["bottom_middle"]), nil, nil },
    },
    -- [APP.ChromeCanary] = { APP.ChromeCanary, nil, SCREEN.K1, Utils.getHsRect(LAYOUT.right_6), nil, nil },
    -- [APP._WeChat] = { APP._WeChat, nil, SCREEN["MAC"], Utils.getHsRect(LAYOUT.right_bottom), nil, nil },
    -- [APP._Lark] = { APP._Lark, nil, SCREEN["MAC"], Utils.getHsRect(LAYOUT.full), nil, nil },
    -- [APP.Knock] = { APP.Knock, nil, SCREEN["MAC"], Utils.getHsRect(LAYOUT.full), nil, nil },
    -- [APP._DIDA] = { APP._DIDA, nil, SCREEN["MAC"], Utils.getHsRect(LAYOUT.full), nil, nil },
    -- [APP._TXT] = { APP._TXT, nil, SCREEN.K1, Utils.getHsRect(LAYOUT.left_4), nil, nil },
    -- [APP._Finder] = { APP._Finder, nil, SCREEN.K1, Utils.getHsRect(LAYOUT.left_4), nil, nil }
}

module.ALT = ALT
module.PUSH_KEY = PUSH_KEY
module.SCREEN = SCREEN
module.LAYOUT = LAYOUT
module.APP = APP
module.APP_KEY = APP_KEY
module.APP_LAYOUT = APP_LAYOUT
module.envChange = envChange
module.isHome = isHome

return module
