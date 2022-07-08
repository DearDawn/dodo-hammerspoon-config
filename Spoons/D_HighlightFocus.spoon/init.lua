local obj = {}
obj.__index = obj
obj.timeout = 0.2

-- Metadata
obj.name = "D_HighlightFocus"
obj.version = "0.1"
obj.author = "Dawn <tangjingchun@bytedance.com>"
obj.license = "MIT - https://opensource.org/licenses/MIT"

function obj:windowHighlight()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local c = require("hs.canvas")

    if (self.borderCanvas) then
        self.borderCanvas:delete()
    end

    self.borderCanvas = c.new {
        x = f.x,
        y = f.y,
        h = f.h,
        w = f.w
    }:appendElements({
        action = "build",
        padding = 3,
        type = "rectangle",
        radius = 10,
        reversePath = true
    }, {
        action = "fill",
        fillColor = {
            alpha = 1,
            red = 1
        },
        frame = f,
        type = "rectangle"
    }):show()

    hs.timer.doAfter(self.timeout, function()
        self.borderCanvas:delete()
        self.borderCanvas = nil
    end)
end

function obj:mouseHighlight()
    -- Get the current co-ordinates of the mouse pointer
    local mousepoint = hs.mouse.absolutePosition()
    -- Prepare a big red circle around the mouse pointer
    if (self.mouseCircle) then
        self.mouseCircle:delete()
    end

    self.mouseCircle = hs.drawing.circle(hs.geometry.rect(mousepoint.x - 40, mousepoint.y - 40, 80, 80))
    self.mouseCircle:setStrokeColor({
        ["red"] = 1,
        ["blue"] = 0,
        ["green"] = 0,
        ["alpha"] = 1
    })
    self.mouseCircle:setFill(false)
    self.mouseCircle:setStrokeWidth(5)
    self.mouseCircle:show()

    -- Set a timer to delete the circle after 3 seconds
    hs.timer.doAfter(self.timeout, function()
        self.mouseCircle:delete()
        self.mouseCircle = nil
    end)
end

function obj:watch(appName, eventType, appObject)
    if (eventType == hs.application.watcher.activated) then
        self:windowHighlight()
        self:mouseHighlight()
    end
end

return obj
