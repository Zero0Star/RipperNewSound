if workspace:FindFirstChild("HardcoreTwo") then
    return
end
local marker = Instance.new("BoolValue")
marker.Name = "HardcoreTwo"
marker.Value = true
marker.Parent = workspace

local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()
local entityBehaviors = {}
function entityBehaviors.SA90()
local MainUI = game:GetObjects("rbxassetid://95819908379371")[1]
MainUI.Parent = game.Players.LocalPlayer.PlayerGui
local plr = game.Players.LocalPlayer
local arg1 = game.Workspace.CurrentCamera
local Jumpscare_A90 = MainUI.Jumpscare.Jumpscare_A90
Jumpscare_A90.BackgroundTransparency = 1
Jumpscare_A90.Face.Visible = true
Jumpscare_A90.FaceAngry.Visible = false
Jumpscare_A90.Static.Visible = true
Jumpscare_A90.Static2.Visible = true
Jumpscare_A90.Static.ImageTransparency = 1
Jumpscare_A90.Static2.ImageTransparency = 1
Jumpscare_A90.Face.Image = "rbxassetid://12635832722"
Jumpscare_A90.FaceAngry.Image = "rbxassetid://12635955412"

Jumpscare_A90.Face.ImageColor3 = Color3.new(0, 0, 0)
Jumpscare_A90.Face.Position = UDim2.new(math.random(10, 90) / 100, 0, math.random(10, 90) / 100, 0)
Jumpscare_A90.Visible = true
local isMoving = false
game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Modules.A90.Spawn:Play()
task.wait(0.03333333333333333)
Jumpscare_A90.Face.ImageColor3 = Color3.new(1, 1, 1)
task.wait(0.22)
Jumpscare_A90.BackgroundTransparency = 0
Jumpscare_A90.Face.Position = UDim2.new(0.5, 0, 0.49, 0)
task.wait(0.03333333333333333)
Jumpscare_A90.StopIcon.Visible = true
Jumpscare_A90.BackgroundColor3 = Color3.new(0, 0, 0)
Jumpscare_A90.BackgroundTransparency = 1
Jumpscare_A90.Static.ImageTransparency = 0.8
Jumpscare_A90.Static2.ImageTransparency = 0.8
local isActive = true
local LookVector = arg1.CFrame.LookVector
task.delay(0.2, function()
	Jumpscare_A90.StopIcon.Visible = false
	while isActive do
		task.wait(0.03333333333333333)
		Jumpscare_A90.Static.Position = UDim2.new(math.random(0, 100) / 100, 0, math.random(0, 100) / 100, 0)
		Jumpscare_A90.Static.Rotation = math.random(0, 1) * 180
		Jumpscare_A90.Static2.Position = UDim2.new(math.random(0, 100) / 100, 0, math.random(0, 100) / 100, 0)
		Jumpscare_A90.Static2.Rotation = math.random(0, 1) * 180
		Jumpscare_A90.Face.Position = UDim2.new(0.5, 0, 0.49, math.random(-1, 1))
		Jumpscare_A90.FaceAngry.Position = UDim2.new(0.5 + math.random(-100, 100) / 50000, 0, 0.49 + math.random(-100, 100) / 30000, math.random(-1, 1))
		local randint = math.random(0, 1)
		Jumpscare_A90.FaceAngry.ImageColor3 = Color3.new(1, randint, randint)
		if not isMoving then
			if 0.4 < (LookVector - arg1.CFrame.LookVector).Magnitude then
				isMoving = true
			end
			if 0.4 < plr.Character.Humanoid.MoveDirection.Magnitude then
				isMoving = true
			end
		end
	end
end)

task.wait(0.2)
Jumpscare_A90.BackgroundColor3 = Color3.new(0, 0, 0)
Jumpscare_A90.BackgroundTransparency = 0
Jumpscare_A90.Static.ImageTransparency = 0
Jumpscare_A90.Static2.ImageTransparency = 0.5
task.wait(0.03333333333333333)
Jumpscare_A90.Face.ImageColor3 = Color3.new(1, 0, 0)
task.wait(0.03333333333333333)
Jumpscare_A90.Visible = false
task.wait(0.08)
if isMoving then
	Jumpscare_A90.Visible = true
	game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Modules.A90.Hit:Play()
	task.wait(0.03333333333333333)
	Jumpscare_A90.Face.ImageColor3 = Color3.new(1, 1, 1)
	task.wait(0.03333333333333333)
	Jumpscare_A90.BackgroundTransparency = 0
	Jumpscare_A90.Static.ImageTransparency = 0
	Jumpscare_A90.Static2.ImageTransparency = 0.5
	task.wait(0.06666666666666667)
	Jumpscare_A90.FaceAngry.ImageColor3 = Color3.new(1, 0, 0)
	Jumpscare_A90.FaceAngry.Visible = true
	task.wait(0.06666666666666667)
	Jumpscare_A90.FaceAngry.ImageColor3 = Color3.new(1, 1, 1)
	Jumpscare_A90.Face.Visible = false
	Jumpscare_A90.FaceAngry.Size = UDim2.new(0.8, 0, 0.8, 0)
	task.wait(0.75)
	plr.Character.Humanoid.Health -= 60
	local function TriggerDeathHint(DeathMessages, DeathCauseString)
		spawn(function()
			for _ = 1, 50 do
				game:GetService("ReplicatedStorage").GameStats["Player_" .. game.Players.LocalPlayer.Name].Total.DeathCause.Value = DeathCauseString
				firesignal(game:GetService("ReplicatedStorage").RemotesFolder.DeathHint.OnClientEvent, DeathMessages, "Yellow")
				wait()
			end
		end)
	end

	TriggerDeathHint({
		"嗯,又死了,你死于所谓的 Super A-90",
		"我读取到了他的意念,或许它很喜欢跟你玩木头人类",
		"总之,你总有一天会适应它的存在的"
	}, "Super A-90")
	
	task.wait(0.1)
	Jumpscare_A90.FaceAngry.Visible = false
	Jumpscare_A90.BackgroundColor3 = Color3.new(1, 1, 1)
	Jumpscare_A90.Static.ImageTransparency = 1
	Jumpscare_A90.Static2.ImageTransparency = 1
	task.wait(0.06666666666666667)
	Jumpscare_A90.BackgroundColor3 = Color3.new(1, 0, 0)
	task.wait(0.06666666666666667)
	Jumpscare_A90.BackgroundColor3 = Color3.new(0, 0, 0)
	task.wait(0.06666666666666667)
else
	game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Modules.A90.Spawn:Stop()
	Jumpscare_A90.BackgroundTransparency = 1
end
isActive = false
Jumpscare_A90.Visible = false
wait(2)
MainUI:Destroy()
end
function entityBehaviors.WH1T3()
local entity = spawner.Create({Entity = {Name = "WH1T3",
Asset = "91653443213214",HeightOffset = 5},Lights = {Flicker = {Enabled = false,Duration = 10},Shatter = false,Repair = false},Earthquake = {Enabled = false},CameraShake = {Enabled = false,Range = 200,Values = {1.5, 20, 0.1, 1}},
Movement = {Speed = 800,Delay = 5,Reversed = false},Rebounding = {Enabled = true,Type = "ambush",Min = 4,Max = 4,Delay = math.random(10, 30) / 10},Damage = {Enabled = true,Range = 100,Amount = 125},Crucifixion = {
Enabled = true,Range = 100,Resist = false,Break = true},Death = {Type = "Guiding",Hints = {"你死于WH1T3", "听取周围的声音", "观察它的规律", "反复进柜子躲避它"},Cause = "WH1T3"}})
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

function entityBehaviors.TUMA()
local function Damage(Amount)
    local Players = game:GetService("Players")
    local Player = Players.LocalPlayer
    local Character = Player.Character or Player.CharacterAdded:Wait()
    local Humanoid = Character:WaitForChild("Humanoid")
    local DamageAmount = (Amount / 100) * Humanoid.MaxHealth
    local NewHealth = Humanoid.Health - DamageAmount
    if NewHealth <= 0 then
        Player:SetAttribute("Alive", false)
        replicatesignal(Player.Kill)
    else
        Humanoid.Health = NewHealth
    end
end

local function LoadCustomInstance(source)
    local model
    if tonumber(source) then
        local success, result = pcall(function()
            return game:GetObjects("rbxassetid://" .. tostring(source))[1]
        end)
        if success and result then
            model = result
        end
    end
    if model then
        model.Parent = workspace
        for _, obj in ipairs(model:GetDescendants()) do
            if obj:IsA("Script") or obj:IsA("LocalScript") then
                obj:Destroy()
            end
        end
    end
    return model
end

local function MainExecution()
    local player = game.Players.LocalPlayer
    local character = player.Character
    if not character then
        character = player.CharacterAdded:Wait()
    end
    local humanoid = character:FindFirstChildWhichIsA("Humanoid")
    if not humanoid or humanoid.Health <= 0 then
        return
    end
    local chasingEntity = LoadCustomInstance(86163085571492)
    if not chasingEntity then
        return
    end
    task.spawn(function()
        wait(30)
        if chasingEntity and chasingEntity.Parent then
            chasingEntity:Destroy()
        end
    end)
    local entityPart
    if chasingEntity:IsA("Model") then
        if chasingEntity.PrimaryPart then
            entityPart = chasingEntity.PrimaryPart
        else
            entityPart = chasingEntity:FindFirstChildWhichIsA("BasePart")
        end
    else
        entityPart = chasingEntity:FindFirstChildWhichIsA("BasePart")
    end
    if not entityPart then
        chasingEntity:Destroy()
        return
    end
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    entityPart.CFrame = humanoidRootPart.CFrame * CFrame.new(0, 0, 40)
    local function ColorEnvironment()
        local player = game.Players.LocalPlayer
        local character = player.Character
        local function IsMonsterPart(part)
            if part:IsA("Model") and (part:GetAttribute("Monster") or part.Name:find("Monster") or part.Name:find("Entity")) then
                return true
            end
            local ancestor = part.Parent
            while ancestor do
                if ancestor:IsA("Model") and (ancestor:GetAttribute("Monster") or ancestor.Name:find("Monster") or ancestor.Name:find("Entity")) then
                    return true
                end
                ancestor = ancestor.Parent
            end
            return false
        end
        for transparency = 0, 0.8, 0.1 do
            for _, part in pairs(workspace:GetDescendants()) do
                if part:IsA("BasePart") then
                    local isPlayerPart = character and (part:IsDescendantOf(character) or part.Name == "HumanoidRootPart")
                    local isMonster = IsMonsterPart(part)
                    local isSpawnLocation = part:IsA("SpawnLocation") or (part.Parent and part.Parent:IsA("SpawnLocation"))
                    local isChasingEntity = part:IsDescendantOf(chasingEntity)
                    if not isPlayerPart and not isMonster and not isChasingEntity and not part:IsA("Terrain") and not isSpawnLocation then
                        task.spawn(function()
                            local originalColor = part.Color
                            local originalMaterial = part.Material
                            for i = 0, 1, 0.1 do
                                if part and part.Parent then
                                    part.Color = originalColor:Lerp(Color3.fromRGB(255, 105, 180), i)
                                    part.Material = Enum.Material.Neon
                                    part.Transparency = transparency
                                    wait(0.05)
                                end
                            end
                        end)
                    end
                end
            end
            wait(0.5)
        end
    end
    local function TriggerSimpleJumpscare()
        local jumpscareGui = Instance.new("ScreenGui")
        jumpscareGui.Name = "SimpleJumpscare"
        jumpscareGui.Parent = player:WaitForChild("PlayerGui")
        jumpscareGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        local jumpscareImage = Instance.new("ImageLabel")
        jumpscareImage.Name = "JumpscareImage"
        jumpscareImage.Parent = jumpscareGui
        jumpscareImage.BackgroundTransparency = 1
        jumpscareImage.Position = UDim2.new(0.5, 0, 0.5, 0)
        jumpscareImage.AnchorPoint = Vector2.new(0.5, 0.5)
        jumpscareImage.Size = UDim2.new(0.01, 0, 0.01, 0)
        jumpscareImage.Image = "rbxassetid://2142657118"
        jumpscareImage.ImageColor3 = Color3.fromRGB(203, 73, 208)
        jumpscareImage.ImageTransparency = 1
        local killSound = Instance.new("Sound")
        killSound.SoundId = "rbxassetid://139300381946118"
        killSound.Volume = 3
        killSound.Parent = workspace
        local tweenService = game:GetService("TweenService")
        local function ExecuteJumpscareSequence()
            tweenService:Create(jumpscareImage, TweenInfo.new(0.5), {
                ImageTransparency = 0
            }):Play()
            tweenService:Create(jumpscareImage, TweenInfo.new(0.5), {
                Size = UDim2.new(0.8, 0, 0.8, 0),
                Position = UDim2.new(0.5, 0, 0.5, 0)
            }):Play()
            killSound:Play()
            spawn(function()
                wait(0.3)
                local char = player.Character
                if char then
                    local hum = char:FindFirstChildWhichIsA("Humanoid")
                    if hum then
                        hum:TakeDamage(100)
                        if game.ReplicatedStorage.GameStats["Player_" .. player.Name] then
                            game.ReplicatedStorage.GameStats["Player_" .. player.Name].Total.DeathCause.Value = "Threat"
                        end
                        firesignal(game.ReplicatedStorage.RemotesFolder.DeathHint.OnClientEvent, {
                            "你死于Threat...",
                            "威胁如影随形...",
                            "在它看见你之前躲起来..."
                        }, "Blue")
                    end
                end
            end)
            wait(0.5)
            tweenService:Create(jumpscareImage, TweenInfo.new(1), {
                ImageTransparency = 1
            }):Play()
            wait(1)
            killSound:Destroy()
            jumpscareGui:Destroy()
        end
        ExecuteJumpscareSequence()
    end
    local function StartRaycastDamage()
        while true do
            local char = player.Character
            if char then
                local hum = char:FindFirstChildWhichIsA("Humanoid")
                if hum and hum.Health > 0 then
                    local rayOrigin = Vector3.new(
                        math.random(-50, 50),
                        math.random(5, 20),
                        math.random(-50, 50)
                    )
                    local rayDirection = (char.HumanoidRootPart.Position - rayOrigin).Unit * 10
                    local raycastResult = workspace:Raycast(rayOrigin, rayDirection)
                    if raycastResult and raycastResult.Instance:IsDescendantOf(char) then
                        Damage(100)
                        TriggerSimpleJumpscare()
                        if chasingEntity and chasingEntity.Parent then
                            chasingEntity:Destroy()
                        end
                        break
                    end
                end
            end
            wait(0.5)
        end
    end
    local function SetupCollisionDetection()
        if entityPart then
            entityPart.Touched:Connect(function(hit)
                local hitCharacter = hit:FindFirstAncestorWhichIsA("Model")
                if hitCharacter and hitCharacter == character then
                    if not character:GetAttribute("Hiding") then
                        Damage(100)
                        TriggerSimpleJumpscare()
                        if chasingEntity and chasingEntity.Parent then
                            chasingEntity:Destroy()
                        end
                    end
                end
            end)
        end
    end
    local function StartChasing()
        local RunService = game:GetService("RunService")
        local chasingSpeed = 11
        local isChasing = true
        local detectionInterval = 0.5
        local lastDetectionTime = 0
        local chaseConnection
        chaseConnection = RunService.RenderStepped:Connect(function(deltaTime)
            if not isChasing or not chasingEntity or not chasingEntity.Parent then
                if chaseConnection then
                    chaseConnection:Disconnect()
                end
                return
            end
            local currentCharacter = player.Character
            if not currentCharacter then
                if chasingEntity and chasingEntity.Parent then
                    chasingEntity:Destroy()
                end
                isChasing = false
                if chaseConnection then
                    chaseConnection:Disconnect()
                end
                return
            end
            local currentHumanoid = currentCharacter:FindFirstChildWhichIsA("Humanoid")
            if not currentHumanoid or currentHumanoid.Health <= 0 then
                if chasingEntity and chasingEntity.Parent then
                    chasingEntity:Destroy()
                end
                isChasing = false
                if chaseConnection then
                    chaseConnection:Disconnect()
                end
                return
            end
            local target = currentCharacter.HumanoidRootPart
            if not target then
                return
            end
            local direction = (target.Position - entityPart.Position).Unit
            local moveVector = direction * chasingSpeed * deltaTime
            entityPart.Position = entityPart.Position + moveVector
            entityPart.CFrame = CFrame.lookAt(entityPart.Position, target.Position)
            local currentTime = tick()
            if currentTime - lastDetectionTime >= detectionInterval then
                lastDetectionTime = currentTime
                local rayOrigin = entityPart.Position
                local rayDirection = (target.Position - rayOrigin).Unit * 10
                local ray = Ray.new(rayOrigin, rayDirection)
                local hit = workspace:FindPartOnRay(ray, chasingEntity)
                if hit and hit:IsDescendantOf(currentCharacter) and not currentCharacter:GetAttribute("Hiding") then
                    isChasing = false
                    Damage(100)
                    TriggerSimpleJumpscare()
                    if chasingEntity and chasingEntity.Parent then
                        chasingEntity:Destroy()
                    end
                    if chaseConnection then
                        chaseConnection:Disconnect()
                    end
                end
            end
            local distance = (entityPart.Position - target.Position).Magnitude
            if distance < 2 then
                isChasing = false
                Damage(100)
                TriggerSimpleJumpscare()
                if chasingEntity and chasingEntity.Parent then
                    chasingEntity:Destroy()
                end
                if chaseConnection then
                    chaseConnection:Disconnect()
                end
            end
        end)
        return chaseConnection
    end
    local function Cleanup()
        if chasingEntity and chasingEntity.Parent then
            chasingEntity:Destroy()
        end
    end
    game:GetService("Players").PlayerRemoving:Connect(function(leavingPlayer)
        if leavingPlayer == player then
            Cleanup()
        end
    end)
    humanoid.Died:Connect(function()
        Cleanup()
    end)
    SetupCollisionDetection()
    StartChasing()
    task.spawn(StartRaycastDamage)
    task.spawn(function()
        ColorEnvironment()
    end)
