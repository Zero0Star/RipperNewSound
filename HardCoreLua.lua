local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
    local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local gui = player:WaitForChild("PlayerGui")

local gameData = {
    gameActive = false,
    gameDuration = 61,
    maxPressure = 5,
    currentPressure = 5,
    remainingTime = 61,
    escapeForce = 0.03,
    recoveryRate = 1,
    drainRate = 1,
    lastSlamTime = 0,
    minSlamInterval = 2,
    maxSlamInterval = 6,
    currentSlamInterval = 4,
    timeProgress = 0
}

local function showKillEffect()
    local playerGui = player:WaitForChild("PlayerGui")
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "KillEffect"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui
    
    for _, child in ipairs(screenGui:GetChildren()) do
        child:Destroy()
    end

    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://112123002526111"
    sound.Volume = 4
    sound.Parent = workspace
    sound:Play()
    game:GetService("Debris"):AddItem(sound, sound.TimeLength + 1)
    
    local image = Instance.new("ImageLabel")
    image.Image = "rbxassetid://99207315574595"
    image.Size = UDim2.new(0, 10, 0, 10)
    image.Position = UDim2.new(0.5, 0, 0.5, 0)
    image.AnchorPoint = Vector2.new(0.5, 0.5)
    image.BackgroundTransparency = 1
    image.ScaleType = Enum.ScaleType.Fit
    image.SizeConstraint = Enum.SizeConstraint.RelativeXY
    image.Parent = screenGui
    
    TweenService:Create(image, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(1.5, 0, 1.5, 0)
    }):Play()
    
    wait(0.3)

    local time = 0
    local duration = 0.8
    
    while time < duration do
        time = time + wait()
        local shakeX = math.sin(time * 30) * 0.002
        local shakeY = math.cos(time * 28) * 0.002
        
        image.Position = UDim2.new(0.5 + shakeX, 0, 0.5 + shakeY, 0)
    end

    replicatesignal(game.Players.LocalPlayer.Kill)
    
    TweenService:Create(image, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        ImageTransparency = 1
    }):Play()
    
    wait(0.2)
    image:Destroy()
    wait(0.5)
    screenGui:Destroy()
end

local function showSurviveEffect()
    if workspace:FindFirstChild("Z-367") then
        workspace["Z-367"]:Destroy()
    end
end

local function GitAud(soundgit, filename)
    local url = soundgit
    local FileName = filename
    writefile(FileName .. ".mp3", game:HttpGet(url))
    return (getcustomasset or getsynasset)(FileName .. ".mp3")
end

local function CustomGitSound(soundlink, vol, filename)
    local sound = Instance.new("Sound")
    sound.SoundId = GitAud(soundlink, filename)
    sound.Parent = workspace
    sound.Name = filename or "Music"
    sound.Volume = vol
    sound:Play()
    return sound
end

local function createGameUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "PressureMinigame"
    screenGui.Enabled = false
    screenGui.DisplayOrder = 10
    screenGui.Parent = gui
    
    local background = Instance.new("Frame")
    background.Name = "Background"
    background.Size = UDim2.new(1, 0, 1, 0)
    background.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    background.BackgroundTransparency = 1
    background.ZIndex = 1
    background.Parent = screenGui
    
    local centerDot = Instance.new("Frame")
    centerDot.Name = "CenterDot"
    centerDot.Size = UDim2.new(0, 8, 0, 8)
    centerDot.Position = UDim2.new(0.5, -4, 0.5, -4)
    centerDot.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    centerDot.BorderSizePixel = 0
    centerDot.AnchorPoint = Vector2.new(0.5, 0.5)
    centerDot.ZIndex = 5
    centerDot.BackgroundTransparency = 1
    
    local dotCorner = Instance.new("UICorner")
    dotCorner.CornerRadius = UDim.new(1, 0)
    dotCorner.Parent = centerDot
    
    local centerCircle = Instance.new("Frame")
    centerCircle.Name = "CenterCircle"
    centerCircle.Size = UDim2.new(0, 100, 0, 100)
    centerCircle.Position = UDim2.new(0.5, -50, 0.5, -50)
    centerCircle.BackgroundTransparency = 1
    centerCircle.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
    centerCircle.BorderColor3 = Color3.fromRGB(180, 180, 180)
    centerCircle.BorderSizePixel = 2
    centerCircle.AnchorPoint = Vector2.new(0.5, 0.5)
    centerCircle.ZIndex = 4
    centerCircle.BackgroundTransparency = 1
    
    local circleCorner = Instance.new("UICorner")
    circleCorner.CornerRadius = UDim.new(1, 0)
    circleCorner.Parent = centerCircle
    
    local controlBall = Instance.new("Frame")
    controlBall.Name = "ControlBall"
    controlBall.Size = UDim2.new(0, 30, 0, 30)
    controlBall.Position = UDim2.new(0.5, -15, 0.5, -15)
    controlBall.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    controlBall.BorderSizePixel = 0
    controlBall.AnchorPoint = Vector2.new(0.5, 0.5)
    controlBall.ZIndex = 6
    controlBall.BackgroundTransparency = 1
    
    local ballCorner = Instance.new("UICorner")
    ballCorner.CornerRadius = UDim.new(1, 0)
    ballCorner.Parent = controlBall
    
    local pressureBack = Instance.new("Frame")
    pressureBack.Name = "PressureBack"
    pressureBack.Size = UDim2.new(0.6, 0, 0, 30)
    pressureBack.Position = UDim2.new(0.2, 0, 0.05, 0)
    pressureBack.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    pressureBack.BorderSizePixel = 2
    pressureBack.BorderColor3 = Color3.fromRGB(80, 80, 80)
    pressureBack.ZIndex = 3
    pressureBack.BackgroundTransparency = 1
    
    local backCorner = Instance.new("UICorner")
    backCorner.CornerRadius = UDim.new(0, 6)
    backCorner.Parent = pressureBack
    
    local pressureFill = Instance.new("Frame")
    pressureFill.Name = "PressureFill"
    pressureFill.Size = UDim2.new(1, 0, 1, 0)
    pressureFill.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
    pressureFill.BorderSizePixel = 0
    pressureFill.ZIndex = 4
    pressureFill.BackgroundTransparency = 1
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(0, 6)
    fillCorner.Parent = pressureFill
    
    local pressureText = Instance.new("TextLabel")
    pressureText.Name = "PressureText"
    pressureText.Size = UDim2.new(1, 0, 1, 0)
    pressureText.BackgroundTransparency = 1
    pressureText.Text = "Stay in the center!"
    pressureText.TextColor3 = Color3.fromRGB(200, 200, 200)
    pressureText.TextSize = 18
    pressureText.Font = Enum.Font.GothamBold
    pressureText.TextStrokeTransparency = 0.5
    pressureText.ZIndex = 5
    pressureText.TextTransparency = 1
    
    local timerText = Instance.new("TextLabel")
    timerText.Name = "Timer"
    timerText.Size = UDim2.new(0.3, 0, 0, 40)
    timerText.Position = UDim2.new(0.35, 0, 0.1, 0)
    timerText.BackgroundTransparency = 1
    timerText.Text = "01:01"
    timerText.TextColor3 = Color3.fromRGB(200, 200, 200)
    timerText.TextSize = 36
    timerText.Font = Enum.Font.GothamBold
    timerText.TextStrokeTransparency = 0.5
    timerText.ZIndex = 3
    timerText.TextTransparency = 1
    
    pressureFill.Parent = pressureBack
    pressureText.Parent = pressureBack
    centerDot.Parent = screenGui
    centerCircle.Parent = screenGui
    controlBall.Parent = screenGui
    pressureBack.Parent = screenGui
    timerText.Parent = screenGui
    
    return {
        ScreenGui = screenGui,
        Background = background,
        Ball = controlBall,
        CenterDot = centerDot,
        CenterCircle = centerCircle,
        PressureBack = pressureBack,
        PressureFill = pressureFill,
        PressureText = pressureText,
        Timer = timerText
    }
end

