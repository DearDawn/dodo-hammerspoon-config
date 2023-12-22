tell application "System Events"
    tell process "ClashX Pro"
        -- 获取菜单栏图标的菜单
        set clashMenu to menu bar item 1 of menu bar 2
        -- 获取菜单项 "出站模式(.*)" 的子菜单
        set modeSubMenu to menu item 1 of menu 1 of clashMenu
        -- 获取菜单项 "设置为系统代理"
        set systemProxyMenuItem to menu item "设置为系统代理" of menu 1 of clashMenu
        -- 获取菜单项 "增强模式"
        set enhancedModeMenuItem to menu item "增强模式" of menu 1 of clashMenu
        -- 获取菜单项 "出站模式(.*) - 全局连接"
        set globalModeMenuItem to menu item "全局连接" of menu 1 of modeSubMenu
        -- 获取菜单项 "出站模式(.*) - 规则判断"
        set ruleModeMenuItem to menu item "规则判断" of menu 1 of modeSubMenu
        -- 检查 "设置为系统代理" 菜单项的勾选状态
        set isSystemProxyChecked to value of attribute "AXMenuItemMarkChar" of systemProxyMenuItem
        if isSystemProxyChecked is equal to "✓" then
            display notification "关闭 ClashX 系统全局增强代理" with title "ClashX Pro"
            -- 如果已勾选，则取消勾选 "设置为系统代理"、"增强模式" 和 "出站模式(.*) - 全局连接"
            click systemProxyMenuItem
            click enhancedModeMenuItem
            click globalModeMenuItem
            -- 勾选 "出站模式(.*) - 规则判断"
            click ruleModeMenuItem
        else
            display notification "开启 ClashX 系统全局增强代理" with title "ClashX Pro"
            -- 如果未勾选，则勾选 "设置为系统代理"、"增强模式" 和 "出站模式(.*) - 全局连接"
            click systemProxyMenuItem
            click enhancedModeMenuItem
            click globalModeMenuItem
            -- 取消勾选 "出站模式(.*) - 规则判断"
            click ruleModeMenuItem
        end if
    end tell
end tell