end
MainExecution()
end
function entityBehaviors.OSAB()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Camera = workspace.CurrentCamera

local function isPlayerLookingAtEntity(entity)
    local player = Players.LocalPlayer
    local character = player.Character
    if not character then return false end

    local head = character:FindFirstChild("Head")
    if not head then return false end

    local entityPosition
    if entity:IsA("Model") then
        local primary = entity.PrimaryPart or entity:FindFirstChildWhichIsA("BasePart")
        if not primary then return false end
        entityPosition = primary.Position
    else
        entityPosition = entity.Position
    end

    local cameraDirection = Camera.CFrame.LookVector
    local toEntity = (entityPosition - head.Position).Unit

    local dot = cameraDirection:Dot(toEntity)
    return dot > 0.7
end

local damageConnection

local function setParticleTransparency(model, value)
    for _, obj in ipairs(model:GetDescendants()) do
        if obj:IsA("ParticleEmitter") then
            obj.Transparency = NumberSequence.new(value)
        end
    end
end

local function fadeParticles(model, fromValue, toValue, duration)
    local emitters = {}

    for _, obj in ipairs(model:GetDescendants()) do
        if obj:IsA("ParticleEmitter") then
            table.insert(emitters, obj)
            obj.Transparency = NumberSequence.new(fromValue)
        end
    end

    local startTime = tick()

    while tick() - startTime < duration do
        local alpha = (tick() - startTime) / duration
        local value = fromValue + (toValue - fromValue) * alpha

        for _, emitter in ipairs(emitters) do
            emitter.Transparency = NumberSequence.new(value)
        end

        RunService.Heartbeat:Wait()
    end

    for _, emitter in ipairs(emitters) do
        emitter.Transparency = NumberSequence.new(toValue)
    end
end

local function startDamageLoop(entity)
    if damageConnection then
        damageConnection:Disconnect()
    end

    local lastDamageTime = 0

    damageConnection = RunService.Heartbeat:Connect(function(deltaTime)
        if not entity or not entity.Parent then
            damageConnection:Disconnect()
            return
        end

        if not isPlayerLookingAtEntity(entity) then
            lastDamageTime = lastDamageTime + deltaTime

            if lastDamageTime >= 0.5 then
                lastDamageTime = 0

                local Player = Players.LocalPlayer
                local Character = Player.Character or Player.CharacterAdded:Wait()
                local Humanoid = Character:WaitForChild("Humanoid")

                local NewHealth = Humanoid.Health - 10
                Humanoid.Health = NewHealth

                if NewHealth <= 0 then
                    Player:SetAttribute("Alive", false)

                    if game.ReplicatedStorage:FindFirstChild("Kill") then
                        game.ReplicatedStorage.Kill:FireServer(Player)
                    end
                end
            end
        end
    end)
end

function GetRoom()
    return workspace.CurrentRooms:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value)
end

local function LoadCustomInstance(source)
    local model

    if tonumber(source) then
        local success, result = pcall(function()
            return game:GetObjects("rbxassetid://" .. tostring(source))[1]
        end)

        if success and result then
            model = result
        end
    end

    if model then
        model.Parent = workspace

        for _, obj in ipairs(model:GetDescendants()) do
            if obj:IsA("Script") or obj:IsA("LocalScript") then
                obj:Destroy()
            end
        end
    end

    return model
end

local function fadeOutAndDestroy(model)
    fadeParticles(model, 0, 1, 1)

    if model then
        model:Destroy()
    end
end

local s = LoadCustomInstance(124110962492998)

if not s then
    return
end

if s:IsA("Model") then
    if s.PrimaryPart then
        s:SetPrimaryPartCFrame(GetRoom():WaitForChild("RoomEntrance").CFrame * CFrame.new(5, 0.8, -15))
    else
        local primary = s:FindFirstChildWhichIsA("BasePart")

        if primary then
            s.PrimaryPart = primary
            s:SetPrimaryPartCFrame(GetRoom():WaitForChild("RoomEntrance").CFrame * CFrame.new(5, 0.8, -15))
        end
    end
else
    local entity = s:FindFirstChildWhichIsA("BasePart")

    if entity then
        entity.CFrame = GetRoom():WaitForChild("RoomEntrance").CFrame * CFrame.new(5, 0.8, -15)

        if entity:FindFirstChild("Part") then
            entity.Part.CFrame = entity.CFrame
        end
    end
end

local Obsession = s:FindFirstChild("Obsession")

if not Obsession and s.Name == "Obsession" then
    Obsession = s
end

setParticleTransparency(s, 1)

fadeParticles(s, 1, 0, 1)

startDamageLoop(s)

game.ReplicatedStorage.GameData.LatestRoom.Changed:Wait()

if damageConnection then
    damageConnection:Disconnect()
end

fadeOutAndDestroy(s)
end
function entityBehaviors.Hunger()
function GetRoom()
    return workspace.CurrentRooms:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value)
end

local function LoadCustomInstance(source)
    local model
    
    if tonumber(source) then
        local success, result = pcall(function()
            return game:GetObjects("rbxassetid://" .. tostring(source))[1]
        end)
        if success and result then
            model = result
        end
    end
    
    if model then
        model.Parent = workspace
        for _, obj in ipairs(model:GetDescendants()) do
            if obj:IsA("Script") or obj:IsA("LocalScript") then
                obj:Destroy()
            end
        end
    end
    
    return model
end

local s = LoadCustomInstance(138426557790457)
if not s then
    return
end

if s:IsA("Model") then
    if s.PrimaryPart then
        s:SetPrimaryPartCFrame(GetRoom():WaitForChild("RoomEntrance").CFrame * CFrame.new(0, 0.8, -25))
    else
        local primary = s:FindFirstChildWhichIsA("BasePart")
        if primary then
            s.PrimaryPart = primary
            s:SetPrimaryPartCFrame(GetRoom():WaitForChild("RoomEntrance").CFrame * CFrame.new(0, 0.8, -25))
        end
    end
else
    local entity = s:FindFirstChildWhichIsA("BasePart")
    if entity then
        entity.CFrame = GetRoom():WaitForChild("RoomEntrance").CFrame * CFrame.new(0, 0.8, -25)
        if entity:FindFirstChild("Part") then
            entity.Part.CFrame = entity.CFrame
        end
    end
end
local hunger = s:FindFirstChild("Hunger")
if not hunger and s.Name == "Hunger" then
    hunger = s
end

if hunger then
    local rushNew = hunger:FindFirstChild("RushNew")
    if rushNew then
        local attachment = rushNew:FindFirstChild("Attachment")
        if attachment then
            local particle = attachment:FindFirstChild("ParticleEmitter")
            if particle and particle:IsA("ParticleEmitter") then
                particle.Transparency = NumberSequence.new(1)
                wait(12)
                local startTime = tick()
                local fadeDuration = 5
                while tick() - startTime < fadeDuration do
                    local elapsed = tick() - startTime
                    local transparency = math.clamp(1 - (elapsed / fadeDuration), 0, 1)
                    particle.Transparency = NumberSequence.new(transparency)
                    game:GetService("RunService").Heartbeat:Wait()
                end
                particle.Transparency = NumberSequence.new(0)
                require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("I have no strength to run.. I am very hungry", true)
                game.ReplicatedStorage.GameData.LatestRoom.Changed:Wait()
                s:Destroy()
            end
        end
    end
end
end

function entityBehaviors.HIMS()
local entity = spawner.Create({Entity = {Name = "Him",
Asset = "86311109309225",HeightOffset = 0},Lights = {Flicker = {Enabled = false,Duration = 10},Shatter = false,Repair = false},Earthquake = {Enabled = false},CameraShake = {Enabled = false,Range = 200,Values = {1.5, 20, 0.1, 1}},
Movement = {Speed = 300,Delay = 5,Reversed = false},Rebounding = {Enabled = true,Type = "ambush",Min = 4,Max = 4,Delay = math.random(5, 30) / 10},Damage = {Enabled = true,Range = 100,Amount = 125},Crucifixion = {
Enabled = true,Range = 100,Resist = false,Break = true},Death = {Type = "Guiding",Hints = {"你死于Him", "竭力的嘶吼声预告着它要到来", "观察它的规律", "反复进柜子躲避它"},Cause = "Him"}})
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
function entityBehaviors.bkeyes()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Camera = workspace.CurrentCamera

local function isPlayerLookingAtEntity(entity)
    local player = Players.LocalPlayer
    local character = player.Character
    if not character then return false end

    local head = character:FindFirstChild("Head")
    if not head then return false end

    local entityPosition

    if entity:IsA("Model") then
        local primary = entity.PrimaryPart or entity:FindFirstChildWhichIsA("BasePart")
        if not primary then return false end
        entityPosition = primary.Position
    else
        entityPosition = entity.Position
    end

    local cameraDirection = Camera.CFrame.LookVector
    local toEntity = (entityPosition - head.Position).Unit

    local dot = cameraDirection:Dot(toEntity)
    return dot > 0.7
end

local function setParticleTransparency(model, value)
    for _, obj in ipairs(model:GetDescendants()) do
        if obj:IsA("ParticleEmitter") then
            obj.Transparency = NumberSequence.new(value)
        end
    end
end

local function fadeParticles(model, fromValue, toValue, duration)
    local emitters = {}

    for _, obj in ipairs(model:GetDescendants()) do
        if obj:IsA("ParticleEmitter") then
            table.insert(emitters, obj)
        end
    end

    local startTime = tick()

    while tick() - startTime < duration do
        local alpha = (tick() - startTime) / duration
        local value = fromValue + (toValue - fromValue) * alpha

        for _, emitter in ipairs(emitters) do
            emitter.Transparency = NumberSequence.new(value)
        end

        RunService.Heartbeat:Wait()
    end

    for _, emitter in ipairs(emitters) do
        emitter.Transparency = NumberSequence.new(toValue)
    end
end

local damageConnection

local function startDamageLoop(entity)
    if damageConnection then
        damageConnection:Disconnect()
    end

    local lastDamageTime = 0

    damageConnection = RunService.Heartbeat:Connect(function(deltaTime)
        if not entity or not entity.Parent then
            damageConnection:Disconnect()
            return
        end

        if isPlayerLookingAtEntity(entity) then
            lastDamageTime = lastDamageTime + deltaTime

            if lastDamageTime >= 0.05 then
                lastDamageTime = 0

                local Player = Players.LocalPlayer
                local Character = Player.Character or Player.CharacterAdded:Wait()
                local Humanoid = Character:WaitForChild("Humanoid")

                if Humanoid.Health > 0 then
                    local NewHealth = Humanoid.Health - 5

                    if NewHealth <= 0 then
                        Humanoid.Health = 0
                        Player:SetAttribute("Alive", false)

                        if game.ReplicatedStorage:FindFirstChild("Kill") then
                            game.ReplicatedStorage.Kill:FireServer(Player)
                        end
                    else
                        Humanoid.Health = NewHealth
                    end
                end
            end
        end
    end)
end

function GetRoom()
    return workspace.CurrentRooms:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value)
end

local function LoadCustomInstance(source)
    local model

    if tonumber(source) then
        local success, result = pcall(function()
            return game:GetObjects("rbxassetid://" .. tostring(source))[1]
        end)

        if success and result then
            model = result
        end
    end

    if model then
        model.Parent = workspace

        for _, obj in ipairs(model:GetDescendants()) do
            if obj:IsA("Script") or obj:IsA("LocalScript") then
                obj:Destroy()
            end
        end
    end

    return model
end

local s = LoadCustomInstance(130034778193642)

if not s then
    return
end

local targetPart
local currentRoom = GetRoom()

if currentRoom then
    local doorModel = currentRoom:FindFirstChild("Door")

    if doorModel then
        targetPart = doorModel:FindFirstChild("Door")
    end
end

local targetCFrame

if targetPart and targetPart:IsA("BasePart") then
    targetCFrame = targetPart.CFrame
else
    targetCFrame = GetRoom():WaitForChild("RoomEntrance").CFrame
end

if s:IsA("Model") then
    if s.PrimaryPart then
        s:SetPrimaryPartCFrame(targetCFrame * CFrame.new(0, 0, 5))
    else
        local primary = s:FindFirstChildWhichIsA("BasePart")

        if primary then
            s.PrimaryPart = primary
            s:SetPrimaryPartCFrame(targetCFrame * CFrame.new(0, 0, 5))
        end
    end
else
    local entity = s:FindFirstChildWhichIsA("BasePart")

    if entity then
        entity.CFrame = targetCFrame * CFrame.new(0, 0, 5)

        if entity:FindFirstChild("Part") then
            entity.Part.CFrame = entity.CFrame
        end
    end
end

local Brokeneyes = s:FindFirstChild("Broken eyes")

if not Brokeneyes and s.Name == "Broken eyes" then
    Brokeneyes = s
end

setParticleTransparency(s, 1)

fadeParticles(s, 1, 0, 2)

startDamageLoop(s)

game.ReplicatedStorage.GameData.LatestRoom.Changed:Wait()

if damageConnection then
    damageConnection:Disconnect()
end

fadeParticles(s, 0, 1, 2)

s:Destroy()
end
function entityBehaviors.dread()
function GetRoom()
    return workspace.CurrentRooms:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value)
