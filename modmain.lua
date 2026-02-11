GLOBAL.setmetatable(env, {
    __index = function(t, k)
        return GLOBAL.rawget(GLOBAL, k)
    end
})

local debug_list = {}
local num = 1

local custom_list = {}
local custom_num = 1

-- 判断是否下载了对应模组

---@param name integer
local function IsmodDownLoad(name)
    return KnownModIndex:GetModInfo("workshop-"..name)
end

-- 判断是否有新的模组替代它
---@param NewMod string|nil
---@return table|nil
local function switch_NewMod(NewMod)
    if NewMod then
        return
            {
                text = "带我订阅此MOD的替代品",
                cb = function()
                    VisitURL(NewMod)
                end
            }
    end
end

---@param title string
---@param desc string
---@param text1 string
---@param cb1 function
---@param text2 string|nil
---@param cb2 function|nil
---@param text3 string|nil
---@param cb3 function|nil
local function show_custom_debug(title,desc,text1,cb1,text2,cb2,text3,cb3)
    local PopupDialogScreen = require("screens/redux/popupdialog")
    TheFrontEnd:PushScreen(
        PopupDialogScreen(
            title,
            desc,
            {
                {
                    text = text1,
                    cb = cb1,
                },
                text2 and
                {
                    text = text2,
                    cb = cb2,
                } or nil,
                text3 and
                {
                    text = text3,
                    cb = cb3,
                } or nil,
            }
        )
    )
end

-- 显示结果
---@param title string
---@param desc string
---@param URL string
---@param NewMod string|nil
local function show_debug(title,desc,URL,NewMod)
	local PopupDialogScreen = require("screens/redux/popupdialog")
    TheFrontEnd:PushScreen(
        PopupDialogScreen(
            title,
            desc,
            {
                {
                    text = "下一个！",
                    cb = function()
                        num = num + 1
                        TheFrontEnd:PopScreen()

                        if num <= #debug_list then
                            show_debug(debug_list[num][1],debug_list[num][2],debug_list[num][3],debug_list[num][4])
                        elseif #custom_list > 0 then
                            local title = custom_list[custom_num][1]
                            local desc = custom_list[custom_num][2]
                            local text1 = custom_list[custom_num][3]
                            local cb1 = custom_list[custom_num][4]
                            local text2 = custom_list[custom_num][5]
                            local cb2 = custom_list[custom_num][6]
                            local text3 = custom_list[custom_num][7]
                            local cb3 = custom_list[custom_num][8]
                            show_custom_debug(title,desc,text1,cb1,text2,cb2,text3,cb3)
                        end
                    end,
                },
                {
                    text = "带我去取消订阅",
                    cb = function()
                        VisitURL(URL)
                    end,
                },
                switch_NewMod(NewMod),
            }
        )
    )
end

-- 添加需要处理的模组
--- @param modid integer
--- @param title string
--- @param desc string
--- @param NewMod integer|string|nil
local function addlist_debug(modid, title, desc, NewMod) -- 标题，内容，旧模组创意工坊链接，新的模组替代品
    if IsmodDownLoad(modid) then
        table.insert(debug_list, {title, desc, "https://steamcommunity.com/sharedfiles/filedetails/?id="..modid, type(NewMod) == "number" and "https://steamcommunity.com/sharedfiles/filedetails/?id=" .. NewMod or NewMod})
    end
end

-- 检测部分（添加到 debug_list）

-- DST Storm Cellar
addlist_debug(382177939,"DST Storm Cellar","这是一个过时的Mod 含有诸多BUG\n建议您前往创意工坊取消订阅")

-- DST Freezer
addlist_debug(346962876,"DST Freezer","这是一个过时的Mod 含有诸多BUG\n建议您前往创意工坊取消订阅")

-- Map Revealer for DST
addlist_debug(363112314,"Map Revealer for DST","这是一个过时的Mod 含有诸多BUG\n建议您前往创意工坊取消订阅")

-- Finder
addlist_debug(780009141,"Finder","这是一个过时的Mod 无法正常使用\n建议您前往创意工坊取消订阅")

