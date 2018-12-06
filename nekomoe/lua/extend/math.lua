
---四舍五入
function math.round(value)
    value = tonumber(value) or 0
    return math.floor(value + 0.5)
end