end

local function LoadCustomInstance(source)
    local model
    
    if tonumber(source) then
        local success, result = pcall(function()
            return game:GetObjects("rbxassetid://" .. tostring(source))[1]
        end)
        if success and result then
            model = result
        end
    end
    
    if model then
        model.Parent = workspace
        for _, obj in ipairs(model:GetDescendants()) do
            if obj:IsA("Script") or obj:IsA("LocalScript") then
                obj:Destroy()
            end
        end
    end
    
    return model
end

local function Damage(Amount)
    local Players = game:GetService("Players")

    local Player = Players.LocalPlayer
    local Character = Player.Character or Player.CharacterAdded:Wait()
    local Humanoid = Character:WaitForChild("Humanoid")
    
    local DamageAmount = (Amount / 100) * Humanoid.MaxHealth
    local NewHealth = Humanoid.Health - DamageAmount
    
    if NewHealth <= 0 then
        Player:SetAttribute("Alive", false)
        replicatesignal(Player.Kill)
    else
        Humanoid.Health = NewHealth
    end
end
local s = LoadCustomInstance(128969616828176)
if not s then
    return
end

if s:IsA("Model") then
    if s.PrimaryPart then
        s:SetPrimaryPartCFrame(GetRoom():WaitForChild("RoomEntrance").CFrame * CFrame.new(0, -3.6, -25))
    else
        local primary = s:FindFirstChildWhichIsA("BasePart")
        if primary then
            s.PrimaryPart = primary
            s:SetPrimaryPartCFrame(GetRoom():WaitForChild("RoomEntrance").CFrame * CFrame.new(0, -3.6, -25))
        end
    end
else
    local entity = s:FindFirstChildWhichIsA("BasePart")
    if entity then
        entity.CFrame = GetRoom():WaitForChild("RoomEntrance").CFrame * CFrame.new(0, -3.6, -25)
        if entity:FindFirstChild("Part") then
            entity.Part.CFrame = entity.CFrame
        end
    end
end
local sound1 = Instance.new("Sound")
sound1.SoundId = "rbxassetid://139804031181000"
sound1.Parent = workspace
sound1.Looped = false
sound1.Volume = 1
local soundCount = math.random(3, 10)

for i = 1, soundCount do 
    sound1:Play() 
    sound1.Ended:Wait() 
end
sound1:Destroy()
local sound2 = Instance.new("Sound")
sound2.SoundId = "rbxassetid://137004686137325"
sound2.Parent = workspace
sound2.Looped = false
sound2.Volume = 1
sound2.PlaybackSpeed = 0.8
sound2:Play()
local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")
local image = Instance.new("ImageLabel")
image.Image = "rbxassetid://100734201255797"
image.BackgroundTransparency = 1
image.Size = UDim2.new(1, 0, 1, 0)
image.Position = UDim2.new(0.5, 0, 0.5, 0)
image.AnchorPoint = Vector2.new(0.5, 0.5)
image.Parent = gui
image.ZIndex = 999
image.ScaleType = Enum.ScaleType.Fit
image.BackgroundTransparency = 1
image.ImageTransparency = 1
image.ImageColor3 = Color3.fromRGB(255, 255, 255)
local blur = Instance.new("BlurEffect")
blur.Size = 2
blur.Parent = game:GetService("Lighting")
for i = 0, 1, 0.05 do
    image.ImageTransparency = 1 - (i * 0.1)
    local offsetX = (math.random() - 0.5) * 2
    local offsetY = (math.random() - 0.5) * 2
    image.Position = UDim2.new(0.5, offsetX, 0.5, offsetY)
    
    wait(0.05)
end

image.ImageTransparency = 0.9
image.Position = UDim2.new(0.5, 0, 0.5, 0)
local hasTriggered = false
local startStay = tick()
while tick() - startStay < 2 do
    local offsetX = (math.random() - 0.5) * 2
    local offsetY = (math.random() - 0.5) * 2
    image.Position = UDim2.new(0.5, offsetX, 0.5, offsetY)
    local character = player.Character
    if character then
        local humanoid = character:FindFirstChildWhichIsA("Humanoid")
        if humanoid and humanoid.Health > 0 then
            local isHiding = character:GetAttribute("Hiding")
            if not isHiding and not hasTriggered then
                Damage(100)
                hasTriggered = true

                if game.ReplicatedStorage.GameStats["Player_" .. player.Name] then
                    game.ReplicatedStorage.GameStats["Player_" .. player.Name].Total.DeathCause.Value = "ClockDread"
                end
                
                firesignal(game.ReplicatedStorage.RemotesFolder.DeathHint.OnClientEvent, {
                    "你死于ClockDread...",
                    "时间似乎停止了...",
                    "在钟声响起时，找个地方躲起来..."
                }, "Blue")
            end
        end
    end
    
    wait(0.05)
end

for i = 1, 0, -0.05 do
    image.ImageTransparency = 0.9 + (1 - i) * 0.1

    local offsetX = (math.random() - 1) * 2
    local offsetY = (math.random() - 1) * 2
    image.Position = UDim2.new(0.5, offsetX, 0.5, offsetY)
    
    wait(0.05)
end

image:Destroy()
gui:Destroy()
blur:Destroy()

sound2:Destroy()

task.wait(20)

if s and s.Parent then
    s:Destroy()
end
end
function entityBehaviors.MOVERS()
local MainUI = game:GetObjects("rbxassetid://95819908379371")[1]
MainUI.Parent = game.Players.LocalPlayer.PlayerGui
local plr = game.Players.LocalPlayer
local arg1 = game.Workspace.CurrentCamera
local Jumpscare_Mover = MainUI.Jumpscare.Jumpscare_A90
Jumpscare_Mover.BackgroundTransparency = 1
Jumpscare_Mover.Face.Visible = true
Jumpscare_Mover.FaceAngry.Visible = false
Jumpscare_Mover.Static.Visible = true
Jumpscare_Mover.Static2.Visible = true
Jumpscare_Mover.Static.ImageTransparency = 1
Jumpscare_Mover.Static2.ImageTransparency = 1
Jumpscare_Mover.Face.Image = "rbxassetid://119177305867863"
Jumpscare_Mover.FaceAngry.Image = "rbxassetid://77341058717266"

Jumpscare_Mover.Face.ImageColor3 = Color3.new(0, 0, 0)
Jumpscare_Mover.Face.Position = UDim2.new(0.5, 0, 0.5, 0)
Jumpscare_Mover.Visible = true

Jumpscare_Mover.BackgroundColor3 = Color3.new(0, 0, 0)
Jumpscare_Mover.Static.ImageColor3 = Color3.new(0, 0, 0)
Jumpscare_Mover.Static2.ImageColor3 = Color3.new(0, 0, 0)

local spawnSound = Instance.new("Sound")
spawnSound.SoundId = "rbxassetid://138085276131551"
spawnSound.Volume = 8
spawnSound.Parent = Jumpscare_Mover
spawnSound:Play()

local jumpscareSound = Instance.new("Sound")
jumpscareSound.SoundId = "rbxassetid://139300381946118"
jumpscareSound.Volume = 8
jumpscareSound.Parent = Jumpscare_Mover

local fadeTime = 5
local fadeSteps = 50
local fadeInterval = fadeTime / fadeSteps

for i = 0, 1, 1/fadeSteps do
    Jumpscare_Mover.Face.ImageTransparency = 1 - i
    Jumpscare_Mover.Static.ImageTransparency = 1 - i
    Jumpscare_Mover.Static2.ImageTransparency = 1 - i
    Jumpscare_Mover.BackgroundTransparency = 1 - i
    task.wait(fadeInterval)
end

Jumpscare_Mover.Face.ImageTransparency = 0
Jumpscare_Mover.Static.ImageTransparency = 0.8
Jumpscare_Mover.Static2.ImageTransparency = 0.8
Jumpscare_Mover.BackgroundTransparency = 0
Jumpscare_Mover.Face.ImageColor3 = Color3.new(1, 1, 1)

local isMoving = false
local wasMoving = false
local LookVector = arg1.CFrame.LookVector
local isActive = true
local stopCheckTime = 0
local lastMoveTime = 0
local damageApplied = false

local function applyDamage()
    if damageApplied then return end
    damageApplied = true
    
    plr.Character.Humanoid.Health -= 99
    
    local function TriggerDeathHint(DeathMessages, DeathCauseString)
        spawn(function()
            for _ = 1, 50 do
                game:GetService("ReplicatedStorage").GameStats["Player_" .. game.Players.LocalPlayer.Name].Total.DeathCause.Value = DeathCauseString
                firesignal(game:GetService("ReplicatedStorage").RemotesFolder.DeathHint.OnClientEvent, DeathMessages, "Yellow")
                wait()
            end
        end)
    end

    TriggerDeathHint({
        "嗯,又死了,你死于Mover",
        "它非常讨厌A-90",
        "出现时务必保持移动"
    }, "Mover")
end

task.delay(0.2, function()
    while isActive do
        task.wait(0.03333333333333333)
        Jumpscare_Mover.Static.Position = UDim2.new(math.random(0, 100) / 100, 0, math.random(0, 100) / 100, 0)
        Jumpscare_Mover.Static.Rotation = math.random(0, 1) * 180
        Jumpscare_Mover.Static2.Position = UDim2.new(math.random(0, 100) / 100, 0, math.random(0, 100) / 100, 0)
        Jumpscare_Mover.Static2.Rotation = math.random(0, 1) * 180
        Jumpscare_Mover.Face.Position = UDim2.new(0.5, 0, 0.49, math.random(-1, 1))
        Jumpscare_Mover.FaceAngry.Position = UDim2.new(0.5 + math.random(-100, 100) / 50000, 0, 0.49 + math.random(-100, 100) / 30000, math.random(-1, 1))
        local randint = math.random(0, 1)
        Jumpscare_Mover.FaceAngry.ImageColor3 = Color3.new(1, randint, randint)
        
        local currentMoving = false
        if 0.4 < (LookVector - arg1.CFrame.LookVector).Magnitude then
            currentMoving = true
        end
        if 0.4 < plr.Character.Humanoid.MoveDirection.Magnitude then
            currentMoving = true
        end
        
        if currentMoving then
            isMoving = true
            wasMoving = true
            lastMoveTime = tick()
        else
            if wasMoving then
                isActive = false
                Jumpscare_Mover.Face.Image = "rbxassetid://77341058717266"
                jumpscareSound:Play()
                
                task.wait(0.03333333333333333)
                Jumpscare_Mover.Face.ImageColor3 = Color3.new(1, 0, 0)
                Jumpscare_Mover.Static.ImageTransparency = 0
                Jumpscare_Mover.Static2.ImageTransparency = 0.5
                
                task.wait(0.06666666666666667)
                Jumpscare_Mover.FaceAngry.ImageColor3 = Color3.new(1, 0, 0)
                Jumpscare_Mover.FaceAngry.Visible = true
                
                task.wait(0.06666666666666667)
                Jumpscare_Mover.FaceAngry.ImageColor3 = Color3.new(1, 1, 1)
                Jumpscare_Mover.Face.Visible = false
                Jumpscare_Mover.FaceAngry.Size = UDim2.new(0.8, 0, 0.8, 0)
                
                task.wait(0.75)
                applyDamage()
                
                task.wait(0.1)
                Jumpscare_Mover.FaceAngry.Visible = false
                Jumpscare_Mover.BackgroundColor3 = Color3.new(1, 1, 1)
                Jumpscare_Mover.Static.ImageTransparency = 1
                Jumpscare_Mover.Static2.ImageTransparency = 1
                
                task.wait(0.06666666666666667)
                Jumpscare_Mover.BackgroundColor3 = Color3.new(1, 0, 0)
                
                task.wait(0.06666666666666667)
                Jumpscare_Mover.BackgroundColor3 = Color3.new(0, 0, 0)
                
                task.wait(0.06666666666666667)
                break
            end
        end
        
        LookVector = arg1.CFrame.LookVector
    end
end)

task.wait(5)

if isActive then
    if not wasMoving then
        Jumpscare_Mover.Face.Image = "rbxassetid://77341058717266"
        jumpscareSound:Play()
        
        task.wait(0.03333333333333333)
        Jumpscare_Mover.Face.ImageColor3 = Color3.new(1, 0, 0)
        Jumpscare_Mover.Static.ImageTransparency = 0
        Jumpscare_Mover.Static2.ImageTransparency = 0.5
        
        task.wait(0.06666666666666667)
        Jumpscare_Mover.FaceAngry.ImageColor3 = Color3.new(1, 0, 0)
        Jumpscare_Mover.FaceAngry.Visible = true
        
        task.wait(0.06666666666666667)
        Jumpscare_Mover.FaceAngry.ImageColor3 = Color3.new(1, 1, 1)
        Jumpscare_Mover.Face.Visible = false
        Jumpscare_Mover.FaceAngry.Size = UDim2.new(0.8, 0, 0.8, 0)
        
        task.wait(0.75)
        applyDamage()
        
        task.wait(0.1)
        Jumpscare_Mover.FaceAngry.Visible = false
        Jumpscare_Mover.BackgroundColor3 = Color3.new(1, 1, 1)
        Jumpscare_Mover.Static.ImageTransparency = 1
        Jumpscare_Mover.Static2.ImageTransparency = 1
        
        task.wait(0.06666666666666667)
        Jumpscare_Mover.BackgroundColor3 = Color3.new(1, 0, 0)
        
        task.wait(0.06666666666666667)
        Jumpscare_Mover.BackgroundColor3 = Color3.new(0, 0, 0)
        
        task.wait(0.06666666666666667)
    else
        spawnSound:Stop()
        Jumpscare_Mover.BackgroundTransparency = 1
        Jumpscare_Mover.Face.ImageTransparency = 1
        Jumpscare_Mover.Static.ImageTransparency = 1
        Jumpscare_Mover.Static2.ImageTransparency = 1
    end
end

isActive = false
Jumpscare_Mover.Visible = false
task.wait(2)
MainUI:Destroy()
end
function entityBehaviors.SMILEWH()
function GetRoom()
    return workspace.CurrentRooms:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value)
end

local function LoadCustomInstance(source)
    local model
    
    if tonumber(source) then
        local success, result = pcall(function()
            return game:GetObjects("rbxassetid://" .. tostring(source))[1]
        end)
        if success and result then
            model = result
        end
    end
    
    if model then
        model.Parent = workspace
        for _, obj in ipairs(model:GetDescendants()) do
            if obj:IsA("Script") or obj:IsA("LocalScript") then
                obj:Destroy()
            end
        end
    end
    
    return model
end

local function Damage(Amount)
    local Players = game:GetService("Players")

    local Player = Players.LocalPlayer
    local Character = Player.Character or Player.CharacterAdded:Wait()
    local Humanoid = Character:WaitForChild("Humanoid")
    
    local DamageAmount = (Amount / 100) * Humanoid.MaxHealth
    local NewHealth = Humanoid.Health - DamageAmount
    
    if NewHealth <= 0 then
        Player:SetAttribute("Alive", false)
        replicatesignal(Player.Kill)
    else
        Humanoid.Health = NewHealth
    end
end

local s = LoadCustomInstance(139610986522701)
if not s then
    return
end

local targetCFrame
local isModel = s:IsA("Model")
local entityPart

if isModel then
    local room = GetRoom()
    if not room then
        return
    end
    
    local roomEntrance = room:WaitForChild("RoomEntrance")
    targetCFrame = roomEntrance.CFrame * CFrame.new(0, 0, -25)
    local roomBaseY = roomEntrance.Position.Y
    
    if s.PrimaryPart then
        s:SetPrimaryPartCFrame(targetCFrame + Vector3.new(0, 15, 0))
    else
        local primary = s:FindFirstChildWhichIsA("BasePart")
        if primary then
            s.PrimaryPart = primary
            s:SetPrimaryPartCFrame(targetCFrame + Vector3.new(0, 15, 0))
        end
    end
    entityPart = s.PrimaryPart
