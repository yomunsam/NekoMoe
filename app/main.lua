-- app初始化

local config = require("app.config.startup") or {}

--设置路由（如果在config中关掉路由的话，这个设置不会启用）
local route = NekoMoe.Route.GetRouteEntity()

route:add("/", function()
    print("触发了路由：/")
    Utils.Dom.SetTitle("喵喵喵")
    NekoMoe.Page.LoadTo("/app/view/index.html","body",{enable = true})
end)

NekoMoe.Route.Use("/",route)


--- 应该在完成所有操作之后调用Init
NekoMoe.Init(config)

