Utils = Utils or {}
Utils.Cookie = Utils.Cookie or {}

function Utils.Cookie.GetAll()
    return js.global.document.cookie
end