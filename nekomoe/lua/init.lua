---lua初始化
package.path = '../?.lua;'.. package.path ;



--扩展Lua方法
require("nekomoe.lua.extend.string")
require("nekomoe.lua.extend.logger")
require("nekomoe.lua.extend.table")
require("nekomoe.lua.extend.math")
require("nekomoe.lua.extend.other")

--核心程序集
require("nekomoe.lua.core.nekomoe")