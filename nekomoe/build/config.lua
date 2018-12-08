--- nekomoe 猫萌前端框架 打包配置

NekoMoe = NekoMoe or {}
NekoMoe.Build = NekoMoe.Build or {}

NekoMoe.Build.Framework = {}

---框架内lua文件打包配置
NekoMoe.Build.Framework.LuaPack = {

    -- 框架：lua方法扩展
    "nekomoe.lua.extend.string",
    "nekomoe.lua.extend.logger",
    "nekomoe.lua.extend.table",
    "nekomoe.lua.extend.math",
    "nekomoe.lua.extend.other",
    "nekomoe.lua.extend.class",

    -- 框架：常量和配置定义
    "nekomoe.config.app",
    "nekomoe.lua.const.nekoconst",

    --工具程序集
    "nekomoe.lua.utils.dom",

    --核心程序集
    "nekomoe.lua.core.pagemgr.pagemgr",
    "nekomoe.lua.core.route.route",
    "nekomoe.lua.core.template.nekotpl",
    "nekomoe.lua.core.nekomoe",

    --other
    "nekomoe.lua.core.template.template",
    "nekomoe.lua.core.route.entity"
}

---输出位置
NekoMoe.Build.Framework.LuaOutput = "nekomoe.min.lua"