if workspace:FindFirstChild("HardcoreFour") then
    return
end
local marker = Instance.new("BoolValue")
marker.Name = "HardcoreFour"
marker.Value = true
marker.Parent = workspace
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
local achievementGiver = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Custom%20Achievements/Source.lua"))()
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
    entityPart.CFrame = humanoidRootPart.CFrame * CFrame.new(0, 0, 20)
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

startDamageLoop(s)

game.ReplicatedStorage.GameData.LatestRoom.Changed:Wait()
s:Destroy()
if damageConnection then
    damageConnection:Disconnect()
end
end

function entityBehaviors.kITTY()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local function GetRoom()
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

local function isPlayerLookingAtModel(model)
    local player = Players.LocalPlayer
    local character = player.Character
    if not character then return false end
    
    local head = character:FindFirstChild("Head")
    if not head then return false end
    
    local camera = Workspace.CurrentCamera
    if not camera then return false end
    
    local modelPosition
    if model:IsA("Model") then
        if model.PrimaryPart then
            modelPosition = model.PrimaryPart.Position
        else
            local primary = model:FindFirstChildWhichIsA("BasePart")
            if primary then
                modelPosition = primary.Position
            else
                return false
            end
        end
    else
        modelPosition = model.Position
    end
    
    local cameraCFrame = camera.CFrame
    local cameraDirection = cameraCFrame.LookVector
    local toModel = (modelPosition - cameraCFrame.Position).Unit
    
    local dot = cameraDirection:Dot(toModel)
    return dot > 0.9
end

local function raycastToPlayer(model, maxDistance)
    local player = Players.LocalPlayer
    local character = player.Character
    if not character then return false end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return false end
    
    local modelPosition
    if model:IsA("Model") then
        if model.PrimaryPart then
            modelPosition = model.PrimaryPart.Position
        else
            local primary = model:FindFirstChildWhichIsA("BasePart")
            if primary then
                modelPosition = primary.Position
            else
                return false
            end
        end
    else
        modelPosition = model.Position
    end
    
    local direction = (humanoidRootPart.Position - modelPosition)
    local distance = direction.Magnitude
    
    if distance <= maxDistance then
        local raycastParams = RaycastParams.new()
        raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
        raycastParams.FilterDescendantsInstances = {model}
        raycastParams.IgnoreWater = true
        
        local raycastResult = Workspace:Raycast(
            modelPosition,
            direction.Unit * maxDistance,
            raycastParams
        )
        
        if raycastResult then
            local hitPart = raycastResult.Instance
            if hitPart and hitPart:IsDescendantOf(character) then
                return true
            end
        end
    end
    
    return false
end

local function updateParticleVisibility(model, isVisible)
    if not model then return end
    
    local ObsessionNew = model:FindFirstChild("ObsessionNew")
    if not ObsessionNew then
        ObsessionNew = model:FindFirstChild("Obsession")
    end
    
    if ObsessionNew then
        local attachment = ObsessionNew:FindFirstChildOfClass("Attachment")
        if attachment then
            local particleEmitter = attachment:FindFirstChildOfClass("ParticleEmitter")
            if particleEmitter then
                particleEmitter.Transparency = NumberSequence.new(isVisible and 1 or 0)
            end
        end
    end
end

local currentRoom = GetRoom()
if not currentRoom then
    return
end

local assetsFolder = currentRoom:FindFirstChild("Assets")
if not assetsFolder then
    return
end

local pillars = {}
for _, child in ipairs(assetsFolder:GetChildren()) do
    if child.Name == "Pillar" and child:IsA("Model") then
        table.insert(pillars, child)
    end
end

if #pillars == 0 then
    return
end

