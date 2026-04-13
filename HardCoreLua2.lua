loadstring(game:HttpGet("https://github.com/Zero0Star/RipperNewSound/blob/master/Sprint.lua?raw=true"))()
-----------
local checkedEntities = {}
local listeningSounds = {}
local function runEvent()
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

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://129108783729677" then
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
-----------
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
    local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()
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

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://119672184905651" then
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
-------------
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
    local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()
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

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://122666487907498" then
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
----------
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
    local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()
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
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://1845474773" then
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
-----------
local checkedEntities = {}
local listeningSounds = {}
local function runEvent()
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
    
    local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()
    local entity = spawner.Create({
        Entity = {
            Name = "Ripper",
            Asset = "90276221585032",
            HeightOffset = 6},Lights = {Flicker = {Enabled = false,Duration = 10},Shatter = false,Repair = false},Earthquake = {Enabled = false},
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
        if entityModel then
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
end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://101665501585468" then
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
-----------ML
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
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

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://94313092216761" then
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
-----------admin gun
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
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

-- 查找Misc文件夹中的Handle
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

-- 隐藏Misc Handle
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

-- 恢复Misc Handle
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

-- 清理Misc Handle
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

-- 监控并处理所有GoldGun音效
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

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://128471328667052" then
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
-----------GL
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
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

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://152019307" then
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
--------GODOF1
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
    for _, model in pairs(workspace.CurrentRooms:GetDescendants()) do
    if model.Name == "DropCeiling" and model.Parent and model.Parent.Name == "Parts" then
        model:Destroy()
    end
end

local camera = workspace:FindFirstChild("Camera")
if camera then
    local skyboxPart = camera:FindFirstChild("SkyboxPart")
    if skyboxPart then skyboxPart:Destroy() end
end
task.wait(4)
require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("You are not God....",true)
task.wait(1)
require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).remind("But your soul is ultimately my feast", true)
wait(1)
local Lighting = game:GetService("Lighting")
local Sky = Lighting:FindFirstChildOfClass("Sky") or Instance.new("Sky", Lighting)

Sky.SkyboxBk = "rbxassetid://15983968922"
Sky.SkyboxDn = "rbxassetid://15983966825"
Sky.SkyboxFt = "rbxassetid://15983965025"
Sky.SkyboxLf = "rbxassetid://15983967420"
Sky.SkyboxRt = "rbxassetid://15983966246"
Sky.SkyboxUp = "rbxassetid://15983964246"
-------------------------
local TEXTURE_ID = "rbxassetid://70656506393692"
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BossTextureUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local texture = Instance.new("ImageLabel")
texture.Name = "BossTexture"
texture.Image = TEXTURE_ID
texture.BackgroundTransparency = 1
texture.Size = UDim2.fromOffset(900, 500) 
texture.ScaleType = Enum.ScaleType.Stretch
texture.Position = UDim2.new(0.5, 0, 0, -220)  
texture.AnchorPoint = Vector2.new(0.5, 0)
texture.Visible = true
texture.Parent = screenGui
local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()
local entity = spawner.Create({
	Entity = {
		Name = "dfsa",
		Asset = "70789280044418",
		HeightOffset = 10
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
		Range = 1500,
		Values = {0.5, 20, 0.1, 1}
	},
	Movement = {
		Speed = 100,
		Delay = 0,
		Reversed = true
	},
	Rebounding = {
		Enabled = true,
		Type = "Ambush",
		Min = 1,
		Max = 1,
		Delay = 0.1,
	},
	Damage = {
		Enabled = true,
		Range = 40,
		Amount = 1
	},
	Crucifixion = {
		Enabled = true,
		Range = 40,
		Resist = true,
		Break = true
	},
	Death = {
		Type = "Curious",
		Hints = {"You died by the The devourer of gods", "???", "Wait, who is this guy?","I’m not clear about his background, but anyway, you must be careful.","See you..."},
		Cause = ""
	},
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

local s = LoadCustomInstance(82138419401558, workspace)
if not s then
    warn("Failed to load Frost entity.")
    return
end

local entity = s:FindFirstChildWhichIsA("BasePart")
entity.CFrame = GetRoom():WaitForChild("RoomEntrance").CFrame * CFrame.new(15, 100, 15)
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
wait(5)
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
local s = LoadCustomInstance(86700013599003, workspace)
if not s then
    return
end

local entity = s:FindFirstChildWhichIsA("BasePart")
entity.CFrame = GetRoom():WaitForChild("RoomEntrance").CFrame * CFrame.new(1, 0, 1)
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
DestroyWithDelay()
end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://140612367685491" then
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
----GODOF2
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

local s = LoadCustomInstance(86700013599003, workspace)
if not s then
    return
end

local entity = s:FindFirstChildWhichIsA("BasePart")
entity.CFrame = GetRoom():WaitForChild("RoomEntrance").CFrame * CFrame.new(1, 0, 1)
end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://140537774926087" then
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
---------GOD3
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
    local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()
local function makeEntity(asset)
    local e = spawner.Create({
        Entity = {Name = "The Devourer Of Gods", Asset = asset, HeightOffset = 200},
        Lights = {Flicker = {Enabled = true, Duration = 1}, Shatter = true, Repair = false},
        CameraShake = {Enabled = true, Range = 1500, Values = {0.5, 20, 0.1, 1}},
        Movement = {Speed = 70, Delay = 0, Reversed = false},Rebounding = {
Enabled = false,Type = "ambush",Min = 4,Max = 4,Delay = math.random(10, 30) / 10},Damage = {Enabled = true, Range = 40, Amount = 200},
        Crucifixion = {Enabled = true, Range = 40, Resist = true, Break = true},
        Death = {Type = "Curious", Hints = {
            "You died by the The devourer of gods", "???", "Wait, who is this guy?",
            "I’m not clear about his background, but anyway, you must be careful.", "See you..."
        }}
    })
    
    e:SetCallback("OnRebounding", function(s)
        local m = e.Model.Main
        local a1, a2 = m.Attachment, m.AttachmentSwitch
        for _, c in a1:GetChildren() do c.Enabled = not s end
        for _, c in a2:GetChildren() do c.Enabled = s end
        local spd = s and 0.35 or 0.25
        m.Footsteps.PlaybackSpeed = spd
        m.PlaySound.PlaybackSpeed = s and 0.25 or 0.16
        (s and m.Switch or m.SwitchBack):Play()
    end)
    
    return e
end

-- 创建17个实体，每个间隔0.08秒
local assets = {
    "104227777289979",    -- 第1个
    "140679368116066",   -- 第2-16个
    "140679368116066",
    "140679368116066",
    "140679368116066",
    "140679368116066",
    "140679368116066",
    "140679368116066",
    "140679368116066",
    "140679368116066",
    "140679368116066",
    "140679368116066",
    "140679368116066",
    "140679368116066",
    "140679368116066",
    "140679368116066",
    "104227777289979" 
}

for i = 1, 17 do
    spawn(function()
        local entity = makeEntity(assets[i])
        entity:Run()
    end)
    
    if i < 17 then
        wait(0.5)
    end
end
end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://140311790133562" then
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
------------god4
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
    local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()
local entity = spawner.Create({
	Entity = {
		Name = "The Devourer Of Gods",
		Asset = "74255725774689",
		HeightOffset = 10},Lights = {Flicker = {Enabled = true,Duration = 1},Shatter = true,Repair = false},Earthquake = {Enabled = false},
	    CameraShake = {Enabled = true,Range = 1500,Values = {0.5, 20, 0.1, 1}},Movement = {Speed = 500,Delay = 0,Reversed = false},Rebounding = {Enabled = false,Type = "Blitz",Min = 1,Max = math.random(1, 2),Delay = math.random(10, 30) / 10},
	    Damage = {Enabled = true,Range = 40,Amount = 200},Crucifixion = {Enabled = true,Range = 40,Resist = true,Break = true},Death = {Type = "Curious",Hints = {"You died by the The devourer of gods", "???", "Wait, who is this guy?","I’m not clear about his background, but anyway, you must be careful.","See you..."},Cause = ""},})
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
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://140083448239444" then
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
---------333 NOHIDING
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
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

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://135514949073433" then
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
-----333 HIDING
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
    require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("躲藏!", true)
wait(0.5)
local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()
local entity = spawner.Create({Entity = {Name = "A-333",Asset = "93292275397844",HeightOffset = 0},
Lights = {Flicker = {Enabled = false,Duration = 10},Shatter = false,Repair = false},Earthquake = {Enabled = false},
Enabled = true,Range = 30,Values = {1, 50, 0.1, 1},Movement = {Speed = 1000,Delay = 0.5,Reversed = true},Rebounding = {
Enabled = false,Type = "ambush",Min = 4,Max = 4,Delay = math.random(10, 30) / 10},Damage = {Enabled = true,Range = 100,Amount = 150},
Crucifixion = {Enabled = true,Range = 100,Resist = false,Break = true}, Death = {Type = "Guiding",Hints = {"你死于A-333", "根据他说的执意来做", "需要你拥有极强的反应所以最好带上十字架..", "祝你好运!"},Cause = ""}})
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
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://129584649253762" then
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
----333loading
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
    require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("Loading...", true)
end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://117821043946806" then
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
----------333
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
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

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://136073454817575" then
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
-----s
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
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

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://1845303150" then
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
-----------ML
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
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
        sound.Volume = 2
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
    mainGame.caption("Some people always think they can control the overall situation.", true)
    wait(10)
    mainGame.caption("Are you kidding me?", true)
    wait(10)
    mainGame.caption("You will regret the things you have done", true)
    wait(10)
    mainGame.caption("At least for now....", true)
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

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://123091058956674" then
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
-----JEFF
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
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

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://9045341575" then
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
-----------JEFF
local checkedEntities = {}
local listeningSounds = {}
local function runEvent()
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

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://103972512702681" then
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
----------JEFF STAR
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
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

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://126590329938074" then
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
-----JEFF GUN
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
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

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://83225089316779" then
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
----Rebound
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
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
end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://14093035297" then
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
----------ggggl
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
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

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://139371088930869" then
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
--------ANM
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
    local achievementGiver = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Custom%20Achievements/Source.lua"))()
achievementGiver({
Title = "Torn Apart",
Desc = "被撕成碎片.",
Reason = "成功幸存于开膛手.",
Image = "rbxassetid://12231244908"
})
end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://140585136431105" then
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
-----------REAN
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
    local achievementGiver = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Custom%20Achievements/Source.lua"))()
achievementGiver({
Title = "Out of many Rebound",
Desc = "它还会回来吗?",
Reason = "成功幸存于反弹.",
Image = "rbxassetid://11759928678"
})
end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://137097894782334" then
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
----------
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
    local achievementGiver = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Custom%20Achievements/Source.lua"))()
achievementGiver({
Title = "Mouth Close Ear Open",
Desc = "我听到了什么??",
Reason = "成功幸存于寂静.",
Image = "rbxassetid://101950034142799"
})
end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://128462216922227" then
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
-------------
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
    local achievementGiver = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Custom%20Achievements/Source.lua"))()
achievementGiver({
Title = "Why are you running?",
Desc = "这很不让人理解...不不不...",
Reason = "成功幸存于鹿神.",
Image = "rbxassetid://11395249132"
})
end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://123590946605210" then
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
-----------
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
    local achievementGiver = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Custom%20Achievements/Source.lua"))()
achievementGiver({
Title = "A Great Clamity Is Approaching",
Desc = "我想知道它一直这么疯狂吗?",
Reason = "成功幸存于A-60.",
Image = "rbxassetid://132714224363069"
})
end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://120300179122784" then
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
----------
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
    local achievementGiver = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Custom%20Achievements/Source.lua"))()
achievementGiver({
Title = "From pressure",
Desc = "等等,他该出现在这里吗?",
Reason = "成功幸存于Z-367.",
Image = "rbxassetid://78666140831420"
})
end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://87305819765843" then
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
------------
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
    local achievementGiver = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Custom%20Achievements/Source.lua"))()
achievementGiver({
Title = "Winter arrives",
Desc = "我想我该多加件外套?",
Reason = "成功幸存于冻霜.",
Image = "rbxassetid://11949062415"
})
end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://104494720137050" then
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
------------
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
    local achievementGiver = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Custom%20Achievements/Source.lua"))()
achievementGiver({
Title = "Super crazy!",
Desc = "它真是疯了...",
Reason = "成功幸存于复仇杰夫杀手.",
Image = "rbxassetid://668614178"
})
end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://91855870334213" then
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
--------------
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
    local achievementGiver = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Custom%20Achievements/Source.lua"))()
achievementGiver({
Title = "Hide and Seek",
Desc = "看不见我..看不见我..",
Reason = "成功幸存于那个眼睛.",
Image = "rbxassetid://123386445373745"
})
end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://91358358405366" then
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
--------bomb
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
    local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local REPLACEMENT_CONFIG = {
    ["compass"] = {assetId = 111123143736711}
}
local CHECK_INTERVAL = 0.3
local trackedTargets = {}

local OFFSET_LEFT = Vector3.new(-10, 0, 0)
local OFFSET_UP = Vector3.new(0, 5, 0)
local TOTAL_OFFSET = OFFSET_LEFT + OFFSET_UP

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

local function hideCompassParts(compass)
    if not compass or not compass.Parent then return end
    
    local function hideRecursive(obj)
        if obj:IsA("MeshPart") or obj:IsA("BasePart") then
            if not trackedTargets[compass] then
                trackedTargets[compass] = {originalParts = {}}
            end
            trackedTargets[compass].originalParts[obj] = {transparency = obj.Transparency}
            obj.Transparency = 1
        end
        
        if obj:IsA("ParticleEmitter") or obj:IsA("Beam") or obj:IsA("Trail") then
            if not trackedTargets[compass] then
                trackedTargets[compass] = {originalParts = {}}
            end
            trackedTargets[compass].originalParts[obj] = {enabled = obj.Enabled}
            obj.Enabled = false
        end
        
        if obj:IsA("Texture") or obj:IsA("Decal") or obj:IsA("SurfaceAppearance") then
            if not trackedTargets[compass] then
                trackedTargets[compass] = {originalParts = {}}
            end
            trackedTargets[compass].originalParts[obj] = {transparency = obj.Transparency}
            obj.Transparency = 1
        end
        
        for _, child in ipairs(obj:GetChildren()) do
            hideRecursive(child)
        end
    end
    
    hideRecursive(compass)
end
local function restoreCompass(compass)
    local data = trackedTargets[compass]
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
    
    effectModel.Name = "Compass_Follower"
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
        local offsetCFrame = targetCFrame + TOTAL_OFFSET
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

    local offsetCFrame = targetCFrame + TOTAL_OFFSET
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
    
    hideCompassParts(target)
    
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
        restoreCompass(target)
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

local function findAllCompasses()
    local targets = {}
    
    local function findCompassesRecursive(parent)
        for _, child in ipairs(parent:GetChildren()) do
            if child.Name:lower() == "compass" then
                local config = getItemConfig(child.Name)
                if config then
                    table.insert(targets, {target = child, config = config})
                end
            end
            findCompassesRecursive(child)
        end
    end
    
    findCompassesRecursive(workspace)
    return targets
end

local function startDetection()
    local lastCheckTime = 0
    
    while true do
        local currentTime = tick()
        
        if currentTime - lastCheckTime >= CHECK_INTERVAL then
            lastCheckTime = currentTime
            
            cleanupDestroyedTargets()
            
            local allCompasses = findAllCompasses()
            
            for _, targetData in ipairs(allCompasses) do
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

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://83742851388096" then
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
--------
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
local soundService = game:GetService("SoundService")
local workspace = game.Workspace
local players = game:GetService("Players")
local tweenService = game:GetService("TweenService")
local runService = game:GetService("RunService")

local firstSound = Instance.new("Sound")
firstSound.SoundId = "rbxassetid://139207403536718"
firstSound.Volume = 3
firstSound.Parent = workspace

local playCount = 0
local screenGuis = {}

local function createWhiteScreenEffect(player)
    if not player then return nil, nil end
    
    local playerGui = player:FindFirstChild("PlayerGui")
    if not playerGui then
        player.CharacterAdded:Wait()
        playerGui = player:WaitForChild("PlayerGui")
    end
    
    local oldGui = playerGui:FindFirstChild("WhiteScreenEffect")
    if oldGui then
        oldGui:Destroy()
    end
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "WhiteScreenEffect"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.IgnoreGuiInset = true
    
    local whiteFrame = Instance.new("Frame")
    whiteFrame.Name = "WhiteOverlay"
    whiteFrame.Size = UDim2.new(1, 0, 1, 0)
    whiteFrame.Position = UDim2.new(0, 0, 0, 0)
    whiteFrame.BackgroundColor3 = Color3.new(1, 1, 1)
    whiteFrame.BackgroundTransparency = 1
    whiteFrame.BorderSizePixel = 0
    whiteFrame.ZIndex = 999
    
    whiteFrame.Parent = screenGui
    screenGui.Parent = playerGui
    
    screenGuis[player] = {screenGui = screenGui, whiteFrame = whiteFrame}
    
    return screenGui, whiteFrame
end

local function playWhiteScreenEffect()
    for _, player in ipairs(players:GetPlayers()) do
        coroutine.wrap(function()
            local screenGui, whiteFrame = createWhiteScreenEffect(player)
            if not screenGui or not whiteFrame then return end
            
            local fadeInInfo = TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
            local fadeInGoal = {BackgroundTransparency = 0}
            local fadeInTween = tweenService:Create(whiteFrame, fadeInInfo, fadeInGoal)
            
            local fadeOutInfo = TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
            local fadeOutGoal = {BackgroundTransparency = 1}
            local fadeOutTween = tweenService:Create(whiteFrame, fadeOutInfo, fadeOutGoal)
            
            fadeInTween:Play()
            fadeInTween.Completed:Wait()
            
            wait(4)
            
            fadeOutTween:Play()
            fadeOutTween.Completed:Wait()
            
            if screenGui and screenGui.Parent then
                screenGui:Destroy()
            end
            screenGuis[player] = nil
        end)()
    end
end

local function changeAllPartsToBlack()
    for _, item in ipairs(workspace:GetDescendants()) do
        if item:IsA("BasePart") and item.Name ~= "Floor" then
            item.Anchored = false
            item.BrickColor = BrickColor.new("Really black")
            item.Color = Color3.new(0, 0, 0)
            
            local surfaceAppearance = item:FindFirstChildOfClass("SurfaceAppearance")
            if surfaceAppearance then
                surfaceAppearance:Destroy()
            end
        end
        
        if item:IsA("Model") then
            for _, part in ipairs(item:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "Floor" then
                    part.Anchored = false
                    part.BrickColor = BrickColor.new("Really black")
                    part.Color = Color3.new(0, 0, 0)
                    
                    local surfaceAppearance = part:FindFirstChildOfClass("SurfaceAppearance")
                    if surfaceAppearance then
                        surfaceAppearance:Destroy()
                    end
                end
            end
        end
    end
end

local function startCameraShake()
    local SHAKE_INTENSITY = 50
    local SHAKE_DURATION = 10
    local SHAKE_SPEED = 70
    
    for _, player in ipairs(players:GetPlayers()) do
        coroutine.wrap(function()
            if not player then return end
            
            local camera = workspace.CurrentCamera
            local startTime = tick()
            local originalPosition = camera.CFrame.Position
            local connection
            
            connection = runService.RenderStepped:Connect(function()
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
                    if connection then
                        connection:Disconnect()
                    end
                end
            end)
        end)()
    end
end

firstSound.Ended:Connect(function()
    playCount = playCount + 1
    
    if playCount >= 3 then
        local secondSound = Instance.new("Sound")
        secondSound.SoundId = "rbxassetid://132158324987663"
        secondSound.Volume = 10
        secondSound.Parent = workspace
        
        playWhiteScreenEffect()
        startCameraShake()
        
        wait(0.05)
        secondSound:Play()
        
        secondSound.Ended:Connect(function()
            changeAllPartsToBlack()
            secondSound:Destroy()
        end)
        
        firstSound:Destroy()
    else
        wait(0.1)
        firstSound:Play()
    end
end)

firstSound:Play()

players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        if firstSound and firstSound.Parent then
            firstSound:Destroy()
        end
    end)
    
    if screenGuis[player] then
        screenGuis[player].screenGui:Destroy()
        screenGuis[player] = nil
    end
end)

players.PlayerRemoving:Connect(function(player)
    if screenGuis[player] then
        screenGuis[player].screenGui:Destroy()
        screenGuis[player] = nil
    end
end)

for _, player in ipairs(players:GetPlayers()) do
    if not screenGuis[player] then
        screenGuis[player] = nil
    end
end
end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://8307248039" then
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
----------
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

local s = LoadCustomInstance(106818719931200, workspace)
if not s then
    return
end

local entity = s:FindFirstChildWhichIsA("BasePart")
entity.CFrame = GetRoom():WaitForChild("RoomEntrance").CFrame * CFrame.new(0, 7, -15)
entity.Part.CFrame = entity.CFrame
end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://109690961059477" then
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
-----
local hint = Instance.new("Hint", Workspace)
hint.Text = "LoadingTwo... Doors HardCore V9.8 By Mr.key & HeavenNow :)"
game.Debris:AddItem(hint, 10)