-- Health Info
addlist_debug(375859599,"Health Info","这是一个过时的Mod 含有诸多BUG\n建议您前往创意工坊取消订阅")

-- Global Pause
addlist_debug(758532836,"Global Pause","这是一个过时的Mod\n建议您前往创意工坊取消订阅")

-- Global Player Icons
addlist_debug(632082897,"Global Player Icons","这是一个过时的Mod，功能已经失效了\n建议您前往创意工坊取消订阅")

-- Extra Equip Slots
addlist_debug(375850593,"Extra Equip Slots","这是一个过时的Mod 且含有诸多BUG\n强烈建议您备份存档后尝试换个版本",3574405615)

-- Extra Equip Slots (Updated)
addlist_debug(1818688368,"Extra Equip Slots (Updated)","这是一个过时的Mod 且含有诸多BUG\n建议您备份存档后尝试换个版本",3574405615)

-- DST 四格装备栏
addlist_debug(1819567085,"DST 四格装备栏","这是一个过时的Mod 含有诸多BUG\n建议您备份存档后尝试换个版本",3574405615)

-- 五格装备栏（幽冥汉化版）
addlist_debug(2373346252,"五格装备栏（幽冥汉化版）","这是一个过时的Mod 含有诸多BUG\n建议您备份存档后尝试换个版本",3574405615)

--额外物品装备栏&UI优化
addlist_debug(1405120786,"额外物品装备栏&UI优化","这是一个过时的Mod 含有诸多BUG\n建议您备份存档后尝试换个版本",3574405615)

if not IsmodDownLoad(3481258227) then -- 45格修复(但不确定修复后还有没有其它BUG)
    -- 45 Inventory Slots 这是原版
    addlist_debug(786556008,"45 Inventory Slots","这是一个过时的Mod 含有诸多BUG！\n建议您前往创意工坊取消订阅\n(我推荐不订阅45格，BUG总是有的，还不如给自己指令刷一个坎普斯背包)")
end

-- 45 Inventory Slots
addlist_debug(2965758547,"45 Inventory Slots","这是一个过时的Mod 含有诸多BUG！\n建议您前往创意工坊取消订阅\n(我推荐不订阅45格，BUG总是有的，还不如给自己指令刷一个坎普斯背包)")

-- 45 Inventory Slots and the fixed fishing rod slots.
addlist_debug(2568821043,"45 Inventory Slots and the fixed fishing rod slots.","这是一个过时的Mod 含有诸多BUG！\n建议您前往创意工坊取消订阅\n(我推荐不订阅45格，BUG总是有的，还不如给自己指令刷一个坎普斯背包)")

-- 45 Inventory Slots [EquipSlot UI expand]
addlist_debug(2906717350,"45 Inventory Slots [EquipSlot UI expand]","这是一个过时的Mod 含有诸多BUG！\n建议您前往创意工坊取消订阅\n(我推荐不订阅45格，BUG总是有的，还不如给自己指令刷一个坎普斯背包)")


-- [Discontinued] VK Extra Equipment and Inventory
addlist_debug(943020433,"[Discontinued] VK Extra Equipment and Inventory","这是一个过时的Mod 含有诸多BUG！\n建议您前往创意工坊取消订阅")


-- [OUTDATED] Complete Your Map
addlist_debug(459280938,"[OUTDATED] Complete Your Map","这是一个过时的Mod，打开它会让你的游戏立刻闪退。请取消订阅")


-- Complete Your Map[FIX]
addlist_debug(2003064672,"Complete Your Map[FIX]","这是一个过时的Mod 含有诸多BUG\n建议您前往创意工坊取消订阅")


-- Display Food Values
addlist_debug(347079953,"Display Food Values","这是一个过时的Mod 含有诸多BUG\n建议您前往创意工坊取消订阅，并使用Show Me(中文)或Insight替代它")


-- [T] Map Plugins(DST)
addlist_debug(668708075,"Map Plugins(DST)","这是一个过时的Mod 含有诸多BUG\n建议您前往创意工坊取消订阅",2923713671)

