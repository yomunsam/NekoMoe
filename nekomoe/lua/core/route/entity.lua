---路由组 实体 Route Entity

local route = class()

---构造函数
function route:ctor()
    self.route_info = {}
    --[[
        格式：
        key/value
        key : path , 
        value :callback
    ]]
end

---添加路由
function route:add(path,callbcak)
    self.route_info[path] = callbcak
end

---获取针对路由的私有路径
local function Get_Route_Private_Path(url_path,route_path)
    --返回值1，私有路由
    --返回值2，url附带参数，如果没有则返回空table
    local restr = string.sub(url_path,string.len(route_path)+1,string.len(url_path))
    local redata = {}   --TODO
    if url_path == route_path then
        restr = "/"
    end
    if restr == "" or restr == nil then
        restr = "/"
    end
    return restr,redata
end

---触发路由
function route:call(route_root_path,url_path)
    --[[
        参数1：当前路由组的父级path,
        参数2：实际被路由的URl路径
    ]]
    --根据两个路径换算
    local cur_route_path,url_param = Get_Route_Private_Path(url_path,route_root_path)   --被本路由组路由的最终相对路径
    if self.route_info[cur_route_path] ~= nil then
        self.route_info[cur_route_path](url_param)
    else
        NekoMoe.Page.Jump404()
    end
end

return route