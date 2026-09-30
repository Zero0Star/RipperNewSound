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
local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()
local dgmusic = "https://github.com/Zero0Star/RipperNewSound/blob/master/NoRunning.mp3?raw=true"
local entityBehaviors = {}

function entityBehaviors.WHATTHIS()
loadstring(game:HttpGet("https://github.com/Zero0Star/RipperNewSound/blob/master/AINEW.lua?raw=true"))()
end
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
Damage = {Enabled = true,Range = 99,Amount = 125},Crucifixion = {Enabled = true,Range = 100,Resist = false,Break = true},Death = {
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

local models = game:GetObjects("rbxassetid://112572076699068")
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

function entityBehaviors.Muffler1()
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

local s = LoadCustomInstance(113018476110287)
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
    targetCFrame = roomEntrance.CFrame * CFrame.new(0, -13, -25)
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
        targetCFrame = roomEntrance.CFrame * CFrame.new(0, -13, -25)
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

end

function entityBehaviors.Muffler2()
require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("You extremely foolish human.",true)
local muffler = workspace:FindFirstChild("Muffler")
if not muffler or not muffler:IsA("Model") then
    return
end

local closeStatic = muffler:FindFirstChild("Close Static")
if closeStatic and closeStatic:IsA("Sound") then
    closeStatic.Volume = 0
end

function DownloadAudio(url, filename)
    local url = url
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
    sound.SoundId = DownloadAudio(soundlink, filename)
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

function ChangeSkybox()

    local lighting = game:GetService("Lighting")
    
    pcall(function()
        local newSky = Instance.new("Sky")
        newSky.SkyboxBk = "rbxassetid://159454299"
        newSky.SkyboxDn = "rbxassetid://159454296"
        newSky.SkyboxFt = "rbxassetid://159454293"
        newSky.SkyboxLf = "rbxassetid://159454286"
        newSky.SkyboxRt = "rbxassetid://159454300"
        newSky.SkyboxUp = "rbxassetid://159454288"
        
        for _, sky in pairs(lighting:GetChildren()) do
            if sky:IsA("Sky") then
                sky:Destroy()
            end
        end
        
        newSky.Parent = lighting
    end)
end

function CameraShakeEffect()

    pcall(function()
        local CameraShaker = require(game.ReplicatedStorage.CameraShaker)
        local camara = workspace.CurrentCamera
        local camShake = CameraShaker.new(Enum.RenderPriority.Camera.Value, function(shakeCf)
            camara.CFrame = camara.CFrame * shakeCf
        end)
        camShake:Start()
        camShake:ShakeOnce(5, 50, 0.1, 20, 2, 0.5)
    end)
end

local bossStartSound = CustomGitSound(
    "https://github.com/Zero0Star/RipperNewSound/blob/master/MuteBossMusicStart.mp3?raw=true",
    2,
    "BOSSstart"
)


if bossStartSound then
bossStartSound.Name = "START"
    spawn(function()
        bossStartSound.Ended:Wait()
        CustomGitSound(
            "https://github.com/Zero0Star/RipperNewSound/blob/master/MuteBossMusicEnd.mp3?raw=true",
            2,
            "BOSSEND"
        )
        if bossEndSound then
            bossEndSound.Name = "BOSSEND"
        end
    end)

    wait(5)

    local eightSeven = muffler:FindFirstChild("EightSeven")
    if eightSeven then
        local faceAttach = eightSeven:FindFirstChild("FaceAttach")
        if faceAttach then
            local particle = faceAttach:FindFirstChildWhichIsA("ParticleEmitter")
            if particle then

                CameraShakeEffect()

                particle.Transparency = NumberSequence.new(1)
                for i = 1, 0.2, -0.016 do
                    particle.Transparency = NumberSequence.new(i)
                    wait(0.016)
                end
            end
        end
    end

    for _, obj in pairs(workspace.CurrentRooms:GetDescendants()) do
        if obj.Name == "DropCeiling" and obj.Parent and obj.Parent.Name == "Parts" then
            obj:Destroy()
        end
    end
    
    local camera = workspace:FindFirstChild("Camera")
    if camera then
        local skyboxPart = camera:FindFirstChild("SkyboxPart")
        if skyboxPart then skyboxPart:Destroy() end
    end

    wait(2)

    if not muffler.PrimaryPart then
        local primary = muffler:FindFirstChildWhichIsA("BasePart")
        if primary then
            muffler.PrimaryPart = primary
        end
    end
    
    if muffler.PrimaryPart then
        local startPos = muffler.PrimaryPart.Position
        local targetHeight = startPos.Y + 100
        local riseTime = 2.8
        local startTime = tick()
        
        spawn(function()
            while tick() - startTime < riseTime do
                local elapsed = tick() - startTime
                local progress = elapsed / riseTime
                if progress > 1 then progress = 1 end
                
                local ease = progress * progress * (3 - 2 * progress)
                local newY = startPos.Y + (targetHeight - startPos.Y) * ease
                
                muffler:SetPrimaryPartCFrame(CFrame.new(startPos.X, newY, startPos.Z))
                wait(0.016)
            end
            spawn(function()
                local eightSeven = muffler:FindFirstChild("EightSeven")
                if eightSeven then
                    local camAttach = eightSeven:FindFirstChild("CamAttach")
                    if camAttach then
                        local bubble = camAttach:FindFirstChild("Bubble")
                        local crescents = camAttach:FindFirstChild("crescents")
                        local smoke = camAttach:FindFirstChild("Smoke")

                        if smoke and smoke:IsA("ParticleEmitter") then
                            spawn(function()
                                for i = 1, 0.2, -0.016 do
                                    smoke.Transparency = NumberSequence.new(i)
                                    wait(0.016)
                                end
                            end)
                        end

                        if bubble and crescents then
                            spawn(function()
                                for i = 0, 1, 0.016 do
                                    local progress = i
                                    local ease = progress * progress * (3 - 2 * progress)
                                    local alpha = 1 - 0.8 * ease
                                    local size = 1 + 109 * ease
                                    
                                    bubble.Transparency = NumberSequence.new(alpha)
                                    crescents.Transparency = NumberSequence.new(alpha)
                                    
                                    local sizeSeq = NumberSequence.new({
                                        NumberSequenceKeypoint.new(0, size),
                                        NumberSequenceKeypoint.new(1, size)
                                    })
                                    bubble.Size = sizeSeq
                                    crescents.Size = sizeSeq
                                    
                                    wait(0.016)
                                end

                                spawn(function()
                                    ChangeSkybox()
                                end)
                            end)
                        end
                    end
                end
            end)
        end)
    end
end
end

function entityBehaviors.Muffler3()
local function EnhancedBeamEffect()
    local muffler = workspace:FindFirstChild("Muffler")
    if not muffler or not muffler:IsA("Model") then return end
    
    local eightSeven = muffler:FindFirstChild("EightSeven")
    if not eightSeven then return end
    
    local attachmentFolder = eightSeven:FindFirstChild("Attachment")
    if not attachmentFolder then return end
    
    local attachment1 = attachmentFolder:FindFirstChild("1")
    if not attachment1 or not attachment1:IsA("Attachment") then return end
    
    local particle1 = attachment1:FindFirstChildWhichIsA("ParticleEmitter")
    if particle1 then
        particle1.Transparency = NumberSequence.new(1)
        for i = 1, 0, -0.05 do
            particle1.Transparency = NumberSequence.new(i)
            wait(0.05)
        end
    end
    
    wait(2)
    
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://135388974385336"
    sound.Parent = workspace
    sound.Volume = 5
    sound:Play()

    pcall(function()
        local CameraShaker = require(game.ReplicatedStorage.CameraShaker)
        local camara = workspace.CurrentCamera
        local camShake = CameraShaker.new(Enum.RenderPriority.Camera.Value, function(shakeCf)
            camara.CFrame = camara.CFrame * shakeCf
        end)
        camShake:Start()
        camShake:ShakeOnce(10, 50, 0.1, 8, 2, 0.5)
    end)
    
    local attachment0 = attachmentFolder:FindFirstChild("0")
    if attachment0 and attachment0:IsA("Attachment") then
        local players = game:GetService("Players"):GetPlayers()
        local nearestPlayer = nil
        local minDist = math.huge
        
        for _, player in pairs(players) do
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local root = player.Character.HumanoidRootPart
                local dist = (root.Position - attachment0.WorldPosition).Magnitude
                if dist < minDist then
                    minDist = dist
                    nearestPlayer = player
                end
            end
        end
        
        if nearestPlayer and nearestPlayer.Character then
            local targetPart = nearestPlayer.Character.HumanoidRootPart
            local originalPos = attachment0.Position
            
            for _, obj in pairs(attachment0:GetChildren()) do
                if obj:IsA("ParticleEmitter") then
                    obj.Transparency = NumberSequence.new(0)
                end
            end

            for _, obj in pairs(muffler:GetDescendants()) do
                if obj:IsA("Beam") then
                    if obj.Attachment0 == attachment0 and obj.Attachment1 == attachment1 then
                        obj.Width0 = 40
                        obj.Width1 = 15
                    elseif obj.Attachment0 == attachment1 and obj.Attachment1 == attachment0 then
                        obj.Width0 = 15
                        obj.Width1 = 60
                    end
                    obj.Color = ColorSequence.new(Color3.fromRGB(255, 0, 255))  -- 品红色，最亮的紫色

                    obj.Transparency = NumberSequence.new(0)

                    pcall(function()
                        obj.Material = Enum.Material.Neon

                        local surfaceAppearance = Instance.new("SurfaceAppearance")
                        surfaceAppearance.ColorMap3D = Color3.fromRGB(255, 0, 255)
                        surfaceAppearance.Parent = obj
                    end)
                end
            end
            
            local runService = game:GetService("RunService")
            local conn = runService.Heartbeat:Connect(function()
                if targetPart and targetPart.Parent then
                    local parent = attachment0.Parent
                    while parent and not parent:IsA("BasePart") do
                        parent = parent.Parent
                    end
                    
                    if parent and parent:IsA("BasePart") then
                        local worldPos = targetPart.Position
                        local localPos = parent.CFrame:PointToObjectSpace(worldPos)
                        attachment0.Position = localPos
                    end
                end
            end)
            
            sound.Ended:Wait()
            conn:Disconnect()
            attachment0.Position = originalPos
            
            for _, obj in pairs(attachment0:GetChildren()) do
                if obj:IsA("ParticleEmitter") then
                    obj.Transparency = NumberSequence.new(1)
                end
            end
            
            for _, obj in pairs(muffler:GetDescendants()) do
                if obj:IsA("Beam") then
                    obj.Transparency = NumberSequence.new(1)
                end
            end
            
            if particle1 then
                particle1.Transparency = NumberSequence.new(1)
            end
        end
    end
end

EnhancedBeamEffect()
end

function entityBehaviors.SILENCECUR()
local silence = workspace:FindFirstChild("Silence")
if silence and silence:IsA("Model") then
    local silencePos = silence.PrimaryPart and silence.PrimaryPart.Position or silence:GetPivot().Position
    silence:Destroy()
    
    local model
    pcall(function()
        model = game:GetObjects("rbxassetid://101941879996976")[1]
    end)
    
    if model and model:IsA("Model") then
        model.Parent = workspace
        model:PivotTo(CFrame.new(silencePos + Vector3.new(0, 6, 0)))
        
        local explosionCameraShaker = require(game.ReplicatedStorage.CameraShaker)
        local explosionCam = workspace.CurrentCamera
        local explosionCamShake = explosionCameraShaker.new(Enum.RenderPriority.Camera.Value, function(shakeCf)
            explosionCam.CFrame = explosionCam.CFrame * shakeCf
        end)
        explosionCamShake:Start()
        explosionCamShake:ShakeOnce(10, 100, 0.1, 8, 10, 1)
        
        task.wait(7)
        
        local beams = {}
        local emitters = {}
        
        for _, obj in ipairs(model:GetDescendants()) do
            if obj:IsA("Beam") then
                table.insert(beams, obj)
            elseif obj:IsA("ParticleEmitter") then
                table.insert(emitters, obj)
            end
        end
        
        local startTime = tick()
        local duration = 1
        
        while tick() - startTime < duration do
            local elapsed = tick() - startTime
            local alpha = elapsed / duration
            
            for _, beam in ipairs(beams) do
                beam.Transparency = NumberSequence.new(alpha)
            end
            
            for _, emitter in ipairs(emitters) do
                emitter.Transparency = NumberSequence.new(alpha)
            end
            
            task.wait()
        end
        
        for _, beam in ipairs(beams) do
            beam.Transparency = NumberSequence.new(1)
        end
        
        for _, emitter in ipairs(emitters) do
            emitter.Transparency = NumberSequence.new(1)
        end
        
        task.wait(0.5)
        model:Destroy()
    end
end
end

function entityBehaviors.HUNGERCUR()
local Hunger = workspace:FindFirstChild("Hunger")
if Hunger and Hunger:IsA("Model") then
    local HungerPos = Hunger.PrimaryPart and Hunger.PrimaryPart.Position or Hunger:GetPivot().Position
    Hunger:Destroy()
    
    local model
    pcall(function()
        model = game:GetObjects("rbxassetid://75267288948071")[1]
    end)
    
    if model and model:IsA("Model") then
        model.Parent = workspace
        model:PivotTo(CFrame.new(HungerPos + Vector3.new(0, 6, 0)))
        
        local explosionCameraShaker = require(game.ReplicatedStorage.CameraShaker)
        local explosionCam = workspace.CurrentCamera
        local explosionCamShake = explosionCameraShaker.new(Enum.RenderPriority.Camera.Value, function(shakeCf)
            explosionCam.CFrame = explosionCam.CFrame * shakeCf
        end)
        explosionCamShake:Start()
        explosionCamShake:ShakeOnce(10, 100, 0.1, 8, 10, 1)
        
        task.wait(6)
        require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("一个杂碎已经被我清除",true)
        local beams = {}
        local emitters = {}
        local meshes = {}
        
        for _, obj in ipairs(model:GetDescendants()) do
            if obj:IsA("Beam") then
                table.insert(beams, obj)
            elseif obj:IsA("ParticleEmitter") then
                table.insert(emitters, obj)
            elseif obj:IsA("MeshPart") then
                table.insert(meshes, obj)
            end
        end
        
        local startTime = tick()
        local duration = 1
        
        while tick() - startTime < duration do
            local elapsed = tick() - startTime
            local alpha = elapsed / duration
            
            for _, beam in ipairs(beams) do
                beam.Transparency = NumberSequence.new(alpha)
            end
            
            for _, emitter in ipairs(emitters) do
                emitter.Transparency = NumberSequence.new(alpha)
            end
            
            for _, mesh in ipairs(meshes) do
                mesh.Transparency = alpha
            end
            
            task.wait()
        end
        
        for _, beam in ipairs(beams) do
            beam.Transparency = NumberSequence.new(1)
        end
        
        for _, emitter in ipairs(emitters) do
            emitter.Transparency = NumberSequence.new(1)
        end
        
        for _, mesh in ipairs(meshes) do
            mesh.Transparency = 1
        end
        
        task.wait(0.5)
        model:Destroy()
    end
end
end

function entityBehaviors.RIPPCUR()
local rushNew = workspace:FindFirstChild("RushNew")
if rushNew and rushNew:IsA("BasePart") then
    local rushNewPos = rushNew.Position
    rushNew:Destroy()
    
    local model
    pcall(function()
        model = game:GetObjects("rbxassetid://70558624002937")[1]
    end)
    
    if model and model:IsA("Model") then
        model.Parent = workspace
        model:PivotTo(CFrame.new(rushNewPos + Vector3.new(0, 8, 0)))
        
        local explosionCameraShaker = require(game.ReplicatedStorage.CameraShaker)
        local explosionCam = workspace.CurrentCamera
        local explosionCamShake = explosionCameraShaker.new(Enum.RenderPriority.Camera.Value, function(shakeCf)
            explosionCam.CFrame = explosionCam.CFrame * shakeCf
        end)
        explosionCamShake:Start()
        explosionCamShake:ShakeOnce(10, 100, 0.1, 8, 10, 1)
        
        task.wait(8)
        
        local beams = {}
        local emitters = {}
        local meshes = {}
        
        for _, obj in ipairs(model:GetDescendants()) do
            if obj:IsA("Beam") then
                table.insert(beams, obj)
            elseif obj:IsA("ParticleEmitter") then
                table.insert(emitters, obj)
            elseif obj:IsA("MeshPart") then
                table.insert(meshes, obj)
            end
        end
        
        local startTime = tick()
        local duration = 1
        
        while tick() - startTime < duration do
            local elapsed = tick() - startTime
            local alpha = elapsed / duration
            
            for _, beam in ipairs(beams) do
                beam.Transparency = NumberSequence.new(alpha)
            end
            
            for _, emitter in ipairs(emitters) do
                emitter.Transparency = NumberSequence.new(alpha)
            end
            
            for _, mesh in ipairs(meshes) do
                mesh.Transparency = alpha
            end
            
            task.wait()
        end
        
        for _, beam in ipairs(beams) do
            beam.Transparency = NumberSequence.new(1)
        end
        
        for _, emitter in ipairs(emitters) do
            emitter.Transparency = NumberSequence.new(1)
        end
        
        for _, mesh in ipairs(meshes) do
            mesh.Transparency = 1
        end
        
        task.wait(0.5)
        model:Destroy()
    end
end
end

function entityBehaviors.DEERCUR()
local DeerGod = workspace:FindFirstChild("DeerGod")
if DeerGod and DeerGod:IsA("Model") then
    local DeerGodPos = DeerGod.PrimaryPart and DeerGod.PrimaryPart.Position or DeerGod:GetPivot().Position
    DeerGod:Destroy()
    
    local model
    pcall(function()
        model = game:GetObjects("rbxassetid://95232410623518")[1]
    end)
    
    if model and model:IsA("Model") then
        model.Parent = workspace
        model:PivotTo(CFrame.new(DeerGodPos + Vector3.new(0, 7, 0)))
        
        local explosionCameraShaker = require(game.ReplicatedStorage.CameraShaker)
        local explosionCam = workspace.CurrentCamera
        local explosionCamShake = explosionCameraShaker.new(Enum.RenderPriority.Camera.Value, function(shakeCf)
            explosionCam.CFrame = explosionCam.CFrame * shakeCf
        end)
        explosionCamShake:Start()
        explosionCamShake:ShakeOnce(10, 100, 0.1, 8, 10, 1)
        
        task.wait(7)
        require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("你不该呆在这里",true)
        local beams = {}
        local emitters = {}
        local meshes = {}
        
        for _, obj in ipairs(model:GetDescendants()) do
            if obj:IsA("Beam") then
                table.insert(beams, obj)
            elseif obj:IsA("ParticleEmitter") then
                table.insert(emitters, obj)
            elseif obj:IsA("MeshPart") then
                table.insert(meshes, obj)
            end
        end
        
        local startTime = tick()
        local duration = 1
        
        while tick() - startTime < duration do
            local elapsed = tick() - startTime
            local alpha = elapsed / duration
            
            for _, beam in ipairs(beams) do
                beam.Transparency = NumberSequence.new(alpha)
            end
            
            for _, emitter in ipairs(emitters) do
                emitter.Transparency = NumberSequence.new(alpha)
            end
            
            for _, mesh in ipairs(meshes) do
                mesh.Transparency = alpha
            end
            
            task.wait()
        end
        
        for _, beam in ipairs(beams) do
            beam.Transparency = NumberSequence.new(1)
        end
        
        for _, emitter in ipairs(emitters) do
            emitter.Transparency = NumberSequence.new(1)
        end
        
        for _, mesh in ipairs(meshes) do
            mesh.Transparency = 1
        end
        
        task.wait(0.5)
        model:Destroy()
    end
end
end
function entityBehaviors.REBOUCUR()
local Rebound = workspace:FindFirstChild("Rebound")
if Rebound and Rebound:IsA("Model") then
    local ReboundPos

    local primaryPart = Rebound.PrimaryPart
    if not primaryPart then
        primaryPart = Rebound:FindFirstChildWhichIsA("BasePart")
    end
    
    if primaryPart then
        ReboundPos = primaryPart.Position
    else
        ReboundPos = Rebound:GetPivot().Position
    end
    
    Rebound:Destroy()
    
    local model
    pcall(function()
        model = game:GetObjects("rbxassetid://79375225577662")[1]
    end)
    
    if model and model:IsA("Model") then
        model.Parent = workspace

        local newPrimaryPart = model.PrimaryPart
        if not newPrimaryPart then
            newPrimaryPart = model:FindFirstChildWhichIsA("BasePart")
        end
        
        if newPrimaryPart then
            newPrimaryPart.Anchored = true
            newPrimaryPart.CanCollide = false
            newPrimaryPart.CFrame = CFrame.new(ReboundPos + Vector3.new(0, 6, 0))
        else
            model:PivotTo(CFrame.new(ReboundPos + Vector3.new(0, 5.7, 0)))
        end
        
        local explosionCameraShaker = require(game.ReplicatedStorage.CameraShaker)
        local explosionCam = workspace.CurrentCamera
        local explosionCamShake = explosionCameraShaker.new(Enum.RenderPriority.Camera.Value, function(shakeCf)
            explosionCam.CFrame = explosionCam.CFrame * shakeCf
        end)
        explosionCamShake:Start()
        explosionCamShake:ShakeOnce(10, 100, 0.1, 8, 10, 1)
        
        task.wait(7)
        require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("一个杂碎已经被我清除",true)
        
        local beams = {}
        local emitters = {}
        
        for _, obj in ipairs(model:GetDescendants()) do
            if obj:IsA("Beam") then
                table.insert(beams, obj)
            elseif obj:IsA("ParticleEmitter") then
                table.insert(emitters, obj)
            end
        end
        
        local startTime = tick()
        local duration = 1
        
        while tick() - startTime < duration do
            local elapsed = tick() - startTime
            local alpha = elapsed / duration
            
            for _, beam in ipairs(beams) do
                beam.Transparency = NumberSequence.new(alpha)
            end
            
            for _, emitter in ipairs(emitters) do
                emitter.Transparency = NumberSequence.new(alpha)
            end
            
            task.wait()
        end
        
        for _, beam in ipairs(beams) do
            beam.Transparency = NumberSequence.new(1)
        end
        
        for _, emitter in ipairs(emitters) do
            emitter.Transparency = NumberSequence.new(1)
        end
        
        task.wait(0.5)
        model:Destroy()
    end
end
end
local function PreloadDeerGodSounds()
    if workspace:FindFirstChild("DeerGod_Preloaded") then
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

    if dgmusic then
        DownloadAndStoreSound(dgmusic, "DeerGod")
    end
end

PreloadDeerGodSounds()

local function PlayPreloadedDeerGodSound(volume)
    volume = volume or 4
    local sound = workspace:FindFirstChild("DeerGod_Preloaded")
    
    if sound then
        sound.Volume = volume
        sound:Play()
        return sound
    end
    return nil
end

function entityBehaviors.SHOOPFY()
local Following_ENEMY = workspace:FindFirstChild("Following_ENEMY")
if Following_ENEMY and Following_ENEMY:IsA("Model") then
    local Following_ENEMYPos = Following_ENEMY.PrimaryPart and Following_ENEMY.PrimaryPart.Position or Following_ENEMY:GetPivot().Position
    Following_ENEMY:Destroy()
    
    local model
    pcall(function()
        model = game:GetObjects("rbxassetid://102643619785276")[1]
    end)
    
    if model and model:IsA("Model") then
        model.Parent = workspace
        model:PivotTo(CFrame.new(Following_ENEMYPos + Vector3.new(0, 4.3, 0)))
        
        local explosionCameraShaker = require(game.ReplicatedStorage.CameraShaker)
        local explosionCam = workspace.CurrentCamera
        local explosionCamShake = explosionCameraShaker.new(Enum.RenderPriority.Camera.Value, function(shakeCf)
            explosionCam.CFrame = explosionCam.CFrame * shakeCf
        end)
        explosionCamShake:Start()
        explosionCamShake:ShakeOnce(10, 100, 0.1, 8, 10, 1)
        
        task.wait(7)
        require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("你不该呆在这里",true)
        local beams = {}
        local emitters = {}
        local meshes = {}
        
        for _, obj in ipairs(model:GetDescendants()) do
            if obj:IsA("Beam") then
                table.insert(beams, obj)
            elseif obj:IsA("ParticleEmitter") then
                table.insert(emitters, obj)
            elseif obj:IsA("MeshPart") then
                table.insert(meshes, obj)
            end
        end
        
        local startTime = tick()
        local duration = 1
        
        while tick() - startTime < duration do
            local elapsed = tick() - startTime
            local alpha = elapsed / duration
            
            for _, beam in ipairs(beams) do
                beam.Transparency = NumberSequence.new(alpha)
            end
            
            for _, emitter in ipairs(emitters) do
                emitter.Transparency = NumberSequence.new(alpha)
            end
            
            for _, mesh in ipairs(meshes) do
                mesh.Transparency = alpha
            end
            
            task.wait()
        end
        
        for _, beam in ipairs(beams) do
            beam.Transparency = NumberSequence.new(1)
        end
        
        for _, emitter in ipairs(emitters) do
            emitter.Transparency = NumberSequence.new(1)
        end
        
        for _, mesh in ipairs(meshes) do
            mesh.Transparency = 1
        end
        
        task.wait(0.5)
        model:Destroy()
    end
end
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

function entityBehaviors.TOUSHI()
    local Workspace = game:GetService("Workspace")
    local CurrentRooms = Workspace:WaitForChild("CurrentRooms")

    if not _G.KeyDoorHighlightState then
        _G.KeyDoorHighlightState = {
            isEnabled = false,
            highlights = {},
            connections = {},
            currentRoomCount = 0
        }
    end
    
    local state = _G.KeyDoorHighlightState

    local function findKeyParts(model)
        if not model or not model:IsA("Model") then
            return {}
        end
        
        local keyParts = {}
        
        for _, child in pairs(model:GetDescendants()) do
            if child:IsA("BasePart") and child.Transparency < 1 then
                table.insert(keyParts, child)
            end
        end
        
        return keyParts
    end

    local function findDoorPart(door)
        if not door then return nil end
        
        if door:IsA("BasePart") then
            return door
        end
        
        if door:IsA("Model") then
            if door.PrimaryPart and door.PrimaryPart:IsA("BasePart") then
                return door.PrimaryPart
            end
            
            for _, child in pairs(door:GetDescendants()) do
                if child:IsA("BasePart") and child.Transparency < 1 then
                    return child
                end
            end
        end
        
        return nil
    end

    local function createHighlight(target, name)
        if not target or not target:IsA("BasePart") then
            return nil
        end

        if target:FindFirstChild(name .. "Highlight") then
            return target:FindFirstChild(name .. "Highlight")
        end
        
        local highlight = Instance.new("Highlight")
        highlight.Name = name .. "Highlight"
        highlight.FillColor = Color3.fromRGB(0, 255, 0)
        highlight.OutlineColor = Color3.fromRGB(0, 200, 0)
        highlight.FillTransparency = 0.7
        highlight.OutlineTransparency = 0.3
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.Adornee = target
        highlight.Parent = target
        
        state.highlights[highlight] = true
        return highlight
    end

    local function scanAndHighlightAll()
        for _, room in pairs(CurrentRooms:GetChildren()) do
            if room:IsA("Model") then

                local assets = room:FindFirstChild("Assets")
                if assets then
                    local keyObtain = assets:FindFirstChild("KeyObtain")
                    if keyObtain then
                        local keyParts = findKeyParts(keyObtain)
                        for _, part in ipairs(keyParts) do
                            createHighlight(part, "Key")
                        end
                    end
                end

                local door = room:FindFirstChild("Door")
                if door then
                    local doorPart = findDoorPart(door)
                    if doorPart then
                        createHighlight(doorPart, "Door")
                    end
                end
            end
        end
    end

    local function startMonitoring()

        local roomAddedConnection = CurrentRooms.ChildAdded:Connect(function(room)
            if state.isEnabled and room:IsA("Model") then
                task.wait(0.3)

                local assets = room:FindFirstChild("Assets")
                if assets then
                    local keyObtain = assets:FindFirstChild("KeyObtain")
                    if keyObtain then
                        local keyParts = findKeyParts(keyObtain)
                        for _, part in ipairs(keyParts) do
                            createHighlight(part, "Key")
                        end
                    end
                end

                local door = room:FindFirstChild("Door")
                if door then
                    local doorPart = findDoorPart(door)
                    if doorPart then
                        createHighlight(doorPart, "Door")
                    end
                end
            end
        end)
        
        table.insert(state.connections, roomAddedConnection)

        for _, room in pairs(CurrentRooms:GetChildren()) do
            if room:IsA("Model") then

                local assetsConnection
                assetsConnection = room:GetPropertyChangedSignal("Assets"):Connect(function()
                    if state.isEnabled and room:FindFirstChild("Assets") then
                        local assets = room.Assets
                        task.wait(0.1)
                        
                        local keyObtain = assets:FindFirstChild("KeyObtain")
                        if keyObtain then
                            task.wait(0.1)
                            local keyParts = findKeyParts(keyObtain)
                            for _, part in ipairs(keyParts) do
                                createHighlight(part, "Key")
                            end
                        end
                    end
                end)
                
                table.insert(state.connections, assetsConnection)

                local doorConnection
                doorConnection = room:GetPropertyChangedSignal("Door"):Connect(function()
                    if state.isEnabled and room:FindFirstChild("Door") then
                        local door = room.Door
                        local doorPart = findDoorPart(door)
                        if doorPart then
                            createHighlight(doorPart, "Door")
                        end
                    end
                end)
                
                table.insert(state.connections, doorConnection)
            end
        end
    end

    local function cleanupAll()
        for highlight, _ in pairs(state.highlights) do
            if highlight and highlight.Parent then
                highlight:Destroy()
            end
        end
        state.highlights = {}

        for _, connection in ipairs(state.connections) do
            if connection and typeof(connection) == "RBXScriptConnection" then
                connection:Disconnect()
            end
        end
        state.connections = {}
        
        state.isEnabled = false
        state.currentRoomCount = 0
    end

    if state.isEnabled then
        cleanupAll()
    else
        state.isEnabled = true
        scanAndHighlightAll()
        startMonitoring()
    end
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

local githubAudioUrl = "https://github.com/Zero0Star/RipperNewSound/blob/master/MultiMonsterRipper.mp3?raw=true"
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

function entityBehaviors.MR()
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
                        "你死于MultiMonster...",
                        "我认为它不属于这里.",
                        "它的变化随时间推移将越来越危险,等待我的持续观察."
                    },
                    "Yellow"
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
        local RIPPER_MODEL_ID = "127021565298754"

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

        local heightOffset = Vector3.new(0, 1, 0)
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

        local NEAR_EXPLOSION_DISTANCE = 80
        local FAR_EXPLOSION_DISTANCE = 220
        local SHAKE_MAX_DISTANCE = 350
        local MAX_EXPLOSION_SHAKE = 300

        local localPlayer = Players.LocalPlayer
        local playerRoot = nil

        if localPlayer and localPlayer.Character then
            playerRoot =
                localPlayer.Character:FindFirstChild(
                    "HumanoidRootPart"
                )
        end

        local ripperDistance = math.huge

        if playerRoot and ripper and ripper.Parent then
            ripperDistance =
                (
                    playerRoot.Position
                    - ripper.Position
                ).Magnitude
        end

        -- The moving Ripper is a cloned BasePart. In this asset that part
        -- can itself be RushNew, so check it first, then fall back to the
        -- original loaded asset in case RushNew lives deeper in the model.
        local rushNew = nil

        if ripper and ripper.Parent then
            if ripper.Name == "RushNew" then
                rushNew = ripper
            else
                rushNew =
                    ripper:FindFirstChild(
                        "RushNew",
                        true
                    )
            end
        end

        if not rushNew
            and ripperAsset
            and ripperAsset.Parent
        then
            rushNew =
                ripperAsset:FindFirstChild(
                    "RushNew",
                    true
                )
        end

        local explodeSound = nil

        if ripperDistance
            <= NEAR_EXPLOSION_DISTANCE
        then
            -- Very close: keep the original explosion sound.
            local explosionSound =
                workspace:FindFirstChild(
                    "RipperExplosionSound"
                )

            if explosionSound
                and explosionSound:IsA("Sound")
            then
                explodeSound = Instance.new("Sound")
                explodeSound.SoundId =
                    explosionSound.SoundId
                explodeSound.Volume = 5
                explodeSound.PlaybackSpeed =
                    explosionSound.PlaybackSpeed
                explodeSound.Parent = ripper
            end
        elseif ripperDistance
            <= FAR_EXPLOSION_DISTANCE
        then
            -- Mid distance: use RushNew.Despawn2 at Volume 10.
            local despawn2 =
                rushNew
                and rushNew:FindFirstChild(
                    "Despawn2"
                )

            if despawn2
                and despawn2:IsA("Sound")
            then
                explodeSound = despawn2:Clone()
                explodeSound.Volume = 10
                explodeSound.Parent = ripper
            end
        else
            -- Very far: use RushNew.Despawn3 at Volume 10.
            local despawn3 =
                rushNew
                and rushNew:FindFirstChild(
                    "Despawn3"
                )

            if despawn3
                and despawn3:IsA("Sound")
            then
                explodeSound = despawn3:Clone()
                explodeSound.Volume = 10
                explodeSound.Parent = ripper
            end
        end

        -- Safety fallback if Despawn2 / Despawn3 is missing from the asset.
        if not explodeSound then
            local explosionSound =
                workspace:FindFirstChild(
                    "RipperExplosionSound"
                )

            if explosionSound
                and explosionSound:IsA("Sound")
            then
                explodeSound = Instance.new("Sound")
                explodeSound.SoundId =
                    explosionSound.SoundId
                explodeSound.Volume = 5
                explodeSound.PlaybackSpeed =
                    explosionSound.PlaybackSpeed
                explodeSound.Parent = ripper
            end
        end

        if explodeSound then
            explodeSound:Play()
        end

        -- Keep the original 300 shake while very close. Beyond the near
        -- range, smoothly fade the amplitude to 0 by SHAKE_MAX_DISTANCE.
        local shakeAmplitude = 0

        if ripperDistance
            <= NEAR_EXPLOSION_DISTANCE
        then
            shakeAmplitude = MAX_EXPLOSION_SHAKE
        elseif ripperDistance
            < SHAKE_MAX_DISTANCE
        then
            local alpha =
                1
                - (
                    ripperDistance
                    - NEAR_EXPLOSION_DISTANCE
                )
                / (
                    SHAKE_MAX_DISTANCE
                    - NEAR_EXPLOSION_DISTANCE
                )

            shakeAmplitude =
                MAX_EXPLOSION_SHAKE
                * math.clamp(alpha, 0, 1)
        end

        if cameraShakerModule
            and shakeAmplitude > 0
        then
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
                shakeAmplitude,
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

