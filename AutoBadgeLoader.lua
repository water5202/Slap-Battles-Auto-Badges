if not game:IsLoaded() then
	game.Loaded:Wait()
end

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local Players = game:GetService("Players")
local BRICKLABEL
local UIS = game:GetService("UserInputService")
local VirtualInput = game:GetService("VirtualUser")
local HRP
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local localplayer = Players.LocalPlayer
local GeneralHit = ReplicatedStorage:WaitForChild("GeneralHit") -- Dual's Double hit Event
local Ping
local time
local TARGETSLAPPLAYER = nil
local idledConnection
local Brickconnection = nil
local RunService = game:GetService("RunService")
local ArenaPart = workspace.Lobby.Teleport1
local GOTOPLAYER = nil
local brickvar
local GS
local Duplicate = ReplicatedStorage:WaitForChild("Duplicate") -- Replica's Duplicate Event
-- 1
function SpawnReplica()
Duplicate:FireServer()
end
-- 2
function AutoBrick()
BRICKLABEL = game:GetService("Players").LocalPlayer.PlayerGui.BRICKCOUNT.ImageLabel.TextLabel
game:GetService("ReplicatedStorage").lbrick:FireServer()
brickvar = tonumber(BRICKLABEL.Text) or 0
brickvar = brickvar + 1
BRICKLABEL.Text = tostring(brickvar)
end
--
local bypass;
    bypass = hookmetamethod(game, "__namecall", function(method, ...) 
        if getnamecallmethod() == "FireServer" and method == game.ReplicatedStorage.Ban then
            return
        elseif getnamecallmethod() == "FireServer" and method == game.ReplicatedStorage.AdminGUI then
            return
        elseif getnamecallmethod() == "FireServer" and method == game.ReplicatedStorage.WalkSpeedChanged then
            return
        end
        return bypass(method, ...)
    end)

Fluent:Notify({Title = "Interface", Content = "Bypassed AntiCheat!", SubContent = "HookMeta Method", Duration = 5})

if game.Workspace:FindFirstChild("SafeSpotPart") then 
    game.Workspace.SafeSpotPart:Destroy() 
end

local MusicPlayer = Instance.new("Sound")
MusicPlayer.Name = "fuck me bro"
MusicPlayer.Parent = workspace
MusicPlayer.Volume = 1