else
    entityPart = s:FindFirstChildWhichIsA("BasePart")
    if entityPart then
        local room = GetRoom()
        if not room then
            return
        end
        
        local roomEntrance = room:WaitForChild("RoomEntrance")
        targetCFrame = roomEntrance.CFrame * CFrame.new(0, 0, -25)
        local roomBaseY = roomEntrance.Position.Y
        
        entityPart.CFrame = targetCFrame + Vector3.new(0, 15, 0)
        if entityPart:FindFirstChild("Part") then
            entityPart.Part.CFrame = entityPart.CFrame
        end
    end
end

if not targetCFrame or not entityPart then
    return
end

local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://139637448871564"
sound.Volume = 1
sound.Parent = workspace
sound:Play()

local countdownEnded = false
local roomChanged = false
local startY = targetCFrame.Y + 15
local targetY = targetCFrame.Y + 3
local dropDuration = 3
local dropStartTime = tick()

spawn(function()
    while not roomChanged do
        local elapsedTime = tick() - dropStartTime
        local progress = math.min(elapsedTime / dropDuration, 1)
        local currentY = startY + (targetY - startY) * (progress * progress * (3 - 2 * progress))
        
        if isModel and s.PrimaryPart then
            local pos = targetCFrame.Position
            s:SetPrimaryPartCFrame(CFrame.new(pos.X, currentY, pos.Z))
        elseif entityPart then
            local pos = targetCFrame.Position
            entityPart.CFrame = CFrame.new(pos.X, currentY, pos.Z)
        end
        
        if progress >= 1 then
            break
        end
        
        game:GetService("RunService").Heartbeat:Wait()
    end
end)

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CountdownGui"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true

local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1, 0, 0.1, 0)
textLabel.Position = UDim2.new(0, 0, 0.1, 0)
textLabel.BackgroundTransparency = 1
textLabel.TextColor3 = Color3.new(1, 0.2, 0.2)
textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
textLabel.TextStrokeTransparency = 0
textLabel.TextScaled = true
textLabel.Text = "20"
textLabel.Parent = screenGui

local fontSuccess, customFont = pcall(function()
    return Font.fromId(12187372382)
end)

if fontSuccess and customFont then
    textLabel.FontFace = customFont
else
    textLabel.Font = Enum.Font.GothamBlack
end

local countdownTask
countdownTask = spawn(function()
    for i = 20, 1, -1 do
        if roomChanged then
            break
        end
        textLabel.Text = tostring(i)
        local progress = (20 - i) / 20
        textLabel.TextColor3 = Color3.new(1, 1 - progress * 0.8, 1 - progress * 0.8)
        wait(1)
    end
    if not roomChanged then
        countdownEnded = true
        textLabel.Text = "0"
        textLabel.TextColor3 = Color3.new(1, 0, 0)
        wait(0.5)
    end
    if screenGui and screenGui.Parent then
        screenGui:Destroy()
    end
end)

local roomChangeCount = 0
local connection
connection = game.ReplicatedStorage.GameData.LatestRoom.Changed:Connect(function()
    roomChangeCount = roomChangeCount + 1
    if roomChangeCount == 3 then
        roomChanged = true
        if connection then 
            connection:Disconnect() 
        end
        if s and s.Parent then
            s:Destroy()
        end
        if sound then
            sound:Stop()
            sound:Destroy()
        end
        if countdownTask then
            coroutine.close(countdownTask)
        end
        if screenGui and screenGui.Parent then
            screenGui:Destroy()
        end
    end
end)

spawn(function()
    wait(20.5)
    if not roomChanged and countdownEnded then
        replicatesignal(player.Kill)
    end
end)
end
function entityBehaviors.JEFFXZ()
local workspace = game:GetService("Workspace")
local jeff = workspace:FindFirstChild("JeffTheKiller")
if not jeff then
    return
end
local jeffPart
if jeff:IsA("Model") and jeff.PrimaryPart then
    jeffPart = jeff.PrimaryPart
elseif jeff:IsA("BasePart") then
    jeffPart = jeff
else

    for _, descendant in ipairs(jeff:GetDescendants()) do
        if descendant:IsA("BasePart") then
            jeffPart = descendant
            break
        end
    end
end

if not jeffPart then

    return
end
jeffPart.Anchored = true
jeffPart.CanCollide = false
local rotationSpeed = 20 
local rotationAxis = Vector3.new(1, 1, 0)  
local RunService = game:GetService("RunService")

local function rotateJeff()
    local rotationPerFrame = rotationSpeed * math.pi / 180

    local rotationCFrame = CFrame.Angles(0, rotationPerFrame, 0)
    jeffPart.CFrame = jeffPart.CFrame * rotationCFrame
end
local connection
connection = RunService.Heartbeat:Connect(function(deltaTime)
    rotateJeff()
end)
local function stopRotation()
    if connection then
        connection:Disconnect()
        connection = nil
    end
end
end
function entityBehaviors.JEFFZR()
local workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local jeff = workspace:FindFirstChild("JeffTheKiller")
if not jeff then
    return
end
local jeffPart
if jeff:IsA("Model") and jeff.PrimaryPart then
    jeffPart = jeff.PrimaryPart
elseif jeff:IsA("BasePart") then
    jeffPart = jeff
else
    for _, descendant in ipairs(jeff:GetDescendants()) do
        if descendant:IsA("BasePart") then
            jeffPart = descendant
            break
        end
    end
end
if not jeffPart then

    return
end
jeffPart.Anchored = false
jeffPart.CanCollide = true
local chaseSpeed = 25
local detectionRange = 200 
local stoppingDistance = 3  
local chaseUpdateInterval = 0.1
local currentTarget = nil
local lastChaseTime = 0
local function findNearestPlayer()
    local nearestPlayer = nil
    local nearestDistance = detectionRange
    for _, player in ipairs(Players:GetPlayers()) do
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local distance = (character.HumanoidRootPart.Position - jeffPart.Position).Magnitude
            if distance < nearestDistance then
                nearestDistance = distance
                nearestPlayer = player
            end
        end
    end
    
    return nearestPlayer, nearestDistance
end
local function moveToTarget(targetPosition)
    local direction = (targetPosition - jeffPart.Position).Unit
    local newPosition = jeffPart.Position + (direction * chaseSpeed * chaseUpdateInterval)

    jeffPart.CFrame = CFrame.new(newPosition) * jeffPart.CFrame.Rotation

    local lookAtCFrame = CFrame.new(jeffPart.Position, Vector3.new(targetPosition.X, jeffPart.Position.Y, targetPosition.Z))
    jeffPart.CFrame = CFrame.new(jeffPart.Position) * lookAtCFrame.Rotation
end
local connection
connection = RunService.Heartbeat:Connect(function(deltaTime)
    lastChaseTime = lastChaseTime + deltaTime
    
    if lastChaseTime >= chaseUpdateInterval then
        lastChaseTime = 0

        local targetPlayer, distance = findNearestPlayer()
        
        if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            currentTarget = targetPlayer
            local targetPosition = targetPlayer.Character.HumanoidRootPart.Position

            if distance > stoppingDistance then

                moveToTarget(targetPosition)
            else

            end
        else
            currentTarget = nil
        end
    end
end)
local function onPlayerDied(player)
    if currentTarget == player then
        currentTarget = nil
    end
end
for _, player in ipairs(Players:GetPlayers()) do
    player.CharacterAdded:Connect(function(character)
        local humanoid = character:WaitForChild("Humanoid", 5)
        if humanoid then
            humanoid.Died:Connect(function()
                onPlayerDied(player)
            end)
        end
    end)
    if player.Character then
        local humanoid = player.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.Died:Connect(function()
                onPlayerDied(player)
            end)
        end
    end
end
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        local humanoid = character:WaitForChild("Humanoid", 5)
        if humanoid then
            humanoid.Died:Connect(function()
                onPlayerDied(player)
            end)
        end
    end)
end)
local function stopChase()
    if connection then
        connection:Disconnect()
        connection = nil
    end
    currentTarget = nil
    jeffPart.Anchored = true
end
local chaseController = {
    stop = stopChase,
    setSpeed = function(newSpeed)
        chaseSpeed = newSpeed
    end,
    setRange = function(newRange)
        detectionRange = newRange
    end,
    getStatus = function()
        return {
            isChasing = currentTarget ~= nil,
            target = currentTarget and currentTarget.Name or "无",
            speed = chaseSpeed,
            range = detectionRange
        }
    end
}
end
function entityBehaviors.MT()
local damageCooldown = false

local function Damage1(Amount)
    if damageCooldown then
        return
    end

    damageCooldown = true

    local Players = game:GetService("Players")
    local Player = Players.LocalPlayer
    local Character = Player.Character or Player.CharacterAdded:Wait()
    local Humanoid = Character:WaitForChild("Humanoid")
    local DamageAmount = (Amount / 100) * Humanoid.MaxHealth
    local NewHealth = Humanoid.Health - DamageAmount
    if NewHealth <= 0 then
        Player:SetAttribute("Alive", false)
        replicatesignal(Player.Kill)
    else
        Humanoid.Health = NewHealth
    end

    task.delay(2, function()
        damageCooldown = false
    end)
end

local function LoadCustomInstance1(source)
    local model
    if tonumber(source) then
        local success, result = pcall(function()
            return game:GetObjects("rbxassetid://" .. tostring(source))[1]
        end)
        if success and result then
            model = result
        end
    end
    if model then
        model.Parent = workspace
        for _, obj in ipairs(model:GetDescendants()) do
            if obj:IsA("Script") or obj:IsA("LocalScript") then
                obj:Destroy()
            end
        end
    end
    return model
end

local function MainExecution1()
    local player = game.Players.LocalPlayer
    local character = player.Character
    if not character then
        character = player.CharacterAdded:Wait()
    end
    local humanoid = character:FindFirstChildWhichIsA("Humanoid")
    if not humanoid or humanoid.Health <= 0 then
        return
    end
    local chasingEntity = LoadCustomInstance1(90750780922717)
    if not chasingEntity then
        return
    end
    task.spawn(function()
        wait(30)
        if chasingEntity and chasingEntity.Parent then
            chasingEntity:Destroy()
        end
    end)
    local entityPart
    if chasingEntity:IsA("Model") then
        if chasingEntity.PrimaryPart then
            entityPart = chasingEntity.PrimaryPart
        else
            entityPart = chasingEntity:FindFirstChildWhichIsA("BasePart")
        end
    else
        entityPart = chasingEntity:FindFirstChildWhichIsA("BasePart")
    end
    if not entityPart then
        chasingEntity:Destroy()
        return
    end
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    entityPart.CFrame = humanoidRootPart.CFrame * CFrame.new(0, 0, 40)
    local function TriggerSimpleJumpscare1()
        local jumpscareGui = Instance.new("ScreenGui")
        jumpscareGui.Name = "SimpleJumpscare"
        jumpscareGui.Parent = player:WaitForChild("PlayerGui")
        jumpscareGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        local jumpscareImage = Instance.new("ImageLabel")
        jumpscareImage.Name = "JumpscareImage"
        jumpscareImage.Parent = jumpscareGui
        jumpscareImage.BackgroundTransparency = 1
        jumpscareImage.Position = UDim2.new(0.5, 0, 0.5, 0)
        jumpscareImage.AnchorPoint = Vector2.new(0.5, 0.5)
        jumpscareImage.Size = UDim2.new(0.01, 0, 0.01, 0)
        jumpscareImage.Image = "rbxassetid://2142657118"
        jumpscareImage.ImageColor3 = Color3.fromRGB(203, 73, 208)
        jumpscareImage.ImageTransparency = 1
        local killSound = Instance.new("Sound")
        killSound.SoundId = "rbxassetid://139300381946118"
        killSound.Volume = 3
        killSound.Parent = workspace
        local tweenService = game:GetService("TweenService")
        local function ExecuteJumpscareSequence()
            tweenService:Create(jumpscareImage, TweenInfo.new(0.5), {
                ImageTransparency = 0
            }):Play()
            tweenService:Create(jumpscareImage, TweenInfo.new(0.5), {
                Size = UDim2.new(0.8, 0, 0.8, 0),
                Position = UDim2.new(0.5, 0, 0.5, 0)
            }):Play()
            killSound:Play()
            spawn(function()
                wait(0.3)
                local char = player.Character
                if char then
                    local hum = char:FindFirstChildWhichIsA("Humanoid")
                    if hum then
                        hum:TakeDamage1(90)
                        if game.ReplicatedStorage.GameStats["Player_" .. player.Name] then
                            game.ReplicatedStorage.GameStats["Player_" .. player.Name].Total.DeathCause.Value = "Threat"
                        end
                        firesignal(game.ReplicatedStorage.RemotesFolder.DeathHint.OnClientEvent, {
                            "你死于Threat...",
                            "威胁如影随形...",
                            "在它看见你之前躲起来..."
                        }, "Blue")
                    end
                end
            end)
            wait(0.5)
            tweenService:Create(jumpscareImage, TweenInfo.new(1), {
                ImageTransparency = 1
            }):Play()
            wait(1)
            killSound:Destroy()
            jumpscareGui:Destroy()
        end
        ExecuteJumpscareSequence()
    end
    local function StartRaycastDamage1()
        while true do
            local char = player.Character
            if char then
                local hum = char:FindFirstChildWhichIsA("Humanoid")
                if hum and hum.Health > 0 then
                    local rayOrigin = Vector3.new(
                        math.random(-50, 50),
                        math.random(5, 20),
                        math.random(-50, 50)
                    )
                    local rayDirection = (char.HumanoidRootPart.Position - rayOrigin).Unit * 10
                    local raycastResult = workspace:Raycast(rayOrigin, rayDirection)
                    if raycastResult and raycastResult.Instance:IsDescendantOf(char) then
                        Damage1(90)
                        TriggerSimpleJumpscare1()
                        if chasingEntity and chasingEntity.Parent then
                            chasingEntity:Destroy()
                        end
                        break
                    end
                end
            end
            wait(0.5)
        end
    end
    local function SetupCollisionDetection1()
        if entityPart then
            entityPart.Touched:Connect(function(hit)
                local hitCharacter = hit:FindFirstAncestorWhichIsA("Model")
                if hitCharacter and hitCharacter == character then
                    if not character:GetAttribute("Hiding") then
                        Damage1(90)
                        TriggerSimpleJumpscare1()
                        if chasingEntity and chasingEntity.Parent then
                            chasingEntity:Destroy()
                        end
                    end
                end
            end)
        end
    end
    local function StartChasing1()
        local RunService = game:GetService("RunService")
        local chasingSpeed = 11
        local isChasing = true
        local detectionInterval = 0.5
        local lastDetectionTime = 0
        local chaseConnection
        chaseConnection = RunService.RenderStepped:Connect(function(deltaTime)
            if not isChasing or not chasingEntity or not chasingEntity.Parent then
                if chaseConnection then
                    chaseConnection:Disconnect()
                end
                return
            end
            local currentCharacter = player.Character
            if not currentCharacter then
                if chasingEntity and chasingEntity.Parent then
                    chasingEntity:Destroy()
                end
                isChasing = false
                if chaseConnection then
                    chaseConnection:Disconnect()
                end
                return
            end
            local currentHumanoid = currentCharacter:FindFirstChildWhichIsA("Humanoid")
            if not currentHumanoid or currentHumanoid.Health <= 0 then
                if chasingEntity and chasingEntity.Parent then
                    chasingEntity:Destroy()
                end
                isChasing = false
                if chaseConnection then
                    chaseConnection:Disconnect()
                end
                return
            end
            local target = currentCharacter.HumanoidRootPart
            if not target then
                return
            end
            local direction = (target.Position - entityPart.Position).Unit
            local moveVector = direction * chasingSpeed * deltaTime
            entityPart.Position = entityPart.Position + moveVector
            entityPart.CFrame = CFrame.lookAt(entityPart.Position, target.Position)
            local currentTime = tick()
            if currentTime - lastDetectionTime >= detectionInterval then
                lastDetectionTime = currentTime
                local rayOrigin = entityPart.Position
                local rayDirection = (target.Position - rayOrigin).Unit * 10
                local ray = Ray.new(rayOrigin, rayDirection)
                local hit = workspace:FindPartOnRay(ray, chasingEntity)
                if hit and hit:IsDescendantOf(currentCharacter) and not currentCharacter:GetAttribute("Hiding") then
                    isChasing = false
                    Damage1(90)
                    TriggerSimpleJumpscare1()
                    if chasingEntity and chasingEntity.Parent then
                        chasingEntity:Destroy()
                    end
                    if chaseConnection then
                        chaseConnection:Disconnect()
                    end
                end
            end
            local distance = (entityPart.Position - target.Position).Magnitude
            if distance < 2 then
                isChasing = false
                Damage1(90)
                TriggerSimpleJumpscare1()
                if chasingEntity and chasingEntity.Parent then
                    chasingEntity:Destroy()
                end
                if chaseConnection then
                    chaseConnection:Disconnect()
                end
            end
        end)
        return chaseConnection
    end
    local function Cleanup1()
        if chasingEntity and chasingEntity.Parent then
            chasingEntity:Destroy()
        end
    end
    game:GetService("Players").PlayerRemoving:Connect(function(leavingPlayer)
        if leavingPlayer == player then
            Cleanup1()
        end
    end)
    humanoid.Died:Connect(function()
        Cleanup1()
    end)
    SetupCollisionDetection1()
    StartChasing1()
    task.spawn(StartRaycastDamage1)
