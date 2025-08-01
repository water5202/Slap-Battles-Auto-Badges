if not game:IsLoaded() then
	game.Loaded:Wait()
end

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
game.Players.LocalPlayer.CameraMaxZoomDistance = 100
game.Players.LocalPlayer.CameraMode = Enum.CameraMode.Classic

local Window = Fluent:CreateWindow({
    Title = "The Elude Maze // " .. identifyexecutor(),
    SubTitle = "",
    TabWidth = 120,
    Size = UDim2.fromOffset(400, 300),
    Acrylic = false,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.H
})

local Tabs = {
    Main = Window:AddTab({ Title = "Maze Badges", Icon = "hammer" })
}

Tabs.Main:AddButton({
    Title = "Exposed Badge",
    Description = "Automatically gets Exposed Badge",
    Callback = function()
        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Ruins.Elude.Glove, 0)
task.wait(0.5)
        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Ruins.Elude.Glove, 1) 
    end
})

Tabs.Main:AddButton({
    Title = "Counter Lever",
    Description = "Pulls the lever and Pim Spawns",
    Callback = function()
fireclickdetector(workspace.CounterLever.ClickDetector)
    end
})


Tabs.Main:AddButton({
    Title = "Counter Badge",
    Description = "Automatically gets the Counter Badge",
    Callback = function()
        fireclickdetector(workspace.CounterLever.ClickDetector)

        local player = game.Players.LocalPlayer
        player.Character.HumanoidRootPart.CFrame = CFrame.new(-118.254112, 33.9999962, -15.9436445, 0.999970675, 9.07502198e-08, -0.00766188465, -9.13593965e-08, 1, -7.91567913e-08, 0.00766188465, 7.9854459e-08, 0.999970675)

        task.wait(1)
        player.Character.HumanoidRootPart.Anchored = true

        local part
        while not part do
            local target = workspace.Maze:GetChildren()[673]
            if target then
                part = target:FindFirstChildOfClass("ClickDetector")
            end
            task.wait(0.1)
        end

        while true do
            fireclickdetector(part)
            task.wait(0.005)
        end
    end
})

Tabs.Main:AddButton({
    Title = "Alchemist Relic",
    Description = "Gets the Relic",
    Callback = function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace._ugcQuestObjectEludeHat.Position
fireclickdetector(workspace._ugcQuestObjectEludeHat.ClickDetector)
    end
})

Window:SelectTab(1)
