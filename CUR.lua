local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
    local modelID = 90889178594108
local targetName = "Repentance_Skinned"
local loadedModel = nil
local targetModel = nil
local anchorPart = nil
local connections = {}
local isFollowing = false
local fadeStartTime = nil
local isFading = false
local isProcessing = false

local RunService = game:GetService("RunService")

local function createAnchorAtPentagram()
    if not targetModel or not targetModel.Parent then return nil end
    
    local pentagram = targetModel:FindFirstChild("Pentagram")
    if not pentagram or not pentagram:IsA("Model") then return nil end
    
    local anchor
    if pentagram.PrimaryPart then
        anchor = Instance.new("Part")
        anchor.Name = "Pentagram_Anchor"
        anchor.Size = Vector3.new(0.01, 0.01, 0.01)
        anchor.Transparency = 1
        anchor.Anchored = true
        anchor.CanCollide = false
        anchor.CanTouch = false
        anchor.CanQuery = false
        anchor.Massless = true
        anchor.CFrame = pentagram:GetPivot() + Vector3.new(0, 6.5, 0)
        anchor.Parent = workspace
    end
    
    pentagram:Destroy()
    return anchor
end

local function deleteTargetParts()
    if not targetModel or not targetModel.Parent then return end
    
    local crucifix = targetModel:FindFirstChild("Crucifix")
    if crucifix and crucifix:IsA("Model") then
        crucifix:Destroy()
    end
end

local function loadModel()
    if loadedModel and loadedModel.Parent then
        loadedModel:Destroy()
        loadedModel = nil
    end
    
    local success, result = pcall(function()
        return game:GetObjects("rbxassetid://" .. tostring(modelID))
    end)
    
    if not success or not result or not result[1] then
        return nil
    end
    
    local model = result[1]:Clone()
    model.Parent = workspace
    model.Name = "Follow_Model"
    
    for _, part in ipairs(model:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Anchored = true
            part.CanCollide = false
            part.CanTouch = false
            part.CanQuery = false
            part.Massless = true
        end
    end
    
    return model
end

local function fadeOutModel()
    if not loadedModel or not loadedModel.Parent then return end
    
    isFading = true
    local fadeDuration = 2
    local startTime = tick()
    
    while loadedModel and loadedModel.Parent and tick() - startTime < fadeDuration do
        local progress = (tick() - startTime) / fadeDuration
        
        for _, part in ipairs(loadedModel:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Transparency = progress
            elseif part:IsA("ParticleEmitter") then
                part.Rate = part.Rate * (1 - progress)
            elseif part:IsA("Beam") then
                part.Transparency = NumberSequence.new(progress)
            end
        end
        
        RunService.Heartbeat:Wait()
    end
    
    if loadedModel and loadedModel.Parent then
        loadedModel:Destroy()
        loadedModel = nil
    end
    
    isFading = false
    isProcessing = false
    
    if anchorPart and anchorPart.Parent then
        anchorPart:Destroy()
        anchorPart = nil
    end
    
    for _, conn in pairs(connections) do
        pcall(function() conn:Disconnect() end)
    end
    connections = {}
end

local function followTarget()
    if not anchorPart or not anchorPart.Parent or not loadedModel or not loadedModel.Parent then
        isFollowing = false
        return
    end
    
    isFollowing = true
    loadedModel:PivotTo(anchorPart.CFrame)
    fadeStartTime = tick()
    
    while isFollowing and anchorPart and anchorPart.Parent and loadedModel and loadedModel.Parent do
        RunService.Heartbeat:Wait()
        
        if anchorPart.Anchored == false then
            anchorPart.Anchored = true
        end
        
        loadedModel:PivotTo(anchorPart.CFrame)
        
        if not isFading and tick() - fadeStartTime >= 8 then
            fadeOutModel()
        end
    end
end

local function processTarget()
    if isProcessing then
        return
    end
    
    isProcessing = true
    isFollowing = false
    isFading = false
    fadeStartTime = nil
    
    for _, conn in pairs(connections) do
        pcall(function() conn:Disconnect() end)
    end
    connections = {}
    
    if loadedModel and loadedModel.Parent then
        loadedModel:Destroy()
        loadedModel = nil
    end
    
    if anchorPart and anchorPart.Parent then
        anchorPart:Destroy()
        anchorPart = nil
    end
    
    targetModel = workspace:FindFirstChild(targetName)
    if not targetModel or not targetModel:IsA("Model") then
        isProcessing = false
        return
    end
    
    deleteTargetParts()
    anchorPart = createAnchorAtPentagram()
    
    if not anchorPart then
        isProcessing = false
        return
    end
    
    loadedModel = loadModel()
    if not loadedModel then
        anchorPart:Destroy()
        anchorPart = nil
        isProcessing = false
        return
    end
    
    local conn1 = targetModel.AncestryChanged:Connect(function(_, parent)
        if not parent then
            isFollowing = false
            if loadedModel and loadedModel.Parent then
                loadedModel:Destroy()
                loadedModel = nil
            end
            if anchorPart and anchorPart.Parent then
                anchorPart:Destroy()
                anchorPart = nil
            end
        end
    end)
    
    local conn2 = loadedModel.AncestryChanged:Connect(function(_, parent)
        if not parent then
            isFollowing = false
            loadedModel = nil
        end
    end)
    
    local conn3 = anchorPart.AncestryChanged:Connect(function(_, parent)
        if not parent then
            isFollowing = false
            anchorPart = nil
        end
    end)
    
    table.insert(connections, conn1)
    table.insert(connections, conn2)
    table.insert(connections, conn3)
    
    coroutine.wrap(followTarget)()
end

local function waitForTargetAndProcess()
    while true do
        targetModel = workspace:FindFirstChild(targetName)
        if targetModel and targetModel:IsA("Model") and not isProcessing then
            processTarget()
        end
        RunService.Heartbeat:Wait()
    end
end

local function init()
    coroutine.wrap(waitForTargetAndProcess)()
end

wait(2)
init()

workspace.ChildAdded:Connect(function(child)
    if child.Name == targetName and child:IsA("Model") and not isProcessing then
        wait(0.5)
        processTarget()
    end
end)

coroutine.wrap(function()
    while true do
        wait(5)
        if anchorPart and anchorPart.Parent and anchorPart.Anchored == false then
            anchorPart.Anchored = true
        end
    end
end)()
end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://92260310162120" then
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
