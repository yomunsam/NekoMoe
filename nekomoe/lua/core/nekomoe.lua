NekoMoe = NekoMoe or {}

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