Utils = Utils or {}
Utils.Storage = Utils.Storage or {}



function Utils.Storage.IsLocalExist(key)
    return js.global.localStorage:hasOwnProperty(tostring(key))
end

function Utils.Storage.ReadLocal(key)
    return js.global.localStorage:getItem(tostring(key))
end

function Utils.Storage.SetLocal(key,value)
    js.global.localStorage:setItem(tostring(key),tostring(value))
end