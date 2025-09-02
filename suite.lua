local queueteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
local TeleportCheck = false

local exec = identifyexecutor()
local http = game:GetService('HttpService')

local function getrequest()
    return (syn and syn.request) or http_request or request or (http and http.request)
end

local player = game.Players
local lp = player.LocalPlayer
local char = lp.Character or lp.CharacterAdded:Wait()
local hum = char:WaitForChild('HumanoidRootPart')
local plrname = lp.Name
local display_name = lp.DisplayName

local userid = lp.UserId
local uis = game:GetService('UserInputService')
local PlaceId = tostring(game.PlaceId)
local ids = {'107495947845865', '79546208627805', '126509999114328'}
--[[

    99 Nights in the Forest - 79546208627805 / 126509999114328 [Lobby, Game]
    Testing Place - 4483381587

--]]
local Library = loadstring(game:HttpGet('https://pastebin.com/raw/gemp0EAX'))()
local SaveManager = loadstring(game:HttpGet('https://pastebin.com/raw/n61n8pcS'))()
local InterfaceManager = loadstring(game:HttpGet('https://pastebin.com/raw/z61cjJet'))()
local Options = Library.Options
local game_name
local CREATOR = 'by Berlin'
local match_found = false

lp.Chatted:Connect(function(msg)
    if msg:lower() == '/t inf' then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
    end
end)

for _, Id in ipairs(ids) do
    if PlaceId == Id then
        match_found = true
        if Id == '107495947845865' and (userid == 1608459557 or userid == 7056536081) then
            game_name = 'A good gaming chair'
        elseif Id == '79546208627805' or Id == '126509999114328' then
            game_name = 'The good gaming chair'
        end
        break
    end
end

if not match_found then
    Library:Notify({
        Title = 'Notification',
        Content = 'This game is not available as of now.',
        Duration = 8
    })
    return
    
end