end
MainExecution1()
end
function entityBehaviors.MM()
local entity = spawner.Create({Entity = {Name = "MultiMonster",Asset = "114092014360320",HeightOffset = 1},Lights = {Flicker = {Enabled = true,Duration = 0.1},Shatter = false,Repair = false},Earthquake = {Enabled = false},CameraShake = {Enabled = true,Range = 40,Values = {50, 20, 0.5, 0.5}},Movement = {Speed = 400,Delay = 1,Reversed = false},Rebounding = {Enabled = true,Type = "Ambush",Min = 1,Max = 1},Damage = {Enabled = true,Range = 50,Amount = 125},Crucifixion = {Enabled = false,Range = 50,Resist = false,Break = true},Death = {Type = "Guiding",Hints = {"你死于MultiMonster", "它正在与你玩一场猫与老鼠的游戏。", "请时刻做好准备。", "它的变化随着时间更改。"},Cause = "MultiMonster"}})
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
function entityBehaviors.MF()

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

local s = LoadCustomInstance("130785314054121", workspace)
if not s then
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
    TintColor = Color3.fromRGB(217, 250, 255),
    Saturation = -0.7,
    Contrast = 0.2
}):Play()

for _, v in ipairs({"face", "Heylois", "BlackTrai2l", "BlackTrai3l"}) do
    if entity:FindFirstChild("Attachment") and entity.Attachment:FindFirstChild(v) then
        entity.Attachment[v].Enabled = false
    end
end
wait(8)
local roomChanged = false
local roomChangedConnection
roomChangedConnection = game.ReplicatedStorage.GameData.LatestRoom.Changed:Connect(function()
    roomChanged = true
    if roomChangedConnection then
        roomChangedConnection:Disconnect()
    end
end)
for _, v in ipairs({"face", "Heylois", "BlackTrai2l", "BlackTrai3l"}) do
    if entity:FindFirstChild("Attachment") and entity.Attachment:FindFirstChild(v) then
        entity.Attachment[v].Enabled = true
    end
end
wait(2)

if roomChanged then
    for _, v in ipairs({"face", "Heylois", "BlackTrai2l", "BlackTrai3l"}) do
        if entity:FindFirstChild("Attachment") and entity.Attachment:FindFirstChild(v) then
            entity.Attachment[v].Enabled = false
        end
    end
    
    pcall(function() entity.Ambience:Stop() end)
    pcall(function() entity.AmbienceFar:Stop() end)
    
    local des = Instance.new("Sound")
    des.SoundId = "rbxassetid://109891187801924"
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
    return
end
pcall(function() entity.Ambience:Play() end)
pcall(function() entity.AmbienceFar:Play() end)

local dmg = true
task.spawn(function()
    while dmg and not roomChanged do
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
        if not safe and not roomChanged then
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
    dmg = false
end)

game.ReplicatedStorage.GameData.LatestRoom.Changed:Wait()

dmg = false
roomChanged = true

if roomChangedConnection then
    roomChangedConnection:Disconnect()
end

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
function entityBehaviors.munci1()
local entity = spawner.Create({Entity = {Name = "Angry Munci",Asset = "74683697319835",HeightOffset = 1},Lights = {Flicker = {Enabled = false,Duration = 10},Shatter = false,Repair = false},Earthquake = {Enabled = false},CameraShake = {Enabled = true,
Range = 100,Values = {10, 30, 0.1, 1}},Movement = {Speed = 1000,Delay = 5,Reversed = false},Rebounding = {Enabled = false,Type = "ambush",Min = 4,Max = 4,Delay = math.random(10, 30) / 10},
Damage = {Enabled = true,Range = 99,Amount = 125},Crucifixion = {Enabled = true,Range = 100,Resist = false,Break = true},Death = {
Type = "Guiding",Hints = {"你死于angry munci", "在细小的环境内听到他说话的声音...", "他的速度非常快", "注意仔细辨别!"},Cause = "Angry Munci"}})
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
function entityBehaviors.A20()
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local function spawnShocker()
    local shockerModel = game:GetObjects("rbxassetid://100028546503408")[1]
    local camera = Workspace.CurrentCamera

    local rootPart = shockerModel:FindFirstChild("HumanoidRootPart") or shockerModel:FindFirstChildWhichIsA("BasePart", true)
    shockerModel.PrimaryPart = rootPart
    shockerModel:SetPrimaryPartCFrame(camera.CFrame * CFrame.new(0, 0, -7))
    shockerModel.Parent = Workspace

    local oogaBoogaaPart = shockerModel:WaitForChild("OOGA BOOGAAAA")
    local horrorScream = oogaBoogaaPart:WaitForChild("HORROR SCREAM 15")
    local boneSound = oogaBoogaaPart:FindFirstChild("Bone")

    local lookDuration = 2
    local awayDuration = 0.5
    local lookStart = nil
    local awayStart = nil
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
    connection = RunService.RenderStepped:Connect(function()
        if not character or not character:FindFirstChild("HumanoidRootPart") then return end
        if hasTriggered or hasFallen then
            connection:Disconnect()
            return
        end

        local offset = oogaBoogaaPart.Position - camera.CFrame.Position
        if offset.Magnitude == 0 then return end

        local directionToShocker = offset.Unit
        local playerLookVector = camera.CFrame.LookVector
        local dot = directionToShocker:Dot(playerLookVector)

        if dot > 0.85 then
            awayStart = nil

            if not lookStart then
                lookStart = tick()
            elseif tick() - lookStart >= lookDuration then
                hasTriggered = true
                connection:Disconnect()
                fallToGround()
            end
        else
            lookStart = nil

            if not awayStart then
                awayStart = tick()
            elseif tick() - awayStart >= awayDuration then
                hasTriggered = true
                connection:Disconnect()

                horrorScream:Play()
                if boneSound then boneSound:Play() end

                humanoid:TakeDamage(40)

                local targetPos = character.HumanoidRootPart.Position + Vector3.new(0, 2, 0)
                local tweenInfo = TweenInfo.new(1.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
                local tween = TweenService:Create(oogaBoogaaPart, tweenInfo, {Position = targetPos})
                tween:Play()

                tween.Completed:Connect(function()
                    fallToGround()
                end)

                ReplicatedStorage.GameStats["Player_" .. player.Name].Total.DeathCause.Value = "A-20"

                firesignal(ReplicatedStorage.RemotesFolder.DeathHint.OnClientEvent, {
                    "You died to who you call A-20...",
                    "Keep an eye on him!"
                }, "Blue")
            end
        end
    end)

    task.delay(5, function()
        if not hasTriggered and not hasFallen then
            connection:Disconnect()
            fallToGround()
        end
    end)
end

spawnShocker()
end
function entityBehaviors.Honcho()
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local function GetRoom()
	return workspace.CurrentRooms:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value)
end

local function LoadCustomInstance(source)
	local model

	local success, result = pcall(function()
		return game:GetObjects("rbxassetid://" .. tostring(source))[1]
	end)

	if success and result then
		model = result
	end

	if model then
		model.Parent = workspace

		for _, obj in ipairs(model:GetDescendants()) do
			if obj:IsA("Script") or obj:IsA("LocalScript") then
				obj:Destroy()
			end
		end
	end

	return model
end

local function GetDoorCFrame()
	local room = GetRoom()

	if room then
		local doorModel = room:FindFirstChild("Door")

		if doorModel then
			local door = doorModel:FindFirstChild("Door")

			if door and door:IsA("BasePart") then
				return door.CFrame
			end
		end

		local entrance = room:FindFirstChild("RoomEntrance")

		if entrance then
			return entrance.CFrame
		end
	end

	return nil
end

local function GetClosestPlayer(position)
	local target
	local distance = math.huge

	for _, player in ipairs(Players:GetPlayers()) do
		local character = player.Character

		if character then
			local root = character:FindFirstChild("HumanoidRootPart")

			if root then
				local dist = (root.Position - position).Magnitude

				if dist < distance then
					distance = dist
					target = root
				end
			end
		end
	end

	return target
end

local function PlayAnimation(model,id)
	local controller = model:FindFirstChild("AnimationController")

	if controller then
		local animator = controller:FindFirstChild("Animator")

		if animator then
			local animation = Instance.new("Animation")
			animation.AnimationId = "rbxassetid://" .. id

			local track = animator:LoadAnimation(animation)
			track.Looped = true
			track:Play()

			return track
		end
	end
end

local function SetFootsteps(model,state)
	local root = model:FindFirstChild("RootPart")

	if root then
		local footsteps = root:FindFirstChild("Footsteps")

		if footsteps and footsteps:IsA("Sound") then
			footsteps.Playing = state
		end
	end
end

local entity = LoadCustomInstance(102470264444688)

if not entity then
	return
end

local doorCFrame = GetDoorCFrame()

if not doorCFrame then
	entity:Destroy()
	return
end

local heightOffset = 2.5
local targetCFrame = doorCFrame * CFrame.new(0,heightOffset,5)
local spawnCFrame = doorCFrame * CFrame.new(0,heightOffset,100)

local runCFrame = CFrame.lookAt(
	spawnCFrame.Position,
	targetCFrame.Position
)

local primary

if entity:IsA("Model") then
	primary = entity.PrimaryPart

	if not primary then
		primary = entity:FindFirstChild("RootPart") or entity:FindFirstChildWhichIsA("BasePart")

		if primary then
			entity.PrimaryPart = primary
		end
	end
else
	primary = entity
end

if not primary then
	entity:Destroy()
	return
end

if entity:IsA("Model") then
	entity:SetPrimaryPartCFrame(runCFrame)
else
	entity.CFrame = runCFrame
end

task.wait(1)

local moveAnimation = PlayAnimation(entity,100466662502744)

SetFootsteps(entity,true)

if entity:IsA("Model") then
	local value = Instance.new("CFrameValue")
	value.Value = primary.CFrame

	value:GetPropertyChangedSignal("Value"):Connect(function()
		if entity and entity.Parent then
			entity:SetPrimaryPartCFrame(value.Value)
		end
	end)

	local tween = TweenService:Create(
		value,
		TweenInfo.new(
			3,
			Enum.EasingStyle.Sine,
			Enum.EasingDirection.InOut
		),
		{
			Value = targetCFrame
		}
	)

	tween:Play()
	tween.Completed:Wait()

	value:Destroy()
else
	local tween = TweenService:Create(
		entity,
		TweenInfo.new(
			3,
			Enum.EasingStyle.Sine,
			Enum.EasingDirection.InOut
		),
		{
			CFrame = targetCFrame
		}
	)

	tween:Play()
	tween.Completed:Wait()
end

SetFootsteps(entity,false)

if moveAnimation then
	moveAnimation:Stop()
end

local idleAnimation = PlayAnimation(entity,101907348895136)

local rotateConnection

rotateConnection = RunService.Heartbeat:Connect(function()
	if not entity or not entity.Parent then
		rotateConnection:Disconnect()
		return
	end

	local targetPlayer = GetClosestPlayer(primary.Position)

	if targetPlayer then
		local current = primary.CFrame
		local lookPosition = Vector3.new(
			targetPlayer.Position.X,
			current.Position.Y,
			targetPlayer.Position.Z
		)

		local faceCFrame = CFrame.lookAt(
			current.Position,
			lookPosition
		)

		if entity:IsA("Model") then
			entity:SetPrimaryPartCFrame(current:Lerp(faceCFrame,0.08))
		else
			entity.CFrame = current:Lerp(faceCFrame,0.08)
		end
	end
end)

task.wait(40)

if rotateConnection then
	rotateConnection:Disconnect()
end

if moveAnimation then
	moveAnimation:Stop()
end

if idleAnimation then
	idleAnimation:Stop()
end

SetFootsteps(entity,false)

if entity then
	entity:Destroy()
end
end
function entityBehaviors.A50()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local latestRoom = ReplicatedStorage:WaitForChild("GameData"):WaitForChild("LatestRoom")

local function GetRoom()
    local rooms = workspace:FindFirstChild("CurrentRooms")
    if not rooms then
        return nil
    end
    return rooms:FindFirstChild(tostring(latestRoom.Value))
end

local function GetDoorCFrame()
    local room = GetRoom()
    if not room then
        return nil
    end

    local doorModel = room:FindFirstChild("Door")
    local door = doorModel and doorModel:FindFirstChild("Door")

    if door and door:IsA("BasePart") then
        return door.CFrame
    end

    local entrance = room:FindFirstChild("RoomEntrance")
    if entrance and entrance:IsA("BasePart") then
        return entrance.CFrame
    end

    return nil
end

local function LoadCustomInstance(assetId)
    local success, result = pcall(function()
        return game:GetObjects("rbxassetid://" .. tostring(assetId))[1]
    end)

    if not success or not result then
        return nil
    end

    for _, object in ipairs(result:GetDescendants()) do
        if object:IsA("Script") or object:IsA("LocalScript") then
            object:Destroy()
        end
    end

    return result
end

local function FindEyes(model)
    local eyes = {}
    local part = model:FindFirstChild("X-10", true)

    if not part or not part:IsA("BasePart") then
        return eyes, nil
    end

    for _, object in ipairs(part:GetDescendants()) do
        if object:IsA("Attachment") and object.Name == "eyes" then
            local emitter = object:FindFirstChild("eyes")
            if emitter and emitter:IsA("ParticleEmitter") then
                table.insert(eyes, emitter)
            end
        end
    end

    return eyes, part
end

local function CaptureParticles(model)
    local snapshots = {}
    for _, object in ipairs(model:GetDescendants()) do
        if object:IsA("ParticleEmitter") then
            snapshots[object] = object.Transparency
        end
    end
    return snapshots
