local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local HardcorePanel = Instance.new("ScreenGui")
HardcorePanel.Name = "HardcorePanel"
HardcorePanel.ResetOnSpawn = false
HardcorePanel.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
HardcorePanel.Parent = PlayerGui

local COLORS = {
    PRIMARY = Color3.fromRGB(255, 50, 50),
    SECONDARY = Color3.fromRGB(255, 100, 100),
    BACKGROUND = Color3.fromRGB(20, 5, 5),
    BUTTON_BG = Color3.fromRGB(40, 10, 10),
    BUTTON_HOVER = Color3.fromRGB(60, 15, 15),
    CLOSE_BG = Color3.fromRGB(255, 50, 50),
    TEXT_WHITE = Color3.fromRGB(255, 255, 255),
    TEXT_INSTRUCT = Color3.fromRGB(100, 200, 255)
}

local MobileIcon = Instance.new("ImageButton")
MobileIcon.Name = "MobileIcon"
MobileIcon.Size = UDim2.new(0, 60, 0, 60)
MobileIcon.Position = UDim2.new(0.95, 0, 0.05, 0)  -- 右上角位置
MobileIcon.Image = "rbxassetid://11656483170"  -- 使用您指定的图标
MobileIcon.BackgroundTransparency = 1
MobileIcon.AnchorPoint = Vector2.new(1, 0)  -- 右上角锚点
MobileIcon.Parent = HardcorePanel

local IconGlow = Instance.new("ImageLabel")
IconGlow.Name = "IconGlow"
IconGlow.Size = UDim2.new(1.2, 0, 1.2, 0)
IconGlow.Position = UDim2.new(-0.1, 0, -0.1, 0)
IconGlow.Image = "rbxassetid://11656483170"
IconGlow.ImageColor3 = Color3.new(1, 0.3, 0.3)  -- 红色主题
IconGlow.BackgroundTransparency = 1
IconGlow.ZIndex = -1
IconGlow.ImageTransparency = 0.7
IconGlow.AnchorPoint = Vector2.new(1, 0)  -- 与父级保持一致
IconGlow.Parent = MobileIcon

-- 脉冲动画
RunService.Heartbeat:Connect(function()
    local scale = 1 + 0.1 * math.sin(tick() * 2)
    IconGlow.Size = UDim2.new(scale, 0, scale, 0)
    IconGlow.Position = UDim2.new((scale-1)/-2, 0, (scale-1)/-2, 0)
    IconGlow.ImageTransparency = 0.7 + 0.2 * math.sin(tick() * 2)
end)

-- 悬停和点击效果
MobileIcon.MouseEnter:Connect(function()
    TweenService:Create(MobileIcon, TweenInfo.new(0.2), {Size = UDim2.new(0, 65, 0, 65)}):Play()
    TweenService:Create(IconGlow, TweenInfo.new(0.2), {ImageTransparency = 0.5}):Play()
end)

MobileIcon.MouseLeave:Connect(function()
    TweenService:Create(MobileIcon, TweenInfo.new(0.2), {Size = UDim2.new(0, 60, 0, 60)}):Play()
    TweenService:Create(IconGlow, TweenInfo.new(0.2), {ImageTransparency = 0.7}):Play()
end)

MobileIcon.MouseButton1Down:Connect(function()
    TweenService:Create(MobileIcon, TweenInfo.new(0.1), {Size = UDim2.new(0, 55, 0, 55)}):Play()
end)

MobileIcon.MouseButton1Up:Connect(function()
    TweenService:Create(MobileIcon, TweenInfo.new(0.1), {Size = UDim2.new(0, 60, 0, 60)}):Play()
end)

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0.3, 0, 0.5, 0)
MainFrame.Position = UDim2.new(0.35, 0, 0.25, 0)
MainFrame.BackgroundColor3 = COLORS.BACKGROUND
MainFrame.BackgroundTransparency = 0.2
MainFrame.BorderColor3 = COLORS.PRIMARY
MainFrame.BorderSizePixel = 2
MainFrame.Visible = false
MainFrame.Parent = HardcorePanel

local UIGlow = Instance.new("UIGradient")
UIGlow.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 0, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(150, 0, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 0, 0))
})
UIGlow.Rotation = 45
UIGlow.Enabled = true
UIGlow.Parent = MainFrame

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = COLORS.PRIMARY
UIStroke.Thickness = 3
UIStroke.Transparency = 0.3
UIStroke.Parent = MainFrame

local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0.08, 0)
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
TitleBar.BackgroundTransparency = 0.3
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleUICorner = Instance.new("UICorner")
TitleUICorner.CornerRadius = UDim.new(0, 8)
TitleUICorner.Parent = TitleBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Size = UDim2.new(0.8, 0, 1, 0)
TitleLabel.Position = UDim2.new(0.1, 0, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "HardCore PANEL"
TitleLabel.TextColor3 = COLORS.PRIMARY
TitleLabel.TextScaled = true
TitleLabel.Font = Enum.Font.SciFi
TitleLabel.Parent = TitleBar

local function addPulseEffect(label)
    local pulseInfo = TweenInfo.new(
        1.5,
        Enum.EasingStyle.Quint,
        Enum.EasingDirection.InOut,
        -1,
        true
    )
    
    local pulseTween = TweenService:Create(
        label,
        pulseInfo,
        {TextTransparency = 0.3}
    )
    pulseTween:Play()
end

addPulseEffect(TitleLabel)

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0.1, 0, 0.8, 0)
CloseButton.Position = UDim2.new(0.89, 0, 0.1, 0)
CloseButton.BackgroundColor3 = COLORS.CLOSE_BG
CloseButton.BackgroundTransparency = 0.2
CloseButton.Text = "X"
CloseButton.TextColor3 = COLORS.TEXT_WHITE
CloseButton.TextScaled = true
CloseButton.Font = Enum.Font.SciFi
CloseButton.Parent = TitleBar

local CloseUICorner = Instance.new("UICorner")
CloseUICorner.CornerRadius = UDim.new(0, 4)
CloseUICorner.Parent = CloseButton

local ButtonContainer = Instance.new("Frame")
ButtonContainer.Name = "ButtonContainer"
ButtonContainer.Size = UDim2.new(0.9, 0, 0.72, 0)
ButtonContainer.Position = UDim2.new(0.05, 0, 0.1, 0)
ButtonContainer.BackgroundTransparency = 1
ButtonContainer.Parent = MainFrame

local FloorsScrollingFrame = Instance.new("ScrollingFrame")
FloorsScrollingFrame.Name = "FloorsScrollingFrame"
FloorsScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
FloorsScrollingFrame.BackgroundTransparency = 1
FloorsScrollingFrame.BorderSizePixel = 0
FloorsScrollingFrame.ScrollBarThickness = 6
FloorsScrollingFrame.ScrollBarImageColor3 = COLORS.PRIMARY
FloorsScrollingFrame.Visible = true
FloorsScrollingFrame.Parent = ButtonContainer

local DexScrollingFrame = Instance.new("ScrollingFrame")
DexScrollingFrame.Name = "DexScrollingFrame"
DexScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
DexScrollingFrame.BackgroundTransparency = 1
DexScrollingFrame.BorderSizePixel = 0
DexScrollingFrame.ScrollBarThickness = 6
DexScrollingFrame.ScrollBarImageColor3 = COLORS.PRIMARY
DexScrollingFrame.Visible = false
DexScrollingFrame.Parent = ButtonContainer

local MonsterScrollingFrame = Instance.new("ScrollingFrame")
MonsterScrollingFrame.Name = "MonsterScrollingFrame"
MonsterScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
MonsterScrollingFrame.BackgroundTransparency = 1
MonsterScrollingFrame.BorderSizePixel = 0
MonsterScrollingFrame.ScrollBarThickness = 6
MonsterScrollingFrame.ScrollBarImageColor3 = COLORS.PRIMARY
MonsterScrollingFrame.Visible = false
MonsterScrollingFrame.Parent = ButtonContainer

local ItemScrollingFrame = Instance.new("ScrollingFrame")
ItemScrollingFrame.Name = "ItemScrollingFrame"
ItemScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
ItemScrollingFrame.BackgroundTransparency = 1
ItemScrollingFrame.BorderSizePixel = 0
ItemScrollingFrame.ScrollBarThickness = 6
ItemScrollingFrame.ScrollBarImageColor3 = COLORS.PRIMARY
ItemScrollingFrame.Visible = false
ItemScrollingFrame.Parent = ButtonContainer

local FloorsListLayout = Instance.new("UIListLayout")
FloorsListLayout.Padding = UDim.new(0, 6)
FloorsListLayout.Parent = FloorsScrollingFrame

local DexListLayout = Instance.new("UIListLayout")
DexListLayout.Padding = UDim.new(0, 6)
DexListLayout.Parent = DexScrollingFrame

local MonsterListLayout = Instance.new("UIListLayout")
MonsterListLayout.Padding = UDim.new(0, 6)
MonsterListLayout.Parent = MonsterScrollingFrame

local ItemListLayout = Instance.new("UIListLayout")
ItemListLayout.Padding = UDim.new(0, 6)
ItemListLayout.Parent = ItemScrollingFrame

local function addFloorButton(name, text, onClick)
    local button = Instance.new("TextButton")
    button.Name = name .. "Button"
    button.Size = UDim2.new(0.9, 0, 0, 40)
    button.BackgroundColor3 = COLORS.BUTTON_BG
    button.BackgroundTransparency = 0.1
    button.Text = text
    button.TextColor3 = COLORS.PRIMARY
    button.TextScaled = true
    button.Font = Enum.Font.SciFi
    button.TextSize = 20
    button.Parent = FloorsScrollingFrame
    
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 6)
    uiCorner.Parent = button
    
    local uiStroke = Instance.new("UIStroke")
    uiStroke.Color = COLORS.PRIMARY
    uiStroke.Thickness = 2
    uiStroke.Parent = button
    
    button.MouseEnter:Connect(function()
        TweenService:Create(
            button,
            TweenInfo.new(0.2),
            {
                BackgroundColor3 = COLORS.BUTTON_HOVER,
                TextColor3 = COLORS.SECONDARY
            }
        ):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(
            button,
            TweenInfo.new(0.2),
            {
                BackgroundColor3 = COLORS.BUTTON_BG,
                TextColor3 = COLORS.PRIMARY
            }
        ):Play()
    end)
    
    button.MouseButton1Down:Connect(function()
        TweenService:Create(
            button,
            TweenInfo.new(0.1),
            {BackgroundTransparency = 0.4}
        ):Play()
    end)
    
    button.MouseButton1Up:Connect(function()
        TweenService:Create(
            button,
            TweenInfo.new(0.1),
            {BackgroundTransparency = 0.1}
        ):Play()
    end)
    
    button.Activated:Connect(function()
        print("[Hardcore Panel] " .. text .. " button clicked!")
        if onClick then
            local success, err = pcall(onClick)
            if not success then
            end
        end
    end)
    
    return button
end

addFloorButton("Hotel", "Hotel", function()
    local Event = game:GetService("ReplicatedStorage").RemotesFolder.CreateElevator
    Event:FireServer({
        Mods = {
            "NoGuidingLight", "EntitiesMore", "ItemSpawnMore", "AmbushMore", "ScreechFast", "EyesLevel2", "AmbushFaster",
            "DupeMost", "BackdoorVacuum", "SnareMoster", "NoKeySound", "BackdoorRush", "Rooms", "GoldSpawnLess",
            "FigureFaster", "RushLevel2", "RushMore", "LockMore", "AdminPanel"
        },
        Settings = {},
        Destination = "Hotel",
        FriendsOnly = true,
        MaxPlayers = "20"
    })
end)

addFloorButton("Mines", "Mines", function()
    local Event = game:GetService("ReplicatedStorage").RemotesFolder.CreateElevator
    Event:FireServer({
        Mods = {
            "NoGuidingLight", "EntitiesMore", "AmbushMore", "ScreechFast", "AmbushFaster", "DupeMost", "BackdoorVacuum",
            "BackdoorLookman", "NoKeySound", "BackdoorRush", "Rooms", "GiggleSunglasses", "Fog", "GoldSpawnLess",
            "PlayerLessSlots", "FigureFaster", "RushMore", "AdminPanel"
        },
        Settings = {},
        Destination = "Mines",
        FriendsOnly = true,
        MaxPlayers = "20"
    })
end)

addFloorButton("OutDoors", "OutDoors", function()
    local Event = game:GetService("ReplicatedStorage").RemotesFolder.CreateElevator
    Event:FireServer({
        Mods = {
            "AmbushMore", "EntitiesMost", "ScreechFast", "AmbushFaster", "DupeMost", "RushFaster", "BackdoorLookman",
            "BackdoorRush", "Rooms", "GiggleSunglasses", "GoldSpawnLess", "PlayerLessSlots", "FigureFaster", "RushMore", "AdminPanel"
        },
        Settings = {},
        Destination = "Garden",
        FriendsOnly = true,
        MaxPlayers = "20"
    })
end)

addFloorButton("Rooms", "Rooms", function()
    local Event = game:GetService("ReplicatedStorage").RemotesFolder.CreateElevator
    Event:FireServer({
        Mods = {
            "NoGuidingLight", "AmbushMore", "EntitiesMost", "ScreechFast", "AmbushFaster", "RushFaster", "BackdoorLookman",
            "NoKeySound", "BackdoorRush", "Rooms", "GoldSpawnLess", "PlayerLessSlots", "FigureFaster", "AdminPanel"
        },
        Settings = {},
        Destination = "Rooms",
        FriendsOnly = true,
        MaxPlayers = "20"
    })
end)

addFloorButton("BackDoors", "BackDoors", function()
    local Event = game:GetService("ReplicatedStorage").RemotesFolder.CreateElevator
    Event:FireServer({
        Mods = {
            "AmbushMore", "EntitiesMost", "ScreechFast", "AmbushFaster", "DupeMost", "RushFaster", "BackdoorVacuum",
            "BackdoorLookman", "BackdoorRush", "Rooms", "GoldSpawnLess", "PlayerLessSlots", "FigureFaster", "AdminPanel"
        },
        Settings = {},
        Destination = "Backdoor",
        FriendsOnly = true,
        MaxPlayers = "20"
    })
end)

addFloorButton("RushMode", "Rush Mode", function()
    local Event = game:GetService("ReplicatedStorage").RemotesFolder.CreateElevator
    Event:FireServer({
        Mods = {
            "NoGuidingLight", "ItemSpawnMore", "AmbushMore", "EntitiesMost", "ScreechFast", "AmbushFaster", "DupeMost",
            "BackdoorVacuum", "NoKeySound", "BackdoorRush", "Rooms", "GoldSpawnLess", "FigureFaster", "RushMore", "AdminPanel"
        },
        Settings = {},
        Destination = "Fools26",
        FriendsOnly = true,
        MaxPlayers = "20"
    })
end)

addFloorButton("Halloween", "Halloween2025", function()
    local Event = game:GetService("ReplicatedStorage").RemotesFolder.CreateElevator
    Event:FireServer({
        Mods = {"AdminPanel"},
        Settings = {},
        Destination = "Halloween25",
        FriendsOnly = true,
        MaxPlayers = "20"
    })
end)

local function addDexButton(name, text, onClick)
    local button = Instance.new("TextButton")
    button.Name = name .. "Button"
    button.Size = UDim2.new(0.9, 0, 0, 40)
    button.BackgroundColor3 = COLORS.BUTTON_BG
    button.BackgroundTransparency = 0.1
    button.Text = text
    button.TextColor3 = COLORS.PRIMARY
    button.TextScaled = true
    button.Font = Enum.Font.SciFi
    button.TextSize = 20
    button.Parent = DexScrollingFrame
    
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 6)
    uiCorner.Parent = button
    
    local uiStroke = Instance.new("UIStroke")
    uiStroke.Color = COLORS.PRIMARY
    uiStroke.Thickness = 2
    uiStroke.Parent = button
    
    button.MouseEnter:Connect(function()
        TweenService:Create(
            button,
            TweenInfo.new(0.2),
            {
                BackgroundColor3 = COLORS.BUTTON_HOVER,
                TextColor3 = COLORS.SECONDARY
            }
        ):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(
            button,
            TweenInfo.new(0.2),
            {
                BackgroundColor3 = COLORS.BUTTON_BG,
                TextColor3 = COLORS.PRIMARY
            }
        ):Play()
    end)
    
    button.MouseButton1Down:Connect(function()
        TweenService:Create(
            button,
            TweenInfo.new(0.1),
            {BackgroundTransparency = 0.4}
        ):Play()
    end)
    
    button.MouseButton1Up:Connect(function()
        TweenService:Create(
            button,
            TweenInfo.new(0.1),
            {BackgroundTransparency = 0.1}
        ):Play()
    end)
    
    button.Activated:Connect(function()
        print("[Hardcore Panel] " .. text .. " button clicked!")
        if onClick then
            local success, err = pcall(onClick)
            if not success then
                warn("[Hardcore Panel] 执行失败: " .. tostring(err))
            end
        end
    end)
    
    return button
end

-- 添加Dex工具按钮
addDexButton("HardcoreDex", "Hardcore DEX", function()
    HardcoreDex = loadstring(game:HttpGet("https://github.com/AZYsGithub/DexPlusPlus/releases/latest/download/out.lua"))()
end)

-- 添加Cobalt监控工具按钮
addDexButton("Cobalt", "Cobalt", function()
    local url = "https://raw.githubusercontent.com/Zero0Star/RipperMPSound/master/CobaltSpy.lua"
    loadstring(game:HttpGet(url))()
end)

local function addMonsterButton(name, text, onClick)
    local button = Instance.new("TextButton")
    button.Name = name .. "Button"
    button.Size = UDim2.new(0.9, 0, 0, 40)
    button.BackgroundColor3 = COLORS.BUTTON_BG
    button.BackgroundTransparency = 0.1
    button.Text = text
    button.TextColor3 = COLORS.PRIMARY
    button.TextScaled = true
    button.Font = Enum.Font.SciFi
    button.TextSize = 20
    button.Parent = MonsterScrollingFrame
    
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 6)
    uiCorner.Parent = button
    
    local uiStroke = Instance.new("UIStroke")
    uiStroke.Color = COLORS.PRIMARY
    uiStroke.Thickness = 2
    uiStroke.Parent = button
    
    button.MouseEnter:Connect(function()
        TweenService:Create(
            button,
            TweenInfo.new(0.2),
            {
                BackgroundColor3 = COLORS.BUTTON_HOVER,
                TextColor3 = COLORS.SECONDARY
            }
        ):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(
            button,
            TweenInfo.new(0.2),
            {
                BackgroundColor3 = COLORS.BUTTON_BG,
                TextColor3 = COLORS.PRIMARY
            }
        ):Play()
    end)
    
    button.MouseButton1Down:Connect(function()
        TweenService:Create(
            button,
            TweenInfo.new(0.1),
            {BackgroundTransparency = 0.4}
        ):Play()
    end)
    
    button.MouseButton1Up:Connect(function()
        TweenService:Create(
            button,
            TweenInfo.new(0.1),
            {BackgroundTransparency = 0.1}
        ):Play()
    end)
    
    button.Activated:Connect(function()
        print("[Hardcore Panel] " .. text .. " button clicked!")
        if onClick then
            local success, err = pcall(onClick)
            if not success then
                warn("[Hardcore Panel] 执行失败: " .. tostring(err))
            end
        end
    end)
    
    return button
end

addMonsterButton("Groundskeeper", "Groundskeeper", function()
    local Event = game:GetService("ReplicatedStorage").RemotesFolder.AdminPanelRunCommand
    Event:FireServer(
        "Groundskeeper",
        {}
    )
end)