-- Interface
local function createui(game)
    local Window = Library:CreateWindow({
        Title = game_name,
        SubTitle = CREATOR,
        TabWidth = 160,
        Size = UDim2.fromOffset(760, 450),
        Acrylic = true,
        Theme = "Darker",
        MinimizeKey = Enum.KeyCode.End
    })
    do
        if game == '99nightsintheforest' then
            -- Tabs
            local Tabs = {
                About = Window:AddTab({ Title = "About", Icon = "info" }),
                Main = Window:AddTab({ Title = "Main", Icon = "crown" }),
                Teleport = Window:AddTab({ Title = "Teleport", Icon = "map-pin" }),
                Webhook = Window:AddTab({ Title = "Webhook", Icon = "link" }),
                Settings = Window:AddTab({ Title = "Settings", Icon = "settings" }),
            }

            -- Sections
            local Information = Tabs.About:AddSection("Script Information")
            local Script = Tabs.Settings:AddSection("Script")
            local Performance = Tabs.Settings:AddSection("Performance")
            local Integration = Tabs.Webhook:AddSection("Integration")

            -- About
            Information:AddParagraph({
                Title = "Version 1.0",
            })
            Information:AddParagraph({
                Title = "Anti-AFK",
                Content = "Automatically enabled to prevent idle kick."
            })
            Information:AddButton({
                Title = "Bug Report",
                Description = "Click to copy the discord invite link.",
                Callback = function()
                    setclipboard('discord.gg/NV2j3PWU9n')
                    Library:Notify({
                        Title = "Notification",
                        Content = "Invite link has been copied to the clipboard.",
                        Duration = 5
                    })
                end
            })

            -- Webhook
            local link = Integration:AddInput("whlink", {
                Title = "Webhook URL",
                Description = "Put your webhook link here.",
                Numeric = false,
                Finished = false,
                Callback = function(Value)
                end
            })

            local webcooldown = Integration:AddSlider("whcd", {
                Title = "Send Interval (minutes)",
                Default = 30,
                Min = 1,
                Max = 60,
                Rounding = 1,
                Callback = function(Value)
                end
            })

            local webtoggle = Integration:AddToggle("whtoggle", {
                Title = "Enable Webhook", 
                Default = false,
                Callback = function(state)
                end 
            })

            Integration:AddButton({
                Title = "Test Webhook",
                Callback = function()
                    local data = {
                        content = "",
                        embeds = {{
                            title = "Test Subject",
                            author = {
                                plrname = "Account: " .. display_name .. " "
                            },
                            description = "Rewards gained from the last dungeon run:",
                            fields = {
                                {
                                    plrname = "Ticket Gained",
                                    value = "```69```",
                                    inline = true
                                },
                                {
                                    plrname = "Common Gained",
                                    value = "```420```",
                                    inline = true
                                }
                            },
                            color = 65280,
                            timestamp = DateTime.now():ToIsoDate(),
                            footer = {
                                text = "Berlin"
                            }
                        }},
                        components = {{
                        type = 1,
                        components = {{
                            type = 2,
                            style = 5,
                            label = "User Profile",
                            url = "https://www.roblox.com/users/" .. userid .. "/profile"
                        }, {
                            type = 2,
                            style = 5,
                            label = "Experience",
                            url = "https://www.roblox.com/games/" .. game.PlaceId
                        }}
                    }}}
                    local url = link.Value
                    if not isvl(url) or issus(url) then
                        Library:Notify({
                            Title = "Notification",
                            Content = "Invalid Webhook URL.",
                            Duration = 5
                        })
                    else
                        sendwebhook(data, url)
                    end
                    
                end
            })

            -- Settings
            local AutoExecuteOnTeleport = Script:AddToggle("autexectp", {
                Title = "Auto Execute on Teleport", 
                Description = "Executes the script automatically after teleporting (e.g., Server Hop)",
                Default = true,
                Callback = function(state)
                    if state then
                        if queueteleport then
                            if not _G.TeleportConnection then
                                _G.TeleportConnection = lp.OnTeleport:Connect(function(State)
                                    if Options.autexectp.Value and (not TeleportCheck) and queueteleport then
                                        TeleportCheck = true
                                        queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/xb3rlinz/Loader/refs/heads/main/suite.lua'))()")
                                    end
                                end)
                            end
                            Library:Notify({
                                Title = "Notification",
                                Content = "Auto Execute on Teleport enabled.",
                                Duration = 3
                            })
                        else
                            Library:Notify({
                                Title = "Warning",
                                Content = "Your executor doesn't support queue_on_teleport.",
                                Duration = 5
                            })
                            Options.autexectp:SetValue(false)
                        end
                    else
                        if _G.TeleportConnection then
                            _G.TeleportConnection:Disconnect()
                            _G.TeleportConnection = nil
                        end
                        TeleportCheck = false
                        Library:Notify({
                            Title = "Notification",
                            Content = "Auto Execute on Teleport disabled.",
                            Duration = 3
                        })
                    end
                end
            })
            
            local WhiteScreen = Performance:AddToggle("ws", {
                Title = "White Screen", 
                Default = false,
                Callback = function(state)
                end 
            })
            local BlackScreen = Performance:AddToggle("bs", {
                Title = "Black Screen", 
                Default = false,
                Callback = function(state)
                end 
            })
            local FPSBoost = Performance:AddToggle("fpsb", {
                Title = "FPS Boost", 
                Default = false,
                Callback = function(state)
                end 
            })

            spawn(function()
                wait(1)
                if Options.autexectp and Options.autexectp.Value and queueteleport then
                    AutoExecuteOnTeleport.Callback(true)
                end
            end)

            SaveManager:SetLibrary(Library)
            InterfaceManager:SetLibrary(Library)
            InterfaceManager:SetFolder("Seraph/Library")
            SaveManager:SetFolder("Seraph/99nightsinmyass")
            InterfaceManager:BuildInterfaceSection(Tabs.Settings)
            SaveManager:BuildConfigSection(Tabs.Settings)
            Window:SelectTab(1)
            SaveManager:LoadAutoloadConfig()
        end
    end

    do
        if game == 'testing' then
            -- Tabs
            local Tabs = {
                About = Window:AddTab({ Title = "About", Icon = "info" }),
                Main = Window:AddTab({ Title = "Main", Icon = "crown" }),
                Dungeon = Window:AddTab({ Title = "Dungeon", Icon = "sword" }),
                Castle = Window:AddTab({ Title = "Castle", Icon = "flame" }),
                Rank = Window:AddTab({ Title = "Rank", Icon = "swords" }),
                Raid = Window:AddTab({ Title = "Raid", Icon = "shield" }),
                Teleport = Window:AddTab({ Title = "Teleport", Icon = "map-pin" }),
                Sell = Window:AddTab({ Title = "Sell", Icon = "dollar-sign" }),
                Mount = Window:AddTab({ Title = "Mount", Icon = "car" }),
                Shop = Window:AddTab({ Title = "Shop", Icon = "shopping-cart" }),
                Exchange = Window:AddTab({ Title = "Exchange", Icon = "coins" }),
                Upgrader = Window:AddTab({ Title = "Upgrader", Icon = "hammer" }),
                Boosts = Window:AddTab({ Title = "Boosts", Icon = "activity" }),
                Experimental = Window:AddTab({ Title = "Experimental", Icon = "flask-conical" }),
                Webhook = Window:AddTab({ Title = "Webhook", Icon = "link" }),
                Settings = Window:AddTab({ Title = "Settings", Icon = "settings" }),
            }
            
            -- Sections
            local Information = Tabs.About:AddSection("Script Information")
            local AutoFarm = Tabs.Main:AddSection("Auto Farm")
            local FarmingOptions = Tabs.Main:AddSection("Farming Options")
            local AutoClickOptions = Tabs.Main:AddSection("Auto Click Options")
            local SimpleAction = Tabs.Main:AddSection("Simple Action")
            local FilteredActionOptions = Tabs.Main:AddSection("Filtered Action Options")

            local DungeonOptions = Tabs.Dungeon:AddSection("Options")
            local DungeonSettings = Tabs.Dungeon:AddSection("Settings")
            local DungeonFarm = Tabs.Dungeon:AddSection("Auto Farm")

            local CastleOptions = Tabs.Castle:AddSection("Options")
            local CastleFarm = Tabs.Castle:AddSection("Auto Farm")

            local RankUpFarm = Tabs.Castle:AddSection("Auto Farm")

            local RaidOptions = Tabs.Raid:AddSection("Options")
            local RaidServerHop = Tabs.Raid:AddSection("Server Hop")

            local ShadowSelling = Tabs.Sell:AddSection("Shadow Selling")

            local ExchangeShop = Tabs.Shop:AddSection("Shop")

            local Script = Tabs.Settings:AddSection("Script")
            local Performance = Tabs.Settings:AddSection("Performance")
            local Integration = Tabs.Webhook:AddSection("Integration")

            -- About
            Information:AddParagraph({
                Title = "Version 1.0 beta",
                Content = "First time writing a script. If you find any bugs, feel free to report them on my Discord 🙏"
            })

            Information:AddParagraph({
                Title = "Anti-AFK",
                Content = "Automatically enabled to prevent idle kick."
            })

            Information:AddButton({
                Title = "Bug Report",
                Description = "Click to copy the discord invite link.",
                Callback = function()
                    setclipboard('discord.gg/NV2j3PWU9n')
                    Library:Notify({
                        Title = "Notification",
                        Content = "Invite link has been copied to the clipboard.",
                        Duration = 5
                    })
                end
            })

            -- Experimental
            Tabs.Experimental:AddParagraph({
                Title = "Experrimental features:",
                Content = "- Nothing as of now >:)"
            })

            -- Webhook
            local link = Integration:AddInput("whlink", {
                Title = "Webhook URL",
                Description = "Put your webhook link here.",
                Numeric = false,
                Finished = false,
                Callback = function(Value)
                end
            })
            
            local webcooldown = Integration:AddSlider("whcd", {
                Title = "Send Interval (minutes)",
                Default = 30,
                Min = 1,
                Max = 60,
                Rounding = 1,
                Callback = function(Value)
                end
            })
            
            local webtoggle = Integration:AddToggle("whtoggle", {
                Title = "Enable Webhook", 
                Default = false,
                Callback = function(state)
                end 
            })
            
            Integration:AddButton({
                Title = "Test Webhook",
                Callback = function()
                    local data = {
                        content = "",
                        embeds = {{
                            title = "Test Subject",
                            author = {
                                name = "Account: " .. display_name .. " "
                            },
                            description = "Rewards gained from the last dungeon run:",
                            fields = {
                                {
                                    name = "Ticket Gained",
                                    value = "```69```",
                                    inline = true
                                },
                                {
                                    name = "Common Gained",
                                    value = "```420```",
                                    inline = true
                                }
                            },
                            color = 65280,
                            timestamp = DateTime.now():ToIsoDate(),
                            footer = {
                                text = "Berlin"
                            }
                        }},
                        components = {{
                        type = 1,
                        components = {{
                            type = 2,
                            style = 5,
                            label = "User Profile",
                            url = "https://www.roblox.com/users/" .. userid .. "/profile"
                        }, {
                            type = 2,
                            style = 5,
                            label = "Experience",
                            url = "https://www.roblox.com/games/" .. game.PlaceId
                        }}
                    }}}
                    local url = link.Value
                    if not isvl(url) or issus(url) then
                        Library:Notify({
                            Title = "Notification",
                            Content = "Invalid Webhook URL.",
                            Duration = 5
                        })
                    else
                        sendwebhook(data, url)
                    end
                    
                end
            })
            
            -- Settings
            local AutoExecuteOnTeleport = Script:AddToggle("autexectp", {
                Title = "Auto Execute on Teleport", 
                Description = "Executes the script automatically after teleporting (e.g., Server Hop)",
                Default = true,
                Callback = function(state)
                end
            })

            local WhiteScreen = Performance:AddToggle("ws", {
                Title = "White Screen", 
                Default = false,
                Callback = function(state)
                end 
            })

            local BlackScreen = Performance:AddToggle("bs", {
                Title = "Black Screen", 
                Default = false,
                Callback = function(state)
                end 
            })

            local FPSBoost = Performance:AddToggle("fpsb", {
                Title = "FPS Boost", 
                Default = false,
                Callback = function(state)
                end 
            })
            
            SaveManager:SetLibrary(Library)
            InterfaceManager:SetLibrary(Library)
            InterfaceManager:SetFolder("Seraph/Library")
            SaveManager:SetFolder("Seraph/AC87039211657390")
            InterfaceManager:BuildInterfaceSection(Tabs.Settings)
            SaveManager:BuildConfigSection(Tabs.Settings)
            Window:SelectTab(1)
            SaveManager:LoadAutoloadConfig()
        end
    end 
