NekoMoe = NekoMoe or {}

local inited = false
local enable_route
local route_type

--- App初始化入口
function NekoMoe.Init(config)
    if inited then return end
    --配置初始化
    enable_route = config.enable_route
    route_type = config.route_type or NekoConst.Route.Type.hash
    if enable_route == nil then enable_route = true end

    --初始化页面管理器
    NekoMoe.Page.Init()
    --初始化路由管理器
    NekoMoe.Route.Init(enable_route,route_type)


    inited = true
end


NekoMoe.testRender = function ()
    --dump(package.loaded)
    local cur_html = js.global.document:getElementsByTagName('html')[0].innerHTML
    -- local cur_html = lua_pushjsfunction("document.getElementsByTagName('html')[0].innerHTML;")
    --print(cur_html)
    local template = require "nekomoe.lua.core.template.template"
    local data = {
        message = "hello , world"
    }
    local cur_render = template.render(cur_html,data)
    --print(cur_render)
    js.global.document:getElementsByTagName('html')[0].innerHTML = cur_render
end