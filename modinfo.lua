---@diagnostic disable: lowercase-global
name = "MOD检测报告器"
version = "2025.11.05"
description = [[
检测你的MOD列表，告诉你哪些MOD是过时的/有BUG的，并为你推荐它的替代品。
最近更新：
现在检测到玩家订阅有BUG的五格装备栏时，将推荐订阅【四格装备栏】而不是【背包格子】
]]
author = "冰冰羊"

api_version = 10
priority = 10

dst_compatible = true

all_clients_require_mod = false
client_only_mod = true
server_only_mod = false

icon_atlas = "images/modicon.xml"
icon = "modicon.tex"