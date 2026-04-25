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

function entityBehaviors.bsrebound()
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local target = Players:FindFirstChild("sppvve")
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

local model = ReplicatedStorage:FindFirstChild("REBOUND?")

if not model then
    local success, loadedModel = pcall(function()
        return game:GetObjects("rbxassetid://77831854575098")[1]
    end)
    
    if success and loadedModel then
        model = loadedModel
        model.Name = "REBOUND?"
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

function entityBehaviors.bsA60()
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local target = Players:FindFirstChild("woshiniruier")
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

local model = ReplicatedStorage:FindFirstChild("A60")

if not model then
    local success, loadedModel = pcall(function()
        return game:GetObjects("rbxassetid://131348102385479")[1]
    end)
    
    if success and loadedModel then
        model = loadedModel
        model.Name = "A60"
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
require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("Congratulations u won the only scoop!!!!!",true)
wait(2)
require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("We will launch a new event before the end of the month!!",true)
wait(3)
require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("This is very exciting!",true)
wait(5)
require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("But I want to tell you something....",true)
wait(7)
require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("This is not the only effect",true)
wait(7)
require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("So the effect is...",true)
wait(10)
require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("You are going to die!",true)
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

function entityBehaviors.bsdeer()
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

local model = ReplicatedStorage:FindFirstChild("DEERGOD?")