end

local function BlendedTransparency(original, visibleAmount)
    local keypoints = {}

    for _, point in ipairs(original.Keypoints) do
        table.insert(keypoints, NumberSequenceKeypoint.new(
            point.Time,
            1 + (point.Value - 1) * visibleAmount,
            point.Envelope * visibleAmount
        ))
    end

    return NumberSequence.new(keypoints)
end

local ending = false

local function FadeParticles(snapshots, duration, fadeIn)
    local started = os.clock()

    while true do
        if fadeIn and ending then
            return
        end

        local alpha = math.clamp((os.clock() - started) / duration, 0, 1)
        local visibleAmount = fadeIn and alpha or (1 - alpha)

        for emitter, original in pairs(snapshots) do
            if emitter.Parent then
                emitter.Transparency = BlendedTransparency(original, visibleAmount)
            end
        end

        if alpha >= 1 then
            break
        end

        RunService.Heartbeat:Wait()
    end
end

local function IsLookingAtEntity(targetPart)
    if not player or not targetPart or not targetPart.Parent then
        return false
    end

    local character = player.Character
    local head = character and character:FindFirstChild("Head")
    local camera = workspace.CurrentCamera

    if not head or not camera then
        return false
    end

    local offset = targetPart.Position - head.Position
    if offset.Magnitude < 0.001 then
        return true
    end

    return camera.CFrame.LookVector:Dot(offset.Unit) > 0.7
end

local doorCFrame = GetDoorCFrame()
if not doorCFrame then
    return
end

local entity = LoadCustomInstance(101425536134620)
if not entity then
    return
end

if not entity:IsA("Model") then
    entity:Destroy()
    return
end

local eyes, targetPart = FindEyes(entity)
local originalParticles = CaptureParticles(entity)

for emitter in pairs(originalParticles) do
    emitter.Transparency = NumberSequence.new(1)
end

for _, eye in ipairs(eyes) do
    eye.Enabled = false
end

entity:PivotTo(doorCFrame * CFrame.new(0, 0, 10))
entity.Parent = workspace

local roomChanges = 0
local damageConnection
local roomConnection

local function EndEntity()
    if ending then
        return
    end

    ending = true

    if damageConnection then
        damageConnection:Disconnect()
        damageConnection = nil
    end

    if roomConnection then
        roomConnection:Disconnect()
        roomConnection = nil
    end

    task.spawn(function()
        local currentParticles = CaptureParticles(entity)
        FadeParticles(currentParticles, 1, false)

        for _, eye in ipairs(eyes) do
            if eye.Parent then
                eye.Enabled = false
            end
        end

        if entity.Parent then
            entity:Destroy()
        end
    end)
end

roomConnection = latestRoom.Changed:Connect(function()
    roomChanges = roomChanges + 1
    if roomChanges >= 2 then
        EndEntity()
    end
end)

FadeParticles(originalParticles, 2, true)

if ending then
    return
end

