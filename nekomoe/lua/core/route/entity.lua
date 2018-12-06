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

---触发路由
function route:call(path)
    if self.route_info[path] ~= nil then
        self.route_info[path]()
    end
end

return route