--- DOM交互

Utils = Utils or {}
Utils.Dom = Utils.Dom or {}

local window = js.global
local document = window.document



---获取页面元素
function Utils.Dom.GetElementsByTagName(name)
    return document:getElementsByTagName(name)
end

---获取整个页面的HTML内容
function Utils.Dom.GetWholeHTML()
    return document:getElementsByTagName('html')[0].innerHTML
end

---把整个页面的HTML内容设置为指定内容
function Utils.Dom.SetWholeHTML(content)
    document:getElementsByTagName('html')[0].innerHTML = content
end

function Utils.Dom.GetTitle()
    return document.title
end

function Utils.Dom.SetTitle(title)
    document.title = title
end