if workspace:FindFirstChild("HardcoreTwo") then
    return
end
local marker = Instance.new("BoolValue")
marker.Name = "HardcoreTwo"
marker.Value = true
marker.Parent = workspace
loadstring(game:HttpGet("https://github.com/Zero0Star/RipperNewSound/blob/master/Sprint.lua?raw=true"))()
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
local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()
local entityBehaviors = {}

local soundUrl = "https://github.com/Zero0Star/RipperNewSound/blob/master/BossTime.mp3?raw=true"
local soundName = "BOSSTIME"
local loadedSound

local function DownloadSound(url, name)
    local fullFileName = name .. ".mp3"
    
    local success, audioData = pcall(function()
        return game:HttpGet(url)
    end)
    
    if not success then
        return nil
    end

    local writeSuccess = pcall(function()
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
    end
    
    if not assetPath then
        return nil
    end

    local sound = Instance.new("Sound")
    sound.SoundId = assetPath
    sound.Name = name .. "_Preloaded"
    sound.Parent = workspace
    sound.Volume = 0
    return sound
end

loadedSound = DownloadSound(soundUrl, soundName)

function entityBehaviors.GrimReaper()
    if loadedSound then
        loadedSound.Volume = 1
        loadedSound:Play()
        
        local connection
        connection = loadedSound.Ended:Connect(function()
            connection:Disconnect()
            loadedSound:Stop()
            loadedSound:Destroy()
            
            pcall(function()
                delfile(soundName .. ".mp3")
            end)
        end)
    end
    
    require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("Hello.",true)
    require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).titlelocation("Survive the Grim Reaper",true)
    wait(2)
    require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("...",true)
    wait(4)
    require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("I am very unfamiliar, right?",true)
    wait(4)
    require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("You don't need to know this.",true)
    wait(4)
    require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("In short, I wish you good luck.",true)
    wait(4)
    require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("Task: Survive...",true)
end

function entityBehaviors.bsrebound()
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")
local LocalPlayer = Players.LocalPlayer

local function hideOtherPlayers()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then

            for _, part in pairs(player.Character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.Transparency = 1
                elseif part:IsA("Accessory") then

                    local handle = part:FindFirstChild("Handle")
                    if handle and handle:IsA("BasePart") then
                        handle.Transparency = 1
                    end
                end
            end

            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then

                for _, clothing in pairs(humanoid:GetChildren()) do
                    if clothing:IsA("ShirtGraphic") or clothing:IsA("Shirt") or clothing:IsA("Pants") then
                        clothing:Destroy()
                    elseif clothing:IsA("CharacterMesh") then
                        clothing:Destroy()
                    end
                end
            end

            local head = player.Character:FindFirstChild("Head")
            if head then
                local nameTag = head:FindFirstChildOfClass("BillboardGui")
                if nameTag then
                    nameTag.Enabled = false
                end
            end
        end
    end
end

hideOtherPlayers()

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        wait(0.1)
        if player ~= LocalPlayer then

            for _, part in pairs(character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.Transparency = 1
                elseif part:IsA("Accessory") then

                    local handle = part:FindFirstChild("Handle")
                    if handle and handle:IsA("BasePart") then
                        handle.Transparency = 1
                    end
                end
            end

            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then

                for _, clothing in pairs(humanoid:GetChildren()) do
                    if clothing:IsA("ShirtGraphic") or clothing:IsA("Shirt") or clothing:IsA("Pants") then
                        clothing:Destroy()
                    elseif clothing:IsA("CharacterMesh") then
                        clothing:Destroy()
                    end
                end
            end

            local head = character:FindFirstChild("Head")
            if head then
                local nameTag = head:FindFirstChildOfClass("BillboardGui")
                if nameTag then
                    nameTag.Enabled = false
                end
            end
        end
    end)
end)

local originalAtmosphere = nil
local hasOriginalAtmosphere = false

for _, child in pairs(Lighting:GetChildren()) do
    if child:IsA("Atmosphere") then
        originalAtmosphere = child:Clone() 
        hasOriginalAtmosphere = true
        break
    end
end

local originalFogStart = Lighting.FogStart
local originalFogEnd = Lighting.FogEnd
local originalFogColor = Lighting.FogColor
local originalAmbient = Lighting.Ambient
local originalOutdoorAmbient = Lighting.OutdoorAmbient
local originalBrightness = Lighting.Brightness

if hasOriginalAtmosphere then
    Lighting:WaitForChild("Atmosphere"):Destroy()
end

local fogAtmosphere = Instance.new("Atmosphere")
fogAtmosphere.Name = "ZeroVisibilityFog"
fogAtmosphere.Density = 1.0
fogAtmosphere.Offset = 0.3
fogAtmosphere.Color = Color3.fromRGB(220, 225, 230)
fogAtmosphere.Decay = Color3.fromRGB(5, 5, 8)
fogAtmosphere.Glare = 0.2
fogAtmosphere.Haze = 0.9
fogAtmosphere.Parent = Lighting

Lighting.Ambient = Color3.fromRGB(90, 95, 105)
Lighting.OutdoorAmbient = Color3.fromRGB(70, 75, 85)
Lighting.Brightness = 1.2
Lighting.FogStart = 0
Lighting.FogEnd = 50
Lighting.FogColor = Color3.fromRGB(200, 205, 210)

local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://9113731836"
sound.Volume = 1
sound.Parent = SoundService
sound:Play()

while true do
    if not sound.IsPlaying then
        sound:Play()
    end
    wait(sound.TimeLength)
end

wait(500)

sound:Stop()
sound:Destroy()

fogAtmosphere:Destroy()

Lighting.Ambient = originalAmbient
Lighting.OutdoorAmbient = originalOutdoorAmbient
Lighting.Brightness = originalBrightness
Lighting.FogStart = originalFogStart
Lighting.FogEnd = originalFogEnd
Lighting.FogColor = originalFogColor

if hasOriginalAtmosphere and originalAtmosphere then
    originalAtmosphere.Parent = Lighting
end
end

function entityBehaviors.bsfigure()
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local target = Players:FindFirstChild("sppvve")
if not target then
    return
end

local walkAnimationId = "rbxassetid://18570699250"
local idleAnimationId = "rbxassetid://18540813605"
local walkAnimationTrack = nil
local idleAnimationTrack = nil
local isMoving = false
local lastPosition = nil
local moveThreshold = 0.013

local function makePlayerTransparent(character)
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Transparency = 1
        elseif part:IsA("Decal") or part:IsA("Texture") then
            part.Transparency = 1
        end
    end
end

if target.Character then
    makePlayerTransparent(target.Character)
end

target.CharacterAdded:Connect(function(character)
    wait(0.62)
    makePlayerTransparent(character)
end)

local model = ReplicatedStorage:FindFirstChild("deer")

if not model then
    local success, loadedModel = pcall(function()
        return game:GetObjects("rbxassetid://12576230222")[1]
    end)
    
    if success and loadedModel then
        model = loadedModel
        model.Name = "Figurenow"
        model.Parent = ReplicatedStorage
    else
        return
    end
end

local mainFigurenow = model:Clone()
mainFigurenow.Parent = workspace

if not mainFigurenow.PrimaryPart then
    for _, part in pairs(mainFigurenow:GetDescendants()) do
        if part:IsA("BasePart") then
            mainFigurenow.PrimaryPart = part
            break
        end
    end
end

if not mainFigurenow.PrimaryPart then
    return
end

local function setupAnimationsInFigurenowHumanoid(parentModel)
    local humanoid = parentModel:FindFirstChild("Humanoid")
    if not humanoid then
        return nil, nil
    end
    
    local animator = humanoid:FindFirstChildWhichIsA("Animator")
    if not animator then
        animator = Instance.new("Animator")
        animator.Parent = humanoid
    end
    
    local walkAnimation = Instance.new("Animation")
    walkAnimation.AnimationId = walkAnimationId
    local idleAnimation = Instance.new("Animation")
    idleAnimation.AnimationId = idleAnimationId
    
    local walkSuccess, walkTrack = pcall(function()
        return animator:LoadAnimation(walkAnimation)
    end)
    
    local idleSuccess, idleTrack = pcall(function()
        return animator:LoadAnimation(idleAnimation)
    end)
    
    if walkSuccess and walkTrack then
        walkTrack.Looped = true
    else
        walkTrack = nil
    end
    
    if idleSuccess and idleTrack then
        idleTrack.Looped = true
    else
        idleTrack = nil
    end
    
    return walkTrack, idleTrack
end

walkAnimationTrack, idleAnimationTrack = setupAnimationsInFigurenowHumanoid(mainFigurenow)

local heightOffset = 3.5

RunService.Heartbeat:Connect(function()
    if not target or not target.Character then
        return
    end
    
    local humanoidRootPart = target.Character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then
        return
    end
    
    local currentPosition = humanoidRootPart.Position
    if lastPosition then
        local distance = (currentPosition - lastPosition).Magnitude
        local nowMoving = distance > moveThreshold
        
        if nowMoving and not isMoving then
            isMoving = true
            if walkAnimationTrack then
                walkAnimationTrack:Play()
            end
            if idleAnimationTrack then
                idleAnimationTrack:Stop()
            end
        elseif not nowMoving and isMoving then
            isMoving = false
            if walkAnimationTrack then
                walkAnimationTrack:Stop()
            end
            if idleAnimationTrack then
                idleAnimationTrack:Play()
            end
        end
    else
        if idleAnimationTrack then
            idleAnimationTrack:Play()
        end
    end
    
    lastPosition = currentPosition
    
    local targetPosition = humanoidRootPart.Position
    local headPosition = targetPosition + Vector3.new(0, heightOffset, 0)
    local targetRotation = humanoidRootPart.CFrame.Rotation
    local newCFrame = CFrame.new(headPosition) * targetRotation
    
    if mainFigurenow.PrimaryPart then
        mainFigurenow:SetPrimaryPartCFrame(newCFrame)
    end
end)
end

function entityBehaviors.bsripper()
require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("你的十字架得到了好奇之光的庇护",true)

end

function entityBehaviors.bswhoop()
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local target = Players:FindFirstChild("Yxi_na")
if not target then
    return
end

local function makePlayerTransparent(character)
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Transparency = 1
        elseif part:IsA("Decal") or part:IsA("Texture") then
            part.Transparency = 1
        end
    end
end

if target.Character then
    makePlayerTransparent(target.Character)
end

target.CharacterAdded:Connect(function(character)
    wait(0.5)
    makePlayerTransparent(character)
end)

local model = ReplicatedStorage:FindFirstChild("WHOOP")

if not model then
    local success, loadedModel = pcall(function()
        return game:GetObjects("rbxassetid://106818719931200")[1]
    end)
    
    if success and loadedModel then
        model = loadedModel
        model.Name = "WHOOP"
        model.Parent = ReplicatedStorage
    else
        return
    end
end

local clone = model:Clone()
clone.Parent = workspace

if not clone.PrimaryPart then
    for _, part in pairs(clone:GetDescendants()) do
        if part:IsA("BasePart") then
            clone.PrimaryPart = part
            break
        end
    end
end

if not clone.PrimaryPart then
    return
end

local heightOffset = 1

RunService.Heartbeat:Connect(function()
    if not target or not target.Character then
        return
    end
    
    local humanoidRootPart = target.Character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then
        return
    end
    
    local targetPosition = humanoidRootPart.Position
    local headPosition = targetPosition + Vector3.new(0, heightOffset, 0)

    local targetRotation = humanoidRootPart.CFrame.Rotation
    local newCFrame = CFrame.new(headPosition) * targetRotation
    
    clone:SetPrimaryPartCFrame(newCFrame)
end)
end

function entityBehaviors.bsdeer2()
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local target = Players:FindFirstChild("YMXeternalX")
if not target then
    return
end

local function makePlayerTransparent(character)
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Transparency = 1
        elseif part:IsA("Decal") or part:IsA("Texture") then
            part.Transparency = 1
        end
    end
end

if target.Character then
    makePlayerTransparent(target.Character)
end

target.CharacterAdded:Connect(function(character)
    wait(0.5)
    makePlayerTransparent(character)
end)

local model = ReplicatedStorage:FindFirstChild("DEERGOD?")

if not model then
    local success, loadedModel = pcall(function()
        return game:GetObjects("rbxassetid://80926918241696")[1]
    end)
    
    if success and loadedModel then
        model = loadedModel
        model.Name = "DEERGOD?"
        model.Parent = ReplicatedStorage
    else
        return
    end
end

local clone = model:Clone()
clone.Parent = workspace

if not clone.PrimaryPart then
    for _, part in pairs(clone:GetDescendants()) do
        if part:IsA("BasePart") then
            clone.PrimaryPart = part
            break
        end
    end
end

if not clone.PrimaryPart then
    return
end

local heightOffset = 0

RunService.Heartbeat:Connect(function()
    if not target or not target.Character then
        return
    end
    
    local humanoidRootPart = target.Character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then
        return
    end
    
    local targetPosition = humanoidRootPart.Position
    local headPosition = targetPosition + Vector3.new(0, heightOffset, 0)

    local targetRotation = humanoidRootPart.CFrame.Rotation
    local newCFrame = CFrame.new(headPosition) * targetRotation
    
    clone:SetPrimaryPartCFrame(newCFrame)
end)
end

function entityBehaviors.bsdeer()
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local target = Players:FindFirstChild("A_Yun66")
if not target then
    return
end

local function makePlayerTransparent(character)
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Transparency = 1
        elseif part:IsA("Decal") or part:IsA("Texture") then
            part.Transparency = 1
        end
    end
end

if target.Character then
    makePlayerTransparent(target.Character)
end

target.CharacterAdded:Connect(function(character)
    wait(0.5)
    makePlayerTransparent(character)
end)

local model = ReplicatedStorage:FindFirstChild("ds?")

if not model then
    local success, loadedModel = pcall(function()
        return game:GetObjects("rbxassetid://73999376914785")[1]
    end)
    
    if success and loadedModel then
        model = loadedModel
        model.Name = "DEERGOD?"
        model.Parent = ReplicatedStorage
    else
        return
    end
end

local clone = model:Clone()
clone.Parent = workspace

if not clone.PrimaryPart then
    for _, part in pairs(clone:GetDescendants()) do
        if part:IsA("BasePart") then
            clone.PrimaryPart = part
            break
        end
    end
end

if not clone.PrimaryPart then
    return
end

local heightOffset = 0

RunService.Heartbeat:Connect(function()
    if not target or not target.Character then
        return
    end
    
    local humanoidRootPart = target.Character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then
        return
    end
    
    local targetPosition = humanoidRootPart.Position
    local headPosition = targetPosition + Vector3.new(0, heightOffset, 0)

    local targetRotation = humanoidRootPart.CFrame.Rotation
    local newCFrame = CFrame.new(headPosition) * targetRotation
    
    clone:SetPrimaryPartCFrame(newCFrame)
end)
end


function entityBehaviors.SHOOPTWO()
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://138148333"
sound.Name = "WHOOP"
sound.Parent = workspace
sound:Play()

local targetModel = workspace:FindFirstChild("WHOOP")
if not targetModel then return end

if not targetModel.PrimaryPart then
    local rootPart = targetModel:FindFirstChild("HumanoidRootPart") or targetModel:FindFirstChildWhichIsA("BasePart")
    if rootPart then targetModel.PrimaryPart = rootPart else return end
end

local WHOOPModel = Workspace:FindFirstChild("WHOOP")
if not WHOOPModel then return end

if not WHOOPModel.PrimaryPart then
    local rootPart = WHOOPModel:FindFirstChild("HumanoidRootPart") or WHOOPModel:FindFirstChildWhichIsA("BasePart")
    if rootPart then WHOOPModel.PrimaryPart = rootPart else return end
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
    return
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
if WHOOPModel and WHOOPModel.PrimaryPart and laser1Model and laser1Model.PrimaryPart then
    laser1Model:PivotTo(WHOOPModel.PrimaryPart.CFrame)
    hideModel(targetModel)
    laser1FollowConnection = RunService.Heartbeat:Connect(function()
        if not WHOOPModel or not WHOOPModel.PrimaryPart or not laser1Model or not laser1Model.PrimaryPart or 
           not WHOOPModel.PrimaryPart.Parent or not laser1Model.Parent then
            if laser1FollowConnection then laser1FollowConnection:Disconnect() end
            return
        end
        laser1Model:PivotTo(WHOOPModel.PrimaryPart.CFrame)
    end)
else
    return
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
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local SHAKE_INTENSITY = 2
    local SHAKE_DURATION = 10
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
            if connection then connection:Disconnect() end
        end
    end)
else
    return
end

local laser2FollowConnection
if WHOOPModel and WHOOPModel.PrimaryPart and laser2Model and laser2Model.PrimaryPart then
    laser2Model:PivotTo(WHOOPModel.PrimaryPart.CFrame)
    hideModel(laser1Model)
    laser2FollowConnection = RunService.Heartbeat:Connect(function()
        if not WHOOPModel or not WHOOPModel.PrimaryPart or not laser2Model or not laser2Model.PrimaryPart or 
           not WHOOPModel.PrimaryPart.Parent or not laser2Model.Parent then
            if laser2FollowConnection then laser2FollowConnection:Disconnect() end
            return
        end
        laser2Model:PivotTo(WHOOPModel.PrimaryPart.CFrame)
    end)
else
    return
end

local soundFinished = false
local soundConnection
soundConnection = sound.Ended:Connect(function()
    soundFinished = true
    if soundConnection then soundConnection:Disconnect() end
end)
while not soundFinished do task.wait(0.1) end

if targetModel then restoreModelExceptRootPart(targetModel) end

if laser1FollowConnection then laser1FollowConnection:Disconnect() end
if laser2FollowConnection then laser2FollowConnection:Disconnect() end

if laser1Model and laser1Model.Parent then laser1Model:Destroy() end
if laser2Model and laser2Model.Parent then laser2Model:Destroy() end
if sound and sound.Parent then sound:Destroy() end
end

function entityBehaviors.DEBUGONE()
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
if not player or not player:FindFirstChild("PlayerGui") then return end

local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player.PlayerGui
screenGui.Name = "BlackOverlay"
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.DisplayOrder = 2147483647
screenGui.ResetOnSpawn = false 

local frame = Instance.new("Frame")
frame.Parent = screenGui
frame.Size = UDim2.new(1, 0, 1, 0)
frame.Position = UDim2.new(0, 0, 0, 0)
frame.AnchorPoint = Vector2.new(0, 0)
frame.BackgroundColor3 = Color3.new(0, 0, 0)
frame.BorderSizePixel = 0
frame.BackgroundTransparency = 1 
frame.ZIndex = 1000

frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
    frame.Size = UDim2.new(1, 0, 1, 0)
end)

local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://127988102685688"
sound.Volume = 5
sound.Parent = workspace

local function fadeTo(targetTransparency, duration)
    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
    local tween = TweenService:Create(frame, tweenInfo, {BackgroundTransparency = targetTransparency})
    tween:Play()
    return tween
end

task.wait(1)
local fadeInTween = fadeTo(0, 1)
sound:Play()
fadeInTween.Completed:Wait()
fadeTo(1, 1).Completed:Wait()
game.Debris:AddItem(screenGui, sound.TimeLength + 1)end
function entityBehaviors.luckblock1()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local REPLACEMENT_CONFIG = {
    ["bread"] = {assetId = 116624705319388}
}

local CHECK_INTERVAL = 0.3
local trackedTargets = {}

local function loadAsset(assetId)
    local success, result = pcall(function()
        return game:GetObjects("rbxassetid://" .. assetId)[1]
    end)
    if success and result then
        return result:Clone()
    end
    return nil
end

local function disableCollision(model)
    for _, part in ipairs(model:GetDescendants()) do
        if part:IsA("BasePart") or part:IsA("MeshPart") then
            part.CanCollide = false
            part.CanTouch = false
            part.CanQuery = false
        end
    end
end

