-- app初始化

local config = require("app.config.startup") or {}

--设置路由（如果在config中关掉路由的话，这个设置不会启用）
local route = NekoMoe.Route.GetRouteEntity()

route:add("/", function()
    NekoMoe.Page.ShowPage("/app/view/index.html",{enable=true},{title="Hello,NekoMoe"})
end)

local route2 = NekoMoe.Route.GetRouteEntity()

route2:add("/", function()
    NekoMoe.Page.ChangeTo("命中了第二个路由组","body",{enable=true})
end)

NekoMoe.Route.Use("/",route)
NekoMoe.Route.Use("/b",route2)

--- 应该在完成所有操作之后调用Init
NekoMoe.Init(config)

