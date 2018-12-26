---lua初始化
package.path = '../?.lua;'.. package.path ;



--扩展Lua方法
require("nekomoe.lua.extend.string")
require("nekomoe.lua.extend.logger")
require("nekomoe.lua.extend.table")
require("nekomoe.lua.extend.math")
require("nekomoe.lua.extend.other")
require("nekomoe.lua.extend.class")

--配置
require("nekomoe.config.app")
--全局常量
require("nekomoe.lua.const.nekoconst")

--工具程序集
require("nekomoe.lua.utils.dom")
require("nekomoe.lua.utils.storage")
require("nekomoe.lua.utils.cookie")

--核心程序集
require("nekomoe.lua.core.pagemgr.pagemgr")
require("nekomoe.lua.core.route.route")
require("nekomoe.lua.core.template.nekotpl")
require("nekomoe.lua.core.nekomoe")


--启动app
require(NekoConfig.App.start_path)