local Platform = Instance.new("Part")
Platform.Name = "SafeSpotPart"
Platform.Parent = workspace
Platform.CFrame = CFrame.new(-108000.6895, -122.158432, -2900.86475, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Platform.Size = Vector3.new(84, 5, 82)
Platform.Transparency = 0.5
Platform.Anchored = true

local Window = Fluent:CreateWindow({
    Title = "Auto Badges // " .. identifyexecutor(),
    SubTitle = "",
    TabWidth = 120,
    Size = UDim2.fromOffset(400, 300),
    Acrylic = false,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.H
})

local Tabs = {
    AutoFish = Window:AddTab({ Title = "Auto Fish", Icon = "hammer" }),
    AutoBrickMaster = Window:AddTab({ Title = "Auto BrickMaster", Icon = "hammer" }),
    SlapFarm = Window:AddTab({ Title = "Slap Farm", Icon = "hammer" }),
    BobFarm = Window:AddTab({ Title = "Bob Farm", Icon = "hammer" }),
    Badges = Window:AddTab({ Title = "Badges", Icon = "box" }),
    Info = Window:AddTab({ Title = "Info", Icon = "info" }),
    MusicPlayerTab = Window:AddTab({ Title = "Music Player", Icon = "music" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local MusicInput = Tabs.MusicPlayerTab:AddInput("SexyMusicPlayerInput", {
    Title = "SoundID",
    Description = "",
    Default = "",
    Placeholder = "rbxassetid://int",
    Numeric = false,
    Finished = false,
    Callback = function(Value)
        MusicPlayer.SoundId = Value
    end
})

local MusicVolume = Tabs.MusicPlayerTab:AddInput("SexyMusicVolumeInput", {
    Title = "Music Volume",
    Description = "",
    Default = "",
    Placeholder = "//",
    Numeric = true,
    Finished = false,
    Callback = function(Value)
        MusicPlayer.Volume = Value
    end
})

local CanTheMusicLoop = Tabs.MusicPlayerTab:AddToggle("MusicLooperToggle", 
{
    Title = "Music Loop?", 
    Description = "Loops Music or not",
    Default = false,
    Callback = function(state)
	if state then
	    MusicPlayer.Looped = true
	else
	    MusicPlayer.Looped = false
        end
    end 
})

Tabs.MusicPlayerTab:AddButton({
    Title = "Play Music",
    Description = "",
    Callback = function()
        MusicPlayer.Playing = not MusicPlayer.Playing
    end
})

local MusicStart = Tabs.MusicPlayerTab:AddInput("SexyMusicStartInput", {
    Title = "TimePosition",
    Description = "",
    Default = "",
    Placeholder = "//",
    Numeric = true,
    Finished = false,
    Callback = function(Value)
        MusicPlayer.TimePosition = Value
    end
})

local SlapsText = Tabs.Info:AddParagraph({
        Title = "Slaps // ?",
        Content = "Shows Slaps"
})

task.spawn(function()
while true do
SlapsText:SetTitle("Slaps // " .. game.Players.LocalPlayer.leaderstats.Slaps.Value)
task.wait(0.001)
    end
end)

local PlayerText = Tabs.Info:AddParagraph({
        Title = "0/16",
        Content = "Players"
})

task.spawn(function()
    while true do
    local playersinnumb = #Players:GetChildren()
        PlayerText:SetTitle(playersinnumb .. "/16")
        task.wait(0.001)
    end
end)

local PingText = Tabs.Info:AddParagraph({
        Title = "Ping // ?",
        Content = "Shows your current Ping"
})

task.spawn(function()
    while true do
Ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
PingText:SetTitle("Ping // " .. Ping)
	task.wait(1)
    end
end)

local CODETEXT = Tabs.Info:AddParagraph({
        Title = "",
        Content = "Elude keypad code"
})

task.spawn(function()
while true do
CODETEXT:SetTitle("Keypad Code // "..tostring((#game.Players:GetPlayers()) * 25 + 1100 - 7))
task.wait(0.001)
    end
end)

local GloveStandText = Tabs.Info:AddParagraph({
        Title = "Glove Stands // Numb",
        Content = "Increased alot"
})

task.spawn(function()
while true do
GS = #workspace.Lobby.GloveStands:GetChildren()
GloveStandText:SetTitle("Glove Stands // " .. GS)
task.wait(0.001)
    end
end)

local KeypadText = Tabs.Info:AddParagraph({
        Title = "Keypad Spawned // No",
        Content = "Elude Keypad"
})

task.spawn(function()
while true do
if game.Workspace:FindFirstChild("Keypad") then
KeypadText:SetTitle("Keypad Spawn // Yes")
else
KeypadText:SetTitle("Keypad Spawn // No")
end
task.wait(0.001)
    end
end)

local SiphonText = Tabs.Info:AddParagraph({
        Title = "Siphon Orb // No",
        Content = "Checks for Siphon orb"
})

task.spawn(function()
while true do
if game.Workspace:FindFirstChild("SiphonOrb") then
SiphonText:SetTitle("Siphon Orb // Yes")
			else
SiphonText:SetTitle("Siphon Orb // No")
end
task.wait(0.001)
    end
end)

local ToolBoxText = Tabs.Info:AddParagraph({
        Title = "Toolbox // No",
        Content = "Checks for Toolbox"
})

task.spawn(function()
while true do
if game.Workspace:FindFirstChild("Toolbox") then
ToolBoxText:SetTitle("Toolbox // Yes")
			else
ToolBoxText:SetTitle("Toolbox // No")
end
task.wait(0.001)
    end
end)

local TimeBar = Tabs.Info:AddParagraph({
    Title = "",
    Content = "Local Time"
})

task.spawn(function()
while true do
time = os.date("%H:%M:%S")
TimeBar:SetTitle(time)
task.wait(0.1)
end			
end)

Tabs.Badges:AddButton({
    Title = "Get Plunger",
    Description = "Gets Plunger automatically",
    Callback = function()
local teleportFunc = queueonteleport or queue_on_teleport
    if teleportFunc then
        teleportFunc([[
if not game:IsLoaded() then
    game.Loaded:Wait()
end
fireclickdetector(workspace["plunger glove"].ClickDetector)
]])
end
fireclickdetector(workspace.BountyHunterRoom.PlungerMain.ClickDetector)
task.wait(0.5)
fireclickdetector(workspace.plungers.ToiletPlunger.ClickDetector)
    end
})

Tabs.Badges:AddButton({
    Title = "Get Iceskate",
    Description = "so free lmao",
    Callback = function()
         game:GetService("ReplicatedStorage").IceSkate:FireServer("Freeze")
    end
})

Tabs.Badges:AddButton({
    Title = "Get Lamp",
    Description = "so free lmao",
    Callback = function()
         game:GetService("ReplicatedStorage").nightmare:FireServer("LightBroken")
    end
})

Tabs.Badges:AddButton({
    Title = "Get Boxing Glove",
    Description = "Gets Boxing Glove automatically",
    Callback = function()
local teleportFunc = queueonteleport or queue_on_teleport
    if teleportFunc then
        teleportFunc([[
if not game:IsLoaded() then
    game.Loaded:Wait()
end
					
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(4183.43701, 3518.25, 194.199707, -1, 0, 0, 0, 1, 0, 0, 0, -1)
task.wait(3)
fireclickdetector(workspace.BoxingGloves.ClickDetector)
task.wait(1)
game:GetService("TeleportService"):Teleport(6403373529)
]])
end
game:GetService("TeleportService"):Teleport(7234087065)
    end
})

Tabs.AutoFish:AddButton({
    Title = "Equip ZZZZZZZ",
    Description = "",
    Callback = function()
         fireclickdetector(workspace.Lobby.ZZZZZZZ.ClickDetector) 
    end
})

Tabs.Badges:AddButton({
    Title = "All 3 Misc Badges",
    Description = "Duck Orange and Knife",
    Callback = function()
         fireclickdetector(workspace.Lobby.Scene.knofe.ClickDetector)
	 fireclickdetector(workspace.Arena.island5.Orange.ClickDetector)
	 fireclickdetector(workspace.Lobby.Scene.knofe.ClickDetector)
    end
})

Tabs.Badges:AddButton({
    Title = "Get [REDACTED]",
    Description = "Must Have 5000 Slaps",
    Callback = function()
if localplayer.Character:FindFirstChild("entered") and game:GetService("Players").LocalPlayer.leaderstats.Slaps.Value >= 5000 then
	firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.PocketDimension.Doors["9"], 0)
	task.wait(0.1)
	firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.PocketDimension.Doors["9"], 1)
			else
	Fluent:Notify({Title = "Interface", Content = "Not Enough Slaps", SubContent = "", Duration = 5})
			end
    end
})

Tabs.Badges:AddButton({
    Title = "Get Glovel",
    Description = "Make sure you have Hitman Quest",
    Callback = function()
localplayer.Character.Humanoid.Health = 0
task.wait(5)
fireclickdetector(workspace.Lobby.Extended.ClickDetector)
task.wait(1)
HRP = localplayer.Character.HumanoidRootPart
firetouchinterest(HRP, ArenaPart, 0)
task.wait(0.5)
firetouchinterest(HRP, ArenaPart, 1)
task.wait(0.5)
HRP.CFrame = CFrame.new(220.62793, 26.9119072, 189.395142, 0.760179281, 2.943524e-08, -0.649713337, 2.955138e-08, 1, 7.98807491e-08, 0.649713337, -7.99236162e-08, 0.760179281)
task.wait(0.5)
fireproximityprompt(workspace.Arena.CannonIsland.GlovelHoleInTheWall.ProximityPrompt)
task.wait(5)
HRP.CFrame = CFrame.new(-210.165329, 7.0089736, 0.595660448, 0.106427543, -7.25070226e-09, -0.994320452, 8.1350473e-09, 1, -6.42137987e-09, 0.994320452, -7.40543271e-09, 0.106427543)
    end
})

Tabs.SlapFarm:AddButton({
    Title = "Equip Dual",
    Description = "",
    Callback = function()
fireclickdetector(workspace.Lobby.Dual.ClickDetector)
    end
})

Tabs.SlapFarm:AddButton({
    Title = "Teleport to SafeSpot",
    Description = "",
    Callback = function()
HRP = localplayer.Character.HumanoidRootPart
firetouchinterest(HRP,  ArenaPart, 0)
task.wait(0.1)
firetouchinterest(HRP, ArenaPart, 1)
task.wait(0.5)
localplayer.Character.HumanoidRootPart.CFrame = CFrame.new(-108000.6895, -119.158432, -2900.86475, 1, 0, 0, 0, 1, 0, 0, 0, 1)
    end
})

local teleporting = false

local GOTOPLAYERTELEPORTER = Tabs.SlapFarm:AddToggle("SexyCoolSlapTeleportToggle", {
    Title = "Teleport to Player", 
    Description = "For Alt Account",
    Default = false,
    Callback = function(state)
        teleporting = state
        if state then
            task.spawn(function()
                while teleporting do
                    if GOTOPLAYER and GOTOPLAYER.Character and GOTOPLAYER.Character:FindFirstChild("HumanoidRootPart") then
                        if localplayer.Character and localplayer.Character:FindFirstChild("HumanoidRootPart") then
                            localplayer.Character.HumanoidRootPart.CFrame = GOTOPLAYER.Character.HumanoidRootPart.CFrame
                        end
                    end
                    task.wait(0.001)
                end
            end)
        end
    end
})

local ChangeGOTOPLAYER = Tabs.SlapFarm:AddInput("SexyInputBox", {
    Title = "",
    Description = "TP",
    Default = nil,
    Placeholder = "//",
    Numeric = false, 
    Finished = false,
    Callback = function(input)
        GOTOPLAYER = game.Players:FindFirstChild(input)
    end
})

local SlapAuraRunning = false

local AutoSlapToggle = Tabs.SlapFarm:AddToggle("SexySlapAura", {
    Title = "Slap Aura",
    Description = "Slaps the player to farm on",
    Default = false,
    Callback = function(state)
        SlapAuraRunning = state
        if SlapAuraRunning then
            task.spawn(function()
                while SlapAuraRunning do
                    if TARGETSLAPPLAYER and TARGETSLAPPLAYER.Character and TARGETSLAPPLAYER.Character:FindFirstChild("HumanoidRootPart") then
                        game:GetService("ReplicatedStorage"):WaitForChild("GeneralHit"):FireServer(TARGETSLAPPLAYER.Character.HumanoidRootPart)
                    end
                    task.wait(0.7)
                end
            end)
        end
    end
})

local ChangeTARGETSLAPPLAYER = Tabs.SlapFarm:AddInput("SexyInputBox2", {
    Title = "",
    Description = "Slap Aura",
    Default = nil,
    Placeholder = "//",
    Numeric = false, 
    Finished = false,
    Callback = function(input)
        TARGETSLAPPLAYER = game.Players:FindFirstChild(input)
    end
})

Tabs.Badges:AddButton({
    Title = "Elude Maze Teleport",
    Description = "Goto Elude Maze",
    Callback = function()
local teleportFunc = queueonteleport or queue_on_teleport
    if teleportFunc then
        teleportFunc([[
loadstring(game:HttpGet("https://raw.githubusercontent.com/water5202/Slap-Battles-Auto-Badges/refs/heads/main/EludeMazeUI"))()
]])
end
game:GetService("TeleportService"):Teleport(11828384869)
    end
})

Tabs.AutoBrickMaster:AddButton({
    Title = "Equip Brick",
    Description = "",
    Callback = function()
         fireclickdetector(workspace.Lobby.Brick.ClickDetector)
    end
})

local brickfarming = false

local brickfarmer = Tabs.AutoBrickMaster:AddToggle("TheCoolestBrickToggle", {
    Title = "Auto BrickMaster",
    Description = "",
    Default = false,
    Callback = function(state)
        brickfarming = state
        if brickfarming and localplayer.Character:FindFirstChild("entered") then
            task.spawn(function()
                while brickfarming do
AutoBrick()
task.wait(1.3)
                end
            end)
        end
    end
})
-- dunno why i decided to use RunService for a loop but whatever

Tabs.AutoFish:AddButton({
    Title = "Goto Safespot",
    Description = "",
    Callback = function()
       HRP = localplayer.Character.HumanoidRootPart
                            firetouchinterest(HRP,  ArenaPart, 0)
                            task.wait(0.1)
                            firetouchinterest(HRP, ArenaPart, 1)
			    task.wait(0.3)
                            localplayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-108000.6895, -119.158432, -2900.86475, 1, 0, 0, 0, 1, 0, 0, 0, 1)
                                task.wait(0.2)
        if game.Players.LocalPlayer.leaderstats.Glove.Value == "ZZZZZZZ" then
          game:GetService("ReplicatedStorage"):WaitForChild("ZZZZZZZSleep"):FireServer()
        end
    end
})

Tabs.Badges:AddButton({
    Title = "Get Frostbite",
    Description = "Gets Frostbite automatically",
    Callback = function()
local teleportFunc = queueonteleport or queue_on_teleport
    if teleportFunc then
        teleportFunc([[
            if not game:IsLoaded() then
                game.Loaded:Wait()
            end
            repeat wait() until game.Players.LocalPlayer
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-554, 177, 56)
wait(0.7)
for i,v in ipairs(game:GetService("Workspace"):GetDescendants()) do
            if v.ClassName == "ProximityPrompt" then
                fireproximityprompt(v)
            end
        end
]])
end
game:GetService("TeleportService"):Teleport(17290438723)
    end
})

Tabs.AutoBrickMaster:AddButton({
    Title = "Goto Safespot",
    Description = "",
    Callback = function()
       HRP = localplayer.Character.HumanoidRootPart
                            firetouchinterest(HRP,  ArenaPart, 0)
                            task.wait(0.1)
                            firetouchinterest(HRP, ArenaPart, 1)
			    task.wait(0.3)
                 localplayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-108000.6895, -119.158432, -2900.86475, 1, 0, 0, 0, 1, 0, 0, 0, 1)
    end
})

Tabs.BobFarm:AddButton({
    Title = "Equip Replica",
    Description = "",
    Callback = function()
         fireclickdetector(workspace.Lobby.Replica.ClickDetector) 
    end
})

local bobfarming = false

local bobfarmtoggle = Tabs.BobFarm:AddToggle("SexySpawnReplica", {
    Title = "Auto Replica",
    Description = "Don't press E",
    Default = false,
    Callback = function(state)
        bobfarming = state
        if bobfarming and localplayer.Character:FindFirstChild("entered") then
	task.wait(0.5)
            task.spawn(function()
                while bobfarming do
		SpawnReplica()
		task.wait(5.5)
                end
            end)
        end
    end
})


Tabs.BobFarm:AddButton({
    Title = "Goto Safespot",
    Description = "",
    Callback = function()
       HRP = localplayer.Character.HumanoidRootPart
                            firetouchinterest(HRP,  ArenaPart, 0)
                            task.wait(0.1)
                            firetouchinterest(HRP, ArenaPart, 1)
			    task.wait(0.3)
                 localplayer.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-108000.6895, -119.158432, -2900.86475, 1, 0, 0, 0, 1, 0, 0, 0, 1)
    end
})

Tabs.Settings:AddButton({
        Title = "Reset",
        Description = "",
        Callback = function()
            Window:Dialog({
                Title = "Confirm Reset?",
                Content = "",
                Buttons = {
                    {
                        Title = "Confirm",
                        Callback = function()
                            game.Players.LocalPlayer.Character.Humanoid.Health = 0
                        end
                    },
                    {
                        Title = "Cancel",
                        Callback = function()
                        end
                    }
                }
            })
        end
})

Tabs.Settings:AddButton({
        Title = "Kick",
        Description = "",
        Callback = function()
            Window:Dialog({
                Title = "Confirm Kick?",
                Content = "",
                Buttons = {
                    {
                        Title = "Confirm",
                        Callback = function()
                            game.Players.LocalPlayer:Kick("Kicked // " .. localplayer.Name .. "!")
                        end
                    },
                    {
                        Title = "Cancel",
                        Callback = function()
                        end
                    }
                }
            })
        end
})

Tabs.SlapFarm:AddButton({
    Title = "Anchor yourself",
    Description = "Anchors your HumanoidRootPart",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = not game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored
    end
})

local slapplefarming = false

local slapplefarmtoggle = Tabs.SlapFarm:AddToggle("SexySlappleTouch", {
    Title = "Auto Slapples",
    Description = "Lags a little?",
    Default = false,
    Callback = function(state)
        slapplefarming = state
        if slapplefarming and localplayer.Character:FindFirstChild("entered") then
	task.wait(0.5)
            task.spawn(function()
                while slapplefarming do
HRP = game.Players.LocalPlayer.Character.HumanoidRootPart
for _,Slapples in pairs(workspace.Arena.island5.Slapples:GetChildren()) do
firetouchinterest(HRP, Slapples.Glove, 0)
task.wait(0.5)
firetouchinterest(HRP, Slapples.Glove, 1)
end
		task.wait(1)
                end
            end)
        end
    end
})

local platefarming = false

local platefarmer = Tabs.Badges:AddToggle("TheCoolestPlateToggle", {
    Title = "Auto Plate",
    Description = "Tycoon Glove",
    Default = false,
    Callback = function(state)
        platefarming = state
        if platefarming and localplayer.Character:FindFirstChild("entered") then
	task.wait(0.5)
            task.spawn(function()
                while platefarming do
HRP = game.Players.LocalPlayer.Character.HumanoidRootPart
HRP.CFrame = workspace.Arena.Plate.CFrame
task.wait(0.001)
                end
            end)
        end
    end
})

local AntiAfk = Tabs.Settings:AddToggle("SexyAntiAfkToggle", {
    Title = "Anti Afk", 
    Description = "Disables being kicked",
    Default = false,
    Callback = function(state)
        if state then
            if not idledConnection then
                idledConnection = Players.LocalPlayer.Idled:Connect(function()
                    VirtualInput:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                    task.wait(0.1)
                    VirtualInput:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                end)
            end
        else
            if idledConnection then
                idledConnection:Disconnect()
                idledConnection = nil
            end
        end
    end
})

Tabs.Settings:AddButton({
    Title = "Infinite Yield",
    Description = "Loads Infinite Yield",
    Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/edgeiy/infiniteyield/master/source"))()
    end
})

Tabs.Settings:AddButton({
    Title = "Console Logger",
    Description = "Loads My Console Logger",
    Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/water5202/Water-s-Custom-Console/refs/heads/main/Loader.lua"))()
    end
})

Tabs.Settings:AddButton({
    Title = "FLY GUI V3",
    Description = "Loads the Classic Mobile fly",
    Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/refs/heads/main/FlyGuiV3.txt"))()
    end
})

Tabs.Settings:AddButton({
    Title = "Unload UI",
    Description = "Unloads UI",
    Callback = function()
                game.Workspace:WaitForChild("AutoFarmPart"):Destroy()
                Fluent:Destroy()
    end
})

Window:SelectTab(1)
