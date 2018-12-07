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
        page = table or nil
            path
            title
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


local cur_max_route_id = 0
---获取路由组对象
function NekoMoe.Route.GetRouteEntity()
    if route_entity_empty == nil then
        route_entity_empty = require("nekomoe.lua.core.route.entity")
    end
    cur_max_route_id = cur_max_route_id + 1
    return route_entity_empty.new(cur_max_route_id)
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

---注册页面路由
function NekoMoe.Route.Page(url_path,page_path,title)
    if route_pool[url_path] ~= nil then
        print("[Error]:重复注册路由: " .. url_path .. "   - 将覆盖之前注册内容")
    end
    route_pool[url_path] = {
        type = 0,
        page = {
            path = page_path,
            title = title
        }
    }
end


---处理路由
local function HandleRoute(path,info,route_path)    --url被路由的路径，路由消息,路由绑定路径
    --print("处理路由：" .. path .. " | " .. route_path)
    --dump(info)
    if info.type == 1 then 
        --命中了路由组
        info.entity:call(route_path,path)
    end
    if info.type == 0 then 
        --页面路由
        NekoMoe.Page.ShowPage(info.page.path,{enable=true},{title=info.page.title})
    end
end

---如果传入路径被路由命中，则范围true
local function GetRouteHit(url_path,route_path)
    --静态路由判定
    --print("判定Url：" .. url_path .. "  |是否命中路由：" .. route_path)
    if url_path == route_path then 
        return true
    end
    if string.startWith(url_path,route_path) then
        return true
    end

    return false
end

---判断路由优先级,如果path_1 优先级大于path_2则返回true
local function HandlePriority(path_1, path_2,url_path)
    --注意，根据下面的用法，我们是把被判断过的path放在path_2的，所以这里我们不再判断path_2是否命中路由
    if not GetRouteHit(url_path,path_1) then return false end --path_1没有命中路由
    -- print("判断路由优先级：" .. path_1 .. "  |  " .. path_2)
    if string.len(path_1) > string.len(path_2) and string.startWith(path_1,path_2) then
        --path_1也是命中的路由，并且是path_2的子级路由
        return true
    end

    return false
end

---路由跳转
function NekoMoe.Route.JumpTo(path)
    if m_enable == false then return end
    if cur_route_path == path then return end

    --遍历路由表
    local cur_route = nil   --当前命中的路由
    local cur_route_path = nil
    for i , v in pairs(route_pool) do
        
        if cur_route == nil then
            if GetRouteHit(path,i) == true then
                --print("命中路由：" .. i)
                cur_route = v
                cur_route_path = i
            end
        else
            if HandlePriority(i,cur_route_path,path) == true then
                cur_route = v
                cur_route_path = i
            end
        end
    end
    if cur_route ~= nil then
        HandleRoute(path,cur_route,cur_route_path)
    end

    cur_route_path = path
end


-------------------------------------------------------------------------------------


function NekoMoe.Route.OnHashChanged()
    --print("收到事件")
    local cur_path = NekoMoe.Route.GetCurHashPath()
    --print("跳转path:" .. cur_path)
    if m_enable and m_route_type == NekoConst.Route.Type.hash then
        NekoMoe.Route.JumpTo(cur_path)
    end
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