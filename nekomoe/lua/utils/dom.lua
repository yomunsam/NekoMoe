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
    local scripts = document.body:querySelectorAll('script');
    local loaded_num = -1

    local function RunJavaScript(script,onload,onerror)
        if script.type == "" or string.lower(script.type) == "text/javascript" or string.lower(script.type) == "application/javascript" then
            local jsObj = document:createElement("script");
            if script.innerHTML ~= nil then              
                jsObj.innerHTML = script.innerHTML
            end
            if script.src ~= nil and script.src ~= "" then
                jsObj:setAttribute('src',script.src)
                -- print("src:" .. jsObj.src)
            end
            jsObj.onload = function() 
                if onload ~= nil then
                    onload()
                end
            end
            jsObj.onerror = function(err)
                if onerror ~= nil then
                    onerror()
                end
            end
            document.body:appendChild(jsObj)
            document.body:removeChild(jsObj);
        end
    end

    local function RunList()
        --获取下一个要执行的内容
        local run_index = loaded_num + 1
        if scripts.length >= run_index + 1 then
            RunJavaScript(scripts[run_index],function()
                --加载成功
                loaded_num = loaded_num + 1
                RunList()
            end,function()
                print("加载出错：" .. run_index)
            end)
        end
    end
    RunList()
end