addMonsterButton("Surge", "Surge", function()
    local Event = game:GetService("ReplicatedStorage").RemotesFolder.AdminPanelRunCommand
    Event:FireServer(
        "Surge",
        {}
    )
end)

addMonsterButton("Bramble", "Bramble", function()
    local Event = game:GetService("ReplicatedStorage").RemotesFolder.AdminPanelRunCommand
    Event:FireServer(
        "Bramble",
        {}
    )
end)
addMonsterButton("Shocker", "Shocker", function()
    local Players = game:GetService("Players")
    local Workspace = game:GetService("Workspace")
    local TweenService = game:GetService("TweenService")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")

    local player = Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")

    local function spawnShocker()
        local shockerModel = game:GetObjects("rbxassetid://101816407601314")[1]
        local camera = Workspace.CurrentCamera

        local rootPart = shockerModel:FindFirstChild("HumanoidRootPart") or shockerModel:FindFirstChildWhichIsA("Part")
        shockerModel.PrimaryPart = rootPart
        shockerModel:SetPrimaryPartCFrame(camera.CFrame * CFrame.new(0, 0, -7))
        shockerModel.Parent = Workspace
        local oogaBoogaaPart = shockerModel:WaitForChild("OOGA BOOGAAAA")
        local horrorScream = oogaBoogaaPart:WaitForChild("HORROR SCREAM 15")
        local boneSound = oogaBoogaaPart:FindFirstChild("Bone")
        local lookDuration = 2
        local lookStart = nil
        local hasTriggered = false
        local hasFallen = false
        local function fallToGround()
            if hasFallen then return end
            hasFallen = true
            oogaBoogaaPart.Anchored = false
            oogaBoogaaPart.CanCollide = false
            task.delay(2, function()
                if shockerModel then
                    shockerModel:Destroy()
                end
            end)
        end
        local connection
        connection = game:GetService("RunService").RenderStepped:Connect(function()
            if not character or not character:FindFirstChild("HumanoidRootPart") then return end
            if hasTriggered then connection:Disconnect() return end
            local directionToShocker = (oogaBoogaaPart.Position - camera.CFrame.Position).Unit
            local playerLookVector = camera.CFrame.LookVector
            local dot = directionToShocker:Dot(playerLookVector)
            if dot > 0.85 then
                if not lookStart then
                    lookStart = tick()
                elseif tick() - lookStart >= lookDuration then
                    hasTriggered = true
                    connection:Disconnect()
                    horrorScream:Play()
                    if boneSound then boneSound:Play() end
                    humanoid:TakeDamage(30)
                    local targetPos = character.HumanoidRootPart.Position + Vector3.new(0, 2, 0)
                    local tweenInfo = TweenInfo.new(1.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
                    local tween = TweenService:Create(oogaBoogaaPart, tweenInfo, {Position = targetPos})
                    tween:Play()

                    tween.Completed:Connect(function()
                        fallToGround()
                    end)

                    ReplicatedStorage.GameStats["Player_".. player.Name].Total.DeathCause.Value = "Shocker"
                    firesignal(ReplicatedStorage.RemotesFolder.DeathHint.OnClientEvent, {
                        "You died to who you call Shocker...",
                        "Don't look at it or it stuns you!"
                    }, "Blue")
                end
            else
                connection:Disconnect()
                fallToGround()
            end
        end)

        task.delay(5, function()
            if not hasTriggered and not hasFallen then
                fallToGround()
            end
        end)
    end
    spawnShocker()
end)

addMonsterButton("Ripper", "Ripper", function()
    function GitAud(soundgit, filename)
        local url = soundgit
        local fileName = filename or "temp_audio"
        local fullFileName = fileName .. ".mp3"
        local success, audioData = pcall(function()
            return game:HttpGet(url)
        end)
        if not success then
            return nil
        end
        local writeSuccess, writeError = pcall(function()
            writefile(fullFileName, audioData)
        end)
        if not writeSuccess then
            return nil
        end
        local assetPath
        if getsynasset then
            assetPath = getsynasset(fullFileName)
        elseif getcustomasset then
            assetPath = getcustomasset(fullFileName)
        else
            warn("[GitAud] 当前环境不支持 getcustomasset 或 getsynasset")
            return nil
        end
        return assetPath
    end
    function CustomGitSound(soundlink, vol, filename)
        local sound = Instance.new("Sound")
        sound.SoundId = GitAud(soundlink, filename)
        if not sound.SoundId then
            return
        end
        sound.Parent = workspace
        sound.Name = filename or "GitHub_Music"
        sound.Volume = vol or 1
        sound.Loaded:Wait()
        sound:Play()
        sound.Ended:Connect(function()
            sound:Destroy()
        end)
    end
    local githubAudioUrl = "https://github.com/Zero0Star/RipperMPSound/blob/master/RipperNewSound.mp3?raw=true"
    local volume = 2
    local saveName = "RipperSound"
    CustomGitSound(githubAudioUrl, volume, saveName)
    local TweenService = game:GetService("TweenService")
    local targetColor = Color3.fromRGB(255, 93, 93)
    local fadeDuration = 1
    local fadeInfo = TweenInfo.new(
        fadeDuration,
        Enum.EasingStyle.Linear,
        Enum.EasingDirection.Out
    )
    local function createFadeTween(object)
        if object:IsA("BasePart") or object:IsA("Light") then
            local tween = TweenService:Create(object, fadeInfo, {Color = targetColor})
            tween:Play()
            return tween
        end
        return nil
    end
    local function modifyObjectsWithTween()
        local allTweens = {}
        for _, room in pairs(workspace.CurrentRooms:GetChildren()) do
            if room:IsA("Model") then
                local assets = room:FindFirstChild("Assets")
                if assets then
                    for _, chandelier in pairs(assets:GetChildren()) do
                        if chandelier:IsA("Model") and chandelier.Name == "Chandelier" then
                            local lightFixture = chandelier:FindFirstChild("LightFixture")
                            if lightFixture then
                                local pointLight = lightFixture:FindFirstChild("PointLight")
                                if pointLight and pointLight:IsA("PointLight") then
                                    table.insert(allTweens, createFadeTween(pointLight))
                                end
                                
                                local spotLight = lightFixture:FindFirstChild("SpotLight")
                                if spotLight and spotLight:IsA("SpotLight") then
                                    table.insert(allTweens, createFadeTween(spotLight))
                                end
                                
                                local neon = lightFixture:FindFirstChild("Neon")
                                if neon and neon:IsA("BasePart") then
                                    table.insert(allTweens, createFadeTween(neon))
                                end
                            end
                        end
                    end
                    
                    local lightFixtures = assets:FindFirstChild("Light_Fixtures")
                    if lightFixtures then
                        for _, lightStand in pairs(lightFixtures:GetChildren()) do
                            if lightStand:IsA("Model") and lightStand.Name == "LightStand" then
                                local lightFixture = lightStand:FindFirstChild("LightFixture")
                                if lightFixture then
                                    local pointLight = lightFixture:FindFirstChild("PointLight")
                                    if pointLight and pointLight:IsA("PointLight") then
                                        table.insert(allTweens, createFadeTween(pointLight))
                                    end
                                    
                                    local neon = lightFixture:FindFirstChild("Neon")
                                    if neon and neon:IsA("BasePart") then
                                        table.insert(allTweens, createFadeTween(neon))
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    coroutine.wrap(function()
        modifyObjectsWithTween()
    end)()

    local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()
    local entity = spawner.Create({
        Entity = {
            Name = "Ripper",
            Asset = "90276221585032",
            HeightOffset = 6
        },
        Lights = {
            Flicker = {
                Enabled = false,
                Duration = 10
            },
            Shatter = false,
            Repair = false
        },
        Earthquake = {
            Enabled = false
        },
        CameraShake = {
            Enabled = true,
            Range = 200,
            Values = {10, 50, 0.1, 1}
        },
        Movement = {
            Speed = 180,
            Delay = 7,
            Reversed = false
        },
        Rebounding = {
            Enabled = false,
            Type = "ambush",
            Min = 4,
            Max = 4,
            Delay = math.random(10, 30) / 10
        },
        Damage = {
            Enabled = true,
            Range = 100,
            Amount = 1
        },
        Crucifixion = {
            Enabled = true,
            Range = 100,
            Resist = false,
            Break = true
        },
        Death = {
            Type = "Guiding",
            Hints = {"你死于Ripper", "它会吼叫以示它的存在", "这么做时立刻躲起来!", "他会巡查所有未躲藏之处"},
            Cause = ""
        }
    })

    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")

    local SHAKE_INTENSITY = 0.4
    local SHAKE_DURATION = 5
    local SHAKE_SPEED = 70

    local player = Players.LocalPlayer
    if not player then return end

    local camera = workspace.CurrentCamera
    local startTime = tick()
    local originalPosition = camera.CFrame.Position
    local connection

    connection = RunService.RenderStepped:Connect(function()
        local elapsed = tick() - startTime
        
        if elapsed < SHAKE_DURATION then
            local decay = 1 - (elapsed / SHAKE_DURATION)
            local intensity = SHAKE_INTENSITY * decay

            local time = elapsed * SHAKE_SPEED
            local offset = Vector3.new(
                math.sin(time * 1.1) * intensity * 0.5 + math.random(-intensity, intensity) * 0.3,
                math.cos(time * 0.9) * intensity * 0.5 + math.random(-intensity, intensity) * 0.3,
                math.sin(time * 1.0) * intensity * 0.3
            )

            local lookVector = camera.CFrame.LookVector
            local upVector = camera.CFrame.UpVector
            local rightVector = camera.CFrame.RightVector

            local currentPos = camera.CFrame.Position
            local newPos = currentPos + offset
            
            camera.CFrame = CFrame.new(newPos, newPos + lookVector) * CFrame.Angles(0, 0, 0)
        else
            if connection then
                connection:Disconnect()
            end
        end
    end)

    entity:SetCallback("OnRebounding", function(startOfRebound)
        local entityModel = entity.Model
        local main = entityModel:WaitForChild("Main")
        local attachment = main:WaitForChild("Attachment")
        local AttachmentSwitch = main:WaitForChild("AttachmentSwitch")
        local sounds = {
            footsteps = main:WaitForChild("Footsteps"),
            playSound = main:WaitForChild("PlaySound"),
            switch = main:WaitForChild("Switch"),
            switchBack = main:WaitForChild("SwitchBack")
        }

        for _, c in attachment:GetChildren() do
            c.Enabled = (not startOfRebound)
        end
        for _, c in AttachmentSwitch:GetChildren() do
            c.Enabled = startOfRebound
        end

        if startOfRebound == true then
            sounds.footsteps.PlaybackSpeed = 0.35
            sounds.playSound.PlaybackSpeed = 0.25
            sounds.switch:Play()
        else
            sounds.footsteps.PlaybackSpeed = 0.25
            sounds.playSound.PlaybackSpeed = 0.16
            sounds.switchBack:Play()
        end
        
    end)
    local function playSoundOnRipperRemoved()
        local ripper = workspace:FindFirstChild("Ripper")
        
        if not ripper then
            wait(3)
            ripper = workspace:FindFirstChild("Ripper")
            
            if not ripper then
                return
            end
        end
        
        local connection
        connection = workspace.ChildRemoved:Connect(function(child)
            if child and child.Name == "Ripper" then
                if connection then
                    connection:Disconnect()
                end
                
                local sound = Instance.new("Sound")
                sound.SoundId = "rbxassetid://1837829565"
                sound.Volume = 2
                sound.Looped = false
                sound.Parent = workspace
                
                wait(0.2)
                
                if sound.IsLoaded then
                    sound.Playing = true
                    
                    local endedConnection
                    endedConnection = sound.Ended:Connect(function()
                        if endedConnection then
                            endedConnection:Disconnect()
                        end
                        sound:Destroy()
                    end)
                    
                    delay(10, function()
                        if sound and sound.Parent then
                            sound:Destroy()
                        end
                    end)
                else
                    sound:Destroy()
                end
            end
        end)
        
        delay(30, function()
            if connection and connection.Connected then
                connection:Disconnect()
            end
        end)
    end
    delay(2, function()
        playSoundOnRipperRemoved()
    end)
    entity:Run()
end)

addMonsterButton("Rebound", "Rebound", function()
    function GitAud(soundgit, filename)
        local url = soundgit
        local fileName = filename or "temp_audio"
        local fullFileName = fileName .. ".mp3"
        local success, audioData = pcall(function()
            return game:HttpGet(url)
        end)
        if not success then
            return nil
        end
        local writeSuccess, writeError = pcall(function()
            writefile(fullFileName, audioData)
        end)
        if not writeSuccess then
            return nil
        end
        local assetPath
        if getsynasset then
            assetPath = getsynasset(fullFileName)
        elseif getcustomasset then
            assetPath = getcustomasset(fullFileName)
        else
            return nil
        end
        return assetPath
    end
    function CustomGitSound(soundlink, vol, filename)
        local sound = Instance.new("Sound")
        sound.SoundId = GitAud(soundlink, filename)
        if not sound.SoundId then
            return
        end
        sound.Parent = workspace
        sound.Name = filename or "GitHub_Music"
        sound.Volume = vol or 1
        sound.Loaded:Wait()
        sound:Play()
        sound.Ended:Connect(function()
            sound:Destroy()
        end)
    end
    local githubAudioUrl = "https://github.com/Zero0Star/RipperMPSound/blob/master/ReboundSoundV1.mp3?raw=true"
    local volume = 2
    local saveName = "ReboundSweep"
    CustomGitSound(githubAudioUrl, volume, saveName)
    local part = Instance.new("Part")
    part.Name = "Bound"
    part.Parent = workspace
    game.Lighting.MainColorCorrection.TintColor = Color3.fromRGB(61, 171, 98)
    game.Lighting.MainColorCorrection.Contrast = 0.2
    game.Lighting.MainColorCorrection.Saturation = -0.7
    local tween = game:GetService("TweenService")
    tween:Create(game.Lighting.MainColorCorrection, TweenInfo.new(5), {Contrast = 0}):Play()
    tween:Create(game.Lighting.MainColorCorrection, TweenInfo.new(5), {Saturation = 0}):Play()
    local TW = tween:Create(game.Lighting.MainColorCorrection, TweenInfo.new(5), {TintColor = Color3.fromRGB(255, 255, 255)})
    TW:Play()
    local CameraShaker = require(game.ReplicatedStorage.CameraShaker)
    local camara = game.Workspace.CurrentCamera
    local camShake = CameraShaker.new(Enum.RenderPriority.Camera.Value, function(shakeCf)
        camara.CFrame = camara.CFrame * shakeCf
    end)
    camShake:Start()
    camShake:ShakeOnce(10, 3, 0.1, 6, 2, 0.5)
    local speed = math.random(350, 1050)
    local delay = {"2", "2.5", "1.5", "1", "2.1"}
    local randomDelay = delay[math.random(1, #delay)]
    wait(3)
    local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()
    local entity = spawner.Create({
        Entity = {Name = "Rebound", Asset = "102940663292742", HeightOffset = 3},
        Lights = {Flicker = {Enabled = false, Duration = 10}, Shatter = false, Repair = false},
        Earthquake = {Enabled = false},
        CameraShake = {Enabled = true, Range = 200, Values = {1.5, 20, 0.1, 1}},
        Movement = {Speed = 100, Delay = 5, Reversed = true},
        Rebounding = {Enabled = false, Type = "ambush", Min = 4, Max = 4, Delay = math.random(10, 30) / 10},
        Damage = {Enabled = true, Range = 100, Amount = 1},
        Crucifixion = {Enabled = true, Range = 100, Resist = false, Break = true},
        Death = {Type = "Guiding", Hints = {"你死于Rebound", "巨大的噪音震耳欲聋", "保持时刻警惕它的存在", "祝你好运"}, Cause = ""}
    })
    function GitAud(soundgit, filename)
        local url = soundgit
        local fileName = filename or "temp_audio"
        local fullFileName = fileName .. ".mp3"
        local success, audioData = pcall(function()
            return game:HttpGet(url)
        end)
        if not success then
            return nil
        end
        local writeSuccess, writeError = pcall(function()
            writefile(fullFileName, audioData)
        end)
        if not writeSuccess then
            return nil
        end
        local assetPath
        if getsynasset then
            assetPath = getsynasset(fullFileName)
        elseif getcustomasset then
            assetPath = getcustomasset(fullFileName)
        else
            return nil
        end
        return assetPath
    end
    function CustomGitSound(soundlink, vol, filename)
        local sound = Instance.new("Sound")
        sound.SoundId = GitAud(soundlink, filename)
        if not sound.SoundId then
            return
        end
        sound.Parent = workspace
        sound.Name = filename or "GitHub_Music"
        sound.Volume = vol or 1
        sound.Loaded:Wait()
        sound:Play()
        sound.Ended:Connect(function()
            sound:Destroy()
        end)
    end
    local githubAudioUrl = "https://github.com/Zero0Star/RipperMPSound/blob/master/ReboundMovings.mp3?raw=true"
    local volume = 8
    local saveName = "ReboundMovings"
    CustomGitSound(githubAudioUrl, volume, saveName)
    entity:SetCallback("OnRebounding", function(startOfRebound)
        local entityModel = entity.Model
        local main = entityModel:WaitForChild("Main")
        local attachment = main:WaitForChild("Attachment")
        local AttachmentSwitch = main:WaitForChild("AttachmentSwitch")
        local sounds = {
            footsteps = main:WaitForChild("Footsteps"),
            playSound = main:WaitForChild("PlaySound"),
            switch = main:WaitForChild("Switch"),
            switchBack = main:WaitForChild("SwitchBack")
        }
        for _, c in attachment:GetChildren() do
            c.Enabled = (not startOfRebound)
        end
        for _, c in AttachmentSwitch:GetChildren() do
            c.Enabled = startOfRebound
        end
        if startOfRebound == true then
            sounds.footsteps.PlaybackSpeed = 0.35
            sounds.playSound.PlaybackSpeed = 0.25
            sounds.switch:Play()
        else
            sounds.footsteps.PlaybackSpeed = 0.25
            sounds.playSound.PlaybackSpeed = 0.16
            sounds.switchBack:Play()
        end
    end)
    entity:Run()
    game.ReplicatedStorage.GameData.LatestRoom.Changed:Wait()
    local CameraShaker = require(game.ReplicatedStorage.CameraShaker)
    local camara = game.Workspace.CurrentCamera
    local camShake = CameraShaker.new(Enum.RenderPriority.Camera.Value, function(shakeCf)
        camara.CFrame = camara.CFrame * shakeCf
    end)
    camShake:Start()
    camShake:ShakeOnce(10, 3, 0.1, 6, 2, 0.5)
    local speed = math.random(350, 1050)
    local delay = {"2", "2.5", "1.5", "1", "2.1"}
    local randomDelay = delay[math.random(1, #delay)]
    local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()
    local entity = spawner.Create({
        Entity = {Name = "Rebound", Asset = "102940663292742", HeightOffset = 3},
        Lights = {Flicker = {Enabled = false, Duration = 10}, Shatter = false, Repair = false},
        Earthquake = {Enabled = false},
        CameraShake = {Enabled = true, Range = 200, Values = {1.5, 20, 0.1, 1}},
        Movement = {Speed = 100, Delay = 5, Reversed = false},
        Rebounding = {Enabled = false, Type = "ambush", Min = 4, Max = 4, Delay = math.random(10, 30) / 10},
        Damage = {Enabled = true, Range = 100, Amount = 1},
        Crucifixion = {Enabled = true, Range = 100, Resist = false, Break = true},
        Death = {Type = "Guiding", Hints = {"你死于Rebound", "巨大的噪音震耳欲聋", "保持时刻警惕它的存在", "祝你好运"}, Cause = ""}
    })
    function GitAud(soundgit, filename)
        local url = soundgit
        local fileName = filename or "temp_audio"
        local fullFileName = fileName .. ".mp3"
        local success, audioData = pcall(function()
            return game:HttpGet(url)
        end)
        if not success then
            return nil
        end
        local writeSuccess, writeError = pcall(function()
            writefile(fullFileName, audioData)
        end)
        if not writeSuccess then
            return nil
        end
        local assetPath
        if getsynasset then
            assetPath = getsynasset(fullFileName)
        elseif getcustomasset then
            assetPath = getcustomasset(fullFileName)
        else
            return nil
        end
        return assetPath
    end
    function CustomGitSound(soundlink, vol, filename)
        local sound = Instance.new("Sound")
        sound.SoundId = GitAud(soundlink, filename)
        if not sound.SoundId then
            return
        end
        sound.Parent = workspace
        sound.Name = filename or "GitHub_Music"
        sound.Volume = vol or 1
        sound.Loaded:Wait()
        sound:Play()
        sound.Ended:Connect(function()
            sound:Destroy()
        end)
    end
    local githubAudioUrl = "https://github.com/Zero0Star/RipperMPSound/blob/master/ReboundMovings.mp3?raw=true"
    local volume = 8
    local saveName = "ReboundMovings"
    CustomGitSound(githubAudioUrl, volume, saveName)
    entity:SetCallback("OnRebounding", function(startOfRebound)
        local entityModel = entity.Model
        local main = entityModel:WaitForChild("Main")
        local attachment = main:WaitForChild("Attachment")
        local AttachmentSwitch = main:WaitForChild("AttachmentSwitch")
        local sounds = {
            footsteps = main:WaitForChild("Footsteps"),
            playSound = main:WaitForChild("PlaySound"),
            switch = main:WaitForChild("Switch"),
            switchBack = main:WaitForChild("SwitchBack")
        }
        for _, c in attachment:GetChildren() do
            c.Enabled = (not startOfRebound)
        end
        for _, c in AttachmentSwitch:GetChildren() do
            c.Enabled = startOfRebound
        end
        if startOfRebound == true then
            sounds.footsteps.PlaybackSpeed = 0.35
            sounds.playSound.PlaybackSpeed = 0.25
            sounds.switch:Play()
        else
            sounds.footsteps.PlaybackSpeed = 0.25
            sounds.playSound.PlaybackSpeed = 0.16
            sounds.switchBack:Play()
        end
    end)
    entity:Run()
    game.ReplicatedStorage.GameData.LatestRoom.Changed:Wait()
    local CameraShaker = require(game.ReplicatedStorage.CameraShaker)
    local camara = game.Workspace.CurrentCamera
    local camShake = CameraShaker.new(Enum.RenderPriority.Camera.Value, function(shakeCf)
        camara.CFrame = camara.CFrame * shakeCf
    end)
    camShake:Start()
    camShake:ShakeOnce(10, 3, 0.1, 6, 2, 0.5)
    local speed = math.random(350, 1050)
    local delay = {"2", "2.5", "1.5", "1", "2.1"}
    local randomDelay = delay[math.random(1, #delay)]
    local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()
    local entity = spawner.Create({
        Entity = {Name = "Rebound", Asset = "102940663292742", HeightOffset = 3},
        Lights = {Flicker = {Enabled = false, Duration = 10}, Shatter = false, Repair = false},
        Earthquake = {Enabled = false},
        CameraShake = {Enabled = true, Range = 200, Values = {1.5, 20, 0.1, 1}},
        Movement = {Speed = 100, Delay = 5, Reversed = true},
        Rebounding = {Enabled = false, Type = "ambush", Min = 4, Max = 4, Delay = math.random(10, 30) / 10},
        Damage = {Enabled = true, Range = 100, Amount = 1},
        Crucifixion = {Enabled = true, Range = 100, Resist = false, Break = true},
        Death = {Type = "Guiding", Hints = {"你死于Rebound", "巨大的噪音震耳欲聋", "保持时刻警惕它的存在", "祝你好运"}, Cause = ""}
    })
    function GitAud(soundgit, filename)
        local url = soundgit
        local fileName = filename or "temp_audio"
        local fullFileName = fileName .. ".mp3"
        local success, audioData = pcall(function()
            return game:HttpGet(url)
        end)
        if not success then
            return nil
        end
        local writeSuccess, writeError = pcall(function()
            writefile(fullFileName, audioData)
        end)
        if not writeSuccess then
            return nil
        end
        local assetPath
        if getsynasset then
            assetPath = getsynasset(fullFileName)
        elseif getcustomasset then
            assetPath = getcustomasset(fullFileName)
        else
            return nil
        end
        return assetPath
    end
    function CustomGitSound(soundlink, vol, filename)
        local sound = Instance.new("Sound")
        sound.SoundId = GitAud(soundlink, filename)
        if not sound.SoundId then
            return
        end
        sound.Parent = workspace
        sound.Name = filename or "GitHub_Music"
        sound.Volume = vol or 1
        sound.Loaded:Wait()
        sound:Play()
        sound.Ended:Connect(function()
            sound:Destroy()
        end)
    end
    local githubAudioUrl = "https://github.com/Zero0Star/RipperMPSound/blob/master/ReboundMovings.mp3?raw=true"
    local volume = 8
    local saveName = "ReboundMovings"
    CustomGitSound(githubAudioUrl, volume, saveName)
    entity:SetCallback("OnRebounding", function(startOfRebound)
        local entityModel = entity.Model
        local main = entityModel:WaitForChild("Main")
        local attachment = main:WaitForChild("Attachment")
        local AttachmentSwitch = main:WaitForChild("AttachmentSwitch")
        local sounds = {
            footsteps = main:WaitForChild("Footsteps"),
            playSound = main:WaitForChild("PlaySound"),
            switch = main:WaitForChild("Switch"),
            switchBack = main:WaitForChild("SwitchBack")
        }
        for _, c in attachment:GetChildren() do
            c.Enabled = (not startOfRebound)
        end
        for _, c in AttachmentSwitch:GetChildren() do
            c.Enabled = startOfRebound
        end
        if startOfRebound == true then
            sounds.footsteps.PlaybackSpeed = 0.35
            sounds.playSound.PlaybackSpeed = 0.25
            sounds.switch:Play()
        else
            sounds.footsteps.PlaybackSpeed = 0.25
            sounds.playSound.PlaybackSpeed = 0.16
            sounds.switchBack:Play()
        end
    end)
    entity:Run()
    game.ReplicatedStorage.GameData.LatestRoom.Changed:Wait()
    local CameraShaker = require(game.ReplicatedStorage.CameraShaker)
    local camara = game.Workspace.CurrentCamera
    local camShake = CameraShaker.new(Enum.RenderPriority.Camera.Value, function(shakeCf)
        camara.CFrame = camara.CFrame * shakeCf
    end)
    camShake:Start()
    camShake:ShakeOnce(10, 3, 0.1, 6, 2, 0.5)
    local speed = math.random(350, 1050)
    local delay = {"2", "2.5", "1.5", "1", "2.1"}
    local randomDelay = delay[math.random(1, #delay)]
    local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()
    local entity = spawner.Create({
        Entity = {Name = "Rebound", Asset = "102940663292742", HeightOffset = 3},
        Lights = {Flicker = {Enabled = false, Duration = 10}, Shatter = false, Repair = false},
        Earthquake = {Enabled = false},
        CameraShake = {Enabled = true, Range = 200, Values = {1.5, 20, 0.1, 1}},
        Movement = {Speed = 100, Delay = 5, Reversed = false},
        Rebounding = {Enabled = false, Type = "ambush", Min = 4, Max = 4, Delay = math.random(10, 30) / 10},
        Damage = {Enabled = true, Range = 100, Amount = 1},
        Crucifixion = {Enabled = true, Range = 100, Resist = false, Break = true},
        Death = {Type = "Guiding", Hints = {"你死于Rebound", "巨大的噪音震耳欲聋", "保持时刻警惕它的存在", "祝你好运"}, Cause = ""}
    })
    function GitAud(soundgit, filename)
        local url = soundgit
        local fileName = filename or "temp_audio"
        local fullFileName = fileName .. ".mp3"
        local success, audioData = pcall(function()
            return game:HttpGet(url)
        end)
        if not success then
            return nil
        end
        local writeSuccess, writeError = pcall(function()
            writefile(fullFileName, audioData)
        end)
        if not writeSuccess then
            return nil
        end
        local assetPath
        if getsynasset then
            assetPath = getsynasset(fullFileName)
        elseif getcustomasset then
            assetPath = getcustomasset(fullFileName)
        else
            return nil
        end
        return assetPath
    end
    function CustomGitSound(soundlink, vol, filename)
        local sound = Instance.new("Sound")
        sound.SoundId = GitAud(soundlink, filename)
        if not sound.SoundId then
            return
        end
        sound.Parent = workspace
        sound.Name = filename or "GitHub_Music"
        sound.Volume = vol or 1
        sound.Loaded:Wait()
        sound:Play()
        sound.Ended:Connect(function()
            sound:Destroy()
        end)
    end
    local githubAudioUrl = "https://github.com/Zero0Star/RipperMPSound/blob/master/ReboundMovings.mp3?raw=true"
    local volume = 8
    local saveName = "ReboundMovings"
    CustomGitSound(githubAudioUrl, volume, saveName)
    entity:SetCallback("OnRebounding", function(startOfRebound)
        local entityModel = entity.Model
        local main = entityModel:WaitForChild("Main")
        local attachment = main:WaitForChild("Attachment")
        local AttachmentSwitch = main:WaitForChild("AttachmentSwitch")
        local sounds = {
            footsteps = main:WaitForChild("Footsteps"),
            playSound = main:WaitForChild("PlaySound"),
            switch = main:WaitForChild("Switch"),
            switchBack = main:WaitForChild("SwitchBack")
        }
        for _, c in attachment:GetChildren() do
            c.Enabled = (not startOfRebound)
        end
        for _, c in AttachmentSwitch:GetChildren() do
            c.Enabled = startOfRebound
        end
        if startOfRebound == true then
            sounds.footsteps.PlaybackSpeed = 0.35
            sounds.playSound.PlaybackSpeed = 0.25
            sounds.switch:Play()
        else
            sounds.footsteps.PlaybackSpeed = 0.25
            sounds.playSound.PlaybackSpeed = 0.16
            sounds.switchBack:Play()
        end
    end)
    entity:Run()
end)
addMonsterButton("DeerGod", "Deer God", function()
    local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()
    
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    
    local LocalPlayer = Players.LocalPlayer
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
    
    local entityModel
    local chaseConnection = nil
    local customSpeed = 20
    local activationRange = 75
    
    local entity = spawner.Create({
        Entity = {
            Name = "Deer god",
            Asset = "94961532857273",
            HeightOffset = -0.8
        },
        Lights = {
            Flicker = {
                Enabled = true,
                Duration = 50
            },
            Shatter = true,
            Repair = false
        },
        Earthquake = {
            Enabled = false
        },
        CameraShake = {
            Enabled = true,
            Range = 1500,
            Values = {0.5, 5, 0.1, 1}
        },
        Movement = {
            Speed = 20,
            Delay = 2,
            Reversed = false
        },
        Rebounding = {
            Enabled = false,
            Type = "Blitz",
            Min = 1,
            Max = math.random(1, 2),
            Delay = math.random(10, 30) / 10
        },
        Damage = {
            Enabled = true,
            Range = 10,
            Amount = 200
        },
        Crucifixion = {
            Enabled = true,
            Range = 40,
            Resist = true,
            Break = true
        },
        Death = {
            Type = "Curious",
            Hints = {
                "It seems you are so unfortunate...", 
                "You died by the Deer God", 
                "That powerful force will drag you into the abyss.",
                "The cross cannot guarantee your safety.",
                "See you next time."
            },
            Cause = ""
        }
    })
    
    ---====== 追击系统核心函数 ======---
    local function startChaseSystem()
        if not entityModel or not entityModel.PrimaryPart then
            return
        end
    
        if chaseConnection then
            chaseConnection:Disconnect()
            chaseConnection = nil
        end
    
        chaseConnection = RunService.Heartbeat:Connect(function(dt)
    
            if not entityModel 
                or not entityModel.PrimaryPart 
                or not HumanoidRootPart 
                or not HumanoidRootPart.Parent 
            then 
                return 
            end
            
            local pos = entityModel.PrimaryPart.Position
            local target = HumanoidRootPart.Position
            local distance = (target - pos).Magnitude
    
            if distance <= activationRange then
                local dir = (target - pos).Unit
                local moveVec = dir * customSpeed * dt
                local newCFrame = CFrame.new(pos + moveVec, target)
                entityModel:SetPrimaryPartCFrame(newCFrame)
            end
    
        end)
        
    end
    
    ---====== 实体回调 ======---
    entity:SetCallback("OnSpawned", function()
        entityModel = entity.Model

        if entityModel then
            if not entityModel.PrimaryPart then
                local primaryPart = entityModel:FindFirstChild("Main") or entityModel:FindFirstChildWhichIsA("BasePart")
                if primaryPart then
                    entityModel.PrimaryPart = primaryPart
                end
            end
        end
    
        startChaseSystem()
    end)
    
    entity:SetCallback("OnDespawning", function()
    
        if chaseConnection then
            chaseConnection:Disconnect()
            chaseConnection = nil
        end
    end)
    
    ---====== Debug entity ======---
    entity:SetCallback("OnDamagePlayer", function(newHealth)
        if newHealth == 0 then
    
            if chaseConnection then
                chaseConnection:Disconnect()
                chaseConnection = nil
            end
    
            if entityModel and entityModel.PrimaryPart then
                local currentPos = entityModel.PrimaryPart.Position
                local forwardDir = entityModel.PrimaryPart.CFrame.LookVector
                local targetPos = currentPos + forwardDir * 10
                
                entityModel:SetPrimaryPartCFrame(CFrame.new(currentPos, targetPos))
            end
        end
    end)
    
    entity:SetCallback("OnRebounding", function(startOfRebound)
        if not entityModel then return end
        
        local main = entityModel:FindFirstChild("Main")
        if not main then return end
        
        local attachment = main:WaitForChild("Attachment")
        local AttachmentSwitch = main:WaitForChild("AttachmentSwitch")
        local sounds = {
            footsteps = main:WaitForChild("Footsteps"),
            playSound = main:WaitForChild("PlaySound"),
            switch = main:WaitForChild("Switch"),
            switchBack = main:WaitForChild("SwitchBack")
        }
    
        for _, c in attachment:GetChildren() do
            c.Enabled = (not startOfRebound)
        end
        for _, c in AttachmentSwitch:GetChildren() do
            c.Enabled = startOfRebound
        end
    
        if startOfRebound == true then
            sounds.footsteps.PlaybackSpeed = 0.35
            sounds.playSound.PlaybackSpeed = 0.25
            sounds.switch:Play()
        else
            sounds.footsteps.PlaybackSpeed = 0.25
            sounds.playSound.PlaybackSpeed = 0.16
            sounds.switchBack:Play()
        end
    end)
    
    ---====== 运行实体 ======---
    entity:Run()
    
    function GitAud(soundgit, filename)
        local url = soundgit
        local FileName = filename
        writefile(FileName .. ".mp3", game:HttpGet(url))
    
        return (getcustomasset or getsynasset)(FileName .. ".mp3")
    end
    
    function CustomGitSound(soundlink, vol, filename)
        local sound = Instance.new("Sound")
        sound.SoundId = GitAud(soundlink, filename)
        sound.Parent = workspace
        sound.Name = filename or "Music"
        sound.Volume = vol or 1
        sound:Play()
    end
    
    local targetAudioUrl = "https://github.com/eoyoustme/rebouna/blob/main/HesBehindYouRUN.mp3?raw=true"
    local volume = 4
    local localFileName = "DeerGod"
    CustomGitSound(targetAudioUrl, volume, localFileName)
end)

addMonsterButton("Hatred", "!!HatRed!!", function()
    local Duration = 260 
    local FlickerAmount = 30 
    local LatestRoomValue = game.ReplicatedStorage.GameData.LatestRoom.Value 
    local LatestRoom = workspace.CurrentRooms[LatestRoomValue] 
    if LatestRoom then 
        require(game.ReplicatedStorage.ModulesClient.Module_Events).flicker(LatestRoom, Duration, FlickerAmount) 
    end 
    
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    
    local SHAKE_INTENSITY = 1 
    local SHAKE_DURATION = 260 
    local SHAKE_SPEED = 3 
    
    local player = Players.LocalPlayer
    if not player then return end
    
    local camera = workspace.CurrentCamera
    local startTime = tick()
    local originalPosition = camera.CFrame.Position
    local connection
    
    connection = RunService.RenderStepped:Connect(function()
        local elapsed = tick() - startTime
        
        if elapsed < SHAKE_DURATION then
            local decay = 1 - (elapsed / SHAKE_DURATION)
            local intensity = SHAKE_INTENSITY * decay
            local time = elapsed * SHAKE_SPEED
            local offset = Vector3.new(
                math.sin(time * 1.1) * intensity * 0.5 + math.random(-intensity, intensity) * 0.3,
                math.cos(time * 0.9) * intensity * 0.5 + math.random(-intensity, intensity) * 0.3,
                math.sin(time * 1.0) * intensity * 0.3
            )
            
            local lookVector = camera.CFrame.LookVector
            local upVector = camera.CFrame.UpVector
            local rightVector = camera.CFrame.RightVector
            
            local currentPos = camera.CFrame.Position
            local newPos = currentPos + offset
            
            camera.CFrame = CFrame.new(newPos, newPos + lookVector) * CFrame.Angles(0, 0, 0)
        else
            if connection then
                connection:Disconnect()
            end
        end
    end)
    
    function GitAud(soundgit, filename)
        local url = soundgit
        local FileName = filename
        writefile(FileName .. ".mp3", game:HttpGet(url))
        return (getcustomasset or getsynasset)(FileName .. ".mp3")
    end
    
    function CustomGitSound(soundlink, vol, filename)
        local sound = Instance.new("Sound")
        sound.SoundId = GitAud(soundlink, filename)
        sound.Parent = workspace
        sound.Name = filename or "Music"
        sound.Volume = vol or 1
        sound:Play()
    end
    
    local targetAudioUrl = "https://github.com/Zero0Star/RipperMPSound/blob/master/HatredBossMusic.mp3?raw=true"
    local volume = 0.8
    local localFileName = "Hatred"
    CustomGitSound(targetAudioUrl, volume, localFileName)
    
    require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("What is this?",true)
    
    local Workspace = game:GetService("Workspace")
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    
    local player = Players.LocalPlayer
    local character = player.Character
    local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
    
    if not humanoidRootPart then
        if character then
            humanoidRootPart = character:WaitForChild("HumanoidRootPart", 3)
        else
            character = player.CharacterAdded:Wait()
            humanoidRootPart = character:WaitForChild("HumanoidRootPart", 3)
        end
    end
    
    if not humanoidRootPart then return end
    
    local MODEL_ID = 128445565656639
    local START_DISTANCE = 120
    local STOP_DISTANCE = 15
    local APPROACH_DURATION = 20
    local HOVER_DURATION = 260
    
    local function createGlowingModel()
        local model = Instance.new("Model")
        model.Name = "MovingModel"
        
        local mainPart = Instance.new("Part")
        mainPart.Name = "Core"
        mainPart.Size = Vector3.new(5, 5, 5)
        mainPart.Shape = Enum.PartType.Ball
        mainPart.Color = Color3.fromRGB(0, 200, 255)
        mainPart.Material = Enum.Material.Neon
        mainPart.Transparency = 0.2
        mainPart.CanCollide = false
        mainPart.Anchored = true
        mainPart.Parent = model
        
        local pointLight = Instance.new("PointLight")
        pointLight.Color = Color3.fromRGB(100, 200, 255)
        pointLight.Range = 30
        pointLight.Brightness = 5
        pointLight.Parent = mainPart
        
        model.PrimaryPart = mainPart
        return model
    end
    
    local function loadModel()
        local success, result = pcall(function()
            local objects = game:GetObjects("rbxassetid://" .. tostring(MODEL_ID))
            if objects and #objects > 0 then
                return objects[1]:Clone()
            end
            return nil
        end)
        
        if success and result then
            return result
        end
        
        return createGlowingModel()
    end
    
    local function startAnimation()
        local model = loadModel()
        if not model then return end
        
        model.Name = "DistantModel"
        model.Parent = Workspace
        
        local primaryPart = model.PrimaryPart
        if not primaryPart then
            for _, part in ipairs(model:GetDescendants()) do
                if part:IsA("BasePart") then
                    model.PrimaryPart = part
                    primaryPart = part
                    break
                end
            end
        end
        
        if not primaryPart then
            model:Destroy()
            return
        end
        
        for _, part in ipairs(model:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
                part.Anchored = true
            end
        end
        
        local playerPos = humanoidRootPart.Position
        local playerCFrame = humanoidRootPart.CFrame
        local playerLook = playerCFrame.LookVector
        local startPos = playerPos + (playerLook * START_DISTANCE)
        startPos = startPos + Vector3.new(0, 10, 0)
        
        model:SetPrimaryPartCFrame(CFrame.new(startPos))
        
        local startTime = tick()
        local isMoving = true
        local isHovering = false
        local hoverStartTime = 0
        
        local connection
        
        connection = RunService.Heartbeat:Connect(function(delta)
            if not model or not model.Parent or not model:IsDescendantOf(Workspace) then
                if connection then
                    connection:Disconnect()
                end
                return
            end
            
            if not humanoidRootPart or not humanoidRootPart.Parent then
                if connection then
                    connection:Disconnect()
                end
                if model and model.Parent then
                    model:Destroy()
                end
                return
            end
            
            local currentTime = tick()
            local currentPlayerPos = humanoidRootPart.Position
            local playerLookDirection = humanoidRootPart.CFrame.LookVector
            
            if isMoving then
                local elapsed = currentTime - startTime
                local progress = math.min(elapsed / APPROACH_DURATION, 1)
                
                if progress >= 1 then
                    isMoving = false
                    isHovering = true
                    hoverStartTime = currentTime
                    return
                end
                
                local easedProgress = progress * progress
                local targetPos = currentPlayerPos + (playerLookDirection * STOP_DISTANCE) + Vector3.new(0, 3, 0)
                local currentPos = startPos:Lerp(targetPos, easedProgress)
                
                model:SetPrimaryPartCFrame(CFrame.new(currentPos))
                
                local lookDirection = (currentPlayerPos - currentPos)
                if lookDirection.Magnitude > 0.1 then
                    lookDirection = lookDirection.Unit
                    model:SetPrimaryPartCFrame(CFrame.new(currentPos, currentPos + lookDirection))
                end
            elseif isHovering then
                local hoverTime = currentTime - hoverStartTime
                if hoverTime >= HOVER_DURATION then
                    if model and model.Parent then
                        model:Destroy()
                    end
                    if connection then
                        connection:Disconnect()
                    end
                    return
                end
                
                local targetPos = currentPlayerPos + (playerLookDirection * STOP_DISTANCE) + Vector3.new(0, 3, 0)
                local currentPos = primaryPart.Position
                local smoothedPos = currentPos:Lerp(targetPos, 0.1)
                
                model:SetPrimaryPartCFrame(CFrame.new(smoothedPos))
                
                local lookDirection = (currentPlayerPos - smoothedPos)
                if lookDirection.Magnitude > 0.1 then
                    lookDirection = lookDirection.Unit
                    model:SetPrimaryPartCFrame(CFrame.new(smoothedPos, smoothedPos + lookDirection))
                end
            end
        end)
        
        return function()
            if connection then
                connection:Disconnect()
            end
            if model and model.Parent then
                model:Destroy()
            end
        end
    end
    
    task.wait(0.5)
    startAnimation()
    
    wait(20)
    require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("We meet again,little bug.",true)
    wait(4)
    require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("I hope you can learn a lesson this time.",true)
    wait(4)
    require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("Let's get started.",true)
    wait(1)
    
    local Players = game:GetService("Players")
    local TweenService = game:GetService("TweenService")
    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")
    local StarterGui = game:GetService("StarterGui")
    
    local player = Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")
    
    local GameState = {
        isRunning = false,
        currentPhase = 1,
        overlay = nil,
        gameUI = nil,
        target = nil,
        blueTarget = nil,
        blueTarget2 = nil,
        connections = {},
        originalMouseBehavior = nil,
        originalMouseIconEnabled = nil,
        originalInventoryVisible = true,
        inventoryFrame = nil
    }
    
    local function hideInventory()
        local inventoryPath = "MainUI/Settings/Inventory"
        local pathParts = string.split(inventoryPath, "/")
        local current = playerGui
        
        for _, partName in ipairs(pathParts) do
            if current then
                current = current:FindFirstChild(partName)
            end
        end
        
        if current and current:IsA("GuiObject") then
            GameState.inventoryFrame = current
            GameState.originalInventoryVisible = current.Visible
            current.Visible = false
        else
            local allFrames = playerGui:GetDescendants()
            for _, obj in ipairs(allFrames) do
                if obj:IsA("GuiObject") and (obj.Name == "Inventory" or string.find(obj.Name:lower(), "inventory")) then
                    GameState.inventoryFrame = obj
                    GameState.originalInventoryVisible = obj.Visible
                    obj.Visible = false
                    break
                end
            end
        end
    end
    
    local function restoreInventory()
        if GameState.inventoryFrame and GameState.inventoryFrame:IsA("GuiObject") then
            GameState.inventoryFrame.Visible = GameState.originalInventoryVisible
        end
        GameState.inventoryFrame = nil
        GameState.originalInventoryVisible = true
    end
    
    local function createOverlay()
        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "GameOverlay"
        screenGui.ResetOnSpawn = false
        screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
        screenGui.IgnoreGuiInset = true
        
        local overlay = Instance.new("Frame")
        overlay.Name = "BlackOverlay"
        overlay.Size = UDim2.new(1, 0, 1, 0)
        overlay.BackgroundColor3 = Color3.new(0, 0, 0)
        overlay.BackgroundTransparency = 1
        overlay.ZIndex = 100
        overlay.Parent = screenGui
        
        screenGui.Parent = playerGui
        return overlay
    end
    
    local function unlockMouse()
        GameState.originalMouseBehavior = UserInputService.MouseBehavior
        GameState.originalMouseIconEnabled = UserInputService.MouseIconEnabled
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default
        UserInputService.MouseIconEnabled = true
        task.wait(0.1)
    end
    
    local function restoreMouse()
        if GameState.originalMouseBehavior then
            UserInputService.MouseBehavior = GameState.originalMouseBehavior
        end
        if GameState.originalMouseIconEnabled ~= nil then
            UserInputService.MouseIconEnabled = GameState.originalMouseIconEnabled
        end
    end
    
    local function createGameUI()
        local gameGui = Instance.new("ScreenGui")
        gameGui.Name = "MiniGameUI"
        gameGui.ResetOnSpawn = false
        gameGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
        gameGui.IgnoreGuiInset = true
        
        local gameFrame = Instance.new("Frame")
        gameFrame.Name = "GameFrame"
        gameFrame.Size = UDim2.new(0.8, 0, 0.8, 0)
        gameFrame.Position = UDim2.new(0.1, 0, 0.1, 0)
        gameFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
        gameFrame.BackgroundTransparency = 0.1
        gameFrame.BorderSizePixel = 0
        gameFrame.ZIndex = 101
        gameFrame.Visible = false
        gameFrame.Parent = gameGui
        
        local mouseHint = Instance.new("TextLabel")
        mouseHint.Name = "MouseHint"
        mouseHint.Size = UDim2.new(0.8, 0, 0.08, 0)
        mouseHint.Position = UDim2.new(0.1, 0, 0.1, 0)
        mouseHint.BackgroundTransparency = 1
        mouseHint.TextColor3 = Color3.fromRGB(200, 200, 255)
        mouseHint.Text = "Click the RED target! Avoid BLUE targets!"
        mouseHint.TextSize = 18
        mouseHint.Font = Enum.Font.SourceSansBold
        mouseHint.TextWrapped = true
        mouseHint.ZIndex = 102
        mouseHint.Parent = gameFrame
        
        local phaseText = Instance.new("TextLabel")
        phaseText.Name = "PhaseText"
        phaseText.Size = UDim2.new(0.3, 0, 0.08, 0)
        phaseText.Position = UDim2.new(0.35, 0, 0, 0)
        phaseText.BackgroundTransparency = 1
        phaseText.TextColor3 = Color3.fromRGB(255, 200, 50)
        phaseText.Text = "Phase 1"
        phaseText.TextSize = 20
        phaseText.Font = Enum.Font.SciFi
        phaseText.ZIndex = 102
        phaseText.Parent = gameFrame
        
        local timerText = Instance.new("TextLabel")
        timerText.Name = "Timer"
        timerText.Size = UDim2.new(0.3, 0, 0.1, 0)
        timerText.Position = UDim2.new(0.35, 0, 0.05, 0)
        timerText.BackgroundTransparency = 1
        timerText.TextColor3 = Color3.new(1, 1, 1)
        timerText.TextScaled = true
        timerText.Font = Enum.Font.SciFi
        timerText.Text = "20"
        timerText.ZIndex = 102
        timerText.Parent = gameFrame
        
        local counterText = Instance.new("TextLabel")
        counterText.Name = "Counter"
        counterText.Size = UDim2.new(0.3, 0, 0.1, 0)
        counterText.Position = UDim2.new(0.35, 0, 0.85, 0)
        counterText.BackgroundTransparency = 1
        counterText.TextColor3 = Color3.new(1, 1, 1)
        counterText.TextScaled = true
        counterText.Font = Enum.Font.SciFi
        counterText.Text = "Clicks: 0/10"
        counterText.ZIndex = 102
        counterText.Parent = gameFrame
        
        local instructionText = Instance.new("TextLabel")
        instructionText.Name = "Instruction"
        instructionText.Size = UDim2.new(0.8, 0, 0.1, 0)
        instructionText.Position = UDim2.new(0.1, 0, 0.2, 0)
        instructionText.BackgroundTransparency = 1
        instructionText.TextColor3 = Color3.new(1, 1, 1)
        instructionText.TextScaled = true
        instructionText.Font = Enum.Font.SciFi
        instructionText.Text = "Click 10 times in 20 seconds!"
        instructionText.TextWrapped = true
        instructionText.ZIndex = 102
        instructionText.Parent = gameFrame
        
        local target = Instance.new("TextButton")
        target.Name = "RedTarget"
        target.Size = UDim2.new(0, 60, 0, 60)
        target.Position = UDim2.new(0.5, -30, 0.5, -30)
        target.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        target.BackgroundTransparency = 0.2
        target.BorderSizePixel = 0
        target.ZIndex = 103
        target.Text = ""
        target.AutoButtonColor = false
        target.Active = true
        target.Selectable = false
        target.Parent = gameFrame
        
        local targetCorner = Instance.new("UICorner")
        targetCorner.CornerRadius = UDim.new(1, 0)
        targetCorner.Parent = target
        
        local targetGlow = Instance.new("UIStroke")
        targetGlow.Color = Color3.fromRGB(255, 150, 150)
        targetGlow.Thickness = 3
        targetGlow.Parent = target
        
        local clickEffect = Instance.new("Frame")
        clickEffect.Name = "ClickEffect"
        clickEffect.Size = UDim2.new(1, 0, 1, 0)
        clickEffect.BackgroundColor3 = Color3.fromRGB(255, 255, 200)
        clickEffect.BackgroundTransparency = 0.8
        clickEffect.ZIndex = 104
        clickEffect.Visible = false
        local clickCorner = Instance.new("UICorner")
        clickCorner.CornerRadius = UDim.new(1, 0)
        clickCorner.Parent = clickEffect
        clickEffect.Parent = target
        
        local blueTarget = Instance.new("TextButton")
        blueTarget.Name = "BlueTarget1"
        blueTarget.Size = UDim2.new(0, 50, 0, 50)
        blueTarget.Position = UDim2.new(0.3, -25, 0.3, -25)
        blueTarget.BackgroundColor3 = Color3.fromRGB(50, 100, 255)
        blueTarget.BackgroundTransparency = 0.1
        blueTarget.BorderSizePixel = 0
        blueTarget.ZIndex = 103
        blueTarget.Text = ""
        blueTarget.AutoButtonColor = false
        blueTarget.Active = true
        blueTarget.Selectable = false
        blueTarget.Visible = false
        blueTarget.Parent = gameFrame
        
        local blueTargetCorner = Instance.new("UICorner")
        blueTargetCorner.CornerRadius = UDim.new(1, 0)
        blueTargetCorner.Parent = blueTarget
        
        local blueTargetGlow = Instance.new("UIStroke")
        blueTargetGlow.Color = Color3.fromRGB(100, 150, 255)
        blueTargetGlow.Thickness = 3
        blueTargetGlow.Parent = blueTarget
        
        local blueTarget2 = Instance.new("TextButton")
        blueTarget2.Name = "BlueTarget2"
        blueTarget2.Size = UDim2.new(0, 50, 0, 50)
        blueTarget2.Position = UDim2.new(0.7, -25, 0.7, -25)
        blueTarget2.BackgroundColor3 = Color3.fromRGB(50, 100, 255)
        blueTarget2.BackgroundTransparency = 0.1
        blueTarget2.BorderSizePixel = 0
        blueTarget2.ZIndex = 103
        blueTarget2.Text = ""
        blueTarget2.AutoButtonColor = false
        blueTarget2.Active = true
        blueTarget2.Selectable = false
        blueTarget2.Visible = false
        blueTarget2.Parent = gameFrame
        
        local blueTarget2Corner = Instance.new("UICorner")
        blueTarget2Corner.CornerRadius = UDim.new(1, 0)
        blueTarget2Corner.Parent = blueTarget2
        
        local blueTarget2Glow = Instance.new("UIStroke")
        blueTarget2Glow.Color = Color3.fromRGB(100, 150, 255)
        blueTarget2Glow.Thickness = 3
        blueTarget2Glow.Parent = blueTarget2
        
        return gameGui, gameFrame, target, blueTarget, blueTarget2, timerText, counterText, instructionText, mouseHint, phaseText
    end
    
    local function fadeIn(overlay)
        if overlay and overlay:IsA("Frame") then
            local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad)
            local goal = {BackgroundTransparency = 0.5}
            local tween = TweenService:Create(overlay, tweenInfo, goal)
            tween:Play()
            tween.Completed:Wait()
            return true
        end
        return false
    end
    
    local function fadeOut(overlay, gameUI)
        if overlay and overlay:IsA("Frame") and overlay.Parent then
            local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad)
            local goal = {BackgroundTransparency = 1}
            local tween = TweenService:Create(overlay, tweenInfo, goal)
            tween:Play()
            tween.Completed:Wait()
            overlay.Parent:Destroy()
        end
        if gameUI and gameUI:IsA("ScreenGui") and gameUI.Parent then
            gameUI:Destroy()
        end
        restoreInventory()
        restoreMouse()
        GameState.overlay = nil
        GameState.gameUI = nil
        GameState.target = nil
        GameState.blueTarget = nil
        GameState.blueTarget2 = nil
        GameState.isRunning = false
        GameState.currentPhase = 1
    end
    
    local function getSafeRandomPosition(parentFrame, targetSize)
        if not parentFrame or not targetSize then
            return UDim2.new(0.5, 0, 0.5, 0)
        end
        local parentAbsSize = parentFrame.AbsoluteSize
        local targetAbsSize = targetSize.AbsoluteSize
        
        if parentAbsSize.X <= 0 or parentAbsSize.Y <= 0 then
            return UDim2.new(0.5, 0, 0.5, 0)
        end
        
        local maxX = math.max(0, parentAbsSize.X - targetAbsSize.X)
        local maxY = math.max(0, parentAbsSize.Y - targetAbsSize.Y)
        
        if maxX <= 0 or maxY <= 0 then
            return UDim2.new(0.5, 0, 0.5, 0)
        end
        
        local x = math.random(0, maxX)
        local y = math.random(0, maxY)
        return UDim2.new(0, x, 0, y)
    end
    
    local function moveTarget(target, newPosition, duration)
        if not target or not newPosition then return end
        duration = duration or 0.3
        local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = TweenService:Create(target, tweenInfo, {Position = newPosition})
        tween:Play()
        return tween
    end
    
    local function showClickEffect(clickEffect, color)
        if not clickEffect then return end
        clickEffect.Visible = true
        clickEffect.BackgroundTransparency = 0.8
        if color then
            clickEffect.BackgroundColor3 = color
        end
        local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad)
        local tween = TweenService:Create(clickEffect, tweenInfo, { 
            BackgroundTransparency = 1, 
            Size = UDim2.new(1.5, 0, 1.5, 0) 
        })
        tween:Play()
        tween.Completed:Connect(function()
            clickEffect.Visible = false
            clickEffect.Size = UDim2.new(1, 0, 1, 0)
        end)
    end
    
    local function showPhaseTransition(instructionText, newPhase)
        if not instructionText then return end
        if newPhase == 2 then
            instructionText.Text = "PHASE 2 STARTING!"
            instructionText.TextColor3 = Color3.fromRGB(255, 200, 0)
            for i = 1, 3 do
                instructionText.TextTransparency = 0.3
                task.wait(0.2)
                instructionText.TextTransparency = 0
                task.wait(0.2)
            end
        elseif newPhase == 3 then
            instructionText.Text = "FINAL PHASE STARTING!"
            instructionText.TextColor3 = Color3.fromRGB(255, 100, 100)
            for i = 1, 3 do
                instructionText.TextTransparency = 0.3
                task.wait(0.2)
                instructionText.TextTransparency = 0
                task.wait(0.2)
            end
        end
    end
    
    local function startMiniGame(gameUI, gameFrame, target, blueTarget, blueTarget2, timerText, counterText, instructionText, mouseHint, phaseText)
        if not gameUI or not gameFrame or not target or not blueTarget or not blueTarget2 or not timerText or not counterText or not instructionText then
            return false
        end
        
        gameFrame.Visible = true
        
        task.delay(3, function()
            if mouseHint and mouseHint.Parent then
                mouseHint.Visible = false
            end
        end)
        
        local timeLeft = 20
        local currentClicks = 0
        local isGameOver = false
        local phaseStartTime = tick()
        local clickConnection, blueClickConnection1, blueClickConnection2, gameConnection
        
        local clickEffect = target:FindFirstChild("ClickEffect")
        
        local blueClickEffect1 = Instance.new("Frame")
        blueClickEffect1.Name = "ClickEffect"
        blueClickEffect1.Size = UDim2.new(1, 0, 1, 0)
        blueClickEffect1.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
        blueClickEffect1.BackgroundTransparency = 0.8
        blueClickEffect1.ZIndex = 104
        blueClickEffect1.Visible = false
        local blueCorner1 = Instance.new("UICorner")
        blueCorner1.CornerRadius = UDim.new(1, 0)
        blueCorner1.Parent = blueClickEffect1
        blueClickEffect1.Parent = blueTarget
        
        local blueClickEffect2 = Instance.new("Frame")
        blueClickEffect2.Name = "ClickEffect"
        blueClickEffect2.Size = UDim2.new(1, 0, 1, 0)
        blueClickEffect2.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
        blueClickEffect2.BackgroundTransparency = 0.8
        blueClickEffect2.ZIndex = 104
        blueClickEffect2.Visible = false
        local blueCorner2 = Instance.new("UICorner")
        blueCorner2.CornerRadius = UDim.new(1, 0)
        blueCorner2.Parent = blueClickEffect2
        blueClickEffect2.Parent = blueTarget2
        
        local function updateTimer()
            if timerText and timerText:IsA("TextLabel") then
                timerText.Text = tostring(math.floor(timeLeft))
                if timeLeft < 5 then
                    timerText.TextColor3 = Color3.fromRGB(255, 50, 50)
                else
                    timerText.TextColor3 = Color3.new(1, 1, 1)
                end
            end
        end
        
        local function updateCounter()
            if counterText and counterText:IsA("TextLabel") then
                if GameState.currentPhase == 1 then
                    counterText.Text = "Clicks: " .. currentClicks .. "/10"
                elseif GameState.currentPhase == 2 then
                    counterText.Text = "Clicks: " .. currentClicks .. "/15"
                else
                    counterText.Text = "Clicks: " .. currentClicks .. "/20"
                end
                
                if GameState.currentPhase == 1 and currentClicks >= 7 then
                    counterText.TextColor3 = Color3.fromRGB(50, 255, 50)
                elseif GameState.currentPhase == 2 and currentClicks >= 10 then
                    counterText.TextColor3 = Color3.fromRGB(50, 255, 50)
                elseif GameState.currentPhase == 3 and currentClicks >= 15 then
                    counterText.TextColor3 = Color3.fromRGB(50, 255, 50)
                else
                    counterText.TextColor3 = Color3.new(1, 1, 1)
                end
            end
        end
        
        local function updatePhase(phaseNum)
            GameState.currentPhase = phaseNum
            if phaseText and phaseText:IsA("TextLabel") then
                phaseText.Text = "Phase " .. phaseNum
                if phaseNum == 1 then
                    phaseText.TextColor3 = Color3.fromRGB(255, 200, 50)
                    instructionText.Text = "Click 10 times in 20 seconds!"
                    target.Visible = true
                    blueTarget.Visible = false
                    blueTarget2.Visible = false
                elseif phaseNum == 2 then
                    phaseText.TextColor3 = Color3.fromRGB(200, 50, 200)
                    instructionText.Text = "Avoid BLUE targets! Click RED only! 30s"
                    target.Visible = true
                    blueTarget.Visible = true
                    blueTarget2.Visible = false
                elseif phaseNum == 3 then
                    phaseText.TextColor3 = Color3.fromRGB(255, 50, 50)
                    instructionText.Text = "HARD MODE! 2 BLUE targets! 30s"
                    target.Visible = true
                    blueTarget.Visible = true
                    blueTarget2.Visible = true
                end
            end
        end
        
        local function randomMoveRedTarget()
            if isGameOver or not target or not gameFrame then return end
            local newPosition = getSafeRandomPosition(gameFrame, target)
            if GameState.currentPhase == 1 then
                moveTarget(target, newPosition, 0.3)
            elseif GameState.currentPhase == 2 then
                moveTarget(target, newPosition, 0.4)
            else
                moveTarget(target, newPosition, 0.2)
            end
        end
        
        local function randomMoveBlueTarget1()
            if isGameOver or not blueTarget or not gameFrame or GameState.currentPhase == 1 then return end
            local newPosition = getSafeRandomPosition(gameFrame, blueTarget)
            moveTarget(blueTarget, newPosition, 0.8)
        end
        
        local function randomMoveBlueTarget2()
            if isGameOver or not blueTarget2 or not gameFrame or GameState.currentPhase < 3 then return end
            local newPosition = getSafeRandomPosition(gameFrame, blueTarget2)
            moveTarget(blueTarget2, newPosition, 0.8)
        end
        
        local function startPhaseTwo()
            GameState.currentPhase = 2
            showPhaseTransition(instructionText, 2)
            timeLeft = 30
            phaseStartTime = tick()
            currentClicks = 0
            if timerText then
                timerText.TextColor3 = Color3.new(1, 1, 1)
            end
            updateCounter()
            updatePhase(2)
            target.Size = UDim2.new(0, 50, 0, 50)
            blueTarget.Size = UDim2.new(0, 50, 0, 50)
            target.Position = UDim2.new(0.3, -25, 0.3, -25)
            blueTarget.Position = UDim2.new(0.7, -25, 0.7, -25)
        end
        
        local function startPhaseThree()
            GameState.currentPhase = 3
            showPhaseTransition(instructionText, 3)
            timeLeft = 30
            phaseStartTime = tick()
            currentClicks = 0
            if timerText then
                timerText.TextColor3 = Color3.new(1, 1, 1)
            end
            updateCounter()
            updatePhase(3)
            target.Size = UDim2.new(0, 45, 0, 45)
            blueTarget.Size = UDim2.new(0, 45, 0, 45)
            blueTarget2.Size = UDim2.new(0, 45, 0, 45)
            target.Position = UDim2.new(0.5, -22.5, 0.5, -22.5)
            blueTarget.Position = UDim2.new(0.2, -22.5, 0.2, -22.5)
            blueTarget2.Position = UDim2.new(0.8, -22.5, 0.8, -22.5)
        end
        
        if target:IsA("TextButton") or target:IsA("ImageButton") then
            clickConnection = target.MouseButton1Click:Connect(function()
                if isGameOver then return end
                currentClicks = currentClicks + 1
                updateCounter()
                if clickEffect then
                    showClickEffect(clickEffect, Color3.fromRGB(255, 255, 200))
                end
                if GameState.currentPhase == 1 and currentClicks >= 10 then
                    startPhaseTwo()
                    return
                elseif GameState.currentPhase == 2 and currentClicks >= 15 then
                    startPhaseThree()
                    return
                elseif GameState.currentPhase == 3 and currentClicks >= 20 then
                    isGameOver = true
                    if instructionText and instructionText:IsA("TextLabel") then
                        instructionText.Text = "Game Complete! Victory!"
                        instructionText.TextColor3 = Color3.fromRGB(0, 255, 0)
                    end
                    task.wait(2)
                    require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("It looks like you've made progress.Congratulations.",true)
                    local workspace = game:GetService("Workspace")
                    local hatredMusic = workspace:FindFirstChild("HATREDMusic")
                    if hatredMusic then
                        hatredMusic:Destroy()
                    end
                    local distantModel = workspace:FindFirstChild("DistantModel")
                    if distantModel then
                        distantModel:Destroy()
                    end
                    return
                end
                randomMoveRedTarget()
            end)
        end
        
        if blueTarget:IsA("TextButton") or blueTarget:IsA("ImageButton") then
            blueClickConnection1 = blueTarget.MouseButton1Click:Connect(function()
                if isGameOver or GameState.currentPhase == 1 then return end
                timeLeft = timeLeft - 3
                if timeLeft < 0 then
                    timeLeft = 0
                end
                if instructionText and instructionText:IsA("TextLabel") then
                    instructionText.Text = "-3 SECONDS! Avoid BLUE!"
                    instructionText.TextColor3 = Color3.fromRGB(255, 50, 50)
                    task.delay(1, function()
                        if instructionText and instructionText.Parent then
                            if GameState.currentPhase == 2 then
                                instructionText.Text = "Avoid BLUE targets! Click RED only! 30s"
                            else
                                instructionText.Text = "HARD MODE! 2 BLUE targets! 30s"
                            end
                            instructionText.TextColor3 = Color3.new(1, 1, 1)
                        end
                    end)
                end
                if blueClickEffect1 then
                    showClickEffect(blueClickEffect1, Color3.fromRGB(255, 100, 100))
                end
                randomMoveBlueTarget1()
            end)
        end
        
        if blueTarget2:IsA("TextButton") or blueTarget2:IsA("ImageButton") then
            blueClickConnection2 = blueTarget2.MouseButton1Click:Connect(function()
                if isGameOver or GameState.currentPhase < 3 then return end
                timeLeft = timeLeft - 3
                if timeLeft < 0 then
                    timeLeft = 0
                end
                if instructionText and instructionText:IsA("TextLabel") then
                    instructionText.Text = "-3 SECONDS! Avoid BLUE!"
                    instructionText.TextColor3 = Color3.fromRGB(255, 50, 50)
                    task.delay(1, function()
                        if instructionText and instructionText.Parent then
                            instructionText.Text = "HARD MODE! 2 BLUE targets! 30s"
                            instructionText.TextColor3 = Color3.new(1, 1, 1)
                        end
                    end)
                end
                if blueClickEffect2 then
                    showClickEffect(blueClickEffect2, Color3.fromRGB(255, 100, 100))
                end
                randomMoveBlueTarget2()
            end)
        end
        
        updateTimer()
        updateCounter()
        updatePhase(1)
        target.Position = UDim2.new(0.5, -30, 0.5, -30)
        
        local lastRedMoveTime = tick()
        local lastBlue1MoveTime = tick()
        local lastBlue2MoveTime = tick()
        local redMoveCooldown = 0.8
        local blueMoveCooldown = 1.5
        
        gameConnection = RunService.Heartbeat:Connect(function(deltaTime)
            if isGameOver then
                if gameConnection then
                    gameConnection:Disconnect()
                end
                return
            end
            
            local currentTime = tick()
            if GameState.currentPhase == 1 then
                timeLeft = math.max(0, 20 - (currentTime - phaseStartTime))
            else
                timeLeft = math.max(0, 30 - (currentTime - phaseStartTime))
            end
            updateTimer()
            
            if currentTime - lastRedMoveTime >= redMoveCooldown then
                randomMoveRedTarget()
                lastRedMoveTime = currentTime
                if redMoveCooldown > 0.4 then
                    redMoveCooldown = redMoveCooldown - 0.005
                end
            end
            
            if GameState.currentPhase >= 2 and currentTime - lastBlue1MoveTime >= blueMoveCooldown then
                randomMoveBlueTarget1()
                lastBlue1MoveTime = currentTime
            end
            
            if GameState.currentPhase == 3 and currentTime - lastBlue2MoveTime >= blueMoveCooldown then
                randomMoveBlueTarget2()
                lastBlue2MoveTime = currentTime
            end
            
            if timeLeft <= 0 then
                isGameOver = true
                if instructionText and instructionText:IsA("TextLabel") then
                    if GameState.currentPhase == 1 then
                        instructionText.Text = "Time's up! Failed Phase 1!"
                    elseif GameState.currentPhase == 2 then
                        instructionText.Text = "Time's up! Failed Phase 2!"
                    else
                        instructionText.Text = "Time's up! Failed Final Phase!"
                    end
                    instructionText.TextColor3 = Color3.fromRGB(255, 50, 50)
                end
                
                if gameConnection then
                    gameConnection:Disconnect()
                end
                
                task.wait(2)
                require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("It seems you have lost to me once again.",true)
                task.wait(3)
                require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("Well then, how should I deal with you?",true)
                task.wait(3)
                require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("haha",true)
                task.wait(4)
                require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("I think I should do this",true)
                task.wait(3)
                game.Players.LocalPlayer:Kick("Your Loser")
            end
        end)
        
        table.insert(GameState.connections, clickConnection)
        table.insert(GameState.connections, blueClickConnection1)
        table.insert(GameState.connections, blueClickConnection2)
        table.insert(GameState.connections, gameConnection)
        
        while not isGameOver do
            task.wait(0.1)
        end
        
        if GameState.currentPhase == 3 and currentClicks >= 20 then
            task.wait(2)
        end
        return (GameState.currentPhase == 3 and currentClicks >= 20)
    end
    
    local function main()
        if GameState.isRunning then
            return false
        end
        GameState.isRunning = true
        hideInventory()
        unlockMouse()
        
        local overlay = createOverlay()
        GameState.overlay = overlay
        
        local gameUI, gameFrame, target, blueTarget, blueTarget2, timerText, counterText, instructionText, mouseHint, phaseText = createGameUI()
        GameState.gameUI = gameUI
        GameState.target = target
        GameState.blueTarget = blueTarget
        GameState.blueTarget2 = blueTarget2
        
        local fadeSuccess = fadeIn(overlay)
        if not fadeSuccess then
            GameState.isRunning = false
            restoreInventory()
            return false
        end
        task.wait(1)
        
        if gameUI and not gameUI.Parent then
            gameUI.Parent = playerGui
        end
        
        local success = false
        local successResult = pcall(function()
            success = startMiniGame(gameUI, gameFrame, target, blueTarget, blueTarget2, timerText, counterText, instructionText, mouseHint, phaseText)
        end)
        
        fadeOut(overlay, gameUI)
        return success
    end
    
    local function cleanup()
        for _, connection in ipairs(GameState.connections) do
            if connection then
                pcall(function() connection:Disconnect() end)
            end
        end
        GameState.connections = {}
        
        if GameState.overlay and GameState.overlay.Parent then
            pcall(function() GameState.overlay.Parent:Destroy() end)
        end
        
        if GameState.gameUI and GameState.gameUI.Parent then
            pcall(function() GameState.gameUI:Destroy() end)
        end
        
        restoreInventory()
        restoreMouse()
        GameState.isRunning = false
        GameState.currentPhase = 1
        GameState.overlay = nil
        GameState.gameUI = nil
        GameState.target = nil
        GameState.blueTarget = nil
        GameState.blueTarget2 = nil
    end
    
    player.CharacterRemoving:Connect(function()
        cleanup()
    end)
    
    local escConnection
    escConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == Enum.KeyCode.Escape and GameState.isRunning then
            cleanup()
        end
    end)
    
    table.insert(GameState.connections, escConnection)
    task.wait(2)
    
    local function startGame()
        if not GameState.isRunning then
            local success, errorMsg = pcall(main)
            if not success then
                pcall(cleanup)
            end
        end
    end
    
    task.wait(1)
    startGame()
    
    _G.StartMiniGame = startGame
    _G.StopMiniGame = cleanup
end)


addMonsterButton("A60", "A-60", function()
    local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/DOORS-Entity-Spawner-V2/main/init.luau"))()
    local entity = spawner.Create({
        Entity = {Name = "A60", Asset = "117633452506607", HeightOffset = 0},
        Lights = {Flicker = {Enabled = false, Duration = 10}, Shatter = false, Repair = false},
        Earthquake = {Enabled = false},
        CameraShake = {Enabled = true, Range = 200, Values = {1.5, 20, 0.1, 1}},
        Movement = {Speed = 350, Delay = 3, Reversed = false},
        Rebounding = {Enabled = true, Type = "ambush", Min = 5, Max = 5, Delay = math.random(10, 30) / 10},
        Damage = {Enabled = true, Range = 100, Amount = 125},
        Crucifixion = {Enabled = true, Range = 100, Resist = false, Break = true},
        Death = {Type = "Guiding", Hints = {"你死于A60", "...", "你会从Ambush那学会点什么", "他随时可能出现!"}, Cause = ""}
    })
    
    entity:SetCallback("OnRebounding", function(startOfRebound)
        local entityModel = entity.Model
        local main = entityModel:WaitForChild("Main")
        local attachment = main:WaitForChild("Attachment")
        local AttachmentSwitch = main:WaitForChild("AttachmentSwitch")
        local sounds = {
            footsteps = main:WaitForChild("Footsteps"),
            playSound = main:WaitForChild("PlaySound"),
            switch = main:WaitForChild("Switch"),
            switchBack = main:WaitForChild("SwitchBack")
        }
        
        for _, c in attachment:GetChildren() do
            c.Enabled = (not startOfRebound)
        end
        for _, c in AttachmentSwitch:GetChildren() do
            c.Enabled = startOfRebound
        end
        
        if startOfRebound == true then
            sounds.footsteps.PlaybackSpeed = 0.35
            sounds.playSound.PlaybackSpeed = 0.25
            sounds.switch:Play()
        else
            sounds.footsteps.PlaybackSpeed = 0.25
            sounds.playSound.PlaybackSpeed = 0.16
            sounds.switchBack:Play()
        end
    end)
    
    entity:Run()
    
    task.wait(1)
    
    local face = workspace:WaitForChild("A60"):WaitForChild("RushNew"):WaitForChild("Main"):WaitForChild("Face")
    if face and face:IsA("ParticleEmitter") then
        while true do
            face.Texture = "rbxassetid://12145534911"
            wait(0.1)
            face.Texture = "rbxassetid://12145554242"
            wait(0.1)
            face.Texture = "rbxassetid://12145599498"
            wait(0.1)
            face.Texture = "rbxassetid://12145599275"
            wait(0.1)
            face.Texture = "rbxassetid://12155335619"
            wait(0.1)
            face.Texture = "rbxassetid://12145598814"
            wait(0.1)
            face.Texture = "rbxassetid://12146135062"
            wait(0.1)
            face.Texture = "rbxassetid://11378285585"
            wait(0.1)
        end
    end
end)

addMonsterButton("IndescribableGod", "INDESCRIBABLE GOD", function()
    local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()
    local entity = spawner.Create({
        Entity = {Name = "@&%^#*$Indescribable God!@$*&^!Q(*", Asset = "85650922684960", HeightOffset = -0.8},
        Lights = {Flicker = {Enabled = true, Duration = 50}, Shatter = true, Repair = true},
        Earthquake = {Enabled = false},
        CameraShake = {Enabled = true, Range = 1500, Values = {0.5, 20, 0.1, 1}},
        Movement = {Speed = 15, Delay = 2, Reversed = false},
        Rebounding = {Enabled = false, Type = "Blitz", Min = 1, Max = math.random(1, 2), Delay = math.random(10, 30) / 10},
        Damage = {Enabled = true, Range = 40, Amount = 200},
        Crucifixion = {Enabled = true, Range = 40, Resist = true, Break = true},
        Death = {
            Type = "Curious", 
            Hints = {
                "看来你遭遇了糟糕的事情。", 
                "你死于 %@&*$^%@&*!^$%(*&!^@$((!@&*$%", 
                "或许有时旁观并不会带给你友好的收益。", 
                "急速奔跑是你本能的求生欲。", 
                "下次见。"
            }, 
            Cause = ""
        }
    })
    
    entity:SetCallback("OnRebounding", function(startOfRebound)
        local entityModel = entity.Model
        local main = entityModel:WaitForChild("Main")
        local attachment = main:WaitForChild("Attachment")
        local AttachmentSwitch = main:WaitForChild("AttachmentSwitch")
        local sounds = {
            footsteps = main:WaitForChild("Footsteps"),
            playSound = main:WaitForChild("PlaySound"),
            switch = main:WaitForChild("Switch"),
            switchBack = main:WaitForChild("SwitchBack")
        }
        
        for _, c in attachment:GetChildren() do
            c.Enabled = (not startOfRebound)
        end
        
        for _, c in AttachmentSwitch:GetChildren() do
            c.Enabled = startOfRebound
        end
        
        if startOfRebound == true then
            sounds.footsteps.PlaybackSpeed = 0.35
            sounds.playSound.PlaybackSpeed = 0.25
            sounds.switch:Play()
        else
            sounds.footsteps.PlaybackSpeed = 0.25
            sounds.playSound.PlaybackSpeed = 0.16
            sounds.switchBack:Play()
        end
    end)
    
    entity:Run()
    
    local Event = game:GetService("ReplicatedStorage").RemotesFolder.AdminPanelRunCommand
    Event:FireServer("LightRoom", {["Light Color"] = Color3.new(1, 0.00060111284255981, 0)})
end)

-- 在您的怪物按钮创建函数中添加这个Seek按钮
addMonsterButton("Seek", "Seek", function()
    -- 自定义音效函数
    function GitAud(soundgit, filename)
        local url = soundgit
        local FileName = filename
        writefile(FileName .. ".mp3", game:HttpGet(url))
        return (getcustomasset or getsynasset)(FileName .. ".mp3")
    end
    
    -- 替换Seek音效函数
    function ReplaceSeekMusicInWorkspace(targetAudioUrl, newFileName, volume)
        local targetParent = game:GetService("Workspace")
        local folderName = "SeekMovingNewClone"
        local targetSoundName = "SeekMusic"
        
        local targetFolder = targetParent:FindFirstChild(folderName)
        if not targetFolder then 
            print("⚠️ 找不到文件夹: " .. folderName)
            return nil 
        end
        
        local targetSound = targetFolder:FindFirstChild(targetSoundName)
        if not targetSound then 
            print("⚠️ 找不到音效: " .. targetSoundName)
            return nil 
        end
        
        if not targetSound:IsA("Sound") then 
            print("⚠️ 目标不是音效对象")
            return nil 
        end
        
        local localAssetPath = GitAud(targetAudioUrl, newFileName)
        targetSound.SoundId = localAssetPath
        targetSound.Volume = volume or targetSound.Volume
        
        print("✅ 音效已替换: " .. newFileName)
        return targetSound
    end
    
    -- 使用GitHub音效（请确保URL有效）
    local targetAudioUrl = "https://github.com/Sosnen/Ping-s-Dumbass-projects-/raw/main/Here%20i%20come%20but%20WHAT%20THE%20FUCK.mp3"
    local newFileName = "SeekMusicNew"
    local volume = 5
    
    local replacedSound = ReplaceSeekMusicInWorkspace(targetAudioUrl, newFileName, volume)
    if replacedSound then
        print("🎵 Seek音效替换成功")
    else
        warn("⚠️ Seek音效替换失败")
    end
    
    -- 服务引用
    local Workspace = game:GetService("Workspace")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local RunService = game:GetService("RunService")
    
    -- 加载Seek模型
    local newModel
    local success, result = pcall(function()
        return game:GetObjects("rbxassetid://91573224733706")[1]
    end)
    
    if success and result then
        newModel = result
        newModel.Parent = Workspace
        newModel.Name = "SeekMoving"
        print("✅ Seek模型加载成功")
    else
        warn("❌ Seek模型加载失败")
        return
    end
    
    -- 停止所有动画
    local function stopAllAnimations()
        local seekModel = Workspace:FindFirstChild("SeekMoving")
        if not seekModel then return end
        
        local seekRig = seekModel:FindFirstChild("SeekRig")
        if not seekRig then return end
        
        local humanoid = seekRig:FindFirstChildOfClass("Humanoid")
        if humanoid then
            local animator = humanoid:FindFirstChildOfClass("Animator")
            if animator then
                for _, track in pairs(animator:GetPlayingAnimationTracks()) do
                    track:Stop()
                end
            end
        end
        
        local animController = seekRig:FindFirstChild("AnimationController")
        if animController then
            for _, track in pairs(animController:GetPlayingAnimationTracks()) do
                track:Stop()
            end
        end
    end
    
    -- 播放动画
    local function playAnimation(animationId, looped)
        local seekModel = Workspace:FindFirstChild("SeekMoving")
        if not seekModel then return end
        
        local seekRig = seekModel:FindFirstChild("SeekRig")
        if not seekRig then return end
        
        local humanoid = seekRig:FindFirstChildOfClass("Humanoid")
        if not humanoid then
            local animController = seekRig:FindFirstChild("AnimationController")
            if not animController then
                animController = Instance.new("AnimationController")
                animController.Parent = seekRig
            end
            
            local animation = Instance.new("Animation")
            animation.AnimationId = "rbxassetid://" .. animationId
            animation.Name = "CustomAnim"
            
            local track = animController:LoadAnimation(animation)
            track.Looped = looped or true
            track:Play()
            return track
        end
        return nil
    end
    
    -- 静音Figure音效
    local function muteFigureSounds()
        local seekMoving = Workspace:FindFirstChild("SeekMoving")
        if not seekMoving then return {} end
        
        local figure = seekMoving:FindFirstChild("Figure")
        if not figure then return {} end
        
        local originalSoundStates = {}
        for _, sound in pairs(figure:GetDescendants()) do
            if sound:IsA("Sound") then
                originalSoundStates[sound] = sound.Playing
                sound.Playing = false
            end
        end
        return originalSoundStates
    end
    
    -- 恢复Figure音效
    local function restoreFigureSounds(originalStates)
        for sound, wasPlaying in pairs(originalStates) do
            if sound and sound:IsA("Sound") and sound.Parent then
                sound.Playing = wasPlaying
            end
        end
    end
    
    -- 隐藏SeekMovingNewClone
    local function hideModelParts(model)
        for _, child in pairs(model:GetDescendants()) do
            if child:IsA("BasePart") or child:IsA("MeshPart") or child:IsA("UnionOperation") then
                child.Transparency = 1
            elseif child:IsA("ParticleEmitter") or child:IsA("Beam") or child:IsA("Trail") then
                child.Enabled = false
            elseif child:IsA("Sound") then
                child.Playing = false
            elseif child:IsA("BillboardGui") or child:IsA("SurfaceGui") then
                child.Enabled = false
            elseif child:IsA("Light") or child:IsA("SurfaceLight") or child:IsA("SpotLight") then
                child.Enabled = false
            elseif child:IsA("Decal") or child:IsA("Texture") then
                child.Transparency = 1
            end
        end
        print("✅ SeekMovingNewClone已完全隐藏")
    end
    
    -- 删除StringCheese
    local function deleteAllStringCheese()
        local targetModel = Workspace:FindFirstChild("SeekMovingNewClone")
        if not targetModel then 
            warn("⚠️ 找不到SeekMovingNewClone")
            return 0 
        end
        
        local seekRig = targetModel:FindFirstChild("SeekRig")
        if not seekRig then 
            warn("⚠️ 找不到SeekRig")
            return 0 
        end
        
        local deletedCount = 0
        for _, child in pairs(seekRig:GetDescendants()) do
            if child.Name == "StringCheese" then
                child:Destroy()
                deletedCount = deletedCount + 1
            end
        end
        
        if deletedCount > 0 then
            print("🧀 已删除 " .. deletedCount .. " 个StringCheese")
        else
            print("✅ 未找到StringCheese")
        end
        return deletedCount
    end
    
    -- 主程序
    local targetModel = Workspace:FindFirstChild("SeekMovingNewClone")
    if not targetModel then
        warn("⚠️ 找不到SeekMovingNewClone")
    else
        hideModelParts(targetModel)
        deleteAllStringCheese()
    end
    
    -- 静音SeekMoving/Figure音效
    local originalSoundStates = muteFigureSounds()
    
    -- 动画状态变量
    local animationPlaying = false
    local isRunning = false
    local isSequencePlaying = false
    local runAnimationId = "10729087054"
 
    local function setupAnimationListener()
        local foundAnimator = nil
     
        for _, child in pairs(targetModel:GetDescendants()) do
            if child:IsA("AnimationController") or child:IsA("Animator") then
                foundAnimator = child
                break
            end
        end
        
        if not foundAnimator then
        
            return
        end
   
        
        -- 使用轮询监听动画变化
        local lastTracks = {}
        
        while task.wait(0.1) do
            local currentTracks = foundAnimator:GetPlayingAnimationTracks()
            local trackMap = {}
    
            for _, track in pairs(currentTracks) do
                if track.Animation and track.Animation.AnimationId then
                    local animId = track.Animation.AnimationId:match("rbxassetid://(%d+)")
                    trackMap[animId] = track
                end
            end
   
            for animId, track in pairs(trackMap) do
                if not lastTracks[animId] then
                  
                    if animId == "10954733643" and not animationPlaying then
                
                        animationPlaying = true
                        stopAllAnimations()
                        playAnimation("10954733643", true)
                        task.wait(7)
                        restoreFigureSounds(originalSoundStates)
                    end
           
                    if animId == "12309659361" and not isSequencePlaying then
                    
                        isSequencePlaying = true
                        stopAllAnimations()
                        playAnimation("12309659361", false)
                    end
                    
                    if animId == "12309664766" and isSequencePlaying then

                        stopAllAnimations()
                        playAnimation("12309664766", false)
                    end
                    
                    if animId == "12309667757" and isSequencePlaying then

                        stopAllAnimations()
                        playAnimation("12309667757", false)
                    end

                    if animId == runAnimationId and not isSequencePlaying and not isRunning then

                        isRunning = true
                        stopAllAnimations()
                        playAnimation(runAnimationId, true)
                    end
                end
            end

            for animId, track in pairs(lastTracks) do
                if not trackMap[animId] then

                    if animId == "12309667757" and isSequencePlaying then

                        isSequencePlaying = false
                        stopAllAnimations()
                        playAnimation(runAnimationId, true)
                        isRunning = true
                    end
                    
                    if animId == "10954733643" and animationPlaying then
                        animationPlaying = false
                    end
                end
            end
            
            lastTracks = trackMap
        end
    end

    local function doorChangedHandler()
        stopAllAnimations()
        playAnimation(runAnimationId, true)
        isRunning = true
    end

    coroutine.wrap(function()
        ReplicatedStorage.GameData.LatestRoom.Changed:Wait()
        doorChangedHandler()
    end)()

    RunService.RenderStepped:Connect(function()
        if newModel and newModel.Parent and targetModel and targetModel.Parent then
            if targetModel:IsA("Model") and targetModel.PrimaryPart then
                if newModel:IsA("Model") and newModel.PrimaryPart then
                    local targetCFrame = targetModel.PrimaryPart.CFrame
                    local offsetPosition = targetCFrame.Position + Vector3.new(0, 1.1, 0)
                    newModel:PivotTo(CFrame.new(offsetPosition) * targetCFrame.Rotation)
                end
            end
        end
    end)

    task.wait(1)
    if targetModel then
        setupAnimationListener()
    end

    game.ReplicatedStorage.GameData.LatestRoom.Changed:Wait()
    require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("使用你的体力!",true)

    task.wait(100)
    local seekModel = Workspace:FindFirstChild("SeekMoving")
    if seekModel and seekModel.Parent then
        seekModel:Destroy()
    end
end)

addMonsterButton("XBramble", "X-Bramble", function()
    local Event = game:GetService("ReplicatedStorage").RemotesFolder.AdminPanelRunCommand
Event:FireServer(
    "Bramble",
    {}
)
local targetModel = workspace:WaitForChild("LiveEntityBramble", 5)
if not targetModel then
    return
end

local ModelID = 87341133560380

local success, modelData = pcall(function()
    return game:GetObjects("rbxassetid://" .. ModelID)
end)

if not success or #modelData == 0 then
    return
end

local NewModel = modelData[1]:Clone()
NewModel.Parent = workspace
NewModel.Name = "LiveEntityBramble1"

for _, part in ipairs(NewModel:GetDescendants()) do
    if part:IsA("BasePart") or part:IsA("MeshPart") or part:IsA("Part") then
        part.Transparency = 0
        part.CanCollide = true
    end
end

local partsToCopy = {
    "RightArm",
    "LeftArm", 
    "Head"
}

local copiedParts = {}

for _, partName in ipairs(partsToCopy) do
    
    local sourcePart = NewModel:FindFirstChild(partName, true)
    
    if sourcePart then

        if sourcePart:IsA("Model") then
            for _, child in ipairs(sourcePart:GetDescendants()) do
                if child:IsA("BasePart") or child:IsA("MeshPart") then
                end
            end
        end

        local clonedPart = sourcePart:Clone()
        clonedPart.Parent = targetModel

        local existingPart = targetModel:FindFirstChild(partName)
        if existingPart then
            clonedPart.Name = partName .. "_New"
            print("📝 重命名为: " .. clonedPart.Name .. " (避免冲突)")
        else
            clonedPart.Name = partName
        end
        
        -- 设置不透明
        if clonedPart:IsA("BasePart") or clonedPart:IsA("MeshPart") then
            clonedPart.Transparency = 0
            clonedPart.CanCollide = true
        end
        
        table.insert(copiedParts, clonedPart)
        print("✅ 复制完成: " .. partName)
    else
        warn("❌ 未找到部件: " .. partName)
        
        -- 列出新模型中可用的部件
        print("🔍 可用的部件列表:")
        for _, child in ipairs(NewModel:GetChildren()) do
            print("  - " .. child.Name .. " (" .. child.ClassName .. ")")
        end
    end
end

-- 4. 设置原模型的Head为透明
print("🔧 设置原模型的Head为透明...")
local originalHead = targetModel:FindFirstChild("Head")
if originalHead then
    if originalHead:IsA("BasePart") or originalHead:IsA("MeshPart") then
        originalHead.Transparency = 1
        originalHead.CanCollide = false
        print("✅ 原Head已设为透明")
    elseif originalHead:IsA("Model") then
        for _, part in ipairs(originalHead:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("MeshPart") then
                part.Transparency = 1
                part.CanCollide = false
            end
        end
        print("✅ 原Head模型及其子部件已设为透明")
    end
else
    warn("❌ 未找到原模型的Head")
end

-- 5. 新模型跟随原模型
print("🔄 设置新模型跟随原模型...")
local RunService = game:GetService("RunService")
local followConnection
followConnection = RunService.Heartbeat:Connect(function()
    if not targetModel or not targetModel.Parent or not NewModel or not NewModel.Parent then
        if followConnection then
            followConnection:Disconnect()
        end
        return
    end
    
    -- 获取主部件
    local mainPartTarget = targetModel.PrimaryPart or targetModel:FindFirstChild("HumanoidRootPart") or 
                           targetModel:FindFirstChild("Torso") or targetModel:FindFirstChildWhichIsA("BasePart")
    
    local mainPartNew = NewModel.PrimaryPart or NewModel:FindFirstChild("HumanoidRootPart") or 
                       NewModel:FindFirstChild("Torso") or NewModel:FindFirstChildWhichIsA("BasePart")
    
    if mainPartTarget and mainPartNew then
        -- 精确跟随位置、旋转、方向
        mainPartNew.CFrame = mainPartTarget.CFrame
    end
end)
print("✅ 跟随已建立")

-- 6. 新模型设为透明
print("🔧 延迟设置新模型为透明...")
task.wait(1)  -- 等待1秒确认复制完成
print("🔧 设置新模型为透明...")
for _, part in ipairs(NewModel:GetDescendants()) do
    if part:IsA("BasePart") or part:IsA("MeshPart") or part:IsA("Part") then
        part.Transparency = 1
        part.CanCollide = false
    end
end
print("✅ 新模型已设为透明")

warn("✅ 全部操作完成!")
print("📊 最终状态:")
print("- 新模型:", NewModel.Name, "(ID:", ModelID, ")", "🔹 透明")
print("- 已复制部件:", #copiedParts, "个")
local model = workspace.LiveEntityBramble
local rightArm = model:FindFirstChild("RightArm", true)
local darkGrayColor = Color3.fromRGB(36, 36, 36)  -- 深灰色

if rightArm then
    for _, part in ipairs(rightArm:GetDescendants()) do
        if part:IsA("BasePart") or part:IsA("MeshPart") then
            part.Color = darkGrayColor
        end
    end
end
wait(1)
local model = workspace.LiveEntityBramble
local LeftLeg = model:FindFirstChild("LeftLeg", true)
local darkGrayColor = Color3.fromRGB(36, 36, 36)  -- 深灰色

if LeftLeg then
    for _, part in ipairs(LeftLeg:GetDescendants()) do
        if part:IsA("BasePart") or part:IsA("MeshPart") then
            part.Color = darkGrayColor
        end
    end
end
wait(1)
local model = workspace.LiveEntityBramble
local RightLeg = model:FindFirstChild("RightLeg", true)
local darkGrayColor = Color3.fromRGB(14, 14, 14)  -- 深灰色

if RightLeg then
    for _, part in ipairs(RightLeg:GetDescendants()) do
        if part:IsA("BasePart") or part:IsA("MeshPart") then
            part.Color = darkGrayColor
        end
    end
end
wait(0.5)
local model = workspace.LiveEntityBramble
local Torso = model:FindFirstChild("Torso", true)
local darkGrayColor = Color3.fromRGB(14, 14, 14)  -- 深灰色

if Torso then
    for _, part in ipairs(Torso:GetDescendants()) do
        if part:IsA("BasePart") or part:IsA("MeshPart") then
            part.Color = darkGrayColor
        end
    end
end
wait(0.5)
local model = workspace.LiveEntityBramble
local LeftArm = model:FindFirstChild("LeftArm", true)
local darkGrayColor = Color3.fromRGB(14, 14, 14)  -- 深灰色

if LeftArm then
    for _, part in ipairs(LeftArm:GetDescendants()) do
        if part:IsA("BasePart") or part:IsA("MeshPart") then
            part.Color = darkGrayColor
        end
    end
end
-- 将 LiveEntityBramble 模型中所有的 PointLight 颜色改为 RGB(160, 0, 0)
local targetModel = workspace:WaitForChild("LiveEntityBramble", 5)
if not targetModel then
    warn("❌ 未找到目标模型: LiveEntityBramble")
    return
end
print("✅ 找到目标模型:", targetModel.Name)

-- 目标颜色: RGB(160, 0, 0) 深红色
local targetColor = Color3.fromRGB(160, 0, 0)
print("🎨 目标颜色: RGB(160, 0, 0) - 深红色")

-- 查找并修改所有 PointLight
print("🔍 搜索模型中所有 PointLight...")
local pointLights = {}
local changedLights = 0

-- 先收集所有 PointLight
for _, light in ipairs(targetModel:GetDescendants()) do
    if light:IsA("PointLight") then
        table.insert(pointLights, {
            instance = light,
            originalColor = light.Color,  -- 注意：这里不要用 Clone()
            originalBrightness = light.Brightness,
            originalRange = light.Range
        })
    end
end

if #pointLights == 0 then
    warn("❌ 未找到任何 PointLight")
    
    -- 列出可用的灯光类型
    print("🔍 模型中的灯光类型:")
    local lightTypes = {}
    for _, child in ipairs(targetModel:GetDescendants()) do
        if child:IsA("Light") then
            local typeName = child.ClassName
            if not lightTypes[typeName] then
                lightTypes[typeName] = true
                print("  - " .. typeName)
            end
        end
    end
    return
end

print("✅ 找到 " .. #pointLights .. " 个 PointLight")

-- 修改所有 PointLight
for _, data in ipairs(pointLights) do
    local light = data.instance
    
    -- 修改颜色
    light.Color = targetColor
    
    -- 调整其他属性
    light.Brightness = 5      -- 亮度
    light.Range = 10          -- 范围
    
    changedLights = changedLights + 1
    
    -- 计算新旧颜色
    local newR = math.floor(light.Color.R * 255)
    local newG = math.floor(light.Color.G * 255)
    local newB = math.floor(light.Color.B * 255)
    
    local oldR = math.floor(data.originalColor.R * 255)
    local oldG = math.floor(data.originalColor.G * 255)
    local oldB = math.floor(data.originalColor.B * 255)
    
    print("✅ 已修改 PointLight: " .. light.Name)
    print("   ├─ 路径: " .. light:GetFullName())
    print("   ├─ 原颜色: RGB(" .. oldR .. ", " .. oldG .. ", " .. oldB .. ")")
    print("   ├─ 新颜色: RGB(" .. newR .. ", " .. newG .. ", " .. newB .. ")")
    print("   ├─ 亮度: " .. data.originalBrightness .. " → " .. light.Brightness)
    print("   └─ 范围: " .. data.originalRange .. " → " .. light.Range)
end

warn("✅ 颜色修改完成!")
print("📊 修改统计:")
print("- 目标模型:", targetModel.Name)
print("- 已修改 PointLight:", changedLights, "个")
print("- 目标颜色: RGB(160, 0, 0)")
print("- 亮度设置: 5")
print("- 范围设置: 10")

-- 颜色验证
task.wait(0.5)  -- 等待一下确保颜色已应用
print("\n🔍 颜色验证:")
local correctCount = 0
local incorrectCount = 0

for _, data in ipairs(pointLights) do
    local light = data.instance
    local r = math.floor(light.Color.R * 255)
    local g = math.floor(light.Color.G * 255)
    local b = math.floor(light.Color.B * 255)
    
    if r == 160 and g == 0 and b == 0 then
        print("  ✅ " .. light.Name .. ": RGB(" .. r .. ", " .. g .. ", " .. b .. ") - 正确")
        correctCount = correctCount + 1
    else
        print("  ⚠️ " .. light.Name .. ": RGB(" .. r .. ", " .. g .. ", " .. b .. ") - 不匹配")
        incorrectCount = incorrectCount + 1
    end
end

-- 修改特定路径的 ParticleEmitter 为纯红色
local targetModel = workspace:WaitForChild("LiveEntityBramble", 5)
if not targetModel then
    warn("❌ 未找到目标模型: LiveEntityBramble")
    return
end
print("✅ 找到目标模型:", targetModel.Name)

-- 目标颜色: RGB(255, 0, 0) 纯红色
local targetColor = Color3.fromRGB(255, 0, 0)
print("🎨 目标颜色: RGB(255, 0, 0) - 纯红色")

-- 定义要修改的粒子路径
local particlePaths = {
    "Head.LanternNeon.Attachment.CenterAttach.CenterAttach",
    "Head.UpperHead.Glass.FliesParticles"
}

local changedParticles = 0

-- 遍历每个路径
for _, path in ipairs(particlePaths) do
    print("\n🔍 查找路径:", path)
    
    -- 分割路径
    local parts = {}
    for part in path:gmatch("([^.]+)") do
        table.insert(parts, part)
    end
    
    -- 从目标模型开始查找
    local current = targetModel
    local found = true
    
    for i, partName in ipairs(parts) do
        current = current:FindFirstChild(partName)
        if not current then
            print("❌ 路径中断:", partName, "(在位置", i, ")")
            found = false
            break
        end
    end
    
    if found and current:IsA("ParticleEmitter") then
        print("✅ 找到 ParticleEmitter:", current.Name)
        print("📍 完整路径:", current:GetFullName())
        
        -- 保存原颜色
        local originalColor = nil
        if current.Color and current.Color.Keypoints and #current.Color.Keypoints > 0 then
            originalColor = current.Color.Keypoints[1].Value
        end
        
        -- 修改为纯红色
        local redColorSequence = ColorSequence.new(targetColor)
        current.Color = redColorSequence
        
        -- 修改其他粒子属性以增强效果
        current.Lifetime = NumberRange.new(1, 2)
        current.Rate = 50
        current.Speed = NumberRange.new(5, 10)
        
        -- 设置粒子大小
        current.Size = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0.1),
            NumberSequenceKeypoint.new(0.5, 0.3),
            NumberSequenceKeypoint.new(1, 0)
        })
        
        -- 设置透明度
        current.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0.2),
            NumberSequenceKeypoint.new(0.5, 0.1),
            NumberSequenceKeypoint.new(1, 1)
        })
        
        changedParticles = changedParticles + 1
        
        -- 显示修改信息
        if originalColor then
            local oldR = math.floor(originalColor.R * 255)
            local oldG = math.floor(originalColor.G * 255)
            local oldB = math.floor(originalColor.B * 255)
            print("   ├─ 原颜色: RGB(" .. oldR .. ", " .. oldG .. ", " .. oldB .. ")")
        end
        print("   ├─ 新颜色: RGB(255, 0, 0)")
        print("   ├─ 生命周期: 1-2 秒")
        print("   ├─ 发射率: 50")
        print("   └─ 速度: 5-10")
        
    elseif found then
        print("❌ 找到对象但不是 ParticleEmitter:", current.ClassName)
        
        -- 如果是其他对象，查找其子对象中的 ParticleEmitter
        for _, particle in ipairs(current:GetDescendants()) do
            if particle:IsA("ParticleEmitter") then
                print("✅ 找到子 ParticleEmitter:", particle.Name)
                
                -- 修改颜色
                particle.Color = ColorSequence.new(targetColor)
                particle.Rate = 50
                
                changedParticles = changedParticles + 1

            end
        end
    end
end

local model = workspace:WaitForChild("LiveEntityBramble")
local targetColor = Color3.fromRGB(255, 0, 0)

local function findAndModifyParticle(path)
    local parts = path:split("-")
    local current = model
    
    for _, partName in ipairs(parts) do
        current = current:FindFirstChild(partName)
        if not current then return false end
    end
    
    if current and current:IsA("ParticleEmitter") then
        current.Color = ColorSequence.new(targetColor)
        return true
    end
    
    return false
end

findAndModifyParticle("Head-LanternNeon-Attachment-CenterAttach-LightCenterParticle")

local model = workspace:WaitForChild("LiveEntityBramble")
local lowerHead = model:FindFirstChild("LowerHead", true)
if lowerHead then
    if lowerHead:IsA("BasePart") or lowerHead:IsA("MeshPart") then
        lowerHead.Transparency = 1
    end
    for _, part in ipairs(lowerHead:GetDescendants()) do
        if part:IsA("BasePart") or part:IsA("MeshPart") then
            part.Transparency = 1
        end
    end
end

local model = workspace:WaitForChild("LiveEntityBramble")
local head = model:FindFirstChild("Head", true)

if head then

    local tongue = head:FindFirstChild("Tongue", true)
    if tongue then
        if tongue:IsA("BasePart") or tongue:IsA("MeshPart") then
            tongue.Color = Color3.fromRGB(0, 0, 0)
        elseif tongue:IsA("Model") then
            for _, part in ipairs(tongue:GetDescendants()) do
                if part:IsA("BasePart") or part:IsA("MeshPart") then
                    part.Color = Color3.fromRGB(0, 0, 0)
                end
            end
        end
    end

    local lanternNeon = head:FindFirstChild("LanternNeon", true)
    if lanternNeon then
        if lanternNeon:IsA("BasePart") or lanternNeon:IsA("MeshPart") then
            lanternNeon.Color = Color3.fromRGB(168, 0, 0)
        elseif lanternNeon:IsA("Model") then
            for _, part in ipairs(lanternNeon:GetDescendants()) do
                if part:IsA("BasePart") or part:IsA("MeshPart") then
                    part.Color = Color3.fromRGB(168, 0, 0)
                end
            end
        end
    end
end

local model = workspace:WaitForChild("LiveEntityBramble")
local head = model:FindFirstChild("Head", true)
local lowerHead = head and head:FindFirstChild("LowerHead", true)

if lowerHead then
    local newModel = game:GetObjects("rbxassetid://77857688443174")[1]:Clone()
    newModel.Parent = lowerHead
    newModel.Name = "PART"
end
wait(1)
local PART = workspace.LiveEntityBramble.Head.LowerHead.PART
local target = workspace.LiveEntityBramble:FindFirstChild("Head", true):FindFirstChild("LowerHead", true)
local RunService = game:GetService("RunService")

if PART and target then
    local targetPart = target:IsA("BasePart") and target or target:FindFirstChildWhichIsA("BasePart")
    RunService.Heartbeat:Connect(function()
        PART.CFrame = targetPart.CFrame
    end)
end
end)

addMonsterButton("Lightspeed", "LightSpeed", function()
    
local Event = game:GetService("ReplicatedStorage").RemotesFolder.AdminPanelRunCommand
Event:FireServer(
    "LightRoom",
    {
        ["Light Color"] = Color3.new(1, 0.90844488143921, 0)
    }
)

wait(1)

local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()

---====== Create entity ======---

local entity = spawner.Create({
	Entity = {
		Name = "LightSpeed",
		Asset = "87015961601567",
		HeightOffset = 1
	},
	Lights = {
		Flicker = {
			Enabled = false,
			Duration = 0.1
		},
		Shatter = false,
		Repair = false
	},
	Earthquake = {
		Enabled = false
	},
	CameraShake = {
		Enabled = true,
		Range = 20,
		Values = {90, 50, 20, 20}
	},
	Movement = {
		Speed = 1400,
		Delay = 20,
		Reversed = false
	},
	Rebounding = {
		Enabled = false,
		Type = "Blitz",
		Min = 1,
		Max = math.random(1, 2),
		Delay = math.random(10, 30) / 10
	},
	Damage = {
		Enabled = true,
		Range = 50,
		Amount = 40
	},
	Crucifixion = {
		Enabled = true,
		Range = 50,
		Resist = false,
		Break = true
	},
	Death = {
		Type = "Guiding",
		Hints = {"你死于光速", "在他来临时保证自己以最快的速度作出反应", "伴随着灯光变黄与巨大的雷电轰鸣声", "或许并不致命但总是一个威胁"},
		Cause = ""
	}
})

---====== Debug entity ======---

entity:SetCallback("OnRebounding", function(startOfRebound)
	-- Variables for the entity
	local entityModel = entity.Model
	local main = entityModel:WaitForChild("Main")
	local attachment = main:WaitForChild("Attachment")
	local AttachmentSwitch = main:WaitForChild("AttachmentSwitch")
	local sounds = {
		footsteps = main:WaitForChild("Footsteps"),
		playSound = main:WaitForChild("PlaySound"),
		switch = main:WaitForChild("Switch"),
		switchBack = main:WaitForChild("SwitchBack")
	}

	-- Toggle particle emitters and lights within the entityModel
	-- To switch between green & red state
	for _, c in attachment:GetChildren() do
		c.Enabled = (not startOfRebound)
	end
	for _, c in AttachmentSwitch:GetChildren() do
		c.Enabled = startOfRebound
	end

	-- Play sounds
	if startOfRebound == true then
		sounds.footsteps.PlaybackSpeed = 0.35
		sounds.playSound.PlaybackSpeed = 0.25
		sounds.switch:Play()
	else
		sounds.footsteps.PlaybackSpeed = 0.25
		sounds.playSound.PlaybackSpeed = 0.16
		sounds.switchBack:Play()
	end
	
end)

---====== Run entity ======---

entity:Run()
end)

addMonsterButton("AM60", "AminA60", function()
    local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()
local entity = spawner.Create({
	Entity = {
		Name = "Amin-60",
		Asset = "134290844453819",
		HeightOffset = 0.8
	},
	Lights = {
		Flicker = {
			Enabled = false,
			Duration = 10
		},
		Shatter = true,
		Repair = false
	},
	Earthquake = {
		Enabled = false
	},
	CameraShake = {
		Enabled = true,
		Range = 200,
		Values = {1.5, 20, 0.1, 1}
	},
	Movement = {
		Speed = 400,
		Delay = 6.5,
		Reversed = false
	},
	Rebounding = {
		Enabled = true,
		Type = "ambush",
		Min = 10,
		Max = 10,
		Delay = math.random(10, 30) / 10
	},
	Damage = {
		Enabled = true,
		Range = 100,
		Amount = 125
	},
	Crucifixion = {
		Enabled = true,
		Range = 100,
		Resist = false,
		Break = true
	},
	Death = {
		Type = "Guiding",
		Hints = {"你死于Amin-60", "极大的嘈杂声会掩盖其他声音", "他比A60更加迅速敏捷", "仔细听取木板碎裂的声音"},
		Cause = ""
	}
})

---====== Debug entity ======---

entity:SetCallback("OnRebounding", function(startOfRebound)

	local entityModel = entity.Model
	local main = entityModel:WaitForChild("Main")
	local attachment = main:WaitForChild("Attachment")
	local AttachmentSwitch = main:WaitForChild("AttachmentSwitch")
	local sounds = {
		footsteps = main:WaitForChild("Footsteps"),
		playSound = main:WaitForChild("PlaySound"),
		switch = main:WaitForChild("Switch"),
		switchBack = main:WaitForChild("SwitchBack")
	}

	for _, c in attachment:GetChildren() do
		c.Enabled = (not startOfRebound)
	end
	for _, c in AttachmentSwitch:GetChildren() do
		c.Enabled = startOfRebound
	end

	if startOfRebound == true then
		sounds.footsteps.PlaybackSpeed = 0.35
		sounds.playSound.PlaybackSpeed = 0.25
		sounds.switch:Play()
	else
		sounds.footsteps.PlaybackSpeed = 0.25
		sounds.playSound.PlaybackSpeed = 0.16
		sounds.switchBack:Play()
	end
	
end)

entity:Run()
end)

addMonsterButton("BLA60", "BlackA60", function()
    local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()

---====== Create entity ======---

local entity = spawner.Create({
	Entity = {
		Name = "Black-A60",
		Asset = "96102326082560",
		HeightOffset = 0
	},
	Lights = {
		Flicker = {
			Enabled = false,
			Duration = 10
		},
		Shatter = true,
		Repair = false
	},
	Earthquake = {
		Enabled = false
	},
	CameraShake = {
		Enabled = true,
		Range = 200,
		Values = {1.5, 20, 0.1, 1}
	},
	Movement = {
		Speed = 350,
		Delay = 6.5,
		Reversed = false
	},
	Rebounding = {
		Enabled = true,
		Type = "ambush",
		Min = 10,
		Max = 10,
		Delay = math.random(10, 30) / 10
	},
	Damage = {
		Enabled = true,
		Range = 100,
		Amount = 125
	},
	Crucifixion = {
		Enabled = true,
		Range = 100,
		Resist = false,
		Break = true
	},
	Death = {
		Type = "Guiding",
		Hints = {"你死于A60", "极大的嘈杂声会掩盖其他声音", "在不妥时使用十字架会更方便", "反复进柜子躲避它"},
		Cause = ""
	}
})

---====== Debug entity ======---

entity:SetCallback("OnRebounding", function(startOfRebound)
	-- Variables for the entity
	local entityModel = entity.Model
	local main = entityModel:WaitForChild("Main")
	local attachment = main:WaitForChild("Attachment")
	local AttachmentSwitch = main:WaitForChild("AttachmentSwitch")
	local sounds = {
		footsteps = main:WaitForChild("Footsteps"),
		playSound = main:WaitForChild("PlaySound"),
		switch = main:WaitForChild("Switch"),
		switchBack = main:WaitForChild("SwitchBack")
	}

	-- Toggle particle emitters and lights within the entityModel
	-- To switch between green & red state
	for _, c in attachment:GetChildren() do
		c.Enabled = (not startOfRebound)
	end
	for _, c in AttachmentSwitch:GetChildren() do
		c.Enabled = startOfRebound
	end

	-- Play sounds
	if startOfRebound == true then
		sounds.footsteps.PlaybackSpeed = 0.35
		sounds.playSound.PlaybackSpeed = 0.25
		sounds.switch:Play()
	else
		sounds.footsteps.PlaybackSpeed = 0.25
		sounds.playSound.PlaybackSpeed = 0.16
		sounds.switchBack:Play()
	end
	
end)
end)

addMonsterButton("Silence", "Silence", function()
    local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()
local entity = spawner.Create({
	Entity = {
		Name = "Silence",
		Asset = "106570553068298",
		HeightOffset = 1
	},
	Lights = {
		Flicker = {
			Enabled = false,
			Duration = 0.1
		},
		Shatter = true,
		Repair = false
	},
	Earthquake = {
		Enabled = false
	},
	CameraShake = {
		Enabled = true,
		Range = 20,
		Values = {1.5, 20, 0.1, 1}
	},
	Movement = {
		Speed = 25,
		Delay = 2,
		Reversed = false
	},
	Rebounding = {
		Enabled = false,
		Type = "Blitz",
		Min = 1,
		Max = math.random(1, 2),
		Delay = math.random(10, 30) / 10
	},
	Damage = {
		Enabled = true,
		Range = 200,
		Amount = 125
	},
	Crucifixion = {
		Enabled = true,
		Range = 200,
		Resist = false,
		Break = true
	},
	Death = {
		Type = "Guiding",
		Hints = {"你被 Silence 吞噬了...", "你该学会不在寂静中消亡", "请仔细辨别环境中的声音", "他随时都可能出现"},
		Cause = ""
	}
})

---====== Debug entity ======---

entity:SetCallback("OnRebounding", function(startOfRebound)
	-- Variables for the entity
	local entityModel = entity.Model
	local main = entityModel:WaitForChild("Main")
	local attachment = main:WaitForChild("Attachment")
	local AttachmentSwitch = main:WaitForChild("AttachmentSwitch")
	local sounds = {
		footsteps = main:WaitForChild("Footsteps"),
		playSound = main:WaitForChild("PlaySound"),
		switch = main:WaitForChild("Switch"),
		switchBack = main:WaitForChild("SwitchBack")
	}

	-- Toggle particle emitters and lights within the entityModel
	-- To switch between green & red state
	for _, c in attachment:GetChildren() do
		c.Enabled = (not startOfRebound)
	end
	for _, c in AttachmentSwitch:GetChildren() do
		c.Enabled = startOfRebound
	end

	-- Play sounds
	if startOfRebound == true then
		sounds.footsteps.PlaybackSpeed = 0.35
		sounds.playSound.PlaybackSpeed = 0.25
		sounds.switch:Play()
	else
		sounds.footsteps.PlaybackSpeed = 0.25
		sounds.playSound.PlaybackSpeed = 0.16
		sounds.switchBack:Play()
	end
	
end)

---====== Run entity ======---

entity:Run()
end)

addMonsterButton("Forst", "FrostBite", function()
   function GetRoom()
    local gruh = workspace.CurrentRooms
    return gruh:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value)
end

local plr = game.Players.LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local tweenservice = game:GetService("TweenService")

function LoadCustomInstance(source, parent)
    local model

    local function NormalizeGitHubURL(url)
        if url:match("^https://github.com/.+%.rbxm$") and not url:find("?raw=true") then
            return url .. "?raw=true"
        end
        return url
    end

    while task.wait() and not model do
        if tonumber(source) then
            local success, result = pcall(function()
                return game:GetObjects("rbxassetid://" .. tostring(source))[1]
            end)
            if success and result then
                model = result
            end
        elseif typeof(source) == "string" and source:match("^https?://") and source:match("%.rbxm") then
            local url = NormalizeGitHubURL(source)
            local success, result = pcall(function()
                local filename = "temp_" .. math.random(100000, 999999) .. ".rbxm"
                local content = game:HttpGet(url)
                if writefile and (getcustomasset or getsynasset) and isfile and delfile then
                    writefile(filename, content)
                    local assetFunc = getcustomasset or getsynasset
                    local obj = game:GetObjects(assetFunc(filename))[1]
                    delfile(filename)
                    return obj
                else
                    warn("Executor không hỗ trợ file APIs.")
                    return nil
                end
            end)
            if success and result then
                model = result
            end
        else
            break
        end

        if model then
            model.Parent = parent or workspace
            for _, obj in ipairs(model:GetDescendants()) do
                if obj:IsA("Script") or obj:IsA("LocalScript") then
                    obj:Destroy()
                end
            end
            pcall(function()
                model:SetAttribute("LoadedByExecutor", true)
            end)
        end
    end

    return model
end

local s = LoadCustomInstance("98436457371270", workspace)
if not s then
    warn("Frost entity.")
    return
end

local entity = s:FindFirstChildWhichIsA("BasePart")
entity.CFrame = GetRoom():WaitForChild("RoomEntrance").CFrame * CFrame.new(0, 5, -15)
entity.Part.CFrame = entity.CFrame

pcall(function()
local room = workspace.CurrentRooms:FindFirstChild(
    tostring(game.ReplicatedStorage.GameData.LatestRoom.Value)
)
if room then
    for _, obj in ipairs(room:GetDescendants()) do
        if obj.Name == "PlaySound" and obj:IsA("Sound") then
            obj:Stop()
            obj.Playing = false
            obj.TimePosition = 0
            obj.Looped = false
        end
    end
end
workspace.CurrentRooms[game.ReplicatedStorage.GameData.LatestRoom.Value].Assets.Fireplace.Fireplace_Logs.ToolEventPrompt.Enabled = false
workspace.CurrentRooms[game.ReplicatedStorage.GameData.LatestRoom.Value].Assets.Fireplace.Fireplace_Logs.Log.SparkParticles.Enabled = false
workspace.CurrentRooms[game.ReplicatedStorage.GameData.LatestRoom.Value].Assets.Fireplace.Fireplace_Logs.Log.SmokeParticles.Enabled = false
workspace.CurrentRooms[game.ReplicatedStorage.GameData.LatestRoom.Value].Assets.Fireplace.Fireplace_Logs.Log.FireParticles.Enabled = false
workspace.CurrentRooms[game.ReplicatedStorage.GameData.LatestRoom.Value].Assets.Fireplace.Fireplace_Logs.Log.FireLight.Enabled = false
end)


local pointLight = Instance.new("PointLight")
pointLight.Color = Color3.new(255, 255, 255)
pointLight.Range = 60
pointLight.Brightness = 99999
pointLight.Parent = entity

tweenservice:Create(pointLight, TweenInfo.new(3), {
    Brightness = 0
}):Play()

local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://137044859218769"
sound.Looped = false
sound.Volume = 5
sound.Parent = s
sound:Play()

local frost = Instance.new("ColorCorrectionEffect")
frost.Parent = game.Lighting
tweenservice:Create(frost, TweenInfo.new(10), {
    TintColor = Color3.fromRGB(0, 0, 255),
    Saturation = -0.7,
    Contrast = 0.2
}):Play()

for _, v in ipairs({"face", "Heylois", "BlackTrai2l", "BlackTrai3l"}) do
    if entity:FindFirstChild("Attachment") and entity.Attachment:FindFirstChild(v) then
        entity.Attachment[v].Enabled = false
    end
end

wait(8)

for _, v in ipairs({"face", "Heylois", "BlackTrai2l", "BlackTrai3l"}) do
    if entity:FindFirstChild("Attachment") and entity.Attachment:FindFirstChild(v) then
        entity.Attachment[v].Enabled = true
    end
end

pcall(function() entity.Ambience:Play() end)
pcall(function() entity.AmbienceFar:Play() end)

local dmg = true
task.spawn(function()
    while dmg do
        wait(1)
        local lighter = chr:FindFirstChild("Lighter")
        local safe = false
        if lighter then
            local handle = lighter:FindFirstChild("Handle")
            if handle then
                local holder = handle:FindFirstChild("EffectsHolder")
                if holder then
                    local attach = holder:FindFirstChild("AttachOn")
                    if attach then
                        local main = attach:FindFirstChild("MainLight")
                        if main and main:IsA("PointLight") then
                            safe = main.Enabled
                        end
                    end
                end
            end
        end
        if not safe then
            pcall(function()
                chr.Humanoid.Health -= 5
                game.ReplicatedStorage.GameStats["Player_" .. plr.Name].Total.DeathCause.Value = "Frostbite"
                
                firesignal(game.ReplicatedStorage.RemotesFolder.DeathHint.OnClientEvent, {
                        "It's a bit cold here, isn't it?",
                        "You froze to death by something.",
                        "Maybe you need some cold prevention measures. I heard that humans are very sensitive to the cold..",
                        "Try using your lighter to keep warm.",
                        "This may be a bit tricky and noisy.",
                        "You should try again.",
                        "By the way, the name of the thing that killed you is Frostbite."
                    }, "Yellow")
                
            end)
        end
    end
end)

game.ReplicatedStorage.GameData.LatestRoom.Changed:Wait()
dmg = false

for _, v in ipairs({"face", "Heylois", "BlackTrai2l", "BlackTrai3l"}) do
    if entity:FindFirstChild("Attachment") and entity.Attachment:FindFirstChild(v) then
        entity.Attachment[v].Enabled = false
    end
end

pcall(function() entity.Ambience:Stop() end)
pcall(function() entity.AmbienceFar:Stop() end)

local des = Instance.new("Sound")
des.SoundId = "rbxassetid://111715441853991"
des.Looped = false
des.Volume = 2.5
des.Parent = s
des:Play()

wait(5)
s:Destroy()

tweenservice:Create(frost, TweenInfo.new(5), {
    TintColor = Color3.fromRGB(255, 255, 255),
    Saturation = 0,
    Contrast = 0
}):Play()
wait(5)
frost:Destroy()

end)

addMonsterButton("Smiler", "Smiler", function()
    local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()

local entity = spawner.Create({
	Entity = {
		Name = "smiler",
		Asset = "108450814500304",
		HeightOffset = 0
	},
	Lights = {
		Flicker = {
			Enabled = true,
			Duration = 10
		},
		Shatter = false,
		Repair = false
	},
	Earthquake = {
		Enabled = false
	},
	CameraShake = {
		Enabled = true,
		Range = 200,
		Values = {1.5, 20, 0.1, 1}
	},
	Movement = {
		Speed = 450,
		Delay = 11,
		Reversed = false
	},
	Rebounding = {
		Enabled = true,
		Type = "ambush",
		Min = 8,
		Max = 8,
		Delay = math.random(10, 30) / 10
	},
	Damage = {
		Enabled = true,
		Range = 200,
		Amount = 125
	},
	Crucifixion = {
		Enabled = true,
		Range = 200,
		Resist = false,
		Break = true
	},
	Death = {
		Type = "Guiding",
		Hints = {"你死于Smiler", "或许你需要在Ambush那学会点东西", "在闪灯数秒后他会出现", "加油,我相信你可以做到"},
		Cause = ""
	}
})

---====== Debug entity ======---

entity:SetCallback("OnRebounding", function(startOfRebound)
	-- Variables for the entity
	local entityModel = entity.Model
	local main = entityModel:WaitForChild("Main")
	local attachment = main:WaitForChild("Attachment")
	local AttachmentSwitch = main:WaitForChild("AttachmentSwitch")
	local sounds = {
		footsteps = main:WaitForChild("Footsteps"),
		playSound = main:WaitForChild("PlaySound"),
		switch = main:WaitForChild("Switch"),
		switchBack = main:WaitForChild("SwitchBack")
	}

	-- Toggle particle emitters and lights within the entityModel
	-- To switch between green & red state
	for _, c in attachment:GetChildren() do
		c.Enabled = (not startOfRebound)
	end
	for _, c in AttachmentSwitch:GetChildren() do
		c.Enabled = startOfRebound
	end

	-- Play sounds
	if startOfRebound == true then
		sounds.footsteps.PlaybackSpeed = 0.35
		sounds.playSound.PlaybackSpeed = 0.25
		sounds.switch:Play()
	else
		sounds.footsteps.PlaybackSpeed = 0.25
		sounds.playSound.PlaybackSpeed = 0.16
		sounds.switchBack:Play()
	end
	
end)

---====== Run entity ======---

entity:Run()
end)

local function addItemButton(name, text, onClick)
    local button = Instance.new("TextButton")
    button.Name = name .. "Button"
    button.Size = UDim2.new(0.9, 0, 0, 40)
    button.BackgroundColor3 = COLORS.BUTTON_BG
    button.BackgroundTransparency = 0.1
    button.Text = text
    button.TextColor3 = COLORS.PRIMARY
    button.TextScaled = true
    button.Font = Enum.Font.SciFi
    button.TextSize = 20
    button.Parent = ItemScrollingFrame
    
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 6)
    uiCorner.Parent = button
    
    local uiStroke = Instance.new("UIStroke")
    uiStroke.Color = COLORS.PRIMARY
    uiStroke.Thickness = 2
    uiStroke.Parent = button
    
    button.MouseEnter:Connect(function()
        TweenService:Create(
            button,
            TweenInfo.new(0.2),
            {
                BackgroundColor3 = COLORS.BUTTON_HOVER,
                TextColor3 = COLORS.SECONDARY
            }
        ):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(
            button,
            TweenInfo.new(0.2),
            {
                BackgroundColor3 = COLORS.BUTTON_BG,
                TextColor3 = COLORS.PRIMARY
            }
        ):Play()
    end)
    
    button.MouseButton1Down:Connect(function()
        TweenService:Create(
            button,
            TweenInfo.new(0.1),
            {BackgroundTransparency = 0.4}
        ):Play()
    end)
    
    button.MouseButton1Up:Connect(function()
        TweenService:Create(
            button,
            TweenInfo.new(0.1),
            {BackgroundTransparency = 0.1}
        ):Play()
    end)
    
    button.Activated:Connect(function()
        print("[Hardcore Panel] " .. text .. " button clicked!")
        if onClick then
            local success, err = pcall(onClick)
            if not success then
                warn("[Hardcore Panel] 执行失败: " .. tostring(err))
            end
        end
    end)
    
    return button
end

addItemButton("CandyBag", "CANDY BAG", function()
    local Event = game:GetService("ReplicatedStorage").RemotesFolder.AdminPanelRunCommand
    Event:FireServer(
        "Give Items",
        {
            Players = {
                A_Yun66 = "A_Yun66",
                Nssys123 = "Nssys123",
                YMXeternalX = "YMXeternalX",
                goat_qiu = "goat_qiu",
                SOXIYU24 = "SOXIYU24",
                Maoxinci = "Maoxinci",
                cgdwml = "cgdwml",
                Yxi_na = "Yxi_na",
                woshiniruier = "woshiniruier",
                Suu_Zzzz = "Suu_Zzzz",            
                QWQ75321 = "QWQ75321"
            },
            Items = {
                Shears = "CandyBag"
            }
        }
    )
end)

addItemButton("Lotus", "LOTUS", function()
    local Event = game:GetService("ReplicatedStorage").RemotesFolder.AdminPanelRunCommand
    Event:FireServer(
        "Give Items",
        {
            Players = {
                A_Yun66 = "A_Yun66",
                Nssys123 = "Nssys123",
                YMXeternalX = "YMXeternalX",
                goat_qiu = "goat_qiu",
                SOXIYU24 = "SOXIYU24",
                Maoxinci = "Maoxinci",
                cgdwml = "cgdwml",
                Yxi_na = "Yxi_na",
                woshiniruier = "woshiniruier",
                Suu_Zzzz = "Suu_Zzzz",            
                QWQ75321 = "QWQ75321"
            },
            Items = {
                Shears = "Lotus"
            }
        }
    )
end)

addItemButton("LotusPetal", "LOTUS PETAL", function()
    local Event = game:GetService("ReplicatedStorage").RemotesFolder.AdminPanelRunCommand
    Event:FireServer(
        "Give Items",
        {
            Players = {
                A_Yun66 = "A_Yun66",
                Nssys123 = "Nssys123",
                YMXeternalX = "YMXeternalX",
                goat_qiu = "goat_qiu",
                SOXIYU24 = "SOXIYU24",
                Maoxinci = "Maoxinci",
                cgdwml = "cgdwml",
                Yxi_na = "Yxi_na",
                woshiniruier = "woshiniruier",
                Suu_Zzzz = "Suu_Zzzz",            
                QWQ75321 = "QWQ75321"
            },
            Items = {
                Shears = "LotusPetal"
            }
        }
    )
end)

FloorsListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    FloorsScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, FloorsListLayout.AbsoluteContentSize.Y)
end)

DexListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    DexScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, DexListLayout.AbsoluteContentSize.Y)
end)

MonsterListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    MonsterScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, MonsterListLayout.AbsoluteContentSize.Y)
end)

ItemListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ItemScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, ItemListLayout.AbsoluteContentSize.Y)
end)

local TabContainer = Instance.new("Frame")
TabContainer.Name = "TabContainer"
TabContainer.Size = UDim2.new(0.9, 0, 0.1, 0)
TabContainer.Position = UDim2.new(0.05, 0, 0.84, 0)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = MainFrame

local function createTabButton(name, text, positionX, iconId)
    local button = Instance.new("ImageButton")
    button.Name = name .. "Tab"
    button.Size = UDim2.new(0.15, 0, 0.8, 0)
    button.Position = UDim2.new(positionX, 0, 0.1, 0)
    button.BackgroundColor3 = COLORS.BUTTON_BG
    button.BackgroundTransparency = 0.2
    button.Image = "rbxassetid://" .. tostring(iconId)
    button.ImageColor3 = Color3.new(1, 0.2, 0.2)
    button.ScaleType = Enum.ScaleType.Fit
    button.Parent = TabContainer
    
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 6)
    uiCorner.Parent = button
    
    local uiStroke = Instance.new("UIStroke")
    uiStroke.Color = COLORS.PRIMARY
    uiStroke.Thickness = 2
    uiStroke.Parent = button
    
    local tooltip = Instance.new("TextLabel")
    tooltip.Name = "Tooltip"
    tooltip.Size = UDim2.new(1.5, 0, 0.3, 0)
    tooltip.Position = UDim2.new(0.5, 0, -0.4, 0)
    tooltip.AnchorPoint = Vector2.new(0.5, 0)
    tooltip.BackgroundTransparency = 0.8
    tooltip.BackgroundColor3 = Color3.new(0, 0, 0)
    tooltip.Text = text
    tooltip.TextColor3 = COLORS.PRIMARY
    tooltip.TextScaled = true
    tooltip.Font = Enum.Font.SciFi
    tooltip.Visible = false
    tooltip.Parent = button
    
    local tooltipUICorner = Instance.new("UICorner")
    tooltipUICorner.CornerRadius = UDim.new(0, 4)
    tooltipUICorner.Parent = tooltip
    
    button.MouseEnter:Connect(function()
        TweenService:Create(
            button,
            TweenInfo.new(0.2),
            {
                BackgroundColor3 = COLORS.BUTTON_HOVER,
                ImageColor3 = Color3.new(1, 0.4, 0.4)
            }
        ):Play()
        tooltip.Visible = true
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(
            button,
            TweenInfo.new(0.2),
            {
                BackgroundColor3 = COLORS.BUTTON_BG,
                ImageColor3 = Color3.new(1, 0.2, 0.2)
            }
        ):Play()
        tooltip.Visible = false
    end)
    
    button.MouseButton1Down:Connect(function()
        TweenService:Create(
            button,
            TweenInfo.new(0.1),
            {BackgroundTransparency = 0.4}
        ):Play()
    end)
    
    button.MouseButton1Up:Connect(function()
        TweenService:Create(
            button,
            TweenInfo.new(0.1),
            {BackgroundTransparency = 0.2}
        ):Play()
    end)
    
    return button