-- Extended Map Icons
addlist_debug(1157975551,"Extended Map Icons","这是一个过时的Mod 含有诸多BUG\n建议您前往创意工坊取消订阅",2923713671)

-- Wall Map Icons
addlist_debug(449537190,"Wall Map Icons","这是一个过时的Mod 含有诸多BUG\n建议您前往创意工坊取消订阅",2923713671)


-- DST Where's My Beefalo?
addlist_debug(347360448,"DST Where's My Beefalo?","这是一个过时的Mod 含有诸多BUG\n建议您前往创意工坊取消订阅",2923713671)

-- Where's My Beefalo?
addlist_debug(2565578363,"Where's My Beefalo?","这是一个过时的Mod 含有诸多BUG\n建议您前往创意工坊取消订阅",2923713671)


-- Wormhole icons
addlist_debug(821143467,"Wormhole icons","这是一个过时的Mod 且含有BUG 建议您前往创意工坊取消订阅并换成下方推荐的模组\n并搭配Chinese++ Pro来获取中文翻译",2831613121)


-- Wormhole Icons [Fixed]
addlist_debug(1295277999,"Wormhole Icons [Fixed]","这是一个过时的Mod 且含有BUG 建议您前往创意工坊取消订阅并换成下方推荐的模组\n并搭配Chinese++ Pro来获取中文翻译",2831613121)


-- Wormhole Marks [DST]
addlist_debug(362175979,"Wormhole Marks [DST]","这是一个过时的Mod 且含有BUG 建议您前往创意工坊取消订阅并换成下方推荐的模组\n并搭配Chinese++ Pro来修正中文翻译",2621090176)


-- Smarter Crock Pot
addlist_debug(365119238,"Smarter Crock Pot","这是一个过时的Mod 含有诸多BUG\n建议您前往创意工坊取消订阅并换成最新版",727774324)

-- craft pot
if not IsmodDownLoad(727774324) then
    -- craft pot(服务器版)
    addlist_debug(3448934423,"craft pot","你订阅了非官方版的craft pot 容易发生兼容性问题\n建议您前往创意工坊取消订阅并换成官方版本",727774324)
    addlist_debug(3445445695,"craft pot","你订阅了非官方版的craft pot 容易发生兼容性问题\n并搭配Chinese++ Pro来获取中文翻译",727774324)
end

-- Egg Pain Together(蛋疼排队论)
addlist_debug(949822556,"Egg Pain Together(蛋疼排队论)","这是一个过时的Mod 含有诸多BUG\n建议您前往创意工坊取消订阅并换成最新版",2873533916)

-- Action Queue(DST)
addlist_debug(609051112,"Action Queue(DST)","这是一个过时的Mod 含有诸多BUG\n建议您前往创意工坊取消订阅并换成最新版",2873533916)

-- ActionQueue Reborn
addlist_debug(1608191708,"ActionQueue Reborn","这是一个较老的Mod，功能较少\n我建议您前往创意工坊取消订阅并换成最新版",2873533916)

-- 黑化列队行为学
addlist_debug(2898654623,"黑化列队行为学","这是一个较老的Mod，功能较少\n我建议您前往创意工坊取消订阅并换成最新版",2873533916)

-- ActionQueue RB2 (RWYS supported)
addlist_debug(2325441848,"ActionQueue RB2 (RWYS supported)","这是一个较老的Mod，功能较少还是英文！\n我建议您前往创意工坊取消订阅并换成最新的行为学Mod",2873533916)

-- ActionQueue RB3 汉化版
addlist_debug(3018652965,"ActionQueue RB3 汉化版","原行为学RB3已支持中文语言\n我建议你换成原版行为学RB3 它的版本更新",2873533916)

-- 动作队列·重启·叁模组汉化丨ActionQueue RB3 CN
addlist_debug(3415621265,"动作队列·重启·叁","原行为学RB3已支持中文语言，且翻译质量更好\n我建议你换成原版行为学RB3 它的版本更新",2873533916)


-- 改变堆叠大小 MAX9999
addlist_debug(1571581787,"改变堆叠大小 MAX9999","这个模组已经停止更新维护，现在开启这个模组将使你的服务器崩溃",2774093373)

