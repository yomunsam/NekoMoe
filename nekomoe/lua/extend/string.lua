---Lua方法扩展 - string

function string.split(inputstr, sep)
    if sep == nil then
            sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            t[i] = str
            i = i + 1
    end
    return t
end

---删除首尾空格
function string.trim(s) 
    --return (string.gsub(s, "^%s*(.-)%s*$", "%1")) 
    --return s:match "^%s*(.-)%s*$"
    if s == nil then return "" end
    return (string.gsub(s, "^%s*(.-)%s*$", "%1")) 
end