local MR = "https://github.com/Zero0Star/RipperNewSound/blob/master/MultiMonsterRipper.mp3?raw=true"
local MRD = "https://github.com/Zero0Star/RipperNewSound/blob/master/RipperDoorend.mp3?raw=true"

local backgroundSoundPath = GitAud(
    MR,
    "MRS"
)

local explosionSoundPath = GitAud(
    MRD,
    "MRD"
)

if backgroundSoundPath then
    local oldBackgroundSound = workspace:FindFirstChild(
        "MRS"
    )

    if oldBackgroundSound then
        oldBackgroundSound:Destroy()
    end

    local backgroundSound = Instance.new("Sound")
    backgroundSound.Name = "MRS"
    backgroundSound.SoundId = backgroundSoundPath
    backgroundSound.Volume = 2
    backgroundSound.Looped = false
    backgroundSound.Parent = workspace
end

if explosionSoundPath then
    local oldExplosionSound = workspace:FindFirstChild(
        "MRD"
    )

    if oldExplosionSound then
        oldExplosionSound:Destroy()
    end

    local explosionSound = Instance.new("Sound")
    explosionSound.Name = "MRD"
    explosionSound.SoundId = explosionSoundPath
    explosionSound.Volume = 5
    explosionSound.Looped = false
    explosionSound.Parent = workspace