end

-- Webhook
local function isvl(url)
    local pattern = "^https://discord%.com/api/webhooks/%d+/.+"
    return string.match(url, pattern) ~= nil
end

local function issus(url)
    local blacklist = {
        "discord%.gg",
        "discordapp%.xyz",
        "discord%.gift",
        "fakecord",
        "disc0rd",
        "%.ru",
    }

    for _, blocked in pairs(blacklist) do
        if string.find(url:lower(), blocked) then
            return true
        end
    end
    return false
end

local function sendwebhook(data, url)
    local request = getrequest()

    if not request then
        Library:Notify({
            Title = "Warning",
            Content = "Your executor is not compatible with HTTP requests.",
            Duration = 8
        })
        return
    end

    if plrname == display_name then
        plrname = ''
    else
        plrname = '('..lp.Name..')'
    end

    local body = http:JSONEncode(data)

    local success = pcall(function()
        return request({
            Url = url,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = body
        })
    end)

    if success then
        Library:Notify({
            Title = "Notification",
            Content = "Webhook sent.",
            Duration = 5
        })
    else
        Library:Notify({
            Title = "Notification",
            Content = "Failed to send webhook.",
            Duration = nil
        })
    end
end

-- Notifications Center
local function enableantiafk()
    if exec == 'Solara' then
        local afkelapsed = 0
        uis.InputBegan:Connect(function()
            if connection then
                connection:Disconnect()
                connection = nil
                afkelapsed = 0
            end
        end)
        uis.InputEnded:Connect(function()
            local connection
            connection = game.RunService.Heartbeat:Connect(function(delta)
                afkelapsed += delta
                if afkelapsed >= 1199 then
                    game:GetService("VirtualUser"):ClickButton2(Vector2.new())
                    afkelapsed -= 1199
                end
            end)
        end)
    else
        for i,v in pairs(getconnections(lp.Idled)) do
            v:Disable()
        end
    end
    
    Library:Notify({
        Title = "Notification",
        Content = "Anti-AFK has been enabled.",
        Duration = 5
    })
end

local function loadstate(state)
    if state then
        Library:Notify({
            Title = "Notification",
            Content = "Succeed",
            Duration = 5
        })
        enableantiafk()
    else
        Library:Notify({
            Title = "Notification",
            Content = "Error",
            Duration = 5
        })
    end
end

local function loadui(game)
    loadstate(pcall(createui, game))
end

--[[





    99 Nights in the Forest





--]]
if game_name == 'The good gaming chair' then
    local place_id = tostring(game.PlaceId)
    if place_id == '79546208627805' then
        Library:Notify({
            Title = "Notification",
            Content = "You are currently in a lobby.",
            Duration = 6.5
        })
        return
    end
    loadui('99nightsintheforest')
end

--[[





    a testing place





--]]

if game_name == 'A good gaming chair' then
    loadui('testing')
end