-- 999堆叠
addlist_debug(831523966,"999堆叠","这个模组已经停止更新维护，现在开启这个模组将使你的服务器崩溃",2774093373)


-- Display Attack Range
addlist_debug(2078243581,"Display Attack Range","这是一个有BUG的Mod 碰到某些生物会导致服务器崩溃\n建议您前往创意工坊取消订阅")


-- Item Info 这是原版
addlist_debug(836583293,"Item Info","这是一个过时的Mod 在特定情况会导致游戏崩溃\n建议您前往创意工坊取消订阅并换成最新版",3118627881)

-- Item Info
addlist_debug(1901927445,"Item Info","这是一个过时的Mod 在特定情况会导致游戏崩溃\n建议您前往创意工坊取消订阅并换成最新版",3118627881)

-- item info 物品信息 - Shang 汉化版
addlist_debug(2049203096,"item info 物品信息 - Shang 汉化版","这是一个过时的Mod 在特定情况会导致游戏崩溃\n建议您前往创意工坊取消订阅并换成最新版",3118627881)

-- Item Info Improved
addlist_debug(2972499450,"Item Info Improved","这是一个过时的Mod 在特定情况会导致游戏崩溃\n建议您前往创意工坊取消订阅并换成最新版",3118627881)

-- 小地图HUD模组汉化丨Minimap HUD CN
addlist_debug(3415567277,"小地图HUD","这不是官方原版的小地图Mod，建议您前往创意工坊切换为官方版本\n并搭配Chinese++ Pro来获取最完整的中文汉化\nTips:官方版本与其它Mod的兼容性更好",345692228)


-- 组合状态[最新/中文]-Combined Status
addlist_debug(2438350724,"组合状态[最新/中文]-Combined Status","这不是官方原版的组合状态，兼容性较差。墙裂建议您前往创意工坊切换为官方版本\n并搭配Chinese++ Pro来获取最完整的中文汉化\nTips:官方版本与其它Mod的兼容性更好",376333686)

-- Combined Status (Modified) server version
addlist_debug(1896968971,"Combined Status (Modified) server version","你订阅了非官方版的综合状态显示！且是老旧版本！\n请您务必前往创意工坊订阅官方版本！\n并搭配Chinese++ Pro来获取最完整的中文汉化",376333686)

-- Combined Status online(季节时钟转联机)
addlist_debug(3092317730,"Combined Status online(季节时钟转联机)","你订阅了非官方版的综合状态显示！且是老旧版本！\n请您务必前往创意工坊订阅官方版本！\n并搭配Chinese++ Pro来获取最完整的中文汉化",376333686)

-- 综合状态 服务端 Combined Status Server
addlist_debug(2995319954,"综合状态 服务端 Combined Status Server","你订阅了非官方版的综合状态显示！且是老旧版本！\n请您务必前往创意工坊订阅官方版本！\n并搭配Chinese++ Pro来获取最完整的中文汉化",376333686)

-- Combined Status (Server-Sided)
addlist_debug(2885354999,"Combined Status (Server-Sided)","你订阅了非官方版的综合状态显示！且是老旧版本！\n请您务必前往创意工坊订阅官方版本！\n并搭配Chinese++ Pro来获取最完整的中文汉化",376333686)

-- Force Download: Combined Status
addlist_debug(816057392,"Force Download: Combined Status","你订阅了非官方版的综合状态显示！且是老旧版本！\n请您务必前往创意工坊订阅官方版本！\n并搭配Chinese++ Pro来获取最完整的中文汉化",376333686)

-- Combined Status(盗版)
addlist_debug(632083515,"Combined Status","你订阅了非官方版的综合状态显示！且是老旧版本！\n请您务必前往创意工坊订阅官方版本！\n并搭配Chinese++ Pro来获取最完整的中文汉化",376333686)

-- 几何建筑汉化版—服务器端
addlist_debug(3134766537,"几何建筑汉化版—服务器端","你订阅了非官方版的几何布局！可能会导致兼容性问题发生\n建议取消订阅，切换为官方版\n并搭配Chinese++ Pro来获取最完整的中文汉化",351325790)