end

function entityBehaviors.MR()
    local backgroundSound = workspace:FindFirstChild(
        "MRS"
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
            "MRD"
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
                        "你死于MultiMonster...",
                        "我认为它不属于这里.",
                        "它的变化随时间推移将越来越危险,等待我的持续观察."
                    },
                    "Yellow"
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
        local RIPPER_MODEL_ID = "127021565298754"

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

        local heightOffset = Vector3.new(0, 1, 0)
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

        -- Distance-based despawn sound + camera shake.
        -- Near: original explosion sound / original strong shake.
        -- Mid:  RushNew.Despawn2, Volume = 10.
        -- Far:  RushNew.Despawn3, Volume = 10.
        -- Shake fades with distance after the near range.
        local NEAR_EXPLOSION_DISTANCE = 80
        local FAR_EXPLOSION_DISTANCE = 220
        local SHAKE_MAX_DISTANCE = 350
        local MAX_EXPLOSION_SHAKE = 300

        local localPlayer = Players.LocalPlayer
        local playerRoot = nil

        if localPlayer and localPlayer.Character then
            playerRoot =
                localPlayer.Character:FindFirstChild(
                    "HumanoidRootPart"
                )
        end

        local ripperDistance = math.huge

        if playerRoot and ripper and ripper.Parent then
            ripperDistance =
                (
                    playerRoot.Position
                    - ripper.Position
                ).Magnitude
        end

        -- The moving Ripper is a cloned BasePart. In this asset that part
        -- can itself be RushNew, so check it first, then fall back to the
        -- original loaded asset in case RushNew lives deeper in the model.
        local rushNew = nil

        if ripper and ripper.Parent then
            if ripper.Name == "RushNew" then
                rushNew = ripper
            else
                rushNew =
                    ripper:FindFirstChild(
                        "RushNew",
                        true
                    )
            end
        end

        if not rushNew
            and ripperAsset
            and ripperAsset.Parent
        then
            rushNew =
                ripperAsset:FindFirstChild(
                    "RushNew",
                    true
                )
        end

        local explodeSound = nil

        if ripperDistance
            <= NEAR_EXPLOSION_DISTANCE
        then
            -- Very close: keep the original explosion sound.
            local explosionSound =
                workspace:FindFirstChild(
                    "MRD"
                )

            if explosionSound
                and explosionSound:IsA("Sound")
            then
                explodeSound = Instance.new("Sound")
                explodeSound.SoundId =
                    explosionSound.SoundId
                explodeSound.Volume = 5
                explodeSound.PlaybackSpeed =
                    explosionSound.PlaybackSpeed
                explodeSound.Parent = ripper
            end
        elseif ripperDistance
            <= FAR_EXPLOSION_DISTANCE
        then
            -- Mid distance: use RushNew.Despawn2 at Volume 10.
            local despawn2 =
                rushNew
                and rushNew:FindFirstChild(
                    "Despawn2"
                )

            if despawn2
                and despawn2:IsA("Sound")
            then
                explodeSound = despawn2:Clone()
                explodeSound.Volume = 10
                explodeSound.Parent = ripper
            end
        else
            -- Very far: use RushNew.Despawn3 at Volume 10.
            local despawn3 =
                rushNew
                and rushNew:FindFirstChild(
                    "Despawn3"
                )

            if despawn3
                and despawn3:IsA("Sound")
            then
                explodeSound = despawn3:Clone()
                explodeSound.Volume = 10
                explodeSound.Parent = ripper
            end
        end

        -- Safety fallback if Despawn2 / Despawn3 is missing from the asset.
        if not explodeSound then
            local explosionSound =
                workspace:FindFirstChild(
                    "MRD"
                )

            if explosionSound
                and explosionSound:IsA("Sound")
            then
                explodeSound = Instance.new("Sound")
                explodeSound.SoundId =
                    explosionSound.SoundId
                explodeSound.Volume = 5
                explodeSound.PlaybackSpeed =
                    explosionSound.PlaybackSpeed
                explodeSound.Parent = ripper
            end
        end

        if explodeSound then
            explodeSound:Play()
        end

        -- Keep the original 300 shake while very close. Beyond the near
        -- range, smoothly fade the amplitude to 0 by SHAKE_MAX_DISTANCE.
        local shakeAmplitude = 0

        if ripperDistance
            <= NEAR_EXPLOSION_DISTANCE
        then
            shakeAmplitude = MAX_EXPLOSION_SHAKE
        elseif ripperDistance
            < SHAKE_MAX_DISTANCE
        then
            local alpha =
                1
                - (
                    ripperDistance
                    - NEAR_EXPLOSION_DISTANCE
                )
                / (
                    SHAKE_MAX_DISTANCE
                    - NEAR_EXPLOSION_DISTANCE
                )

            shakeAmplitude =
                MAX_EXPLOSION_SHAKE
                * math.clamp(alpha, 0, 1)
        end

        if cameraShakerModule
            and shakeAmplitude > 0
        then
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
                shakeAmplitude,
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