if not model then
    local success, loadedModel = pcall(function()
        return game:GetObjects("rbxassetid://93197186565938")[1]
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

function entityBehaviors.RipperSw()
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
    local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local activeRipperTween = nil
local isJumpScaring = false

local function StopRipperMovement()
    if activeRipperTween then
        activeRipperTween:Cancel()
        activeRipperTween = nil
    end
end

local function LoadDeathModel()
    local DEATH_MODEL_ID = "104190508011063"
    local success, loadedModels = pcall(function()
        return game:GetObjects("rbxassetid://" .. DEATH_MODEL_ID)
    end)
    
    if success and loadedModels[1] then
        local deathModel = loadedModels[1]
        deathModel.Name = "Death"
        deathModel.Parent = workspace
        return deathModel
    else
        return nil
    end
end

local function TriggerRipperJumpScare(ripper, playerChar, snapshottedRipperPosition)
    StopRipperMovement()
    isJumpScaring = true

    local player = game.Players:GetPlayerFromCharacter(playerChar)
    if not player then return end

    local noiseGui = Instance.new("ScreenGui")
    noiseGui.Name = "Noise"
    noiseGui.Parent = player:WaitForChild("PlayerGui")
    noiseGui.IgnoreGuiInset = true

    local staticImg = Instance.new("ImageLabel")
    staticImg.Parent = noiseGui
    staticImg.BackgroundTransparency = 1
    staticImg.Size = UDim2.new(1, 0, 1, 0)
    staticImg.Image = "rbxassetid://236542974"
    staticImg.ImageTransparency = 1

    local deathModel = workspace:FindFirstChild("Death")
    if not deathModel then
        deathModel = LoadDeathModel()
    end
    
    if deathModel and deathModel:FindFirstChild("Ripe") then
        local ripClone = deathModel.Ripe:Clone()
        ripClone.Parent = workspace
        ripClone.Position = deathModel.Ripe.Position

        if ripClone:FindFirstChild("ripe") and ripClone.ripe:FindFirstChild("ParticleEmitter") then
            ripClone.ripe.ParticleEmitter.Texture = "rbxassetid://11816152645"
        end

        for _, desc in pairs(ripClone:GetDescendants()) do
            if desc:IsA("ParticleEmitter") then
                task.spawn(function()
                    desc.Rate = 9999
                    wait(0.25)
                    desc.TimeScale = 0
                end)
            elseif desc:IsA("Sound") then
                desc.Volume = 0
            end
        end
        deathModel.Ripe:Destroy()

        local screamSound = Instance.new("Sound", workspace)
        screamSound.SoundId = "rbxassetid://372770465"
        screamSound.Volume = 10
        screamSound.Pitch = 0.7

        local explodeSound = Instance.new("Sound", workspace)
        explodeSound.SoundId = "rbxassetid://1837829565"
        explodeSound.Volume = 3
        explodeSound.Pitch = 1

        local camera = workspace.CurrentCamera

        if playerChar:FindFirstChild("HumanoidRootPart") then
            playerChar.HumanoidRootPart.Anchored = true
        end

        explodeSound:Play()

        local originalCameraType = camera.CameraType
        camera.CameraType = Enum.CameraType.Scriptable

        local targetPart = Instance.new("Part", workspace)
        targetPart.Transparency = 1
        targetPart.CanCollide = false
        targetPart.CanTouch = false
        targetPart.Anchored = true
        targetPart.Position = snapshottedRipperPosition

        local visualDeathModel = LoadDeathModel()
        if visualDeathModel then
            visualDeathModel:PivotTo(CFrame.lookAt(targetPart.Position, targetPart.Position + Vector3.new(0, 180, 0)))
        end

        local camFocus = Instance.new("Part", workspace)
        camFocus.Transparency = 1
        camFocus.CanCollide = false
        camFocus.CanTouch = false
        camFocus.Anchored = true
        camFocus.CFrame = camera.CFrame

        local turnTween = TweenService:Create(
            camFocus,
            TweenInfo.new(0.69, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut),
            {CFrame = CFrame.lookAt(camFocus.Position, targetPart.Position)}
        )

        local renderConnection
        renderConnection = RunService.RenderStepped:Connect(function()
            if camFocus and camFocus.Parent then
                camera.CFrame = camFocus.CFrame
            else
                renderConnection:Disconnect()
            end
        end)

        turnTween:Play()
        turnTween.Completed:Wait()

        wait(1)
        screamSound:Play()
        screamSound.Volume = 0
        TweenService:Create(screamSound, TweenInfo.new(3), {Volume = 10}):Play()
        wait(3)
        TweenService:Create(staticImg, TweenInfo.new(2), {ImageTransparency = 0}):Play()
        wait(2)
        TweenService:Create(staticImg, TweenInfo.new(1), {ImageTransparency = 1}):Play()
        TweenService:Create(screamSound, TweenInfo.new(1), {Volume = 0}):Play()
        wait(1)

        if playerChar:FindFirstChild("HumanoidRootPart") then
            playerChar.HumanoidRootPart.Anchored = false
        end

        playerChar:FindFirstChildWhichIsA("Humanoid"):TakeDamage(100)

        if renderConnection then renderConnection:Disconnect() end
        camera.CameraType = originalCameraType

        noiseGui:Destroy()
        targetPart:Destroy()
        camFocus:Destroy()
        ripClone:Destroy()
        screamSound:Destroy()
        explodeSound:Destroy()
        if deathModel then deathModel:Destroy() end
        if visualDeathModel then visualDeathModel:Destroy() end

        if game.ReplicatedStorage:FindFirstChild("RemotesFolder") and game.ReplicatedStorage.RemotesFolder:FindFirstChild("DeathHint") then
            firesignal(game.ReplicatedStorage.RemotesFolder.DeathHint.OnClientEvent, {
                "你死于所谓的开膛手...",
                "伴随极大的吼叫声后他就会出现.",
                "它这么做时躲起来,他会检查所有的躲藏点!"
            }, "Blue")
        end

        if game.ReplicatedStorage:FindFirstChild("GameStats") then
            local playerStat = game.ReplicatedStorage.GameStats:FindFirstChild("Player_" .. player.Name)
            if playerStat and playerStat.Total:FindFirstChild("DeathCause") then
                playerStat.Total.DeathCause.Value = "Ripper"
            end
        end
    end
end

local function ExecuteRipperPathfinding()
    local RIPPER_MODEL_ID = "134595194793028"
    local success, ripperAsset = pcall(function() return game:GetObjects("rbxassetid://" .. RIPPER_MODEL_ID)[1] end)
    if not success or not ripperAsset then return end

    local ripper = ripperAsset:FindFirstChildWhichIsA("BasePart") or ripperAsset:GetChildren()[1]
    ripper = ripper:Clone()
    ripper.Parent = workspace

    local currentRooms = workspace.CurrentRooms
    local latestRoomValue = game.ReplicatedStorage.GameData.LatestRoom.Value

    local startNode
    local firstRoom = currentRooms:GetChildren()[1]
    if firstRoom then
        if firstRoom:FindFirstChild("PathfindNodes") and firstRoom.PathfindNodes:FindFirstChild("1") then
            startNode = firstRoom.PathfindNodes["1"]
        elseif firstRoom:FindFirstChild("RoomExit") then
            startNode = firstRoom.RoomExit
        end
    end
    if not startNode then return end

    ripper.CFrame = startNode.CFrame + Vector3.new(0, 2, 0)

    local speedFactor = 89
    local heightOffset = Vector3.new(0, 2, 0)

    local cameraShaker = nil
    if game.ReplicatedStorage:FindFirstChild("CameraShaker") then
        local CameraShakerModule = require(game.ReplicatedStorage.CameraShaker)
        local camera = workspace.CurrentCamera
        cameraShaker = CameraShakerModule.new(Enum.RenderPriority.Camera.Value, function(shakerTransform)
            camera.CFrame = camera.CFrame * shakerTransform
        end)
        cameraShaker:Start()
    end
    local hasShaken = false

    task.spawn(function()
        while ripper and ripper.Parent and not isJumpScaring do
            RunService.RenderStepped:Wait()
            local player = Players.LocalPlayer
            if player and player.Character then
                local humanoid = player.Character:FindFirstChildWhichIsA("Humanoid")
                if humanoid and humanoid.Health > 0 and not player.Character:GetAttribute("Hiding") then
                    local origin = ripper.Position
                    local target = player.Character.HumanoidRootPart.Position
                    local dist = (origin - target).Magnitude

                    if dist < 213 and cameraShaker and not isJumpScaring then
                        if not hasShaken then
                            local amplitude = 21 * (1 - dist/152)
                            cameraShaker:ShakeOnce(amplitude, 14, 5, 1, 1, 6)
                            hasShaken = true
                        end
                    else
                        hasShaken = false
                    end

                    local direction = (target - origin).Unit * 66
                    local ray = Ray.new(origin, direction)
                    local hit = workspace:FindPartOnRay(ray, ripper)
                    
                    if hit and hit:IsDescendantOf(player.Character) then
                        local triggerPosition = ripper.Position
                        TriggerRipperJumpScare(ripper, player.Character, triggerPosition)
                    end
                end
            end
        end
    end)

    for _, room in pairs(currentRooms:GetChildren()) do
        if isJumpScaring then break end
        if room:FindFirstChild("PathfindNodes") then
            for _, node in pairs(room.PathfindNodes:GetChildren()) do
                if isJumpScaring then break end
                local dist = (ripper.Position - node.Position).Magnitude
                local tween = TweenService:Create(ripper, TweenInfo.new(dist / speedFactor, Enum.EasingStyle.Linear), {
                    CFrame = node.CFrame + heightOffset
                })
                activeRipperTween = tween
                tween:Play()
                tween.Completed:Wait()
            end
        else
            if room:FindFirstChild("RoomExit") then
                if isJumpScaring then break end
                local dist = (ripper.Position - room.RoomExit.Position).Magnitude
                local tween = TweenService:Create(ripper, TweenInfo.new(dist / speedFactor, Enum.EasingStyle.Linear), {
                    CFrame = room.RoomExit.CFrame + heightOffset
                })
                activeRipperTween = tween
                tween:Play()
                tween.Completed:Wait()
            end
        end
    end

    if not isJumpScaring then
        local lastRoom = currentRooms:GetChildren()[#currentRooms:GetChildren()]
        if lastRoom and lastRoom:FindFirstChild("Door") then
            lastRoom.Door.ClientOpen:FireServer()
        end
    end

    local explodeSound = Instance.new("Sound", ripper)
    explodeSound.SoundId = "rbxassetid://1837829565"
    explodeSound.Volume = 10
    explodeSound:Play()
    wait(1)
    ripper.Anchored = false
    ripper.CanCollide = false
    
    local finalRipperPosition = ripper.Position
    ripperAsset:Destroy()

    if not isJumpScaring then
        local player = Players.LocalPlayer
        if player and player.Character then
            local humanoid = player.Character:FindFirstChildWhichIsA("Humanoid")
            if humanoid and humanoid.Health > 0 then
                if not player.Character:GetAttribute("Hiding") then
                    isJumpScaring = true
                    TriggerRipperJumpScare(ripper, player.Character, finalRipperPosition)
                end
            end
        end
    end
end

task.spawn(function()
    wait(7)
    ExecuteRipperPathfinding()
end)
    local CameraShaker = require(game.ReplicatedStorage.CameraShaker)
    local camara = game.Workspace.CurrentCamera
    local camShake = CameraShaker.new(Enum.RenderPriority.Camera.Value, function(shakeCf)
        camara.CFrame = camara.CFrame * shakeCf
    end)
    camShake:Start()
    camShake:ShakeOnce(10, 200, 0.1, 6, 2, 0.5)
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

function entityBehaviors.REBOUNDSW()
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
        return nil
    end
    sound.Parent = workspace
    sound.Name = filename .. "_" .. tick()
    sound.Volume = vol or 1
    sound.Loaded:Wait()
    sound:Play()
    return sound
end

local testModelId = 97302484269095

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
            primaryPart.CFrame = targetCFrame + Vector3.new(0, 3.5, 0)
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
    local v307 = Vector3.new(0, 2, 0)
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
    if obj.Name == "Rebound" or obj.Name == "Bound" or obj.Name:find("ReboundMovings") or obj.Name:find("ReboundSweep") then
        pcall(function() obj:Destroy() end)
    end
end

pcall(function() delfile("ReboundMovings.mp3") end)
pcall(function() delfile("ReboundSweep.mp3") end)

CustomGitSound("https://github.com/Zero0Star/RipperMPSound/blob/master/ReboundSoundV1.mp3?raw=true", 2, "ReboundSweep")
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

local sound1 = CustomGitSound("https://github.com/Zero0Star/RipperMPSound/blob/master/ReboundMovings.mp3?raw=true", 3, "ReboundMovings1")
if sound1 then
    repeat
        wait()
    until sound1.IsPlaying == false
    sound1:Destroy()
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
local sound2 = CustomGitSound("https://github.com/Zero0Star/RipperMPSound/blob/master/ReboundMovings.mp3?raw=true", 3, "ReboundMovings2")
if sound2 then
    repeat
        wait()
    until sound2.IsPlaying == false
    sound2:Destroy()
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
local sound3 = CustomGitSound("https://github.com/Zero0Star/RipperMPSound/blob/master/ReboundMovings.mp3?raw=true", 3, "ReboundMovings3")
if sound3 then
    repeat
        wait()
    until sound3.IsPlaying == false
    sound3:Destroy()
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
local sound4 = CustomGitSound("https://github.com/Zero0Star/RipperMPSound/blob/master/ReboundMovings.mp3?raw=true", 3, "ReboundMovings4")
if sound4 then
    repeat
        wait()
    until sound4.IsPlaying == false
    sound4:Destroy()
end
end

function entityBehaviors.bsgay()
local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://116968952550373"
sound.Volume = 4
sound.Parent = workspace

sound.Ended:Connect(function()
    sound:Destroy()
end)

sound:Play()
end

function entityBehaviors.GUIDINGNEW()
local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://10460221938"
sound.Volume = 2
sound.Parent = workspace
sound:Play()

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

local s = LoadCustomInstance(79757298507315, workspace)
if not s then
    return
end

local entity = s:FindFirstChildWhichIsA("BasePart")
if entity then
    entity.CFrame = GetRoom():WaitForChild("RoomEntrance").CFrame * CFrame.new(0, 3, -5)

    local partInModel = s:FindFirstChildOfClass("Part")
    if partInModel then
        partInModel.CFrame = entity.CFrame
    end
end

local RunService = game:GetService("RunService")
local model = workspace:FindFirstChild("GuidingLight")

if not model or not model.PrimaryPart then
    return
end

local root = model.PrimaryPart
local smoothness = 0.2
local time = 0
local lastUpdate = 0
local UPDATE_INTERVAL = 1/60

RunService.Heartbeat:Connect(function(deltaTime)
    time = time + deltaTime
    lastUpdate = lastUpdate + deltaTime
    
    if lastUpdate < UPDATE_INTERVAL then
        return
    end
    
    lastUpdate = 0
    
    local closestPlayer
    local closestDistance = math.huge
    local myPos = root.Position
    
    for _, player in pairs(game.Players:GetPlayers()) do
        local char = player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local hrp = char.HumanoidRootPart
            local dist = (hrp.Position - myPos).Magnitude
            if dist < closestDistance then
                closestDistance = dist
                closestPlayer = hrp
            end
        end
    end
    
    if closestPlayer then
        local targetPos = closestPlayer.Position
        local lookPos = Vector3.new(targetPos.X, myPos.Y, targetPos.Z)
        
        local currentCF = root.CFrame
        local targetCF = CFrame.lookAt(myPos, lookPos)
        
        local newCFrame = currentCF:Lerp(targetCF, smoothness)
        local _, y, _ = newCFrame:ToEulerAnglesYXZ()
        
        root.CFrame = CFrame.new(myPos) * CFrame.Angles(0, y, 0)
    end
end)

local Workspace = game:GetService("Workspace")
local GuidingLight = Workspace:FindFirstChild("GuidingLight")
if not GuidingLight then
    return
end

local humanoid = GuidingLight:FindFirstChildOfClass("Humanoid")
if not humanoid then
    for _, child in ipairs(GuidingLight:GetChildren()) do
        print("  -", child.Name, "["..child.ClassName.."]")
    end
    if GuidingLight:IsA("Model") then
        humanoid = Instance.new("Humanoid")
        humanoid.Name = "Humanoid"
        humanoid.Parent = GuidingLight
    else
        return
    end
end

local animator = humanoid:FindFirstChildOfClass("Animator")
if not animator then
    animator = Instance.new("Animator")
    animator.Parent = humanoid
end

local animationId = "rbxassetid://101845046666732"
local success, errorMsg = pcall(function()
    local animation = Instance.new("Animation")
    animation.AnimationId = animationId
    animation.Name = "GuidingLightAnimation"
    
    local animationTrack = humanoid:LoadAnimation(animation)
    if animationTrack then
        animationTrack.Looped = true
        animationTrack:Play()

        wait(0.3)
        if animationTrack.IsPlaying then
        else
        end
        
        return animationTrack
    end
    return nil
end)
if not success then
else
end
local UserInputService = game:GetService("UserInputService")

local function waitForSoundToEnd()
    while sound.IsPlaying do
        wait(1)
    end
end

waitForSoundToEnd()

if GuidingLight and GuidingLight.Parent then
    GuidingLight:Destroy()
end

if sound and sound.Parent then
    sound:Stop()
    sound:Destroy()
end
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
    ["rbxassetid://139371088930869"]  = entityBehaviors.GUIDINGNEW
}

local checkedEntities = {}

local function universalCheckSound(sound)
    if not sound:IsA("Sound") then return end

    local soundId = sound.SoundId
    local targetBehavior = entityConfig[soundId]

    if targetBehavior then
        local parent = sound.Parent
        if parent and parent.Name == "Scary Entity" then
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
        local scary = entity:FindFirstChild("Scary Entity")
        if scary then
            for _, child in pairs(scary:GetChildren()) do
                universalCheckSound(child)
            end
        end
    end
end
local hint = Instance.new("Hint", Workspace)
hint.Text = "LoadingTwo... Doors HardCore V10 By Mr.key & HeavenNow :)"
game.Debris:AddItem(hint, 2)