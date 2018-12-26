---NekoMoe 模板引擎管理

NekoMoe = NekoMoe or {}
NekoMoe.Tpl = NekoMoe.Tpl or {}

local tpl = require("nekomoe.lua.core.template.template")

function NekoMoe.Tpl.render_str(str,data)
    return tpl.render(str,data)
end


function NekoMoe.Tpl.RenderMarkdown(source)
    local markdown = require("nekomoe.vendor.markdown")
    return markdown(source)
end