local function PreloadReboundSounds()
    if workspace:FindFirstChild("MultiMonsterRebound_Preloaded") and workspace:FindFirstChild("MultiMonstermovings_Preloaded") then
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

    DownloadAndStoreSound("https://github.com/Zero0Star/RipperNewSound/blob/master/MultiMonsterRebound.mp3?raw=true", "MultiMonsterRebound")

    DownloadAndStoreSound("https://github.com/Zero0Star/RipperMPSound/blob/master/ReboundMovings.mp3?raw=true", "MultiMonstermovings")
end

PreloadReboundSounds()

function entityBehaviors.MRB()
    local testModelId = 93023894774010

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
        local v306 = 1
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
            v323.Image = "rbxassetid://79906427468430"
            
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
    "你死于MultiMonster...",
    "MultiMonster?...",
    "..."
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
           (obj.Name:find("MultiMonstermovings") and not obj.Name:find("_Preloaded")) or 
           (obj.Name:find("MultiMonsterRebound") and not obj.Name:find("_Preloaded")) then
            pcall(function() obj:Destroy() end)
        end
    end

    pcall(function() delfile("MultiMonstermovings.mp3") end)
    pcall(function() delfile("MultiMonsterRebound.mp3") end)

    local sweepSound = PlayPreloadedSound("MultiMonsterRebound", 2)
    
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

    local sound1 = PlayPreloadedSound("MultiMonstermovings", 3)
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
    local sound2 = PlayPreloadedSound("MultiMonstermovings", 3)
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
    local sound3 = PlayPreloadedSound("MultiMonstermovings", 3)
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
    local sound4 = PlayPreloadedSound("MultiMonstermovings", 3)
    if sound4 then
        repeat
            wait()
        until sound4.IsPlaying == false
    end