local function fadeInUI(ui)
    ui.ScreenGui.Enabled = true
    
    local fadeTime = 0.8
    local fadeInfo = TweenInfo.new(fadeTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    
    TweenService:Create(ui.Background, fadeInfo, {BackgroundTransparency = 0.7}):Play()
    
    wait(0.2)
    TweenService:Create(ui.CenterDot, fadeInfo, {BackgroundTransparency = 0}):Play()
    wait(0.1)
    TweenService:Create(ui.CenterCircle, fadeInfo, {BackgroundTransparency = 0.7, BorderColor3 = Color3.fromRGB(180, 180, 180)}):Play()
    wait(0.1)
    TweenService:Create(ui.Ball, fadeInfo, {BackgroundTransparency = 0}):Play()
    wait(0.1)
    TweenService:Create(ui.PressureBack, fadeInfo, {BackgroundTransparency = 0.3}):Play()
    TweenService:Create(ui.PressureFill, fadeInfo, {BackgroundTransparency = 0}):Play()
    TweenService:Create(ui.PressureText, TweenInfo.new(fadeTime, Enum.EasingStyle.Linear), {TextTransparency = 0}):Play()
    TweenService:Create(ui.Timer, TweenInfo.new(fadeTime, Enum.EasingStyle.Linear), {TextTransparency = 0}):Play()
    
    wait(fadeTime)
end

local function fadeOutUI(ui, result)
    local fadeTime = 0.5
    local fadeInfo = TweenInfo.new(fadeTime, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
    
    wait(1.5)
    
    TweenService:Create(ui.Background, fadeInfo, {BackgroundTransparency = 1}):Play()
    TweenService:Create(ui.CenterDot, fadeInfo, {BackgroundTransparency = 1}):Play()
    TweenService:Create(ui.CenterCircle, fadeInfo, {BackgroundTransparency = 1}):Play()
    TweenService:Create(ui.Ball, fadeInfo, {BackgroundTransparency = 1}):Play()
    TweenService:Create(ui.PressureBack, fadeInfo, {BackgroundTransparency = 1}):Play()
    TweenService:Create(ui.PressureFill, fadeInfo, {BackgroundTransparency = 1}):Play()
    TweenService:Create(ui.PressureText, TweenInfo.new(fadeTime), {TextTransparency = 1}):Play()
    TweenService:Create(ui.Timer, TweenInfo.new(fadeTime), {TextTransparency = 1}):Play()
    
    wait(fadeTime)
    ui.ScreenGui:Destroy()
end

local function applySlamForce()
    local forceMultiplier = 0.12
    local angle = math.random() * math.pi * 2
    return Vector2.new(
        math.cos(angle) * forceMultiplier,
        math.sin(angle) * forceMultiplier
    )
end

local function updateSlamInterval(gameProgress)
    local minStart = 2
    local maxStart = 6
    local minEnd = 1
    local maxEnd = 4
    
    local currentMin = minStart + (minEnd - minStart) * gameProgress
    local currentMax = maxStart + (maxEnd - maxStart) * gameProgress
    
    local randomInterval = currentMin + (currentMax - currentMin) * math.random()
    
    return randomInterval, currentMin, currentMax
end

local function startGame()
    local targetAudioUrl = "https://github.com/Zero0Star/RipperNewSound/blob/master/Z367Music.mp3?raw=true"
    local localFileName = "Z367Music"
    
    local gameMusic = nil
    local success, errorMsg = pcall(function()
        gameMusic = CustomGitSound(targetAudioUrl, 3, localFileName)
    end)
    
    if not success then
        gameMusic = Instance.new("Sound")
        gameMusic.Name = "Z367MusicFallback"
        gameMusic.Volume = 4
        gameMusic.Parent = workspace
    end
    
    if gameMusic then
        repeat
            wait(0.1)
        until gameMusic.IsPlaying
    end
    
    local ui = createGameUI()
    fadeInUI(ui)
    
    gameData.gameActive = true
    gameData.currentPressure = gameData.maxPressure
    gameData.remainingTime = gameData.gameDuration
    gameData.lastSlamTime = tick()
    gameData.timeProgress = 0
    
    local initialInterval = 2 + (6 - 2) * math.random()
    gameData.currentSlamInterval = initialInterval
    
    local ballPos = Vector2.new(0.5, 0.5)
    local ballVelocity = Vector2.new(0, 0)
    local isDragging = false
    local lastMousePos = Vector2.new(0, 0)
    local mouseDown = false
    local isMouseControl = true
    
    local mouseSensitivity = 0.0006
    local touchSensitivity = 0.0008
    
    local viewportSize = workspace.CurrentCamera.ViewportSize
    local screenCenter = Vector2.new(viewportSize.X / 2, viewportSize.Y / 2)
    
    local inputBeganConnection = UserInputService.InputBegan:Connect(function(input)
        if not gameData.gameActive then return end
        
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            mouseDown = true
            isDragging = true
            lastMousePos = Vector2.new(input.Position.X, input.Position.Y)
        elseif input.UserInputType == Enum.UserInputType.Touch then
            mouseDown = true
            isDragging = true
            isMouseControl = false
            lastMousePos = Vector2.new(input.Position.X, input.Position.Y)
        end
    end)
    
    local inputEndedConnection = UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or 
           input.UserInputType == Enum.UserInputType.Touch then
            mouseDown = false
            isDragging = false
        end
    end)
    
    local inputChangedConnection = UserInputService.InputChanged:Connect(function(input)
        if not gameData.gameActive or not mouseDown then return end
        
        if input.UserInputType == Enum.UserInputType.MouseMovement and isMouseControl then
            local currentMousePos = Vector2.new(input.Position.X, input.Position.Y)
            local delta = currentMousePos - lastMousePos
            
            ballVelocity = ballVelocity + Vector2.new(delta.X, delta.Y) * mouseSensitivity
            
            lastMousePos = currentMousePos
            
        elseif input.UserInputType == Enum.UserInputType.Touch and not isMouseControl then
            local currentTouchPos = Vector2.new(input.Position.X, input.Position.Y)
            local delta = currentTouchPos - lastMousePos
            
            ballVelocity = ballVelocity + Vector2.new(delta.X, delta.Y) * touchSensitivity
            
            lastMousePos = currentTouchPos
        end
    end)
    
    local lastUpdate = tick()
    local gameLoopConnection
    
    local function cleanupGame()
        if gameData.gameActive then
            gameData.gameActive = false
        end
        
        if inputBeganConnection then
            inputBeganConnection:Disconnect()
        end
        
        if inputEndedConnection then
            inputEndedConnection:Disconnect()
        end
        
        if inputChangedConnection then
            inputChangedConnection:Disconnect()
        end
        
        if gameLoopConnection then
            gameLoopConnection:Disconnect()
        end
        
        if gameMusic and gameMusic.Parent then
            gameMusic:Stop()
            wait(0.1)
            gameMusic:Destroy()
        end
    end
    
    gameLoopConnection = RunService.RenderStepped:Connect(function(deltaTime)
        if not gameData.gameActive then
            cleanupGame()
            return
        end
        
        local currentTime = tick()
        local delta = currentTime - lastUpdate
        lastUpdate = currentTime
        
        local microShake = Vector2.new(
            (math.random() - 0.5) * 0.0008,
            (math.random() - 0.5) * 0.0008
        )
        ballVelocity = ballVelocity + microShake
        
        gameData.timeProgress = 1 - (gameData.remainingTime / gameData.gameDuration)
        
        if currentTime - gameData.lastSlamTime >= gameData.currentSlamInterval then
            local slamForce = applySlamForce()
            ballVelocity = ballVelocity + slamForce
            gameData.lastSlamTime = currentTime
            
            local newInterval, currentMin, currentMax = updateSlamInterval(gameData.timeProgress)
            gameData.currentSlamInterval = newInterval
            
            ui.CenterCircle.BorderColor3 = Color3.fromRGB(255, 100, 100)
            ui.CenterCircle.BorderSizePixel = 4
            wait(0.1)
            ui.CenterCircle.BorderColor3 = Color3.fromRGB(180, 180, 180)
            ui.CenterCircle.BorderSizePixel = 2
        end
        
        ballVelocity = ballVelocity * 0.88
        
        local maxSpeed = 0.035
        if ballVelocity.Magnitude > maxSpeed then
            ballVelocity = ballVelocity.Unit * maxSpeed
        end
        
        ballPos = ballPos + ballVelocity
        ballPos = Vector2.new(
            math.clamp(ballPos.X, 0.05, 0.95),
            math.clamp(ballPos.Y, 0.05, 0.95)
        )
        
        ui.Ball.Position = UDim2.new(ballPos.X, -15, ballPos.Y, -15)
        
        local center = Vector2.new(0.5, 0.5)
        local distance = (ballPos - center).Magnitude
        local isInCenter = distance < 0.05
        
        if isInCenter then
            gameData.currentPressure = math.min(gameData.maxPressure, 
                gameData.currentPressure + gameData.recoveryRate * delta)
            ui.PressureFill.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
            ui.Ball.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
        else
            gameData.currentPressure = gameData.currentPressure - gameData.drainRate * delta
            ui.PressureFill.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
            ui.Ball.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
            
            local distanceMultiplier = 1 + (distance - 0.05) * 5
            gameData.currentPressure = gameData.currentPressure - (distanceMultiplier - 1) * delta
        end
        
        local pressurePercent = gameData.currentPressure / gameData.maxPressure
        ui.PressureFill.Size = UDim2.new(pressurePercent, 0, 1, 0)
        ui.PressureText.Text = "Stay in the center!"
        
        gameData.remainingTime = gameData.remainingTime - delta
        local seconds = math.max(0, math.ceil(gameData.remainingTime))
        local minutes = math.floor(seconds / 60)
        local remainingSeconds = seconds % 60
        ui.Timer.Text = string.format("%02d:%02d", minutes, remainingSeconds)
        
        if not isInCenter then
            local pulse = math.sin(currentTime * 8) * 0.3 + 0.7
            ui.Ball.BackgroundTransparency = 1 - pulse
        else
            ui.Ball.BackgroundTransparency = 0
        end
        
        if gameData.currentPressure <= 0 then
            fadeOutUI(ui, "lose")
            showKillEffect()
            cleanupGame()
        elseif gameData.remainingTime <= 0 then
            fadeOutUI(ui, "win")
            showSurviveEffect()
            cleanupGame()
        end
        
        if gameMusic and not gameMusic.IsPlaying and gameData.gameActive then
            wait(0.5)
            if gameMusic and gameMusic.Parent then
                gameMusic:Destroy()
                gameMusic = nil
            end
        end
    end)
    
    return ui
end
wait(2)
if not gameData.gameActive then
    startGame()
end
end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://111351357978027" then
        local parent = sound.Parent
        if parent and parent.Name == "Scary Entity" then
            local grandParent = parent.Parent
                if not checkedEntities[grandParent] then
                    checkedEntities[grandParent] = true
                    runEvent()
                end
            end
        end
    end

workspace.DescendantAdded:Connect(function(obj)
    wait(0.1)
    if obj:IsA("Sound") then
        checkSound(obj)
        if not listeningSounds[obj] then
            listeningSounds[obj] = true
            obj:GetPropertyChangedSignal("SoundId"):Connect(function()
                checkSound(obj)
            end)
        end
    end
end)

for _, entity in pairs(workspace:GetChildren()) do
    if entity.Name == "CustomEntity" then
        local scary = entity:FindFirstChild("Scary Entity")
        if scary then
            for _, child in pairs(scary:GetChildren()) do
                if child:IsA("Sound") then
                    checkSound(child)
                    if not listeningSounds[child] then
                        listeningSounds[child] = true
                        child:GetPropertyChangedSignal("SoundId"):Connect(function()
                            checkSound(child)
                        end)
                    end
                end
            end
        end
    end
end

---------A60
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()
local entity = spawner.Create({
	Entity = {
		Name = "A60",
		Asset = "14169212325",
		HeightOffset = 0
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
		Values = {1.5, 20, 0.1, 1}
	},
	Movement = {
		Speed = 150,
		Delay = 3,
		Reversed = false
	},
	Rebounding = {
		Enabled = true,
		Type = "ambush",
		Min = 3,
		Max = 3,
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
		Hints = {"你死于A60", "...", "你会从Ambush那学会点什么", "他随时可能出现!"},
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
end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://8325526433" then
        local parent = sound.Parent
        if parent and parent.Name == "Scary Entity" then
            local grandParent = parent.Parent
            if grandParent and grandParent.Name == "CustomEntity" then
                if not checkedEntities[grandParent] then
                    checkedEntities[grandParent] = true
                    runEvent()
                end
            end
        end
    end
end

workspace.DescendantAdded:Connect(function(obj)
    wait(0.1)
    if obj:IsA("Sound") then
        checkSound(obj)
        if not listeningSounds[obj] then
            listeningSounds[obj] = true
            obj:GetPropertyChangedSignal("SoundId"):Connect(function()
                checkSound(obj)
            end)
        end
    end
end)

for _, entity in pairs(workspace:GetChildren()) do
    if entity.Name == "CustomEntity" then
        local scary = entity:FindFirstChild("Scary Entity")
        if scary then
            for _, child in pairs(scary:GetChildren()) do
                if child:IsA("Sound") then
                    checkSound(child)
                    if not listeningSounds[child] then
                        listeningSounds[child] = true
                        child:GetPropertyChangedSignal("SoundId"):Connect(function()
                            checkSound(child)
                        end)
                    end
                end
            end
        end
    end
end

--------A60PHASE2-ROOM
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

local waypointFolder = Workspace:FindFirstChild("A60_Waypoints")
if not waypointFolder then
    waypointFolder = Instance.new("Folder")
    waypointFolder.Name = "A60_Waypoints"
    waypointFolder.Parent = Workspace
end

for _, wp in ipairs(waypointFolder:GetChildren()) do
    wp:Destroy()
end

local allWaypoints = {}
local figureNodes = {}

-- 查找名为"50"的房间
local currentRooms = Workspace:FindFirstChild("CurrentRooms")
if currentRooms then
    local room50 = currentRooms:FindFirstChild("50")
    if room50 and room50:IsA("Model") then
        print("找到房间50")
        
        local figureSetup = room50:FindFirstChild("FigureSetup")
        if figureSetup then
            print("找到FigureSetup")
            
            local figureNodesFolder = figureSetup:FindFirstChild("FigureNodes")
            if figureNodesFolder then
                print("找到FigureNodes")
                
                local node1 = figureNodesFolder:FindFirstChild("1")
                if node1 and node1:IsA("BasePart") then
                    print("找到FigureNodes/1，创建路径点")
                    
                    table.insert(figureNodes, {
                        part = node1,
                        position = node1.Position
                    })
                    
                    for _ = 1, 2 do
                        table.insert(allWaypoints, {
                            part = node1,
                            position = node1.Position,
                            isOnePart = true
                        })
                    end
                    
                    for _ = 1, 3 do
                        table.insert(allWaypoints, {
                            part = node1,
                            position = node1.Position + Vector3.new(
                                math.random(-3, 3),
                                math.random(-0.5, 0.5),
                                math.random(-3, 3)
                            ),
                            isOnePart = true,
                            isOffset = true
                        })
                    end
                    
                    for _ = 1, math.random(3, 6) do
                        for i = #allWaypoints, 2, -1 do
                            local j = math.random(i)
                            allWaypoints[i], allWaypoints[j] = allWaypoints[j], allWaypoints[i]
                        end
                    end
                else
                    print("FigureNodes/1 不是BasePart或不存在")
                end
            else
                print("找不到FigureNodes")
            end
        else
            print("找不到FigureSetup")
        end
    else
        print("找不到房间50")
        
        -- 没有房间50时，创建普通路径点
        local waypointCount = 0
        
        local function processDoor(doorModel, roomName, doorType)
            local position
            
            if doorModel.PrimaryPart then
                position = doorModel:GetPivot().Position
            else
                local parts = {}
                for _, part in ipairs(doorModel:GetDescendants()) do
                    if part:IsA("BasePart") then
                        table.insert(parts, part.Position)
                    end
                end
                
                if #parts > 0 then
                    local sum = Vector3.new(0, 0, 0)
                    for _, pos in ipairs(parts) do
                        sum = sum + pos
                    end
                    position = sum / #parts
                end
            end
            
            if position then
                waypointCount = waypointCount + 1
                
                local waypoint = Instance.new("Part")
                waypoint.Name = "A60_WP_" .. waypointCount
                waypoint.Size = Vector3.new(2, 2, 2)
                waypoint.Position = position
                waypoint.Anchored = true
                waypoint.CanCollide = false
                waypoint.Transparency = 1
                waypoint.Parent = waypointFolder
                
                for _ = 1, 2 do
                    table.insert(allWaypoints, {
                        part = waypoint,
                        position = waypoint.Position,
                        room = roomName,
                        index = waypointCount,
                        doorType = doorType,
                        isDoor = true
                    })
                end
                
                for _ = 1, 4 do
                    local offsetPos = position + Vector3.new(
                        math.random(-4, 4),
                        math.random(0, 2),
                        math.random(-4, 4)
                    )
                    
                    waypointCount = waypointCount + 1
                    local offsetWaypoint = Instance.new("Part")
                    offsetWaypoint.Name = "A60_WP_" .. waypointCount .. "_Offset"
                    offsetWaypoint.Size = Vector3.new(2, 2, 2)
                    offsetWaypoint.Position = offsetPos
                    offsetWaypoint.Anchored = true
                    offsetWaypoint.CanCollide = false
                    offsetWaypoint.Transparency = 1
                    offsetWaypoint.Parent = waypointFolder
                    
                    table.insert(allWaypoints, {
                        part = offsetWaypoint,
                        position = offsetPos,
                        room = roomName,
                        index = waypointCount,
                        doorType = doorType,
                        isDoor = true,
                        isOffset = true
                    })
                end
            end
        end
        
        for _, room in ipairs(currentRooms:GetChildren()) do
            if room:IsA("Model") then
                for _, child in ipairs(room:GetDescendants()) do
                    if child:IsA("Model") and (child.Name == "Door" or child.Name == "DoorNormal" or child.Name == "SideroomDupe") then
                        processDoor(child, room.Name, child.Name)
                    end
                end
            end
        end
        
        for _ = 1, math.random(3, 6) do
            for i = #allWaypoints, 2, -1 do
                local j = math.random(i)
                allWaypoints[i], allWaypoints[j] = allWaypoints[j], allWaypoints[i]
            end
        end
    end
else
    print("找不到CurrentRooms")
end

if #allWaypoints == 0 then
    print("没有创建任何路径点")
    return
end

local a60Model
local success, result = pcall(function()
    return game:GetObjects("rbxassetid://85615143036194")[1]
end)

if success and result then
    a60Model = result
    a60Model.Name = "A60"
    a60Model.Parent = Workspace
    
    if #allWaypoints > 0 then
        a60Model:PivotTo(CFrame.new(allWaypoints[1].position + Vector3.new(5, 0, 5)))
    end
else
    a60Model = Instance.new("Model")
    a60Model.Name = "A60"
    
    local torso = Instance.new("Part")
    torso.Name = "Torso"
    torso.Size = Vector3.new(2, 4, 2)
    torso.Position = Vector3.new(0, 5, 0)
    torso.Anchored = false
    torso.CanCollide = true
    torso.Color = Color3.fromRGB(139, 69, 19)
    torso.Material = Enum.Material.Wood
    torso.Parent = a60Model
    
    a60Model.PrimaryPart = torso
    a60Model.Parent = Workspace
end

local function addFaceParticleAnimation()
    -- 查找名为"Face"的ParticleEmitter
    local faceParticle
    for _, child in ipairs(a60Model:GetDescendants()) do
        if child:IsA("ParticleEmitter") and child.Name == "Face" then
            faceParticle = child
            break
        end
    end
    
    if not faceParticle then
        print("警告：未找到名为'Face'的ParticleEmitter")
        return
    end
    
    print("找到面部粒子发射器")
    
    -- 粒子纹理ID列表
    local particleTextures = {
        "rbxassetid://16020415559",
        "rbxassetid://16020423090", 
        "rbxassetid://16020425703",
        "rbxassetid://16020417711",
        "rbxassetid://16020432826",
        "rbxassetid://16020430685",
        "rbxassetid://16020435171"
    }
    
    local currentTextureIndex = 1
    local animationSpeed = 0.1
    local isAnimating = true
    
    -- 保存原始粒子设置
    local originalTexture = faceParticle.Texture
    local originalEnabled = faceParticle.Enabled
    
    -- 面部粒子动画循环
    coroutine.wrap(function()
        while a60Model and a60Model.Parent and faceParticle and faceParticle.Parent and isAnimating do
            -- 确保粒子发射器是启用的
            faceParticle.Enabled = true
            
            -- 应用当前纹理
            faceParticle.Texture = particleTextures[currentTextureIndex]
            
            -- 更新到下一个纹理
            currentTextureIndex = currentTextureIndex + 1
            if currentTextureIndex > #particleTextures then
                currentTextureIndex = 1
            end
            
            -- 随机速度变化
            local currentSpeed = animationSpeed * (0.8 + math.random() * 0.4)
            wait(currentSpeed)
        end
    end)()
    
    -- 添加控制功能
    local function setAnimationSpeed(speed)
        animationSpeed = math.max(0.05, math.min(0.5, speed))
    end
    
    local function stopAnimation()
        isAnimating = false
        -- 恢复原始纹理
        faceParticle.Texture = originalTexture
    end
    
    local function startAnimation()
        isAnimating = true
    end
    
    -- 添加到键盘控制
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        if input.KeyCode == Enum.KeyCode.F then
            isAnimating = not isAnimating
            if isAnimating then
                print("面部粒子动画: 开启")
            else
                print("面部粒子动画: 关闭")
            end
        end
    end)
    
    return {
        setSpeed = setAnimationSpeed,
        stop = stopAnimation,
        start = startAnimation
    }
end

local currentWaypointIndex = 1
local isMoving = true
local baseSpeed = 60
local rotationSpeed = 0.6
local reachedDistance = 8.0
local smoothFactor = 0.6
local visitCounts = {}
local lastVisitTime = {}

for i = 1, #allWaypoints do
    visitCounts[i] = 0
    lastVisitTime[i] = 0
end

local function getWaypoint()
    if #allWaypoints == 0 then
        return nil, 1
    end
    
    local currentTime = tick()
    local validWaypoints = {}
    
    for i, wp in ipairs(allWaypoints) do
        if wp and wp.part and wp.part.Parent then
            if currentTime - lastVisitTime[i] > 2 then
                table.insert(validWaypoints, {index = i, waypoint = wp})
            end
        end
    end
    
    if #validWaypoints > 0 then
        local choice = validWaypoints[math.random(1, #validWaypoints)]
        currentWaypointIndex = choice.index
        return choice.waypoint, currentWaypointIndex
    end
    
    for i = 1, #allWaypoints do
        local wp = allWaypoints[i]
        if wp and wp.part and wp.part.Parent then
            currentWaypointIndex = i
            return wp, currentWaypointIndex
        end
    end
    
    return nil, 1
end

local function checkReachedWaypoint(waypoint)
    if not waypoint or not waypoint.part or not waypoint.part.Parent then
        return false
    end
    
    local monsterPos = a60Model:GetPivot().Position
    local waypointPos = waypoint.position
    local distance = (monsterPos - waypointPos).Magnitude
    
    return distance <= reachedDistance
end

local lastUpdate = tick()
local currentTarget, currentIndex = getWaypoint()
local velocity = Vector3.new(0, 0, 0)
local wobbleIntensity = 0.15
local wobbleSpeed = 3.0
local wobbleTime = 0
local targetSwitchTime = 0
local minTargetTime = 1.0
local maxTargetTime = 5.0
local speedMultiplier = 1.0
local zigzagAmount = 0
local zigzagSpeed = 2.0
local zigzagIntensity = 0.3

print("总路径点数量: " .. #allWaypoints)
if #figureNodes > 0 then
    print("模式: 房间50模式 (使用FigureNodes/1)")
else
    print("模式: 普通门路径点")
end

coroutine.wrap(function()
    wait(60)
    
    for _, waypoint in ipairs(allWaypoints) do
        if not waypoint.isOnePart and waypoint.part and waypoint.part.Parent then
            waypoint.part:Destroy()
        end
    end
    
    if a60Model and a60Model.Parent then
        a60Model:Destroy()
    end
    
    if waypointFolder and waypointFolder.Parent then
        waypointFolder:Destroy()
    end
end)()

coroutine.wrap(function()
    while a60Model and a60Model.Parent do
        local deltaTime = math.min(tick() - lastUpdate, 0.033)
        lastUpdate = tick()
        wobbleTime = wobbleTime + deltaTime * wobbleSpeed
        zigzagAmount = zigzagAmount + deltaTime * zigzagSpeed
        
        if isMoving and currentTarget then
            local monsterCFrame = a60Model:GetPivot()
            local monsterPos = monsterCFrame.Position
            local targetPos = currentTarget.position
            
            local direction = (targetPos - monsterPos)
            local distance = direction.Magnitude
            
            if distance > 0.1 then
                local moveDirection = direction.Unit
                
                local targetSpeed = baseSpeed * speedMultiplier
                
                if math.random() < 0.4 then
                    speedMultiplier = 0.7 + math.random() * 1.3
                end
                
                if distance < 20 then
                    targetSpeed = targetSpeed * 0.8
                elseif distance > 40 then
                    targetSpeed = targetSpeed * 1.4
                end
                
                if tick() - targetSwitchTime > minTargetTime + math.random() * (maxTargetTime - minTargetTime) then
                    if math.random() < 0.6 then
                        currentTarget, currentIndex = getWaypoint()
                        targetSwitchTime = tick()
                    end
                end
                
                local zigzagOffset = Vector3.new(
                    math.sin(zigzagAmount) * zigzagIntensity,
                    0,
                    math.cos(zigzagAmount * 0.7) * zigzagIntensity * 0.5
                )
                
                moveDirection = (moveDirection + zigzagOffset * 0.1).Unit
                
                local targetVelocity = moveDirection * targetSpeed
                velocity = velocity:Lerp(targetVelocity, smoothFactor)
                
                local wobbleOffset = Vector3.new(
                    math.sin(wobbleTime) * wobbleIntensity * 2.0,
                    math.cos(wobbleTime * 1.3) * wobbleIntensity * 1.0,
                    math.cos(wobbleTime * 0.9) * wobbleIntensity * 1.5
                )
                
                local newPosition = monsterPos + (velocity * deltaTime) + wobbleOffset
                
                if moveDirection.Magnitude > 0.1 then
                    local yawOffset = math.rad(math.sin(wobbleTime * 0.7) * 8)
                    local pitchOffset = math.rad(math.cos(wobbleTime * 1.1) * 6)
                    local rollOffset = math.rad(math.sin(wobbleTime * 1.4) * 4)
                    
                    local rotatedDirection = CFrame.Angles(pitchOffset, yawOffset, rollOffset) * moveDirection
                    
                    local lookAtCFrame = CFrame.lookAt(newPosition, newPosition + rotatedDirection)
                    a60Model:PivotTo(lookAtCFrame)
                end
                
                if checkReachedWaypoint(currentTarget) then
                    if currentIndex then
                        visitCounts[currentIndex] = (visitCounts[currentIndex] or 0) + 1
                        lastVisitTime[currentIndex] = tick()
                    end
                    
                    wait(math.random(0.05, 0.2))
                    
                    if math.random() < 0.8 then
                        currentTarget, currentIndex = getWaypoint()
                        targetSwitchTime = tick()
                    end
                    
                    velocity = velocity * 0.2
                end
            else
                if currentIndex then
                    visitCounts[currentIndex] = (visitCounts[currentIndex] or 0) + 1
                    lastVisitTime[currentIndex] = tick()
                end
                
                wait(math.random(0.05, 0.2))
                currentTarget, currentIndex = getWaypoint()
                targetSwitchTime = tick()
                velocity = Vector3.new(0, 0, 0)
            end
        end
        
        RunService.RenderStepped:Wait()
    end
end)()

local UserInputService = game:GetService("UserInputService")

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.R then
        currentTarget, currentIndex = getWaypoint()
        isMoving = true
        velocity = Vector3.new(0, 0, 0)
        speedMultiplier = 1.0
        
        for i = 1, #allWaypoints do
            visitCounts[i] = 0
            lastVisitTime[i] = 0
        end
        
        if #allWaypoints > 0 then
            a60Model:PivotTo(CFrame.new(allWaypoints[1].position + Vector3.new(5, 0, 5)))
        end
        
    elseif input.KeyCode == Enum.KeyCode.T then
        isMoving = not isMoving
        if isMoving then
            velocity = Vector3.new(0, 0, 0)
        end
    end
end)
local faceController
if a60Model then
    faceController = addFaceParticleAnimation()
end
end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://140305919092081" then
        local parent = sound.Parent
        if parent and parent.Name == "Scary Entity" then
            local grandParent = parent.Parent
            if grandParent and grandParent.Name == "CustomEntity" then
                if not checkedEntities[grandParent] then
                    checkedEntities[grandParent] = true
                    runEvent()
                end
            end
        end
    end
end

workspace.DescendantAdded:Connect(function(obj)
    wait(0.1)
    if obj:IsA("Sound") then
        checkSound(obj)
        if not listeningSounds[obj] then
            listeningSounds[obj] = true
            obj:GetPropertyChangedSignal("SoundId"):Connect(function()
                checkSound(obj)
            end)
        end
    end
end)

for _, entity in pairs(workspace:GetChildren()) do
    if entity.Name == "CustomEntity" then
        local scary = entity:FindFirstChild("Scary Entity")
        if scary then
            for _, child in pairs(scary:GetChildren()) do
                if child:IsA("Sound") then
                    checkSound(child)
                    if not listeningSounds[child] then
                        listeningSounds[child] = true
                        child:GetPropertyChangedSignal("SoundId"):Connect(function()
                            checkSound(child)
                        end)
                    end
                end
            end
        end
    end
end
------A60 PHASE2 LIB
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
   local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

local waypointFolder = Workspace:FindFirstChild("A60_Waypoints")
if not waypointFolder then
    waypointFolder = Instance.new("Folder")
    waypointFolder.Name = "A60_Waypoints"
    waypointFolder.Parent = Workspace
end

for _, wp in ipairs(waypointFolder:GetChildren()) do
    wp:Destroy()
end

local allWaypoints = {}
local figureNodes = {}

-- 查找所有名为"1"的Part
local function findAllOneParts(parent)
    for _, child in ipairs(parent:GetChildren()) do
        if child.Name == "1" and child:IsA("BasePart") then
            table.insert(figureNodes, {
                part = child,
                position = child.Position
            })
        end
        -- 递归查找子对象
        if #child:GetChildren() > 0 then
            findAllOneParts(child)
        end
    end
end

-- 从CurrentRooms开始查找
local currentRooms = Workspace:FindFirstChild("CurrentRooms")
if currentRooms then
    findAllOneParts(currentRooms)
end

-- 如果没找到，再从Workspace根目录查找
if #figureNodes == 0 then
    findAllOneParts(Workspace)
end

if #figureNodes > 0 then
    print("找到 " .. #figureNodes .. " 个名为'1'的Part")
    
    for _, node in ipairs(figureNodes) do
        print("  - 位置: " .. tostring(node.position))
    end
    
    for _, node in ipairs(figureNodes) do
        for _ = 1, 2 do
            table.insert(allWaypoints, {
                part = node.part,
                position = node.position,
                isOnePart = true
            })
        end
    end
    
    for _ = 1, 3 do
        for _, node in ipairs(figureNodes) do
            table.insert(allWaypoints, {
                part = node.part,
                position = node.position + Vector3.new(
                    math.random(-3, 3),
                    math.random(-0.5, 0.5),
                    math.random(-3, 3)
                ),
                isOnePart = true,
                isOffset = true
            })
        end
    end
    
    for _ = 1, math.random(3, 6) do
        for i = #allWaypoints, 2, -1 do
            local j = math.random(i)
            allWaypoints[i], allWaypoints[j] = allWaypoints[j], allWaypoints[i]
        end
    end
else
    print("没有找到名为'1'的Part，创建普通路径点")
    
    local currentRooms = Workspace:FindFirstChild("CurrentRooms")
    if currentRooms then
        local waypointCount = 0
        
        local function processDoor(doorModel, roomName, doorType)
            local position
            
            if doorModel.PrimaryPart then
                position = doorModel:GetPivot().Position
            else
                local parts = {}
                for _, part in ipairs(doorModel:GetDescendants()) do
                    if part:IsA("BasePart") then
                        table.insert(parts, part.Position)
                    end
                end
                
                if #parts > 0 then
                    local sum = Vector3.new(0, 0, 0)
                    for _, pos in ipairs(parts) do
                        sum = sum + pos
                    end
                    position = sum / #parts
                end
            end
            
            if position then
                waypointCount = waypointCount + 1
                
                local waypoint = Instance.new("Part")
                waypoint.Name = "A60_WP_" .. waypointCount
                waypoint.Size = Vector3.new(2, 2, 2)
                waypoint.Position = position
                waypoint.Anchored = true
                waypoint.CanCollide = false
                waypoint.Transparency = 1
                waypoint.Parent = waypointFolder
                
                for _ = 1, 2 do
                    table.insert(allWaypoints, {
                        part = waypoint,
                        position = waypoint.Position,
                        room = roomName,
                        index = waypointCount,
                        doorType = doorType,
                        isDoor = true
                    })
                end
                
                for _ = 1, 4 do
                    local offsetPos = position + Vector3.new(
                        math.random(-4, 4),
                        math.random(0, 2),
                        math.random(-4, 4)
                    )
                    
                    waypointCount = waypointCount + 1
                    local offsetWaypoint = Instance.new("Part")
                    offsetWaypoint.Name = "A60_WP_" .. waypointCount .. "_Offset"
                    offsetWaypoint.Size = Vector3.new(2, 2, 2)
                    offsetWaypoint.Position = offsetPos
                    offsetWaypoint.Anchored = true
                    offsetWaypoint.CanCollide = false
                    offsetWaypoint.Transparency = 1
                    offsetWaypoint.Parent = waypointFolder
                    
                    table.insert(allWaypoints, {
                        part = offsetWaypoint,
                        position = offsetPos,
                        room = roomName,
                        index = waypointCount,
                        doorType = doorType,
                        isDoor = true,
                        isOffset = true
                    })
                end
            end
        end
        
        for _, room in ipairs(currentRooms:GetChildren()) do
            if room:IsA("Model") then
                for _, child in ipairs(room:GetDescendants()) do
                    if child:IsA("Model") and (child.Name == "Door" or child.Name == "DoorNormal" or child.Name == "SideroomDupe") then
                        processDoor(child, room.Name, child.Name)
                    end
                end
            end
        end
        
        for _ = 1, math.random(3, 6) do
            for i = #allWaypoints, 2, -1 do
                local j = math.random(i)
                allWaypoints[i], allWaypoints[j] = allWaypoints[j], allWaypoints[i]
            end
        end
    end
end

local a60Model
local success, result = pcall(function()
    return game:GetObjects("rbxassetid://85615143036194")[1]
end)

if success and result then
    a60Model = result
    a60Model.Name = "A60"
    a60Model.Parent = Workspace
    
    if #allWaypoints > 0 then
        a60Model:PivotTo(CFrame.new(allWaypoints[1].position + Vector3.new(5, 0, 5)))
    end
else
    a60Model = Instance.new("Model")
    a60Model.Name = "A60"
    
    local torso = Instance.new("Part")
    torso.Name = "Torso"
    torso.Size = Vector3.new(2, 4, 2)
    torso.Position = Vector3.new(0, 5, 0)
    torso.Anchored = false
    torso.CanCollide = true
    torso.Color = Color3.fromRGB(139, 69, 19)
    torso.Material = Enum.Material.Wood
    torso.Parent = a60Model
    
    a60Model.PrimaryPart = torso
    a60Model.Parent = Workspace
end

local function addFaceParticleAnimation()
    -- 查找名为"Face"的ParticleEmitter
    local faceParticle
    for _, child in ipairs(a60Model:GetDescendants()) do
        if child:IsA("ParticleEmitter") and child.Name == "Face" then
            faceParticle = child
            break
        end
    end
    
    if not faceParticle then
        print("警告：未找到名为'Face'的ParticleEmitter")
        return
    end
    
    print("找到面部粒子发射器")
    
    -- 粒子纹理ID列表
    local particleTextures = {
        "rbxassetid://16020415559",
        "rbxassetid://16020423090", 
        "rbxassetid://16020425703",
        "rbxassetid://16020417711",
        "rbxassetid://16020432826",
        "rbxassetid://16020430685",
        "rbxassetid://16020435171"
    }
    
    local currentTextureIndex = 1
    local animationSpeed = 0.1
    local isAnimating = true
    
    -- 保存原始粒子设置
    local originalTexture = faceParticle.Texture
    local originalEnabled = faceParticle.Enabled
    
    -- 面部粒子动画循环
    coroutine.wrap(function()
        while a60Model and a60Model.Parent and faceParticle and faceParticle.Parent and isAnimating do
            -- 确保粒子发射器是启用的
            faceParticle.Enabled = true
            
            -- 应用当前纹理
            faceParticle.Texture = particleTextures[currentTextureIndex]
            
            -- 更新到下一个纹理
            currentTextureIndex = currentTextureIndex + 1
            if currentTextureIndex > #particleTextures then
                currentTextureIndex = 1
            end
            
            -- 随机速度变化
            local currentSpeed = animationSpeed * (0.8 + math.random() * 0.4)
            wait(currentSpeed)
        end
    end)()
    
    -- 添加控制功能
    local function setAnimationSpeed(speed)
        animationSpeed = math.max(0.05, math.min(0.5, speed))
    end
    
    local function stopAnimation()
        isAnimating = false
        -- 恢复原始纹理
        faceParticle.Texture = originalTexture
    end
    
    local function startAnimation()
        isAnimating = true
    end
    
    -- 添加到键盘控制
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        if input.KeyCode == Enum.KeyCode.F then
            isAnimating = not isAnimating
            if isAnimating then
                print("面部粒子动画: 开启")
            else
                print("面部粒子动画: 关闭")
            end
        end
    end)
    
    return {
        setSpeed = setAnimationSpeed,
        stop = stopAnimation,
        start = startAnimation
    }
end

local currentWaypointIndex = 1
local isMoving = true
local baseSpeed = 60
local rotationSpeed = 0.6
local reachedDistance = 8.0
local smoothFactor = 0.6
local visitCounts = {}
local lastVisitTime = {}

for i = 1, #allWaypoints do
    visitCounts[i] = 0
    lastVisitTime[i] = 0
end

local function getWaypoint()
    if #allWaypoints == 0 then
        return nil, 1
    end
    
    local currentTime = tick()
    local validWaypoints = {}
    
    for i, wp in ipairs(allWaypoints) do
        if wp and wp.part and wp.part.Parent then
            if currentTime - lastVisitTime[i] > 2 then
                table.insert(validWaypoints, {index = i, waypoint = wp})
            end
        end
    end
    
    if #validWaypoints > 0 then
        local choice = validWaypoints[math.random(1, #validWaypoints)]
        currentWaypointIndex = choice.index
        return choice.waypoint, currentWaypointIndex
    end
    
    for i = 1, #allWaypoints do
        local wp = allWaypoints[i]
        if wp and wp.part and wp.part.Parent then
            currentWaypointIndex = i
            return wp, currentWaypointIndex
        end
    end
    
    return nil, 1
end

local function checkReachedWaypoint(waypoint)
    if not waypoint or not waypoint.part or not waypoint.part.Parent then
        return false
    end
    
    local monsterPos = a60Model:GetPivot().Position
    local waypointPos = waypoint.position
    local distance = (monsterPos - waypointPos).Magnitude
    
    return distance <= reachedDistance
end

local lastUpdate = tick()
local currentTarget, currentIndex = getWaypoint()
local velocity = Vector3.new(0, 0, 0)
local wobbleIntensity = 0.15
local wobbleSpeed = 3.0
local wobbleTime = 0
local targetSwitchTime = 0
local minTargetTime = 1.0
local maxTargetTime = 5.0
local speedMultiplier = 1.0
local zigzagAmount = 0
local zigzagSpeed = 2.0
local zigzagIntensity = 0.3

print("总路径点数量: " .. #allWaypoints)
if #figureNodes > 0 then
    print("模式: 使用" .. #figureNodes .. "个'1' Part作为路径点")
else
    print("模式: 普通路径点")
end

coroutine.wrap(function()
    wait(60)
    
    for _, waypoint in ipairs(allWaypoints) do
        if not waypoint.isOnePart and waypoint.part and waypoint.part.Parent then
            waypoint.part:Destroy()
        end
    end
    
    if a60Model and a60Model.Parent then
        a60Model:Destroy()
    end
    
    if waypointFolder and waypointFolder.Parent then
        waypointFolder:Destroy()
    end
end)()

coroutine.wrap(function()
    while a60Model and a60Model.Parent do
        local deltaTime = math.min(tick() - lastUpdate, 0.033)
        lastUpdate = tick()
        wobbleTime = wobbleTime + deltaTime * wobbleSpeed
        zigzagAmount = zigzagAmount + deltaTime * zigzagSpeed
        
        if isMoving and currentTarget then
            local monsterCFrame = a60Model:GetPivot()
            local monsterPos = monsterCFrame.Position
            local targetPos = currentTarget.position
            
            local direction = (targetPos - monsterPos)
            local distance = direction.Magnitude
            
            if distance > 0.1 then
                local moveDirection = direction.Unit
                
                local targetSpeed = baseSpeed * speedMultiplier
                
                if math.random() < 0.4 then
                    speedMultiplier = 0.7 + math.random() * 1.3
                end
                
                if distance < 20 then
                    targetSpeed = targetSpeed * 0.8
                elseif distance > 40 then
                    targetSpeed = targetSpeed * 1.4
                end
                
                if tick() - targetSwitchTime > minTargetTime + math.random() * (maxTargetTime - minTargetTime) then
                    if math.random() < 0.6 then
                        currentTarget, currentIndex = getWaypoint()
                        targetSwitchTime = tick()
                    end
                end
                
                local zigzagOffset = Vector3.new(
                    math.sin(zigzagAmount) * zigzagIntensity,
                    0,
                    math.cos(zigzagAmount * 0.7) * zigzagIntensity * 0.5
                )
                
                moveDirection = (moveDirection + zigzagOffset * 0.1).Unit
                
                local targetVelocity = moveDirection * targetSpeed
                velocity = velocity:Lerp(targetVelocity, smoothFactor)
                
                local wobbleOffset = Vector3.new(
                    math.sin(wobbleTime) * wobbleIntensity * 2.0,
                    math.cos(wobbleTime * 1.3) * wobbleIntensity * 1.0,
                    math.cos(wobbleTime * 0.9) * wobbleIntensity * 1.5
                )
                
                local newPosition = monsterPos + (velocity * deltaTime) + wobbleOffset
                
                if moveDirection.Magnitude > 0.1 then
                    local yawOffset = math.rad(math.sin(wobbleTime * 0.7) * 8)
                    local pitchOffset = math.rad(math.cos(wobbleTime * 1.1) * 6)
                    local rollOffset = math.rad(math.sin(wobbleTime * 1.4) * 4)
                    
                    local rotatedDirection = CFrame.Angles(pitchOffset, yawOffset, rollOffset) * moveDirection
                    
                    local lookAtCFrame = CFrame.lookAt(newPosition, newPosition + rotatedDirection)
                    a60Model:PivotTo(lookAtCFrame)
                end
                
                if checkReachedWaypoint(currentTarget) then
                    if currentIndex then
                        visitCounts[currentIndex] = (visitCounts[currentIndex] or 0) + 1
                        lastVisitTime[currentIndex] = tick()
                    end
                    
                    wait(math.random(0.05, 0.2))
                    
                    if math.random() < 0.8 then
                        currentTarget, currentIndex = getWaypoint()
                        targetSwitchTime = tick()
                    end
                    
                    velocity = velocity * 0.2
                end
            else
                if currentIndex then
                    visitCounts[currentIndex] = (visitCounts[currentIndex] or 0) + 1
                    lastVisitTime[currentIndex] = tick()
                end
                
                wait(math.random(0.05, 0.2))
                currentTarget, currentIndex = getWaypoint()
                targetSwitchTime = tick()
                velocity = Vector3.new(0, 0, 0)
            end
        end
        
        RunService.RenderStepped:Wait()
    end
end)()

local UserInputService = game:GetService("UserInputService")

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.R then
        currentTarget, currentIndex = getWaypoint()
        isMoving = true
        velocity = Vector3.new(0, 0, 0)
        speedMultiplier = 1.0
        
        for i = 1, #allWaypoints do
            visitCounts[i] = 0
            lastVisitTime[i] = 0
        end
        
        if #allWaypoints > 0 then
            a60Model:PivotTo(CFrame.new(allWaypoints[1].position + Vector3.new(5, 0, 5)))
        end
        
    elseif input.KeyCode == Enum.KeyCode.T then
        isMoving = not isMoving
        if isMoving then
            velocity = Vector3.new(0, 0, 0)
        end
    end
end)
local faceController
if a60Model then
    faceController = addFaceParticleAnimation()
end
end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://139308622787703" then
        local parent = sound.Parent
        if parent and parent.Name == "Scary Entity" then
            local grandParent = parent.Parent
            if grandParent and grandParent.Name == "CustomEntity" then
                if not checkedEntities[grandParent] then
                    checkedEntities[grandParent] = true
                    runEvent()
                end
            end
        end
    end
end

workspace.DescendantAdded:Connect(function(obj)
    wait(0.1)
    if obj:IsA("Sound") then
        checkSound(obj)
        if not listeningSounds[obj] then
            listeningSounds[obj] = true
            obj:GetPropertyChangedSignal("SoundId"):Connect(function()
                checkSound(obj)
            end)
        end
    end
end)

for _, entity in pairs(workspace:GetChildren()) do
    if entity.Name == "CustomEntity" then
        local scary = entity:FindFirstChild("Scary Entity")
        if scary then
            for _, child in pairs(scary:GetChildren()) do
                if child:IsA("Sound") then
                    checkSound(child)
                    if not listeningSounds[child] then
                        listeningSounds[child] = true
                        child:GetPropertyChangedSignal("SoundId"):Connect(function()
                            checkSound(child)
                        end)
                    end
                end
            end
        end
    end
end
------A60-50
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
    
require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("你认为我走了?",true)
wait(2)
require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("我不会这么轻易放过你.",true)
end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://140721539239314" then
        local parent = sound.Parent
        if parent and parent.Name == "Scary Entity" then
            local grandParent = parent.Parent
            if grandParent and grandParent.Name == "CustomEntity" then
                if not checkedEntities[grandParent] then
                    checkedEntities[grandParent] = true
                    runEvent()
                end
            end
        end
    end
end

workspace.DescendantAdded:Connect(function(obj)
    wait(0.1)
    if obj:IsA("Sound") then
        checkSound(obj)
        if not listeningSounds[obj] then
            listeningSounds[obj] = true
            obj:GetPropertyChangedSignal("SoundId"):Connect(function()
                checkSound(obj)
            end)
        end
    end
end)

for _, entity in pairs(workspace:GetChildren()) do
    if entity.Name == "CustomEntity" then
        local scary = entity:FindFirstChild("Scary Entity")
        if scary then
            for _, child in pairs(scary:GetChildren()) do
                if child:IsA("Sound") then
                    checkSound(child)
                    if not listeningSounds[child] then
                        listeningSounds[child] = true
                        child:GetPropertyChangedSignal("SoundId"):Connect(function()
                            checkSound(child)
                        end)
                    end
                end
            end
        end
    end
end
--------A500
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
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
    sound.Name = filename or "A500MUSIC"
    sound.Volume = vol or 1
    return sound
end

local function main()

    local targetAudioUrl = "https://github.com/Zero0Star/RipperMPSound/blob/master/A500Moving.mp3?raw=true"
    local volume = 2
    local localFileName = "A500MUSIC"
    
    local sound = CustomGitSound(targetAudioUrl, volume, localFileName)

    game.ReplicatedStorage.GameData.LatestRoom.Changed:Wait()

    sound:Play()
    
    local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()
    local entity = spawner.Create({
        Entity = {
            Name = "A500",
            Asset = "121633960606961",
            HeightOffset = 0.3
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
            Values = {1.5, 20, 0.1, 1}
        },
        Movement = {
            Speed = 90,
            Delay = 25,
            Reversed = false
        },
        Rebounding = {
            Enabled = true,
            Type = "ambush",
            Min = 30,
            Max = 30,
            Delay = math.random(10, 30) / 10
        },
        Damage = {
            Enabled = true,
            Range = 20,
            Amount = 50
        },
        Crucifixion = {
            Enabled = false,
            Range = 20,
            Resist = false,
            Break = true
        },
        Death = {
            Type = "Guiding",
            Hints = {"你死于A500", "这是很坏的结局", "你需要不停的跑!", "保证自己在两分钟内不被追上"},
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
    
    local face = workspace:WaitForChild("A500"):WaitForChild("RushNew"):WaitForChild("Main"):WaitForChild("Face")
    if face and face:IsA("ParticleEmitter") then
        task.spawn(function()
            local textures = {
                "rbxassetid://109080249848293",
                "rbxassetid://138164251853595",
                "rbxassetid://129267921615075",
                "rbxassetid://138164251853595",
                "rbxassetid://102573027299916"
            }
            while true do
                for _, texture in ipairs(textures) do
                    face.Texture = texture
                    task.wait(0.1)
                end
            end
        end)
    end
    
    task.wait(15)
    
    local Event = game:GetService("ReplicatedStorage").RemotesFolder.AdminPanelRunCommand
    
    Event:FireServer(
        "Apply Changes",
        {
            Players = {
                QWQ75321 = "QWQ75321",
                sppvve = "sppvve"
            },
            ["Max Health"] = 100,
            ["Allow Sliding"] = true,
            ["Star Shield"] = 100,
            ["Speed Boost"] = 20,
            Health = 100,
            ["Allow Jumping"] = true,
            ["God Mode"] = true
        }
    )
    
    Event:FireServer(
        "Give Items",
        {
            Players = {
                sppvve = "sppvve",
                QWQ75321 = "QWQ75321"
            },
            Items = {
                Multitool = "Multitool"
            }
        }
    )
    
    if sound and sound.IsPlaying then
        sound.Ended:Wait()
    end
    
    local a500Model = workspace:FindFirstChild("A500")
    if a500Model then
        a500Model:Destroy()
    end
    
    Event:FireServer(
        "Apply Changes",
        {
            Players = {
                QWQ75321 = "QWQ75321",
                sppvve = "sppvve"
            },
            ["Max Health"] = 100,
            ["Allow Sliding"] = false,
            ["Star Shield"] = 0,
            ["Speed Boost"] = 0,
            Health = 100,
            ["Allow Jumping"] = false,
            ["God Mode"] = false
        }
    )
    
    if sound then
        sound:Destroy()
    end
end

local success, err = pcall(main)
if not success then

end
end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://140731983342235" then
        local parent = sound.Parent
        if parent and parent.Name == "Scary Entity" then
            local grandParent = parent.Parent
            if grandParent and grandParent.Name == "CustomEntity" then
                if not checkedEntities[grandParent] then
                    checkedEntities[grandParent] = true
                    runEvent()
                end
            end
        end
    end
end

workspace.DescendantAdded:Connect(function(obj)
    wait(0.1)
    if obj:IsA("Sound") then
        checkSound(obj)
        if not listeningSounds[obj] then
            listeningSounds[obj] = true
            obj:GetPropertyChangedSignal("SoundId"):Connect(function()
                checkSound(obj)
            end)
        end
    end
end)

for _, entity in pairs(workspace:GetChildren()) do
    if entity.Name == "CustomEntity" then
        local scary = entity:FindFirstChild("Scary Entity")
        if scary then
            for _, child in pairs(scary:GetChildren()) do
                if child:IsA("Sound") then
                    checkSound(child)
                    if not listeningSounds[child] then
                        listeningSounds[child] = true
                        child:GetPropertyChangedSignal("SoundId"):Connect(function()
                            checkSound(child)
                        end)
                    end
                end
            end
        end
    end
end

-------XBRAMBLE
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
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
        else
            clonedPart.Name = partName
        end

        if clonedPart:IsA("BasePart") or clonedPart:IsA("MeshPart") then
            clonedPart.Transparency = 0
            clonedPart.CanCollide = true
        end
        
        table.insert(copiedParts, clonedPart)

    else
        for _, child in ipairs(NewModel:GetChildren()) do

        end
    end
end

local originalHead = targetModel:FindFirstChild("Head")
if originalHead then
    if originalHead:IsA("BasePart") or originalHead:IsA("MeshPart") then
        originalHead.Transparency = 1
        originalHead.CanCollide = false

    elseif originalHead:IsA("Model") then
        for _, part in ipairs(originalHead:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("MeshPart") then
                part.Transparency = 1
                part.CanCollide = false
            end
        end

    end
else

end

local RunService = game:GetService("RunService")
local followConnection
followConnection = RunService.Heartbeat:Connect(function()
    if not targetModel or not targetModel.Parent or not NewModel or not NewModel.Parent then
        if followConnection then
            followConnection:Disconnect()
        end
        return
    end

    local mainPartTarget = targetModel.PrimaryPart or targetModel:FindFirstChild("HumanoidRootPart") or 
                           targetModel:FindFirstChild("Torso") or targetModel:FindFirstChildWhichIsA("BasePart")
    
    local mainPartNew = NewModel.PrimaryPart or NewModel:FindFirstChild("HumanoidRootPart") or 
                       NewModel:FindFirstChild("Torso") or NewModel:FindFirstChildWhichIsA("BasePart")
    
    if mainPartTarget and mainPartNew then

        mainPartNew.CFrame = mainPartTarget.CFrame
    end
end)

task.wait(1)

for _, part in ipairs(NewModel:GetDescendants()) do
    if part:IsA("BasePart") or part:IsA("MeshPart") or part:IsA("Part") then
        part.Transparency = 1
        part.CanCollide = false
    end
end

local model = workspace.LiveEntityBramble
local rightArm = model:FindFirstChild("RightArm", true)
local darkGrayColor = Color3.fromRGB(36, 36, 36) 

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
local darkGrayColor = Color3.fromRGB(36, 36, 36) 

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
local darkGrayColor = Color3.fromRGB(14, 14, 14) 

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
local darkGrayColor = Color3.fromRGB(14, 14, 14) 

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
local darkGrayColor = Color3.fromRGB(14, 14, 14) 

if LeftArm then
    for _, part in ipairs(LeftArm:GetDescendants()) do
        if part:IsA("BasePart") or part:IsA("MeshPart") then
            part.Color = darkGrayColor
        end
    end
end

local targetModel = workspace:WaitForChild("LiveEntityBramble", 5)
if not targetModel then
    return
end

local targetColor = Color3.fromRGB(160, 0, 0)

local pointLights = {}
local changedLights = 0

for _, light in ipairs(targetModel:GetDescendants()) do
    if light:IsA("PointLight") then
        table.insert(pointLights, {
            instance = light,
            originalColor = light.Color, 
            originalBrightness = light.Brightness,
            originalRange = light.Range
        })
    end
end

if #pointLights == 0 then

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

for _, data in ipairs(pointLights) do
    local light = data.instance

    light.Color = targetColor

    light.Brightness = 5
    light.Range = 10      
    changedLights = changedLights + 1

    local newR = math.floor(light.Color.R * 255)
    local newG = math.floor(light.Color.G * 255)
    local newB = math.floor(light.Color.B * 255)
    
    local oldR = math.floor(data.originalColor.R * 255)
    local oldG = math.floor(data.originalColor.G * 255)
    local oldB = math.floor(data.originalColor.B * 255)
    
end

task.wait(0.5)

local correctCount = 0
local incorrectCount = 0

for _, data in ipairs(pointLights) do
    local light = data.instance
    local r = math.floor(light.Color.R * 255)
    local g = math.floor(light.Color.G * 255)
    local b = math.floor(light.Color.B * 255)
    
    if r == 160 and g == 0 and b == 0 then
        correctCount = correctCount + 1
    else
        incorrectCount = incorrectCount + 1
    end
end
local targetModel = workspace:WaitForChild("LiveEntityBramble", 5)
if not targetModel then

    return
end
local targetColor = Color3.fromRGB(255, 0, 0)

local particlePaths = {
    "Head.LanternNeon.Attachment.CenterAttach.CenterAttach",
    "Head.UpperHead.Glass.FliesParticles"
}

local changedParticles = 0

for _, path in ipairs(particlePaths) do

    local parts = {}
    for part in path:gmatch("([^.]+)") do
        table.insert(parts, part)
    end

    local current = targetModel
    local found = true
    
    for i, partName in ipairs(parts) do
        current = current:FindFirstChild(partName)
        if not current then
   
            found = false
            break
        end
    end
    
    if found and current:IsA("ParticleEmitter") then

        local originalColor = nil
        if current.Color and current.Color.Keypoints and #current.Color.Keypoints > 0 then
            originalColor = current.Color.Keypoints[1].Value
        end

        local redColorSequence = ColorSequence.new(targetColor)
        current.Color = redColorSequence

        current.Lifetime = NumberRange.new(1, 2)
        current.Rate = 50
        current.Speed = NumberRange.new(5, 10)

        current.Size = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0.1),
            NumberSequenceKeypoint.new(0.5, 0.3),
            NumberSequenceKeypoint.new(1, 0)
        })

        current.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0.2),
            NumberSequenceKeypoint.new(0.5, 0.1),
            NumberSequenceKeypoint.new(1, 1)
        })
        
        changedParticles = changedParticles + 1

        if originalColor then
            local oldR = math.floor(originalColor.R * 255)
            local oldG = math.floor(originalColor.G * 255)
            local oldB = math.floor(originalColor.B * 255)
        end
        
    elseif found then

        for _, particle in ipairs(current:GetDescendants()) do
            if particle:IsA("ParticleEmitter") then

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
end
local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://116898205685143" then
        local parent = sound.Parent
        if parent and parent.Name == "Scary Entity" then
            local grandParent = parent.Parent
            if grandParent and grandParent.Name == "CustomEntity" then
                if not checkedEntities[grandParent] then
                    checkedEntities[grandParent] = true
                    runEvent()
                end
            end
        end
    end
end

workspace.DescendantAdded:Connect(function(obj)
    wait(0.1)
    if obj:IsA("Sound") then
        checkSound(obj)
        if not listeningSounds[obj] then
            listeningSounds[obj] = true
            obj:GetPropertyChangedSignal("SoundId"):Connect(function()
                checkSound(obj)
            end)
        end
    end
end)

for _, entity in pairs(workspace:GetChildren()) do
    if entity.Name == "CustomEntity" then
        local scary = entity:FindFirstChild("Scary Entity")
        if scary then
            for _, child in pairs(scary:GetChildren()) do
                if child:IsA("Sound") then
                    checkSound(child)
                    if not listeningSounds[child] then
                        listeningSounds[child] = true
                        child:GetPropertyChangedSignal("SoundId"):Connect(function()
                            checkSound(child)
                        end)
                    end
                end
            end
        end
    end
end
----------A200
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
    local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()
local entity = spawner.Create({
	Entity = {
		Name = "A-200",
		Asset = "103526452499813",
		HeightOffset = 1
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
		Values = {1.5, 20, 0.1, 1}
	},
	Movement = {
		Speed = 60,
		Delay = 5,
		Reversed = true
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
		Hints = {"你死于A-200", "竖起耳朵仔细辨别是一个麻烦", "但你不得不这么做", "你或许会在寂静那学到点什么"},
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

local sound = Instance.new("Sound")
sound.Name = "A200"  
sound.SoundId = "rbxassetid://2306939610"
sound.Volume = 0.1
sound.Looped = true
sound.Parent = workspace
sound:Play()

task.wait(10)
sound:Stop()
sound:Destroy()

end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://7298463798" then
        local parent = sound.Parent
        if parent and parent.Name == "Scary Entity" then
            local grandParent = parent.Parent
            if grandParent and grandParent.Name == "CustomEntity" then
                if not checkedEntities[grandParent] then
                    checkedEntities[grandParent] = true
                    runEvent()
                end
            end
        end
    end
end

workspace.DescendantAdded:Connect(function(obj)
    wait(0.1)
    if obj:IsA("Sound") then
        checkSound(obj)
        if not listeningSounds[obj] then
            listeningSounds[obj] = true
            obj:GetPropertyChangedSignal("SoundId"):Connect(function()
                checkSound(obj)
            end)
        end
    end
end)

for _, entity in pairs(workspace:GetChildren()) do
    if entity.Name == "CustomEntity" then
        local scary = entity:FindFirstChild("Scary Entity")
        if scary then
            for _, child in pairs(scary:GetChildren()) do
                if child:IsA("Sound") then
                    checkSound(child)
                    if not listeningSounds[child] then
                        listeningSounds[child] = true
                        child:GetPropertyChangedSignal("SoundId"):Connect(function()
                            checkSound(child)
                        end)
                    end
                end
            end
        end
    end
end
----Amin60
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
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
end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://4004052860" then
        local parent = sound.Parent
        if parent and parent.Name == "Scary Entity" then
            local grandParent = parent.Parent
            if grandParent and grandParent.Name == "CustomEntity" then
                if not checkedEntities[grandParent] then
                    checkedEntities[grandParent] = true
                    runEvent()
                end
            end
        end
    end
end

workspace.DescendantAdded:Connect(function(obj)
    wait(0.1)
    if obj:IsA("Sound") then
        checkSound(obj)
        if not listeningSounds[obj] then
            listeningSounds[obj] = true
            obj:GetPropertyChangedSignal("SoundId"):Connect(function()
                checkSound(obj)
            end)
        end
    end
end)

for _, entity in pairs(workspace:GetChildren()) do
    if entity.Name == "CustomEntity" then
        local scary = entity:FindFirstChild("Scary Entity")
        if scary then
            for _, child in pairs(scary:GetChildren()) do
                if child:IsA("Sound") then
                    checkSound(child)
                    if not listeningSounds[child] then
                        listeningSounds[child] = true
                        child:GetPropertyChangedSignal("SoundId"):Connect(function()
                            checkSound(child)
                        end)
                    end
                end
            end
        end
    end
end
-------blackA60
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
    local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()
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
		Hints = {"你死于BlackA60", "极大的嘈杂声会掩盖其他声音", "在不妥时使用十字架会更方便", "反复进柜子躲避它"},
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
end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://4903742660" then
        local parent = sound.Parent
        if parent and parent.Name == "Scary Entity" then
            local grandParent = parent.Parent
            if grandParent and grandParent.Name == "CustomEntity" then
                if not checkedEntities[grandParent] then
                    checkedEntities[grandParent] = true
                    runEvent()
                end
            end
        end
    end
end

workspace.DescendantAdded:Connect(function(obj)
    wait(0.1)
    if obj:IsA("Sound") then
        checkSound(obj)
        if not listeningSounds[obj] then
            listeningSounds[obj] = true
            obj:GetPropertyChangedSignal("SoundId"):Connect(function()
                checkSound(obj)
            end)
        end
    end
end)

for _, entity in pairs(workspace:GetChildren()) do
    if entity.Name == "CustomEntity" then
        local scary = entity:FindFirstChild("Scary Entity")
        if scary then
            for _, child in pairs(scary:GetChildren()) do
                if child:IsA("Sound") then
                    checkSound(child)
                    if not listeningSounds[child] then
                        listeningSounds[child] = true
                        child:GetPropertyChangedSignal("SoundId"):Connect(function()
                            checkSound(child)
                        end)
                    end
                end
            end
        end
    end
end
------silence
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
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
end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://135376180128296" then
        local parent = sound.Parent
        if parent and parent.Name == "Scary Entity" then
            local grandParent = parent.Parent
            if grandParent and grandParent.Name == "CustomEntity" then
                if not checkedEntities[grandParent] then
                    checkedEntities[grandParent] = true
                    runEvent()
                end
            end
        end
    end
end

workspace.DescendantAdded:Connect(function(obj)
    wait(0.1)
    if obj:IsA("Sound") then
        checkSound(obj)
        if not listeningSounds[obj] then
            listeningSounds[obj] = true
            obj:GetPropertyChangedSignal("SoundId"):Connect(function()
                checkSound(obj)
            end)
        end
    end
end)

for _, entity in pairs(workspace:GetChildren()) do
    if entity.Name == "CustomEntity" then
        local scary = entity:FindFirstChild("Scary Entity")
        if scary then
            for _, child in pairs(scary:GetChildren()) do
                if child:IsA("Sound") then
                    checkSound(child)
                    if not listeningSounds[child] then
                        listeningSounds[child] = true
                        child:GetPropertyChangedSignal("SoundId"):Connect(function()
                            checkSound(child)
                        end)
                    end
                end
            end
        end
    end
end
----------firstbite
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
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

end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://3308152153" then
        local parent = sound.Parent
        if parent and parent.Name == "Scary Entity" then
            local grandParent = parent.Parent
            if grandParent and grandParent.Name == "CustomEntity" then
                if not checkedEntities[grandParent] then
                    checkedEntities[grandParent] = true
                    runEvent()
                end
            end
        end
    end
end

workspace.DescendantAdded:Connect(function(obj)
    wait(0.1)
    if obj:IsA("Sound") then
        checkSound(obj)
        if not listeningSounds[obj] then
            listeningSounds[obj] = true
            obj:GetPropertyChangedSignal("SoundId"):Connect(function()
                checkSound(obj)
            end)
        end
    end
end)

for _, entity in pairs(workspace:GetChildren()) do
    if entity.Name == "CustomEntity" then
        local scary = entity:FindFirstChild("Scary Entity")
        if scary then
            for _, child in pairs(scary:GetChildren()) do
                if child:IsA("Sound") then
                    checkSound(child)
                    if not listeningSounds[child] then
                        listeningSounds[child] = true
                        child:GetPropertyChangedSignal("SoundId"):Connect(function()
                            checkSound(child)
                        end)
                    end
                end
            end
        end
    end
end
-----------INGOD1
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
    local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()
local entity = spawner.Create({
	Entity = {
		Name = "@&%^#*$Indescribable God!@$*&^!Q(* ",
		Asset = "115187708721417",
		HeightOffset = 1
	},
	Lights = {
		Flicker = {
			Enabled = false,
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
		Values = {0.5, 20, 0.1, 1}
	},
	Movement = {
		Speed = 20,
		Delay = 2,
		Reversed = false
	},
	Rebounding = {
		Enabled = true,
		Type = "Ambush",
		Min = 3,
		Max = 5,
		Delay = math.random(10, 30) / 10
	},
	Damage = {
		Enabled = true,
		Range = 40,
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
		Hints = {"It seems you are so unfortunate...", "You died by the ??? God", "That powerful force will drag you into the abyss.","The cross cannot guarantee your safety.","See you next time."},
		Cause = ""
	},
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
entity:Run()
end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://138586264525744" then
        local parent = sound.Parent
        if parent and parent.Name == "Scary Entity" then
            local grandParent = parent.Parent
            if grandParent and grandParent.Name == "CustomEntity" then
                if not checkedEntities[grandParent] then
                    checkedEntities[grandParent] = true
                    runEvent()
                end
            end
        end
    end
end

workspace.DescendantAdded:Connect(function(obj)
    wait(0.1)
    if obj:IsA("Sound") then
        checkSound(obj)
        if not listeningSounds[obj] then
            listeningSounds[obj] = true
            obj:GetPropertyChangedSignal("SoundId"):Connect(function()
                checkSound(obj)
            end)
        end
    end
end)

for _, entity in pairs(workspace:GetChildren()) do
    if entity.Name == "CustomEntity" then
        local scary = entity:FindFirstChild("Scary Entity")
        if scary then
            for _, child in pairs(scary:GetChildren()) do
                if child:IsA("Sound") then
                    checkSound(child)
                    if not listeningSounds[child] then
                        listeningSounds[child] = true
                        child:GetPropertyChangedSignal("SoundId"):Connect(function()
                            checkSound(child)
                        end)
                    end
                end
            end
        end
    end
end
-------SUBSPACE
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
local sound = Instance.new("Sound")
sound.Name = "Subspace"
sound.SoundId = "rbxassetid://108345344203629"
sound.Volume = 4
sound.Parent = workspace

sound.Ended:Connect(function()
    sound:Destroy()
end)

sound:Play()
wait(5)
    local sound = Instance.new("Sound")
sound.Name = "Subspace"
sound.SoundId = "rbxassetid://134461834055887"
sound.Volume = 4
sound.Parent = workspace

sound.Ended:Connect(function()
    sound:Destroy()
end)

sound:Play()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local SHAKE_INTENSITY = 20
local SHAKE_DURATION = 7
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
local Workspace = game:GetService("Workspace")
local function RandomUnanchor(count)
    count = count or 1800
    local parts = {}

      for _, part in pairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") and part.Anchored and not string.find(part.Name:lower(), "floor") then
            table.insert(parts, part)
        end
    end

    if #parts == 0 then

        return
    end
    
    local targetCount = math.min(count, #parts)
    local indices = {}

    for i = 1, #parts do
        indices[i] = i
    end

    for i = #indices, 2, -1 do
        local j = math.random(1, i)
        indices[i], indices[j] = indices[j], indices[i]
    end
    
    local unanchored = 0

    for i = 1, targetCount do
        local part = parts[indices[i]]
        if part and part.Anchored then
            part.Anchored = false
            unanchored = unanchored + 1

            if i % 100 == 0 then
            
            end
        end
    end

    return unanchored
end

RandomUnanchor(1800)
end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://124942412759969" then
        local parent = sound.Parent
        if parent and parent.Name == "Scary Entity" then
            local grandParent = parent.Parent
            if grandParent and grandParent.Name == "CustomEntity" then
                if not checkedEntities[grandParent] then
                    checkedEntities[grandParent] = true
                    runEvent()
                end
            end
        end
    end
end

workspace.DescendantAdded:Connect(function(obj)
    wait(0.1)
    if obj:IsA("Sound") then
        checkSound(obj)
        if not listeningSounds[obj] then
            listeningSounds[obj] = true
            obj:GetPropertyChangedSignal("SoundId"):Connect(function()
                checkSound(obj)
            end)
        end
    end
end)

for _, entity in pairs(workspace:GetChildren()) do
    if entity.Name == "CustomEntity" then
        local scary = entity:FindFirstChild("Scary Entity")
        if scary then
            for _, child in pairs(scary:GetChildren()) do
                if child:IsA("Sound") then
                    checkSound(child)
                    if not listeningSounds[child] then
                        listeningSounds[child] = true
                        child:GetPropertyChangedSignal("SoundId"):Connect(function()
                            checkSound(child)
                        end)
                    end
                end
            end
        end
    end
end
---------YINGOD2

local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
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
end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://118662411300943" then
        local parent = sound.Parent
        if parent and parent.Name == "Scary Entity" then
            local grandParent = parent.Parent
            if grandParent and grandParent.Name == "CustomEntity" then
                if not checkedEntities[grandParent] then
                    checkedEntities[grandParent] = true
                    runEvent()
                end
            end
        end
    end
end

workspace.DescendantAdded:Connect(function(obj)
    wait(0.1)
    if obj:IsA("Sound") then
        checkSound(obj)
        if not listeningSounds[obj] then
            listeningSounds[obj] = true
            obj:GetPropertyChangedSignal("SoundId"):Connect(function()
                checkSound(obj)
            end)
        end
    end
end)

for _, entity in pairs(workspace:GetChildren()) do
    if entity.Name == "CustomEntity" then
        local scary = entity:FindFirstChild("Scary Entity")
        if scary then
            for _, child in pairs(scary:GetChildren()) do
                if child:IsA("Sound") then
                    checkSound(child)
                    if not listeningSounds[child] then
                        listeningSounds[child] = true
                        child:GetPropertyChangedSignal("SoundId"):Connect(function()
                            checkSound(child)
                        end)
                    end
                end
            end
        end
    end
end
----DEL ALL
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
     local Event = game:GetService("ReplicatedStorage").RemotesFolder.AdminPanelRunCommand
Event:FireServer(
    "DELETE ALL",
    {}
)
    local function deleteDirectChildModels()
    local workspace = game:GetService("Workspace")
    local modelNames = {
        "A-200", "A60", "Amin-60", "Black-A60", "Deer god", "DeerGod",
        "Frostbite", "@&%^#*$Indescribable God!@$*&^!Q(* ", "LightSpeed",
        "Rebound", "Ripper", "Following_ENEMY", "Silence", "smiler", "Chainsmoker"
    }
    
    for _, name in ipairs(modelNames) do
        local model = workspace:FindFirstChild(name)
        if model and model:IsA("Model") then
            model:Destroy()
        end
    end
end

deleteDirectChildModels()

end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://140736591220630" then
        local parent = sound.Parent
        if parent and parent.Name == "Scary Entity" then
            local grandParent = parent.Parent
            if grandParent and grandParent.Name == "CustomEntity" then
                if not checkedEntities[grandParent] then
                    checkedEntities[grandParent] = true
                    runEvent()
                end
            end
        end
    end
end

workspace.DescendantAdded:Connect(function(obj)
    wait(0.1)
    if obj:IsA("Sound") then
        checkSound(obj)
        if not listeningSounds[obj] then
            listeningSounds[obj] = true
            obj:GetPropertyChangedSignal("SoundId"):Connect(function()
                checkSound(obj)
            end)
        end
    end
end)

for _, entity in pairs(workspace:GetChildren()) do
    if entity.Name == "CustomEntity" then
        local scary = entity:FindFirstChild("Scary Entity")
        if scary then
            for _, child in pairs(scary:GetChildren()) do
                if child:IsA("Sound") then
                    checkSound(child)
                    if not listeningSounds[child] then
                        listeningSounds[child] = true
                        child:GetPropertyChangedSignal("SoundId"):Connect(function()
                            checkSound(child)
                        end)
                    end
                end
            end
        end
    end
end
-----smiler
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
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
entity:Run()
end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://140721035016341" then
        local parent = sound.Parent
        if parent and parent.Name == "Scary Entity" then
            local grandParent = parent.Parent
            if grandParent and grandParent.Name == "CustomEntity" then
                if not checkedEntities[grandParent] then
                    checkedEntities[grandParent] = true
                    runEvent()
                end
            end
        end
    end
end

workspace.DescendantAdded:Connect(function(obj)
    wait(0.1)
    if obj:IsA("Sound") then
        checkSound(obj)
        if not listeningSounds[obj] then
            listeningSounds[obj] = true
            obj:GetPropertyChangedSignal("SoundId"):Connect(function()
                checkSound(obj)
            end)
        end
    end
end)

for _, entity in pairs(workspace:GetChildren()) do
    if entity.Name == "CustomEntity" then
        local scary = entity:FindFirstChild("Scary Entity")
        if scary then
            for _, child in pairs(scary:GetChildren()) do
                if child:IsA("Sound") then
                    checkSound(child)
                    if not listeningSounds[child] then
                        listeningSounds[child] = true
                        child:GetPropertyChangedSignal("SoundId"):Connect(function()
                            checkSound(child)
                        end)
                    end
                end
            end
        end
    end
end
-------------SHOOP DA
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
    local RunService = game:GetService("RunService")
local modelId = 86112457302745
local loadedModel

local success, result = pcall(function()
    return game:GetObjects("rbxassetid://" .. modelId)[1]
end)

if success and result and result:IsA("Model") then
    loadedModel = result
    loadedModel.Parent = workspace
    loadedModel.Name = "Following_ENEMY"
else
    return
end

if not loadedModel.PrimaryPart then
    local rootPart = loadedModel:FindFirstChild("HumanoidRootPart") or loadedModel:FindFirstChildWhichIsA("BasePart")
    if rootPart then
        loadedModel.PrimaryPart = rootPart
    else
        return
    end
end

local function findGroundskeeper()
    local currentRooms = workspace:FindFirstChild("CurrentRooms")
    if not currentRooms then return nil end

    for _, room in ipairs(currentRooms:GetChildren()) do
        if room:IsA("Model") or room:IsA("Folder") then
            local target = room:FindFirstChild("Groundskeeper", true)
            if target and target:IsA("Model") then
                return target
            end
        end
    end
    return nil
end

local targetModel = findGroundskeeper()
if not targetModel then
    return
end

if not targetModel.PrimaryPart then
    local rootPart = targetModel:FindFirstChild("HumanoidRootPart") or targetModel:FindFirstChildWhichIsA("BasePart")
    if rootPart then
        targetModel.PrimaryPart = rootPart
    else
        return
    end
end

local function processHideModel(model)
    for _, descendant in ipairs(model:GetDescendants()) do
        if descendant:IsA("BasePart") or descendant:IsA("MeshPart") then
            descendant.Transparency = 1
            if descendant:IsA("MeshPart") then
                descendant.RenderFidelity = Enum.RenderFidelity.Performance
            end
        end
        if descendant:IsA("Decal") or descendant:IsA("Texture") then
            descendant.Transparency = 1
        end
        if descendant:IsA("SurfaceGui") or descendant:IsA("BillboardGui") then
            descendant.Enabled = false
        end
        if descendant:IsA("PointLight") or descendant:IsA("SpotLight") or descendant:IsA("SurfaceLight") then
            descendant:Destroy()
        end
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = false
        end
        if descendant:IsA("Fire") or descendant:IsA("Smoke") then
            descendant.Enabled = false
        end
    end
end

local function hideGroundskeeper()
    local foundAny = false
    local function searchAndHide(parent)
        for _, child in ipairs(parent:GetChildren()) do
            if child.Name == "Groundskeeper" and child:IsA("Model") then
                processHideModel(child)
                foundAny = true
            end
            searchAndHide(child)
        end
    end
    searchAndHide(workspace)
    return foundAny
end

hideGroundskeeper()

local function setupHideMonitor()
    local connections = {}
    local function monitorChildAdded(parent)
        local connection = parent.ChildAdded:Connect(function(child)
            if child.Name == "Groundskeeper" and child:IsA("Model") then
                task.wait(0.1)
                processHideModel(child)
            end
            monitorChildAdded(child)
        end)
        table.insert(connections, connection)
    end
    monitorChildAdded(workspace)
    return function()
        for _, conn in ipairs(connections) do
            conn:Disconnect()
        end
    end
end

local hideMonitor = setupHideMonitor()

local function processDeleteSounds(model)
    for _, descendant in ipairs(model:GetDescendants()) do
        if descendant:IsA("Sound") then
            descendant:Destroy()
        end
    end
end

local function setupSoundDeletionMonitor()
    local connections = {}
    local function monitorDescendantAdded(parent)
        local connection = parent.DescendantAdded:Connect(function(descendant)
            if descendant:IsA("Sound") then
                local current = descendant
                while current and current ~= game do
                    if current.Name == "Groundskeeper" and current:IsA("Model") then
                        descendant:Destroy()
                        break
                    end
                    current = current.Parent
                end
            end
        end)
        table.insert(connections, connection)
    end
    monitorDescendantAdded(workspace)
    
    local groundskeeperConnection
    groundskeeperConnection = workspace.DescendantAdded:Connect(function(descendant)
        if descendant.Name == "Groundskeeper" and descendant:IsA("Model") then
            task.wait(0.1)
            processDeleteSounds(descendant)
        end
    end)
    table.insert(connections, groundskeeperConnection)
    
    return function()
        for _, conn in ipairs(connections) do
            conn:Disconnect()
        end
    end
end

local soundMonitor = setupSoundDeletionMonitor()

local followConnection
followConnection = RunService.Heartbeat:Connect(function()
    if not targetModel or not targetModel.PrimaryPart or not loadedModel or not loadedModel.PrimaryPart or 
       not targetModel.PrimaryPart.Parent or not loadedModel.Parent then
        if followConnection then
            followConnection:Disconnect()
        end
        return
    end
    local targetCFrame = targetModel.PrimaryPart.CFrame
    loadedModel:PivotTo(targetCFrame)
end)

local function playLaserEffect()
    local RunService = game:GetService("RunService")
    local Workspace = game:GetService("Workspace")
    local Players = game:GetService("Players")
    
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://138148333"
    sound.Name = "WHOOP"
    sound.Parent = workspace
    sound:Play()
    
    local targetModel = workspace:FindFirstChild("Following_ENEMY")
    if not targetModel then 
        if sound and sound.Parent then sound:Destroy() end
        return false 
    end
    
    local currentRooms = Workspace:FindFirstChild("CurrentRooms")
    local groundskeeperModel
    if currentRooms then
        for _, room in ipairs(currentRooms:GetChildren()) do
            if room:IsA("Folder") or room:IsA("Model") then
                local groundskeeper = room:FindFirstChild("Groundskeeper")
                if groundskeeper and groundskeeper:IsA("Model") then
                    groundskeeperModel = groundskeeper
                    break
                end
            end
        end
    end
    if not groundskeeperModel then 
        if sound and sound.Parent then sound:Destroy() end
        return false 
    end
    
    if not groundskeeperModel.PrimaryPart then
        local rootPart = groundskeeperModel:FindFirstChild("HumanoidRootPart") or groundskeeperModel:FindFirstChildWhichIsA("BasePart")
        if rootPart then 
            groundskeeperModel.PrimaryPart = rootPart 
        else 
            if sound and sound.Parent then sound:Destroy() end
            return false
        end
    end
    
    task.wait(1.8)
    
    local laser1Id = 75823189898619
    local laser1Model
    local laser1Success, laser1Result = pcall(function()
        return game:GetObjects("rbxassetid://" .. laser1Id)[1]
    end)
    
    if laser1Success and laser1Result and laser1Result:IsA("Model") then
        laser1Model = laser1Result
        laser1Model.Name = "Laser1"
        laser1Model.Parent = workspace
        if not laser1Model.PrimaryPart then
            local rootPart = laser1Model:FindFirstChild("HumanoidRootPart") or laser1Model:FindFirstChildWhichIsA("BasePart")
            if rootPart then laser1Model.PrimaryPart = rootPart end
        end
    else
        if sound and sound.Parent then sound:Destroy() end
        return false
    end
    
    local function hideModel(model)
        for _, descendant in ipairs(model:GetDescendants()) do
            if descendant:IsA("BasePart") or descendant:IsA("MeshPart") then
                descendant.Transparency = 1
            elseif descendant:IsA("Decal") or descendant:IsA("Texture") then
                descendant.Transparency = 1
            elseif descendant:IsA("SurfaceGui") or descendant:IsA("BillboardGui") then
                descendant.Enabled = false
            end
        end
    end
    
    local function restoreModelExceptRootPart(model)
        for _, descendant in ipairs(model:GetDescendants()) do
            if descendant.Name ~= "HumanoidRootPart" then
                if descendant:IsA("BasePart") or descendant:IsA("MeshPart") then
                    descendant.Transparency = 0
                elseif descendant:IsA("Decal") or descendant:IsA("Texture") then
                    descendant.Transparency = 0
                elseif descendant:IsA("SurfaceGui") or descendant:IsA("BillboardGui") then
                    descendant.Enabled = true
                end
            end
        end
    end
    
    local laser1FollowConnection
    if groundskeeperModel and groundskeeperModel.PrimaryPart and laser1Model and laser1Model.PrimaryPart then
        laser1Model:PivotTo(groundskeeperModel.PrimaryPart.CFrame)
        hideModel(targetModel)
        laser1FollowConnection = RunService.Heartbeat:Connect(function()
            if not groundskeeperModel or not groundskeeperModel.PrimaryPart or not laser1Model or not laser1Model.PrimaryPart or 
               not groundskeeperModel.PrimaryPart.Parent or not laser1Model.Parent then
                if laser1FollowConnection then 
                    laser1FollowConnection:Disconnect() 
                end
                return
            end
            laser1Model:PivotTo(groundskeeperModel.PrimaryPart.CFrame)
        end)
    else
        if laser1Model and laser1Model.Parent then laser1Model:Destroy() end
        if sound and sound.Parent then sound:Destroy() end
        return false
    end
    
    task.wait(1.3)
    
    local laser2Id = 74088823220607
    local laser2Model
    local laser2Success, laser2Result = pcall(function()
        return game:GetObjects("rbxassetid://" .. laser2Id)[1]
    end)
    
    if laser2Success and laser2Result and laser2Result:IsA("Model") then
        laser2Model = laser2Result
        laser2Model.Name = "Laser2"
        laser2Model.Parent = workspace
        
        if not laser2Model.PrimaryPart then
            local rootPart = laser2Model:FindFirstChild("HumanoidRootPart") or laser2Model:FindFirstChildWhichIsA("BasePart")
            if rootPart then laser2Model.PrimaryPart = rootPart end
        end
        
        local player = Players.LocalPlayer
        if player then
            local camera = workspace.CurrentCamera
            if camera then
                local SHAKE_INTENSITY = 2
                local SHAKE_DURATION = 10
                local SHAKE_SPEED = 70
                local startTime = tick()
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
                        local currentPos = camera.CFrame.Position
                        local newPos = currentPos + offset
                        camera.CFrame = CFrame.new(newPos, newPos + lookVector) * CFrame.Angles(0, 0, 0)
                    else
                        if connection then connection:Disconnect() end
                    end
                end)
            end
        end
    else
        if laser1FollowConnection then laser1FollowConnection:Disconnect() end
        if laser1Model and laser1Model.Parent then laser1Model:Destroy() end
        if sound and sound.Parent then sound:Destroy() end
        return false
    end
    
    local laser2FollowConnection
    if groundskeeperModel and groundskeeperModel.PrimaryPart and laser2Model and laser2Model.PrimaryPart then
        laser2Model:PivotTo(groundskeeperModel.PrimaryPart.CFrame)
        hideModel(laser1Model)
        laser2FollowConnection = RunService.Heartbeat:Connect(function()
            if not groundskeeperModel or not groundskeeperModel.PrimaryPart or not laser2Model or not laser2Model.PrimaryPart or 
               not groundskeeperModel.PrimaryPart.Parent or not laser2Model.Parent then
                if laser2FollowConnection then 
                    laser2FollowConnection:Disconnect() 
                end
                return
            end
            laser2Model:PivotTo(groundskeeperModel.PrimaryPart.CFrame)
        end)
    else
        if laser1FollowConnection then laser1FollowConnection:Disconnect() end
        if laser2FollowConnection then laser2FollowConnection:Disconnect() end
        if laser1Model and laser1Model.Parent then laser1Model:Destroy() end
        if laser2Model and laser2Model.Parent then laser2Model:Destroy() end
        if sound and sound.Parent then sound:Destroy() end
        return false
    end
    
    local soundFinished = false
    local soundConnection
    soundConnection = sound.Ended:Connect(function()
        soundFinished = true
        if soundConnection then soundConnection:Disconnect() end
    end)
    
    while not soundFinished do 
        task.wait(0.1) 
    end
    
    if targetModel then 
        restoreModelExceptRootPart(targetModel) 
    end
    
    if laser1FollowConnection then laser1FollowConnection:Disconnect() end
    if laser2FollowConnection then laser2FollowConnection:Disconnect() end
    
    if laser1Model and laser1Model.Parent then laser1Model:Destroy() end
    if laser2Model and laser2Model.Parent then laser2Model:Destroy() end
    if sound and sound.Parent then sound:Destroy() end
    
    return true
end

local function scheduleLaserEffects()
    local endTime = tick() + 5 * 60
    local count = 0
    
    while tick() < endTime do
        count = count + 1
        
        playLaserEffect()
        
        local waitTime = math.random(12, 50)
        
        if tick() + waitTime > endTime then
            local remainingTime = endTime - tick()
            if remainingTime > 0 then
                task.wait(remainingTime)
            end
            break
        else
            task.wait(waitTime)
        end
    end
    
    if followConnection then
        followConnection:Disconnect()
    end
    if hideMonitor then
        hideMonitor()
    end
    if soundMonitor then
        soundMonitor()
    end
    if loadedModel and loadedModel.Parent then
        loadedModel:Destroy()
    end
end

task.spawn(scheduleLaserEffects)

end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://140719303781203" then
        local parent = sound.Parent
        if parent and parent.Name == "Scary Entity" then
            local grandParent = parent.Parent
            if grandParent and grandParent.Name == "CustomEntity" then
                if not checkedEntities[grandParent] then
                    checkedEntities[grandParent] = true
                    runEvent()
                end
            end
        end
    end
end

workspace.DescendantAdded:Connect(function(obj)
    wait(0.1)
    if obj:IsA("Sound") then
        checkSound(obj)
        if not listeningSounds[obj] then
            listeningSounds[obj] = true
            obj:GetPropertyChangedSignal("SoundId"):Connect(function()
                checkSound(obj)
            end)
        end
    end
end)

for _, entity in pairs(workspace:GetChildren()) do
    if entity.Name == "CustomEntity" then
        local scary = entity:FindFirstChild("Scary Entity")
        if scary then
            for _, child in pairs(scary:GetChildren()) do
                if child:IsA("Sound") then
                    checkSound(child)
                    if not listeningSounds[child] then
                        listeningSounds[child] = true
                        child:GetPropertyChangedSignal("SoundId"):Connect(function()
                            checkSound(child)
                        end)
                    end
                end
            end
        end
    end
end
----CHAINSMKER
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
     local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()
local entity = spawner.Create({
	Entity = {
		Name = "Chainsmoker",
		Asset = "91743718986054",
		HeightOffset = 1
	},
	Lights = {
		Flicker = {
			Enabled = true,
			Duration = 1
		},
		Shatter = true,
		Repair = false
	},
	Earthquake = {
		Enabled = false
	},
	CameraShake = {
		Enabled = true,
		Range = 10,
		Values = {1.5, 20, 0.1, 1}
	},
	Movement = {
		Speed = 30,
		Delay = 1,
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
		Range = 5,
		Amount = 125
	},
	Crucifixion = {
		Enabled = true,
		Range = 20,
		Resist = false,
		Break = true
	},
	Death = {
		Type = "Guiding",
		Hints = {"你死于Chainsmoker", "......", "或许我不能告诉你他的信息", "总而言之，当心闪灯"},
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
end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://18926010713" then
        local parent = sound.Parent
        if parent and parent.Name == "Scary Entity" then
            local grandParent = parent.Parent
            if grandParent and grandParent.Name == "CustomEntity" then
                if not checkedEntities[grandParent] then
                    checkedEntities[grandParent] = true
                    runEvent()
                end
            end
        end
    end
end

workspace.DescendantAdded:Connect(function(obj)
    wait(0.1)
    if obj:IsA("Sound") then
        checkSound(obj)
        if not listeningSounds[obj] then
            listeningSounds[obj] = true
            obj:GetPropertyChangedSignal("SoundId"):Connect(function()
                checkSound(obj)
            end)
        end
    end
end)

for _, entity in pairs(workspace:GetChildren()) do
    if entity.Name == "CustomEntity" then
        local scary = entity:FindFirstChild("Scary Entity")
        if scary then
            for _, child in pairs(scary:GetChildren()) do
                if child:IsA("Sound") then
                    checkSound(child)
                    if not listeningSounds[child] then
                        listeningSounds[child] = true
                        child:GetPropertyChangedSignal("SoundId"):Connect(function()
                            checkSound(child)
                        end)
                    end
                end
            end
        end
    end
end
--------HatRed
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
    
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
end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://86930884029006" then
        local parent = sound.Parent
        if parent and parent.Name == "Scary Entity" then
            local grandParent = parent.Parent
            if grandParent and grandParent.Name == "CustomEntity" then
                if not checkedEntities[grandParent] then
                    checkedEntities[grandParent] = true
                    runEvent()
                end
            end
        end
    end
end

workspace.DescendantAdded:Connect(function(obj)
    wait(0.1)
    if obj:IsA("Sound") then
        checkSound(obj)
        if not listeningSounds[obj] then
            listeningSounds[obj] = true
            obj:GetPropertyChangedSignal("SoundId"):Connect(function()
                checkSound(obj)
            end)
        end
    end
end)

for _, entity in pairs(workspace:GetChildren()) do
    if entity.Name == "CustomEntity" then
        local scary = entity:FindFirstChild("Scary Entity")
        if scary then
            for _, child in pairs(scary:GetChildren()) do
                if child:IsA("Sound") then
                    checkSound(child)
                    if not listeningSounds[child] then
                        listeningSounds[child] = true
                        child:GetPropertyChangedSignal("SoundId"):Connect(function()
                            checkSound(child)
                        end)
                    end
                end
            end
        end
    end
end
--------deergod
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
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
end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://110532875373161" then
        local parent = sound.Parent
        if parent and parent.Name == "Scary Entity" then
            local grandParent = parent.Parent
            if grandParent and grandParent.Name == "CustomEntity" then
                if not checkedEntities[grandParent] then
                    checkedEntities[grandParent] = true
                    runEvent()
                end
            end
        end
    end
end

workspace.DescendantAdded:Connect(function(obj)
    wait(0.1)
    if obj:IsA("Sound") then
        checkSound(obj)
        if not listeningSounds[obj] then
            listeningSounds[obj] = true
            obj:GetPropertyChangedSignal("SoundId"):Connect(function()
                checkSound(obj)
            end)
        end
    end
end)

for _, entity in pairs(workspace:GetChildren()) do
    if entity.Name == "CustomEntity" then
        local scary = entity:FindFirstChild("Scary Entity")
        if scary then
            for _, child in pairs(scary:GetChildren()) do
                if child:IsA("Sound") then
                    checkSound(child)
                    if not listeningSounds[child] then
                        listeningSounds[child] = true
                        child:GetPropertyChangedSignal("SoundId"):Connect(function()
                            checkSound(child)
                        end)
                    end
                end
            end
        end
    end
end
-------light
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
    local Event = game:GetService("ReplicatedStorage").RemotesFolder.AdminPanelRunCommand
Event:FireServer(
    "LightRoom",
    {
        ["Light Color"] = Color3.new(1, 0.90844488143921, 0)
    }
)
wait(1)
local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()
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
end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://1079408535" then
        local parent = sound.Parent
        if parent and parent.Name == "Scary Entity" then
            local grandParent = parent.Parent
            if grandParent and grandParent.Name == "CustomEntity" then
                if not checkedEntities[grandParent] then
                    checkedEntities[grandParent] = true
                    runEvent()
                end
            end
        end
    end
end

workspace.DescendantAdded:Connect(function(obj)
    wait(0.1)
    if obj:IsA("Sound") then
        checkSound(obj)
        if not listeningSounds[obj] then
            listeningSounds[obj] = true
            obj:GetPropertyChangedSignal("SoundId"):Connect(function()
                checkSound(obj)
            end)
        end
    end
end)

for _, entity in pairs(workspace:GetChildren()) do
    if entity.Name == "CustomEntity" then
        local scary = entity:FindFirstChild("Scary Entity")
        if scary then
            for _, child in pairs(scary:GetChildren()) do
                if child:IsA("Sound") then
                    checkSound(child)
                    if not listeningSounds[child] then
                        listeningSounds[child] = true
                        child:GetPropertyChangedSignal("SoundId"):Connect(function()
                            checkSound(child)
                        end)
                    end
                end
            end
        end
    end
end
---------------A200JUMPFACE
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
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
    return sound
end

function ExecuteJumpScare()

    local targetAudioUrl = "https://raw.githubusercontent.com/Zero0Star/RipperMPSound/master/A120Jump.mp3"
    local volume = 4
    local localFileName = "JumpScareSound"
    
    local jumpSound = CustomGitSound(targetAudioUrl, volume, localFileName)

    task.wait(0.1)
    
    local images = {113886624548165, 16907654704, 91100683423814}
    local container = Instance.new("Folder", game.Players.LocalPlayer:WaitForChild("PlayerGui"))
    local redGui = Instance.new("ScreenGui", container)
    redGui.Name = "RedLayer"
    redGui.ResetOnSpawn = false
    redGui.IgnoreGuiInset = true
    redGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    redGui.DisplayOrder = 0
    local redOverlay = Instance.new("Frame", redGui)
    redOverlay.Name = "RedBg"
    redOverlay.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    redOverlay.BackgroundTransparency = 1
    redOverlay.Size = UDim2.new(1, 0, 1, 0)
    redOverlay.Position = UDim2.new(0, 0, 0, 0)
    redOverlay.BorderSizePixel = 0

    local imageGui = Instance.new("ScreenGui", container)
    imageGui.Name = "ImageLayer"
    imageGui.ResetOnSpawn = false
    imageGui.IgnoreGuiInset = true
    imageGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    imageGui.DisplayOrder = 1 
    local img = Instance.new("ImageLabel", imageGui)
    img.AnchorPoint = Vector2.new(0.5, 0.5)
    img.Size = UDim2.new(0, 100, 0, 100)
    img.Position = UDim2.new(0.5, 0, 0.5, 0)
    img.BackgroundTransparency = 1
    img.ImageTransparency = 1
    img.ScaleType = Enum.ScaleType.Fit
    img.ZIndex = 10
    local ts = game:GetService("TweenService")
    replicatesignal(game.Players.LocalPlayer.Kill)
    ts:Create(redOverlay, TweenInfo.new(0.1), {BackgroundTransparency = 0.2}):Play()

img.Image = "rbxassetid://" .. images[1]
ts:Create(img, TweenInfo.new(0.2), {ImageTransparency = 0}):Play()
ts:Create(img, TweenInfo.new(0.3), {Size = UDim2.new(0, 300, 0, 300)}):Play()
task.wait(0.08)

img.Image = "rbxassetid://" .. images[2]
ts:Create(img, TweenInfo.new(0.3), {Size = UDim2.new(0, 700, 0, 700)}):Play()
task.wait(0.08)
ts:Create(redOverlay, TweenInfo.new(0.2), {BackgroundTransparency = 0.1}):Play()
img.Image = "rbxassetid://" .. images[3]
ts:Create(img, TweenInfo.new(0.8), {Size = UDim2.new(0, 1500, 0, 1500)}):Play()
task.wait(0.5)
ts:Create(redOverlay, TweenInfo.new(0.3), {BackgroundTransparency = 0.05}):Play()
task.wait(0.8 + 0.5)
ts:Create(img, TweenInfo.new(0.5), {ImageTransparency = 1}):Play()
ts:Create(redOverlay, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
task.wait(0.5)
ts:Create(redOverlay, TweenInfo.new(0.8), {BackgroundTransparency = 1}):Play()
task.wait(0.8)
    container:Destroy()
    if jumpSound and jumpSound.Playing then
        jumpSound.Ended:Wait()
        task.wait(1)
        jumpSound:Destroy()
    end
end
ExecuteJumpScare()
end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://93679208285508" then
        local parent = sound.Parent
        if parent and parent.Name == "Scary Entity" then
            local grandParent = parent.Parent
            if grandParent and grandParent.Name == "CustomEntity" then
                if not checkedEntities[grandParent] then
                    checkedEntities[grandParent] = true
                    runEvent()
                end
            end
        end
    end
end

workspace.DescendantAdded:Connect(function(obj)
    wait(0.1)
    if obj:IsA("Sound") then
        checkSound(obj)
        if not listeningSounds[obj] then
            listeningSounds[obj] = true
            obj:GetPropertyChangedSignal("SoundId"):Connect(function()
                checkSound(obj)
            end)
        end
    end
end)

for _, entity in pairs(workspace:GetChildren()) do
    if entity.Name == "CustomEntity" then
        local scary = entity:FindFirstChild("Scary Entity")
        if scary then
            for _, child in pairs(scary:GetChildren()) do
                if child:IsA("Sound") then
                    checkSound(child)
                    if not listeningSounds[child] then
                        listeningSounds[child] = true
                        child:GetPropertyChangedSignal("SoundId"):Connect(function()
                            checkSound(child)
                        end)
                    end
                end
            end
        end
    end
end
-------Rebound JumpFace
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
    local Players = game:GetService("Players")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local function playSoundEffect()
    local success, errorMsg = pcall(function()
        local sound = Instance.new("Sound", workspace)
        sound.Name = "EffectSound"
        sound.SoundId = "rbxassetid://94785993416953"
        sound.Volume = 1
        sound:Play()

        wait(0.1)
        
        sound.Ended:Connect(function()
            wait(0.1)
            sound:Destroy()
        end)
    end)
    
    if not success then

    end
end

local function playStickerAnimation()
    local success, errorMsg = pcall(function()
        local player = Players.LocalPlayer
        local playerGui = player:WaitForChild("PlayerGui")
        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "CenterStickerFX"
        screenGui.ResetOnSpawn = false
        screenGui.IgnoreGuiInset = true
        screenGui.Parent = playerGui
        local sticker = Instance.new("ImageLabel")
        sticker.Image = "rbxassetid://97823818277141"
        sticker.BackgroundTransparency = 1
        sticker.AnchorPoint = Vector2.new(0.5, 0.5)
        sticker.Position = UDim2.new(0.5, 0, 0.5, 0)
        sticker.Size = UDim2.new(0, 0, 0, 0)
        sticker.ImageTransparency = 1
        sticker.ZIndex = 1000
        sticker.Parent = screenGui

        local config = {
            fadeIn = {time = 0.1, size = 1000, trans = 0},
            hold = {time = 0.7, size = 1020, trans = 0},
            fadeOut = {time = 0.1, size = 0, trans = 1}
        }

        local fadeIn = TweenService:Create(sticker, TweenInfo.new(config.fadeIn.time), {
            ImageTransparency = config.fadeIn.trans,
            Size = UDim2.new(0, config.fadeIn.size, 0, config.fadeIn.size)
        })
        
        local hold = TweenService:Create(sticker, TweenInfo.new(config.hold.time), {
            Size = UDim2.new(0, config.hold.size, 0, config.hold.size)
        })
        
        local fadeOut = TweenService:Create(sticker, TweenInfo.new(config.fadeOut.time), {
            ImageTransparency = config.fadeOut.trans,
            Size = UDim2.new(0, config.fadeOut.size, 0, config.fadeOut.size)
        })
        
        fadeIn:Play()
        fadeIn.Completed:Wait()
        
        hold:Play()
        hold.Completed:Wait()
        
        fadeOut:Play()
        fadeOut.Completed:Wait()
        
        screenGui:Destroy()
    end)
    
    if not success then
    end
end
coroutine.wrap(playSoundEffect)()
coroutine.wrap(playStickerAnimation)()
replicatesignal(game.Players.LocalPlayer.Kill)
end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://96703287490096" then
        local parent = sound.Parent
        if parent and parent.Name == "Scary Entity" then
            local grandParent = parent.Parent
            if grandParent and grandParent.Name == "CustomEntity" then
                if not checkedEntities[grandParent] then
                    checkedEntities[grandParent] = true
                    runEvent()
                end
            end
        end
    end
end

workspace.DescendantAdded:Connect(function(obj)
    wait(0.1)
    if obj:IsA("Sound") then
        checkSound(obj)
        if not listeningSounds[obj] then
            listeningSounds[obj] = true
            obj:GetPropertyChangedSignal("SoundId"):Connect(function()
                checkSound(obj)
            end)
        end
    end
end)

for _, entity in pairs(workspace:GetChildren()) do
    if entity.Name == "CustomEntity" then
        local scary = entity:FindFirstChild("Scary Entity")
        if scary then
            for _, child in pairs(scary:GetChildren()) do
                if child:IsA("Sound") then
                    checkSound(child)
                    if not listeningSounds[child] then
                        listeningSounds[child] = true
                        child:GetPropertyChangedSignal("SoundId"):Connect(function()
                            checkSound(child)
                        end)
                    end
                end
            end
        end
    end
end
-----ENDROOM
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
    require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("End Room Task",true)
end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://140723850841863" then
        local parent = sound.Parent
        if parent and parent.Name == "Scary Entity" then
            local grandParent = parent.Parent
            if grandParent and grandParent.Name == "CustomEntity" then
                if not checkedEntities[grandParent] then
                    checkedEntities[grandParent] = true
                    runEvent()
                end
            end
        end
    end
end

workspace.DescendantAdded:Connect(function(obj)
    wait(0.1)
    if obj:IsA("Sound") then
        checkSound(obj)
        if not listeningSounds[obj] then
            listeningSounds[obj] = true
            obj:GetPropertyChangedSignal("SoundId"):Connect(function()
                checkSound(obj)
            end)
        end
    end
end)

for _, entity in pairs(workspace:GetChildren()) do
    if entity.Name == "CustomEntity" then
        local scary = entity:FindFirstChild("Scary Entity")
        if scary then
            for _, child in pairs(scary:GetChildren()) do
                if child:IsA("Sound") then
                    checkSound(child)
                    if not listeningSounds[child] then
                        listeningSounds[child] = true
                        child:GetPropertyChangedSignal("SoundId"):Connect(function()
                            checkSound(child)
                        end)
                    end
                end
            end
        end
    end
end
-----Blast
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
    require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("这把枪支看起来生锈..我小心使用..",true)
end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://140722528152072" then
        local parent = sound.Parent
        if parent and parent.Name == "Scary Entity" then
            local grandParent = parent.Parent
            if grandParent and grandParent.Name == "CustomEntity" then
                if not checkedEntities[grandParent] then
                    checkedEntities[grandParent] = true
                    runEvent()
                end
            end
        end
    end
end

workspace.DescendantAdded:Connect(function(obj)
    wait(0.1)
    if obj:IsA("Sound") then
        checkSound(obj)
        if not listeningSounds[obj] then
            listeningSounds[obj] = true
            obj:GetPropertyChangedSignal("SoundId"):Connect(function()
                checkSound(obj)
            end)
        end
    end
end)

for _, entity in pairs(workspace:GetChildren()) do
    if entity.Name == "CustomEntity" then
        local scary = entity:FindFirstChild("Scary Entity")
        if scary then
            for _, child in pairs(scary:GetChildren()) do
                if child:IsA("Sound") then
                    checkSound(child)
                    if not listeningSounds[child] then
                        listeningSounds[child] = true
                        child:GetPropertyChangedSignal("SoundId"):Connect(function()
                            checkSound(child)
                        end)
                    end
                end
            end
        end
    end
end
-------CEASE
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
    local Event = game:GetService("ReplicatedStorage").RemotesFolder.AdminPanelRunCommand
Event:FireServer(
    "LightRoom",
    {
        ["Light Color"] = Color3.new(0, 0.098297834396362, 1)
    }
)
local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()
local entity = spawner.Create({
	Entity = {
		Name = "Cease",
		Asset = "96059843141781",
		HeightOffset = 1
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
		Values = {1.5, 20, 0.1, 1}
	},
	Movement = {
		Speed = 100,
		Delay = 5,
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
		Enabled = false,
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
		Hints = {"CEASE", "你该学会辨别", "听取周围的声音", "反复进柜子躲避它"},
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
wait(7)
local Event = game:GetService("ReplicatedStorage").RemotesFolder.AdminPanelRunCommand
Event:FireServer(
    "LightRoom",
    {
        ["Light Color"] = Color3.new(0, 0, 0)
    }
)

end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://103515031866941" then
        local parent = sound.Parent
        if parent and parent.Name == "Scary Entity" then
            local grandParent = parent.Parent
            if grandParent and grandParent.Name == "CustomEntity" then
                if not checkedEntities[grandParent] then
                    checkedEntities[grandParent] = true
                    runEvent()
                end
            end
        end
    end
end

workspace.DescendantAdded:Connect(function(obj)
    wait(0.1)
    if obj:IsA("Sound") then
        checkSound(obj)
        if not listeningSounds[obj] then
            listeningSounds[obj] = true
            obj:GetPropertyChangedSignal("SoundId"):Connect(function()
                checkSound(obj)
            end)
        end
    end
end)

for _, entity in pairs(workspace:GetChildren()) do
    if entity.Name == "CustomEntity" then
        local scary = entity:FindFirstChild("Scary Entity")
        if scary then
            for _, child in pairs(scary:GetChildren()) do
                if child:IsA("Sound") then
                    checkSound(child)
                    if not listeningSounds[child] then
                        listeningSounds[child] = true
                        child:GetPropertyChangedSignal("SoundId"):Connect(function()
                            checkSound(child)
                        end)
                    end
                end
            end
        end
    end
end
---------Ripper Jump
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
    local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

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

local function createScreenFlash()

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "RipperJumpFlash"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.IgnoreGuiInset = true
    
    local imageLabel = Instance.new("ImageLabel")
    imageLabel.Name = "FlashImage"
    imageLabel.Image = "rbxassetid://2510585515"
    imageLabel.Size = UDim2.new(1, 0, 1, 0)
    imageLabel.Position = UDim2.new(0, 0, 0, 0)
    imageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    imageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
    imageLabel.Size = UDim2.new(1.2, 0, 1.2, 0) 
    imageLabel.BackgroundTransparency = 1
    imageLabel.ImageTransparency = 0.9 
    imageLabel.ImageColor3 = Color3.new(1, 1, 1)
    imageLabel.Parent = screenGui
    
    screenGui.Parent = player:WaitForChild("PlayerGui")
    
    local tweenService = game:GetService("TweenService")

    local flashDuration = 5
    local startTime = tick()
    local currentFlashCount = 0
    
    while tick() - startTime < flashDuration do
        local elapsedTime = tick() - startTime
        local progress = elapsedTime / flashDuration

        local targetTransparency = 0.9 - (progress * 0.8)
        if targetTransparency < 0.1 then
            targetTransparency = 0.1
        end

        local currentSpeed = 0.5 - (progress * 0.4)
        if currentSpeed < 0.1 then
            currentSpeed = 0.1
        end
        
        local flashDurationHalf = currentSpeed / 2

        local fadeInTween = tweenService:Create(
            imageLabel,
            TweenInfo.new(flashDurationHalf * 0.5, Enum.EasingStyle.Linear),
            {ImageTransparency = targetTransparency}
        )
        fadeInTween:Play()
        fadeInTween.Completed:Wait()

        wait(flashDurationHalf * 0.1)

        local fadeOutTransparency = targetTransparency + 0.3
        if fadeOutTransparency > 0.9 then
            fadeOutTransparency = 0.9
        end
        
        local fadeOutTween = tweenService:Create(
            imageLabel,
            TweenInfo.new(flashDurationHalf * 0.5, Enum.EasingStyle.Linear),
            {ImageTransparency = fadeOutTransparency}
        )
        fadeOutTween:Play()
        fadeOutTween.Completed:Wait()

        wait(flashDurationHalf * 0.1)
        
        currentFlashCount += 1

        if progress > 0.7 then
            imageLabel.ImageTransparency = targetTransparency - 0.1
        end
    end

    for i = 1, 5 do
        local intensity = 1 - (i * 0.15)

        local quickFadeIn = tweenService:Create(
            imageLabel,
            TweenInfo.new(0.08, Enum.EasingStyle.Linear),
            {ImageTransparency = 0.1 + (i * 0.05)} 
        )
        quickFadeIn:Play()
        quickFadeIn.Completed:Wait()
        
        wait(0.05)

        local quickFadeOut = tweenService:Create(
            imageLabel,
            TweenInfo.new(0.08, Enum.EasingStyle.Linear),
            {ImageTransparency = 0.5 + (i * 0.1)} 
        )
        quickFadeOut:Play()
        quickFadeOut.Completed:Wait()
        
        wait(0.05)
    end

    local finalFlash = tweenService:Create(
        imageLabel,
        TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {ImageTransparency = 0.05}
    )
    finalFlash:Play()
    finalFlash.Completed:Wait()
    
    wait(0.1)

    local finalFadeOut = tweenService:Create(
        imageLabel,
        TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
        {ImageTransparency = 1}
    )
    finalFadeOut:Play()
    finalFadeOut.Completed:Wait()

    wait(0.3)
    screenGui:Destroy()
end

local function createJumpScareAtPlayer()
    local jumpModel = LoadCustomInstance(104190508011063, workspace)
    if not jumpModel then

        return
    end
    
    jumpModel.Name = "RipperJumpFace_Player"
    
    local primaryPart
    if jumpModel:IsA("Model") then
        primaryPart = jumpModel.PrimaryPart or jumpModel:FindFirstChildWhichIsA("BasePart")
        if primaryPart then
            jumpModel.PrimaryPart = primaryPart
        end
    else
        primaryPart = jumpModel
    end
    
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if rootPart and primaryPart then
        local angle = math.random() * 2 * math.pi
        local distance = math.random(15, 25)
        local offset = Vector3.new(
            math.cos(angle) * distance,
            6,
            math.sin(angle) * distance
        )
        
        local spawnPosition = rootPart.Position + offset
        
        if jumpModel:IsA("Model") and jumpModel.PrimaryPart then
            jumpModel:SetPrimaryPartCFrame(CFrame.new(spawnPosition))
        else
            jumpModel.CFrame = CFrame.new(spawnPosition)
        end
        
        local camera = workspace.CurrentCamera
        local originalCameraType = camera.CameraType
        local originalSubject = camera.CameraSubject
        
        camera.CameraType = Enum.CameraType.Scriptable
        
        local lookAtPos = primaryPart.Position
        local cameraPos = lookAtPos + Vector3.new(0, 3, -7)
        camera.CFrame = CFrame.lookAt(cameraPos, lookAtPos)
        
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = 0
            humanoid.JumpPower = 0
        end
        
        spawn(function()
            createScreenFlash()
        end)
        
        wait(5)
        
        if humanoid then
            humanoid.WalkSpeed = 16
            humanoid.JumpPower = 50
        end
        
        if camera then
            camera.CameraType = originalCameraType
            camera.CameraSubject = originalSubject
        end
    end
    
    jumpModel:Destroy()
end

local function triggerJumpScare()
    if not character or not character.Parent then
        return
    end
    
    createJumpScareAtPlayer()
end

local ripperCheckConnection
local function startRipperCheck()
    if ripperCheckConnection then
        ripperCheckConnection:Disconnect()
    end
    
    ripperCheckConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if not character or not character.Parent then
            if ripperCheckConnection then
                ripperCheckConnection:Disconnect()
            end
            return
        end
        
        local ripperModel = workspace:FindFirstChild("Ripper")
        
        if not ripperModel then
            if ripperCheckConnection then
                ripperCheckConnection:Disconnect()
            end
            triggerJumpScare()
        end
    end)
end

startRipperCheck()

player.CharacterAdded:Connect(function(newChar)
    character = newChar
    wait(1)
    startRipperCheck()
end)

wait(6)
replicatesignal(game.Players.LocalPlayer.Kill)
end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://109318460496354" then
        local parent = sound.Parent
        if parent and parent.Name == "Scary Entity" then
            local grandParent = parent.Parent
            if grandParent and grandParent.Name == "CustomEntity" then
                if not checkedEntities[grandParent] then
                    checkedEntities[grandParent] = true
                    runEvent()
                end
            end
        end
    end
end

workspace.DescendantAdded:Connect(function(obj)
    wait(0.1)
    if obj:IsA("Sound") then
        checkSound(obj)
        if not listeningSounds[obj] then
            listeningSounds[obj] = true
            obj:GetPropertyChangedSignal("SoundId"):Connect(function()
                checkSound(obj)
            end)
        end
    end
end)

for _, entity in pairs(workspace:GetChildren()) do
    if entity.Name == "CustomEntity" then
        local scary = entity:FindFirstChild("Scary Entity")
        if scary then
            for _, child in pairs(scary:GetChildren()) do
                if child:IsA("Sound") then
                    checkSound(child)
                    if not listeningSounds[child] then
                        listeningSounds[child] = true
                        child:GetPropertyChangedSignal("SoundId"):Connect(function()
                            checkSound(child)
                        end)
                    end
                end
            end
        end
    end
end
----deergodjump
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
    local Event = game:GetService("ReplicatedStorage").RemotesFolder.AdminPanelRunCommand
Event:FireServer(
    "Break Lights",
    {
        ["Lights Affected"] = 100,
        ["Affect All Rooms"] = true
    }
)
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

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

local function createJumpScareAtPlayer()
    local jumpModel = LoadCustomInstance(78610714185582, workspace)
    if not jumpModel then
        return
    end
    
    jumpModel.Name = "DGJF"
    
    local primaryPart
    if jumpModel:IsA("Model") then
        primaryPart = jumpModel.PrimaryPart or jumpModel:FindFirstChildWhichIsA("BasePart")
        if primaryPart then
            jumpModel.PrimaryPart = primaryPart
        end
    else
        primaryPart = jumpModel
    end
    
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if rootPart and primaryPart then
        local angle = math.random() * 2 * math.pi
        local distance = math.random(5, 15)
        local offset = Vector3.new(
            math.cos(angle) * distance,
            -0.8,
            math.sin(angle) * distance
        )
        
        local spawnPosition = rootPart.Position + offset
        
        if jumpModel:IsA("Model") and jumpModel.PrimaryPart then
            jumpModel:SetPrimaryPartCFrame(CFrame.new(spawnPosition))
        else
            jumpModel.CFrame = CFrame.new(spawnPosition)
        end
        
        local camera = workspace.CurrentCamera
        local originalCameraType = camera.CameraType
        local originalSubject = camera.CameraSubject
        
        camera.CameraType = Enum.CameraType.Scriptable
        
        local lookAtPos = primaryPart.Position
        local cameraPos = lookAtPos + Vector3.new(0, 3, -7)
        camera.CFrame = CFrame.lookAt(cameraPos, lookAtPos)
        
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = 0
            humanoid.JumpPower = 0
        end
        
        spawn(function()
            createScreenFlash()
        end)
        
        wait(5)

require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("你似乎不明白",true)
wait(2)
require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("躲藏永远躲避不了我",true)
wait(2)
        local TweenService = game:GetService("TweenService")

local function showFullscreenImage()
    local player = game.Players.LocalPlayer
    local gui = player:WaitForChild("PlayerGui")
    local screenGui = Instance.new("ScreenGui", gui)
    screenGui.Name = "FullscreenImage"
    screenGui.IgnoreGuiInset = true  
    
    local image = Instance.new("ImageLabel", screenGui)
    image.Name = "FullscreenImageLabel"
    
    image.Image = "rbxassetid://115142446909754"
    image.Size = UDim2.new(2, 0, 1, 0)
    image.Position = UDim2.new(-0.5, 0, 0, 0)
    image.BackgroundTransparency = 1
    image.ImageTransparency = 1

    image.ScaleType = Enum.ScaleType.Fit
    image.BackgroundColor3 = Color3.new(0, 0, 0)
    
    local fadeIn = TweenService:Create(image, TweenInfo.new(0.01, Enum.EasingStyle.Linear), {ImageTransparency = 0})
    fadeIn:Play()

    fadeIn.Completed:Wait()
local sound = Instance.new("Sound", workspace)
sound.SoundId = "rbxassetid://116282238939992"
sound.Volume = 1
sound:Play()

replicatesignal(game.Players.LocalPlayer.Kill)
    wait(0.1)

    local fadeOut = TweenService:Create(image, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {ImageTransparency = 1})
    fadeOut:Play()
    
sound.Ended:Wait()
sound:Destroy() 
    fadeOut.Completed:Wait()
    screenGui:Destroy()
end
showFullscreenImage()

        if humanoid then
            humanoid.WalkSpeed = 16
            humanoid.JumpPower = 50
        end
        
        if camera then
            camera.CameraType = originalCameraType
            camera.CameraSubject = originalSubject
        end
    end
    
    jumpModel:Destroy()
end

local function triggerJumpScare()
    if not character or not character.Parent then
        return
    end
    
    createJumpScareAtPlayer()
end

local ripperCheckConnection
local function startRipperCheck()
    if ripperCheckConnection then
        ripperCheckConnection:Disconnect()
    end
    
    ripperCheckConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if not character or not character.Parent then
            if ripperCheckConnection then
                ripperCheckConnection:Disconnect()
            end
            return
        end
        
        local ripperModel = workspace:FindFirstChild("Ripper")
        
        if not ripperModel then
            if ripperCheckConnection then
                ripperCheckConnection:Disconnect()
            end
            triggerJumpScare()
        end
    end)
end

for _, obj in pairs(workspace:GetChildren()) do
    if obj.Name == "DGJF" then
        obj:Destroy()
    end
end

startRipperCheck()

player.CharacterAdded:Connect(function(newChar)
    character = newChar
    wait(1)
    startRipperCheck()
end)
end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://140690368868329" then
        local parent = sound.Parent
        if parent and parent.Name == "Scary Entity" then
            local grandParent = parent.Parent
            if grandParent and grandParent.Name == "CustomEntity" then
                if not checkedEntities[grandParent] then
                    checkedEntities[grandParent] = true
                    runEvent()
                end
            end
        end
    end
end

workspace.DescendantAdded:Connect(function(obj)
    wait(0.1)
    if obj:IsA("Sound") then
        checkSound(obj)
        if not listeningSounds[obj] then
            listeningSounds[obj] = true
            obj:GetPropertyChangedSignal("SoundId"):Connect(function()
                checkSound(obj)
            end)
        end
    end
end)

for _, entity in pairs(workspace:GetChildren()) do
    if entity.Name == "CustomEntity" then
        local scary = entity:FindFirstChild("Scary Entity")
        if scary then
            for _, child in pairs(scary:GetChildren()) do
                if child:IsA("Sound") then
                    checkSound(child)
                    if not listeningSounds[child] then
                        listeningSounds[child] = true
                        child:GetPropertyChangedSignal("SoundId"):Connect(function()
                            checkSound(child)
                        end)
                    end
                end
            end
        end
    end
end
----curilight
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
    local Event = game:GetService("ReplicatedStorage").RemotesFolder.AdminPanelRunCommand
    Event:FireServer("Break Lights", {["Lights Affected"] = 100, ["Affect All Rooms"] = true})
    task.wait(1)
    Event:FireServer("LightRoom", {["Light Color"] = Color3.new(0.80784314870834, 0.63644915819168, 0)})
    task.wait(0.1)
    Event:FireServer("DELETE ALL", {})
    task.wait(2)
    
    local function deleteDirectChildModels()
        for _, name in ipairs({"A-200", "A60", "Amin-60", "Black-A60", "Deer god", "DeerGod", "Frostbite", "@&%^#*$Indescribable God!@$*&^!Q(* ", "LightSpeed", "Rebound", "Ripper", "Following_ENEMY", "Silence", "smiler", "Chainsmoker"}) do
            local model = workspace:FindFirstChild(name)
            if model and model:IsA("Model") then model:Destroy() end
        end
    end
    deleteDirectChildModels()
    
    function GetRoom()
        return workspace.CurrentRooms:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value)
    end
    
    function LoadCustomInstance(source)
        local model
        while task.wait() and not model do
            if tonumber(source) then
                local success, result = pcall(function() return game:GetObjects("rbxassetid://"..tostring(source))[1] end)
                if success and result then model = result end
            end
        end
        if model then
            model.Parent = workspace
            for _, obj in ipairs(model:GetDescendants()) do
                if obj:IsA("Script") or obj:IsA("LocalScript") then obj:Destroy() end
            end
        end
        return model
    end
    
    local s = LoadCustomInstance("78378481962514")
    if not s then return end
    s.Name = "CuriLight"
    
    local entity = s:FindFirstChildWhichIsA("BasePart")
    if entity then entity.CFrame = GetRoom():WaitForChild("RoomEntrance").CFrame * CFrame.new(0,5,-25) end
    
    pcall(function()
        local room = workspace.CurrentRooms:FindFirstChild(tostring(game.ReplicatedStorage.GameData.LatestRoom.Value))
        if room then
            for _, obj in ipairs(room:GetDescendants()) do
                if obj.Name == "PlaySound" and obj:IsA("Sound") then
                    obj:Stop() obj.Playing = false obj.TimePosition = 0 obj.Looped = false
                end
            end
            local fireplace = room.Assets.Fireplace.Fireplace_Logs
            fireplace.ToolEventPrompt.Enabled = false
            local log = fireplace.Log
            log.SparkParticles.Enabled = false
            log.SmokeParticles.Enabled = false
            log.FireParticles.Enabled = false
            log.FireLight.Enabled = false
        end
    end)
    task.wait(0.5)
    
    function GitAud(soundgit, filename)
        local url = soundgit
        local FileName = filename
        writefile(FileName..".mp3", game:HttpGet(url))
        return (getcustomasset or getsynasset)(FileName..".mp3")
    end
    function CustomGitSound(soundlink, vol, filename)
        local sound = Instance.new("Sound")
        sound.SoundId = GitAud(soundlink, filename)
        sound.Parent = workspace
        sound.Name = filename or "CL"
        sound.Volume = vol or 1
        sound:Play()
        return sound
    end
    
    local targetAudioUrl = "https://github.com/Zero0star/RipperMPSound/blob/master/CuriLightSpeak.mp3?raw=true"
    local volume = 2
    local localFileName = "CruiMu"
    
    local function setupCuriLightFeatures()
        local CuriLight = workspace:FindFirstChild("CuriLight")
        if not CuriLight or not CuriLight:IsA("Model") then return end
        
        local humanoid = CuriLight:FindFirstChildOfClass("Humanoid")
        if not humanoid then
            humanoid = Instance.new("Humanoid")
            humanoid.Name = "Humanoid"
            humanoid.WalkSpeed = 0
            humanoid.JumpPower = 0
            humanoid.AutoRotate = false
            humanoid.Parent = CuriLight
        end
        
        local function playAnimation()
            local animator = humanoid:FindFirstChildOfClass("Animator")
            if not animator then animator = Instance.new("Animator") animator.Parent = humanoid end
            
            local animationId = "rbxassetid://122746752555782"
            local success, errorMsg = pcall(function()
                local animation = Instance.new("Animation")
                animation.AnimationId = animationId
                animation.Name = "CuriLightAnimation"
                local animationTrack = humanoid:LoadAnimation(animation)
                if animationTrack then 
                    animationTrack.Looped = true
                    animationTrack:Play()
                    return animationTrack
                end
                return nil
            end)
            
            if not success then warn("NO:", errorMsg) end
        end
        
        playAnimation()
        
        local function getPrimaryPart(model)
            if model.PrimaryPart then return model.PrimaryPart end
            local parts = {"HumanoidRootPart", "Head", "Torso", "UpperTorso", "Part"}
            for _, partName in ipairs(parts) do
                local part = model:FindFirstChild(partName)
                if part and part:IsA("BasePart") then return part end
            end
            for _, child in ipairs(model:GetChildren()) do
                if child:IsA("BasePart") then return child end
            end
            return nil
        end
        
        local curiLightPart = getPrimaryPart(CuriLight)
        if not curiLightPart then return end
        
        local CONFIG = {ROTATION_SPEED = 5, SMOOTHNESS = 0.1, HEIGHT_OFFSET = 0, MAX_DISTANCE = 100, ENABLED = true}
        local lastUpdateTime = tick()
        local connection
        
        local function updateLookAt()
            if not CONFIG.ENABLED then return end
            local character = game.Players.LocalPlayer.Character
            if not character then return end
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            if not humanoidRootPart then return end
            local distance = (humanoidRootPart.Position - curiLightPart.Position).Magnitude
            if distance > CONFIG.MAX_DISTANCE then return end
            local targetPosition = humanoidRootPart.Position + Vector3.new(0, CONFIG.HEIGHT_OFFSET, 0)
            local curiLightPosition = curiLightPart.Position
            local direction = (targetPosition - curiLightPosition).Unit
            local targetLookAt = CFrame.lookAt(curiLightPosition, curiLightPosition + direction)
            local _, currentY, _ = curiLightPart.CFrame:ToOrientation()
            local _, targetY, _ = targetLookAt:ToOrientation()
            local yawDifference = targetY - currentY
            if yawDifference > math.pi then yawDifference = yawDifference - 2 * math.pi
            elseif yawDifference < -math.pi then yawDifference = yawDifference + 2 * math.pi end
            local deltaTime = tick() - lastUpdateTime
            lastUpdateTime = tick()
            local lerpAmount = 1 - math.exp(-CONFIG.ROTATION_SPEED * deltaTime)
            local lerpedY = currentY + yawDifference * lerpAmount
            local newCFrame = CFrame.new(curiLightPosition) * CFrame.Angles(0, lerpedY, 0)
            curiLightPart.CFrame = newCFrame
        end
        
        connection = game:GetService("RunService").Heartbeat:Connect(updateLookAt)
        
        game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
            if input.KeyCode == Enum.KeyCode.T and not gameProcessed then CONFIG.ENABLED = not CONFIG.ENABLED end
        end)
        
        return CuriLight, connection
    end
    
    local curiModel, curiConnection = setupCuriLightFeatures()
    task.wait(5)
    
    local sound = CustomGitSound(targetAudioUrl, volume, localFileName)
    
    task.wait(1)
    
    require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("Dead Again",true)
    task.wait(3)
    require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("You know better than I how to save yourself.",true)
    task.wait(2.5)
    require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("OH",true)
    task.wait(1.4)
    require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("I think you are using something called admin.",true)
    task.wait(2.8)
    require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("Sorry..",true)
    task.wait(2.2)
    require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("But my appearance is not to save you.",true)
    task.wait(2.5)
    require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("In short, be careful next time...",true)
    task.wait(2.2)
    require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("However, I will always keep an eye on you.",true)
    task.wait(4)
    require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("Okey..",true)
    task.wait(2)
    require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("See U Again",true)
    
    sound.Ended:Wait()
    
    if curiConnection then curiConnection:Disconnect() end
    if curiModel then curiModel:Destroy() end
end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://100192030036066" then
        local parent = sound.Parent
        if parent and parent.Name == "Scary Entity" then
            local grandParent = parent.Parent
            if grandParent and grandParent.Name == "CustomEntity" then
                if not checkedEntities[grandParent] then
                    checkedEntities[grandParent] = true
                    runEvent()
                end
            end
        end
    end
end

workspace.DescendantAdded:Connect(function(obj)
    wait(0.1)
    if obj:IsA("Sound") then
        checkSound(obj)
        if not listeningSounds[obj] then
            listeningSounds[obj] = true
            obj:GetPropertyChangedSignal("SoundId"):Connect(function()
                checkSound(obj)
            end)
        end
    end
end)

for _, entity in pairs(workspace:GetChildren()) do
    if entity.Name == "CustomEntity" then
        local scary = entity:FindFirstChild("Scary Entity")
        if scary then
            for _, child in pairs(scary:GetChildren()) do
                if child:IsA("Sound") then
                    checkSound(child)
                    if not listeningSounds[child] then
                        listeningSounds[child] = true
                        child:GetPropertyChangedSignal("SoundId"):Connect(function()
                            checkSound(child)
                        end)
                    end
                end
            end
        end
    end
end
----shoker
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
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
            -- Đang nhìn
            if not lookStart then
                lookStart = tick()
            elseif tick() - lookStart >= lookDuration then
                hasTriggered = true
                connection:Disconnect()

                horrorScream:Play()
                if boneSound then boneSound:Play() end
                humanoid:TakeDamage(30)

                -- Tween lao tới player
                local targetPos = character.HumanoidRootPart.Position + Vector3.new(0, 2, 0)
                local tweenInfo = TweenInfo.new(1.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
                local tween = TweenService:Create(oogaBoogaaPart, tweenInfo, {Position = targetPos})
                tween:Play()

                tween.Completed:Connect(function()
                    -- Sau khi lao tới thì rơi xuống đất
                    fallToGround()
                end)

                -- Death message
                ReplicatedStorage.GameStats["Player_".. player.Name].Total.DeathCause.Value = "Shocker"
                firesignal(ReplicatedStorage.RemotesFolder.DeathHint.OnClientEvent, {
                    "You died to who you call Shocker...",
                    "Don't look at it or it stuns you!"
                }, "Blue")
            end
        else
            -- Không nhìn → ngã luôn
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
end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://9113115842" then
        local parent = sound.Parent
        if parent and parent.Name == "Scary Entity" then
            local grandParent = parent.Parent
            if grandParent and grandParent.Name == "CustomEntity" then
                if not checkedEntities[grandParent] then
                    checkedEntities[grandParent] = true
                    runEvent()
                end
            end
        end
    end
end

workspace.DescendantAdded:Connect(function(obj)
    wait(0.1)
    if obj:IsA("Sound") then
        checkSound(obj)
        if not listeningSounds[obj] then
            listeningSounds[obj] = true
            obj:GetPropertyChangedSignal("SoundId"):Connect(function()
                checkSound(obj)
            end)
        end
    end
end)

for _, entity in pairs(workspace:GetChildren()) do
    if entity.Name == "CustomEntity" then
        local scary = entity:FindFirstChild("Scary Entity")
        if scary then
            for _, child in pairs(scary:GetChildren()) do
                if child:IsA("Sound") then
                    checkSound(child)
                    if not listeningSounds[child] then
                        listeningSounds[child] = true
                        child:GetPropertyChangedSignal("SoundId"):Connect(function()
                            checkSound(child)
                        end)
                    end
                end
            end
        end
    end
end
-------seek2
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

local targetAudioUrl = "https://github.com/Sosnen/Ping-s-Dumbass-projects-/raw/main/Here%20i%20come%20but%20WHAT%20THE%20FUCK.mp3"
local newFileName = "SeekMusicNew"
local volume = 5

local CUSTOM_SEEK_MODEL_ID = "rbxassetid://91573224733706"

if Workspace:FindFirstChild("hardcoreInit") then
    return
else
    local hardcoreInit = Instance.new("BoolValue", Workspace)
    hardcoreInit.Name = "hardcoreInit"
end

local customSeekAudio = nil
local audioLoaded = false
local isReplacingSeek = false
local currentCustomSeek = nil
local latestSeekClone = nil
local seekMusicAsset = nil

local function loadAudioFromGitHub()
    spawn(function()
        pcall(function()
            local audioData = game:HttpGet(targetAudioUrl)
            writefile(newFileName .. ".mp3", audioData)
            local customAsset = (getcustomasset or getsynasset)(newFileName .. ".mp3")
            seekMusicAsset = customAsset
            audioLoaded = true
        end)
    end)
end

local function replaceSeekMusic()
    Workspace.DescendantAdded:Connect(function(descendant)
        if descendant.Parent ~= nil and descendant:IsA("Sound") then
            if descendant.Name == "SeekMusic" and descendant.Parent.Name == "SeekMovingNewClone" then
                descendant.Volume = volume
                
                if seekMusicAsset and audioLoaded then
                    descendant.SoundId = seekMusicAsset
                else
                    pcall(function()
                        local audioData = game:HttpGet(targetAudioUrl)
                        writefile(newFileName .. ".mp3", audioData)
                        local customAsset = (getcustomasset or getsynasset)(newFileName .. ".mp3")
                        descendant.SoundId = customAsset
                    end)
                end
            end
        end
    end)
end

local function cleanupOldSeekModel()
    if currentCustomSeek and currentCustomSeek.Parent then
        currentCustomSeek:Destroy()
        currentCustomSeek = nil
    end
    isReplacingSeek = false
end

local function replaceSeekModel()
    local function checkAndReplace()
        wait(3.5)
        
        if isReplacingSeek then
            return
        end
        
        if not Workspace:FindFirstChild("SeekMovingNewClone") then
            return
        end
        
        local originalSeek = Workspace.SeekMovingNewClone
        
        if latestSeekClone and latestSeekClone == originalSeek then
            return
        end
        
        latestSeekClone = originalSeek
        isReplacingSeek = true
        
        cleanupOldSeekModel()
        
        local originalRig = originalSeek:FindFirstChild("SeekRig")
        if not originalRig then 
            isReplacingSeek = false
            return
        end
        
        local customSeekModel
        local success, err = pcall(function()
            customSeekModel = game:GetObjects(CUSTOM_SEEK_MODEL_ID)[1]
        end)
        
        if not success or not customSeekModel then
            isReplacingSeek = false
            return
        end
        
        customSeekModel.Name = "seek2"
        
        for _, child in pairs(customSeekModel.Figure:GetChildren()) do
            if child:IsA("Sound") then
                child:Stop()
            end
        end
        
        if originalRig.Head:FindFirstChild("Eye") then
            originalRig.Head.Eye:Destroy()
        end
        if originalRig.Head:FindFirstChild("Black") then
            originalRig.Head.Black:Destroy()
        end
        
        for _, child in pairs(originalRig:GetDescendants()) do
            if child.Name == "StringCheese" then
                child:Destroy()
            end
        end
        
        customSeekModel.Parent = Workspace
        currentCustomSeek = customSeekModel
        local customRig = customSeekModel:FindFirstChild("SeekRig")
        
        if not customRig then
            cleanupOldSeekModel()
            return
        end
        
        if not customRig:FindFirstChild("Root") then
            cleanupOldSeekModel()
            return
        end
        
        customRig:FindFirstChild("Root").Anchored = true
        
        local followConnection
        followConnection = RunService.Heartbeat:Connect(function()
            if not originalSeek or not originalSeek.Parent or not customSeekModel or not customSeekModel.Parent then
                if followConnection then
                    followConnection:Disconnect()
                end
                return
            end
            
            if originalRig:FindFirstChild("Root") and customRig:FindFirstChild("Root") then
                customRig:FindFirstChild("Root").CFrame = originalRig:FindFirstChild("Root").CFrame
            end
            
            for _, sound in pairs(originalSeek.Figure:GetChildren()) do
                if sound:IsA("Sound") then
                    sound:Stop()
                end
            end
            
            for _, part in pairs(originalRig:GetChildren()) do
                if part:IsA("BasePart") then
                    part.Transparency = 1
                end
            end
        end)
        
        repeat
            task.wait()
        until originalSeek:FindFirstChild("SeekMusic") and originalSeek.SeekMusic.IsPlaying == true
        
        spawn(function()
            wait(7)
            if customSeekModel and customSeekModel.Parent then
                local figure = customSeekModel.Figure
                figure.FootstepsFar:Play()
                figure.Footsteps:Play()
                figure.Splashing:Play()
                figure["Splashing Far"]:Play()
            end
        end)
        
        if customRig then
            local animController = customRig.AnimationController
            local raiseAnim = animController:LoadAnimation(customRig.AnimRaise)
            raiseAnim:Play()
            raiseAnim.Stopped:Wait()
            animController:LoadAnimation(customRig.AnimRun):Play()
        end
        
        spawn(function()
            ReplicatedStorage.GameData.LatestRoom.Changed:Wait()
            
            require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("使用你的体力!!!", true)
            
            if customSeekModel and customSeekModel.Parent then
                for _, child in pairs(customSeekModel.Figure:GetChildren()) do
                    if child:IsA("Sound") then
                        child:Play()
                    end
                end
            end
        end)
        
        originalSeek.AncestryChanged:Connect(function(_, parent)
            if parent == nil then
                if followConnection then
                    followConnection:Disconnect()
                end
                cleanupOldSeekModel()
                latestSeekClone = nil
            end
        end)
    end
    
    if ReplicatedStorage:FindFirstChild("GameData") and ReplicatedStorage.GameData:FindFirstChild("LatestRoom") then
        ReplicatedStorage.GameData.LatestRoom.Changed:Connect(checkAndReplace)
    else
        spawn(function()
            while true do
                wait(2)
                if Workspace:FindFirstChild("SeekMovingNewClone") and not isReplacingSeek then
                    checkAndReplace()
                end
            end
        end)
    end
end

loadAudioFromGitHub()
replaceSeekMusic()
replaceSeekModel()

local hint = Instance.new("Hint", Workspace)
hint.Text = "Loading... Doors HardCore V9.8 By Mr.key & HeavenNow :)"
game.Debris:AddItem(hint, 10)