end

local FloorsTab = createTabButton("Floors", "Floors", 0.08, 18624930841)
local DexTab = createTabButton("Dex", "Tool", 0.28, 137278255690287)
local MonsterTab = createTabButton("Monster", "Monster", 0.48, 103144676623079)
local ItemTab = createTabButton("Item", "Item", 0.68, 131732617072026)

local function switchTab(tabNumber)
    if tabNumber == 1 then
        FloorsScrollingFrame.Visible = true
        DexScrollingFrame.Visible = false
        MonsterScrollingFrame.Visible = false
        ItemScrollingFrame.Visible = false
        FloorsTab.ImageColor3 = Color3.new(1, 0.4, 0.4)
        DexTab.ImageColor3 = Color3.new(1, 0.2, 0.2)
        MonsterTab.ImageColor3 = Color3.new(1, 0.2, 0.2)
        ItemTab.ImageColor3 = Color3.new(1, 0.2, 0.2)
    elseif tabNumber == 2 then
        FloorsScrollingFrame.Visible = false
        DexScrollingFrame.Visible = true
        MonsterScrollingFrame.Visible = false
        ItemScrollingFrame.Visible = false
        FloorsTab.ImageColor3 = Color3.new(1, 0.2, 0.2)
        DexTab.ImageColor3 = Color3.new(1, 0.4, 0.4)
        MonsterTab.ImageColor3 = Color3.new(1, 0.2, 0.2)
        ItemTab.ImageColor3 = Color3.new(1, 0.2, 0.2)
    elseif tabNumber == 3 then
        FloorsScrollingFrame.Visible = false
        DexScrollingFrame.Visible = false
        MonsterScrollingFrame.Visible = true
        ItemScrollingFrame.Visible = false
        FloorsTab.ImageColor3 = Color3.new(1, 0.2, 0.2)
        DexTab.ImageColor3 = Color3.new(1, 0.2, 0.2)
        MonsterTab.ImageColor3 = Color3.new(1, 0.4, 0.4)
        ItemTab.ImageColor3 = Color3.new(1, 0.2, 0.2)
    elseif tabNumber == 4 then
        FloorsScrollingFrame.Visible = false
        DexScrollingFrame.Visible = false
        MonsterScrollingFrame.Visible = false
        ItemScrollingFrame.Visible = true
        FloorsTab.ImageColor3 = Color3.new(1, 0.2, 0.2)
        DexTab.ImageColor3 = Color3.new(1, 0.2, 0.2)
        MonsterTab.ImageColor3 = Color3.new(1, 0.2, 0.2)
        ItemTab.ImageColor3 = Color3.new(1, 0.4, 0.4)
    end
