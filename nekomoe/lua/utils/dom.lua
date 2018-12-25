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
    document:getElementsByTagName('html')[0].innerHTML = conten
    
end

function Utils.Dom.GetTitle()
    return document.title
end

function Utils.Dom.SetTitle(title)
    document.title = title
end


---在切换页面DOM内容后重新运行JS
function Utils.Dom.HandleJavaScripts()
    --处理页面中的JS
    local scripts = document:getElementsByTagName("body")[0]:getElementsByTagName('script')
    for i = 0 , scripts.length -1, 1 do
        if scripts[i].type == "" or string.lower(scripts[i].type) == "text/javascript" or string.lower(scripts[i].type) == "application/javascript" then
            if scripts[i].innerHTML ~= nil then
                local jsObj = document:createElement("script");
                jsObj.innerHTML = scripts[i].innerHTML
                document.body:appendChild(jsObj)
            end

            if scripts[i].src ~= nil and scripts[i].src ~= "" then
                local jsObj = document:createElement("script");
                jsObj.src = scripts[i].src
                jsObj.innerHTML = scripts[i].innerHTML
                -- print(jsObj.innerHTML)
                document.body:appendChild(jsObj)
            end
        end
        
    end
end