local function hideObject(obj)
    if obj:IsA("BasePart") or obj:IsA("MeshPart") then
        if not trackedTargets[obj] then
            trackedTargets[obj] = {originalTransparency = obj.Transparency}
        end
        obj.Transparency = 1
        if obj:IsA("Tool") and obj.Handle then
            if not trackedTargets[obj].handleTransparency then
                trackedTargets[obj].handleTransparency = obj.Handle.Transparency
            end
            obj.Handle.Transparency = 1
        end
    elseif obj:IsA("Model") then
        if not trackedTargets[obj] then
            trackedTargets[obj] = {originalParts = {}}
        end
        for _, part in ipairs(obj:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("MeshPart") then
                trackedTargets[obj].originalParts[part] = part.Transparency
                part.Transparency = 1
            end
        end
    end
end

local function showObject(obj)
    local data = trackedTargets[obj]
    if not data then return end
    if obj:IsA("BasePart") or obj:IsA("MeshPart") then
        if data.originalTransparency then
            obj.Transparency = data.originalTransparency
        end
        if obj:IsA("Tool") and obj.Handle and data.handleTransparency then
            obj.Handle.Transparency = data.handleTransparency
        end
    elseif obj:IsA("Model") and data.originalParts then
        for part, transparency in pairs(data.originalParts) do
            if part and part.Parent then
                part.Transparency = transparency
            end
        end
    end
end

local function getConfig(itemName)
    local nameLower = itemName:lower()
    return REPLACEMENT_CONFIG[nameLower]
end

local function findTargets()
    local targets = {}
    
    for _, item in ipairs(workspace:GetChildren()) do
        local config = getConfig(item.Name)
        
        if item:IsA("Model") and config and item.Name ~= "Drops" then
            table.insert(targets, {target = item, config = config})
        end
        
        if item:IsA("Tool") and config then
            table.insert(targets, {target = item, config = config})
        end
        
        if (item:IsA("BasePart") or item:IsA("MeshPart")) and config then
            table.insert(targets, {target = item, config = config})
        end
        
        if item:IsA("Model") and item.Name ~= "Drops" then
            for _, child in ipairs(item:GetDescendants()) do
                local childConfig = getConfig(child.Name)
                
                if child:IsA("Model") and childConfig then
                    table.insert(targets, {target = child, config = childConfig})
                end
                
                if child:IsA("Tool") and childConfig then
                    table.insert(targets, {target = child, config = childConfig})
                end
                
                if (child:IsA("BasePart") or child:IsA("MeshPart")) and childConfig then
                    table.insert(targets, {target = child, config = childConfig})
                end
            end
        end
    end
    
    local dropsFolder = workspace:FindFirstChild("Drops")
    if dropsFolder then
        for _, item in ipairs(dropsFolder:GetChildren()) do
            if item:IsA("Model") then
                local config = getConfig(item.Name)
                if config then
                    table.insert(targets, {target = item, config = config})
                end
            end
        end
    end
    
    return targets
end

local function getPosition(target)
    if target:IsA("BasePart") or target:IsA("MeshPart") then
        return target.CFrame
    elseif target:IsA("Tool") and target.Handle then
        return target.Handle.CFrame
    elseif target:IsA("Model") then
        if target.PrimaryPart then
            return target:GetPivot()
        elseif target:FindFirstChildWhichIsA("BasePart") then
            return target:FindFirstChildWhichIsA("BasePart").CFrame
        end
    end
    return nil
end

local function createModel(target, assetId)
    local model = loadAsset(assetId)
    if not model then return nil end
    model.Name = "LuckBlock"
    model.Parent = workspace
    disableCollision(model)
    if not model.PrimaryPart then
        if model:FindFirstChildWhichIsA("BasePart") then
            model.PrimaryPart = model:FindFirstChildWhichIsA("BasePart")
        else
            model:Destroy()
            return nil
        end
    end
    
    local targetPos = getPosition(target)
    if targetPos then
        model:PivotTo(targetPos)
    end
    return model
end

local function updatePosition(data, target)
    if not data.effect or not data.effect.Parent or not target or not target.Parent then
        return false
    end
    local targetPos = getPosition(target)
    if not targetPos then
        return false
    end
    data.effect:PivotTo(targetPos)
    return true
end

local function startTracking(target, config)
    if trackedTargets[target] then return trackedTargets[target] end
    
    local effect = createModel(target, config.assetId)
    if not effect then return end
    
    hideObject(target)
    
    trackedTargets[target] = {
        effect = effect, 
        target = target,
        config = config
    }
    
    local data = trackedTargets[target]
    data.connection = RunService.RenderStepped:Connect(function()
        if not updatePosition(data, target) then
            if data.connection then
                data.connection:Disconnect()
            end
            if data.effect and data.effect.Parent then
                data.effect:Destroy()
            end
            trackedTargets[target] = nil
        end
    end)
    
    return trackedTargets[target]
end

local function stopTracking(target, restore)
    local data = trackedTargets[target]
    if not data then return end
    
    if restore then
        showObject(target)
    end
    
    if data.effect and data.effect.Parent then
        data.effect:Destroy()
    end
    
    if data.connection then
        data.connection:Disconnect()
    end
    
    trackedTargets[target] = nil
end

local function cleanup()
    for target, _ in pairs(trackedTargets) do
        if not target or not target.Parent then
            if trackedTargets[target].effect and trackedTargets[target].effect.Parent then
                trackedTargets[target].effect:Destroy()
            end
            if trackedTargets[target].connection then
                trackedTargets[target].connection:Disconnect()
            end
            trackedTargets[target] = nil
        end
    end
end

local function start()
    local lastCheck = 0
    while true do
        local currentTime = tick()
        if currentTime - lastCheck >= CHECK_INTERVAL then
            lastCheck = currentTime
            cleanup()
            local allTargets = findTargets()
            for _, targetData in ipairs(allTargets) do
                if not trackedTargets[targetData.target] then
                    startTracking(targetData.target, targetData.config)
                end
            end
            for target, data in pairs(trackedTargets) do
                if target and target.Parent then
                    local valid = false
                    local parent = target.Parent
                    while parent do
                        if parent == workspace or (parent.Name == "Drops" and parent.Parent == workspace) or (parent:IsA("Model") and parent.Parent == workspace) then
                            valid = true
                            break
                        end
                        parent = parent.Parent
                    end
                    if not valid then
                        stopTracking(target, true)
                    end
                end
            end
        end
        RunService.Heartbeat:Wait()
    end
end
task.spawn(start)
end
function entityBehaviors.TwoKane1()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local JEFF_NAME = "JeffTheKiller"
local MODEL_ID = 139609642724387
local DURATION = 10

local jeff = workspace:FindFirstChild(JEFF_NAME)
if not jeff then return end

local rootPart = jeff:FindFirstChild("HumanoidRootPart")
if not rootPart then return end

local function getClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = math.huge
    local jeffPosition = rootPart.Position
    
    for _, player in pairs(Players:GetPlayers()) do
        local character = player.Character
        if character then
            local targetRootPart = character:FindFirstChild("HumanoidRootPart")
            if targetRootPart then
                local distance = (targetRootPart.Position - jeffPosition).Magnitude
                if distance < shortestDistance then
                    shortestDistance = distance
                    closestPlayer = player
                end
            end
        end
    end
    return closestPlayer
end

local function loadModel()
    local success, result = pcall(function()
        local model = game:GetObjects("rbxassetid://" .. tostring(MODEL_ID))[1]
        if model then
            model.Parent = workspace
            return model
        end
        return nil
    end)
    
    if not success then
        return nil
    end
    
    return result
end

local function executeBehavior()
    local closestPlayer = getClosestPlayer()
    if not closestPlayer or not closestPlayer.Character then 
        return 
    end
    
    local targetRootPart = closestPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not targetRootPart then 
        return 
    end
    
    local initialCFrame = rootPart.CFrame
    local humanoid = jeff:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = 0
        humanoid.JumpPower = 0
    end
    
    local offset = targetRootPart.CFrame.LookVector * -5
    rootPart.CFrame = CFrame.new(targetRootPart.Position + offset)
    
    task.wait(1)
    
    local direction = (targetRootPart.Position - rootPart.Position) * Vector3.new(1, 0, 1)
    if direction.Magnitude > 0 then
        local lookAtCFrame = CFrame.lookAt(rootPart.Position, rootPart.Position + direction)
        rootPart.CFrame = CFrame.new(rootPart.Position) * lookAtCFrame.Rotation
    end
    
    if humanoid then
        humanoid.WalkSpeed = 50
    end
    
    local isActive = true
    
    local model = loadModel()
    if not model then
        model = Instance.new("Part")
        model.Name = "Effect"
        model.Size = Vector3.new(3, 3, 3)
        model.BrickColor = BrickColor.new("Bright red")
        model.Material = Enum.Material.Neon
        model.Parent = workspace
    end
    
    local targetPosition = targetRootPart.Position
    local startTime = time()
    
    local connection = RunService.Heartbeat:Connect(function(deltaTime)
        if not isActive or not closestPlayer.Character or not targetRootPart.Parent then
            connection:Disconnect()
            return
        end
        
        targetPosition = targetRootPart.Position
        
        local elapsed = time() - startTime
        local speedMultiplier = 1 + (elapsed / DURATION) * 2
        
        local angle = math.sin(elapsed * 3) * math.pi
        local radius = 5 + math.sin(elapsed * 2) * 2
        
        local x = math.cos(angle) * radius
        local z = math.sin(angle) * radius
        
        local orbitPosition = Vector3.new(
            targetPosition.X + x,
            targetPosition.Y + 1,
            targetPosition.Z + z
        )
        
        local moveDirection = (orbitPosition - rootPart.Position).Unit
        rootPart.CFrame = CFrame.lookAt(
            rootPart.Position + moveDirection * 30 * speedMultiplier * deltaTime * 60,
            targetPosition
        )
        
        if model and model.Parent then
            if model:IsA("Model") then
                local primaryPart = model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart")
                if primaryPart then
                    primaryPart.CFrame = CFrame.new(rootPart.Position + Vector3.new(0, 3, 0))
                end
            else
                model.CFrame = CFrame.new(rootPart.Position + Vector3.new(0, 3, 0))
            end
        end
    end)
    task.wait(DURATION)
    isActive = false
    connection:Disconnect()
    if model and model.Parent then
        model:Destroy()
    end
    if humanoid then
        humanoid.WalkSpeed = 0
    end
    rootPart.CFrame = initialCFrame
end
executeBehavior()
end

function entityBehaviors.Angler()
local entity = spawner.Create({
	Entity = {
		Name = "Angler",
		Asset = "137184736069143",
		HeightOffset = -0.6},Lights = {Flicker = {Enabled = true,Duration = 2},Shatter = true,Repair = false},Earthquake = {Enabled = false},CameraShake = {Enabled = true,Range = 200,Values = {1.5, 20, 0.1, 1}},
	Movement = {Speed = 110,Delay = 3,Reversed = false},Rebounding = {Enabled = false,Type = "ambush",Min = 4,Max = 4,Delay = math.random(10, 30) / 10},Damage = {Enabled = true,Range = 100,
		Amount = 125},Crucifixion = {Enabled = true,Range = 100,Resist = false,Break = true},Death = {Type = "Guiding",Hints = {"你死于Angler", "他和Rush一样", "看见闪灯时躲避", "这非常简单"},Cause = ""}})

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

function entityBehaviors.Z367Two1()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local Camera = workspace.CurrentCamera
local entityModel
local chaseConnection = nil
local customSpeed = 70
local activationRange = 70

local isChasing = false
local soundSystemActive = false
local bangSounds = {}
local attackSound = nil
local chaseStartTime = 0
local isShakingCamera = false
local soundManagerConnection = nil
local pandemoniumEyesBeam = nil 
local entity = spawner.Create({
	Entity = {
		Name = "Z-367",
		Asset = "100118518576966",
HeightOffset = -3},Lights = {Flicker = {Enabled = true,Duration = 1.5},Shatter = false,Repair = false},
Earthquake = {Enabled = false},CameraShake = {Enabled = false,Range = 20,Values = {1.5, 20, 0.1, 1}},
Movement = {Speed = 50,Delay = 2,Reversed = false},Rebounding = {Enabled = false,Type = "Blitz",
Min = 1,Max = math.random(1, 2),Delay = math.random(10, 30) / 10},Damage = {Enabled = false,Range = 20,Amount = 0},
Crucifixion = {Enabled = true,Range = 70,Resist = false,Break = true},Death = {Type = "Guiding",Hints = {"你被 Z-367 击败了...", "你该多练练准星!", "请仔细辨别环境中的声音", "他随时都可能出现"},Cause = ""}
})
local function findSoundsAndBeam()
    local zModel = Workspace:FindFirstChild("Z-367")
    if not zModel then return false end
    
    local pandemoniumPart = zModel:FindFirstChild("Pandemonium")
    if not pandemoniumPart then return false end
    pandemoniumEyesBeam = pandemoniumPart:FindFirstChild("PandemoniumEyes")
    if pandemoniumEyesBeam and pandemoniumEyesBeam:IsA("Beam") then
        pandemoniumEyesBeam.Enabled = false
    end
    
    attackSound = pandemoniumPart:FindFirstChild("Attack")
    
    for i = 1, 4 do
        local bangSound = pandemoniumPart:FindFirstChild("Bang"..i)
        if bangSound and bangSound:IsA("Sound") then
            table.insert(bangSounds, bangSound)
        end
    end
    
    return attackSound ~= nil and #bangSounds > 0
end

local function setPandemoniumEyesEnabled(enabled)
    if pandemoniumEyesBeam and pandemoniumEyesBeam:IsA("Beam") then
        pandemoniumEyesBeam.Enabled = enabled
    end
end

local function playRandomBang()
    if #bangSounds == 0 then return end
    
    local randomIndex = math.random(1, #bangSounds)
    local selectedSound = bangSounds[randomIndex]
    
    if selectedSound then
        selectedSound:Play()
    end
end
local function startSoundManager()
    if soundManagerConnection then
        soundManagerConnection:Disconnect()
    end
    
    local bangTimer = 0
    local nextBangInterval = math.random(2, 6)
    
    soundManagerConnection = RunService.Heartbeat:Connect(function(dt)
        if not soundSystemActive then return end
        
        local currentTime = os.clock()
        local elapsedTime = currentTime - chaseStartTime

        if elapsedTime < 0.1 and attackSound and not attackSound.Playing then
            attackSound:Play()
        end

        if elapsedTime >= 6 and attackSound and attackSound.Volume > 0.1 then
            attackSound.Volume = 0.1

        end

        if elapsedTime >= 6 and elapsedTime < 66 then
            bangTimer = bangTimer + dt
            
            if bangTimer >= nextBangInterval then
                playRandomBang()
                bangTimer = 0
                nextBangInterval = math.random(2, 6)
            end
        end

        if elapsedTime >= 66 then
            soundSystemActive = false
            soundManagerConnection:Disconnect()
            soundManagerConnection = nil
        end
    end)
end

local function startCameraShake()
    if isShakingCamera then return end
    
    isShakingCamera = true
    
    task.spawn(function()
        while isShakingCamera and soundSystemActive do
            local shakeIntensity = math.random(5, 15) / 100
            local shakeDuration = math.random(5, 10) / 100
            
            local startTime = os.clock()
            while os.clock() - startTime < shakeDuration and isShakingCamera and soundSystemActive do
                local offset = Vector3.new(
                    (math.random() - 0.5) * 2 * shakeIntensity,
                    (math.random() - 0.5) * 2 * shakeIntensity,
                    0
                )
                Camera.CFrame = Camera.CFrame + offset
                task.wait(0.01)
            end
            task.wait(math.random(5, 20) / 10)
        end
    end)
end

local function startSoundSystem()
    if soundSystemActive then return end
    
    soundSystemActive = true
    chaseStartTime = os.clock()
    
    startSoundManager()
    startCameraShake()
end

local function stopSoundSystem()
    if not soundSystemActive then return end
    
    soundSystemActive = false
    isShakingCamera = false
    
    if soundManagerConnection then
        soundManagerConnection:Disconnect()
        soundManagerConnection = nil
    end
    
    if attackSound then
        attackSound:Stop()
        attackSound.Volume = 1
    end
    
    for _, sound in ipairs(bangSounds) do
        if sound and sound.Playing then
            sound:Stop()
        end
    end
end

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

            setPandemoniumEyesEnabled(true)

            if not isChasing then
                isChasing = true
                startSoundSystem()
            end
        else

            setPandemoniumEyesEnabled(false)

            if isChasing then
                isChasing = false
                stopSoundSystem()
            end
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

    findSoundsAndBeam()
    startChaseSystem()
end)

entity:SetCallback("OnDespawning", function()
    if chaseConnection then
        chaseConnection:Disconnect()
        chaseConnection = nil
    end
    
    stopSoundSystem()
    setPandemoniumEyesEnabled(false)
end)

entity:SetCallback("OnDamagePlayer", function(newHealth)
    if newHealth == 0 then
        if chaseConnection then
            chaseConnection:Disconnect()
            chaseConnection = nil
        end
        
        stopSoundSystem()
        setPandemoniumEyesEnabled(false)

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
end

function entityBehaviors.Z367Two2()
local entity = spawner.Create({
	Entity = {
		Name = "Z-367",
		Asset = "100118518576966",
HeightOffset = -3},Lights = {Flicker = {Enabled = true,Duration = 1.5},Shatter = false,Repair = false},
Earthquake = {Enabled = false},CameraShake = {Enabled = false,Range = 20,Values = {1.5, 20, 0.1, 1}},
Movement = {Speed = 50,Delay = 2,Reversed = false},Rebounding = {Enabled = false,Type = "Blitz",
Min = 1,Max = math.random(1, 2),Delay = math.random(10, 30) / 10},Damage = {Enabled = false,Range = 20,Amount = 0},
Crucifixion = {Enabled = true,Range = 70,Resist = false,Break = true},Death = {Type = "Guiding",Hints = {"你被 Z-367 击败了...", "你该多练练准星!", "请仔细辨别环境中的声音", "他随时都可能出现"},Cause = ""}
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
function GitAud(soundgit, filename)
    local fileName = filename or "temp_audio"
    local fullFileName = fileName .. ".mp3"

    local success, audioData = pcall(function()
        return game:HttpGet(soundgit)
    end)

    if not success then
        return nil
    end

    local writeSuccess = pcall(function()
        writefile(fullFileName, audioData)
    end)

    if not writeSuccess then
        return nil
    end

    if getsynasset then
        return getsynasset(fullFileName)
    elseif getcustomasset then
        return getcustomasset(fullFileName)
    end

    return nil
end

local githubAudioUrl = "https://github.com/Zero0Star/RipperMPSound/blob/master/RipperNewSound.mp3?raw=true"
local explosionSoundUrl = "https://github.com/Zero0Star/RipperNewSound/blob/master/RipperDoorend.mp3?raw=true"

local backgroundSoundPath = GitAud(
    githubAudioUrl,
    "RipperBackgroundSound"
)

local explosionSoundPath = GitAud(
    explosionSoundUrl,
    "RipperExplosionSound"
)

if backgroundSoundPath then
    local oldBackgroundSound = workspace:FindFirstChild(
        "RipperBackgroundSound"
    )

    if oldBackgroundSound then
        oldBackgroundSound:Destroy()
    end

    local backgroundSound = Instance.new("Sound")
    backgroundSound.Name = "RipperBackgroundSound"
    backgroundSound.SoundId = backgroundSoundPath
    backgroundSound.Volume = 2
    backgroundSound.Looped = false
    backgroundSound.Parent = workspace
end

if explosionSoundPath then
    local oldExplosionSound = workspace:FindFirstChild(
        "RipperExplosionSound"
    )

    if oldExplosionSound then
        oldExplosionSound:Destroy()
    end

    local explosionSound = Instance.new("Sound")
    explosionSound.Name = "RipperExplosionSound"
    explosionSound.SoundId = explosionSoundPath
    explosionSound.Volume = 5
    explosionSound.Looped = false
    explosionSound.Parent = workspace
end

function entityBehaviors.RipperSw()
    local backgroundSound = workspace:FindFirstChild(
        "RipperBackgroundSound"
    )

    if backgroundSound then
        backgroundSound:Stop()
        backgroundSound.TimePosition = 0
        backgroundSound:Play()
    end

    local TweenService = game:GetService("TweenService")
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")

    local targetColor = Color3.fromRGB(255, 93, 93)
    local fadeDuration = 1

    local fadeInfo = TweenInfo.new(
        fadeDuration,
        Enum.EasingStyle.Linear,
        Enum.EasingDirection.Out
    )

    local function createFadeTween(object)
        if object:IsA("BasePart") or object:IsA("Light") then
            local tween = TweenService:Create(
                object,
                fadeInfo,
                {
                    Color = targetColor
                }
            )

            tween:Play()
            return tween
        end

        return nil
    end

    local function modifyObjectsWithTween()
        local currentRooms = workspace:FindFirstChild("CurrentRooms")

        if not currentRooms then
            return
        end

        for _, room in ipairs(currentRooms:GetChildren()) do
            if room:IsA("Model") then
                local assets = room:FindFirstChild("Assets")

                if assets then
                    for _, chandelier in ipairs(assets:GetChildren()) do
                        if chandelier:IsA("Model")
                            and chandelier.Name == "Chandelier"
                        then
                            local lightFixture =
                                chandelier:FindFirstChild("LightFixture")

                            if lightFixture then
                                local pointLight =
                                    lightFixture:FindFirstChild("PointLight")

                                local spotLight =
                                    lightFixture:FindFirstChild("SpotLight")

                                local neon =
                                    lightFixture:FindFirstChild("Neon")

                                if pointLight
                                    and pointLight:IsA("PointLight")
                                then
                                    createFadeTween(pointLight)
                                end

                                if spotLight
                                    and spotLight:IsA("SpotLight")
                                then
                                    createFadeTween(spotLight)
                                end

                                if neon and neon:IsA("BasePart") then
                                    createFadeTween(neon)
                                end
                            end
                        end
                    end

                    local lightFixtures =
                        assets:FindFirstChild("Light_Fixtures")

                    if lightFixtures then
                        for _, lightStand in ipairs(
                            lightFixtures:GetChildren()
                        ) do
                            if lightStand:IsA("Model")
                                and lightStand.Name == "LightStand"
                            then
                                local lightFixture =
                                    lightStand:FindFirstChild(
                                        "LightFixture"
                                    )

                                if lightFixture then
                                    local pointLight =
                                        lightFixture:FindFirstChild(
                                            "PointLight"
                                        )

                                    local neon =
                                        lightFixture:FindFirstChild("Neon")

                                    if pointLight
                                        and pointLight:IsA("PointLight")
                                    then
                                        createFadeTween(pointLight)
                                    end

                                    if neon and neon:IsA("BasePart") then
                                        createFadeTween(neon)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    task.spawn(modifyObjectsWithTween)

    local activeRipperTween = nil
    local isJumpScaring = false
    local ripper = nil
    local ripperAsset = nil

    local function StopRipperMovement()
        if activeRipperTween then
            activeRipperTween:Cancel()
            activeRipperTween = nil
        end
    end

    local function LoadDeathModel()
        local DEATH_MODEL_ID = "104190508011063"

        local success, loadedModels = pcall(function()
            return game:GetObjects(
                "rbxassetid://" .. DEATH_MODEL_ID
            )
        end)

        if success and loadedModels and loadedModels[1] then
            local deathModel = loadedModels[1]
            deathModel.Name = "Death"
            deathModel.Parent = workspace
            return deathModel
        end

        return nil
    end

    local function TriggerRipperJumpScare(
        currentRipper,
        playerChar,
        snapshottedRipperPosition
    )
        if isJumpScaring then
            return
        end

        StopRipperMovement()
        isJumpScaring = true

        if ripperAsset and ripperAsset.Parent then
            ripperAsset:Destroy()
            ripperAsset = nil
        end

        local player = Players:GetPlayerFromCharacter(playerChar)

        if not player then
            isJumpScaring = false
            return
        end

        local playerGui = player:FindFirstChild("PlayerGui")

        if not playerGui then
            playerGui = player:WaitForChild("PlayerGui", 5)
        end

        if not playerGui then
            isJumpScaring = false
            return
        end

        local noiseGui = Instance.new("ScreenGui")
        noiseGui.Name = "Noise"
        noiseGui.IgnoreGuiInset = true
        noiseGui.ResetOnSpawn = false
        noiseGui.Parent = playerGui

        local staticImg = Instance.new("ImageLabel")
        staticImg.BackgroundTransparency = 1
        staticImg.Size = UDim2.new(1, 0, 1, 0)
        staticImg.Image = "rbxassetid://236542974"
        staticImg.ImageTransparency = 1
        staticImg.Parent = noiseGui

        local images = {
            "rbxassetid://236542974",
            "rbxassetid://12784032030"
        }

        local imgIndex = 1

        task.spawn(function()
            while staticImg and staticImg.Parent do
                staticImg.Image = images[imgIndex]
                imgIndex = imgIndex % #images + 1
                task.wait(0.03)
            end
        end)

        local deathModel = workspace:FindFirstChild("Death")

        if not deathModel then
            deathModel = LoadDeathModel()
        end

        if not deathModel
            or not deathModel:FindFirstChild("Ripe")
        then
            noiseGui:Destroy()
            isJumpScaring = false
            return
        end

        local originalRipe = deathModel:FindFirstChild("Ripe")
        local ripClone = originalRipe:Clone()
        ripClone.Parent = workspace

        if ripClone:IsA("BasePart") then
            ripClone.Position = originalRipe.Position
        elseif ripClone:IsA("Model") then
            ripClone:PivotTo(originalRipe:GetPivot())
        end

        local ripeObject = ripClone:FindFirstChild("ripe")

        if ripeObject then
            local particleEmitter =
                ripeObject:FindFirstChild("ParticleEmitter")

            if particleEmitter
                and particleEmitter:IsA("ParticleEmitter")
            then
                particleEmitter.Texture =
                    "rbxassetid://11816152645"
            end
        end

        for _, desc in ipairs(ripClone:GetDescendants()) do
            if desc:IsA("ParticleEmitter") then
                task.spawn(function()
                    desc.Rate = 9999
                    task.wait(0.25)

                    if desc and desc.Parent then
                        desc.TimeScale = 0
                    end
                end)
            elseif desc:IsA("Sound") then
                desc.Volume = 0
            end
        end

        originalRipe:Destroy()

        local screamSound = Instance.new("Sound")
        screamSound.SoundId = "rbxassetid://372770465"
        screamSound.Volume = 10
        screamSound.PlaybackSpeed = 0.7
        screamSound.Parent = workspace

        local explodeSound = Instance.new("Sound")
        local explosionSound = workspace:FindFirstChild(
            "RipperExplosionSound"
        )

        if explosionSound then
            explodeSound.SoundId = explosionSound.SoundId
        end

        explodeSound.Volume = 10
        explodeSound.PlaybackSpeed = 1
        explodeSound.Parent = workspace

        local camera = workspace.CurrentCamera
        local rootPart =
            playerChar:FindFirstChild("HumanoidRootPart")

        local humanoid =
            playerChar:FindFirstChildWhichIsA("Humanoid")

        if rootPart then
            rootPart.Anchored = true
        end

        explodeSound:Play()

        local cameraShakerModule =
            game.ReplicatedStorage:FindFirstChild(
                "CameraShaker"
            )

        if cameraShakerModule then
            local explosionCameraShaker =
                require(cameraShakerModule)

            local explosionCamShake =
                explosionCameraShaker.new(
                    Enum.RenderPriority.Camera.Value,
                    function(shakeCf)
                        if camera then
                            camera.CFrame =
                                camera.CFrame * shakeCf
                        end
                    end
                )

            explosionCamShake:Start()
            explosionCamShake:ShakeOnce(
                50,
                400,
                0.1,
                0.7,
                2,
                1
            )
        end

        local originalCameraType = camera.CameraType
        camera.CameraType = Enum.CameraType.Scriptable

        local targetPart = Instance.new("Part")
        targetPart.Transparency = 1
        targetPart.CanCollide = false
        targetPart.CanTouch = false
        targetPart.CanQuery = false
        targetPart.Anchored = true
        targetPart.Position = snapshottedRipperPosition
        targetPart.Parent = workspace

        local visualDeathModel = LoadDeathModel()

        if visualDeathModel then
            visualDeathModel:PivotTo(
                CFrame.lookAt(
                    targetPart.Position,
                    targetPart.Position
                        + Vector3.new(0, 180, 0)
                )
            )
        end

        local camFocus = Instance.new("Part")
        camFocus.Transparency = 1
        camFocus.CanCollide = false
        camFocus.CanTouch = false
        camFocus.CanQuery = false
        camFocus.Anchored = true
        camFocus.CFrame = camera.CFrame
        camFocus.Parent = workspace

        local turnTween = TweenService:Create(
            camFocus,
            TweenInfo.new(
                0.69,
                Enum.EasingStyle.Circular,
                Enum.EasingDirection.InOut
            ),
            {
                CFrame = CFrame.lookAt(
                    camFocus.Position,
                    targetPart.Position
                )
            }
        )

        local renderConnection

        renderConnection =
            RunService.RenderStepped:Connect(function()
                if camFocus
                    and camFocus.Parent
                    and camera
                then
                    camera.CFrame = camFocus.CFrame
                elseif renderConnection then
                    renderConnection:Disconnect()
                end
            end)

        turnTween:Play()
        turnTween.Completed:Wait()

        task.wait(1)

        screamSound.Volume = 0
        screamSound:Play()

        TweenService:Create(
            screamSound,
            TweenInfo.new(3),
            {
                Volume = 10
            }
        ):Play()

        task.wait(3)

        TweenService:Create(
            staticImg,
            TweenInfo.new(2),
            {
                ImageTransparency = 0
            }
        ):Play()

        task.wait(2)

        TweenService:Create(
            staticImg,
            TweenInfo.new(1),
            {
                ImageTransparency = 1
            }
        ):Play()

        TweenService:Create(
            screamSound,
            TweenInfo.new(1),
            {
                Volume = 0
            }
        ):Play()

        task.wait(1)

        if rootPart and rootPart.Parent then
            rootPart.Anchored = false
        end

        if humanoid and humanoid.Parent then
            humanoid:TakeDamage(100)
        end

        if renderConnection then
            renderConnection:Disconnect()
        end

        if camera then
            camera.CameraType = originalCameraType
        end

        if noiseGui then
            noiseGui:Destroy()
        end

        if targetPart then
            targetPart:Destroy()
        end

        if camFocus then
            camFocus:Destroy()
        end

        if ripClone then
            ripClone:Destroy()
        end

        if screamSound then
            screamSound:Destroy()
        end

        if explodeSound then
            explodeSound:Destroy()
        end

        if deathModel then
            deathModel:Destroy()
        end

        if visualDeathModel then
            visualDeathModel:Destroy()
        end

        if currentRipper and currentRipper.Parent then
            currentRipper:Destroy()
        end

        ripper = nil

        local remotesFolder =
            game.ReplicatedStorage:FindFirstChild(
                "RemotesFolder"
            )

        if remotesFolder then
            local deathHint =
                remotesFolder:FindFirstChild("DeathHint")

            if deathHint then
                firesignal(
                    deathHint.OnClientEvent,
                    {
                        "你死于所谓的开膛手...",
                        "伴随极大的吼叫声后他就会出现.",
                        "它这么做时躲起来,他会检查所有的躲藏点!"
                    },
                    "Blue"
                )
            end
        end

        local gameStats =
            game.ReplicatedStorage:FindFirstChild(
                "GameStats"
            )

        if gameStats then
            local playerStat = gameStats:FindFirstChild(
                "Player_" .. player.Name
            )

            if playerStat then
                local total =
                    playerStat:FindFirstChild("Total")

                if total then
                    local deathCause =
                        total:FindFirstChild("DeathCause")

                    if deathCause then
                        deathCause.Value = "Ripper"
                    end
                end
            end
        end
    end

    local function getOrderedRooms()
        local currentRooms =
            workspace:FindFirstChild("CurrentRooms")

        local orderedRooms = {}

        if not currentRooms then
            return orderedRooms
        end

        for _, room in ipairs(currentRooms:GetChildren()) do
            if room:IsA("Model") then
                local roomNumber = tonumber(room.Name)

                if roomNumber then
                    table.insert(
                        orderedRooms,
                        {
                            Number = roomNumber,
                            Room = room
                        }
                    )
                end
            end
        end

        table.sort(
            orderedRooms,
            function(a, b)
                return a.Number < b.Number
            end
        )

        return orderedRooms
    end

    local function getOrderedNodes(pathfindNodes)
        local orderedNodes = {}

        for _, node in ipairs(
            pathfindNodes:GetChildren()
        ) do
            if node:IsA("BasePart") then
                table.insert(orderedNodes, node)
            end
        end

        table.sort(
            orderedNodes,
            function(a, b)
                local numberA = tonumber(a.Name)
                local numberB = tonumber(b.Name)

                if numberA and numberB then
                    return numberA < numberB
                elseif numberA then
                    return true
                elseif numberB then
                    return false
                end

                return a.Name < b.Name
            end
        )

        return orderedNodes
    end

    local function moveRipperTo(
        targetCFrame,
        speedFactor
    )
        if isJumpScaring
            or not ripper
            or not ripper.Parent
        then
            return false
        end

        local distance = (
            ripper.Position - targetCFrame.Position
        ).Magnitude

        local duration =
            math.max(distance / speedFactor, 0.01)

        local tween = TweenService:Create(
            ripper,
            TweenInfo.new(
                duration,
                Enum.EasingStyle.Linear,
                Enum.EasingDirection.InOut
            ),
            {
                CFrame = targetCFrame
            }
        )

        activeRipperTween = tween
        tween:Play()

        local playbackState =
            tween.Completed:Wait()

        if activeRipperTween == tween then
            activeRipperTween = nil
        end

        return playbackState
                == Enum.PlaybackState.Completed
            and not isJumpScaring
            and ripper
            and ripper.Parent ~= nil
    end

    local function ExecuteRipperPathfinding()
        local RIPPER_MODEL_ID = "104570339911705"

        local success, loadedAsset = pcall(function()
            return game:GetObjects(
                "rbxassetid://" .. RIPPER_MODEL_ID
            )[1]
        end)

        if not success or not loadedAsset then
            ripperAsset = nil
            return
        end

        ripperAsset = loadedAsset

        local basePart =
            ripperAsset:FindFirstChildWhichIsA(
                "BasePart",
                true
            )

        if not basePart then
            ripperAsset:Destroy()
            ripperAsset = nil
            return
        end

        ripper = basePart:Clone()
        ripper.Anchored = true
        ripper.Parent = workspace

        local orderedRooms = getOrderedRooms()

        if #orderedRooms == 0 then
            ripper:Destroy()
            ripper = nil
            ripperAsset:Destroy()
            ripperAsset = nil
            return
        end

        local startRoom = orderedRooms[1].Room
        local startNode = nil
        local startPathfindNodes =
            startRoom:FindFirstChild("PathfindNodes")

        if startPathfindNodes then
            local startNodes =
                getOrderedNodes(startPathfindNodes)

            startNode = startNodes[1]
        end

        if not startNode then
            startNode =
                startRoom:FindFirstChild("RoomExit")
        end

        if not startNode
            or not startNode:IsA("BasePart")
        then
            ripper:Destroy()
            ripper = nil
            ripperAsset:Destroy()
            ripperAsset = nil
            return
        end

        local heightOffset = Vector3.new(0, 2, 0)
        local speedFactor = 89

        ripper.CFrame =
            startNode.CFrame + heightOffset

        local cameraShaker = nil
        local cameraShakerModule =
            game.ReplicatedStorage:FindFirstChild(
                "CameraShaker"
            )

        if cameraShakerModule then
            local CameraShakerModule =
                require(cameraShakerModule)

            local camera = workspace.CurrentCamera

            cameraShaker = CameraShakerModule.new(
                Enum.RenderPriority.Camera.Value,
                function(shakerTransform)
                    if camera then
                        camera.CFrame =
                            camera.CFrame
                            * shakerTransform
                    end
                end
            )

            cameraShaker:Start()
        end

        local hasShaken = false

        task.spawn(function()
            while ripper
                and ripper.Parent
                and not isJumpScaring
            do
                RunService.RenderStepped:Wait()

                local player = Players.LocalPlayer

                if player and player.Character then
                    local character = player.Character

                    local humanoid =
                        character:FindFirstChildWhichIsA(
                            "Humanoid"
                        )

                    local rootPart =
                        character:FindFirstChild(
                            "HumanoidRootPart"
                        )

                    if humanoid
                        and rootPart
                        and humanoid.Health > 0
                        and not character:GetAttribute(
                            "Hiding"
                        )
                    then
                        local origin = ripper.Position
                        local target = rootPart.Position

                        local distance = (
                            origin - target
                        ).Magnitude

                        if distance < 213
                            and cameraShaker
                        then
                            if not hasShaken then
                                local amplitude =
                                    math.max(
                                        0,
                                        21
                                            * (
                                                1
                                                - distance
                                                    / 152
                                            )
                                    )

                                cameraShaker:ShakeOnce(
                                    amplitude,
                                    14,
                                    5,
                                    1,
                                    1,
                                    6
                                )

                                hasShaken = true
                            end
                        else
                            hasShaken = false
                        end

                        local difference =
                            target - origin

                        if difference.Magnitude > 0 then
                            local raycastParams =
                                RaycastParams.new()

                            raycastParams.FilterType =
                                Enum.RaycastFilterType.Exclude

                            raycastParams.FilterDescendantsInstances =
                                {
                                    ripper
                                }

                            local raycastResult =
                                workspace:Raycast(
                                    origin,
                                    difference.Unit * 66,
                                    raycastParams
                                )

                            if raycastResult
                                and raycastResult.Instance
                                and raycastResult.Instance:IsDescendantOf(
                                    character
                                )
                            then
                                TriggerRipperJumpScare(
                                    ripper,
                                    character,
                                    ripper.Position
                                )
                            end
                        end
                    end
                end
            end
        end)

        local targetRoomIndex =
            math.max(1, #orderedRooms - 1)

        local reachedFinalRoom = false
        local completedRoomIndex = 0

        for roomIndex = 1, targetRoomIndex do
            if isJumpScaring
                or not ripper
                or not ripper.Parent
            then
                break
            end

            local roomData =
                orderedRooms[roomIndex]

            local room =
                roomData and roomData.Room

            if not room or not room.Parent then
                local refreshDeadline =
                    os.clock() + 5

                repeat
                    task.wait(0.1)

                    orderedRooms =
                        getOrderedRooms()

                    roomData =
                        orderedRooms[roomIndex]

                    room =
                        roomData and roomData.Room
                until room
                    or os.clock()
                        >= refreshDeadline
                    or isJumpScaring
                    or not ripper
                    or not ripper.Parent
            end

            if not room or not room.Parent then
                break
            end

            local roomCompleted = false
            local pathfindNodes =
                room:FindFirstChild(
                    "PathfindNodes"
                )

            if pathfindNodes then
                local orderedNodes =
                    getOrderedNodes(
                        pathfindNodes
                    )

                if #orderedNodes > 0 then
                    roomCompleted = true

                    for _, node in ipairs(
                        orderedNodes
                    ) do
                        if isJumpScaring
                            or not ripper
                            or not ripper.Parent
                        then
                            roomCompleted = false
                            break
                        end

                        local moved =
                            moveRipperTo(
                                node.CFrame
                                    + heightOffset,
                                speedFactor
                            )

                        if not moved then
                            roomCompleted = false
                            break
                        end
                    end
                end
            end

            if not roomCompleted then
                local roomExit =
                    room:FindFirstChild(
                        "RoomExit"
                    )

                if roomExit
                    and roomExit:IsA(
                        "BasePart"
                    )
                then
                    roomCompleted =
                        moveRipperTo(
                            roomExit.CFrame
                                + heightOffset,
                            speedFactor
                        )
                end
            end

            if not roomCompleted then
                break
            end

            completedRoomIndex = roomIndex

            if roomIndex
                == targetRoomIndex
            then
                reachedFinalRoom = true
            end
        end

        activeRipperTween = nil

        if isJumpScaring
            or not ripper
            or not ripper.Parent
        then
            ripper = nil
            ripperAsset = nil
            return
        end

        if not reachedFinalRoom
            or completedRoomIndex
                < targetRoomIndex
        then
            if ripper and ripper.Parent then
                ripper:Destroy()
            end

            if ripperAsset
                and ripperAsset.Parent
            then
                ripperAsset:Destroy()
            end

            ripper = nil
            ripperAsset = nil
            return
        end

        local explodeSound =
            Instance.new("Sound")

        local explosionSound =
            workspace:FindFirstChild(
                "RipperExplosionSound"
            )

        if explosionSound then
            explodeSound.SoundId =
                explosionSound.SoundId
        end

        explodeSound.Volume = 5
        explodeSound.Parent = ripper
        explodeSound:Play()

        if cameraShakerModule then
            local endExplosionCameraShaker =
                require(cameraShakerModule)

            local endExplosionCam =
                workspace.CurrentCamera

            local endExplosionCamShake =
                endExplosionCameraShaker.new(
                    Enum.RenderPriority.Camera.Value,
                    function(shakeCf)
                        if endExplosionCam then
                            endExplosionCam.CFrame =
                                endExplosionCam.CFrame
                                * shakeCf
                        end
                    end
                )

            endExplosionCamShake:Start()

            endExplosionCamShake:ShakeOnce(
                300,
                400,
                0.1,
                0.7,
                2,
                1
            )
        end

        task.wait(1)

        local finalRipperPosition = nil

        if ripper and ripper.Parent then
            finalRipperPosition =
                ripper.Position

            ripper.Anchored = false
            ripper.CanCollide = false
            ripper.CanTouch = false
            ripper.CanQuery = false
        end

        if ripperAsset
            and ripperAsset.Parent
        then
            ripperAsset:Destroy()
            ripperAsset = nil
        end

        if isJumpScaring
            or not ripper
            or not ripper.Parent
        then
            ripper = nil
            return
        end

        local player = Players.LocalPlayer

        if player and player.Character then
            local character = player.Character

            local humanoid =
                character:FindFirstChildWhichIsA(
                    "Humanoid"
                )

            if humanoid
                and humanoid.Health > 0
                and not character:GetAttribute(
                    "Hiding"
                )
                and finalRipperPosition
            then
                TriggerRipperJumpScare(
                    ripper,
                    character,
                    finalRipperPosition
                )

                return
            end
        end

        local fallingRipper = ripper

        ripper = nil
        ripperAsset = nil

        task.delay(10, function()
            if fallingRipper
                and fallingRipper.Parent
            then
                fallingRipper:Destroy()
            end
        end)
    end

    task.spawn(function()
        task.wait(7)
        ExecuteRipperPathfinding()
    end)

    local function runFinalCameraShake()
        local cameraShakerModule =
            game.ReplicatedStorage:FindFirstChild(
                "CameraShaker"
            )

        if not cameraShakerModule then
            return
        end

        local CameraShaker =
            require(cameraShakerModule)

        local camera =
            workspace.CurrentCamera

        local camShake =
            CameraShaker.new(
                Enum.RenderPriority.Camera.Value,
                function(shakeCf)
                    if camera then
                        camera.CFrame =
                            camera.CFrame
                            * shakeCf
                    end
                end
            )

        camShake:Start()

        camShake:ShakeOnce(
            10,
            200,
            0.1,
            6,
            2,
            0.5
        )
    end

    runFinalCameraShake()
end

function entityBehaviors.GodEgg()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local REPLACEMENT_CONFIG = {
    ["generatorfuse"] = {assetId = 138693840664582}
}
local CHECK_INTERVAL = 0.3
local trackedTargets = {}

local function loadAssetLocally(assetId)
    local success, result = pcall(function()
        return game:GetObjects("rbxassetid://" .. assetId)[1]
    end)
    if success and result then
        return result:Clone()
    end
    return nil
end

local function disableModelCollision(model)
    for _, part in ipairs(model:GetDescendants()) do
        if part:IsA("BasePart") or part:IsA("MeshPart") then
            part.CanCollide = false
            part.CanTouch = false
            part.CanQuery = false
        end
    end
end

local function hideGeneratorFuseParts(generatorFuse)
    if not generatorFuse or not generatorFuse.Parent then return end
    
    local function hideRecursive(obj)
        if obj:IsA("MeshPart") or obj:IsA("BasePart") then
            if not trackedTargets[generatorFuse] then
                trackedTargets[generatorFuse] = {originalParts = {}}
            end
            trackedTargets[generatorFuse].originalParts[obj] = {transparency = obj.Transparency}
            obj.Transparency = 1
        end
        
        if obj:IsA("ParticleEmitter") or obj:IsA("Beam") or obj:IsA("Trail") then
            if not trackedTargets[generatorFuse] then
                trackedTargets[generatorFuse] = {originalParts = {}}
            end
            trackedTargets[generatorFuse].originalParts[obj] = {enabled = obj.Enabled}
            obj.Enabled = false
        end
        
        if obj:IsA("Texture") or obj:IsA("Decal") or obj:IsA("SurfaceAppearance") then
            if not trackedTargets[generatorFuse] then
                trackedTargets[generatorFuse] = {originalParts = {}}
            end
            trackedTargets[generatorFuse].originalParts[obj] = {transparency = obj.Transparency}
            obj.Transparency = 1
        end
        
        for _, child in ipairs(obj:GetChildren()) do
            hideRecursive(child)
        end
    end
    
    hideRecursive(generatorFuse)
end

local function restoreGeneratorFuse(generatorFuse)
    local data = trackedTargets[generatorFuse]
    if not data or not data.originalParts then return end
    
    for part, partData in pairs(data.originalParts) do
        if part and part.Parent then
            if (part:IsA("MeshPart") or part:IsA("BasePart")) and partData.transparency then
                part.Transparency = partData.transparency
            elseif (part:IsA("ParticleEmitter") or part:IsA("Beam") or part:IsA("Trail")) and partData.enabled ~= nil then
                part.Enabled = partData.enabled
            elseif (part:IsA("Texture") or part:IsA("Decal") or part:IsA("SurfaceAppearance")) and partData.transparency then
                part.Transparency = partData.transparency
            end
        end
    end
end

local function getItemConfig(itemName)
    local nameLower = itemName:lower()
    return REPLACEMENT_CONFIG[nameLower]
end

local function getTargetCFrame(target)
    if target:IsA("BasePart") or target:IsA("MeshPart") then
        return target.CFrame
    elseif target:IsA("Tool") and target:FindFirstChild("Handle") then
        return target.Handle.CFrame
    elseif target:IsA("Model") then
        if target.PrimaryPart then
            return target:GetPivot()
        elseif target:FindFirstChildWhichIsA("BasePart") then
            return target:FindFirstChildWhichIsA("BasePart").CFrame
        end
    end
    return nil
end

local function createFollowEffect(target, assetId)
    local effectModel = loadAssetLocally(assetId)
    if not effectModel then 
        return nil 
    end
    
    effectModel.Name = "GeneratorFuse_Follower"
    effectModel.Parent = workspace
    disableModelCollision(effectModel)
    
    if not effectModel.PrimaryPart then
        if effectModel:FindFirstChildWhichIsA("BasePart") then
            effectModel.PrimaryPart = effectModel:FindFirstChildWhichIsA("BasePart")
        else
            effectModel:Destroy()
            return nil
        end
    end
    
    local targetCFrame = getTargetCFrame(target)
    if targetCFrame then
        effectModel:PivotTo(targetCFrame)
    end
    
    return effectModel
end

local function updateEffectPosition(data, target)
    if not data.effect or not data.effect.Parent or not target or not target.Parent then
        return false
    end
    
    local targetCFrame = getTargetCFrame(target)
    if not targetCFrame then
        return false
    end
    
    data.effect:PivotTo(targetCFrame)
    return true
end

local function startTrackingTarget(target, config)
    if trackedTargets[target] then 
        return trackedTargets[target] 
    end
    
    local effectModel = createFollowEffect(target, config.assetId)
    if not effectModel then 
        return nil 
    end
    
    hideGeneratorFuseParts(target)
    
    trackedTargets[target] = {
        effect = effectModel, 
        target = target,
        config = config
    }
    
    local data = trackedTargets[target]
    
    data.connection = RunService.RenderStepped:Connect(function()
        if not updateEffectPosition(data, target) then
            if data.connection then
                data.connection:Disconnect()
            end
            if data.effect and data.effect.Parent then
                data.effect:Destroy()
            end
            trackedTargets[target] = nil
        end
    end)
    
    return trackedTargets[target]
end

local function stopTrackingTarget(target, restoreVisibility)
    local data = trackedTargets[target]
    if not data then return end
    
    if restoreVisibility then
        restoreGeneratorFuse(target)
    end
    
    if data.effect and data.effect.Parent then
        data.effect:Destroy()
    end
    
    if data.connection then
        data.connection:Disconnect()
    end
    
    trackedTargets[target] = nil
end

local function cleanupDestroyedTargets()
    for target, data in pairs(trackedTargets) do
        if not target or not target.Parent then
            if data.effect and data.effect.Parent then
                data.effect:Destroy()
            end
            if data.connection then
                data.connection:Disconnect()
            end
            trackedTargets[target] = nil
        end
    end
end

local function findAllGeneratorFuses()
    local targets = {}
    
    local function findGeneratorFusesRecursive(parent)
        for _, child in ipairs(parent:GetChildren()) do
            if child.Name:lower() == "generatorfuse" then
                local config = getItemConfig(child.Name)
                if config then
                    table.insert(targets, {target = child, config = config})
                end
            end
            findGeneratorFusesRecursive(child)
        end
    end
    
    findGeneratorFusesRecursive(workspace)
    return targets
end

local function startDetection()
    local lastCheckTime = 0
    
    while true do
        local currentTime = tick()
        
        if currentTime - lastCheckTime >= CHECK_INTERVAL then
            lastCheckTime = currentTime
            
            cleanupDestroyedTargets()
            
            local allGeneratorFuses = findAllGeneratorFuses()
            
            for _, targetData in ipairs(allGeneratorFuses) do
                if not trackedTargets[targetData.target] then
                    startTrackingTarget(targetData.target, targetData.config)
                end
            end
            
            for target, data in pairs(trackedTargets) do
                if target and target.Parent then
                    local isValid = false
                    local parent = target.Parent
                    
                    while parent do
                        if parent == workspace then
                            isValid = true
                            break
                        end
                        parent = parent.Parent
                    end
                    
                    if not isValid then
                        stopTrackingTarget(target, true)
                    end
                end
            end
        end
        RunService.Heartbeat:Wait()
    end
end
local function initialize()
    task.spawn(startDetection)
end
local function cleanup()
    for target, _ in pairs(trackedTargets) do
        stopTrackingTarget(target, true)
    end
    trackedTargets = {}
end
local function setupPlayerEvents()
    local player = Players.LocalPlayer
    if player then
        player:GetPropertyChangedSignal("Character"):Connect(function()
            cleanupDestroyedTargets()
        end)
        player.AncestryChanged:Connect(function(_, parent)
            if not parent then
                cleanup()
            end
        end)
    end
end
initialize()
setupPlayerEvents()
end

function entityBehaviors.MLbody()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local REPLACEMENT_CONFIG = {
    ["starjug"] = {assetId = 89687019396850}
}
local CHECK_INTERVAL = 0.3
local trackedTargets = {}

local function loadAssetLocally(assetId)
    local success, result = pcall(function()
        return game:GetObjects("rbxassetid://" .. assetId)[1]
    end)
    if success and result then
        return result:Clone()
    end
    return nil
end

local function disableModelCollision(model)
    for _, part in ipairs(model:GetDescendants()) do
        if part:IsA("BasePart") or part:IsA("MeshPart") then
            part.CanCollide = false
            part.CanTouch = false
            part.CanQuery = false
        end
    end
end

local function hideStarJugParts(starJug)
    if not starJug or not starJug.Parent then return end
    
    local function hideRecursive(obj)
        if obj:IsA("MeshPart") or obj:IsA("BasePart") then
            if not trackedTargets[starJug] then
                trackedTargets[starJug] = {originalParts = {}}
            end
            trackedTargets[starJug].originalParts[obj] = {transparency = obj.Transparency}
            obj.Transparency = 1
        end
        
        if obj:IsA("ParticleEmitter") or obj:IsA("Beam") or obj:IsA("Trail") then
            if not trackedTargets[starJug] then
                trackedTargets[starJug] = {originalParts = {}}
            end
            trackedTargets[starJug].originalParts[obj] = {enabled = obj.Enabled}
            obj.Enabled = false
        end
        
        if obj:IsA("Texture") or obj:IsA("Decal") or obj:IsA("SurfaceAppearance") then
            if not trackedTargets[starJug] then
                trackedTargets[starJug] = {originalParts = {}}
            end
            trackedTargets[starJug].originalParts[obj] = {transparency = obj.Transparency}
            obj.Transparency = 1
        end
        
        for _, child in ipairs(obj:GetChildren()) do
            hideRecursive(child)
        end
    end
    
    hideRecursive(starJug)
end

local function restoreStarJug(starJug)
    local data = trackedTargets[starJug]
    if not data or not data.originalParts then return end
    
    for part, partData in pairs(data.originalParts) do
        if part and part.Parent then
            if (part:IsA("MeshPart") or part:IsA("BasePart")) and partData.transparency then
                part.Transparency = partData.transparency
            elseif (part:IsA("ParticleEmitter") or part:IsA("Beam") or part:IsA("Trail")) and partData.enabled ~= nil then
                part.Enabled = partData.enabled
            elseif (part:IsA("Texture") or part:IsA("Decal") or part:IsA("SurfaceAppearance")) and partData.transparency then
                part.Transparency = partData.transparency
            end
        end
    end
end

local function getItemConfig(itemName)
    local nameLower = itemName:lower()
    return REPLACEMENT_CONFIG[nameLower]
end
local function getTargetCFrame(target)
    if target:IsA("BasePart") or target:IsA("MeshPart") then
        return target.CFrame
    elseif target:IsA("Tool") and target:FindFirstChild("Handle") then
        return target.Handle.CFrame
    elseif target:IsA("Model") then
        if target.PrimaryPart then
            return target:GetPivot()
        elseif target:FindFirstChildWhichIsA("BasePart") then
            return target:FindFirstChildWhichIsA("BasePart").CFrame
        end
    end
    return nil
end
local function createFollowEffect(target, assetId)
    local effectModel = loadAssetLocally(assetId)
    if not effectModel then 
        return nil 
    end
    effectModel.Name = "StarJug_Follower"
    effectModel.Parent = workspace
    disableModelCollision(effectModel)
    if not effectModel.PrimaryPart then
        if effectModel:FindFirstChildWhichIsA("BasePart") then
            effectModel.PrimaryPart = effectModel:FindFirstChildWhichIsA("BasePart")
        else
            effectModel:Destroy()
            return nil
        end
    end
    
    local targetCFrame = getTargetCFrame(target)
    if targetCFrame then
        effectModel:PivotTo(targetCFrame)
    end
    
    return effectModel
end

local function updateEffectPosition(data, target)
    if not data.effect or not data.effect.Parent or not target or not target.Parent then
        return false
    end
    
    local targetCFrame = getTargetCFrame(target)
    if not targetCFrame then
        return false
    end
    
    data.effect:PivotTo(targetCFrame)
    return true
end

local function startTrackingTarget(target, config)
    if trackedTargets[target] then 
        return trackedTargets[target] 
    end
    
    local effectModel = createFollowEffect(target, config.assetId)
    if not effectModel then 
        return nil 
    end
    
    hideStarJugParts(target)
    
    trackedTargets[target] = {
        effect = effectModel, 
        target = target,
        config = config
    }
    
    local data = trackedTargets[target]
    
    data.connection = RunService.RenderStepped:Connect(function()
        if not updateEffectPosition(data, target) then
            if data.connection then
                data.connection:Disconnect()
            end
            if data.effect and data.effect.Parent then
                data.effect:Destroy()
            end
            trackedTargets[target] = nil
        end
    end)
    
    return trackedTargets[target]
end

local function stopTrackingTarget(target, restoreVisibility)
    local data = trackedTargets[target]
    if not data then return end
    
    if restoreVisibility then
        restoreStarJug(target)
    end
    
    if data.effect and data.effect.Parent then
        data.effect:Destroy()
    end
    
    if data.connection then
        data.connection:Disconnect()
    end
    
    trackedTargets[target] = nil
end
local function cleanupDestroyedTargets()
    for target, data in pairs(trackedTargets) do
        if not target or not target.Parent then
            if data.effect and data.effect.Parent then
                data.effect:Destroy()
            end
            if data.connection then
                data.connection:Disconnect()
            end
            trackedTargets[target] = nil
        end
    end
end
local function findAllStarJugs()
    local targets = {}
    local function findStarJugsRecursive(parent)
        for _, child in ipairs(parent:GetChildren()) do
            if child.Name:lower() == "starjug" then
                local config = getItemConfig(child.Name)
                if config then
                    table.insert(targets, {target = child, config = config})
                end
            end
            findStarJugsRecursive(child)
        end
    end
    findStarJugsRecursive(workspace)
    return targets
end

local function startDetection()
    local lastCheckTime = 0
    
    while true do
        local currentTime = tick()
        if currentTime - lastCheckTime >= CHECK_INTERVAL then
            lastCheckTime = currentTime
            
            cleanupDestroyedTargets()
            
            local allStarJugs = findAllStarJugs()
            
            for _, targetData in ipairs(allStarJugs) do
                if not trackedTargets[targetData.target] then
                    startTrackingTarget(targetData.target, targetData.config)
                end
            end
            for target, data in pairs(trackedTargets) do
                if target and target.Parent then
                    local isValid = false
                    local parent = target.Parent
                    
                    while parent do
                        if parent == workspace then
                            isValid = true
                            break
                        end
                        parent = parent.Parent
                    end
                    
                    if not isValid then
                        stopTrackingTarget(target, true)
                    end
                end
            end
        end
        RunService.Heartbeat:Wait()
    end
end
local function initialize()
    task.spawn(startDetection)
end
local function cleanup()
    for target, _ in pairs(trackedTargets) do
        stopTrackingTarget(target, true)
    end
    trackedTargets = {}
end
local function setupPlayerEvents()
    local player = Players.LocalPlayer
    if player then
        player:GetPropertyChangedSignal("Character"):Connect(function()
            cleanupDestroyedTargets()
        end)
        player.AncestryChanged:Connect(function(_, parent)
            if not parent then
                cleanup()
            end
        end)
    end
end
initialize()
setupPlayerEvents()
end

function entityBehaviors.ADMINGUN()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local REPLACEMENT_CONFIG = {
    ["goldgun"] = {assetId = 129274626661418}
}
local CHECK_INTERVAL = 0.3
local trackedTargets = {}

local miscHandles = {}

local function loadAssetLocally(assetId)
    local success, result = pcall(function()
        return game:GetObjects("rbxassetid://" .. assetId)[1]
    end)
    if success and result then
        return result:Clone()
    end
    return nil
end

local function processGoldGunSounds(goldGun)
    if not goldGun or not goldGun.Parent then return false end
    
    local processedSounds = 0
    
    for _, descendant in ipairs(goldGun:GetDescendants()) do
        if descendant:IsA("Sound") then
            local soundName = descendant.Name:lower()
            
            if soundName == "sound_equip" or soundName == "sound_throw_client" then
                if not trackedTargets[goldGun] then
                    trackedTargets[goldGun] = {sounds = {}}
                end
                if not trackedTargets[goldGun].sounds then
                    trackedTargets[goldGun].sounds = {}
                end
                
                trackedTargets[goldGun].sounds[soundName] = {
                    originalSound = descendant:Clone(),
                    parent = descendant.Parent,
                    name = descendant.Name
                }
                
                descendant:Destroy()
                processedSounds = processedSounds + 1
            end
            
            if soundName == "sound_throw" then
                local newSoundId = "rbxassetid://139620337204036"
                
                if descendant.SoundId ~= newSoundId then
                    if not trackedTargets[goldGun] then
                        trackedTargets[goldGun] = {sounds = {}}
                    end
                    if not trackedTargets[goldGun].sounds then
                        trackedTargets[goldGun].sounds = {}
                    end
                    
                    if not trackedTargets[goldGun].sounds["sound_throw"] then
                        trackedTargets[goldGun].sounds["sound_throw"] = {
                            originalSoundId = descendant.SoundId,
                            originalSound = descendant:Clone()
                        }
                    end
                    
                    descendant.SoundId = newSoundId
                    descendant.Volume = 0.5
                    descendant.MaxDistance = 100
                    descendant.EmitterSize = 5
                    
                    processedSounds = processedSounds + 1
                end
            end
            
            if soundName == "sound_inspect" then
                local newSoundId = "rbxassetid://134995295985396"
                
                if descendant.SoundId ~= newSoundId then
                    if not trackedTargets[goldGun] then
                        trackedTargets[goldGun] = {sounds = {}}
                    end
                    if not trackedTargets[goldGun].sounds then
                        trackedTargets[goldGun].sounds = {}
                    end
                    
                    if not trackedTargets[goldGun].sounds["sound_inspect"] then
                        trackedTargets[goldGun].sounds["sound_inspect"] = {
                            originalSoundId = descendant.SoundId,
                            originalSound = descendant:Clone()
                        }
                    end
                    
                    descendant.SoundId = newSoundId
                    descendant.Volume = 0.6
                    descendant.MaxDistance = 80
                    descendant.EmitterSize = 4
                    
                    processedSounds = processedSounds + 1
                end
            end
        end
    end
    
    return processedSounds > 0
end

local function restoreGoldGunSounds(goldGun)
    local data = trackedTargets[goldGun]
    if not data or not data.sounds then return end
    
    for soundName, soundData in pairs(data.sounds) do
        if soundData.originalSound and soundData.parent and soundData.name then
            local existingSound = soundData.parent:FindFirstChild(soundData.name)
            if not existingSound then
                local newSound = soundData.originalSound:Clone()
                newSound.Parent = soundData.parent
            end
        end
        
        if soundData.originalSoundId then
            local targetSound = nil
            
            for _, descendant in ipairs(goldGun:GetDescendants()) do
                if descendant:IsA("Sound") and descendant.Name:lower() == soundName then
                    targetSound = descendant
                    break
                end
            end
            
            if targetSound and soundData.originalSound then
                targetSound.SoundId = soundData.originalSoundId
                targetSound.Volume = soundData.originalSound.Volume
                targetSound.MaxDistance = soundData.originalSound.MaxDistance
                targetSound.EmitterSize = soundData.originalSound.EmitterSize
                targetSound.RollOffMode = soundData.originalSound.RollOffMode
            end
        end
    end
    
    data.sounds = {}
end

local function disableModelCollision(model)
    for _, part in ipairs(model:GetDescendants()) do
        if part:IsA("BasePart") or part:IsA("MeshPart") then
            part.CanCollide = false
            part.CanTouch = false
            part.CanQuery = false
        end
    end
end

local function hideGoldGunParts(goldGun)
    if not goldGun or not goldGun.Parent then return end
    
    local function hideRecursive(obj)
        if obj:IsA("MeshPart") or obj:IsA("BasePart") then
            if not trackedTargets[goldGun] then
                trackedTargets[goldGun] = {originalParts = {}}
            end
            if not trackedTargets[goldGun].originalParts then
                trackedTargets[goldGun].originalParts = {}
            end
            trackedTargets[goldGun].originalParts[obj] = {transparency = obj.Transparency}
            obj.Transparency = 1
        end
        
        if obj:IsA("ParticleEmitter") or obj:IsA("Beam") or obj:IsA("Trail") then
            if not trackedTargets[goldGun] then
                trackedTargets[goldGun] = {originalParts = {}}
            end
            if not trackedTargets[goldGun].originalParts then
                trackedTargets[goldGun].originalParts = {}
            end
            trackedTargets[goldGun].originalParts[obj] = {enabled = obj.Enabled}
            obj.Enabled = false
        end
        
        if obj:IsA("Texture") or obj:IsA("Decal") or obj:IsA("SurfaceAppearance") then
            if not trackedTargets[goldGun] then
                trackedTargets[goldGun] = {originalParts = {}}
            end
            if not trackedTargets[goldGun].originalParts then
                trackedTargets[goldGun].originalParts = {}
            end
            trackedTargets[goldGun].originalParts[obj] = {transparency = obj.Transparency}
            obj.Transparency = 1
        end
        
        for _, child in ipairs(obj:GetChildren()) do
            hideRecursive(child)
        end
    end
    
    hideRecursive(goldGun)
end

local function restoreGoldGun(goldGun)
    local data = trackedTargets[goldGun]
    if not data then return end
    
    if data.originalParts then
        for part, partData in pairs(data.originalParts) do
            if part and part.Parent then
                if (part:IsA("MeshPart") or part:IsA("BasePart")) and partData.transparency then
                    part.Transparency = partData.transparency
                elseif (part:IsA("ParticleEmitter") or part:IsA("Beam") or part:IsA("Trail")) and partData.enabled ~= nil then
                    part.Enabled = partData.enabled
                elseif (part:IsA("Texture") or part:IsA("Decal") or part:IsA("SurfaceAppearance")) and partData.transparency then
                    part.Transparency = partData.transparency
                end
            end
        end
    end
    
    restoreGoldGunSounds(goldGun)
end

local function getItemConfig(itemName)
    local nameLower = itemName:lower()
    return REPLACEMENT_CONFIG[nameLower]
end

local function getTargetCFrame(target)
    if target:IsA("BasePart") or target:IsA("MeshPart") then
        return target.CFrame
    elseif target:IsA("Tool") and target:FindFirstChild("Handle") then
        return target.Handle.CFrame
    elseif target:IsA("Model") then
        if target.PrimaryPart then
            return target:GetPivot()
        elseif target:FindFirstChildWhichIsA("BasePart") then
            return target:FindFirstChildWhichIsA("BasePart").CFrame
        end
    end
    return nil
end

local function createFollowEffect(target, assetId)
    local effectModel = loadAssetLocally(assetId)
    if not effectModel then 
        return nil 
    end
    
    effectModel.Name = "GoldGun_Follower"
    effectModel.Parent = workspace
    disableModelCollision(effectModel)
    
    if not effectModel.PrimaryPart then
        if effectModel:FindFirstChildWhichIsA("BasePart") then
            effectModel.PrimaryPart = effectModel:FindFirstChildWhichIsA("BasePart")
        else
            effectModel:Destroy()
            return nil
        end
    end
    
    local targetCFrame = getTargetCFrame(target)
    if targetCFrame then
        local rotationCFrame = targetCFrame * CFrame.Angles(math.rad(180), math.rad(90), 0)
        local offsetCFrame = rotationCFrame + rotationCFrame.UpVector * 0.2
        effectModel:PivotTo(offsetCFrame)
    end
    
    return effectModel
end

local function updateEffectPosition(data, target)
    if not data.effect or not data.effect.Parent or not target or not target.Parent then
        return false
    end
    
    local targetCFrame = getTargetCFrame(target)
    if not targetCFrame then
        return false
    end
    
    local rotationCFrame = targetCFrame * CFrame.Angles(math.rad(-90), math.rad(180), 0)
    local offsetCFrame = rotationCFrame + rotationCFrame.UpVector * 0.2
    data.effect:PivotTo(offsetCFrame)
    return true
end

local function startTrackingTarget(target, config)
    if trackedTargets[target] then 
        return trackedTargets[target] 
    end
    
    local effectModel = createFollowEffect(target, config.assetId)
    if not effectModel then 
        return nil 
    end
    
    hideGoldGunParts(target)
    processGoldGunSounds(target)
    
    trackedTargets[target] = {
        effect = effectModel, 
        target = target,
        config = config
    }
    
    local data = trackedTargets[target]
    
    data.connection = RunService.RenderStepped:Connect(function()
        if not updateEffectPosition(data, target) then
            if data.connection then
                data.connection:Disconnect()
            end
            if data.effect and data.effect.Parent then
                data.effect:Destroy()
            end
            restoreGoldGunSounds(target)
            trackedTargets[target] = nil
        end
    end)
    
    return trackedTargets[target]
end

local function stopTrackingTarget(target, restoreVisibility)
    local data = trackedTargets[target]
    if not data then return end
    
    if restoreVisibility then
        restoreGoldGun(target)
    end
    
    if data.effect and data.effect.Parent then
        data.effect:Destroy()
    end
    
    if data.connection then
        data.connection:Disconnect()
    end
    
    restoreGoldGunSounds(target)
    trackedTargets[target] = nil
end

local function cleanupDestroyedTargets()
    for target, data in pairs(trackedTargets) do
        if not target or not target.Parent then
            if data.effect and data.effect.Parent then
                data.effect:Destroy()
            end
            if data.connection then
                data.connection:Disconnect()
            end
            restoreGoldGunSounds(target)
            trackedTargets[target] = nil
        end
    end
end

local function findMiscHandle()
    local handle = nil
    
    local miscFolder = workspace:FindFirstChild("Misc")
    if miscFolder then
        handle = miscFolder:FindFirstChild("Handle")
        if handle and handle:IsA("MeshPart") then
            return handle
        end
    end
    
    return nil
end

local function hideMiscHandle(handle)
    if not handle or not handle.Parent then return false end
    
    if miscHandles[handle] and miscHandles[handle].originalHandleData then
        return false
    end
    
    if not miscHandles[handle] then
        miscHandles[handle] = {}
    end
    
    miscHandles[handle].originalHandleData = {
        transparency = handle.Transparency,
        canCollide = handle.CanCollide,
        canTouch = handle.CanTouch,
        canQuery = handle.CanQuery
    }
    
    handle.Transparency = 1
    handle.CanCollide = false
    handle.CanTouch = false
    handle.CanQuery = false
    
    return true
end

local function restoreMiscHandle(handle)
    local data = miscHandles[handle]
    if not data or not data.originalHandleData then return end
    
    if handle and handle.Parent then
        handle.Transparency = data.originalHandleData.transparency
        handle.CanCollide = data.originalHandleData.canCollide
        handle.CanTouch = data.originalHandleData.canTouch
        handle.CanQuery = data.originalHandleData.canQuery
    end
    
    data.originalHandleData = nil
end
local function processMiscHandle()
    local handle = findMiscHandle()
    if not handle or miscHandles[handle] then return end
    
    local config = getItemConfig("goldgun")
    if not config then return end
    
    hideMiscHandle(handle)
    
    local effectModel = loadAssetLocally(config.assetId)
    if not effectModel then return end
    
    effectModel.Name = "GoldGun_Misc_Follower"
    effectModel.Parent = workspace
    disableModelCollision(effectModel)
    
    if not effectModel.PrimaryPart then
        if effectModel:FindFirstChildWhichIsA("BasePart") then
            effectModel.PrimaryPart = effectModel:FindFirstChildWhichIsA("BasePart")
        else
            effectModel:Destroy()
            return
        end
    end
    
    local rotationCFrame = handle.CFrame * CFrame.Angles(math.rad(180), math.rad(90), 0)
    local offsetCFrame = rotationCFrame + rotationCFrame.UpVector * -0.2
    effectModel:PivotTo(offsetCFrame)
    
    miscHandles[handle] = {
        effect = effectModel,
        handle = handle
    }
    
    local data = miscHandles[handle]
    
    data.connection = RunService.RenderStepped:Connect(function()
        if not data.effect or not data.effect.Parent or not handle or not handle.Parent then
            if data.connection then
                data.connection:Disconnect()
            end
            if data.effect and data.effect.Parent then
                data.effect:Destroy()
            end
            restoreMiscHandle(handle)
            miscHandles[handle] = nil
        else
            local rotationCFrame = handle.CFrame * CFrame.Angles(math.rad(180), math.rad(90), 0)
            local offsetCFrame = rotationCFrame + rotationCFrame.UpVector * -0.2
            data.effect:PivotTo(offsetCFrame)
        end
    end)
end

local function stopMiscHandle(handle)
    local data = miscHandles[handle]
    if not data then return end
    
    if data.effect and data.effect.Parent then
        data.effect:Destroy()
    end
    
    if data.connection then
        data.connection:Disconnect()
    end
    
    restoreMiscHandle(handle)
    
    miscHandles[handle] = nil
end

local function cleanupMiscHandles()
    for handle, data in pairs(miscHandles) do
        if not handle or not handle.Parent then
            if data.effect and data.effect.Parent then
                data.effect:Destroy()
            end
            if data.connection then
                data.connection:Disconnect()
            end
            restoreMiscHandle(handle)
            miscHandles[handle] = nil
        end
    end
end

local function findAllGoldGuns()
    local targets = {}
    
    local function findGoldGunsRecursive(parent)
        for _, child in ipairs(parent:GetChildren()) do
            if child.Name:lower() == "goldgun" then
                local config = getItemConfig(child.Name)
                if config then
                    table.insert(targets, {target = child, config = config})
                end
            end
            findGoldGunsRecursive(child)
        end
    end
    
    findGoldGunsRecursive(workspace)
    return targets
end
local function monitorAllGoldGuns()
    while true do
        for _, targetData in ipairs(findAllGoldGuns()) do
            processGoldGunSounds(targetData.target)
        end
        
        for _, player in ipairs(Players:GetPlayers()) do
            local backpack = player:FindFirstChild("Backpack")
            if backpack then
                local goldGun = backpack:FindFirstChild("GoldGun")
                if goldGun then
                    processGoldGunSounds(goldGun)
                end
                
                if not backpack.ChildAddedConnection then
                    backpack.ChildAddedConnection = backpack.ChildAdded:Connect(function(child)
                        if child.Name == "GoldGun" then
                            task.wait(0.1)
                            processGoldGunSounds(child)
                        end
                    end)
                end
            end
            
            local character = player.Character
            if character then
                local goldGun = character:FindFirstChild("GoldGun")
                if goldGun then
                    processGoldGunSounds(goldGun)
                end
            end
        end
        
        task.wait(1)
    end
end

local function startDetection()
    local lastCheckTime = 0
    
    while true do
        local currentTime = tick()
        
        if currentTime - lastCheckTime >= CHECK_INTERVAL then
            lastCheckTime = currentTime
            
            cleanupDestroyedTargets()
            cleanupMiscHandles()
            
            local allGoldGuns = findAllGoldGuns()
            
            for _, targetData in ipairs(allGoldGuns) do
                if not trackedTargets[targetData.target] then
                    startTrackingTarget(targetData.target, targetData.config)
                end
            end
            
            processMiscHandle()
            
            for target, data in pairs(trackedTargets) do
                if target and target.Parent then
                    local isValid = false
                    local parent = target.Parent
                    
                    while parent do
                        if parent == workspace then
                            isValid = true
                            break
                        end
                        parent = parent.Parent
                    end
                    
                    if not isValid then
                        stopTrackingTarget(target, true)
                    end
                end
            end
        end
        
        RunService.Heartbeat:Wait()
    end
end

local function initialize()
    task.spawn(startDetection)
    task.spawn(monitorAllGoldGuns)
end

local function cleanup()
    for target, _ in pairs(trackedTargets) do
        stopTrackingTarget(target, true)
    end
    
    for handle, _ in pairs(miscHandles) do
        stopMiscHandle(handle)
    end
    
    trackedTargets = {}
    miscHandles = {}
end
local function setupPlayerEvents()
    local player = Players.LocalPlayer
    if player then
        player:GetPropertyChangedSignal("Character"):Connect(function()
            cleanupDestroyedTargets()
        end)
        player.AncestryChanged:Connect(function(_, parent)
            if not parent then
                cleanup()
            end
        end)
    end
end
initialize()
setupPlayerEvents()
end

function entityBehaviors.guidingjug()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local REPLACEMENT_CONFIG = {
    ["starjug"] = {assetId = 90395549970314}
}
local CHECK_INTERVAL = 0.3
local trackedTargets = {}

local function loadAssetLocally(assetId)
    local success, result = pcall(function()
        return game:GetObjects("rbxassetid://" .. assetId)[1]
    end)
    if success and result then
        return result:Clone()
    end
    return nil
end

local function disableModelCollision(model)
    for _, part in ipairs(model:GetDescendants()) do
        if part:IsA("BasePart") or part:IsA("MeshPart") then
            part.CanCollide = false
            part.CanTouch = false
            part.CanQuery = false
        end
    end
end

local function hideStarJugParts(starJug)
    if not starJug or not starJug.Parent then return end
    
    local function hideRecursive(obj)
        if obj:IsA("MeshPart") or obj:IsA("BasePart") then
            if not trackedTargets[starJug] then
                trackedTargets[starJug] = {originalParts = {}}
            end
            trackedTargets[starJug].originalParts[obj] = {transparency = obj.Transparency}
            obj.Transparency = 1
        end
        
        if obj:IsA("ParticleEmitter") or obj:IsA("Beam") or obj:IsA("Trail") then
            if not trackedTargets[starJug] then
                trackedTargets[starJug] = {originalParts = {}}
            end
            trackedTargets[starJug].originalParts[obj] = {enabled = obj.Enabled}
            obj.Enabled = false
        end
        
        if obj:IsA("Texture") or obj:IsA("Decal") or obj:IsA("SurfaceAppearance") then
            if not trackedTargets[starJug] then
                trackedTargets[starJug] = {originalParts = {}}
            end
            trackedTargets[starJug].originalParts[obj] = {transparency = obj.Transparency}
            obj.Transparency = 1
        end
        
        for _, child in ipairs(obj:GetChildren()) do
            hideRecursive(child)
        end
    end
    
    hideRecursive(starJug)
end

local function restoreStarJug(starJug)
    local data = trackedTargets[starJug]
    if not data or not data.originalParts then return end
    
    for part, partData in pairs(data.originalParts) do
        if part and part.Parent then
            if (part:IsA("MeshPart") or part:IsA("BasePart")) and partData.transparency then
                part.Transparency = partData.transparency
            elseif (part:IsA("ParticleEmitter") or part:IsA("Beam") or part:IsA("Trail")) and partData.enabled ~= nil then
                part.Enabled = partData.enabled
            elseif (part:IsA("Texture") or part:IsA("Decal") or part:IsA("SurfaceAppearance")) and partData.transparency then
                part.Transparency = partData.transparency
            end
        end
    end
end

local function getItemConfig(itemName)
    local nameLower = itemName:lower()
    return REPLACEMENT_CONFIG[nameLower]
end

local function getTargetCFrame(target)
    if target:IsA("BasePart") or target:IsA("MeshPart") then
        return target.CFrame
    elseif target:IsA("Tool") and target:FindFirstChild("Handle") then
        return target.Handle.CFrame
    elseif target:IsA("Model") then
        if target.PrimaryPart then
            return target:GetPivot()
        elseif target:FindFirstChildWhichIsA("BasePart") then
            return target:FindFirstChildWhichIsA("BasePart").CFrame
        end
    end
    return nil
end

local function createFollowEffect(target, assetId)
    local effectModel = loadAssetLocally(assetId)
    if not effectModel then 
        return nil 
    end
    
    effectModel.Name = "StarJug_Follower"
    effectModel.Parent = workspace
    disableModelCollision(effectModel)
    
    if not effectModel.PrimaryPart then
        if effectModel:FindFirstChildWhichIsA("BasePart") then
            effectModel.PrimaryPart = effectModel:FindFirstChildWhichIsA("BasePart")
        else
            effectModel:Destroy()
            return nil
        end
    end
    
    local targetCFrame = getTargetCFrame(target)
    if targetCFrame then
        effectModel:PivotTo(targetCFrame)
    end
    
    return effectModel
end

local function updateEffectPosition(data, target)
    if not data.effect or not data.effect.Parent or not target or not target.Parent then
        return false
    end
    
    local targetCFrame = getTargetCFrame(target)
    if not targetCFrame then
        return false
    end
    
    data.effect:PivotTo(targetCFrame)
    return true
end

local function startTrackingTarget(target, config)
    if trackedTargets[target] then 
        return trackedTargets[target] 
    end
    
    local effectModel = createFollowEffect(target, config.assetId)
    if not effectModel then 
        return nil 
    end
    
    hideStarJugParts(target)
    
    trackedTargets[target] = {
        effect = effectModel, 
        target = target,
        config = config
    }
    
    local data = trackedTargets[target]
    
    data.connection = RunService.RenderStepped:Connect(function()
        if not updateEffectPosition(data, target) then
            if data.connection then
                data.connection:Disconnect()
            end
            if data.effect and data.effect.Parent then
                data.effect:Destroy()
            end
            trackedTargets[target] = nil
        end
    end)
    
    return trackedTargets[target]
end

local function stopTrackingTarget(target, restoreVisibility)
    local data = trackedTargets[target]
    if not data then return end
    
    if restoreVisibility then
        restoreStarJug(target)
    end
    
    if data.effect and data.effect.Parent then
        data.effect:Destroy()
    end
    
    if data.connection then
        data.connection:Disconnect()
    end
    
    trackedTargets[target] = nil
end

local function cleanupDestroyedTargets()
    for target, data in pairs(trackedTargets) do
        if not target or not target.Parent then
            if data.effect and data.effect.Parent then
                data.effect:Destroy()
            end
            if data.connection then
                data.connection:Disconnect()
            end
            trackedTargets[target] = nil
        end
    end
end

local function findAllStarJugs()
    local targets = {}
    
    local function findStarJugsRecursive(parent)
        for _, child in ipairs(parent:GetChildren()) do
            if child.Name:lower() == "starjug" then
                local config = getItemConfig(child.Name)
                if config then
                    table.insert(targets, {target = child, config = config})
                end
            end
            findStarJugsRecursive(child)
        end
    end
    
    findStarJugsRecursive(workspace)
    return targets
end

local function startDetection()
    local lastCheckTime = 0
    
    while true do
        local currentTime = tick()
        
        if currentTime - lastCheckTime >= CHECK_INTERVAL then
            lastCheckTime = currentTime
            
            cleanupDestroyedTargets()
            
            local allStarJugs = findAllStarJugs()
            
            for _, targetData in ipairs(allStarJugs) do
                if not trackedTargets[targetData.target] then
                    startTrackingTarget(targetData.target, targetData.config)
                end
            end
            
            for target, data in pairs(trackedTargets) do
                if target and target.Parent then
                    local isValid = false
                    local parent = target.Parent
                    
                    while parent do
                        if parent == workspace then
                            isValid = true
                            break
                        end
                        parent = parent.Parent
                    end
                    
                    if not isValid then
                        stopTrackingTarget(target, true)
                    end
                end
            end
        end
        
        RunService.Heartbeat:Wait()
    end
end

local function initialize()
    task.spawn(startDetection)
end

local function cleanup()
    for target, _ in pairs(trackedTargets) do
        stopTrackingTarget(target, true)
    end
    trackedTargets = {}
end

local function setupPlayerEvents()
    local player = Players.LocalPlayer
    if player then
        player:GetPropertyChangedSignal("Character"):Connect(function()
            cleanupDestroyedTargets()
        end)
        
        player.AncestryChanged:Connect(function(_, parent)
            if not parent then
                cleanup()
            end
        end)
    end
end
initialize()
setupPlayerEvents()
end

function entityBehaviors.A333NOHIDING()
require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("不躲藏!", true)
wait(0.5)
local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()
local entity = spawner.Create({Entity = {Name = "A-333",Asset = "93292275397844",HeightOffset = 0},
Lights = {Flicker = {Enabled = false,Duration = 10},Shatter = false,Repair = false},Earthquake = {Enabled = false},
Enabled = true,Range = 30,Values = {1, 50, 0.1, 1},Movement = {Speed = 1000,Delay = 0.5,Reversed = true},Rebounding = {
Enabled = false,Type = "ambush",Min = 4,Max = 4,Delay = math.random(10, 30) / 10},Damage = {Enabled = true,Range = 100,Amount = 0},
Crucifixion = {Enabled = true,Range = 100,Resist = false,Break = true}, Death = {Type = "Guiding",Hints = {"你死于A-333", "根据他说的执意来做", "需要你拥有极强的反应所以最好带上十字架..", "祝你好运!"},Cause = ""}})
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

function entityBehaviors.A333HIDING()
require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("躲藏!", true)
wait(0.5)
local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()
local entity = spawner.Create({Entity = {Name = "A-333",Asset = "93292275397844",HeightOffset = 0},
Lights = {Flicker = {Enabled = false,Duration = 10},Shatter = false,Repair = false},Earthquake = {Enabled = false},
Enabled = true,Range = 30,Values = {1, 50, 0.1, 1},Movement = {Speed = 1000,Delay = 0.5,Reversed = true},Rebounding = {
Enabled = false,Type = "ambush",Min = 4,Max = 4,Delay = math.random(10, 30) / 10},Damage = {Enabled = true,Range = 100,Amount = 150},
Crucifixion = {Enabled = true,Range = 100,Resist = false,Break = true}, Death = {Type = "Guiding",Hints = {"你死于A-333", "根据他说的执意来做", "需要你拥有极强的反应所以最好带上十字架..", "祝你好运!"},Cause = ""}})
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
function entityBehaviors.A333LODING()
require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("Loading...", true)
end

function entityBehaviors.gunjeffkq()
local sound = Instance.new("Sound")
sound.Name = "Subspace"
sound.SoundId = "rbxassetid://89344175304287"
sound.Volume = 4
sound.Parent = workspace

sound.Ended:Connect(function()
    sound:Destroy()
end)
sound:Play()
end

function entityBehaviors.JEFFGUN2()
local RunService = game:GetService("RunService")
local V1 = game:GetObjects("rbxassetid://134258088105212")[1]
V1.Parent = workspace
local V2 = workspace:WaitForChild("JeffTheKiller")

local xOffset = 0
local yOffset = 0
local zOffset = 0

if V1:IsA("Model") then
    local primary = V1:FindFirstChildWhichIsA("BasePart")
    if primary then
        V1.PrimaryPart = primary
    end
end

local function HS()
    if not V2 then return end
    
    local function HP(obj)
        if obj:IsA("BasePart") then
            obj.Transparency = 1
            obj.CanCollide = false
        end
        
        for _, child in ipairs(obj:GetChildren()) do
            if child:IsA("Decal") or child:IsA("Texture") or child:IsA("SurfaceAppearance") then
                child.Transparency = 1
            elseif child:IsA("ParticleEmitter") or child:IsA("Beam") or child:IsA("Trail") then
                child.Enabled = false
            end
            
            HP(child)
        end
    end
    
    local p1 = V2:FindFirstChild("Knife")
    local p2 = V2:FindFirstChild("Head")
    local p3 = V2:FindFirstChild("BoyAnimeHair_Black")
    if p1 then HP(p1) end
    if p2 then HP(p2) end
    if p3 then
        local h = p3:Clone()
        h.Parent = V2
        HP(h)
    end
    
    local leftArm = V2:FindFirstChild("Left Arm")
    local rightArm = V2:FindFirstChild("Right Arm")
    if leftArm then HP(leftArm) end
    if rightArm then HP(rightArm) end
end

HS()

local connection
connection = V2.AncestryChanged:Connect(function(_, parent)
    if not parent then
        V1:Destroy()
        if connection then
            connection:Disconnect()
        end
    end
end)

RunService.Heartbeat:Connect(function()
    if not V2 or not V2.Parent then 
        V1:Destroy()
        if connection then
            connection:Disconnect()
        end
        return 
    end

    local function findRootPart(model)
        local root = model:FindFirstChild("HumanoidRootPart") or model:FindFirstChild("Torso")
        if root then 
            return root 
        end
        
        for _, child in pairs(model:GetDescendants()) do
            if (child.Name == "HumanoidRootPart" or child.Name == "Torso") and child:IsA("BasePart") then
                return child
            end
        end
        return nil
    end
    
    local root = findRootPart(V2)
    if not root then 
        V1:Destroy()
        if connection then
            connection:Disconnect()
        end
        return
    end
    if V1:IsA("Model") then
        if not V1.PrimaryPart then
            local part = V1:FindFirstChildWhichIsA("BasePart")
            if part then
                V1.PrimaryPart = part
            end
        end
        
        if V1.PrimaryPart then
            local newCFrame = CFrame.new(
                root.CFrame.Position.X + xOffset,
                root.CFrame.Position.Y + yOffset,
                root.CFrame.Position.Z + zOffset
            ) * root.CFrame.Rotation
            V1:SetPrimaryPartCFrame(newCFrame)
        end
    elseif V1:IsA("BasePart") then
        local newCFrame = CFrame.new(
            root.CFrame.Position.X + xOffset,
            root.CFrame.Position.Y + yOffset,
            root.CFrame.Position.Z + zOffset
        ) * root.CFrame.Rotation
        V1.CFrame = newCFrame
    end
end)
end

function entityBehaviors.JEFFGUN3()
local RunService = game:GetService("RunService")
local V1 = game:GetObjects("rbxassetid://128269554312849")[1]
V1.Parent = workspace
local V2 = workspace:WaitForChild("JeffTheKiller")

local xOffset = 0
local yOffset = 0
local zOffset = 0

if V1:IsA("Model") then
    local primary = V1:FindFirstChildWhichIsA("BasePart")
    if primary then
        V1.PrimaryPart = primary
    end
end

local function HS()
    if not V2 then return end
    
    local function HP(obj)
        if obj:IsA("BasePart") then
            obj.Transparency = 1
            obj.CanCollide = false
        end
        
        for _, child in ipairs(obj:GetChildren()) do
            if child:IsA("Decal") or child:IsA("Texture") or child:IsA("SurfaceAppearance") then
                child.Transparency = 1
            elseif child:IsA("ParticleEmitter") or child:IsA("Beam") or child:IsA("Trail") then
                child.Enabled = false
            end
            
            HP(child)
        end
    end
    
    local p1 = V2:FindFirstChild("Knife")
    local p2 = V2:FindFirstChild("Head")
    local p3 = V2:FindFirstChild("BoyAnimeHair_Black")
    if p1 then HP(p1) end
    if p2 then HP(p2) end
    if p3 then
        local h = p3:Clone()
        h.Parent = V2
        HP(h)
    end
    
    local leftArm = V2:FindFirstChild("Left Arm")
    local rightArm = V2:FindFirstChild("Right Arm")
    if leftArm then HP(leftArm) end
    if rightArm then HP(rightArm) end
end

HS()

local connection
connection = V2.AncestryChanged:Connect(function(_, parent)
    if not parent then
        V1:Destroy()
        if connection then
            connection:Disconnect()
        end
    end
end)

RunService.Heartbeat:Connect(function()
    if not V2 or not V2.Parent then 
        V1:Destroy()
        if connection then
            connection:Disconnect()
        end
        return 
    end

    local function findRootPart(model)
        local root = model:FindFirstChild("HumanoidRootPart") or model:FindFirstChild("Torso")
        if root then 
            return root 
        end
        
        for _, child in pairs(model:GetDescendants()) do
            if (child.Name == "HumanoidRootPart" or child.Name == "Torso") and child:IsA("BasePart") then
                return child
            end
        end
        return nil
    end
    
    local root = findRootPart(V2)
    if not root then 
        V1:Destroy()
        if connection then
            connection:Disconnect()
        end
        return
    end
    if V1:IsA("Model") then
        if not V1.PrimaryPart then
            local part = V1:FindFirstChildWhichIsA("BasePart")
            if part then
                V1.PrimaryPart = part
            end
        end
        
        if V1.PrimaryPart then
            local newCFrame = CFrame.new(
                root.CFrame.Position.X + xOffset,
                root.CFrame.Position.Y + yOffset,
                root.CFrame.Position.Z + zOffset
            ) * root.CFrame.Rotation
            V1:SetPrimaryPartCFrame(newCFrame)
        end
    elseif V1:IsA("BasePart") then
        local newCFrame = CFrame.new(
            root.CFrame.Position.X + xOffset,
            root.CFrame.Position.Y + yOffset,
            root.CFrame.Position.Z + zOffset
        ) * root.CFrame.Rotation
        V1.CFrame = newCFrame
    end
end)
end


function entityBehaviors.A333ONE()
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local audioUrl = "https://github.com/Zero0Star/RipperNewSound/blob/master/A-333Music2.mp3?raw=true"
local audioFileName = "A333_Music"
local function downloadAudio()
    pcall(function()
        local audioData = game:HttpGet(audioUrl)
        writefile(audioFileName .. ".mp3", audioData)

    end)
end
downloadAudio()
ReplicatedStorage.GameData.LatestRoom.Changed:Wait()

function GetRoom()
    local gruh = workspace.CurrentRooms
    return gruh:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value)
end

local s
local success, err = pcall(function()
    s = game:GetObjects("rbxassetid://93292275397844")[1]
    s.Parent = workspace
    local entity = s:FindFirstChildWhichIsA("BasePart")
    entity.CFrame = GetRoom():WaitForChild("RoomEntrance").CFrame * CFrame.new(0, 2, -15)
    if entity:FindFirstChild("Part") then
        entity.Part.CFrame = entity.CFrame
    end
end)

if success then

    task.spawn(function()
        wait(10)

        pcall(function()
            local customAsset = (getcustomasset or getsynasset)(audioFileName .. ".mp3")
            local sound = Instance.new("Sound")
            sound.Name = "A333_Music"
            sound.SoundId = customAsset
            sound.Volume = 1
            sound.Parent = Workspace
            sound:Play()

            repeat
                wait(1)
            until not sound or not sound.Parent or (sound.TimeLength > 0 and sound.TimePosition >= sound.TimeLength)
            
            if sound and sound.Parent then
                sound:Destroy()

            end

            pcall(function()
                delfile(audioFileName .. ".mp3")
            end)
        end)
    end)
    
    task.spawn(function()
        wait(2)
        pcall(function()
            require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("按照他说的做!", true)
        end)
    end)
    task.spawn(function()
        wait(4)
        if Workspace:FindFirstChild("A-333") then
            Workspace["A-333"]:Destroy()
        end
    end)
end
end

function entityBehaviors.SCURE()
local modelID = 76379083600613
local targetName = "Repentance_Skinned"
local loadedVFX = nil
local targetModel = nil
local connections = {}
local isFollowing = false

local RunService = game:GetService("RunService")

local function loadVFXPart()
    if loadedVFX and loadedVFX.Parent then
        loadedVFX:Destroy()
        loadedVFX = nil
    end
    
    local success, result = pcall(function()
        return game:GetObjects("rbxassetid://" .. tostring(modelID))
    end)
    
    if not success or not result or not result[1] then
        return nil
    end
    
    local model = result[1]
    
    local vfxPart
    for _, child in ipairs(model:GetDescendants()) do
        if child:IsA("BasePart") and child.Name:lower() == "vfx" then
            vfxPart = child:Clone()
            break
        end
    end
    
    if not vfxPart then
        return nil
    end
    
    vfxPart.Anchored = true
    vfxPart.CanCollide = false
    vfxPart.Transparency = 1
    vfxPart.CanTouch = false
    vfxPart.CanQuery = false
    vfxPart.Massless = true
    vfxPart.Parent = workspace
    vfxPart.Name = "Following_VFX"
    
    return vfxPart
end

local function fadeOutVFX()
    if not loadedVFX or not loadedVFX.Parent then return end
    
    local fadeDuration = 2
    local fadeStart = tick()
    
    while loadedVFX and loadedVFX.Parent and tick() - fadeStart < fadeDuration do
        local progress = (tick() - fadeStart) / fadeDuration
        local transparency = progress
        
        for _, descendant in ipairs(loadedVFX:GetDescendants()) do
            if descendant:IsA("BasePart") then
                descendant.Transparency = transparency
            elseif descendant:IsA("Beam") then
                descendant.Transparency = NumberSequence.new(transparency)
            elseif descendant:IsA("ParticleEmitter") then
                descendant.Rate = descendant.Rate * (1 - progress)
            end
        end
        
        RunService.Heartbeat:Wait()
    end
    
    if loadedVFX and loadedVFX.Parent then
        loadedVFX:Destroy()
        loadedVFX = nil
    end
end

local function followTarget()
    if not targetModel or not targetModel.Parent or not loadedVFX or not loadedVFX.Parent then
        isFollowing = false
        return
    end
    
    isFollowing = true
    loadedVFX.Anchored = true
    
    local loadTime = tick()
    local fadeStarted = false
    
    while isFollowing and targetModel and targetModel.Parent and loadedVFX and loadedVFX.Parent do
        RunService.Heartbeat:Wait()
        
        if loadedVFX.Anchored == false then
            loadedVFX.Anchored = true
        end
        
        if tick() - loadTime >= 8 and not fadeStarted then
            fadeStarted = true
            coroutine.wrap(fadeOutVFX)()
        end
        
        if fadeStarted then
            isFollowing = false
            break
        end
        
        local targetPos
        if targetModel:IsA("Model") then
            local primary = targetModel.PrimaryPart
            if primary then
                targetPos = primary.CFrame
            else
                for _, child in ipairs(targetModel:GetDescendants()) do
                    if child:IsA("BasePart") then
                        targetPos = child.CFrame
                        break
                    end
                end
            end
        elseif targetModel:IsA("BasePart") then
            targetPos = targetModel.CFrame
        end
        
        if targetPos then
            loadedVFX.CFrame = targetPos + Vector3.new(0, 4, 0)
        end
    end
end

local function start()
    isFollowing = false
    for _, conn in pairs(connections) do
        pcall(function() conn:Disconnect() end)
    end
    connections = {}
    
    if loadedVFX and loadedVFX.Parent then
        loadedVFX:Destroy()
        loadedVFX = nil
    end
    
    targetModel = workspace:FindFirstChild(targetName)
    if not targetModel or not targetModel:IsA("Model") then
        return
    end
    
    loadedVFX = loadVFXPart()
    if not loadedVFX then
        return
    end
    
    local conn1 = targetModel.AncestryChanged:Connect(function(_, parent)
        if not parent then
            isFollowing = false
            if loadedVFX and loadedVFX.Parent then
                loadedVFX:Destroy()
                loadedVFX = nil
            end
        end
    end)
    
    local conn2 = loadedVFX.AncestryChanged:Connect(function(_, parent)
        if not parent then
            isFollowing = false
            loadedVFX = nil
        end
    end)
    
    table.insert(connections, conn1)
    table.insert(connections, conn2)
    
    coroutine.wrap(followTarget)()
end

local function init()
    pcall(start)
    
    workspace.ChildAdded:Connect(function(child)
        if child.Name == targetName and child:IsA("Model") then
            wait(0.5)
            pcall(start)
        end
    end)
end
wait(2)
init()
coroutine.wrap(function()
    while true do
        wait(5)
        if loadedVFX and loadedVFX.Parent and loadedVFX.Anchored == false then
            loadedVFX.Anchored = true
        end
    end
end)()
end

function entityBehaviors.MLTHREE()
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local audioUrl = "https://github.com/Zero0Star/RipperNewSound/raw/master/8d341ae5854f0d734fced2ba0605c0a3.mp3?raw=true"
local audioFileName = "custom_audio"

local function loadAndPlayAudio()
    pcall(function()
        local audioData = game:HttpGet(audioUrl)
        writefile(audioFileName .. ".mp3", audioData)
        local customAsset = (getcustomasset or getsynasset)(audioFileName .. ".mp3")
        
        local sound = Instance.new("Sound")
        sound.Name = "ML"
        sound.SoundId = customAsset
        sound.Looped = true
        sound.Volume = 0
        sound.Parent = Workspace
        sound:Play()
    end)
end

loadAndPlayAudio()

function GetRoom()
    local gruh = workspace.CurrentRooms
    return gruh:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value)
end

local plr = game.Players.LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()

function LoadCustomInstance(source, parent, timeout)
    timeout = timeout or 10
    local startTime = tick()
    local model

    local success, result = pcall(function()
        return game:GetObjects("rbxassetid://" .. tostring(source))[1]
    end)
    
    if success and result then
        model = result

    else

        return nil
    end

    if model then
        for _, obj in ipairs(model:GetDescendants()) do
            if obj:IsA("Script") or obj:IsA("LocalScript") then
                obj:Destroy()
            end
        end
        model.Parent = parent or Workspace
    end
    
    return model
end

local s = LoadCustomInstance(121103157413966, Workspace)
if not s then

    return
end

local room = GetRoom()
if room and room:FindFirstChild("RoomEntrance") then
    local entity = s:FindFirstChildWhichIsA("BasePart")
    if entity then
        entity.CFrame = room.RoomEntrance.CFrame * CFrame.new(0, 5, -15)
        if entity:FindFirstChild("Part") then
            entity.Part.CFrame = entity.CFrame
        end

    end
end

pcall(function()
    local roomValue = game.ReplicatedStorage.GameData.LatestRoom.Value
    local currentRoom = workspace.CurrentRooms:FindFirstChild(tostring(roomValue))
    
    if currentRoom then

        for _, obj in ipairs(currentRoom:GetDescendants()) do
            if obj.Name == "PlaySound" and obj:IsA("Sound") then
                obj:Stop()
            end
        end

        local fireplace = currentRoom:FindFirstChild("Assets")
        if fireplace and fireplace:FindFirstChild("Fireplace") then
            local logs = fireplace.Fireplace.Fireplace_Logs
            if logs then
                pcall(function() logs.ToolEventPrompt.Enabled = false end)
                pcall(function() logs.Log.SparkParticles.Enabled = false end)
                pcall(function() logs.Log.SmokeParticles.Enabled = false end)
                pcall(function() logs.Log.FireParticles.Enabled = false end)
                pcall(function() logs.Log.FireLight.Enabled = false end)
            end
        end
    end
end)

local MISHX = Workspace:FindFirstChild("MISHX")
if MISHX then

    local player = Players.LocalPlayer
    local rootPart = MISHX:FindFirstChild("HumanoidRootPart") or MISHX:FindFirstChildWhichIsA("BasePart")
    
    if rootPart then
        local smoothness = 0.1
        RunService.RenderStepped:Connect(function()
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local targetPos = player.Character.HumanoidRootPart.Position
                local currentPos = rootPart.Position
                local lookVector = Vector3.new(targetPos.X - currentPos.X, 0, targetPos.Z - currentPos.Z)
                
                if lookVector.Magnitude > 0 then
                    local targetCFrame = CFrame.new(currentPos, currentPos + lookVector)
                    local currentCFrame = rootPart.CFrame
                    local newCFrame = currentCFrame:Lerp(targetCFrame, smoothness)
                    rootPart.CFrame = newCFrame
                end
            end
        end)

    end

    local humanoid = MISHX:FindFirstChildOfClass("Humanoid")
    if not humanoid and MISHX:IsA("Model") then
        humanoid = Instance.new("Humanoid")
        humanoid.Parent = MISHX
    end
    
    if humanoid then
        local animator = humanoid:FindFirstChildOfClass("Animator")
        if not animator then
            animator = Instance.new("Animator")
            animator.Parent = humanoid
        end
        
        local animationId = "rbxassetid://111408250277560"
        pcall(function()
            local animation = Instance.new("Animation")
            animation.AnimationId = animationId
            local animationTrack = humanoid:LoadAnimation(animation)
            if animationTrack then
                animationTrack.Looped = true
                animationTrack:Play()
            end
        end)
    end
end

pcall(function()
    local mainGame = require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game)
    mainGame.caption(".......", true)
    wait(10)
    mainGame.caption("I know I am not real", true)
    wait(10)
    mainGame.caption("But you are real", true)
    wait(10)
    mainGame.caption("But you are destined not to in this game.", true)
end)
wait(6)
if Workspace:FindFirstChild("MISHX") then
    Workspace["MISHX"]:Destroy()

end
local sound = Workspace:FindFirstChild("ML")
if sound and sound:IsA("Sound") then

    repeat
        wait(1)
    until not sound or not sound.Parent or sound.TimeLength > 0 and sound.TimePosition >= sound.TimeLength

    if sound and sound.Parent then
        sound:Destroy()
    end
else
end
end

function entityBehaviors.JEFFTWO()
local RunService = game:GetService("RunService")
local V1 = game:GetObjects("rbxassetid://132473459444776")[1]
V1.Parent = workspace
local V2 = workspace:WaitForChild("JeffTheKiller")
local function HS()
    if not V2 then return end
    
    local function HP(obj)
        if obj:IsA("BasePart") then
            obj.Transparency = 1
            obj.CanCollide = false
        end
        
        for _, child in ipairs(obj:GetChildren()) do
            if child:IsA("Decal") or child:IsA("Texture") or child:IsA("SurfaceAppearance") then
                child.Transparency = 1
            elseif child:IsA("ParticleEmitter") or child:IsA("Beam") or child:IsA("Trail") then
                child.Enabled = false
            end
            
            HP(child)
        end
    end
    local p1 = V2:FindFirstChild("Knife")
    local p2 = V2:FindFirstChild("Head")
    local p3 = V2:FindFirstChild("BoyAnimeHair_Black")
    if p1 then HP(p1) end
    if p2 then HP(p2) end
    if p3 then
        local handle = p3:FindFirstChild("Handle")
        if handle then HP(handle) end
    end
end
HS()
local connection
connection = V2.AncestryChanged:Connect(function(_, parent)
    if not parent then
        V1:Destroy()
        if connection then
            connection:Disconnect()
        end
    end
end)

RunService.Heartbeat:Connect(function()
    if not V2 or not V2.Parent then 
        V1:Destroy()
        if connection then
            connection:Disconnect()
        end
        return 
    end
    local root = V2:FindFirstChild("HumanoidRootPart") or V2:FindFirstChild("Torso")
    if not root then return end
    if V1:IsA("Model") and V1.PrimaryPart then
        V1:SetPrimaryPartCFrame(root.CFrame)
    elseif V1:IsA("BasePart") then
        V1.CFrame = root.CFrame
    end
end)
end

function entityBehaviors.HATRED()
local HATRED_MUSIC_URLS = {
    "https://raw.githubusercontent.com/Zero0Star/RipperMPSound/master/HatredBossMusic.mp3",
    "https://github.com/Zero0Star/RipperMPSound/blob/master/HatredBossMusic.mp3?raw=true",
}
local HATRED_MUSIC_FILE = "HatredBossMusic.mp3"
local HATRED_MUSIC_ASSET = nil
local HATRED_PREPARED_SOUND = nil

local function prepareHatredMusic()
    local getAsset = getcustomasset or getsynasset
    if type(getAsset) ~= "function" or type(writefile) ~= "function" then
        warn("[Hatred] Custom asset APIs are unavailable; HATRED will run without music.")
        return false
    end

    local fileReady = type(isfile) == "function" and isfile(HATRED_MUSIC_FILE)
    if not fileReady then
        local lastError = "no URL was attempted"
        for _, url in ipairs(HATRED_MUSIC_URLS) do
            local downloaded, result = pcall(function()
                local bytes = game:HttpGet(url, true)
                if type(bytes) ~= "string" or #bytes < 1024 then
                    error("downloaded response is not a valid audio file")
                end
                writefile(HATRED_MUSIC_FILE, bytes)
            end)
            if downloaded then
                fileReady = true
                break
            end
            lastError = result
        end
        if not fileReady then
            warn("[Hatred] Music download failed:", lastError)
            return false
        end
    end

    task.wait()
    local assetOk, assetId = pcall(getAsset, HATRED_MUSIC_FILE)
    if not assetOk or type(assetId) ~= "string" or assetId == "" then
        return false
    end

    HATRED_MUSIC_ASSET = assetId
    return true
end

local function createPreparedHatredSound()
    if not HATRED_MUSIC_ASSET then
        return nil
    end

    local sound = workspace:FindFirstChild("HATREDMusic")
    if sound and not sound:IsA("Sound") then
        sound:Destroy()
        sound = nil
    end
    if not sound then
        sound = Instance.new("Sound")
        sound.Name = "HATREDMusic"
        sound.Parent = workspace
    end

    sound:Stop()
    sound.SoundId = HATRED_MUSIC_ASSET
    sound.Volume = 0
    sound.Looped = true
    HATRED_PREPARED_SOUND = sound
    return sound
end

do
    if prepareHatredMusic() then
        createPreparedHatredSound()
    end
end

entityBehaviors = entityBehaviors or {}
_G.entityBehaviors = entityBehaviors
if type(getgenv) == "function" then
    getgenv().entityBehaviors = entityBehaviors
end
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")

local player = Players.LocalPlayer
if not player then
    return
end

if type(_G.HatredBossController) == "table"
    and type(_G.HatredBossController.Stop) == "function" then
    pcall(_G.HatredBossController.Stop)
end

local CONFIG = {
    ModelId = 102706413212788,
    MusicVolume = 0.8,

    StartDistance = 120,
    StopDistance = 15,
    ApproachDuration = 20,
    HoverHeight = 3,
    HoverDuration = 260,

    FlickerDuration = 260,
    FlickerAmount = 30,
    ShakeDuration = 260,
    ShakeIntensity = 0.7,

    PhaseGoals = {10, 15, 20},
    PhaseTimes = {20, 30, 30},
    BluePenalty = 3,
    PhaseTransitionSoundId = 102844356541414,
    PhaseTransitionDelay = 2.2,

    FailureFadeDuration = 5,
    FailureStormDuration = 13,
    FailureVoidDuration = 2.5,
    FaceSwapDuration = 0.1,
    FaceSwapMinDelay = 1.4,
    FaceSwapMaxDelay = 3.2,
    FailureSoundId = 139866863795650,
    FailureSoundVolume = 4,
}

local COLORS = {
    Background = Color3.fromRGB(7, 8, 14),
    Panel = Color3.fromRGB(17, 19, 29),
    Panel2 = Color3.fromRGB(27, 29, 43),
    Text = Color3.fromRGB(242, 244, 255),
    Muted = Color3.fromRGB(151, 157, 183),
    Red = Color3.fromRGB(255, 54, 72),
    RedDark = Color3.fromRGB(138, 22, 42),
    Blue = Color3.fromRGB(48, 128, 255),
    Gold = Color3.fromRGB(255, 195, 77),
    Green = Color3.fromRGB(87, 232, 151),
}

local State = {
    running = false,
    ending = false,
    cleaned = false,
    token = 0,
    phase = 0,
    clicks = 0,
    deadline = 0,

    connections = {},
    tweens = {},
    targetTweens = {},
    instances = {},

    music = nil,
    phaseSound = nil,
    failureSound = nil,
    boss = nil,
    blur = nil,
    gui = nil,
    ui = nil,
    inventory = nil,
    bossConnection = nil,
    mouseConnection = nil,

    originalMouseBehavior = nil,
    originalMouseIconEnabled = nil,
    originalInventoryVisible = nil,
}

local Controller = {}
_G.HatredBossController = Controller

local function alive(token)
    return State.running and not State.cleaned and State.token == token
end

local function addConnection(connection)
    if connection then
        table.insert(State.connections, connection)
    end
    return connection
end

local function disconnect(connection)
    if connection then
        pcall(function()
            connection:Disconnect()
        end)
    end
end

local function destroy(instance)
    if instance and instance.Parent then
        pcall(function()
            instance:Destroy()
        end)
    end
end

local function playTween(instance, info, goal)
    if not instance or not instance.Parent then
        return nil
    end
    local tween = TweenService:Create(instance, info, goal)
    table.insert(State.tweens, tween)
    tween:Play()
    return tween
end

local function waitCancelable(seconds, token)
    local finishAt = os.clock() + seconds
    while os.clock() < finishAt do
        if not alive(token) then
            return false
        end
        task.wait(math.max(0, math.min(0.1, finishAt - os.clock())))
    end
    return alive(token)
end

local function safeCaption(text)
    pcall(function()
        local mainUI = player:WaitForChild("PlayerGui", 3):FindFirstChild("MainUI")
        local initiator = mainUI and mainUI:FindFirstChild("Initiator")
        local mainGame = initiator and initiator:FindFirstChild("Main_Game")
        if mainGame then
            require(mainGame).caption(text, true)
        end
    end)
end

local function getCharacterParts(timeout)
    local character = player.Character or player.CharacterAdded:Wait()
    local root = character:WaitForChild("HumanoidRootPart", timeout or 5)
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    return character, root, humanoid
end

local function startRoomFlicker()
    task.spawn(function()
        pcall(function()
            local gameData = ReplicatedStorage:FindFirstChild("GameData")
            local latestRoomValue = gameData and gameData:FindFirstChild("LatestRoom")
            local rooms = Workspace:FindFirstChild("CurrentRooms")
            local room = latestRoomValue and rooms and rooms:FindFirstChild(tostring(latestRoomValue.Value))
            local modules = ReplicatedStorage:FindFirstChild("ModulesClient")
            local eventModule = modules and modules:FindFirstChild("Module_Events")
            if room and eventModule then
                require(eventModule).flicker(room, CONFIG.FlickerDuration, CONFIG.FlickerAmount)
            end
        end)
    end)
end

local SHAKE_BIND_NAME = "HatredBossCameraShake"

local function startCameraShake(token)
    pcall(function()
        RunService:UnbindFromRenderStep(SHAKE_BIND_NAME)
    end)

    local startedAt = os.clock()
    RunService:BindToRenderStep(SHAKE_BIND_NAME, Enum.RenderPriority.Camera.Value + 1, function()
        if not alive(token) then
            pcall(function()
                RunService:UnbindFromRenderStep(SHAKE_BIND_NAME)
            end)
            return
        end

        local elapsed = os.clock() - startedAt
        if elapsed >= CONFIG.ShakeDuration then
            pcall(function()
                RunService:UnbindFromRenderStep(SHAKE_BIND_NAME)
            end)
            return
        end

        local camera = Workspace.CurrentCamera
        if camera then
            local decay = math.max(0.12, 1 - elapsed / CONFIG.ShakeDuration)
            local power = CONFIG.ShakeIntensity * decay
            local x = math.noise(elapsed * 5.1, 0, 0) * power
            local y = math.noise(0, elapsed * 5.7, 0) * power
            local roll = math.noise(0, 0, elapsed * 4.6) * math.rad(power)
            camera.CFrame = camera.CFrame * CFrame.new(x, y, 0) * CFrame.Angles(0, 0, roll)
        end
    end)
end

local function loadBossMusic()
    if not HATRED_MUSIC_ASSET then
        local getAsset = getcustomasset or getsynasset
        local hasFile = type(isfile) == "function" and isfile(HATRED_MUSIC_FILE)
        if type(getAsset) == "function" and hasFile then
            local ok, assetId = pcall(getAsset, HATRED_MUSIC_FILE)
            if ok and type(assetId) == "string" and assetId ~= "" then
                HATRED_MUSIC_ASSET = assetId
            end
        end
    end

    if not HATRED_MUSIC_ASSET then
        return nil
    end

    local sound = HATRED_PREPARED_SOUND
    if not sound or not sound.Parent or not sound:IsA("Sound") then
        sound = Workspace:FindFirstChild("HATREDMusic")
    end
    if not sound or not sound:IsA("Sound") then
        sound = createPreparedHatredSound()
    end
    if not sound then
        return nil
    end

    HATRED_PREPARED_SOUND = sound
    sound:Stop()
    sound.SoundId = HATRED_MUSIC_ASSET
    sound.Volume = 0
    sound.Looped = true
    sound.Parent = Workspace
    State.music = sound
    sound.TimePosition = 0
    sound:Play()
    playTween(sound, TweenInfo.new(1.5, Enum.EasingStyle.Quad), {Volume = CONFIG.MusicVolume})
    return sound
end

local function fadeMusic(seconds)
    local sound = State.music
    State.music = nil
    if not sound then
        return
    end
    if sound.Parent then
        local tween = TweenService:Create(sound, TweenInfo.new(seconds or 1.2, Enum.EasingStyle.Quad), {Volume = 0})
        tween:Play()
        task.delay(seconds or 1.2, function()
            if sound then
                pcall(function()
                    sound:Stop()
                    sound:Destroy()
                end)
            end
        end)
    end
end

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

local function loadBossModel()
    local success, result = pcall(function()
        local objects = game:GetObjects("rbxassetid://" .. tostring(CONFIG.ModelId))
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

local function startBossMovement(root, token)
    local model = loadBossModel()
    if not model then
        return false
    end

    model.Name = "HatRed"
    model.Parent = Workspace
    State.boss = model

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
        State.boss = nil
        return false
    end

    for _, part in ipairs(model:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
            part.Anchored = true
        end
    end

    local playerPos = root.Position
    local playerLook = root.CFrame.LookVector
    local startPos = playerPos + (playerLook * CONFIG.StartDistance)
    startPos = startPos + Vector3.new(0, 10, 0)
    model:SetPrimaryPartCFrame(CFrame.new(startPos))

    local startTime = tick()
    local isMoving = true
    local isHovering = false
    local hoverStartTime = 0
    local connection

    connection = RunService.Heartbeat:Connect(function()
        if not alive(token) or not model or not model.Parent or not model:IsDescendantOf(Workspace) then
            if connection then
                connection:Disconnect()
            end
            return
        end

        if not root or not root.Parent then
            if connection then
                connection:Disconnect()
            end
            if model and model.Parent then
                model:Destroy()
            end
            return
        end

        local currentTime = tick()
        local currentPlayerPos = root.Position
        local playerLookDirection = root.CFrame.LookVector

        if isMoving then
            local elapsed = currentTime - startTime
            local progress = math.min(elapsed / CONFIG.ApproachDuration, 1)

            if progress >= 1 then
                isMoving = false
                isHovering = true
                hoverStartTime = currentTime
                return
            end

            local easedProgress = progress * progress
            local targetPos = currentPlayerPos + (playerLookDirection * CONFIG.StopDistance)
                + Vector3.new(0, CONFIG.HoverHeight, 0)
            local currentPos = startPos:Lerp(targetPos, easedProgress)
            model:SetPrimaryPartCFrame(CFrame.new(currentPos))

            local lookDirection = currentPlayerPos - currentPos
            if lookDirection.Magnitude > 0.1 then
                lookDirection = lookDirection.Unit
                model:SetPrimaryPartCFrame(CFrame.new(currentPos, currentPos + lookDirection))
            end
        elseif isHovering then
            local hoverTime = currentTime - hoverStartTime
            if hoverTime >= CONFIG.HoverDuration then
                if model and model.Parent then
                    model:Destroy()
                end
                if connection then
                    connection:Disconnect()
                end
                return
            end

            local targetPos = currentPlayerPos + (playerLookDirection * CONFIG.StopDistance)
                + Vector3.new(0, CONFIG.HoverHeight, 0)
            local currentPos = primaryPart.Position
            local smoothedPos = currentPos:Lerp(targetPos, 0.1)
            model:SetPrimaryPartCFrame(CFrame.new(smoothedPos))

            local lookDirection = currentPlayerPos - smoothedPos
            if lookDirection.Magnitude > 0.1 then
                lookDirection = lookDirection.Unit
                model:SetPrimaryPartCFrame(CFrame.new(smoothedPos, smoothedPos + lookDirection))
            end
        end
    end)

    State.bossConnection = connection
    addConnection(connection)
    return true
end

local FACE_NORMAL_ID = 92470122721520
local FACE_GLITCH_IDS = {
    130581413102559,
    94635282583639,
    16804066476,
    16595430194,
}

local function findReboundFace()
    local hatRed = State.boss
    if not hatRed or not hatRed.Parent then
        hatRed = Workspace:FindFirstChild("HatRed")
    end
    if not hatRed then
        return nil
    end

    local face = hatRed:FindFirstChild("FACE", true)
    local attachment = face and face:FindFirstChild("Attachment", true)
    return attachment and attachment:FindFirstChild("Rebound Face", true) or nil
end

local function setFaceTexture(faceObject, assetId)
    if not faceObject or not faceObject.Parent then
        return false
    end

    local asset = "rbxassetid://" .. tostring(assetId)
    local property
    if faceObject:IsA("ImageLabel") or faceObject:IsA("ImageButton") then
        property = "Image"
    elseif faceObject:IsA("MeshPart") then
        property = "TextureID"
    else
        property = "Texture"
    end

    return pcall(function()
        faceObject[property] = asset
    end)
end

local function startFaceChanging(token)
    task.spawn(function()
        while alive(token) and State.boss and State.boss.Parent do
            local delaySeconds = CONFIG.FaceSwapMinDelay
                + math.random() * (CONFIG.FaceSwapMaxDelay - CONFIG.FaceSwapMinDelay)
            if not waitCancelable(delaySeconds, token) then
                return
            end

            local faceObject = findReboundFace()
            if faceObject then
                local randomId = FACE_GLITCH_IDS[math.random(1, #FACE_GLITCH_IDS)]
                setFaceTexture(faceObject, randomId)
                if not waitCancelable(CONFIG.FaceSwapDuration, token) then
                    return
                end
                setFaceTexture(faceObject, FACE_NORMAL_ID)
            else
                -- The asset may still be finishing its hierarchy setup.
                task.wait(0.2)
            end
        end
    end)
end

local function hideInventory()
    local playerGui = player:FindFirstChild("PlayerGui")
    if not playerGui then
        return
    end

    local mainUI = playerGui:FindFirstChild("MainUI")
    local settings = mainUI and mainUI:FindFirstChild("Settings")
    local inventory = settings and settings:FindFirstChild("Inventory")
    if not inventory then
        for _, item in ipairs(playerGui:GetDescendants()) do
            if item:IsA("GuiObject") and item.Name:lower():find("inventory", 1, true) then
                inventory = item
                break
            end
        end
    end

    if inventory and inventory:IsA("GuiObject") then
        State.inventory = inventory
        State.originalInventoryVisible = inventory.Visible
        inventory.Visible = false
    end
end

local function startMouseOverride(token)
    State.originalMouseBehavior = UserInputService.MouseBehavior
    State.originalMouseIconEnabled = UserInputService.MouseIconEnabled

    State.mouseConnection = addConnection(RunService.RenderStepped:Connect(function()
        if alive(token) and State.phase > 0 then
            UserInputService.MouseBehavior = Enum.MouseBehavior.Default
            UserInputService.MouseIconEnabled = true
        end
    end))
    UserInputService.MouseBehavior = Enum.MouseBehavior.Default
    UserInputService.MouseIconEnabled = true
end

local function corner(parent, radius)
    local item = Instance.new("UICorner")
    item.CornerRadius = UDim.new(0, radius)
    item.Parent = parent
    return item
end

local function stroke(parent, color, thickness, transparency)
    local item = Instance.new("UIStroke")
    item.Color = color
    item.Thickness = thickness
    item.Transparency = transparency or 0
    item.Parent = parent
    return item
end

local function makeLabel(parent, name, text, size, position, font, color, textSize, alignment)
    local label = Instance.new("TextLabel")
    label.Name = name
    label.BackgroundTransparency = 1
    label.Size = size
    label.Position = position
    label.Font = font or Enum.Font.Gotham
    label.Text = text
    label.TextColor3 = color or COLORS.Text
    label.TextSize = textSize or 18
    label.TextWrapped = true
    label.TextXAlignment = alignment or Enum.TextXAlignment.Center
    label.ZIndex = 15
    label.Parent = parent
    return label
end

local function makeTarget(parent, name, color, diameter)
    local button = Instance.new("TextButton")
    button.Name = name
    button.AnchorPoint = Vector2.new(0.5, 0.5)
    button.Size = UDim2.fromOffset(diameter + 12, diameter + 12)
    button.Position = UDim2.fromScale(0.5, 0.5)
    button.BackgroundTransparency = 1
    button.BorderSizePixel = 0
    button.AutoButtonColor = false
    button.Text = ""
    button.Active = true
    button.Selectable = true
    button.ZIndex = 20
    button.Parent = parent

    local orb = Instance.new("Frame")
    orb.Name = "Orb"
    orb.AnchorPoint = Vector2.new(0.5, 0.5)
    orb.Position = UDim2.fromScale(0.5, 0.5)
    orb.Size = UDim2.fromOffset(diameter, diameter)
    orb.BackgroundColor3 = color
    orb.BorderSizePixel = 0
    orb.ZIndex = 20
    orb.Parent = button
    corner(orb, 999)

    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new(Color3.new(1, 1, 1), color)
    gradient.Rotation = 45
    gradient.Parent = orb
    stroke(orb, Color3.new(1, 1, 1), 2, 0.45)

    local scale = Instance.new("UIScale")
    scale.Name = "PopScale"
    scale.Scale = 1
    scale.Parent = button

    local shine = Instance.new("Frame")
    shine.Name = "Shine"
    shine.AnchorPoint = Vector2.new(0.5, 0.5)
    shine.Position = UDim2.fromScale(0.36, 0.34)
    shine.Size = UDim2.fromScale(0.26, 0.26)
    shine.BackgroundColor3 = Color3.new(1, 1, 1)
    shine.BackgroundTransparency = 0.25
    shine.BorderSizePixel = 0
    shine.ZIndex = 21
    shine.Parent = orb
    corner(shine, 999)

    return button
end

local function setTargetDiameter(target, diameter)
    if not target then
        return
    end
    target.Size = UDim2.fromOffset(diameter + 12, diameter + 12)
    local orb = target:FindFirstChild("Orb")
    if orb then
        orb.Size = UDim2.fromOffset(diameter, diameter)
    end
end

local function createUI()
    local playerGui = player:WaitForChild("PlayerGui")
    local old = playerGui:FindFirstChild("HatredBossUI")
    destroy(old)

    local gui = Instance.new("ScreenGui")
    gui.Name = "HatredBossUI"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Global
    gui.DisplayOrder = 10000
    gui.Parent = playerGui
    State.gui = gui

    local dim = Instance.new("Frame")
    dim.Name = "Dim"
    dim.Size = UDim2.fromScale(1, 1)
    dim.BackgroundColor3 = Color3.new(0, 0, 0)
    dim.BackgroundTransparency = 1
    dim.BorderSizePixel = 0
    dim.ZIndex = 10
    dim.Parent = gui

    local panel = Instance.new("Frame")
    panel.Name = "Panel"
    panel.AnchorPoint = Vector2.new(0.5, 0.5)
    panel.Position = UDim2.fromScale(0.5, 0.5)
    panel.Size = UDim2.fromScale(0.72, 0.72)
    panel.BackgroundColor3 = COLORS.Panel
    panel.BackgroundTransparency = 0.05
    panel.BorderSizePixel = 0
    panel.ClipsDescendants = true
    panel.ZIndex = 11
    panel.Parent = gui
    corner(panel, 18)
    stroke(panel, Color3.fromRGB(107, 48, 68), 2, 0.25)

    local sizeConstraint = Instance.new("UISizeConstraint")
    sizeConstraint.MinSize = Vector2.new(310, 340)
    sizeConstraint.MaxSize = Vector2.new(980, 700)
    sizeConstraint.Parent = panel

    local panelScale = Instance.new("UIScale")
    panelScale.Name = "EntranceScale"
    panelScale.Scale = 0.84
    panelScale.Parent = panel

    local accent = Instance.new("Frame")
    accent.Size = UDim2.new(1, 0, 0, 5)
    accent.BackgroundColor3 = COLORS.Red
    accent.BorderSizePixel = 0
    accent.ZIndex = 12
    accent.Parent = panel
    local accentGradient = Instance.new("UIGradient")
    accentGradient.Color = ColorSequence.new(COLORS.RedDark, COLORS.Red, COLORS.RedDark)
    accentGradient.Parent = accent

    local title = makeLabel(panel, "Title", "H A T R E D", UDim2.new(0.55, 0, 0, 44), UDim2.new(0.04, 0, 0, 18), Enum.Font.GothamBlack, COLORS.Text, 23, Enum.TextXAlignment.Left)
    local phaseLabel = makeLabel(panel, "Phase", "PHASE 1 / 3", UDim2.new(0.35, 0, 0, 44), UDim2.new(0.61, 0, 0, 18), Enum.Font.GothamBold, COLORS.Gold, 16, Enum.TextXAlignment.Right)

    local instruction = makeLabel(panel, "Instruction", "点击红色目标", UDim2.new(0.92, 0, 0, 34), UDim2.new(0.04, 0, 0, 65), Enum.Font.GothamMedium, COLORS.Muted, 16)

    local statBar = Instance.new("Frame")
    statBar.Name = "StatBar"
    statBar.Size = UDim2.new(0.92, 0, 0, 46)
    statBar.Position = UDim2.new(0.04, 0, 0, 104)
    statBar.BackgroundColor3 = COLORS.Panel2
    statBar.BorderSizePixel = 0
    statBar.ZIndex = 12
    statBar.Parent = panel
    corner(statBar, 10)

    local counter = makeLabel(statBar, "Counter", "0 / 10", UDim2.new(0.28, 0, 1, 0), UDim2.new(0.03, 0, 0, 0), Enum.Font.GothamBold, COLORS.Text, 17, Enum.TextXAlignment.Left)
    local timer = makeLabel(statBar, "Timer", "20.0", UDim2.new(0.25, 0, 1, 0), UDim2.new(0.72, 0, 0, 0), Enum.Font.GothamBlack, COLORS.Text, 19, Enum.TextXAlignment.Right)

    local progressBack = Instance.new("Frame")
    progressBack.Name = "ProgressBack"
    progressBack.AnchorPoint = Vector2.new(0.5, 0.5)
    progressBack.Position = UDim2.fromScale(0.5, 0.5)
    progressBack.Size = UDim2.new(0.36, 0, 0, 7)
    progressBack.BackgroundColor3 = Color3.fromRGB(49, 52, 70)
    progressBack.BorderSizePixel = 0
    progressBack.ZIndex = 13
    progressBack.Parent = statBar
    corner(progressBack, 999)

    local progress = Instance.new("Frame")
    progress.Name = "Progress"
    progress.Size = UDim2.fromScale(0, 1)
    progress.BackgroundColor3 = COLORS.Red
    progress.BorderSizePixel = 0
    progress.ZIndex = 14
    progress.Parent = progressBack
    corner(progress, 999)

    local arena = Instance.new("Frame")
    arena.Name = "Arena"
    arena.Size = UDim2.new(0.92, 0, 1, -205)
    arena.Position = UDim2.new(0.04, 0, 0, 164)
    arena.BackgroundColor3 = COLORS.Background
    arena.BackgroundTransparency = 0.12
    arena.BorderSizePixel = 0
    arena.ClipsDescendants = true
    arena.ZIndex = 12
    arena.Parent = panel
    corner(arena, 14)
    stroke(arena, Color3.fromRGB(69, 72, 94), 1, 0.35)

    local arenaGradient = Instance.new("UIGradient")
    arenaGradient.Color = ColorSequence.new(Color3.fromRGB(13, 14, 23), Color3.fromRGB(25, 13, 21))
    arenaGradient.Rotation = 35
    arenaGradient.Parent = arena

    local redTarget = makeTarget(arena, "RedTarget", COLORS.Red, 66)
    local blueTarget1 = makeTarget(arena, "BlueTarget1", COLORS.Blue, 58)
    local blueTarget2 = makeTarget(arena, "BlueTarget2", COLORS.Blue, 58)
    blueTarget1.Visible = false
    blueTarget2.Visible = false

    local footer = makeLabel(panel, "Footer", "Blue -3s", UDim2.new(0.92, 0, 0, 26), UDim2.new(0.04, 0, 1, -34), Enum.Font.Gotham, COLORS.Muted, 12)

    local phaseSound = Instance.new("Sound")
    phaseSound.Name = "HatredPhaseTransition"
    phaseSound.SoundId = "rbxassetid://" .. tostring(CONFIG.PhaseTransitionSoundId)
    phaseSound.Volume = 0.9
    phaseSound.Parent = SoundService
    State.phaseSound = phaseSound

    State.blur = Instance.new("BlurEffect")
    State.blur.Name = "HatredBossBlur"
    State.blur.Size = 0
    State.blur.Parent = Lighting

    playTween(dim, TweenInfo.new(0.55, Enum.EasingStyle.Quad), {BackgroundTransparency = 0.36})
    playTween(State.blur, TweenInfo.new(0.55, Enum.EasingStyle.Quad), {Size = 14})
    playTween(panelScale, TweenInfo.new(0.55, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1})

    State.ui = {
        Dim = dim,
        Panel = panel,
        PanelScale = panelScale,
        Phase = phaseLabel,
        Instruction = instruction,
        Counter = counter,
        Timer = timer,
        Progress = progress,
        Arena = arena,
        Red = redTarget,
        Blue1 = blueTarget1,
        Blue2 = blueTarget2,
        Footer = footer,
    }
    return State.ui
end

local function moveTarget(target, speed)
    local ui = State.ui
    if not ui or not target or not target.Visible or not target.Parent then
        return
    end

    local arenaSize = ui.Arena.AbsoluteSize
    local targetSize = target.AbsoluteSize
    if arenaSize.X < 10 or arenaSize.Y < 10 then
        return
    end

    local halfX = targetSize.X * 0.5 + 8
    local halfY = targetSize.Y * 0.5 + 8
    local x = math.random(math.floor(halfX), math.max(math.floor(halfX), math.floor(arenaSize.X - halfX)))
    local y = math.random(math.floor(halfY), math.max(math.floor(halfY), math.floor(arenaSize.Y - halfY)))

    local oldTween = State.targetTweens[target]
    if oldTween then
        pcall(function()
            oldTween:Cancel()
        end)
    end
    local tween = TweenService:Create(target, TweenInfo.new(speed, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = UDim2.fromOffset(x, y),
    })
    State.targetTweens[target] = tween
    tween:Play()
end

local function targetPulse(target, color)
    if not target or not target.Parent then
        return
    end
    local scale = target:FindFirstChild("PopScale")
    local orb = target:FindFirstChild("Orb")
    local outline = orb and orb:FindFirstChildOfClass("UIStroke")
    if scale then
        scale.Scale = 0.78
        playTween(scale, TweenInfo.new(0.24, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1})
    end
    if outline then
        outline.Color = color
        outline.Transparency = 0
        playTween(outline, TweenInfo.new(0.35), {Transparency = 0.45})
    end
end

local function updateHUD()
    local ui = State.ui
    if not ui or not ui.Panel.Parent or State.phase < 1 then
        return
    end

    local goal = CONFIG.PhaseGoals[State.phase]
    ui.Phase.Text = string.format("PHASE %d / 3", State.phase)
    ui.Counter.Text = string.format("%d / %d", State.clicks, goal)
    local ratio = math.clamp(State.clicks / goal, 0, 1)
    playTween(ui.Progress, TweenInfo.new(0.18, Enum.EasingStyle.Quad), {Size = UDim2.fromScale(ratio, 1)})

    if State.phase == 1 then
        ui.Phase.TextColor3 = COLORS.Gold
        ui.Instruction.Text = "Click the red one!"
    elseif State.phase == 2 then
        ui.Phase.TextColor3 = Color3.fromRGB(217, 112, 255)
        ui.Instruction.Text = "Click the red one, Dodge the blue"
    else
        ui.Phase.TextColor3 = COLORS.Red
        ui.Instruction.Text = "END：Dodge the blue."
    end
end

local function flashMessage(text, color, seconds, token)
    local ui = State.ui
    if not ui or not ui.Instruction.Parent then
        return
    end
    local expectedPhase = State.phase
    ui.Instruction.Text = text
    ui.Instruction.TextColor3 = color
    task.delay(seconds or 0.8, function()
        if alive(token) and State.phase == expectedPhase then
            ui.Instruction.TextColor3 = COLORS.Muted
            updateHUD()
        end
    end)
end

local function beginPhase(phase, token)
    if not alive(token) then
        return
    end
    State.phase = phase
    State.clicks = 0
    State.deadline = os.clock() + CONFIG.PhaseTimes[phase]

    local ui = State.ui
    ui.Progress.Size = UDim2.fromScale(0, 1)
    ui.Red.Visible = true
    ui.Blue1.Visible = phase >= 2
    ui.Blue2.Visible = phase >= 3
    setTargetDiameter(ui.Red, phase == 1 and 66 or (phase == 2 and 58 or 52))
    setTargetDiameter(ui.Blue1, phase == 3 and 50 or 56)
    setTargetDiameter(ui.Blue2, 50)
    updateHUD()

    task.defer(function()
        RunService.Heartbeat:Wait()
        if alive(token) then
            moveTarget(ui.Red, 0)
            moveTarget(ui.Blue1, 0)
            moveTarget(ui.Blue2, 0)
        end
    end)
end

local function removeBoss()
    local model = State.boss
    State.boss = nil
    disconnect(State.bossConnection)
    State.bossConnection = nil
    destroy(model)
end

local function restoreLocalState()
    if State.inventory and State.inventory.Parent and State.originalInventoryVisible ~= nil then
        State.inventory.Visible = State.originalInventoryVisible
    end
    State.inventory = nil

    if State.originalMouseBehavior ~= nil then
        UserInputService.MouseBehavior = State.originalMouseBehavior
    end
    if State.originalMouseIconEnabled ~= nil then
        UserInputService.MouseIconEnabled = State.originalMouseIconEnabled
    end
end

local function cleanup(immediate)
    if State.cleaned then
        return
    end
    State.cleaned = true
    State.running = false
    State.phase = 0
    State.token = State.token + 1

    pcall(function()
        RunService:UnbindFromRenderStep(SHAKE_BIND_NAME)
    end)

    for _, connection in ipairs(State.connections) do
        disconnect(connection)
    end
    State.connections = {}

    for _, tween in ipairs(State.tweens) do
        pcall(function()
            tween:Cancel()
        end)
    end
    State.tweens = {}
    State.targetTweens = {}

    fadeMusic(immediate and 0.05 or 0.9)
    destroy(State.phaseSound)
    State.phaseSound = nil
    destroy(State.failureSound)
    State.failureSound = nil
    destroy(State.boss)
    State.boss = nil
    destroy(State.blur)
    State.blur = nil
    destroy(State.gui)
    State.gui = nil
    State.ui = nil
    restoreLocalState()
end

Controller.Stop = function()
    cleanup(false)
end

local function defeatPlayer()
    local character, _, humanoid = getCharacterParts(2)
    local signaled = false
    if type(replicatesignal) == "function" then
        signaled = pcall(function()
            replicatesignal(player.Kill)
        end)
    end
    if not signaled and humanoid and humanoid.Parent then
        humanoid.Health = 0
    elseif not signaled and character then
        character:BreakJoints()
    end
end

local FAILURE_TEXTURE_IDS = {
    88894221959954,
    12293713542,
    6214195404,
}

local function createFailureOverlay()
    local gui = State.gui
    if not gui or not gui.Parent then
        return nil
    end

    local old = gui:FindFirstChild("FailureOverlay")
    destroy(old)

    local overlay = Instance.new("Frame")
    overlay.Name = "FailureOverlay"
    overlay.Size = UDim2.fromScale(1, 1)
    overlay.BackgroundColor3 = Color3.new(0, 0, 0)
    overlay.BackgroundTransparency = 1
    overlay.BorderSizePixel = 0
    overlay.ClipsDescendants = true
    overlay.ZIndex = 500
    overlay.Parent = gui

    local textLayer = Instance.new("Frame")
    textLayer.Name = "LoserTextLayer"
    textLayer.Size = UDim2.fromScale(1, 1)
    textLayer.BackgroundTransparency = 1
    textLayer.BorderSizePixel = 0
    textLayer.ZIndex = 510
    textLayer.Parent = overlay

    local glitchBars = {}
    for index = 1, 18 do
        local bar = Instance.new("Frame")
        bar.Name = "EdgeError" .. index
        bar.BackgroundColor3 = COLORS.Red
        bar.BackgroundTransparency = 1
        bar.BorderSizePixel = 0
        bar.ZIndex = 505
        bar.Parent = overlay
        table.insert(glitchBars, bar)
    end

    local glitchImages = {}
    for index = 1, 12 do
        local image = Instance.new("ImageLabel")
        image.Name = "ErrorTexture" .. index
        image.AnchorPoint = Vector2.new(0.5, 0.5)
        image.BackgroundTransparency = 1
        image.BorderSizePixel = 0
        image.Image = "rbxassetid://" .. tostring(FAILURE_TEXTURE_IDS[((index - 1) % #FAILURE_TEXTURE_IDS) + 1])
        image.ImageTransparency = 1
        image.ScaleType = Enum.ScaleType.Stretch
        image.Visible = false
        image.ZIndex = 508 + (index % 3)
        image.Parent = overlay
        table.insert(glitchImages, image)
    end

    destroy(State.failureSound)
    local failureSound = Instance.new("Sound")
    failureSound.Name = "HatredLoserGlitch"
    failureSound.SoundId = "rbxassetid://" .. tostring(CONFIG.FailureSoundId)
    failureSound.Volume = CONFIG.FailureSoundVolume
    failureSound.Parent = SoundService
    State.failureSound = failureSound

    return overlay, textLayer, glitchBars, glitchImages
end

local function updateFailureGlitch(textLayer, glitchBars, glitchImages, intensity)
    if textLayer and textLayer.Parent then
        local jitter = math.floor(2 + intensity * 12)
        textLayer.Position = UDim2.fromOffset(math.random(-jitter, jitter), math.random(-jitter, jitter))
    end

    for index, bar in ipairs(glitchBars) do
        if not bar.Parent then
            continue
        end

        local side = ((index - 1) % 4) + 1
        local thickness = math.random(2, math.floor(5 + intensity * 25))
        local length = math.random(8, math.floor(20 + intensity * 70)) / 100
        if side == 1 then
            bar.Size = UDim2.new(length, 0, 0, thickness)
            bar.Position = UDim2.new(math.random(), 0, 0, math.random(0, 22))
        elseif side == 2 then
            bar.AnchorPoint = Vector2.new(0, 1)
            bar.Size = UDim2.new(length, 0, 0, thickness)
            bar.Position = UDim2.new(math.random(), 0, 1, -math.random(0, 22))
        elseif side == 3 then
            bar.Size = UDim2.new(0, thickness, length, 0)
            bar.Position = UDim2.new(0, math.random(0, 22), math.random(), 0)
        else
            bar.AnchorPoint = Vector2.new(1, 0)
            bar.Size = UDim2.new(0, thickness, length, 0)
            bar.Position = UDim2.new(1, -math.random(0, 22), math.random(), 0)
        end

        local colorRoll = math.random(1, 5)
        bar.BackgroundColor3 = colorRoll == 1 and Color3.new(1, 1, 1)
            or (colorRoll == 2 and Color3.fromRGB(30, 0, 0) or COLORS.Red)
        bar.BackgroundTransparency = math.random(5, math.floor(35 + (1 - intensity) * 50)) / 100
        bar.Visible = math.random() < (0.35 + intensity * 0.65)
    end

    for _, image in ipairs(glitchImages) do
        if image.Parent then
            local width = math.random(18, math.floor(35 + intensity * 55)) / 100
            local height = math.random(12, math.floor(25 + intensity * 50)) / 100
            image.Size = UDim2.fromScale(width, height)
            image.Position = UDim2.fromScale(math.random(), math.random())
            image.Rotation = math.random(-12, 12)
            image.Image = "rbxassetid://" .. tostring(FAILURE_TEXTURE_IDS[math.random(1, #FAILURE_TEXTURE_IDS)])
            image.ImageColor3 = math.random() < 0.25 and Color3.new(1, 1, 1)
                or Color3.fromRGB(255, math.random(15, 75), math.random(15, 75))
            image.ImageTransparency = math.random(8, math.floor(35 + (1 - intensity) * 45)) / 100
            image.Visible = math.random() < (0.2 + intensity * 0.72)
        end
    end
end

local function spawnLoserText(textLayer, intensity, isFirst)
    if not textLayer or not textLayer.Parent then
        return
    end

    local failureSound = State.failureSound
    if failureSound and failureSound.Parent then
        pcall(function()
            failureSound.TimePosition = 0
            failureSound:Play()
        end)
    end

    local label = Instance.new("TextLabel")
    label.Name = "YOUR_LOSER"
    label.AnchorPoint = Vector2.new(0.5, 0.5)
    label.Size = isFirst and UDim2.fromOffset(420, 100)
        or UDim2.fromOffset(math.random(150, 430), math.random(45, 115))
    label.Position = isFirst and UDim2.fromScale(0.5, 0.5)
        or UDim2.fromScale(math.random(), math.random())
    label.BackgroundTransparency = 1
    label.BorderSizePixel = 0
    label.Font = math.random() < 0.35 and Enum.Font.Code or Enum.Font.GothamBlack
    label.Text = "YOUR LOSER"
    label.TextColor3 = math.random() < 0.18 and Color3.new(1, 1, 1) or COLORS.Red
    label.TextStrokeColor3 = Color3.new(0, 0, 0)
    label.TextStrokeTransparency = math.max(0, 0.5 - intensity * 0.45)
    label.TextTransparency = isFirst and 0 or math.random(0, 25) / 100
    label.TextScaled = true
    label.Rotation = isFirst and 0 or math.random(-18, 18)
    label.ZIndex = 520 + math.random(0, 5)
    label.Parent = textLayer

    local scale = Instance.new("UIScale")
    scale.Scale = isFirst and 0.15 or math.random(35, 85) / 100
    scale.Parent = label
    playTween(
        scale,
        TweenInfo.new(isFirst and 0.55 or math.max(0.04, 0.18 - intensity * 0.12), Enum.EasingStyle.Back),
        {Scale = isFirst and 1 or math.random(90, 150) / 100}
    )
end

local function playFailureSequence(token)
    local overlay, textLayer, glitchBars, glitchImages = createFailureOverlay()
    if not overlay then
        return false
    end

    playTween(
        overlay,
        TweenInfo.new(CONFIG.FailureFadeDuration, Enum.EasingStyle.Sine, Enum.EasingDirection.In),
        {BackgroundTransparency = 0}
    )

    if not waitCancelable(1.4, token) then
        return false
    end

    spawnLoserText(textLayer, 0, true)
    if not waitCancelable(1.1, token) then
        return false
    end
    local stormStart = os.clock()
    local spawned = 1

    while alive(token) do
        local elapsed = os.clock() - stormStart
        local progress = math.clamp(elapsed / CONFIG.FailureStormDuration, 0, 1)
        if progress >= 1 then
            break
        end

        updateFailureGlitch(textLayer, glitchBars, glitchImages, progress)
        local burst = 1 + math.floor(progress * 4)
        for _ = 1, burst do
            if spawned >= 240 then
                break
            end
            spawnLoserText(textLayer, progress, false)
            spawned = spawned + 1
        end

        local interval = 0.92 * ((1 - progress) ^ 2) + 0.045
        if not waitCancelable(interval, token) then
            return false
        end
    end

    if textLayer and textLayer.Parent then
        textLayer:Destroy()
    end
    for _, bar in ipairs(glitchBars) do
        destroy(bar)
    end
    for _, image in ipairs(glitchImages) do
        destroy(image)
    end
    destroy(State.failureSound)
    State.failureSound = nil
    overlay.BackgroundTransparency = 0

    return waitCancelable(CONFIG.FailureVoidDuration, token)
end

local function finish(result, token)
    if State.ending or not alive(token) then
        return
    end
    State.ending = true

    local ui = State.ui
    if ui then
        ui.Red.Visible = false
        ui.Blue1.Visible = false
        ui.Blue2.Visible = false
        ui.Timer.Text = result == "victory" and "CLEAR" or "FAILED"
        ui.Timer.TextColor3 = result == "victory" and COLORS.Green or COLORS.Red
        ui.Instruction.Text = result == "victory" and "存活于憎恨" or "YOUR LOSER"
        ui.Instruction.TextColor3 = result == "victory" and COLORS.Green or COLORS.Red
    end

    if result == "victory" then
        removeBoss()
        fadeMusic(1.8)
        waitCancelable(1.1, token)
        safeCaption("It looks like you've made progress. Congratulations.")
        waitCancelable(1.3, token)
        cleanup(false)
    else
        fadeMusic(4)
        if playFailureSequence(token) and alive(token) then
            defeatPlayer()
        end
        cleanup(true)
    end
end

local function startMiniGame(token)
    local ui = createUI()
    hideInventory()
    beginPhase(1, token)
    startMouseOverride(token)

    local transitioning = false
    local nextRedMove = 0
    local nextBlue1Move = 0
    local nextBlue2Move = 0

    addConnection(ui.Red.Activated:Connect(function()
        if not alive(token) or State.ending or transitioning then
            return
        end
        State.clicks = State.clicks + 1
        targetPulse(ui.Red, Color3.new(1, 1, 1))
        updateHUD()

        if State.clicks >= CONFIG.PhaseGoals[State.phase] then
            if State.phase >= 3 then
                task.spawn(finish, "victory", token)
                return
            end

            transitioning = true
            local nextPhase = State.phase + 1
            State.deadline = math.huge
            ui.Red.Visible = false
            ui.Blue1.Visible = false
            ui.Blue2.Visible = false
            ui.Timer.Text = "READY"
            ui.Timer.TextColor3 = COLORS.Gold
            ui.Instruction.Text = nextPhase == 3
                and "存活第二阶段"
                or "存活第一阶段"
            ui.Instruction.TextColor3 = COLORS.Gold
            if State.phaseSound then
                State.phaseSound.TimePosition = 0
                State.phaseSound:Play()
            end
            task.delay(CONFIG.PhaseTransitionDelay, function()
                if alive(token) then
                    beginPhase(nextPhase, token)
                    transitioning = false
                end
            end)
        else
            moveTarget(ui.Red, State.phase == 3 and 0.12 or 0.18)
        end
    end))

    local function blueClicked(target)
        if not alive(token) or State.ending or transitioning or State.phase < 2 then
            return
        end
        State.deadline = State.deadline - CONFIG.BluePenalty
        targetPulse(target, COLORS.Red)
        flashMessage("-3s 躲避蓝色", COLORS.Red, 0.75, token)
        moveTarget(target, 0.16)
    end

    addConnection(ui.Blue1.Activated:Connect(function()
        blueClicked(ui.Blue1)
    end))
    addConnection(ui.Blue2.Activated:Connect(function()
        if State.phase >= 3 then
            blueClicked(ui.Blue2)
        end
    end))

    addConnection(RunService.Heartbeat:Connect(function()
        if not alive(token) or State.ending or State.phase < 1 then
            return
        end

        if transitioning then
            ui.Timer.Text = "READY"
            ui.Timer.TextColor3 = COLORS.Gold
            return
        end

        local now = os.clock()
        local remaining = math.max(0, State.deadline - now)
        ui.Timer.Text = string.format("%.1f", remaining)
        ui.Timer.TextColor3 = remaining <= 5 and COLORS.Red or COLORS.Text

        if not transitioning then
            local redInterval = State.phase == 1 and 0.82 or (State.phase == 2 and 0.66 or 0.5)
            if now >= nextRedMove then
                moveTarget(ui.Red, State.phase == 3 and 0.16 or 0.22)
                nextRedMove = now + redInterval
            end
            if State.phase >= 2 and now >= nextBlue1Move then
                moveTarget(ui.Blue1, 0.3)
                nextBlue1Move = now + (State.phase == 3 and 0.8 or 1.05)
            end
            if State.phase >= 3 and now >= nextBlue2Move then
                moveTarget(ui.Blue2, 0.3)
                nextBlue2Move = now + 0.9
            end
        end

        if remaining <= 0 then
            task.spawn(finish, "defeat", token)
        end
    end))
end

local function runEvent()
    if State.running then
        return
    end

    State.cleaned = false
    State.running = true
    State.ending = false
    State.phase = 0
    State.clicks = 0
    State.token = State.token + 1
    local token = State.token

    local ok, errorMessage = xpcall(function()
        local _, root = getCharacterParts(6)
        if not root then
            error("HumanoidRootPart was not found")
        end

        startRoomFlicker()
        startCameraShake(token)
        loadBossMusic()
        safeCaption("What is this?")
        if not waitCancelable(0.5, token) then
            return
        end
        if not startBossMovement(root, token) then
            error("Original boss model could not be loaded")
        end
        startFaceChanging(token)

        if not waitCancelable(CONFIG.ApproachDuration, token) then
            return
        end
        safeCaption("We meet again, little bug.")
        if not waitCancelable(3.2, token) then return end
        safeCaption("I hope you can learn a lesson this time.")
        if not waitCancelable(3.2, token) then return end
        safeCaption("Let's get started.")
        if not waitCancelable(1, token) then return end

        startMiniGame(token)
    end, debug.traceback)

    if not ok then
        cleanup(true)
    end
end

addConnection(player.CharacterRemoving:Connect(function()
    cleanup(true)
end))

Controller.Start = runEvent
task.spawn(runEvent)
end

function entityBehaviors.JEFFGUN()
local RunService = game:GetService("RunService")
local V1 = game:GetObjects("rbxassetid://81046861041760")[1]
V1.Parent = workspace
local V2 = workspace:WaitForChild("JeffTheKiller")

local xOffset = 0
local yOffset = 0
local zOffset = 0

if V1:IsA("Model") then
    local primary = V1:FindFirstChildWhichIsA("BasePart")
    if primary then
        V1.PrimaryPart = primary
    end
end

local function HS()
    if not V2 then return end
    
    local function HP(obj)
        if obj:IsA("BasePart") then
            obj.Transparency = 1
            obj.CanCollide = false
        end
        
        for _, child in ipairs(obj:GetChildren()) do
            if child:IsA("Decal") or child:IsA("Texture") or child:IsA("SurfaceAppearance") then
                child.Transparency = 1
            elseif child:IsA("ParticleEmitter") or child:IsA("Beam") or child:IsA("Trail") then
                child.Enabled = false
            end
            
            HP(child)
        end
    end
    
    local p1 = V2:FindFirstChild("Knife")
    local p2 = V2:FindFirstChild("Head")
    local p3 = V2:FindFirstChild("BoyAnimeHair_Black")
    if p1 then HP(p1) end
    if p2 then HP(p2) end
    if p3 then
        local h = p3:Clone()
        h.Parent = V2
        HP(h)
    end
    
    local leftArm = V2:FindFirstChild("Left Arm")
    local rightArm = V2:FindFirstChild("Right Arm")
    if leftArm then HP(leftArm) end
    if rightArm then HP(rightArm) end
end

HS()

local connection
connection = V2.AncestryChanged:Connect(function(_, parent)
    if not parent then
        V1:Destroy()
        if connection then
            connection:Disconnect()
        end
    end
end)

RunService.Heartbeat:Connect(function()
    if not V2 or not V2.Parent then 
        V1:Destroy()
        if connection then
            connection:Disconnect()
        end
        return 
    end

    local function findRootPart(model)
        local root = model:FindFirstChild("HumanoidRootPart") or model:FindFirstChild("Torso")
        if root then 
            return root 
        end
        
        for _, child in pairs(model:GetDescendants()) do
            if (child.Name == "HumanoidRootPart" or child.Name == "Torso") and child:IsA("BasePart") then
                return child
            end
        end
        return nil
    end
    
    local root = findRootPart(V2)
    if not root then 
        V1:Destroy()
        if connection then
            connection:Disconnect()
        end
        return
    end
    if V1:IsA("Model") then
        if not V1.PrimaryPart then
            local part = V1:FindFirstChildWhichIsA("BasePart")
            if part then
                V1.PrimaryPart = part
            end
        end
        
        if V1.PrimaryPart then
            local newCFrame = CFrame.new(
                root.CFrame.Position.X + xOffset,
                root.CFrame.Position.Y + yOffset,
                root.CFrame.Position.Z + zOffset
            ) * root.CFrame.Rotation
            V1:SetPrimaryPartCFrame(newCFrame)
        end
    elseif V1:IsA("BasePart") then
        local newCFrame = CFrame.new(
            root.CFrame.Position.X + xOffset,
            root.CFrame.Position.Y + yOffset,
            root.CFrame.Position.Z + zOffset
        ) * root.CFrame.Rotation
        V1.CFrame = newCFrame
    end
end)
end

function entityBehaviors.JEFFSTARY()
 local RunService = game:GetService("RunService")

local jeff = workspace:FindFirstChild("JeffTheKiller")
local rootPart = jeff and jeff:FindFirstChild("HumanoidRootPart")

if jeff and rootPart then
    local humanoid = jeff:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = 0
        humanoid.JumpPower = 0
    end
    
    local initialPosition = rootPart.Position
    
    RunService.Heartbeat:Connect(function()
        local jeffPosition = rootPart.Position
        local closestPlayer = nil
        local shortestDistance = math.huge
        
        for _, player in pairs(game.Players:GetPlayers()) do
            local character = player.Character
            if character then
                local targetRootPart = character:FindFirstChild("HumanoidRootPart")
                if targetRootPart then
                    local distance = (targetRootPart.Position - jeffPosition).Magnitude
                    if distance < shortestDistance then
                        shortestDistance = distance
                        closestPlayer = player
                    end
                end
            end
        end
        
        if closestPlayer and closestPlayer.Character then
            local targetRootPart = closestPlayer.Character:FindFirstChild("HumanoidRootPart")
            if targetRootPart then
                local direction = (targetRootPart.Position - jeffPosition) * Vector3.new(1, 0, 1)
                
                if direction.Magnitude > 0 then
                    local lookAtCFrame = CFrame.lookAt(jeffPosition, jeffPosition + direction)
                    rootPart.CFrame = CFrame.new(jeffPosition) * lookAtCFrame.Rotation
                end
            end
        end
        
        rootPart.CFrame = CFrame.new(initialPosition) * rootPart.CFrame.Rotation
    end)
end
end
function entityBehaviors.JEFFGUNST()
local sound1 = Instance.new("Sound")
sound1.SoundId = "rbxassetid://3120031857"
sound1.Volume = 1
sound1.Parent = workspace
local sound2 = Instance.new("Sound")
sound2.SoundId = "rbxassetid://680140087"
sound2.Volume = 1
sound2.Parent = workspace
sound1:Play()
task.wait(1)
sound2:Play()
sound2.Ended:Wait()
sound1:Destroy()
sound2:Destroy()
end
local function PreloadReboundSounds()
    if workspace:FindFirstChild("ReboundSweep_Preloaded") and workspace:FindFirstChild("ReboundMovings_Preloaded") then
        return
    end
    
    local function DownloadAndStoreSound(url, soundName)
        local fullFileName = soundName .. ".mp3"

        local success, audioData = pcall(function()
            return game:HttpGet(url)
        end)
        
        if not success then
            return nil
        end

        local writeSuccess = pcall(function()
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
        end
        
        if not assetPath then
            return nil
        end

        local sound = Instance.new("Sound")
        sound.SoundId = assetPath
        sound.Name = soundName .. "_Preloaded"
        sound.Parent = workspace
        sound.Volume = 0
        sound:Play()
        sound:Stop()
        
        return sound
    end

    DownloadAndStoreSound("https://github.com/Zero0Star/RipperMPSound/blob/master/ReboundSoundV1.mp3?raw=true", "ReboundSweep")

    DownloadAndStoreSound("https://github.com/Zero0Star/RipperMPSound/blob/master/ReboundMovings.mp3?raw=true", "ReboundMovings")
end

PreloadReboundSounds()

function entityBehaviors.REBOUNDSW()
    local testModelId = 90731910259298

    local function PlayPreloadedSound(soundName, volume)
        volume = volume or 1
        local sound = workspace:FindFirstChild(soundName .. "_Preloaded")
        
        if sound then
            sound.Volume = volume
            sound:Play()
            return sound
        end
        return nil
    end

    local function GetMaxExistingRoom()
        local rooms = workspace.CurrentRooms:GetChildren()
        local maxNum = 0
        for _, room in ipairs(rooms) do
            local num = tonumber(room.Name)
            if num and num > maxNum then
                maxNum = num
            end
        end
        return maxNum
    end

    function SpawnReboundEntity(startRoomType)
        for _, obj in pairs(workspace:GetChildren()) do
            if obj.Name == "Rebound" then
                pcall(function() obj:Destroy() end)
            end
        end

        local success, modelResult = pcall(function()
            return game:GetObjects("rbxassetid://" .. testModelId)[1]
        end)

        if not success or not modelResult then
            return
        end

        local testEntity = modelResult:Clone()
        testEntity.Parent = workspace
        testEntity.Name = "Rebound"

        local primaryPart = testEntity.PrimaryPart or testEntity:FindFirstChildWhichIsA("BasePart")
        if not primaryPart then
            testEntity:Destroy()
            return
        end

        primaryPart.Anchored = true
        primaryPart.CanCollide = false

        spawn(function()
            local targetRoom
            if startRoomType == "start" then
                targetRoom = workspace.CurrentRooms:FindFirstChild("0")
            else
                local maxRoom = GetMaxExistingRoom()
                targetRoom = workspace.CurrentRooms:FindFirstChild(tostring(maxRoom))
            end
            
            if targetRoom then
                local targetCFrame
                if targetRoom:FindFirstChild("Nodes") then
                    targetCFrame = (targetRoom:FindFirstChild("RoomEntrance") or targetRoom:FindFirstChild("RoomExit")).CFrame
                else
                    targetCFrame = targetRoom.RoomExit.CFrame
                end
                primaryPart.CFrame = targetCFrame + Vector3.new(0, 1, 0)
            end
            
            wait(2)
            StartEntityLogic(primaryPart, startRoomType)
        end)
    end

    function StartEntityLogic(primaryPart, startRoomType)
        local CameraShaker = require(game.ReplicatedStorage.CameraShaker)
        local camera = workspace.CurrentCamera
        local camShake = CameraShaker.new(Enum.RenderPriority.Camera.Value, function(cf)
            camera.CFrame = camera.CFrame * cf
        end)
        camShake:Start()

        local v305 = 2
        local v306 = 2
        local v307 = Vector3.new(0, 1, 0)
        local v310 = workspace.CurrentRooms

        local detectedPlayer = false
        local shakeCooldown = 0
        
        local function CheckLineOfSight(entityPart, player, maxDistance)
            if not entityPart or not player or not player.Character then
                return false
            end
            if player.Character:GetAttribute("Hiding") then
                return false
            end
            
            local hum = player.Character:FindFirstChildWhichIsA("Humanoid")
            if not hum or hum.Health <= 0 then
                return false
            end
            
            local origin = entityPart.Position
            local hrp = player.Character:FindFirstChild("HumanoidRootPart")
            if not hrp then return false end
            
            local targetPos = hrp.Position
            local distance = (targetPos - origin).Magnitude
            
            local direction = (targetPos - origin).Unit * maxDistance
            local ray = Ray.new(origin, direction)
            local hitPart, _ = workspace:FindPartOnRay(ray, entityPart)
            
            return hitPart and hitPart:IsDescendantOf(player.Character)
        end

        local function ExecutePlayer()
            if detectedPlayer then return end
            detectedPlayer = true

            local vu321 = Instance.new("ScreenGui")
            local vu322 = Instance.new("ImageLabel")
            local v323 = Instance.new("ImageLabel")
            local v324 = Instance.new("ImageLabel")
            
            vu321.Name = "TestEntityJs"
            vu321.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
            
            vu322.Name = "Static"
            vu322.Parent = vu321
            vu322.BackgroundColor3 = Color3.fromRGB(0, 63, 139)
            vu322.BackgroundTransparency = 1
            vu322.BorderSizePixel = 0
            vu322.Size = UDim2.new(1, 0, 1, 0)
            vu322.Image = "rbxassetid://236543215"
            vu322.ImageColor3 = Color3.fromRGB(0, 255, 255)
            vu322.ImageTransparency = 1
            
            v323.Name = "TestEntity"
            v323.Parent = vu321
            v323.BackgroundTransparency = 1
            v323.Position = UDim2.new(0.486631036, 0, 0.479363143, 0)
            v323.Size = UDim2.new(0.0267379656, 0, 0.0387096703, 0)
            v323.Image = "rbxassetid://97823818277141"
            
            v324.Name = "JSSIZE"
            v324.Parent = vu321
            v324.BackgroundTransparency = 1
            v324.Position = UDim2.new(-0.586452842, 0, -1.25140607, 0)
            v324.Size = UDim2.new(2.12834215, 0, 3.08128953, 0)
            v324.Visible = false
            v324.Image = "rbxassetid://10914800940"

            local function v326()
                local v325 = Instance.new("LocalScript", vu322)
                while v325.Parent and v325.Parent.Parent do
                    v325.Parent.Image = "rbxassetid://236543215"
                    wait(0.002)
                    v325.Parent.Rotation = 0
                    wait(0.002)
                    v325.Parent.Rotation = 180
                    wait(0.002)
                    v325.Parent.Image = "rbxassetid://236777652"
                    wait(0.002)
                    v325.Parent.Rotation = 0
                    wait(0.002)
                    v325.Parent.Rotation = 180
                    wait(0.002)
                end
            end
            coroutine.wrap(v326)()

            local v327 = Instance.new("LocalScript", vu321)
            local vu328 = game.ReplicatedStorage
            local vu329 = game.Players.LocalPlayer
            local vu330 = v327.Parent
            local vu331 = vu330.Static
            local vu332 = vu330.TestEntity
            
            local killSound = Instance.new("Sound")
            killSound.SoundId = "rbxassetid://94785993416953"
            killSound.Parent = workspace
            killSound.Volume = 2

            (function()
                game.TweenService:Create(vu331, TweenInfo.new(0.5), {
                    BackgroundTransparency = 0,
                    ImageTransparency = 0.8
                }):Play()
                
                game.TweenService:Create(vu332, TweenInfo.new(0.5), {
                    Size = v324.Size,
                    Position = v324.Position
                }):Play()
                
                killSound:Play()
                
                spawn(function()
                    wait(0.3)
                    local char = vu329.Character
                    if char then
                        local hum = char:FindFirstChildWhichIsA("Humanoid")
                        if hum then
                            hum:TakeDamage(100)
                            if vu328.GameStats["Player_" .. vu329.Name] then
                                vu328.GameStats["Player_" .. vu329.Name].Total.DeathCause.Value = "Rebound"
                            end

firesignal(game.ReplicatedStorage.RemotesFolder.DeathHint.OnClientEvent, {
    "你死于Rebound...",
    "巨大的噪音震耳欲聋...",
    "每当开启一次门时注意雷声..."
}, "Blue")
                        end
                    end
                end)
                
                wait(0.5)
                game.TweenService:Create(vu331, TweenInfo.new(1), {
                    BackgroundTransparency = 1,
                    ImageTransparency = 1
                }):Play()
                game.TweenService:Create(vu332, TweenInfo.new(0.3), {
                    ImageTransparency = 1
                }):Play()
                wait(1)
                killSound:Destroy()
                vu330:Destroy()
            end)()
        end

        spawn(function()
            local player = game.Players.LocalPlayer
            while primaryPart and primaryPart.Parent do
                wait(0.5)
                if workspace:FindFirstChild("SeekMovingNewClone") or workspace.CurrentRooms:FindFirstChild("50") then
                    break
                end

                if CheckLineOfSight(primaryPart, player, 100) then
                    ExecutePlayer()
                end
            end
        end)

        if startRoomType == "start" then
            local currentRoom = 0
            local maxRoom = game.ReplicatedStorage.GameData.LatestRoom.Value

            while currentRoom <= maxRoom do
                if workspace:FindFirstChild("SeekMovingNewClone") or workspace.CurrentRooms:FindFirstChild("50") then
                    break
                end

                local targetRoom = v310:FindFirstChild(currentRoom)
                if targetRoom then
                    local targetCFrame
                    if targetRoom:FindFirstChild("Nodes") then
                        targetCFrame = (targetRoom:FindFirstChild("RoomEntrance") or targetRoom:FindFirstChild("RoomExit")).CFrame
                    else
                        targetCFrame = targetRoom.RoomExit.CFrame
                    end

                    game.TweenService:Create(primaryPart, TweenInfo.new(v305), {
                        CFrame = targetCFrame + v307
                    }):Play()
                    
                    wait(v306)
                end

                maxRoom = game.ReplicatedStorage.GameData.LatestRoom.Value
                currentRoom = currentRoom + 1
            end
        else
            local currentRoom = GetMaxExistingRoom()
            local minRoom = math.max(0, currentRoom - 7)

            while currentRoom >= minRoom do
                if workspace:FindFirstChild("SeekMovingNewClone") or workspace.CurrentRooms:FindFirstChild("50") then
                    break
                end

                local targetRoom = v310:FindFirstChild(currentRoom)
                if targetRoom then
                    local targetCFrame
                    if targetRoom:FindFirstChild("Nodes") then
                        targetCFrame = (targetRoom:FindFirstChild("RoomEntrance") or targetRoom:FindFirstChild("RoomExit")).CFrame
                    else
                        targetCFrame = targetRoom.RoomExit.CFrame
                    end

                    game.TweenService:Create(primaryPart, TweenInfo.new(v305), {
                        CFrame = targetCFrame + v307
                    }):Play()
                    
                    wait(v306)
                end

                currentRoom = currentRoom - 1
            end
        end

        primaryPart.Anchored = false
        primaryPart.CanCollide = false
    end

    for _, obj in pairs(workspace:GetChildren()) do
        if obj.Name == "Rebound" or obj.Name == "Bound" or 
           (obj.Name:find("ReboundMovings") and not obj.Name:find("_Preloaded")) or 
           (obj.Name:find("ReboundSweep") and not obj.Name:find("_Preloaded")) then
            pcall(function() obj:Destroy() end)
        end
    end

    pcall(function() delfile("ReboundMovings.mp3") end)
    pcall(function() delfile("ReboundSweep.mp3") end)

    local sweepSound = PlayPreloadedSound("ReboundSweep", 2)
    
    local part = Instance.new("Part")
    part.Name = "Bound_" .. tick()
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

    wait(3)

    local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/DOORS-Entity-Spawner-V2/main/init.luau"))()

    SpawnReboundEntity("latest")

    local sound1 = PlayPreloadedSound("ReboundMovings", 3)
    if sound1 then
        repeat
            wait()
        until sound1.IsPlaying == false
    end
    game.ReplicatedStorage.GameData.LatestRoom.Changed:Wait()

    SpawnReboundEntity("start")

    local CameraShaker2 = require(game.ReplicatedStorage.CameraShaker)
    local camara2 = game.Workspace.CurrentCamera
    local camShake2 = CameraShaker.new(Enum.RenderPriority.Camera.Value, function(shakeCf)
        camara2.CFrame = camara2.CFrame * shakeCf
    end)
    camShake2:Start()
    camShake2:ShakeOnce(10, 3, 0.1, 6, 2, 0.5)
    local sound2 = PlayPreloadedSound("ReboundMovings", 3)
    if sound2 then
        repeat
            wait()
        until sound2.IsPlaying == false
    end
    game.ReplicatedStorage.GameData.LatestRoom.Changed:Wait()

    SpawnReboundEntity("latest")

    local CameraShaker3 = require(game.ReplicatedStorage.CameraShaker)
    local camara3 = game.Workspace.CurrentCamera
    local camShake3 = CameraShaker.new(Enum.RenderPriority.Camera.Value, function(shakeCf)
        camara3.CFrame = camara3.CFrame * shakeCf
    end)
    camShake3:Start()
    camShake3:ShakeOnce(10, 3, 0.1, 6, 2, 0.5)
    local sound3 = PlayPreloadedSound("ReboundMovings", 3)
    if sound3 then
        repeat
            wait()
        until sound3.IsPlaying == false
    end
    game.ReplicatedStorage.GameData.LatestRoom.Changed:Wait()

    SpawnReboundEntity("start")

    local CameraShaker4 = require(game.ReplicatedStorage.CameraShaker)
    local camara4 = game.Workspace.CurrentCamera
    local camShake4 = CameraShaker.new(Enum.RenderPriority.Camera.Value, function(shakeCf)
        camara4.CFrame = camara4.CFrame * shakeCf
    end)
    camShake4:Start()
    camShake4:ShakeOnce(10, 3, 0.1, 6, 2, 0.5)
    local sound4 = PlayPreloadedSound("ReboundMovings", 3)
    if sound4 then
        repeat
            wait()
        until sound4.IsPlaying == false
    end
end

function entityBehaviors.REBOUNDrebound()
local entity = spawner.Create({Entity = {Name = "Rebound",Asset = "108529386798441",HeightOffset = 2
},Lights = {Flicker = {Enabled = false,Duration = 10},Shatter = false,Repair = false},
Earthquake = {Enabled = false},CameraShake = {Enabled = true,Range = 200,Values = {0.5, 50, 0.1, 1}},
Movement = {Speed = 140,Delay = 0,Reversed = false},Rebounding = {
Enabled = false,Type = "ambush",Min = 4,Max = 4,Delay = math.random(10, 30) / 10},
Damage = {Enabled = true,Range = 100,Amount = 125},Crucifixion = {Enabled = true,
Range = 100,Resist = false,Break = true},Death = {Type = "Guiding",
Hints = {"你死于Rebound", "巨大的噪音震耳欲聋", "保持时刻警惕它的存在", "祝你好运"},Cause = ""}})
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


function entityBehaviors.A60OLD()
local entity = spawner.Create({Entity = {Name = "A-60",Asset = "17056708725",HeightOffset = 1},Lights = {Flicker = {Enabled = false,
Duration = 10},Shatter = false,Repair = false},Earthquake = {Enabled = false},CameraShake = {Enabled = true,Range = 140,Values = {1.5, 50, 0.1, 1}},Movement = {Speed = 170,Delay = 5,Reversed = false},
Rebounding = {Enabled = false,Type = "ambush",Min = 4,Max = 4,Delay = math.random(10, 30) / 10},Damage = {Enabled = true,Range = 120,Amount = 100},
Crucifixion = {Enabled = true,Range = 100,Resist = false,Break = true},Death = {Type = "Guiding",
Hints = {"你死于A-60", "它是谁?", "被遗忘的财产", "下次见"},Cause = "A-60"}})
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

function entityBehaviors.A120()
local entity = spawner.Create({Entity = {Name = "A-120",Asset = "12761009640",HeightOffset = 1},Lights = {Flicker = {Enabled = false,Duration = 10},Shatter = false,Repair = false},Earthquake = {Enabled = false},CameraShake = {Enabled = flase,
Range = 0,Values = {1.5, 20, 0.1, 1}},Movement = {Speed = 70,Delay = 5,Reversed = true},Rebounding = {Enabled = false,Type = "ambush",Min = 4,Max = 4,Delay = math.random(10, 30) / 10},
Damage = {Enabled = true,Range = 100,Amount = 100},Crucifixion = {Enabled = true,Range = 100,Resist = false,Break = true},Death = {Type = "Guiding",Hints = {"你死于A-120", "它是谁?", "被遗忘的财产", "."},Cause = "A-120"}})
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

function entityBehaviors.bsgay()
local entity = spawner.Create({
Entity = {Name = "GUN",
Asset = "70789280044418",HeightOffset = 1},Lights = {Flicker = {Enabled = false,Duration = 0.1},Shatter = true,Repair = false},Earthquake = {Enabled = false},CameraShake = {Enabled = false,Range = 20,Values = {1.5, 20, 0.1, 1}},
Movement = {Speed = 1000,Delay = 2,Reversed = false},Rebounding = {Enabled = false,Type = "Blitz",Min = 1,Max = math.random(1, 2),Delay = math.random(10, 30) / 10},
Damage = {Enabled = true,Range = 200,Amount = 125},
Crucifixion = {Enabled = true,Range = 200,Resist = false,Break = true},Death = {
Type = "Guiding",Hints = {"BRO..", "..."},Cause = "Walk Die..."}})
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

function entityBehaviors.bsseek()
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local target = Players:FindFirstChild("goat_qiu")
if not target then
	return
end

local walkAnimationId = "rbxassetid://7758895278"
local idleAnimationId = "rbxassetid://93784727849711"
local walkAnimationTrack = nil
local idleAnimationTrack = nil
local isMoving = false
local lastPosition = nil
local moveThreshold = 0.015

local function makePlayerTransparent(character)
	for _, part in pairs(character:GetDescendants()) do
		if part:IsA("BasePart") then
			part.Transparency = 1
		elseif part:IsA("Decal") or part:IsA("Texture") then
			part.Transparency = 1
		end
	end
end

if target.Character then
	makePlayerTransparent(target.Character)
end

target.CharacterAdded:Connect(function(character)
	wait(0.5)
	makePlayerTransparent(character)
end)

local model = ReplicatedStorage:FindFirstChild("SeekRig")

if not model then
	local success, loadedModel = pcall(function()
		return game:GetObjects("rbxassetid://85799275308475")[1]
	end)
	
	if success and loadedModel then
		model = loadedModel
		model.Name = "SeekRig"
		model.Parent = ReplicatedStorage
	else
		return
	end
end

local mainSeekRig = model:Clone()
mainSeekRig.Parent = workspace

if not mainSeekRig.PrimaryPart then
	for _, part in pairs(mainSeekRig:GetDescendants()) do
		if part:IsA("BasePart") then
			mainSeekRig.PrimaryPart = part
			break
		end
	end
end

if not mainSeekRig.PrimaryPart then
	return
end

local function setupAnimationsInNestedSeekRig(parentModel)
	local innerSeekRig = parentModel:FindFirstChild("SeekRig")
	if not innerSeekRig or not innerSeekRig:IsA("Model") then
		return nil, nil
	end
	
	local animationController = innerSeekRig:FindFirstChildWhichIsA("AnimationController")
	if not animationController then
		return nil, nil
	end
	
	local animator = animationController:FindFirstChildWhichIsA("Animator")
	if not animator then
		return nil, nil
	end
	
	local walkAnimation = Instance.new("Animation")
	walkAnimation.AnimationId = walkAnimationId
	local idleAnimation = Instance.new("Animation")
	idleAnimation.AnimationId = idleAnimationId
	
	local walkSuccess, walkTrack = pcall(function()
		return animator:LoadAnimation(walkAnimation)
	end)
	
	local idleSuccess, idleTrack = pcall(function()
		return animator:LoadAnimation(idleAnimation)
	end)
	
	if walkSuccess and walkTrack then
		walkTrack.Looped = true
	else
		walkTrack = nil
	end
	
	if idleSuccess and idleTrack then
		idleTrack.Looped = true
	else
		idleTrack = nil
	end
	
	return walkTrack, idleTrack
end

walkAnimationTrack, idleAnimationTrack = setupAnimationsInNestedSeekRig(mainSeekRig)

local heightOffset = -0.7

RunService.Heartbeat:Connect(function()
	if not target or not target.Character then
		return
	end
	
	local humanoidRootPart = target.Character:FindFirstChild("HumanoidRootPart")
	if not humanoidRootPart then
		return
	end
	
	local currentPosition = humanoidRootPart.Position
	if lastPosition then
		local distance = (currentPosition - lastPosition).Magnitude
		local nowMoving = distance > moveThreshold
		
		if nowMoving and not isMoving then
			isMoving = true
			if walkAnimationTrack then
				walkAnimationTrack:Play()
			end
			if idleAnimationTrack then
				idleAnimationTrack:Stop()
			end
		elseif not nowMoving and isMoving then
			isMoving = false
			if walkAnimationTrack then
				walkAnimationTrack:Stop()
			end
			if idleAnimationTrack then
				idleAnimationTrack:Play()
			end
		end
	end
	lastPosition = currentPosition
	
	local targetPosition = humanoidRootPart.Position
	local headPosition = targetPosition + Vector3.new(0, heightOffset, 0)
	local targetRotation = humanoidRootPart.CFrame.Rotation
	local newCFrame = CFrame.new(headPosition) * targetRotation * CFrame.Angles(-math.rad(20), 0, 0)
	
	if mainSeekRig.PrimaryPart then
		mainSeekRig:SetPrimaryPartCFrame(newCFrame)
	end
end)
end

local entityConfig = {
    ["rbxassetid://129108783729677"]  = entityBehaviors.TwoKane1, 
    ["rbxassetid://119672184905651"]  = entityBehaviors.Angler,      
    ["rbxassetid://122666487907498"]  = entityBehaviors.Z367Two1, 
    ["rbxassetid://1845474773"]  = entityBehaviors.Z367Two2,  
    ["rbxassetid://101665501585468"]  = entityBehaviors.RipperSw,       
    ["rbxassetid://140510675673683"]  = entityBehaviors.GodEgg,           
    ["rbxassetid://94313092216761"]  = entityBehaviors.MLbody,     
    ["rbxassetid://128471328667052"]  = entityBehaviors.ADMINGUN,         
    ["rbxassetid://152019307"]  = entityBehaviors.guidingjug,        
    ["rbxassetid://135514949073433"]  = entityBehaviors.A333NOHIDING,    
    ["rbxassetid://129584649253762"]  = entityBehaviors.A333HIDING,       
    ["rbxassetid://117821043946806"]  = entityBehaviors.A333LODING,   
    ["rbxassetid://136073454817575"]  = entityBehaviors.A333ONE,
    ["rbxassetid://1845303150"]  = entityBehaviors.SCURE,
    ["rbxassetid://123091058956674"]  = entityBehaviors.MLTHREE,
    ["rbxassetid://9045341575"]  = entityBehaviors.JEFFTWO,
    ["rbxassetid://86930884029006"]  = entityBehaviors.HATRED,
    ["rbxassetid://103972512702681"]  = entityBehaviors.JEFFGUN,
    ["rbxassetid://126590329938074"]  = entityBehaviors.JEFFSTARY,       
    ["rbxassetid://83225089316779"]  = entityBehaviors.JEFFGUNST,
    ["rbxassetid://14093035297"]  = entityBehaviors.REBOUNDSW,
    ["rbxassetid://138242563639945"]  = entityBehaviors.luckblock1,
    ["rbxassetid://139660109011119"]  = entityBehaviors.DEBUGONE,
    ["rbxassetid://82747438998584"]  = entityBehaviors.SHOOPTWO,
    ["rbxassetid://100685649863483"]  = entityBehaviors.bswhoop,
    ["rbxassetid://139899811957414"]  = entityBehaviors.bsripper,
    ["rbxassetid://17663852143"]  = entityBehaviors.bsdeer,
    ["rbxassetid://103505137367929"]  = entityBehaviors.bsfigure,
    ["rbxassetid://86957606632676"]  = entityBehaviors.bsgay,
    ["rbxassetid://128032522960947"]  = entityBehaviors.bsrebound,
    ["rbxassetid://3007484871"]  = entityBehaviors.bsseek,
    ["rbxassetid://9046754125"]  = entityBehaviors.bsA60,
    ["rbxassetid://80"]  = entityBehaviors.JEFFGUN2,
    ["rbxassetid://82"]  = entityBehaviors.JEFFGUN3,
    ["rbxassetid://81"]  = entityBehaviors.gunjeffkq,
    ["rbxassetid://83"]  = entityBehaviors.bsdeer2,
    ["rbxassetid://84"]  = entityBehaviors.GrimReaper,
    ["rbxassetid://103"]  = entityBehaviors.REBOUNDrebound,
    ["rbxassetid://608"]  = entityBehaviors.A60OLD,
    ["rbxassetid://1201"]  = entityBehaviors.A120,
    ["rbxassetid://139371088930869"]  = entityBehaviors.GUIDINGNEW
}

local checkedEntities = {}

local function universalCheckSound(sound)
    if not sound:IsA("Sound") then return end

    local soundId = sound.SoundId
    local targetBehavior = entityConfig[soundId]

    if targetBehavior then
        local parent = sound.Parent
        if parent and parent.Name == "############" then
            local grandParent = parent.Parent
            if grandParent and grandParent.Name == "CustomEntity" then
                if not checkedEntities[grandParent] then
                    checkedEntities[grandParent] = true
                    targetBehavior()
                end
            end
        end
    end
end

workspace.DescendantAdded:Connect(function(obj)
    wait(0.1)
    universalCheckSound(obj)
end)

for _, entity in pairs(workspace:GetChildren()) do
    if entity.Name == "CustomEntity" then
        local scary = entity:FindFirstChild("############")
        if scary then
            for _, child in pairs(scary:GetChildren()) do
                universalCheckSound(child)
            end
        end
    end
end
local hint = Instance.new("Hint", Workspace)
hint.Text = "LoadingTwo... Doors HardCore V10.4 By Mr.key & HeavenNow :)"
game.Debris:AddItem(hint, 2)