end

FloorsTab.Activated:Connect(function() 
    switchTab(1) 
end)

DexTab.Activated:Connect(function() 
    switchTab(2) 
end)

MonsterTab.Activated:Connect(function() 
    switchTab(3) 
end)

ItemTab.Activated:Connect(function() 
    switchTab(4) 
end)

switchTab(1)

CloseButton.Activated:Connect(function()
    isPanelOpen = false
    togglePanel(false)
end)

local Watermark = Instance.new("TextLabel")
Watermark.Name = "Watermark"
Watermark.Size = UDim2.new(0.2, 0, 0.05, 0)
Watermark.Position = UDim2.new(0.8, 0, 0.95, 0)
Watermark.BackgroundTransparency = 1
Watermark.Text = "By Mr.Key"
Watermark.TextColor3 = COLORS.TEXT_INSTRUCT
Watermark.TextScaled = true
Watermark.Font = Enum.Font.SciFi
Watermark.TextTransparency = 0.7
Watermark.Parent = HardcorePanel

local InstructionsLabel = Instance.new("TextLabel")
InstructionsLabel.Name = "InstructionsLabel"
InstructionsLabel.Size = UDim2.new(1, 0, 0.05, 0)
InstructionsLabel.Position = UDim2.new(0, 0, 1.05, 0)
InstructionsLabel.BackgroundTransparency = 1
InstructionsLabel.Text = "按 T 键打开/关闭面板"
InstructionsLabel.TextColor3 = COLORS.TEXT_INSTRUCT
InstructionsLabel.TextScaled = true
InstructionsLabel.Font = Enum.Font.SciFi
InstructionsLabel.TextTransparency = 0.7
InstructionsLabel.Parent = MainFrame