local randomPillar = pillars[math.random(1, #pillars)]

local s = LoadCustomInstance(88484943740859)
if not s then
    return
end

local Kitty = s:FindFirstChild("Kitty")
if not Kitty and s.Name == "Kitty" then
    Kitty = s
end

if randomPillar.PrimaryPart then
    if s:IsA("Model") then
        if s.PrimaryPart then
            s:SetPrimaryPartCFrame(randomPillar.PrimaryPart.CFrame + Vector3.new(5, 0, 0))
        else
            local primary = s:FindFirstChildWhichIsA("BasePart")
            if primary then
                s.PrimaryPart = primary
                s:SetPrimaryPartCFrame(randomPillar.PrimaryPart.CFrame + Vector3.new(5, 0, 0))
            end
        end
    else
        local entity = s:FindFirstChildWhichIsA("BasePart")
        if entity then
            entity.CFrame = randomPillar.PrimaryPart.CFrame + Vector3.new(5, 0, 0)
            if entity:FindFirstChild("Part") then
                entity.Part.CFrame = entity.CFrame
            end
        end
    end
else
    local pillarBasePart = randomPillar:FindFirstChildWhichIsA("BasePart")
    if pillarBasePart then
        if s:IsA("Model") then
            if s.PrimaryPart then
                s:SetPrimaryPartCFrame(pillarBasePart.CFrame + Vector3.new(2, 0, 0))
            else
                local primary = s:FindFirstChildWhichIsA("BasePart")
                if primary then
                    s.PrimaryPart = primary
                    s:SetPrimaryPartCFrame(pillarBasePart.CFrame + Vector3.new(2, 0, 0))
                end
            end
        else
            local entity = s:FindFirstChildWhichIsA("BasePart")
            if entity then
                entity.CFrame = pillarBasePart.CFrame + Vector3.new(2, 0, 0)
                if entity:FindFirstChild("Part") then
                    entity.Part.CFrame = entity.CFrame
                end
            end
        end
    end
end

local canHide = false
local hasHidden = false
local spawnTime = tick()

local raycastConnection
raycastConnection = RunService.Heartbeat:Connect(function()
    if not s or not s.Parent then
        raycastConnection:Disconnect()
        return
    end
    
    if not canHide then
        if tick() - spawnTime >= 5 then
            canHide = true
        else
            return
        end
    end
    
    if hasHidden then
        return
    end
    
    local inRange = raycastToPlayer(s, 12)
    local isLooking = isPlayerLookingAtModel(s)
    
    if inRange or isLooking then
        updateParticleVisibility(s, true)
        hasHidden = true
    end
end)

game.ReplicatedStorage.GameData.LatestRoom.Changed:Wait()
if raycastConnection then
    raycastConnection:Disconnect()
end
s:Destroy()
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
                local NewHealth = Humanoid.Health - 5
                
                if NewHealth <= 0 then
                    Player:SetAttribute("Alive", false)
                    if game.ReplicatedStorage:FindFirstChild("Kill") then
                        game.ReplicatedStorage.Kill:FireServer(Player)
                    end
                else
                    Humanoid.Health = NewHealth
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

startDamageLoop(s)

game.ReplicatedStorage.GameData.LatestRoom.Changed:Wait()
s:Destroy()
if damageConnection then
    damageConnection:Disconnect()
end
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
for i = 1, 9 do
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

function entityBehaviors.DEPTH1()
local TweenService = game:GetService("TweenService")
local targetColor = Color3.fromRGB(21, 0, 255)
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
local entity = spawner.Create({Entity = {Name = "Depth",Asset = "93356386746722",HeightOffset = 1},Lights = {Flicker = {Enabled = false,Duration = 10},Shatter = false,Repair = false},Earthquake = {Enabled = false},CameraShake = {Enabled = true,
Range = 100,Values = {10, 30, 0.1, 1}},Movement = {Speed = 180,Delay = 2,Reversed = false},Rebounding = {Enabled = true,Type = "ambush",Min = 4,Max = 4,Delay = math.random(10, 30) / 10},
Damage = {Enabled = false,Range = 99,Amount = 125},Crucifixion = {Enabled = true,Range = 100,Resist = false,Break = true},Death = {
Type = "Guiding",Hints = {"你死于Depth", "当灯光变蓝时他会出现", "他会上锁当前房间的门", "所以务必尽快离开!"},Cause = "Depth"}})
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

function entityBehaviors.coomon()
function DEATHMESSAGE(messages, deathCause)
    spawn(function()
        for _ = 1, 50 do
            wait()
            game:GetService("ReplicatedStorage").GameStats["Player_" .. game.Players.LocalPlayer.Name].Total.DeathCause.Value = deathCause
            firesignal(game:GetService("ReplicatedStorage").RemotesFolder.DeathHint.OnClientEvent, messages, "Blue")
        end
    end)
end

local models = game:GetObjects("rbxassetid://80161041605547")
local figureModel = models[1]
figureModel.Parent = workspace

local room50 = workspace.CurrentRooms["50"]
local startModel = room50:FindFirstChild("Door", true)

if not startModel then
    return
end

local startPart = startModel:FindFirstChild("Hidden")
if not startPart then
    return
end

local figureNodesFolder = workspace.CurrentRooms["50"].FigureSetup.FigureNodes
local allWaypoints = {}

for _, waypoint in pairs(figureNodesFolder:GetChildren()) do
    if waypoint:IsA("BasePart") then
        table.insert(allWaypoints, waypoint)
    end
end

if #allWaypoints == 0 then
    return
end

if not figureModel.PrimaryPart then
    for _, part in pairs(figureModel:GetDescendants()) do
        if part:IsA("BasePart") then
            figureModel.PrimaryPart = part
            break
        end
    end
end

if not figureModel.PrimaryPart then
    return
end

local startHeightOffset = 3
local startPos = Vector3.new(
    startPart.Position.X,
    startPart.Position.Y + startHeightOffset,
    startPart.Position.Z
)

if figureModel and figureModel.PrimaryPart then
    figureModel:SetPrimaryPartCFrame(CFrame.new(startPos))
end

local function moveToPosition(targetPosition, speed)
    if not figureModel or not figureModel.PrimaryPart then
        return
    end
    
    local startPos = figureModel.PrimaryPart.Position
    local endPos = Vector3.new(
        targetPosition.X,
        targetPosition.Y + startHeightOffset,
        targetPosition.Z
    )
    
    local distance = (endPos - startPos).Magnitude
    if distance == 0 then
        return
    end
    
    local duration = distance / speed
    local startTime = tick()
    
    local RunService = game:GetService("RunService")
    local connection
    connection = RunService.Heartbeat:Connect(function(deltaTime)
        if not figureModel or not figureModel.PrimaryPart then
            if connection then
                connection:Disconnect()
            end
            return
        end
        
        local elapsed = tick() - startTime
        local progress = math.min(elapsed / duration, 1)
        
        local currentPos = Vector3.new(
            startPos.X + (endPos.X - startPos.X) * progress,
            startPos.Y + (endPos.Y - startPos.Y) * progress,
            startPos.Z + (endPos.Z - startPos.Z) * progress
        )
        
        figureModel:SetPrimaryPartCFrame(CFrame.new(currentPos))
        
        if progress >= 1 and connection then
            connection:Disconnect()
        end
    end)
    
    while tick() - startTime < duration do
        wait()
    end
    
    if figureModel and figureModel.PrimaryPart then
        figureModel:SetPrimaryPartCFrame(CFrame.new(endPos))
    end
end

local function getNearestWaypoint(currentPos, remainingWaypoints)
    local nearest = nil
    local nearestDistance = math.huge
    
    for _, waypoint in pairs(remainingWaypoints) do
        local waypointWithOffset = Vector3.new(
            waypoint.Position.X,
            waypoint.Position.Y + startHeightOffset,
            waypoint.Position.Z
        )
        local distance = (waypointWithOffset - currentPos).Magnitude
        if distance < nearestDistance then
            nearestDistance = distance
            nearest = waypoint
        end
    end
    
    return nearest
end

local function setupAttackDetection()
    local isAttacking = false
    local attackRange = 10
    local attackCooldown = 0.5
    local deathMessages = {
        "你被Common Sence击败了...",
        "它会沿着固定路径移动，但能感知到你的存在",
        "当它靠近时，它会烧毁附近的路径",
        "保持距离，寻找安全的位置"
    }
    
    spawn(function()
        while figureModel and figureModel.Parent do
            wait(attackCooldown)
            
            local player = game.Players.LocalPlayer
            if player and player.Character and player.Character:FindFirstChild("Humanoid") then
                local character = player.Character
                local humanoid = character:FindFirstChild("Humanoid")
                local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                
                if humanoid and humanoidRootPart and humanoid.Health > 0 then
                    if not figureModel or not figureModel.PrimaryPart then
                        break
                    end
                    
                    local entityPosition = figureModel.PrimaryPart.Position
                    local playerPosition = humanoidRootPart.Position
                    local distance = (playerPosition - entityPosition).Magnitude
                    
                    if distance <= attackRange then
                        local rayDirection = (playerPosition - entityPosition).Unit
                        local ray = Ray.new(entityPosition, rayDirection * attackRange)
                        
                        local ignoreList = {figureModel}
                        local hitPart, hitPosition = workspace:FindPartOnRayWithIgnoreList(ray, ignoreList)
                        
                        if hitPart and hitPart:IsDescendantOf(character) then
                            if not isAttacking then
                                isAttacking = true
                                
                                humanoid:TakeDamage(70)
                                
                                DEATHMESSAGE(deathMessages, "Common Sence")
                                
                                wait(1)
                                isAttacking = false
                            end
                        end
                    end
                end
            end
        end
    end)
end

local function moveThroughWaypoints()
    if not figureModel or not figureModel.PrimaryPart then
        return
    end
    
    local remainingWaypoints = {}
    for _, wp in pairs(allWaypoints) do
        table.insert(remainingWaypoints, wp)
    end
    
    local visitedWaypoints = {}
    local currentPos = figureModel.PrimaryPart.Position
    
    while #remainingWaypoints > 0 do
        if not figureModel or not figureModel.PrimaryPart then
            break
        end
        
        local nearest = getNearestWaypoint(currentPos, remainingWaypoints)
        if nearest then
            moveToPosition(nearest.Position, 14)
            
            if not figureModel or not figureModel.PrimaryPart then
                break
            end
            
            currentPos = figureModel.PrimaryPart.Position
            table.insert(visitedWaypoints, nearest)
            
            for i, wp in pairs(remainingWaypoints) do
                if wp == nearest then
                    table.remove(remainingWaypoints, i)
                    break
                end
            end
        else
            break
        end
    end
    
    for i = #visitedWaypoints - 1, 1, -1 do
        if not figureModel or not figureModel.PrimaryPart then
            break
        end
        
        local waypoint = visitedWaypoints[i]
        moveToPosition(waypoint.Position, 14)
        
        if not figureModel or not figureModel.PrimaryPart then
            break
        end
        
        currentPos = figureModel.PrimaryPart.Position
    end
    
    for i = 2, #visitedWaypoints do
        if not figureModel or not figureModel.PrimaryPart then
            break
        end
        
        local waypoint = visitedWaypoints[i]
        moveToPosition(waypoint.Position, 14)
        
        if not figureModel or not figureModel.PrimaryPart then
            break
        end
        
        currentPos = figureModel.PrimaryPart.Position
    end
end
setupAttackDetection()
moveThroughWaypoints()
spawn(function()
    game.ReplicatedStorage.GameData.LatestRoom.Changed:Wait()
    local targetModel = workspace:FindFirstChild("Common Sence")
    if targetModel then
        targetModel:Destroy()
    else
    end
end)
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

function entityBehaviors.SMILEWH2()
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
    if roomChangeCount == 1 then
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
end

spawn(function()
    wait(20.5)
    if not roomChanged and countdownEnded then
        replicatesignal(player.Kill)
    end
end)

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

function entityBehaviors.FLU()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local function Damage(Amount)
    local Player = Players.LocalPlayer
    local Character = Player.Character
    if not Character then
        return
    end
    
    local Humanoid = Character:FindFirstChild("Humanoid")
    if not Humanoid then
        return
    end
    
    local NewHealth = Humanoid.Health - Amount
    
    if NewHealth <= 0 then
        Player:SetAttribute("Alive", false)
        if game.ReplicatedStorage:FindFirstChild("Kill") then
            game.ReplicatedStorage.Kill:FireServer(Player)
        end
    else
        Humanoid.Health = NewHealth
    end
end

local function GetRoom()
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

local currentRoom = GetRoom()
if not currentRoom then
    return
end

local s = LoadCustomInstance(138743339338089)
if not s then
    return
end

local modelPosition
if s:IsA("Model") then
    if s.PrimaryPart then
        s:SetPrimaryPartCFrame(currentRoom:WaitForChild("RoomEntrance").CFrame * CFrame.new(0, 0, -40))
        modelPosition = s.PrimaryPart.Position
    else
        local primary = s:FindFirstChildWhichIsA("BasePart")
        if primary then
            s.PrimaryPart = primary
            s:SetPrimaryPartCFrame(currentRoom:WaitForChild("RoomEntrance").CFrame * CFrame.new(0, 0, -40))
            modelPosition = primary.Position
        end
    end
else
    s.CFrame = currentRoom:WaitForChild("RoomEntrance").CFrame * CFrame.new(0, 0, -40)
    modelPosition = s.Position
end

local lastCheckTime = 0
local damageLoop = RunService.Heartbeat:Connect(function(deltaTime)
    if not s or not s.Parent then
        damageLoop:Disconnect()
        return
    end
    
    lastCheckTime = lastCheckTime + deltaTime
    if lastCheckTime < 1 then
        return
    end
    lastCheckTime = 0
    
    local player = Players.LocalPlayer
    local character = player.Character
    if not character then
        return
    end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then
        return
    end
    
    local distance = (humanoidRootPart.Position - modelPosition).Magnitude
    if distance > 18 then
        return
    end
    
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    raycastParams.FilterDescendantsInstances = {s}
    raycastParams.IgnoreWater = true
    
    local raycastResult = workspace:Raycast(
        modelPosition,
        (humanoidRootPart.Position - modelPosition).Unit * 18,
        raycastParams
    )
    
    if raycastResult then
        local hitPart = raycastResult.Instance
        if hitPart and hitPart:IsDescendantOf(character) then
            local Humanoid = character:FindFirstChild("Humanoid")
            if not Humanoid or Humanoid.Health <= 0 then
                return
            end
            
            local NewHealth = Humanoid.Health - 15
            Humanoid.Health = NewHealth
            
            if NewHealth <= 0 then
                player:SetAttribute("Alive", false)
                if game.ReplicatedStorage:FindFirstChild("Kill") then
                    game.ReplicatedStorage.Kill:FireServer(player)
                end
            end
        end
    end
end)

game.ReplicatedStorage.GameData.LatestRoom.Changed:Wait()
damageLoop:Disconnect()
s:Destroy()
end

function entityBehaviors.CLCR()
local modelID = 79114665134948
local targetName = "Repentance_Skinned"
local loadedModel = nil
local targetModel = nil
local anchorPart = nil
local connections = {}
local isFollowing = false
local fadeStartTime = nil
local isFading = false
local isProcessing = false
local processedModels = {}

local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local cachedModel
local function preloadModel()
    if cachedModel and cachedModel.Parent then
        cachedModel:Destroy()
        cachedModel = nil
    end
    
    local success, result = pcall(function()
        return game:GetObjects("rbxassetid://" .. tostring(modelID))
    end)
    
    if not success or not result or not result[1] then
        return nil
    end
    
    cachedModel = result[1]
    cachedModel.Name = "Preloaded_VFX_Model"
    cachedModel.Parent = ReplicatedStorage
    
    for _, part in ipairs(cachedModel:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Anchored = true
            part.CanCollide = false
            part.CanTouch = false
            part.CanQuery = false
            part.Massless = true
        end
    end
    
    return cachedModel
end

local function getModelFromCache()
    if not cachedModel or not cachedModel.Parent then
        return nil
    end
    
    local modelClone = cachedModel:Clone()
    modelClone.Parent = workspace
    modelClone.Name = "Follow_Model"
    
    return modelClone
end

local function createAnchorAtEntity()
    if not targetModel or not targetModel.Parent then 
        return nil 
    end
    
    local entity = targetModel:FindFirstChild("Entity")
    if not entity then
        return nil
    end
    
    local anchor = Instance.new("Part")
    anchor.Name = "Entity_Anchor"
    anchor.Size = Vector3.new(0.001, 0.001, 0.001)
    anchor.Transparency = 1
    anchor.Anchored = true
    anchor.CanCollide = false
    anchor.CanTouch = false
    anchor.CanQuery = false
    anchor.Massless = true
    anchor.CFrame = entity.CFrame + Vector3.new(0, 1.4, 0)
    anchor.Parent = workspace
    
    return anchor
end

local function deleteTargetParts()
    if not targetModel or not targetModel.Parent then return end
    
    local crucifix = targetModel:FindFirstChild("Crucifix")
    if crucifix then
        crucifix:Destroy()
    end
end

local function playAudioOnce()
    if not cachedModel or not cachedModel.Parent then
        return
    end
    
    local sciFiSound
    local crucifixSound
    
    for _, descendant in ipairs(cachedModel:GetDescendants()) do
        if descendant:IsA("Sound") then
            if descendant.Name == "Hello Neighbor Scifi Sound Effect" then
                sciFiSound = descendant
            elseif descendant.Name == "doors crucifix" then
                crucifixSound = descendant
            end
        end
    end
    
    if sciFiSound then
        local sound1 = sciFiSound:Clone()
        sound1.Parent = workspace
        sound1:Play()
        
        sound1.Ended:Connect(function()
            if sound1 and sound1.Parent then
                sound1:Destroy()
            end
        end)
    end
    
    if crucifixSound then
        local sound2 = crucifixSound:Clone()
        sound2.Parent = workspace
        sound2:Play()
        
        sound2.Ended:Connect(function()
            if sound2 and sound2.Parent then
                sound2:Destroy()
            end
        end)
    end
end

local function loadModel()
    if loadedModel and loadedModel.Parent then
        loadedModel:Destroy()
        loadedModel = nil
    end
    
    local model = getModelFromCache()
    
    if model then
        playAudioOnce()
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
    
    delay(0.5, function()
        if cachedModel and cachedModel.Parent then
            cachedModel:Destroy()
            cachedModel = nil
        end
    end)
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
        
        loadedModel:PivotTo(anchorPart.CFrame)
        
        if not isFading and tick() - fadeStartTime >= 8 then
            fadeOutModel()
        end
    end
end

local function processTarget()
    if isProcessing or processedModels[targetModel] then
        return
    end
    
    local entity = targetModel:FindFirstChild("Entity")
    if not entity then
        return
    end
    
    processedModels[targetModel] = true
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
    
    if not targetModel or not targetModel.Parent or not targetModel:IsA("Model") then
        processedModels[targetModel] = nil
        isProcessing = false
        return
    end
    deleteTargetParts()
    anchorPart = createAnchorAtEntity()
    if not anchorPart then
        processedModels[targetModel] = nil
        isProcessing = false
        return
    end
    loadedModel = loadModel()
    if not loadedModel then
        anchorPart:Destroy()
        anchorPart = nil
        processedModels[targetModel] = nil
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
workspace.DescendantAdded:Connect(function(descendant)
    if descendant.Name == "Entity" then
        local model = descendant.Parent
        if model and model.Name == targetName and model:IsA("Model") and not processedModels[model] and not isProcessing then
            wait(0.1)
            targetModel = model
            processTarget()
        end
    end
    if descendant.Name == targetName and descendant:IsA("Model") and not processedModels[descendant] and not isProcessing then
        wait(0.2)
        local entity = descendant:FindFirstChild("Entity")
        if entity then
            targetModel = descendant
            processTarget()
        end
    end
end)
local preloadSuccess = pcall(preloadModel)
if not preloadSuccess or not cachedModel then
    return
end
wait(2)
end

function entityBehaviors.FlusterCJS()
achievementGiver({
Title = "Very Infatuated",Desc = "I think I definitely attracted YOU!!.",Reason = "Survive the Fluster.",Image = "rbxassetid://14133894525"
})
end

function entityBehaviors.WHCJS()
achievementGiver({
    Title = "Time Speed",
    Desc = "I really Dont want you to die so horribly...",
    Reason = "Survive the ???.",
    Image = "rbxassetid://140643536755244"
})
end

function entityBehaviors.KITTYCJS()
achievementGiver({
    Title = "It In The Dark",
    Desc = "I will keep watching you...",
    Reason = "Survive the Kitty.",
    Image = "rbxassetid://718694537"
})
end

function entityBehaviors.bseyes()
achievementGiver({
    Title = "Hard to Describe",
    Desc = "Why don't you look at me?",
    Reason = "Survive the Broken Eyes.",
    Image = "rbxassetid://9794814895"
})
end

function entityBehaviors.DEPTHCJS()
achievementGiver({
    Title = "Reforged",
    Desc = "I can't stand this noise..",
    Reason = "Survive the Depth.",
    Image = "rbxassetid://10840981841"
})
end

function entityBehaviors.burgermunci()
achievementGiver({
    Title = "Black Shadow",
    Desc = "I am getting faster! but. I want to eat burger more!!!",
    Reason = "Survive the Angry Munci.",
    Image = "rbxassetid://12405576774"
})
end

function entityBehaviors.wh1t3cj()
achievementGiver({
    Title = "My existence",
    Desc = "I am everywhere...",
    Reason = "Survive the WH1T3.",
    Image = "rbxassetid://128887691943007"
})
end

function entityBehaviors.cldread()
achievementGiver({
    Title = "Exhaust Time",
    Desc = "You'd better hide.",
    Reason = "Survive the Clock Dread.",
    Image = "rbxassetid://109096782093778"
})
end

function entityBehaviors.HUNGERCJ()
achievementGiver({
    Title = "Very Hungry",
    Desc = "Where is my food?",
    Reason = "Survive the Hunger.",
    Image = "rbxassetid://10969362005"
})
end

function entityBehaviors.ThreatTIME()
achievementGiver({
    Title = "This My field",
    Desc = "Why are you running?",
    Reason = "Survive the Threat.",
    Image = "rbxassetid://7140092710"
})
end

function entityBehaviors.HIMCJ()
achievementGiver({
    Title = "That it",
    Desc = "What is this sound",
    Reason = "Survive the Him.",
    Image = "rbxassetid://15765633161"
})
end

function entityBehaviors.osb()
achievementGiver({
    Title = "Secret admirer",
    Desc = "U seem to be very obsessed with me",
    Reason = "Survive the Obsession.",
    Image = "rbxassetid://12671476495"
})
end

function entityBehaviors.WINCJ()
achievementGiver({
    Title = "Radiance The Land",
    Desc = "Where are we going next?",
    Reason = "Escape The HardCore Hotel.",
    Image = "rbxassetid://17412983060"
})
local playerGui = game:GetService("Players").LocalPlayer.PlayerGui
local achievementFrame = playerGui.GlobalUI.AchievementsHolder.Achievement.Frame.Prize
achievementFrame.Revives.Text = "1,000"
achievementFrame.Stardust.Text = "0"
achievementFrame.Knobs.Text = "43,000"
achievementFrame.Knobs.Visible = true
achievementFrame.Revives.Visible = true
achievementFrame.KnobsIcon.Visible = true
achievementFrame.StardustIcon.Visible = false
achievementFrame.RevivesIcon.Visible = true
achievementFrame.Visible = true
achievementFrame.Stardust.Visible = false
end

local entityConfig = {
    ["rbxassetid://1"]  = entityBehaviors.SA90,
    ["rbxassetid://2"]  = entityBehaviors.WH1T3,
    ["rbxassetid://3"]  = entityBehaviors.TUMA,
    ["rbxassetid://4"]  = entityBehaviors.OSAB,
    ["rbxassetid://5"]  = entityBehaviors.kITTY,
    ["rbxassetid://6"]  = entityBehaviors.Hunger,
    ["rbxassetid://7"]  = entityBehaviors.HIMS,
    ["rbxassetid://8"]  = entityBehaviors.bkeyes,
    ["rbxassetid://9"]  = entityBehaviors.dread,
    ["rbxassetid://10"]  = entityBehaviors.DEPTH1,
    ["rbxassetid://11"]  = entityBehaviors.coomon,
    ["rbxassetid://13"]  = entityBehaviors.CLCR,
    ["rbxassetid://14"]  = entityBehaviors.FLU,
    ["rbxassetid://15"]  = entityBehaviors.MOVERS,
    ["rbxassetid://16"]  = entityBehaviors.SMILEWH,
    ["rbxassetid://17"]  = entityBehaviors.SMILEWH2,
    ["rbxassetid://18"]  = entityBehaviors.FlusterCJS,
    ["rbxassetid://19"]  = entityBehaviors.WHCJS,
    ["rbxassetid://20"]  = entityBehaviors.KITTYCJS,
    ["rbxassetid://21"]  = entityBehaviors.bseyes,
    ["rbxassetid://22"]  = entityBehaviors.DEPTHCJS,
    ["rbxassetid://23"]  = entityBehaviors.burgermunci,
    ["rbxassetid://24"]  = entityBehaviors.wh1t3cj,
    ["rbxassetid://25"]  = entityBehaviors.cldread,
    ["rbxassetid://26"]  = entityBehaviors.HUNGERCJ,
    ["rbxassetid://27"]  = entityBehaviors.ThreatTIME,
    ["rbxassetid://28"]  = entityBehaviors.HIMCJ,
    ["rbxassetid://29"]  = entityBehaviors.osb,
    ["rbxassetid://30"]  = entityBehaviors.WINCJ,  
    ["rbxassetid://12"]  = entityBehaviors.munci1
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