-- 几何布局 服务端版
addlist_debug(2901979304,"几何布局 服务端版","你订阅了非官方版的几何布局！可能会导致兼容性问题发生\n建议取消订阅，切换为官方版\n并搭配Chinese++ Pro来获取最完整的中文汉化",351325790)

-- Geometric Placement(盗版)
addlist_debug(591987989,"Geometric Placement","你订阅了非官方版的几何布局！可能会导致兼容性问题发生\n建议取消订阅，切换为官方版\n并搭配Chinese++ Pro来获取最完整的中文汉化",351325790)

-- Geometric Placement(盗版)
addlist_debug(1922842343,"Geometric Placement","你订阅了非官方版的几何布局！可能会导致兼容性问题发生\n建议取消订阅，切换为官方版\n并搭配Chinese++ Pro来获取最完整的中文汉化",351325790)

-- Geometric Placement(盗版)
addlist_debug(3269046346,"Geometric Placement","你订阅了非官方版的几何布局！可能会导致兼容性问题发生\n建议取消订阅，切换为官方版\n并搭配Chinese++ Pro来获取最完整的中文汉化",351325790)

-- 建筑几何学中文汉化Geometric Placement
addlist_debug(3343140219,"建筑几何学中文汉化","你订阅了非官方版的几何布局！可能会导致兼容性问题发生\n建议取消订阅，切换为官方版\n并搭配Chinese++ Pro来获取最完整的中文汉化",351325790)

-- 😶‍🌫️几何布局 服务端
addlist_debug(2995757113,"几何布局 服务端","你订阅了非官方版的几何布局！可能会导致兼容性问题发生\n建议取消订阅，切换为官方版\n并搭配Chinese++ Pro来获取最完整的中文汉化",351325790)

-- 几何布局 - 汉化版
addlist_debug(3034588489,"几何布局 - 汉化版","你订阅了非官方版的几何布局！可能会导致兼容性问题发生\n建议取消订阅，切换为官方版\n并搭配Chinese++ Pro来获取最完整的中文汉化",351325790)

-- 几何布局服务器版
addlist_debug(3467304228,"几何布局服务器版","你订阅了非官方版的几何布局！可能会导致兼容性问题发生\n建议取消订阅，切换为官方版\n并搭配Chinese++ Pro来获取最完整的中文汉化",351325790)

-- [DST]Too Many Items
addlist_debug(551338671,"[DST]Too Many Items","这是一个过时的Mod 含有诸多问题\n建议您前往创意工坊取消订阅并换成最新版",3638290455)