local isPanelOpen = false

local function togglePanel(show)
    if show then
        MainFrame.Visible = true
        MainFrame.Position = UDim2.new(0.35, 0, 0.2, 0)
        MainFrame.Size = UDim2.new(0.3, 0, 0, 0)
        
        local openTween = TweenService:Create(
            MainFrame,
            TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {
                Size = UDim2.new(0.3, 0, 0.5, 0),
                Position = UDim2.new(0.35, 0, 0.25, 0)
            }
        )
        openTween:Play()
        isPanelOpen = true
    else
        local closeTween = TweenService:Create(
            MainFrame,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
            {
                Size = UDim2.new(0.3, 0, 0, 0),
                Position = UDim2.new(0.35, 0, 0.5, 0)
            }
        )
        closeTween:Play()
        
        closeTween.Completed:Connect(function()
            MainFrame.Visible = false
        end)
        isPanelOpen = false
    end
end

MobileIcon.Activated:Connect(function()
    isPanelOpen = not isPanelOpen
    togglePanel(isPanelOpen)
end)

-- 键盘T键控制
local TPressed = false

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.T then
        TPressed = true
    end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.T and TPressed then
        TPressed = false
        isPanelOpen = not isPanelOpen
        togglePanel(isPanelOpen)
    end
end)


local dragging = false
local dragInput = nil
local dragStart = nil
local startPos = nil

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)