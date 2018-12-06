---页面管理器

NekoMoe = NekoMoe or {}
NekoMoe.Page = NekoMoe.Page or {}


---页面的初始内容
local page_original

---初始化页面管理器
function NekoMoe.Page.Init()
    page_original = Utils.Dom.GetWholeHTML()
    Utils.Dom.SetWholeHTML("") --先把整个页面置为空

end

---切整页
function NekoMoe.Page.ShowPage()
    --
end

---加载到某个页面元素中
function NekoMoe.Page.LoadTo(path,tag,tpl_render,index)  --目标路径，元素tag,模板引擎渲染设置table{enable=bool,是否渲染 ； data = table， 传入数据, 元素tag序列 默认为0}
    if index == nil then index = 0 end
    local xml_http = js.new(js.global.XMLHttpRequest)

    local handled = false
    xml_http.onreadystatechange = function()
        if handled then return end
        if xml_http.responseText == "" or xml_http.responseText == nil then return end
        --是否需要渲染页面
        local back_content = xml_http.responseText
        if tpl_render ~= nil then 
            if tpl_render.enable == true then
                back_content = NekoMoe.Tpl.render_str(back_content,tpl_render.data)
            end
        end
        js.global.document:getElementsByTagName(tag)[index].innerHTML = back_content
        handled = true
    end

    xml_http:open("GET",path,true)
	xml_http:send()
end

---将指定元素中的某个内容切换到
function NekoMoe.Page.ChangeTo(content,tag,tpl_render)  --目标路径，元素tag,模板引擎渲染设置table{enable=bool,是否渲染 ； data = table， 传入数据, 元素tag序列 默认为0}
    if index == nil then index = 0 end
    local xml_http = js.new(js.global.XMLHttpRequest)

    local handled = false
    xml_http.onreadystatechange = function()
        if handled then return end
        if xml_http.responseText == "" or xml_http.responseText == nil then return end
        --是否需要渲染页面
        local back_content = xml_http.responseText
        if tpl_render ~= nil then 
            if tpl_render.enable == true then
                back_content = NekoMoe.Tpl.render_str(back_content,tpl_render.data)
            end
        end
        js.global.document:getElementsByTagName(tag)[index].innerHTML = back_content
        handled = true
    end

    xml_http:open("GET",path,true)
	xml_http:send()
end