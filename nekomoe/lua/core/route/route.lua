---前端路由
NekoMoe = NekoMoe or {}
NekoMoe.Route = NekoMoe.Route or {}


local inited = false
local m_enable = false
local m_route_type
local route_entity_empty = nil  --一个空的路由组模板
local route_pool = {}   --所有路由注册，包括路由和路由组
--[[
    key/value
    [path] = {
        type = int , 0: 页面路由 1:路由组
        entity = entity or nil,
        page = string or nil
    }
]]
local cur_route_path = ""



---初始化   --是否启用,路由类型,立即跳转
function NekoMoe.Route.Init(enable,route_type)
    if inited then return end
    --print("路由初始化")
    m_enable = enable
    m_route_type = route_type
    --
    if m_enable and m_route_type == NekoConst.Route.Type.hash then
        --print("尝试注册事件")
        js.global.window:addEventListener('load',NekoMoe.Route.OnHashChanged,false)
        js.global.window:addEventListener('hashchange',NekoMoe.Route.OnHashChanged,false)

        --初始化的时候手动跳转一下
        NekoMoe.Route.JumpTo(NekoMoe.Route.GetCurHashPath())
    end


    inited = true
end



---获取路由组对象
function NekoMoe.Route.GetRouteEntity()
    if route_entity_empty == nil then
        route_entity_empty = require("nekomoe.lua.core.route.entity")
    end
    return route_entity_empty.new(1)
end

---注册使用路由组
function NekoMoe.Route.Use(root_path,entity)
    --检查重复注册
    if route_pool[root_path] ~= nil then
        print("[Error]:重复注册路由: " .. root_path .. "   - 将覆盖之前注册内容")
    end
    route_pool[root_path] = {
        type = 1,
        entity = entity
    }
    --dump(route_pool)
end

---处理路由
local function HandleRoute(path,info)
    --print("处理路由：" .. path)
    --dump(info)
    if info.type == 1 then 
        --命中了路由组
        info.entity:call(path)
    end
    if info.type == 0 then 
        --页面路由
    end
end

---路由跳转
function NekoMoe.Route.JumpTo(path)
    if m_enable == false then return end
    if cur_route_path == path then return end
    --检查路由有没有注册
    --路由优先级 ： 静态路由> 规则路由
    
    --遍历路由表
    for i , v in pairs(route_pool) do
        --命中静态路由
        if i == path then
            HandleRoute(path,v)
        end
    end



    cur_route_path = path
end


-------------------------------------------------------------------------------------


function NekoMoe.Route.OnHashChanged()
    print("收到事件")
    local cur_path = NekoMoe.Route.GetCurHashPath()
    --print("path:" .. path)
end

function NekoMoe.Route.GetCurHashPath()
    local path = js.global.location.hash
    if string.startWith(path,"#") then
        path = string.sub(path,2,string.len(path))
    end

    if string.startWith(path,"/") == false then
        path = "/" .. path
    end
    return path
end