-- Too Many Items Fix (really old, don't use)
addlist_debug(881455419,"Too Many Items Fix (really old, don't use)","这是一个过时的Mod 含有诸多问题 连作者都叫你别用！\n请您前往创意工坊取消订阅并换成最新版",3638290455)

-- [TMIP]Too Many Items Plus
addlist_debug(1365141672,"[TMIP]Too Many Items Plus","这是一个过时的Mod\n建议您前往创意工坊取消订阅并换成最新版",3638290455)

-- T键物品增加
addlist_debug(2763963752,"T键物品增加","这是Too Many Items Plus模组的补充包\n建议您前往创意工坊取消订阅此模组还有T键Plus并换成最新版T键",3638290455)

-- Too Many Items Revisited
addlist_debug(2896126381,"Too Many Items Revisited","这个模组目前已停止更新，建议换成更新的\nToo Many Items Rearranged",3638290455)

if IsmodDownLoad(1467214795) then
    -- 暖石无限耐久与岛屿冒险同时订阅
    addlist_debug(2634976992,"暖石无限耐久","你同时订阅了暖石无限耐久与岛屿冒险，这两个模组是不兼容的\n建议您前往创意工坊取消订阅并换成兼容的版本",466732225)

    -- 小房子和岛屿冒险同时订阅
    addlist_debug(1951468597,"小房子","你同时订阅了小房子与岛屿冒险，这两个模组是不兼容的\n注意不要同时开启！！！！！！")

    -- 独行长路和岛屿冒险同时订阅
    addlist_debug(2657513551,"独行长路","你同时订阅了独行长路与岛屿冒险，这两个模组是不兼容的\n注意不要同时开启！！！！！！")
end

-- 岛屿冒险 - 主线拓展
addlist_debug(3285340146,"岛屿冒险 - 主线拓展","该模组在岛屿冒险 - 海难1.0.0版本更新后不再完全兼容海难\n到游戏后期会崩溃，建议取消订阅")

-- 岛屿冒险 - 额外岛屿
addlist_debug(1780226102,"岛屿冒险 - 额外岛屿","该模组在岛屿冒险 - 海难1.0.0版本更新后不再兼容海难\n请取消订阅")

-- 岛屿冒险 - 额外岛屿2
addlist_debug(3070509424,"岛屿冒险 - 额外岛屿2","该模组在岛屿冒险 - 海难1.0.0版本更新后不再兼容海难\n请取消订阅")

-- 岛屿冒险 - 额外岛屿3
addlist_debug(3195311977,"岛屿冒险 - 额外岛屿2","该模组在岛屿冒险 - 海难1.0.0版本更新后不再兼容海难\n请取消订阅")

-- 岛屿冒险：豪华补充包
addlist_debug(2795087108,"岛屿冒险：豪华补充包","该模组在2023年7月底后就停止维护了\n不再兼容岛屿冒险 - 海难\n请取消订阅！！！")


-- MaxView(大视野)
addlist_debug(804413673,"MaxView(大视野)","这是一个过时的Mod\n建议您前往创意工坊取消订阅并换成OB视角模组",1579421388)


-- Status Announcements 这是原版，太老了
addlist_debug(343753877,"Status Announcements","这是一个过时的Mod\n建议您前往创意工坊取消订阅并换成更新的版本",2785634357)

-- 快捷宣告新·中文（原作授权） 我的评价是不够新！
addlist_debug(2773348050,"快捷宣告新·中文（原作授权）","这是一个过时的Mod\n建议您前往创意工坊取消订阅并换成更新的版本",2785634357)

-- 显示昵称 [服务端]
addlist_debug(3395794288,"显示昵称 [服务端]","开启这个模组后当玩家因诅咒变为猴子时，游戏会崩溃。\n建议你订阅新版本",2917322514)

-- Show Nicknames 显示昵称（客户端）
addlist_debug(956206484,"Show Nicknames 显示昵称（客户端）","开启这个模组后当玩家因诅咒变为猴子时，游戏会崩溃。\n建议你订阅新版本",2917322514)

-- [Tips]提示猎狗和BOSS的攻击时间
addlist_debug(1898292532,"[Tips]提示猎狗和BOSS的攻击时间","这是一个有问题的Mod！该Mod会每秒遍历全局实体占用服务器大量性能！\n建议您前往创意工坊取消订阅！！！", 3561785531)

-- [Tips]提示系统(优化不卡顿版)
addlist_debug(1898292532,"[Tips]提示系统(优化不卡顿版)","建议取消订阅，替换为全局事件计时器Mod", 3561785531)

-- [Tips]刷新提示，优化版
addlist_debug(3059131690,"[Tips]刷新提示，优化版","建议取消订阅，替换为全局事件计时器Mod", 3561785531)

-- Boss生成倒计时
addlist_debug(3127230863,"Boss生成倒计时","评论区说该模组很吃性能，建议取消订阅，并替换为全局事件计时器Mod", 3561785531)

-- Boss预测器
addlist_debug(2510473186,"Boss预测器","我个人推荐换成更好的计时器模组：全局事件计时器", 3561785531)

if IsmodDownLoad(1467214795) or IsmodDownLoad(3322803908) then
    -- 饥饥事件计时器和岛屿冒险/云霄国度同时订阅
    addlist_debug(3511498282,"饥饥事件计时器","你同时订阅了饥饥事件计时器Mod与岛屿冒险或云霄国度Mod\n建议你换成兼容岛屿冒险/云霄国度的计时器模组", 3561785531)
    addlist_debug(3517520518,"饥饥事件计时器加强","你同时订阅了饥饥事件计时器加强Mod与岛屿冒险或云霄国度Mod\n建议你直接换成兼容岛屿冒险/云霄国度的计时器模组", 3561785531)
end

-- 自动寻路 | Never Get Lost
addlist_debug(2119128165,"自动寻路 | Never Get Lost","这是一个有BUG的Mod\n建议您前往创意工坊取消订阅并换成更新的版本",2849308125)


-- 无视服务器Mod过期
addlist_debug(2805318787,"无视服务器Mod过期","此模组会使客户端无视服务器Mod下载状态并强行加入服务器\n这容易导致严重的BUG发生！强烈建议您取消订阅并查看正确的解决方法","https://www.bilibili.com/opus/954763232708395009")

-- 无视服务器Mod过期 by.萌萌的新
addlist_debug(3025319554,"无视服务器Mod过期","此模组会使客户端无视服务器Mod下载状态并强行加入服务器\n这容易导致严重的BUG发生！强烈建议您取消订阅并查看正确的解决方法","https://www.bilibili.com/opus/954763232708395009")

-- 主从不同步修复
addlist_debug(3423266707, "主客不同步修复", "此模组仅仅只是屏蔽了错误，并不能修复不同步问题，换句话说就是错上加错\n建议您取消订阅并自行检查到底是什么mod导致不同步的")

-- Automatic chest sorting
addlist_debug(2321974509,"Automatic chest sorting","这是一个有BUG的Mod\n建议您前往创意工坊取消订阅并换成更新的版本",3223103565)

-- 😶‍🌫️自动整理物品 Automatic chest sorting
addlist_debug(2996027471,"自动整理物品 Automatic chest sorting","这是一个有BUG的Mod\n建议您前往创意工坊取消订阅并换成更新的版本",3223103565)


-- 😶‍🌫️骑牛状态显示 Beefalo Status Bar
addlist_debug(2995399263,"骑牛状态显示 Beefalo Status Bar","这不是官方版的Beefalo Status Bar 兼容性较差（不兼容驯养考拉象Mod）！建议您前往创意工坊切换为官方版本\n并搭配Chinese++ Pro来获取完整的中文汉化",2477889104)


-- 快速丢弃-客户端版本
addlist_debug(873350047,"快速丢弃-客户端版本","此Mod的功能已经被官方收录到原版游戏中了！\n你不需要开启此Mod即可享受它的功能！")

-- 错误追踪
addlist_debug(2427481232,"错误追踪（炸了）","此Mod已停止维护，现在它没有任何作用。",3377689002)

if not IsmodDownLoad(2796122895) then
    -- Show Oceanfish（服务器版）
    addlist_debug(3449296058,"Show Oceanfish","这不是官方版的显示鱼群+自动海钓 Mod\n建议您前往创意工坊切换为官方版本",2796122895)
end

-- Snapping tills server
addlist_debug(3256273776,"Snapping tills server","这不是官方版的Snapping tills 可能会导致兼容性问题发生\n建议您取消订阅\n并搭配Chinese++ Pro来获取完整的中文汉化",2302837868)

-- 耕地对齐服务器版
addlist_debug(3467755622,"耕地对齐服务器版","这不是官方版的Snapping tills 可能会导致兼容性问题发生\n建议您取消订阅\n并搭配Chinese++ Pro来获取完整的中文汉化",2302837868)

-- Auto Walking Server
addlist_debug(3261041569,"Auto Walking Server","这不是官方版自动寻路PLUS\n建议您取消订阅",2849308125)

-- Status Announcements (NoMu) server
addlist_debug(3169298715,"Status Announcements (NoMu) server","这不是官方版快捷宣告(NoMu)\n建议您取消订阅",2784715091)

-- Deluxe Cooking Pot
addlist_debug(907007729,"Deluxe Cooking Pot","这个模组已经停止更新维护，现在开启这个模组将使你的服务器崩溃",3064846414)

-- Keeth客户端
addlist_debug(2111490085,"Keeth客户端","这个模组已经停止更新维护，现在开启这个模组容易使你的游戏崩溃")

---@param check_fn function
---@param title string
---@param desc string
---@param text1 string
---@param cb1 function
---@param text2 string|nil
---@param cb2 function|nil
---@param text3 string|nil
---@param cb3 function|nil
local function addlist_custom_debug(check_fn, title, desc, text1, cb1, text2, cb2, text3, cb3) -- 标题，内容，旧模组创意工坊链接，新的模组替代品
    if check_fn() then
        table.insert(custom_list, {title, desc, text1, cb1, text2, cb2, text3, cb3})
    end
end

-- 暂时用不到的函数
-- local function next_custom_debug()
--     return
--     function()
--         TheFrontEnd:PopScreen()
--         custom_num = custom_num + 1
--         if custom_num <= #custom_list then
--             show_custom_debug(custom_list[custom_num][1],custom_list[custom_num][2],custom_list[custom_num][3],custom_list[custom_num][4])
--         end
--     end
-- end

-- 略微影响服务器性能 且 可能自身出问题/吞日志（日志就一句 简简单单的 error in error handle） 故取消推荐
-- addlist_custom_debug(
--     function()
--         return not IsmodDownLoad(3377689002)
--     end,
--     "你没有订阅【自动崩溃恢复 & 错误追踪分析】模组","这个模组能实时分析检测导致游戏崩溃的模组！建议订阅\n(这叫什么？这叫打组合拳󰀃)",
--     "去创意工坊订阅",
--     function()
--         VisitURL("https://steamcommunity.com/sharedfiles/filedetails/?id=3377689002")
--     end,
--     "下一个！",
--     next_custom_debug()
-- )

addlist_custom_debug(
    function()
        return not IsmodDownLoad(2941527805)
    end,
    #debug_list > 0 and "最后一步" or "MOD检测报告器",
    #debug_list > 0 and "订阅Chinese++ Pro来获取各大官方MOD的翻译！" or "恭喜！我暂时没有检测到你订阅了有问题的MOD！\n你现在可以关闭此模组了。但你还没有订阅Chinese++Pro\n你可以订阅Chinese++ Pro来获取各大官方MOD的翻译！",
    "帮我订阅并关闭【Mod检测报告器】",
    function()
        TheSim:SubscribeToMod("workshop-2941527805")
        KnownModIndex:Disable(modname)
        KnownModIndex:Save()
        TheFrontEnd:PopScreen()
    end
)


AddClassPostConstruct("screens/redux/multiplayermainscreen", function(self) -- 如果在主页面
    self.inst:DoTaskInTime(2, function() -- 等2秒 急了会崩溃0.0
        -- 处理结果并依次展示
        if #debug_list > 0 then
            -- 处理信息
            local title = debug_list[num][1]
            local desc = debug_list[num][2]
            local URL = debug_list[num][3]
            local NewMod = debug_list[num][4]

            show_debug(title,desc,URL,NewMod)
        elseif #custom_list > 0 then
            local title = custom_list[custom_num][1]
            local desc = custom_list[custom_num][2]
            local text1 = custom_list[custom_num][3]
            local cb1 = custom_list[custom_num][4]
            local text2 = custom_list[custom_num][5]
            local cb2 = custom_list[custom_num][6]
            local text3 = custom_list[custom_num][7]
            local cb3 = custom_list[custom_num][8]
            show_custom_debug(title,desc,text1,cb1,text2,cb2,text3,cb3)
        else
            local PopupDialogScreen = require("screens/redux/popupdialog")
            TheFrontEnd:PushScreen(
                PopupDialogScreen(
                    "MOD检测报告器",
                    "恭喜！我没有检测到你订阅了有问题的MOD！\n你现在可以关闭此模组了\n等此模组有更新时，再尝试开启检测\n(如果还有其它有问题的模组但未被检测出来，欢迎前往创意工坊反馈)",
                    {
                        {
                            text = "关闭此模组",
                            cb = function()
                                KnownModIndex:Disable(modname) -- 没问题就关闭模组
                                KnownModIndex:Save()
                                TheFrontEnd:PopScreen()
                            end,
                        },
                    }
                )
            )
        end
    end)
end)