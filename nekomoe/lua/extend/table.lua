---Lua方法扩展 - table

---取table中不为nil的元素个数
function table.nums(t)
    local count = 0
    for k, v in pairs(t) do
        count = count + 1
    end

    return count
end

---判断table是否为空
function table.isEmpty(t)
    return _G.next(t) == nil
end

---判断table为nil或为空
function table.isNilOrEmpty(t)
    return t == nil or _G.next(t) == nil
end