if #eyes ~= 3 then
    warn("X-10: expected 3 eyes Attachments with ParticleEmitters; found " .. tostring(#eyes))
end

for _, eye in ipairs(eyes) do
    task.wait(3)

    if ending then
        return
    end

    if eye.Parent then
        eye.Enabled = true
    end
end

if ending or #eyes ~= 3 or not targetPart then
    return
end

local lastDamageTime = -math.huge

damageConnection = RunService.Heartbeat:Connect(function()
    if ending or not entity.Parent then
        return
    end

    if os.clock() - lastDamageTime < 1 then
        return
    end

    if not IsLookingAtEntity(targetPart) then
        return
    end

    local character = player and player.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")

    if humanoid and humanoid.Health > 0 then
        lastDamageTime = os.clock()
        humanoid:TakeDamage(99)
    end
end)
end
function entityBehaviors.TheBoiledOne()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")

local player = Players.LocalPlayer
local latestRoom = ReplicatedStorage:WaitForChild("GameData"):WaitForChild("LatestRoom")

local MODEL_ID = 114369907629692
local AMBIENT_ID = 137177653817621
local RANDOM_IDS = {119223589229162, 121719103873398, 87808103166511}
local HIT_ID = 87290118952161
local EXIT_ID = 73193010308245
local SPAWN_DISTANCE = 10
local HEIGHT_OFFSET = 2
local WAIT_BEFORE_MOVING = 3
local MOVE_DISTANCE = 45
local MOVE_DURATION = 0.8
local ATTACK_RANGE = 5
local LOOK_THRESHOLD = 0.75
local ROOM_CHANGES_TO_EXIT = 5
local FACE_YAW_OFFSET = math.rad(-90)

local function LoadCustomInstance(source)
    local success, result = pcall(function()
        return game:GetObjects("rbxassetid://" .. tostring(source))[1]
    end)

    if not success or not result then
        return nil
    end

    for _, object in ipairs(result:GetDescendants()) do
        if object:IsA("Script") or object:IsA("LocalScript") then
            object:Destroy()
        end
    end

    result.Parent = workspace
    return result
end

local entity = LoadCustomInstance(MODEL_ID)

if not entity then
    return
end

local primary
if entity:IsA("Model") then
    primary = entity:FindFirstChild("RootPart", true)
    if not (primary and primary:IsA("BasePart")) then
        primary = entity.PrimaryPart or entity:FindFirstChildWhichIsA("BasePart", true)
    end
    if primary then
        entity.PrimaryPart = primary
    end
elseif entity:IsA("BasePart") then
    primary = entity
end

if not primary then
    entity:Destroy()
    return
end

for _, object in ipairs(entity:GetDescendants()) do
    if object:IsA("BasePart") then
        object.Anchored = true
        object.CanCollide = false
    end
end

if entity:IsA("BasePart") then
    entity.Anchored = true
    entity.CanCollide = false
end

local function GetPlayerRoot()
    local character = player.Character
    return character and character:FindFirstChild("HumanoidRootPart") or nil
end

local function GetLivingHumanoid()
    if player:GetAttribute("Alive") == false then
        return nil
    end

    local character = player.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    if humanoid and humanoid.Health > 0 then
        return humanoid
    end
    return nil
end

local function FacePlayerAt(position, targetPosition)
    local lookPosition = Vector3.new(targetPosition.X, position.Y, targetPosition.Z)
    if (lookPosition - position).Magnitude > 0.01 then
        entity:PivotTo(CFrame.lookAt(position, lookPosition) * CFrame.Angles(0, FACE_YAW_OFFSET, 0))
    else
        entity:PivotTo(CFrame.new(position) * entity:GetPivot().Rotation)
    end
end

local root = GetPlayerRoot()
local startBasis = root and root.CFrame or (workspace.CurrentCamera and workspace.CurrentCamera.CFrame) or CFrame.new()
local spawnPosition = (startBasis * CFrame.new(0, HEIGHT_OFFSET, SPAWN_DISTANCE)).Position
FacePlayerAt(spawnPosition, root and root.Position or startBasis.Position)

local savedFogStart = Lighting.FogStart
local savedFogEnd = Lighting.FogEnd
local savedFogColor = Lighting.FogColor
local atmosphere = Lighting:FindFirstChildOfClass("Atmosphere")
local createdAtmosphere = false
local originalAtmosphere

if atmosphere then
    originalAtmosphere = {
        Density = atmosphere.Density,
        Haze = atmosphere.Haze,
        Color = atmosphere.Color,
        Decay = atmosphere.Decay,
        Glare = atmosphere.Glare,
        Offset = atmosphere.Offset
    }
else
    atmosphere = Instance.new("Atmosphere")
    atmosphere.Name = "ShadowEntityFog"
    atmosphere.Parent = Lighting
    createdAtmosphere = true
end

Lighting.FogStart = 0
Lighting.FogEnd = 5
Lighting.FogColor = Color3.fromRGB(55, 58, 64)
atmosphere.Density = 1
atmosphere.Haze = 10
atmosphere.Glare = 0
atmosphere.Offset = 0
atmosphere.Color = Color3.fromRGB(72, 76, 83)
atmosphere.Decay = Color3.fromRGB(25, 27, 31)

local fogBlur = Instance.new("DepthOfFieldEffect")
fogBlur.Name = "ShadowEntityDenseFog"
fogBlur.FocusDistance = 2
fogBlur.InFocusRadius = 1
fogBlur.NearIntensity = 0
fogBlur.FarIntensity = 1
fogBlur.Parent = Lighting

local fogRestored = false
local function RestoreFog()
    if fogRestored then
        return
    end

    fogRestored = true
    Lighting.FogStart = savedFogStart
    Lighting.FogEnd = savedFogEnd
    Lighting.FogColor = savedFogColor

    if fogBlur and fogBlur.Parent then
        fogBlur:Destroy()
    end

    if atmosphere then
        if createdAtmosphere then
            atmosphere:Destroy()
        elseif atmosphere.Parent and originalAtmosphere then
            for property, value in pairs(originalAtmosphere) do
                atmosphere[property] = value
            end
        end
    end
end

local active = true
local completed = false
local roomChanges = 0
local roomConnection
local heartbeatConnection
local activeSounds = {}

local function MakeSound(id, parent)
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://" .. tostring(id)
    sound.Volume = 1
    sound.Looped = false
    sound.Parent = parent or SoundService
    activeSounds[sound] = true
    return sound
end

local function InterruptibleWait(seconds)
    local elapsed = 0
    while active and elapsed < seconds do
        elapsed = elapsed + task.wait(math.min(0.1, seconds - elapsed))
    end
    return active
end

local function WaitUntilPlaybackEnds(sound, limit, shouldStop)
    local loadingStart = os.clock()
    while sound.Parent and not sound.IsLoaded and os.clock() - loadingStart < 6 do
        if shouldStop and not active then
            return
        end
        task.wait(0.1)
    end

    local startTime = os.clock()
    local duration = sound.TimeLength > 0 and sound.TimeLength + 1 or 8
    duration = math.min(duration, limit or 20)

    while sound.Parent and sound.IsPlaying and os.clock() - startTime < duration do
        if shouldStop and not active then
            return
        end
        task.wait(0.1)
    end
end

local function StopAllSounds()
    for sound in pairs(activeSounds) do
        activeSounds[sound] = nil
        if sound.Parent then
            sound:Stop()
            sound:Destroy()
        end
    end
end

local function PlayFinalSound(id)
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://" .. tostring(id)
    sound.Volume = 1
    sound.Looped = false
    sound.Parent = SoundService
    sound:Play()
    WaitUntilPlaybackEnds(sound, 20, false)
    sound:Stop()
    sound:Destroy()
end

local function Finish(id)
    if completed then
        return
    end

    completed = true
    active = false

    if roomConnection then
        roomConnection:Disconnect()
        roomConnection = nil
    end

    if heartbeatConnection then
        heartbeatConnection:Disconnect()
        heartbeatConnection = nil
    end

    StopAllSounds()
    RestoreFog()

    task.spawn(function()
        PlayFinalSound(id)
        if entity and entity.Parent then
            entity:Destroy()
        end
    end)
end

roomConnection = latestRoom.Changed:Connect(function()
    if not active then
        return
    end

    roomChanges = roomChanges + 1
    if roomChanges >= ROOM_CHANGES_TO_EXIT then
        Finish(EXIT_ID)
    end
end)

task.spawn(function()
    local ambient = MakeSound(AMBIENT_ID, SoundService)

    while active do
        ambient:Play()
        WaitUntilPlaybackEnds(ambient, 30, true)
        if not active then
            break
        end
        ambient:Stop()
        if not InterruptibleWait(1) then
            break
        end
    end

    activeSounds[ambient] = nil
    if ambient.Parent then
        ambient:Destroy()
    end
end)

task.spawn(function()
    local previousIndex

    while active do
        local index = math.random(1, #RANDOM_IDS)
        if index == previousIndex and #RANDOM_IDS > 1 then
            index = (index % #RANDOM_IDS) + 1
        end
        previousIndex = index

        local sound = MakeSound(RANDOM_IDS[index], SoundService)
        sound:Play()
        WaitUntilPlaybackEnds(sound, 30, true)
        activeSounds[sound] = nil
        if sound.Parent then
            sound:Stop()
            sound:Destroy()
        end

        if not InterruptibleWait(5) then
            break
        end
    end
end)

local function IsLookingAtEntity()
    local camera = workspace.CurrentCamera
    if not camera or not primary.Parent then
        return false
    end

    local from = camera.CFrame.Position
    local toEntity = primary.Position - from

    if toEntity.Magnitude <= 0.01 then
        return true
    end

    if camera.CFrame.LookVector:Dot(toEntity.Unit) < LOOK_THRESHOLD then
        return false
    end

    local _, visible = camera:WorldToViewportPoint(primary.Position)
    if not visible then
        return false
    end

    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    local character = player.Character
    params.FilterDescendantsInstances = character and {character} or {}

    local result = workspace:Raycast(from, toEntity, params)
    return not result or result.Instance:IsDescendantOf(entity)
end

local function CanHitPlayer()
    local character = player.Character
    local targetRoot = GetPlayerRoot()
    local humanoid = GetLivingHumanoid()
    if not character or not targetRoot or not humanoid then
        return nil
    end

    local origin = primary.Position
    local difference = targetRoot.Position - origin
    local distance = difference.Magnitude

    if distance > ATTACK_RANGE or distance < 0.01 then
        return nil
    end

    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = {entity}
    params.IgnoreWater = true

    local hit = workspace:Raycast(origin, difference.Unit * ATTACK_RANGE, params)
    if hit and hit.Instance:IsDescendantOf(character) then
        return humanoid
    end
    return nil
end

local unnoticedTime = 0
local movement

heartbeatConnection = RunService.Heartbeat:Connect(function(dt)
    if not active or not entity.Parent or not primary.Parent then
        return
    end

    local humanoid = GetLivingHumanoid()
    local targetRoot = GetPlayerRoot()

    if not humanoid or not targetRoot then
        unnoticedTime = 0
        movement = nil
        return
    end

    if IsLookingAtEntity() then
        unnoticedTime = 0
        movement = nil
    else
        if movement then
            movement.elapsed = movement.elapsed + dt
            local alpha = math.clamp(movement.elapsed / MOVE_DURATION, 0, 1)
            local eased = alpha * alpha * (3 - 2 * alpha)
            local position = movement.start:Lerp(movement.goal, eased)
            FacePlayerAt(position, targetRoot.Position)

            if alpha >= 1 then
                movement = nil
                unnoticedTime = 0
            end
        else
            unnoticedTime = unnoticedTime + dt
            if unnoticedTime >= WAIT_BEFORE_MOVING then
                unnoticedTime = 0
                local current = entity:GetPivot().Position
                local target = Vector3.new(targetRoot.Position.X, targetRoot.Position.Y + HEIGHT_OFFSET, targetRoot.Position.Z)
                local flatOffset = Vector3.new(target.X - current.X, 0, target.Z - current.Z)
                local travel = math.min(MOVE_DISTANCE, math.max(flatOffset.Magnitude - 1.5, 0))

                if travel > 0.01 then
                    local goal = current + flatOffset.Unit * travel
                    goal = Vector3.new(goal.X, target.Y, goal.Z)
                    movement = {start = current, goal = goal, elapsed = 0}
                    FacePlayerAt(current, targetRoot.Position)
                end
            end
        end
    end

    local hitHumanoid = CanHitPlayer()
    if hitHumanoid then
        hitHumanoid:TakeDamage(100)
        if hitHumanoid.Health <= 0 then
            player:SetAttribute("Alive", false)
        end
        Finish(HIT_ID)
    end
end)
end
function entityBehaviors.A1()
local sound = workspace:WaitForChild("HardCoreSound"):WaitForChild("A1")
if not sound.IsLoaded then sound.Loaded:Wait() end
sound:Play()
end
function entityBehaviors.A2()
local sound = workspace:WaitForChild("HardCoreSound"):WaitForChild("A2")
if not sound.IsLoaded then sound.Loaded:Wait() end
sound:Play()
end
function entityBehaviors.A3()
local sound = workspace:WaitForChild("HardCoreSound"):WaitForChild("A3")
if not sound.IsLoaded then sound.Loaded:Wait() end
sound:Play()
end
function entityBehaviors.A4()
local sound = workspace:WaitForChild("HardCoreSound"):WaitForChild("A4")
if not sound.IsLoaded then sound.Loaded:Wait() end
sound:Play()
end
function entityBehaviors.A5()
local sound = workspace:WaitForChild("HardCoreSound"):WaitForChild("A5")
if not sound.IsLoaded then sound.Loaded:Wait() end
sound:Play()
end
function entityBehaviors.A6()
local sound = workspace:WaitForChild("HardCoreSound"):WaitForChild("A6")
if not sound.IsLoaded then sound.Loaded:Wait() end
sound:Play()
end
function entityBehaviors.A7()
local sound = workspace:WaitForChild("HardCoreSound"):WaitForChild("A7")
if not sound.IsLoaded then sound.Loaded:Wait() end
sound:Play()
end
function entityBehaviors.SEEKS()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer

local function GetRoom()
    local rooms = workspace:FindFirstChild("CurrentRooms")
    local gameData = ReplicatedStorage:FindFirstChild("GameData")

    if not rooms or not gameData then
        return nil
    end

    local latestRoom = gameData:FindFirstChild("LatestRoom")

    if not latestRoom then
        return nil
    end

    return rooms:FindFirstChild(tostring(latestRoom.Value))
end

local function FindFirstBasePartRecursive(instance)
    if instance:IsA("BasePart") then
        return instance
    end

    for _, child in ipairs(instance:GetChildren()) do
        local found = FindFirstBasePartRecursive(child)

        if found then
            return found
        end
    end

    return nil
end

local function LoadModel(id, parent)
    local success, model = pcall(function()
        return game:GetObjects("rbxassetid://" .. tostring(id))[1]
    end)

    if success and model then
        model.Parent = parent or workspace

        for _, obj in ipairs(model:GetDescendants()) do
            if obj:IsA("Script") or obj:IsA("LocalScript") then
                obj:Destroy()
            end
        end

        return model
    end

    return nil
end

local entityModel = LoadModel(96339158471163, workspace)

if not entityModel then
    return
end

local room = GetRoom()

if not room then
    entityModel:Destroy()
    return
end

local entrance = room:FindFirstChild("RoomEntrance")

if not entrance then
    entityModel:Destroy()
    return
end

local targetCF = entrance.CFrame
    * CFrame.new(-15, 0.9, -50)
    * CFrame.Angles(math.rad(0), 45, 0)

local success = pcall(function()
    entityModel:PivotTo(targetCF)
end)

if not success then
    local mainPart = FindFirstBasePartRecursive(entityModel)

    if mainPart then
        mainPart.CFrame = targetCF

        local subPart = mainPart:FindFirstChild("Part")

        if subPart and subPart:IsA("BasePart") then
            subPart.CFrame = mainPart.CFrame
        end
    end
end

local seekModel = entityModel:FindFirstChild("Seek but TIO", true)

if not seekModel or not seekModel:IsA("Model") then
    return
end

local TURN_SPEED = 6
local UPDATE_INTERVAL = 0.1

local nearestRoot = nil
local updateTimer = 0
local isInteracting = false
local rotationConnection
local roomConnection

local function GetNearestPlayer()
    local nearest = nil
    local shortestDistance = math.huge
    local modelPosition = seekModel:GetPivot().Position

    for _, player in ipairs(Players:GetPlayers()) do
        local character = player.Character

        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            local root = character:FindFirstChild("HumanoidRootPart")

            if humanoid and root and humanoid.Health > 0 then
                local distance = (root.Position - modelPosition).Magnitude

                if distance < shortestDistance then
                    shortestDistance = distance
                    nearest = root
                end
            end
        end
    end

    return nearest
end

local function FindLibraryHintPaper()
    for _, player in ipairs(Players:GetPlayers()) do
        local character = player.Character

        if character then
            for _, obj in ipairs(character:GetDescendants()) do
                if obj:IsA("Tool") and obj.Name == "LibraryHintPaper" then
                    return obj
                end
            end
        end
    end

    return nil
end

local function ShowCaption(message)
    pcall(function()
        require(
            LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game
        ).caption(message, true)
    end)
end

local function ExecuteRemoteScript()
    task.spawn(function()
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Not-Guestly/Scripts/refs/heads/main/Viridislight-Jug"))()
        end)
    end)
end

local function RemoveEntity()
    if roomConnection then
        roomConnection:Disconnect()
        roomConnection = nil
    end

    if rotationConnection then
        rotationConnection:Disconnect()
        rotationConnection = nil
    end

    if entityModel and entityModel.Parent then
        entityModel:Destroy()
    end
end

rotationConnection = RunService.Heartbeat:Connect(function(dt)
    if not seekModel:IsDescendantOf(workspace) then
        if rotationConnection then
            rotationConnection:Disconnect()
            rotationConnection = nil
        end

        return
    end

    updateTimer = updateTimer + dt

    if updateTimer >= UPDATE_INTERVAL then
        updateTimer = 0
        nearestRoot = GetNearestPlayer()
    end

    if not nearestRoot or not nearestRoot.Parent then
        return
    end

    local currentCF = seekModel:GetPivot()
    local currentPosition = currentCF.Position
    local targetPosition = nearestRoot.Position

    local lookPosition = Vector3.new(
        targetPosition.X,
        currentPosition.Y,
        targetPosition.Z
    )

    if (lookPosition - currentPosition).Magnitude < 0.01 then
        return
    end

    local targetRotation = CFrame.lookAt(
        currentPosition,
        lookPosition,
        Vector3.yAxis
    )

    local alpha = 1 - math.exp(-TURN_SPEED * dt)

    local newCF = currentCF:Lerp(targetRotation, alpha)

    seekModel:PivotTo(newCF)
end)

local interactionPart = FindFirstBasePartRecursive(seekModel)

if not interactionPart then
    return
end

local attachment = Instance.new("Attachment")
attachment.Name = "InteractionAttachment"
attachment.Position = Vector3.new(0, 2, 0)
attachment.Parent = interactionPart

local prompt = Instance.new("ProximityPrompt")
prompt.Name = "SeekInteraction"
prompt.ActionText = "互动"
prompt.ObjectText = "Seek but TIO"
prompt.Style = Enum.ProximityPromptStyle.Custom
prompt.KeyboardKeyCode = Enum.KeyCode.E
prompt.GamepadKeyCode = Enum.KeyCode.ButtonX
prompt.HoldDuration = 0
prompt.MaxActivationDistance = 12
prompt.RequiresLineOfSight = false
prompt.ClickablePrompt = true
prompt.Enabled = true
prompt.Parent = attachment

local function FinishInteraction()
    isInteracting = false

    if prompt.Parent and entityModel.Parent then
        prompt.Enabled = true
    end
end

local function PlayInteractionSound(onFinished)
    if not interactionPart:IsDescendantOf(workspace) then
        return nil
    end

    local sound = Instance.new("Sound")
    sound.Name = "SeekInteractionSound"
    sound.SoundId = "rbxassetid://100207909526165"
    sound.Volume = 1
    sound.PlaybackSpeed = 1
    sound.Looped = false
    sound.Parent = interactionPart

    sound.Ended:Once(function()
        sound:Destroy()

        if onFinished then
            onFinished()
        end
    end)

    sound:Play()

    return sound
end

prompt.Triggered:Connect(function(player)
    if isInteracting then
        return
    end

    if player and player ~= LocalPlayer then
        return
    end

    if not entityModel.Parent then
        return
    end

    isInteracting = true
    prompt.Enabled = false

    local libraryHintPaper = FindLibraryHintPaper()

    if libraryHintPaper then
        libraryHintPaper:Destroy()

        ExecuteRemoteScript()

        ShowCaption("我可以去交差了!")

        PlayInteractionSound()

        task.wait(3)

        if not entityModel.Parent then
            return
        end

        ShowCaption("谢谢，还有这个给你")

        PlayInteractionSound(FinishInteraction)
    else
        ShowCaption("兄弟，这很好，这是我从楼梯房间得来的真皮沙发。")

        PlayInteractionSound(FinishInteraction)
    end
end)

local latestRoom = ReplicatedStorage.GameData.LatestRoom
local roomChangeCount = 0

roomConnection = latestRoom.Changed:Connect(function()
    roomChangeCount = roomChangeCount + 1

    if roomChangeCount >= 3 then
        RemoveEntity()
    end
end)
end
function entityBehaviors.HardcoreHoncho()
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CurrentRooms = Workspace:WaitForChild("CurrentRooms")
local LiveEntities = Workspace:WaitForChild("LiveEntities")

local partNames = {
    "LeftAnkle",
    "LeftLowerLeg",
    "LeftMiddleLeg",
    "LeftUpperLeg",
    "RightAnkle",
    "RightLowerLeg",
    "RightMiddleLeg",
    "RightUpperLeg",
    "Pelvis"
}

local partColor = Color3.fromRGB(199, 175, 158)
local particleColor = ColorSequence.new(Color3.fromRGB(100, 0, 2))
local random = Random.new()
local symbols = {"!", "@", "3", "2", "*", "&"}

local function recolor(rig)
    local coloredParts = 0

    for _, name in ipairs(partNames) do
        local part = rig:FindFirstChild(name, true)
        if part and part:IsA("MeshPart") then
            part.Color = partColor
            coloredParts += 1
        end
    end

    local coloredParticles = 0
    local head = rig:FindFirstChild("Head", true)
    if head then
        for _, instance in ipairs(head:GetDescendants()) do
            if instance:IsA("ParticleEmitter") and instance.Parent:IsA("Attachment") then
                instance.Color = particleColor
                coloredParticles += 1
            end
        end
    end

    return coloredParts == #partNames and coloredParticles > 0
end

local maxNumber = -math.huge
for _, room in ipairs(CurrentRooms:GetChildren()) do
    if room:IsA("Model") then
        local number = tonumber(room.Name)
        if number and number > maxNumber then
            maxNumber = number
        end
    end
end

if maxNumber > -math.huge then
    local previousRoom = CurrentRooms:FindFirstChild(tostring(maxNumber - 1))
    if previousRoom then
        local setup = previousRoom:FindFirstChild("ConfrontationCutsceneSetup", true)
        local rig = setup and setup:FindFirstChild("HonchoRigInitial", true)
        if rig then
            recolor(rig)
        end
    end
end

local entityConnection
local rigDescendantConnection
local rigFinished = false
local archiveStarted = false
local archiveActive = false
local roomAddedConnection
local latestRoomConnection
local roomConnections = {}
local labelStates = {}

local function scramble(original)
    local length = math.max(8, utf8.len(original) or #original)
    local result = table.create(length)
    for i = 1, length do
        result[i] = symbols[random:NextInteger(1, #symbols)]
    end
    return table.concat(result)
end

local function watchLabel(label)
    if not archiveActive or labelStates[label] then
        return
    end

    if not (label:IsA("TextLabel") or label:IsA("TextButton") or label:IsA("TextBox")) then
        return
    end

    local state = {original = label.Text}
    labelStates[label] = state

    task.spawn(function()
        while archiveActive and label.Parent do
            local finishAt = os.clock() + 10
            while archiveActive and label.Parent and os.clock() < finishAt do
                label.Text = scramble(state.original)
                task.wait(0.12)
            end

            if not archiveActive or not label.Parent then
                break
            end

            label.Text = state.original
            task.wait(2)
        end

        if label.Parent then
            label.Text = state.original
        end
    end)
end

local function scanDeposit(deposit)
    if not archiveActive or not deposit:IsA("Model") or deposit.Name ~= "ArchivesPackageDeposit" then
        return
    end

    for _, screen in ipairs(deposit:GetDescendants()) do
        if screen.Name == "Screen" and screen:IsA("BasePart") then
            for _, textContainer in ipairs(screen:GetDescendants()) do
                if textContainer.Name == "Text" then
                    for _, label in ipairs(textContainer:GetDescendants()) do
                        if label.Name == "Label" then
                            watchLabel(label)
                        end
                    end
                end
            end
        end
    end
end

local function scanRoom(room)
    if not archiveActive then
        return
    end

    for _, instance in ipairs(room:GetDescendants()) do
        if instance.Name == "ArchivesPackageDeposit" and instance:IsA("Model") then
            scanDeposit(instance)
        end
    end
end

local function watchRoom(room)
    if not archiveActive or not room:IsA("Model") or not tonumber(room.Name) or roomConnections[room] then
        return
    end

    roomConnections[room] = room.DescendantAdded:Connect(function(instance)
        if not archiveActive then
            return
        end

        if instance.Name == "ArchivesPackageDeposit" and instance:IsA("Model") then
            scanDeposit(instance)
        else
            local deposit = instance:FindFirstAncestor("ArchivesPackageDeposit")
            if deposit and deposit:IsDescendantOf(room) then
                scanDeposit(deposit)
            end
        end
    end)

    scanRoom(room)
end

local function stopArchives()
    if not archiveActive then
        return
    end

    archiveActive = false

    if roomAddedConnection then
        roomAddedConnection:Disconnect()
        roomAddedConnection = nil
    end

    if latestRoomConnection then
        latestRoomConnection:Disconnect()
        latestRoomConnection = nil
    end

    for room, connection in pairs(roomConnections) do
        connection:Disconnect()
        roomConnections[room] = nil
    end

    for label, state in pairs(labelStates) do
        if label.Parent then
            label.Text = state.original
        end
        labelStates[label] = nil
    end
end

local function startArchives()
    if archiveStarted then
        return
    end

    archiveStarted = true
    local latestRoom = ReplicatedStorage:WaitForChild("GameData"):WaitForChild("LatestRoom")
    archiveActive = true
    local changes = 0

    latestRoomConnection = latestRoom.Changed:Connect(function()
        changes += 1
        if changes >= 4 then
            stopArchives()
        end
    end)

    roomAddedConnection = CurrentRooms.ChildAdded:Connect(watchRoom)

    for _, room in ipairs(CurrentRooms:GetChildren()) do
        watchRoom(room)
    end
end

local function finishRig()
    if rigFinished then
        return
    end

    rigFinished = true

    if entityConnection then
        entityConnection:Disconnect()
        entityConnection = nil
    end

    if rigDescendantConnection then
        rigDescendantConnection:Disconnect()
        rigDescendantConnection = nil
    end

    startArchives()
end

local function watchRig(rig)
    if rigFinished or not rig:IsA("Model") or rig.Name ~= "HonchoRig" then
        return
    end

    if entityConnection then
        entityConnection:Disconnect()
        entityConnection = nil
    end

    if rigDescendantConnection then
        rigDescendantConnection:Disconnect()
        rigDescendantConnection = nil
    end

    rigDescendantConnection = rig.DescendantAdded:Connect(function()
        if not rigFinished and recolor(rig) then
            finishRig()
        end
    end)

    if recolor(rig) then
        finishRig()
    end
end

entityConnection = LiveEntities.ChildAdded:Connect(watchRig)

for _, entity in ipairs(LiveEntities:GetChildren()) do
    if entity:IsA("Model") and entity.Name == "HonchoRig" then
        watchRig(entity)
        break
    end
end
end
function entityBehaviors.JEFFDEATH()
for _, model in ipairs(workspace:GetChildren()) do
    if model.Name == "JeffTheKiller" then
        local humanoid = model:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.Health = 0
        end
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://102588764079889"
        sound.Volume = 1
        sound.Parent = workspace
        sound:Play()
        sound.Ended:Connect(function()
            sound:Destroy()
        end)
    end
end
end
function entityBehaviors.Baldi()
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local player = Players.LocalPlayer

while not player do
	task.wait()
	player = Players.LocalPlayer
end

local LatestRoom = ReplicatedStorage:WaitForChild("GameData"):WaitForChild("LatestRoom")

local function GetLargestRoom()
	local rooms = workspace:FindFirstChild("CurrentRooms")
	if not rooms then return nil end

	local largest
	local max = -1

	for _, room in pairs(rooms:GetChildren()) do
		local id = tonumber(room.Name)
		if id and id > max then
			max = id
			largest = room
		end
	end

	return largest
end

local function GetDoorCFrame(room)
	local door = room and room:FindFirstChild("Door") and room.Door:FindFirstChild("Door")
	if door and door:IsA("BasePart") then
		return door.CFrame
	end
end

local function LoadBaldi()
	local success, model = pcall(function()
		return game:GetObjects("rbxassetid://84406407528761")[1]
	end)

	if not success or not model then
		return nil
	end

	for _, v in pairs(model:GetDescendants()) do
		if v:IsA("Script") or v:IsA("LocalScript") then
			v:Destroy()
		end
	end

	return model
end

local room = GetLargestRoom()
if not room then return end

local cf = GetDoorCFrame(room)
if not cf then return end

local baldi = LoadBaldi()
if not baldi then return end

baldi:PivotTo(cf)
baldi.Parent = workspace

local destroyed = false
local canStart = false
local triggered = false

local protectDelete = false
local megaSound = nil
local stopMathGame = nil

local function DestroyBaldi()
	if destroyed then return end
	destroyed = true

	if megaSound then
		megaSound:Stop()
		megaSound = nil
	end

	if stopMathGame then
		stopMathGame()
	end

	if baldi and baldi.Parent then
		baldi:Destroy()
	end
end

local roomChanges = 0

LatestRoom.Changed:Connect(function()
	roomChanges += 1

	if roomChanges == 1 then
		local s1 = Instance.new("Sound")
		s1.SoundId = "rbxassetid://17556446241"
		s1.Volume = 1
		s1.Parent = workspace
		s1:Play()

		s1.Ended:Connect(function()
			s1:Destroy()

			local s2 = Instance.new("Sound")
			s2.SoundId = "rbxassetid://100704961414689"
			s2.Volume = 1
			s2.Parent = workspace
			s2:Play()

			s2.Ended:Connect(function()
				s2:Destroy()
				canStart = true
			end)
		end)
	end

	if roomChanges >= 3 then
		if not protectDelete then
			DestroyBaldi()
		end
	end
end)

local function StartMathGame()
	local Main_Game = require(player.PlayerGui.MainUI.Initiator.Main_Game)

	math.randomseed(tick())

	local questionIndex = 1
	local answer = nil
	local currentQuestion = ""

	local active = false
	local gameFinished = false
	local wrongCount = 0

	local chatConnection

	stopMathGame = function()
		gameFinished = true
		active = false
		answer = nil
		currentQuestion = ""

		if chatConnection then
			chatConnection:Disconnect()
			chatConnection = nil
		end
	end

	local function createQuestion(level)

		local a,b,c,x,result

		if level == 1 then

			a = math.random(1,5)
			b = math.random(1,10)
			x = math.random(1,10)

			answer = a*x+b

			return "Given f(x)="..a.."x+"..b..", find f("..x..")"

		elseif level == 2 then

			a = math.random(2,8)
			b = math.random(1,10)
			x = math.random(1,10)

			result = a*x+b
			answer = x

			return "Given f(x)="..a.."x+"..b..", if f(x)="..result..", find x"

		elseif level == 3 then

			a = math.random(2,8)
			b = math.random(-10,10)
			x = math.random(1,10)

			local textB

			if b >= 0 then
				textB = "+"..b
			else
				textB = b
			end

			answer = a*x+b

			return "Given f(x)="..a.."x"..textB..", find f("..x..")"

		elseif level == 4 then

			a = math.random(1,5)
			b = math.random(-5,5)
			c = math.random(-10,10)
			x = math.random(1,8)

			answer = a*x*x+b*x+c

			return "Given f(x)="..a.."x²+"..b.."x+"..c..", find f("..x..")"

		elseif level == 5 then

			a = math.random(1,5)
			b = math.random(-5,5)
			c = math.random(-10,10)
			x = math.random(1,8)

			result = a*x*x+b*x+c
			answer = x

			return "Given f(x)="..a.."x²+"..b.."x+"..c..", if f(x)="..result..", find x"

		end

	end

	local function repeatQuestion()

		task.spawn(function()

			while active and not gameFinished do

				Main_Game.caption(
					"Question "..questionIndex..": "..currentQuestion,
					true
				)

				task.wait(5)

			end

		end)

	end

	local function nextQuestion()

		if questionIndex > 5 then

			gameFinished = true
			active = false
			answer = nil
			currentQuestion = ""

			Main_Game.caption(
				"Game Finished!",
				true
			)

			if chatConnection then
				chatConnection:Disconnect()
				chatConnection = nil
			end

			DestroyBaldi()

			return

		end

		currentQuestion = createQuestion(questionIndex)

		active = true

		Main_Game.caption(
			"Question "..questionIndex..": "..currentQuestion,
			true
		)

		repeatQuestion()

	end

	chatConnection = player.Chatted:Connect(function(message)

		if gameFinished then
			return
		end

		local num = tonumber(message)

		if not num then
			return
		end

		if num == answer then

			active = false

			Main_Game.caption(
				"Correct!",
				true
			)

			task.wait(1)

			questionIndex += 1

			nextQuestion()

		else

			wrongCount += 1

			Main_Game.caption(
				"Wrong!",
				true
			)

			if wrongCount >= 2 then

				gameFinished = true
				active = false
				answer = nil
				currentQuestion = ""

				Main_Game.caption(
					"Game Failed!",
					true
				)

				if chatConnection then
					chatConnection:Disconnect()
					chatConnection = nil
				end

				if megaSound then
					megaSound:Stop()
				end

				protectDelete = true

			end

		end

	end)

	nextQuestion()

end

RunService.Heartbeat:Connect(function()

	if destroyed or triggered or not canStart then
		return
	end

	if not baldi.Parent then
		return
	end


	local target =
		baldi.PrimaryPart
		or baldi:FindFirstChildWhichIsA("BasePart")


	if not target then
		return
	end


	for _,plr in ipairs(Players:GetPlayers()) do


		local character = plr.Character

		local humanoid =
			character and character:FindFirstChildOfClass("Humanoid")


		local root =
			character and character:FindFirstChild("HumanoidRootPart")
		if humanoid
		and humanoid.Health > 0
		and root then


			local distance =
				(root.Position - target.Position).Magnitude


			if distance <= 15 then


				triggered = true
				megaSound =
					baldi:FindFirstChild(
						"Baldi Mega Mix",
						true
					)


				if megaSound then
					megaSound:Play()
				end

				StartMathGame()


				break

			end

		end

	end

end)
end

function entityBehaviors.Baldi2()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local LatestRoom = ReplicatedStorage:WaitForChild("GameData"):WaitForChild("LatestRoom")

local function StopMathGameAndMusic()

	for _,v in ipairs(workspace:GetDescendants()) do
		if v:IsA("Sound") then
			v:Stop()
		end
	end

	local gui = player:FindFirstChild("PlayerGui")
	if gui then
		local mainUI = gui:FindFirstChild("MainUI")
		if mainUI then
			local caption = mainUI:FindFirstChild("Caption", true)
			if caption and caption:IsA("TextLabel") then
				caption.Text = ""
			end
		end
	end

	pcall(function()
		for _,connection in ipairs(getconnections(player.Chatted)) do
			connection:Disable()
		end
	end)
end

StopMathGameAndMusic()

local baldi

for _,v in ipairs(workspace:GetDescendants()) do
	if v:IsA("Model") and v.Name == "Baldi" then
		baldi = v
		break
	end
end

if not baldi then
	return
end

local destroyed = false
local damageDone = false
local targetPlayer

local function DestroyBaldi()
	if destroyed then return end
	destroyed = true

	if baldi and baldi.Parent then
		baldi:Destroy()
	end
end

local baldiPart = baldi:FindFirstChild("baldi", true)
if not baldiPart then
	return
end

local attachment1 = baldiPart:FindFirstChild("Attachment1")
local attachment2 = baldiPart:FindFirstChild("Attachment2")

local baldi2Particle

if attachment1 then
	local old = attachment1:FindFirstChild("baldi")
	if old and old:IsA("ParticleEmitter") then
		old:Destroy()
	end
end

if attachment2 then
	baldi2Particle = attachment2:FindFirstChild("baldi2")
	if baldi2Particle and baldi2Particle:IsA("ParticleEmitter") then
		baldi2Particle.Enabled = true
	end
end

task.wait(5)

local root = baldi.PrimaryPart or baldi:FindFirstChildWhichIsA("BasePart")
if not root then return end

local nearest = math.huge

for _,plr in ipairs(Players:GetPlayers()) do
	local char = plr.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")

	if hrp then
		local d = (root.Position - hrp.Position).Magnitude
		if d < nearest then
			nearest = d
			targetPlayer = plr
		end
	end
end

if not targetPlayer then return end

local function PlayMoveSound()

	local sound = Instance.new("Sound")
	sound.SoundId = "rbxassetid://1841427728"
	sound.Volume = 1
	sound.Parent = baldi
	sound:Play()

	if baldi2Particle then
		baldi2Particle.Texture = "rbxassetid://15951405914"

		task.delay(0.15,function()
			if baldi2Particle then
				baldi2Particle.Texture = "rbxassetid://15953172586"
			end
		end)
	end

	sound.Ended:Connect(function()
		sound:Destroy()
	end)
end

local function Damage()

	if damageDone then return end
	damageDone = true

	local humanoid = targetPlayer.Character and targetPlayer.Character:FindFirstChildOfClass("Humanoid")

	if humanoid then
		humanoid:TakeDamage(100)

		local sound = Instance.new("Sound")
		sound.SoundId = "rbxassetid://98207961689599"
		sound.Parent = workspace
		sound:Play()

		sound.Ended:Connect(function()
			sound:Destroy()
			DestroyBaldi()
		end)
	end
end

local function RayCheck()

	if damageDone then return end

	local hrp = targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart")
	local root = baldi.PrimaryPart or baldi:FindFirstChildWhichIsA("BasePart")

	if not hrp or not root then return end

	local direction = hrp.Position - root.Position

	if direction.Magnitude <= 15 then
		Damage()
	end
end

local function WatchDeath(character)

	local hum = character:WaitForChild("Humanoid")

	hum.Died:Connect(function()
		DestroyBaldi()
	end)
end

if targetPlayer.Character then
	WatchDeath(targetPlayer.Character)
end

targetPlayer.CharacterAdded:Connect(function(character)
	if not destroyed then
		WatchDeath(character)
	end
end)

task.spawn(function()

	while not destroyed do

		task.wait(3)

		local hrp = targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart")
		local root = baldi.PrimaryPart or baldi:FindFirstChildWhichIsA("BasePart")

		if hrp and root then

			local direction = Vector3.new(
				hrp.Position.X-root.Position.X,
				0,
				hrp.Position.Z-root.Position.Z
			)

			if direction.Magnitude > 0 then

				local pos = root.Position + direction.Unit * 20

				baldi:PivotTo(
					CFrame.new(pos.X,pos.Y-2,pos.Z)
				)

				PlayMoveSound()

			end
		end
	end
end)

local connection
connection = RunService.Heartbeat:Connect(function()

	if destroyed then
		connection:Disconnect()
		return
	end

	RayCheck()
end)

local roomCount = 0

LatestRoom.Changed:Connect(function()

	roomCount += 1

	if roomCount >= 20 then

		if connection then
			connection:Disconnect()
		end

		DestroyBaldi()

	end
end)

end
function entityBehaviors.broadcast()
loadstring(game:HttpGet("https://github.com/Zero0Star/RipperNewSound/blob/master/AiNew2.lua?raw=true"))()
end
function entityBehaviors.ai2()
loadstring(game:HttpGet("https://github.com/Zero0Star/RipperNewSound/blob/master/AiNew3.lua?raw=true"))()
end
local entityConfig = {
    ["rbxassetid://40"] = entityBehaviors.SA90,
    ["rbxassetid://42"] = entityBehaviors.OSAB,
    ["rbxassetid://43"] = entityBehaviors.TUMA,
    ["rbxassetid://44"] = entityBehaviors.Hunger,
    ["rbxassetid://46"] = entityBehaviors.bkeyes,
    ["rbxassetid://45"] = entityBehaviors.HIMS,
    ["rbxassetid://47"] = entityBehaviors.dread,
    ["rbxassetid://48"] = entityBehaviors.MOVERS,
    ["rbxassetid://49"] = entityBehaviors.JEFFXZ,
    ["rbxassetid://50"] = entityBehaviors.JEFFZR,
    ["rbxassetid://51"] = entityBehaviors.MT,
    ["rbxassetid://52"] = entityBehaviors.MM,
    ["rbxassetid://53"] = entityBehaviors.MF,
    ["rbxassetid://54"] = entityBehaviors.munci1,
    ["rbxassetid://55"] = entityBehaviors.A20,
    ["rbxassetid://56"] = entityBehaviors.Honcho,
    ["rbxassetid://57"] = entityBehaviors.A50,
    ["rbxassetid://58"] = entityBehaviors.TheBoiledOne,
    ["rbxassetid://59"] = entityBehaviors.A1,
    ["rbxassetid://60"] = entityBehaviors.A2,
    ["rbxassetid://61"] = entityBehaviors.A3,
    ["rbxassetid://62"] = entityBehaviors.A4,
    ["rbxassetid://63"] = entityBehaviors.A5,
    ["rbxassetid://64"] = entityBehaviors.A6,
    ["rbxassetid://65"] = entityBehaviors.A7,
    ["rbxassetid://66"] = entityBehaviors.broadcast,
    ["rbxassetid://67"] = entityBehaviors.ai2,
    ["rbxassetid://68"] = entityBehaviors.SEEKS,
    ["rbxassetid://69"] = entityBehaviors.HardcoreHoncho,
    ["rbxassetid://70"] = entityBehaviors.JEFFDEATH,
    ["rbxassetid://71"] = entityBehaviors.Baldi,
    ["rbxassetid://72"] = entityBehaviors.Baldi2,
    ["rbxassetid://41"] = entityBehaviors.WH1T3
}
local checkedEntities = {}

local CONTAINER_NAMES = {"############", "Scary Entity"}

local function universalCheckSound(sound)
    if not sound:IsA("Sound") then return end

    local soundId = sound.SoundId
    local targetBehavior = entityConfig[soundId]

    if targetBehavior then
        local parent = sound.Parent

        if parent and table.find(CONTAINER_NAMES, parent.Name) then
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

        for _, containerName in ipairs(CONTAINER_NAMES) do
            local container = entity:FindFirstChild(containerName)
            if container then
                for _, child in pairs(container:GetChildren()) do
                    universalCheckSound(child)
                end
            end
        end
    end
end
local hint = Instance.new("Hint", Workspace)
hint.Text = "Loading... Doors HardCoreTwo V10.6 By HeavenNow :)"
game.Debris:AddItem(hint, 3)