end

function entityBehaviors.MO()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

local function isPlayerLookingAtEntity1(entity)
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
local function startDamageLoop1(entity)
    if damageConnection then
        damageConnection:Disconnect()
    end
    
    local lastDamageTime = 0
    damageConnection = RunService.Heartbeat:Connect(function(deltaTime)
        if not entity or not entity.Parent then
            damageConnection:Disconnect()
            return
        end

        if not isPlayerLookingAtEntity1(entity) then
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

local s = LoadCustomInstance1(132340371653318)
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

startDamageLoop1(s)

game.ReplicatedStorage.GameData.LatestRoom.Changed:Wait()
s:Destroy()
if damageConnection then
    damageConnection:Disconnect()
end
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

function entityBehaviors.MC()
local Event = game:GetService("ReplicatedStorage").RemotesFolder.AdminPanelRunCommand
Event:FireServer(
    "LightRoom",
    {
        ["Light Color"] = Color3.new(1, 0, 0)
    }
)
local entity = spawner.Create({Entity = {Name = "Cease",Asset = "82545318629891",HeightOffset = 1},Lights = {Flicker = {Enabled = false,Duration = 10},Shatter = false,Repair = false},Earthquake = {Enabled = false},CameraShake = {Enabled = true,Range = 200,Values = {1.5, 20, 0.1, 1}},Movement = {Speed = 140,Delay = 5,Reversed = false},Rebounding = {Enabled = false,Type = "ambush",Min = 4,Max = 4,Delay = math.random(10, 30) / 10},Damage = {Enabled = false,Range = 100,Amount = 125},Crucifixion = {Enabled = true,Range = 100,Resist = false,Break = true},Death = {Type = "Guiding",Hints = {"CEASE", "你该学会辨别", "听取周围的声音", "反复进柜子躲避它"},Cause = ""}})
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

function entityBehaviors.MD()
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local LocalPlayer = Players.LocalPlayer
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
    local entityModel
    local chaseConnection = nil
    local customSpeed = 20
    local activationRange = 75
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local ids = {"rbxassetid://8116159092","rbxassetid://435812828","rbxassetid://860440643"}

local gui = Instance.new("ScreenGui",player:WaitForChild("PlayerGui"))
gui.Name = "SnowGlitchEnhanced"
gui.IgnoreGuiInset = true

local mainImg = Instance.new("ImageLabel",gui)
mainImg.Size = UDim2.new(1,0,1,0)
mainImg.BackgroundTransparency = 1
mainImg.ImageTransparency = 0.88
mainImg.Image = ids[math.random(#ids)]
mainImg.ScaleType = Enum.ScaleType.Tile
mainImg.TileSize = UDim2.new(0,64,0,64)

local flashFrame = Instance.new("Frame",gui)
flashFrame.Size = UDim2.new(1,0,1,0)
flashFrame.BackgroundColor3 = Color3.new(1,1,1)
flashFrame.BackgroundTransparency = 1
flashFrame.BorderSizePixel = 0

local start = tick()
local lastFlash = tick()
local flashInterval = 0.15
local flashDuration = 0.05

local conn = RunService.RenderStepped:Connect(function()
    local elapsed = tick() - start
    if elapsed >= 60 then
        conn:Disconnect()
        gui:Destroy()
        return
    end
    
    mainImg.Image = ids[math.random(#ids)]
    mainImg.ImageTransparency = 0.78 + math.random()*0.18
    local sz = 48 + math.random(0,32)
    mainImg.TileSize = UDim2.new(0,sz,0,sz)
    local r = math.random(80,120)/100
    local g = math.random(70,110)/100
    local b = math.random(90,130)/100
    mainImg.ImageColor3 = Color3.new(r,g,b)
    
    if tick() - lastFlash >= flashInterval then
        flashFrame.BackgroundTransparency = 0.65 + math.random()*0.25
        lastFlash = tick()
    else
        flashFrame.BackgroundTransparency = 1
    end
    
    if math.random() < 0.03 then
        local x = math.random(0,800)
        local y = math.random(0,600)
        local w = math.random(20,80)
        local h = math.random(10,40)
        local highlight = Instance.new("Frame",gui)
        highlight.Size = UDim2.new(0,w,0,h)
        highlight.Position = UDim2.new(0,x,0,y)
        highlight.BackgroundColor3 = Color3.new(1,1,1)
        highlight.BackgroundTransparency = 0.5 + math.random()*0.3
        highlight.BorderSizePixel = 0
        game:GetService("Debris"):AddItem(highlight,0.06)
    end
end)
    local entity = spawner.Create({
        Entity = {
            Name = "Deer god",
            Asset = "124669690938872",
            HeightOffset = 1.2
        },
        Lights = {
            Flicker = { Enabled = true, Duration = 50 },
            Shatter = true,
            Repair = false
        },
        Earthquake = { Enabled = false },
        CameraShake = {
            Enabled = true,
            Range = 1500,
            Values = {0.5, 5, 0.1, 1}
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
                "MultiMonster", 
                "MultiMonster"
            },
            Cause = "MultiMonster"
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
            then 
                return 
            end

            local nearestPlayer = nil
            local nearestDist = math.huge
            local entityPos = entityModel.PrimaryPart.Position

            for _, player in ipairs(Players:GetPlayers()) do
                local char = player.Character
                if char and char:FindFirstChild("Humanoid") and char:FindFirstChild("HumanoidRootPart") then
                    local humanoid = char.Humanoid
                    if humanoid.Health > 0 then
                        local targetRoot = char.HumanoidRootPart
                        local dist = (targetRoot.Position - entityPos).Magnitude
                        if dist < nearestDist then
                            nearestDist = dist
                            nearestPlayer = player
                        end
                    end
                end
            end

            if not nearestPlayer then return end

            local targetChar = nearestPlayer.Character
            if not targetChar then return end

            local targetRoot = targetChar:FindFirstChild("HumanoidRootPart")
            if not targetRoot then return end

            local pos = entityModel.PrimaryPart.Position
            local target = targetRoot.Position
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
    end

function entityBehaviors.MS()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local NEAR_SOUND_DISTANCE = 115
local FAR_MAX_DISTANCE = 360
local FAR_MIN_VOLUME = 0.02
local MODEL_Y_OFFSET = -12
local SOUND_CONFIRM_TIME = 0.08

local function GitAud(soundgit, filename)
    local url = soundgit
    local FileName = filename
    writefile(FileName .. ".mp3", game:HttpGet(url))
    return (getcustomasset or getsynasset)(FileName .. ".mp3")
end

local SilenceAudio = GitAud(
    "https://github.com/Zero0Star/RipperNewSound/blob/master/Silence.mp3?raw=true",
    "Silence"
)

local SilenceFarAudio = GitAud(
    "https://github.com/Zero0Star/RipperNewSound/blob/master/SilenceFar.mp3?raw=true",
    "SilenceFar"
)

local SilenceSound = workspace:FindFirstChild("SilenceAudio")

if not SilenceSound or not SilenceSound:IsA("Sound") then
    if SilenceSound then
        SilenceSound:Destroy()
    end

    SilenceSound = Instance.new("Sound")
    SilenceSound.Name = "SilenceAudio"
    SilenceSound.Parent = workspace
end

SilenceSound.SoundId = SilenceAudio
SilenceSound.Volume = 5
SilenceSound.Looped = false

local SilenceFarSound = workspace:FindFirstChild("SilenceFarAudio")

if not SilenceFarSound or not SilenceFarSound:IsA("Sound") then
    if SilenceFarSound then
        SilenceFarSound:Destroy()
    end

    SilenceFarSound = Instance.new("Sound")
    SilenceFarSound.Name = "SilenceFarAudio"
    SilenceFarSound.Parent = workspace
end

SilenceFarSound.SoundId = SilenceFarAudio
SilenceFarSound.Volume = 1
SilenceFarSound.Looped = false

local player = Players.LocalPlayer

local function GetPlayerPosition()
    local character = player.Character

    if character then
        local root = character:FindFirstChild("HumanoidRootPart")

        if root then
            return root.Position
        end
    end

    local camera = workspace.CurrentCamera

    if camera then
        return camera.CFrame.Position
    end

    return Vector3.zero
end

local function GetDistance(position)
    return (GetPlayerPosition() - position).Magnitude
end

local function ResetSound(sound)
    sound:Stop()

    pcall(function()
        sound.TimePosition = 0
    end)
end

local function GetFarVolume(distance)
    if distance <= NEAR_SOUND_DISTANCE then
        return 1
    end

    if distance >= FAR_MAX_DISTANCE then
        return FAR_MIN_VOLUME
    end

    local alpha =
        (distance - NEAR_SOUND_DISTANCE)
        / (FAR_MAX_DISTANCE - NEAR_SOUND_DISTANCE)

    local volume =
        (1 - alpha) ^ 1.25

    return math.clamp(
        volume,
        FAR_MIN_VOLUME,
        1
    )
end

local shakeID = 0
local currentShake = nil
local currentShakeOffset = CFrame.new()
local currentOriginalFOV = nil

local function StopShake()
    local camera = workspace.CurrentCamera

    if currentShake then
        pcall(function()
            RunService:UnbindFromRenderStep(currentShake)
        end)
    end

    if camera then
        pcall(function()
            camera.CFrame =
                camera.CFrame
                * currentShakeOffset:Inverse()
        end)

        if currentOriginalFOV then
            camera.FieldOfView =
                currentOriginalFOV
        end
    end

    currentShake = nil
    currentShakeOffset = CFrame.new()
    currentOriginalFOV = nil
end

local function SilenceShake(entityPosition)
    local camera = workspace.CurrentCamera

    if not camera then
        return
    end

    StopShake()

    shakeID += 1

    local bindName =
        "SilenceShake_" .. shakeID

    currentShake = bindName
    currentShakeOffset = CFrame.new()

    local distance =
        GetDistance(entityPosition)

    local distancePower =
        math.clamp(
            1 - ((distance - 8) / 190),
            0.05,
            1
        )

    local shakeStrength =
        0.2
        + ((distancePower ^ 1.35) * 3.8)

    local originalFOV =
        camera.FieldOfView

    currentOriginalFOV =
        originalFOV

    local targetFOV =
        math.clamp(
            originalFOV
            + 72 * distancePower,
            originalFOV,
            120
        )

    local attackTime = 0.07
    local fadeTime = 2.1
    local totalTime =
        attackTime + fadeTime

    local started =
        os.clock()

    RunService:BindToRenderStep(
        bindName,
        Enum.RenderPriority.Camera.Value + 1,
        function()
            if currentShake ~= bindName then
                return
            end

            local elapsed =
                os.clock() - started

            if elapsed >= totalTime then
                camera.CFrame =
                    camera.CFrame
                    * currentShakeOffset:Inverse()

                currentShakeOffset =
                    CFrame.new()

                camera.FieldOfView =
                    originalFOV

                RunService:UnbindFromRenderStep(
                    bindName
                )

                if currentShake == bindName then
                    currentShake = nil
                    currentOriginalFOV = nil
                end

                return
            end

            local envelope
            local fov

            if elapsed <= attackTime then
                local alpha =
                    math.clamp(
                        elapsed / attackTime,
                        0,
                        1
                    )

                local impact =
                    1 - ((1 - alpha) ^ 5)

                envelope = impact

                fov =
                    originalFOV
                    + (
                        targetFOV
                        - originalFOV
                    )
                    * impact
            else
                local alpha =
                    math.clamp(
                        (elapsed - attackTime)
                        / fadeTime,
                        0,
                        1
                    )

                envelope =
                    (1 - alpha) ^ 1.3

                fov =
                    originalFOV
                    + (
                        targetFOV
                        - originalFOV
                    )
                    * envelope
            end

            camera.FieldOfView =
                fov

            local t =
                math.max(
                    elapsed - attackTime,
                    0
                )

            local wave1 =
                math.sin(
                    t * math.pi * 9.4
                )

            local wave2 =
                math.sin(
                    t * math.pi * 15.8
                    + 0.75
                )

            local wave3 =
                math.sin(
                    t * math.pi * 22.2
                    + 1.6
                )

            local verticalWave =
                math.sin(
                    t * math.pi * 12.6
                    + 1.15
                )

            local rollWave =
                math.sin(
                    t * math.pi * 10.1
                    + 0.35
                )

            local pitchWave =
                math.sin(
                    t * math.pi * 7.5
                    + 1.1
                )

            local x =
                (
                    wave1 * 0.22
                    + wave2 * 0.07
                    + wave3 * 0.025
                )
                * shakeStrength
                * envelope

            local y =
                verticalWave
                * 0.032
                * shakeStrength
                * envelope

            local yaw =
                (
                    wave1 * math.rad(0.6)
                    + wave2 * math.rad(0.18)
                )
                * shakeStrength
                * envelope

            local roll =
                rollWave
                * math.rad(0.88)
                * shakeStrength
                * envelope

            local pitch =
                pitchWave
                * math.rad(0.14)
                * shakeStrength
                * envelope

            local newOffset =
                CFrame.new(
                    x,
                    y,
                    0
                )
                * CFrame.Angles(
                    pitch,
                    yaw,
                    roll
                )

            camera.CFrame =
                camera.CFrame
                * currentShakeOffset:Inverse()
                * newOffset

            currentShakeOffset =
                newOffset
        end
    )
end

local jumpscareActive = false
local jumpscareFinished = false

local function TriggerJumpscare()
    if jumpscareActive or jumpscareFinished then
        return
    end

    jumpscareActive = true

    ResetSound(SilenceFarSound)
    ResetSound(SilenceSound)

    SilenceSound.Volume = 5
    SilenceSound:Play()

    StopShake()

    local character =
        player.Character

    if not character then
        jumpscareActive = false
        return
    end

    local humanoid =
        character:FindFirstChildOfClass(
            "Humanoid"
        )

    local playerGui =
        player:WaitForChild(
            "PlayerGui"
        )

    local oldGui =
        playerGui:FindFirstChild(
            "SilenceJumpscare"
        )

    if oldGui then
        oldGui:Destroy()
    end

    local gui =
        Instance.new("ScreenGui")

    gui.Name =
        "SilenceJumpscare"

    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.DisplayOrder = 1000000

    gui.ZIndexBehavior =
        Enum.ZIndexBehavior.Sibling

    gui.Parent =
        playerGui

    local black =
        Instance.new("Frame")

    black.Size =
        UDim2.fromScale(1, 1)

    black.Position =
        UDim2.fromScale(0, 0)

    black.BackgroundColor3 =
        Color3.new(0, 0, 0)

    black.BorderSizePixel = 0
    black.ZIndex = 1
    black.Parent = gui

    local snow =
        Instance.new("ImageLabel")

    snow.AnchorPoint =
        Vector2.new(0.5, 0.5)

    snow.Position =
        UDim2.fromScale(0.5, 0.5)

    snow.Size =
        UDim2.fromScale(1.1, 1.1)

    snow.BackgroundTransparency = 1
    snow.ImageTransparency = 0

    snow.ScaleType =
        Enum.ScaleType.Stretch

    snow.ZIndex = 2
    snow.Parent = gui

    local jumpscare =
        Instance.new("ImageLabel")

    jumpscare.AnchorPoint =
        Vector2.new(0.5, 0.5)

    jumpscare.Position =
        UDim2.fromScale(0.5, 0.5)

    jumpscare.Size =
        UDim2.fromScale(1.02, 1.02)

    jumpscare.BackgroundTransparency = 1

    jumpscare.Image =
        "rbxassetid://14359776338"

    jumpscare.ImageTransparency = 0

    jumpscare.ScaleType =
        Enum.ScaleType.Stretch

    jumpscare.ZIndex = 3
    jumpscare.Parent = gui

    local snowImages = {
        "rbxassetid://117266253034518",
        "rbxassetid://8454012934",
        "rbxassetid://122347391038526"
    }

    snow.Image =
        snowImages[1]

    local camera =
        workspace.CurrentCamera

    local originalFOV =
        camera and camera.FieldOfView or 70

    local duration = 0.8
    local started = os.clock()
    local snowIndex = 1
    local lastSnow = 0

    while true do
        local elapsed =
            os.clock() - started

        local alpha =
            math.clamp(
                elapsed / duration,
                0,
                1
            )

        if elapsed - lastSnow >= 0.045 then
            lastSnow = elapsed

            snowIndex += 1

            if snowIndex > #snowImages then
                snowIndex = 1
            end

            snow.Image =
                snowImages[snowIndex]
        end

        local curve =
            1 - ((1 - alpha) ^ 3)

        local pulse =
            math.sin(
                alpha
                * math.pi
                * 9
            )

        local scale =
            1.02
            + curve * 0.12
            + pulse
            * 0.014
            * (1 - alpha)

        jumpscare.Size =
            UDim2.fromScale(
                scale,
                scale
            )

        jumpscare.Rotation =
            math.sin(
                alpha
                * math.pi
                * 11
            )
            * 0.75
            * (1 - alpha)

        local snowScale =
            1.1
            + math.sin(
                alpha
                * math.pi
                * 13
            )
            * 0.02

        snow.Size =
            UDim2.fromScale(
                snowScale,
                snowScale
            )

        if camera then
            camera.FieldOfView =
                originalFOV
                + 8 * curve
                + (
                    math.sin(
                        alpha
                        * math.pi
                        * 8
                    )
                    * 1.5
                    * (1 - alpha)
                )
        end

        if alpha >= 1 then
            break
        end

        RunService.RenderStepped:Wait()
    end

    if humanoid and humanoid.Parent then
        humanoid:TakeDamage(100)
    end

    local fadeDuration =
        0.45

    local fadeStarted =
        os.clock()

    while true do
        local alpha =
            math.clamp(
                (os.clock() - fadeStarted)
                / fadeDuration,
                0,
                1
            )

        local eased =
            1 - ((1 - alpha) ^ 3)

        jumpscare.ImageTransparency =
            eased

        snow.ImageTransparency =
            eased

        black.BackgroundTransparency =
            eased

        jumpscare.Size =
            UDim2.fromScale(
                1.14
                + eased * 0.04,
                1.14
                + eased * 0.04
            )

        if camera then
            camera.FieldOfView =
                originalFOV
                + 8
                * (1 - eased)
        end

        if alpha >= 1 then
            break
        end

        RunService.RenderStepped:Wait()
    end

    if camera then
        camera.FieldOfView =
            originalFOV
    end

    gui:Destroy()

    jumpscareFinished = true
    jumpscareActive = false
end

local soundWatchConnection = nil
local soundConnections = {}
local soundConfirmTokens = {}
local nearSilence = false

local function IsRealPlayingSound(object)
    if not object then
        return false
    end

    if not object:IsA("Sound") then
        return false
    end

    local character =
        player.Character

    if not character then
        return false
    end

    if not object:IsDescendantOf(character) then
        return false
    end

    if object.SoundId == "" then
        return false
    end

    if object.Volume <= 0 then
        return false
    end

    if not object.Playing then
        return false
    end

    return true
end

local function CancelSoundConfirmation(sound)
    soundConfirmTokens[sound] =
        (soundConfirmTokens[sound] or 0) + 1
end

local function ConfirmPlayingSound(sound)
    if not nearSilence then
        return
    end

    if jumpscareActive or jumpscareFinished then
        return
    end

    if not IsRealPlayingSound(sound) then
        return
    end

    soundConfirmTokens[sound] =
        (soundConfirmTokens[sound] or 0) + 1

    local token =
        soundConfirmTokens[sound]

    task.delay(
        SOUND_CONFIRM_TIME,
        function()
            if not nearSilence then
                return
            end

            if jumpscareActive or jumpscareFinished then
                return
            end

            if soundConfirmTokens[sound] ~= token then
                return
            end

            if not sound or not sound.Parent then
                return
            end

            if not IsRealPlayingSound(sound) then
                return
            end

            task.spawn(
                TriggerJumpscare
            )
        end
    )
end

local function DisconnectWatchedSound(sound)
    local connections =
        soundConnections[sound]

    if connections then
        for _, connection in ipairs(
            connections
        ) do
            if connection then
                connection:Disconnect()
            end
        end
    end

    soundConnections[sound] = nil
    soundConfirmTokens[sound] = nil
end

local function WatchSound(sound)
    if not sound:IsA("Sound") then
        return
    end

    DisconnectWatchedSound(sound)

    soundConnections[sound] = {}

    table.insert(
        soundConnections[sound],
        sound:GetPropertyChangedSignal(
            "Playing"
        ):Connect(function()
            if sound.Playing then
                ConfirmPlayingSound(sound)
            else
                CancelSoundConfirmation(sound)
            end
        end)
    )

    table.insert(
        soundConnections[sound],
        sound.AncestryChanged:Connect(
            function()
                local character =
                    player.Character

                if
                    not character
                    or not sound:IsDescendantOf(character)
                then
                    CancelSoundConfirmation(sound)
                    DisconnectWatchedSound(sound)
                end
            end
        )
    )

    if sound.Playing then
        ConfirmPlayingSound(sound)
    end
end

local function StopSoundWatcher()
    nearSilence = false

    if soundWatchConnection then
        soundWatchConnection:Disconnect()
        soundWatchConnection = nil
    end

    local sounds = {}

    for sound in pairs(
        soundConnections
    ) do
        table.insert(
            sounds,
            sound
        )
    end

    for _, sound in ipairs(
        sounds
    ) do
        CancelSoundConfirmation(sound)
        DisconnectWatchedSound(sound)
    end

    table.clear(
        soundConfirmTokens
    )
end

local function StartSoundWatcher()
    StopSoundWatcher()

    local character =
        player.Character

    if not character then
        return
    end

    nearSilence = true

    for _, object in ipairs(
        character:GetDescendants()
    ) do
        if object:IsA("Sound") then
            WatchSound(object)
        end
    end

    soundWatchConnection =
        character.DescendantAdded:Connect(
            function(object)
                if not nearSilence then
                    return
                end

                if object:IsA("Sound") then
                    WatchSound(object)
                end
            end
        )
end

local audioToken = 0

local function StartRoomAudio(
    entityPosition,
    totalDuration
)
    audioToken += 1

    local token =
        audioToken

    ResetSound(SilenceSound)
    ResetSound(SilenceFarSound)

    task.spawn(
        SilenceShake,
        entityPosition
    )

    task.spawn(function()
        local started =
            os.clock()

        local currentMode =
            nil

        while
            audioToken == token
            and not jumpscareFinished
            and os.clock() - started < totalDuration
        do
            local distance =
                GetDistance(
                    entityPosition
                )

            if distance <= NEAR_SOUND_DISTANCE then
                if currentMode ~= "near" then
                    ResetSound(
                        SilenceFarSound
                    )

                    ResetSound(
                        SilenceSound
                    )

                    SilenceSound.Volume =
                        5

                    SilenceSound:Play()

                    currentMode =
                        "near"
                end

                if not nearSilence then
                    StartSoundWatcher()
                end
            else
                if nearSilence then
                    StopSoundWatcher()
                end

                local farVolume =
                    GetFarVolume(
                        distance
                    )

                if currentMode ~= "far" then
                    ResetSound(
                        SilenceSound
                    )

                    ResetSound(
                        SilenceFarSound
                    )

                    SilenceFarSound.Volume =
                        farVolume

                    SilenceFarSound:Play()

                    currentMode =
                        "far"
                else
                    SilenceFarSound.Volume =
                        farVolume
                end
            end

            RunService.Heartbeat:Wait()
        end

        if nearSilence then
            StopSoundWatcher()
        end
    end)
end

function entityBehaviors.MS()
    jumpscareActive = false
    jumpscareFinished = false

    StopSoundWatcher()

    local CurrentRooms =
        workspace:WaitForChild(
            "CurrentRooms"
        )

    local rooms = {}

    for _, room in ipairs(
        CurrentRooms:GetChildren()
    ) do
        local number =
            tonumber(room.Name)

        if
            number
            and number >= 1
            and number <= 100
        then
            table.insert(
                rooms,
                {
                    Number = number,
                    Room = room
                }
            )
        end
    end

    table.sort(
        rooms,
        function(a, b)
            return
                a.Number
                < b.Number
        end
    )

    if #rooms == 0 then
        return
    end

    local loaded =
        game:GetObjects(
            "rbxassetid://94655489412905"
        )

    local Silence =
        loaded[1]

    if not Silence then
        return
    end

    if not Silence:IsA("Model") then
        local holder =
            Instance.new("Model")

        holder.Name =
            "Silence"

        Silence.Parent =
            holder

        Silence =
            holder
    end

    Silence.Name =
        "Silence"

    Silence.Parent =
        workspace

    for _, object in ipairs(
        Silence:GetDescendants()
    ) do
        if object:IsA("BasePart") then
            object.Anchored = true
            object.CanCollide = false
            object.CanTouch = false
            object.CanQuery = false
        end
    end

    local modelRotation =
        Silence:GetPivot().Rotation

    Silence:PivotTo(
        CFrame.new(
            0,
            0,
            0
        )
        * modelRotation
    )

    local modelBoxCF,
        modelBoxSize =
        Silence:GetBoundingBox()

    local modelBottom =
        modelBoxCF.Position.Y
        - modelBoxSize.Y * 0.5

    local bottomOffset =
        -modelBottom

    local function GetRoomSize(room)
        if room:IsA("Model") then
            local _, size =
                room:GetBoundingBox()

            return size
        end

        if room:IsA("BasePart") then
            return room.Size
        end

        return Vector3.new(
            30,
            20,
            30
        )
    end

    local function FindFloor(room)
        local entrance =
            room:FindFirstChild(
                "RoomEntrance"
            )

        if not entrance then
            entrance =
                room:FindFirstChild(
                    "RoomEntrance",
                    true
                )
        end

        if
            entrance
            and entrance:IsA("BasePart")
        then
            local targetCF =
                entrance.CFrame
                * CFrame.new(
                    0,
                    0,
                    -15
                )

            local target =
                targetCF.Position

            local params =
                RaycastParams.new()

            params.FilterType =
                Enum.RaycastFilterType.Include

            params.FilterDescendantsInstances = {
                room
            }

            params.IgnoreWater =
                true

            local origin =
                target
                + Vector3.new(
                    0,
                    35,
                    0
                )

            local result =
                workspace:Raycast(
                    origin,
                    Vector3.new(
                        0,
                        -90,
                        0
                    ),
                    params
                )

            if result then
                return
                    result.Position,
                    GetRoomSize(room)
            end

            return
                target,
                GetRoomSize(room)
        end

        if room:IsA("Model") then
            local cf, size =
                room:GetBoundingBox()

            local params =
                RaycastParams.new()

            params.FilterType =
                Enum.RaycastFilterType.Include

            params.FilterDescendantsInstances = {
                room
            }

            params.IgnoreWater =
                true

            local origin =
                cf.Position
                + Vector3.new(
                    0,
                    size.Y * 0.5 + 10,
                    0
                )

            local result =
                workspace:Raycast(
                    origin,
                    Vector3.new(
                        0,
                        -(size.Y + 30),
                        0
                    ),
                    params
                )

            if result then
                return
                    result.Position,
                    size
            end

            return
                Vector3.new(
                    cf.Position.X,
                    cf.Position.Y
                    - size.Y * 0.5,
                    cf.Position.Z
                ),
                size
        end

        if room:IsA("BasePart") then
            return
                room.Position
                - Vector3.new(
                    0,
                    room.Size.Y * 0.5,
                    0
                ),
                room.Size
        end

        return
            Vector3.zero,
            Vector3.new(
                30,
                20,
                30
            )
    end

    local function PivotSilence(position)
        Silence:PivotTo(
            CFrame.new(position)
            * modelRotation
        )
    end

    local function MoveVertical(
        startPosition,
        endPosition,
        duration,
        descending
    )
        local started =
            os.clock()

        while true do
            if jumpscareFinished then
                return false
            end

            local alpha =
                math.clamp(
                    (os.clock() - started)
                    / duration,
                    0,
                    1
                )

            local eased

            if descending then
                eased =
                    1
                    - ((1 - alpha) ^ 4)
            else
                eased =
                    alpha ^ 4
            end

            PivotSilence(
                startPosition:Lerp(
                    endPosition,
                    eased
                )
            )

            if alpha >= 1 then
                break
            end

            RunService.RenderStepped:Wait()
        end

        PivotSilence(
            endPosition
        )

        return true
    end

    for _, data in ipairs(
        rooms
    ) do
        if jumpscareFinished then
            break
        end

        local floorPosition,
            roomSize =
            FindFloor(
                data.Room
            )

        local landingPosition =
            floorPosition
            + Vector3.new(
                0,
                bottomOffset
                + MODEL_Y_OFFSET,
                0
            )

        local spawnHeight =
            math.max(
                roomSize.Y + 35,
                45
            )

        local upperPosition =
            landingPosition
            + Vector3.new(
                0,
                spawnHeight,
                0
            )

        PivotSilence(
            upperPosition
        )

        StartRoomAudio(
            landingPosition,
            5.2
        )

        local moved =
            MoveVertical(
                upperPosition,
                landingPosition,
                0.52,
                true
            )

        if not moved then
            break
        end

        local holdStarted =
            os.clock()

        while
            os.clock()
            - holdStarted
            < 4
        do
            if jumpscareFinished then
                break
            end

            RunService.Heartbeat:Wait()
        end

        if jumpscareFinished then
            break
        end

        moved =
            MoveVertical(
                landingPosition,
                upperPosition,
                0.42,
                false
            )

        if not moved then
            break
        end
    end

    audioToken += 1

    StopSoundWatcher()

    ResetSound(
        SilenceFarSound
    )

    if Silence and Silence.Parent then
        Silence:Destroy()
    end
end
end

function entityBehaviors.DeerGodTWO()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local ids = {"rbxassetid://8116159092","rbxassetid://435812828","rbxassetid://860440643"}

local gui = Instance.new("ScreenGui",player:WaitForChild("PlayerGui"))
gui.Name = "SnowGlitchEnhanced"
gui.IgnoreGuiInset = true

local mainImg = Instance.new("ImageLabel",gui)
mainImg.Size = UDim2.new(1,0,1,0)
mainImg.BackgroundTransparency = 1
mainImg.ImageTransparency = 0.88
mainImg.Image = ids[math.random(#ids)]
mainImg.ScaleType = Enum.ScaleType.Tile
mainImg.TileSize = UDim2.new(0,64,0,64)

local flashFrame = Instance.new("Frame",gui)
flashFrame.Size = UDim2.new(1,0,1,0)
flashFrame.BackgroundColor3 = Color3.new(1,1,1)
flashFrame.BackgroundTransparency = 1
flashFrame.BorderSizePixel = 0

local start = tick()
local lastFlash = tick()
local flashInterval = 0.15
local flashDuration = 0.05

local conn = RunService.RenderStepped:Connect(function()
    local elapsed = tick() - start
    if elapsed >= 60 then
        conn:Disconnect()
        gui:Destroy()
        return
    end
    
    mainImg.Image = ids[math.random(#ids)]
    mainImg.ImageTransparency = 0.78 + math.random()*0.18
    local sz = 48 + math.random(0,32)
    mainImg.TileSize = UDim2.new(0,sz,0,sz)
    local r = math.random(80,120)/100
    local g = math.random(70,110)/100
    local b = math.random(90,130)/100
    mainImg.ImageColor3 = Color3.new(r,g,b)
    
    if tick() - lastFlash >= flashInterval then
        flashFrame.BackgroundTransparency = 0.65 + math.random()*0.25
        lastFlash = tick()
    else
        flashFrame.BackgroundTransparency = 1
    end
    
    if math.random() < 0.03 then
        local x = math.random(0,800)
        local y = math.random(0,600)
        local w = math.random(20,80)
        local h = math.random(10,40)
        local highlight = Instance.new("Frame",gui)
        highlight.Size = UDim2.new(0,w,0,h)
        highlight.Position = UDim2.new(0,x,0,y)
        highlight.BackgroundColor3 = Color3.new(1,1,1)
        highlight.BackgroundTransparency = 0.5 + math.random()*0.3
        highlight.BorderSizePixel = 0
        game:GetService("Debris"):AddItem(highlight,0.06)
    end
end)
    local entity = spawner.Create({
        Entity = {
            Name = "DeerGod",
            Asset = "92755817727288",
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
            Speed = 25,
            Delay = 0,
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
            Cause = "Deer God"
        }
    })

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

    PlayPreloadedDeerGodSound(4)
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
    ["rbxassetid://22"]  = entityBehaviors.Muffler1,
    ["rbxassetid://32"]  = entityBehaviors.Muffler2,
    ["rbxassetid://33"]  = entityBehaviors.Muffler3,
    ["rbxassetid://31"]  = entityBehaviors.DeerGodTWO,
    ["rbxassetid://32"]  = entityBehaviors.SILENCECUR,
    ["rbxassetid://33"]  = entityBehaviors.HUNGERCUR,
    ["rbxassetid://34"]  = entityBehaviors.DEERCUR,
    ["rbxassetid://35"]  = entityBehaviors.RIPPCUR,
    ["rbxassetid://36"]  = entityBehaviors.REBOUCUR,
    ["rbxassetid://37"]  = entityBehaviors.JEFFXZ,
    ["rbxassetid://38"]  = entityBehaviors.JEFFZR,
    ["rbxassetid://99"]  = entityBehaviors.TOUSHI,
    ["rbxassetid://888"]  = entityBehaviors.WHATTHIS,
    ["rbxassetid://580"]  = entityBehaviors.SHOOPFY,
    ["rbxassetid://085"]  = entityBehaviors.MR,
    ["rbxassetid://086"]  = entityBehaviors.MRB,
    ["rbxassetid://087"]  = entityBehaviors.MC,
    ["rbxassetid://088"]  = entityBehaviors.MT,
    ["rbxassetid://089"]  = entityBehaviors.MD,
    ["rbxassetid://080"]  = entityBehaviors.MO,
    ["rbxassetid://081"]  = entityBehaviors.MM,
    ["rbxassetid://082"]  = entityBehaviors.MS,
    ["rbxassetid://12"]  = entityBehaviors.munci1
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
hint.Text = "LoadingFour... Doors HardCore V10.5 By Mr.key & HeavenNow :)"
game.Debris:AddItem(hint, 2)