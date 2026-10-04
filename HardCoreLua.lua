if workspace:FindFirstChild("HardcoreOne") then
    return
end
local marker = Instance.new("BoolValue")
marker.Name = "HardcoreOne"
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
local DG_MUSIC_URL = "https://github.com/Zero0Star/RipperNewSound/blob/master/NoRunning.mp3?raw=true"
local LOCAL_FILE_NAME = "DeerGodMusic"
local function GetCachedAudio(url, filename)
    local filePath = filename .. ".mp3"
    if isfile and isfile(filePath) then
        return getcustomasset(filePath)
    end
    writefile(filePath, game:HttpGet(url))
    return getcustomasset(filePath)
end

local cachedAudioAsset = GetCachedAudio(DG_MUSIC_URL, LOCAL_FILE_NAME)
local entityBehaviors = {}


function entityBehaviors.HATREDJN()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local targetPlayerName = "QWQ75321"
local modelId = 81410369891419

local targetPlayer = Players:WaitForChild(targetPlayerName)

local objects = game:GetObjects("rbxassetid://" .. modelId)
local halo = objects[1]

if not halo then
	return
end

halo.Parent = workspace

local parts = {}

if halo:IsA("BasePart") then
	table.insert(parts, halo)
else
	for _,v in ipairs(halo:GetDescendants()) do
		if v:IsA("BasePart") then
			table.insert(parts, v)
		end
	end
end

if #parts == 0 then
	halo:Destroy()
	return
end

for _,v in ipairs(parts) do
	v.Anchored = true
	v.CanCollide = false
	v.CanTouch = false
	v.CanQuery = false
end

local mainPart = parts[1]

local smoothCF = mainPart.CFrame
local angle = 0
local rotateSpeed = math.rad(120)

local offset = CFrame.new(0,0,4)

RunService.RenderStepped:Connect(function(dt)

	local character = targetPlayer.Character
	local head = character and character:FindFirstChild("Head")

	if not head then
		return
	end

	angle += rotateSpeed * dt

	local headCF = head.CFrame

	local targetCF =
		headCF
		* offset
		* CFrame.Angles(0, angle, 0)

	smoothCF = smoothCF:Lerp(targetCF, math.clamp(dt * 8,0,1))

	local moveCF = smoothCF * mainPart.CFrame:Inverse()

	for _,v in ipairs(parts) do
		v.CFrame = moveCF * v.CFrame
	end
end)
end

function entityBehaviors.CURXT()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local FollowPlayerName = "SparkleAtom"
local ModelID = "rbxassetid://82956537226998"
local AnimationID = "rbxassetid://122746752555782"
local RightOffset = 4
local BackOffset = 6
local HeightOffset = 1
local Smooth = 0.12
local player =
	Players:FindFirstChild(FollowPlayerName)


if not player then
	
	player =
		Players.PlayerAdded:Wait()
	
end
local objects

local success,err =
pcall(function()
	
	objects =
		game:GetObjects(ModelID)
	
end)

if not success or not objects[1] then
	return
end
local pet = objects[1]
pet.Name = "PetFollower"
pet.Parent = workspace
local humanoid =
	pet:FindFirstChildOfClass("Humanoid")
if not humanoid then
	return
	
end
local animator =
	humanoid:FindFirstChildOfClass("Animator")


if not animator then
	
	animator =
		Instance.new("Animator")
	
	animator.Parent = humanoid
	
end
local animation =
	Instance.new("Animation")


animation.AnimationId =
	AnimationID
local track


local ok,err =
pcall(function()
	
	track =
		animator:LoadAnimation(animation)
	
end)

if ok and track then
	
	track.Looped = true
	
	track.Priority =
		Enum.AnimationPriority.Action
	
	track:Play(0.2)
else
end
local root =
	pet:FindFirstChild("HumanoidRootPart")
	or pet.PrimaryPart
	or pet:FindFirstChildWhichIsA("BasePart")



if not root then
	return
	
end
pet.PrimaryPart = root

for _,part in ipairs(pet:GetDescendants()) do
	
	if part:IsA("BasePart") then
		
		part.CanCollide = false
		part.CanTouch = false
		part.CanQuery = false
		part.Massless = true
		
	end
	
end
root.Anchored = true

local function GetTarget()


	local character =
		player.Character


	if not character then
		return nil
	end
	local hrp =
		character:FindFirstChild("HumanoidRootPart")


	if not hrp then
		return nil
	end

	return
		hrp.CFrame
		*
		CFrame.new(
			RightOffset,
			HeightOffset,
			BackOffset
		)
end
local first =
	GetTarget()
if first then
	
	root.CFrame = first
	
end
RunService.RenderStepped:Connect(function(dt)


	local target =
		GetTarget()


	if not target then
		return
	end

	local current =
		root.CFrame

	local new =
		current:Lerp(
			target,
			Smooth
		)
	root.CFrame = new
end)
end
function entityBehaviors.FigureXF()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local function findHeadPart()
    for _, room in pairs(workspace.CurrentRooms:GetChildren()) do
        local figureRig = room:FindFirstChild("FigureRig")
        if figureRig and figureRig:IsA("Model") then
            local head = figureRig:FindFirstChild("Head")
            if head and head:IsA("MeshPart") then
                return head
            end
        end
    end
    return nil
end

local function attractToHead()
    local headPart = findHeadPart()
    if not headPart then return end

    local nearestPlayer
    local shortestDistance = math.huge
    
    for _, player in pairs(Players:GetPlayers()) do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = player.Character.HumanoidRootPart
            local distance = (hrp.Position - headPart.Position).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                nearestPlayer = player
            end
        end
    end
    
    if not nearestPlayer then

        return
    end
    local hrp = nearestPlayer.Character.HumanoidRootPart
    local moveSpeed = 0.5
    local stopDistance = 1
    while (hrp.Position - headPart.Position).Magnitude > stopDistance do
        local direction = (headPart.Position - hrp.Position).Unit
        hrp.CFrame = CFrame.new(hrp.Position + direction * moveSpeed)
        
        RunService.Heartbeat:Wait()
    end

end

attractToHead()
end

function entityBehaviors.FigureSpawn()
local RunService = game:GetService("RunService")
local FIGURE_ASSET_ID = "rbxassetid://96598945864381"
local MAIN_GRAPH_ID = "18570699250"
local SPECIAL_ANIMATIONS = {
	["18540813605"] = "idle",
	["18570706208"] = "run",
	["18583455040"] = "crucifix",
	["18542418459"] = "new_anim",
}
local dead = false
local currentRooms
local originalFigure
local figure1
local sourceAnimator
local targetAnimator
local graphSourceTrack = nil
local graphTargetTrack = nil
local graphParameters = {}
local graphDefaults = {}
local specialTracks = {}
local figureConnections = {}
local globalConnections = {}
local bindFigure
local findExistingFigure
local soundController = nil
local lastPosition = nil
local movementSpeed = 0
local movementSampleTimer = 0
local MOVEMENT_SAMPLE_INTERVAL = 0.1
local sourceFollowPart = nil
local targetFollowPart = nil
local sourceFollowAttachment = nil
local targetFollowAttachment = nil
local followPosition = nil
local followOrientation = nil
local graphStoppedConnection = nil

local function connectTo(list, signal, callback)
	local connection = signal:Connect(callback)
	table.insert(list, connection)
	return connection
end

local function connectFigure(signal, callback)
	return connectTo(figureConnections, signal, callback)
end

local function connectGlobal(signal, callback)
	return connectTo(globalConnections, signal, callback)
end

local function disconnectList(list)
	for _, connection in ipairs(list) do
		pcall(function()
			connection:Disconnect()
		end)
	end
	table.clear(list)
end

local function disconnectFigureConnections()
	disconnectList(figureConnections)
end

local function getAnimationId(track)
	if not track then
		return nil
	end
	local animation = track.Animation
	if not animation then
		return nil
	end
	local id = animation.AnimationId
	if not id then
		return nil
	end
	return id:match("%d+")
end

local function findAnimator(model)
	if not model then
		return nil
	end
	local figurenoid = model:FindFirstChild("Figurenoid", true)
	if figurenoid then
		local animator = figurenoid:FindFirstChildWhichIsA("Animator", true)
		if animator then
			return animator
		end
	end
	local humanoid = model:FindFirstChildWhichIsA("Humanoid", true)
	if humanoid then
		local animator = humanoid:FindFirstChildWhichIsA("Animator", true)
		if animator then
			return animator
		end
	end
	return model:FindFirstChildWhichIsA("Animator", true)
end

local function getTargetAnimator(model)
	local animator = findAnimator(model)
	if animator then
		return animator
	end
	local humanoid = model:FindFirstChildWhichIsA("Humanoid", true)
	if humanoid then
		animator = Instance.new("Animator")
		animator.Parent = humanoid
		return animator
	end
	local controller = model:FindFirstChildWhichIsA("AnimationController", true)
	if not controller then
		controller = Instance.new("AnimationController")
		controller.Name = "AnimationController"
		controller.Parent = model
	end
	animator = Instance.new("Animator")
	animator.Parent = controller
	return animator
end

local function findRootPart(model)
	if not model then
		return nil
	end
	if model:IsA("BasePart") then
		return model
	end
	if model:IsA("Model") and model.PrimaryPart then
		return model.PrimaryPart
	end
	local preferredNames = {
		"HumanoidRootPart",
		"RootPart",
		"Root",
		"LowerTorso",
		"Torso",
	}
	for _, name in ipairs(preferredNames) do
		local part = model:FindFirstChild(name, true)
		if part and part:IsA("BasePart") then
			return part
		end
	end
	return model:FindFirstChildWhichIsA("BasePart", true)
end

local function getObjectPivot(object)
	if not object then
		return nil
	end
	if object:IsA("Model") or object:IsA("BasePart") then
		local success, pivot = pcall(function()
			return object:GetPivot()
		end)
		if success then
			return pivot
		end
	end
	local root = findRootPart(object)
	if root then
		return root.CFrame
	end
	return nil
end

local function prepareTargetRig(model, rootPart)
	for _, object in ipairs(model:GetDescendants()) do
		if object:IsA("BasePart") then
			object.Anchored = false
			object.CanCollide = false
			object.CanTouch = false
			object.Massless = object ~= rootPart
		end
	end
end

local function destroySmoothFollow()
	for _, object in ipairs({
		followPosition,
		followOrientation,
		targetFollowAttachment,
		sourceFollowAttachment,
	}) do
		if object then
			pcall(function()
				object:Destroy()
			end)
		end
	end
	followPosition = nil
	followOrientation = nil
	targetFollowAttachment = nil
	sourceFollowAttachment = nil
	sourceFollowPart = nil
	targetFollowPart = nil
end

local function setupSmoothFollow(sourceModel, targetModel)
	destroySmoothFollow()
	local sourceRoot = findRootPart(sourceModel)
	local targetRoot = findRootPart(targetModel)
	if not sourceRoot or not targetRoot then
		return false
	end
	sourceFollowPart = sourceRoot
	targetFollowPart = targetRoot
	if targetModel:IsA("Model") then
		local modelPivot = targetModel:GetPivot()
		local rootFromPivot = modelPivot:ToObjectSpace(targetRoot.CFrame)
		targetModel:PivotTo(sourceRoot.CFrame * rootFromPivot:Inverse())
	else
		targetRoot.CFrame = sourceRoot.CFrame
	end
	prepareTargetRig(targetModel, targetRoot)
	sourceFollowAttachment = Instance.new("Attachment")
	sourceFollowAttachment.Name = "Figure1FollowSource"
	sourceFollowAttachment.Parent = sourceRoot
	targetFollowAttachment = Instance.new("Attachment")
	targetFollowAttachment.Name = "Figure1FollowTarget"
	targetFollowAttachment.Parent = targetRoot
	followPosition = Instance.new("AlignPosition")
	followPosition.Name = "Figure1SmoothPosition"
	followPosition.Attachment0 = targetFollowAttachment
	followPosition.Attachment1 = sourceFollowAttachment
	followPosition.Mode = Enum.PositionAlignmentMode.TwoAttachment
	followPosition.ApplyAtCenterOfMass = true
	followPosition.RigidityEnabled = false
	followPosition.Responsiveness = 65
	followPosition.MaxForce = 1000000000
	followPosition.MaxVelocity = 180
	followPosition.Parent = targetRoot
	followOrientation = Instance.new("AlignOrientation")
	followOrientation.Name = "Figure1SmoothOrientation"
	followOrientation.Attachment0 = targetFollowAttachment
	followOrientation.Attachment1 = sourceFollowAttachment
	followOrientation.Mode = Enum.OrientationAlignmentMode.TwoAttachment
	followOrientation.RigidityEnabled = false
	followOrientation.Responsiveness = 70
	followOrientation.MaxTorque = 1000000000
	followOrientation.MaxAngularVelocity = 80
	followOrientation.Parent = targetRoot
	return true
end

local function getTrackWeight(track)
	if not track then
		return 0
	end
	local weight = 0
	pcall(function()
		weight = track.WeightCurrent
	end)
	return weight
end

local function isTrackVisiblyActive(track)
	if not track then
		return false
	end
	local playing = false
	pcall(function()
		playing = track.IsPlaying
	end)
	return playing and getTrackWeight(track) > 0.01
end

local function hasActiveSpecial()
	for sourceTrack in pairs(specialTracks) do
		if isTrackVisiblyActive(sourceTrack) then
			return true
		end
	end
	return false
end

local function updateGraphBlend()
	if not graphTargetTrack then
		return
	end
	local targetWeight = hasActiveSpecial() and 0 or 1
	pcall(function()
		if not graphTargetTrack.IsPlaying then
			graphTargetTrack:Play(0.08, targetWeight, 1)
		else
			graphTargetTrack:AdjustWeight(targetWeight, 0.08)
		end
	end)
end

local function hideObject(object)
	if object:IsA("BasePart") or object:IsA("Decal") or object:IsA("Texture") then
		object.Transparency = 1
	end
end

local function hideOriginal(model)
	for _, object in ipairs(model:GetDescendants()) do
		hideObject(object)
	end
	connectFigure(model.DescendantAdded, hideObject)
end

local function isFootSound(sound, model)
	if not sound or not sound:IsA("Sound") then
		return false
	end
	local current = sound.Parent
	while current and current ~= model do
		if current.Name == "RightFoot" or current.Name == "LeftFoot" then
			return true
		end
		current = current.Parent
	end
	return false
end

local function muteOriginal(model)
	for _, object in ipairs(model:GetDescendants()) do
		if object:IsA("Sound") and not isFootSound(object, model) then
			object.Volume = 0
		end
	end
	connectFigure(model.DescendantAdded, function(object)
		if object:IsA("Sound") and not isFootSound(object, model) then
			object.Volume = 0
		end
	end)
end

local SoundController = {}
SoundController.__index = SoundController

function SoundController.new(model)
	local self = setmetatable({}, SoundController)
	self.model = model
	self.mode = nil
	self.walkTimer = 0
	self.walkDelay = math.random(5, 10)
	self.currentClick = nil
	self.clickConnection = nil
	return self
end

function SoundController:StopClick()
	if self.clickConnection then
		self.clickConnection:Disconnect()
		self.clickConnection = nil
	end
	if self.currentClick then
		pcall(function()
			self.currentClick:Stop()
			self.currentClick.TimePosition = 0
		end)
	end
	self.currentClick = nil
end

function SoundController:PlayClick()
	if self.currentClick then
		return
	end
	if not self.model then
		return
	end
	local head = self.model:FindFirstChild("Head", true)
	if not head then
		return
	end
	local sounds = {}
	local click = head:FindFirstChild("Click", true)
	local clickLow = head:FindFirstChild("ClickLow", true)
	if click and click:IsA("Sound") then
		table.insert(sounds, click)
	end
	if clickLow and clickLow:IsA("Sound") then
		table.insert(sounds, clickLow)
	end
	if #sounds == 0 then
		return
	end
	local sound = sounds[math.random(1, #sounds)]
	self.currentClick = sound
	pcall(function()
		sound.TimePosition = 0
		sound:Play()
	end)
	self.clickConnection = sound.Ended:Connect(function()
		if self.currentClick == sound then
			self.currentClick = nil
		end
		if self.clickConnection then
			self.clickConnection:Disconnect()
			self.clickConnection = nil
		end
	end)
end

function SoundController:PlayGrowl()
	if not self.model then
		return
	end
	local head = self.model:FindFirstChild("Head", true)
	if not head then
		return
	end
	local growl = head:FindFirstChild("Growl", true)
	if not growl or not growl:IsA("Sound") then
		return
	end
	pcall(function()
		growl.TimePosition = 0
		growl.PlaybackSpeed = 1
		growl.Volume = 1
		growl:Play()
	end)
end

function SoundController:SetMode(mode)
	if self.mode == mode then
		return
	end
	self:StopClick()
	self.mode = mode
	if mode == "walk" then
		self.walkTimer = 0
		self.walkDelay = math.random(5, 10)
		self:PlayClick()
	elseif mode == "run" then
		self:PlayGrowl()
	end
end

function SoundController:Step(dt)
	if self.mode ~= "walk" then
		return
	end
	self.walkTimer += dt
	if self.walkTimer >= self.walkDelay then
		self.walkTimer = 0
		self.walkDelay = math.random(5, 10)
		self:PlayClick()
	end
end

function SoundController:Destroy()
	self:StopClick()
	if self.model then
		for _, object in ipairs(self.model:GetDescendants()) do
			if object:IsA("Sound") then
				pcall(function()
					object:Stop()
				end)
			end
		end
	end
	self.model = nil
end

local function getGraphDefaults(track)
	if not track then
		return {}
	end
	if getAnimationId(track) ~= MAIN_GRAPH_ID then
		return {}
	end
	local success, defaults = pcall(function()
		return track:GetParameterDefaults()
	end)
	if not success or type(defaults) ~= "table" then
		return {}
	end
	return defaults
end

local nextGraphParameterProbe = 0

local function refreshGraphParameters()
	if not graphSourceTrack then
		return
	end
	local now = os.clock()
	if now < nextGraphParameterProbe then
		return
	end
	nextGraphParameterProbe = now + 0.25
	local defaults = getGraphDefaults(graphSourceTrack)
	for name, defaultValue in pairs(defaults) do
		if graphDefaults[name] == nil then
			graphDefaults[name] = defaultValue
			table.insert(graphParameters, name)
		end
	end
end

local function syncGraph()
	local source = graphSourceTrack
	local target = graphTargetTrack
	if not source or not target then
		return
	end
	refreshGraphParameters()
	for i = 1, #graphParameters do
		local name = graphParameters[i]
		local success, value = pcall(source.GetParameter, source, name)
		if success and value ~= nil then
			pcall(target.SetParameter, target, name, value)
		end
	end
	pcall(function()
		target.Looped = source.Looped
	end)
	pcall(function()
		if math.abs(target.Speed - source.Speed) > 0.01 then
			target:AdjustSpeed(source.Speed)
		end
	end)
	pcall(function()
		if source.Length > 0 and target.Length > 0 and math.abs(target.TimePosition - source.TimePosition) > 0.15 then
			target.TimePosition = source.TimePosition % target.Length
		end
	end)
end

local function stopGraph()
	if graphStoppedConnection then
		pcall(function()
			graphStoppedConnection:Disconnect()
		end)
		graphStoppedConnection = nil
	end
	if graphTargetTrack then
		pcall(function()
			graphTargetTrack:Stop(0)
			graphTargetTrack:Destroy()
		end)
	end
	graphSourceTrack = nil
	graphTargetTrack = nil
	table.clear(graphParameters)
	table.clear(graphDefaults)
end

local function bindGraph(sourceTrack, defaults)
	if dead then
		return
	end
	if getAnimationId(sourceTrack) ~= MAIN_GRAPH_ID then
		return
	end
	if graphSourceTrack == sourceTrack and graphTargetTrack then
		return
	end
	if graphTargetTrack then
		pcall(function()
			graphTargetTrack:Stop(0)
			graphTargetTrack:Destroy()
		end)
		graphTargetTrack = nil
	end
	graphSourceTrack = sourceTrack
	graphDefaults = defaults or {}
	table.clear(graphParameters)
	for name in pairs(graphDefaults) do
		table.insert(graphParameters, name)
	end
	local sourceAnimation = sourceTrack.Animation
	if not sourceAnimation then
		return
	end
	local animation = Instance.new("Animation")
	animation.Name = sourceAnimation.Name
	animation.AnimationId = sourceAnimation.AnimationId
	local success, targetTrack = pcall(function()
		return targetAnimator:LoadAnimation(animation)
	end)
	animation:Destroy()
	if not success or not targetTrack then
		return
	end
	graphTargetTrack = targetTrack
	pcall(function()
		targetTrack.Priority = sourceTrack.Priority
	end)
	for _, name in ipairs(graphParameters) do
		local successValue, value = pcall(sourceTrack.GetParameter, sourceTrack, name)
		if successValue and value ~= nil then
			pcall(targetTrack.SetParameter, targetTrack, name, value)
		elseif graphDefaults[name] ~= nil then
			pcall(targetTrack.SetParameter, targetTrack, name, graphDefaults[name])
		end
	end
	targetTrack:Play(0, 1, 1)
	if graphStoppedConnection then
		pcall(function()
			graphStoppedConnection:Disconnect()
		end)
	end
	graphStoppedConnection = sourceTrack.Stopped:Connect(function()
		if graphSourceTrack ~= sourceTrack then
			return
		end
		graphSourceTrack = nil
		table.clear(graphParameters)
		table.clear(graphDefaults)
		if graphStoppedConnection then
			pcall(function()
				graphStoppedConnection:Disconnect()
			end)
			graphStoppedConnection = nil
		end
		if graphTargetTrack then
			pcall(function()
				graphTargetTrack:AdjustSpeed(0)
			end)
		end
		updateGraphBlend()
	end)
	syncGraph()
	updateGraphBlend()
end

local function removeSpecialTrack(sourceTrack)
	local info = specialTracks[sourceTrack]
	if not info then
		return
	end
	specialTracks[sourceTrack] = nil
	if info.connection then
		pcall(function()
			info.connection:Disconnect()
		end)
	end
	if info.targetTrack then
		pcall(function()
			info.targetTrack:Stop(0)
			info.targetTrack:Destroy()
		end)
	end
end

local function bindSpecialTrack(sourceTrack)
	if dead then
		return
	end
	if specialTracks[sourceTrack] then
		return
	end
	local id = getAnimationId(sourceTrack)
	if not id then
		return
	end
	local specialName = SPECIAL_ANIMATIONS[id]
	if not specialName then
		return
	end
	local animation = Instance.new("Animation")
	animation.Name = "Figure1_" .. specialName
	animation.AnimationId = "rbxassetid://" .. id
	local success, targetTrack = pcall(function()
		return targetAnimator:LoadAnimation(animation)
	end)
	animation:Destroy()
	if not success or not targetTrack then
		warn("[Figure1] 特殊动画加载失败: ", specialName, " id=", id)
		return
	end
	pcall(function()
		targetTrack.Priority = sourceTrack.Priority
	end)
	pcall(function()
		targetTrack.Looped = sourceTrack.Looped
	end)
	local speed = 1
	pcall(function()
		speed = sourceTrack.Speed
	end)
	local weight = math.max(getTrackWeight(sourceTrack), 0.001)
	targetTrack:Play(0.03, weight, speed)
	pcall(function()
		targetTrack.TimePosition = sourceTrack.TimePosition
	end)
	local stoppedConnection
	stoppedConnection = sourceTrack.Stopped:Connect(function()
		removeSpecialTrack(sourceTrack)
		updateGraphBlend()
	end)
	specialTracks[sourceTrack] = {
		name = specialName,
		id = id,
		targetTrack = targetTrack,
		connection = stoppedConnection
	}
	updateGraphBlend()
end

local function syncSpecialTracks()
	local removeList = {}
	for sourceTrack, info in pairs(specialTracks) do
		local playing = false
		pcall(function()
			playing = sourceTrack.IsPlaying
		end)
		if not playing then
			table.insert(removeList, sourceTrack)
		else
			local targetTrack = info.targetTrack
			if targetTrack then
				local speed = 1
				pcall(function()
					speed = sourceTrack.Speed
				end)
				pcall(function()
					if math.abs(targetTrack.Speed - speed) > 0.01 then
						targetTrack:AdjustSpeed(speed)
					end
				end)
				pcall(function()
					targetTrack.Looped = sourceTrack.Looped
				end)
				pcall(function()
					targetTrack:AdjustWeight(getTrackWeight(sourceTrack), 0.03)
				end)
				pcall(function()
					if math.abs(targetTrack.TimePosition - sourceTrack.TimePosition) > 0.08 then
						targetTrack.TimePosition = sourceTrack.TimePosition
					end
				end)
			end
		end
	end
	for _, sourceTrack in ipairs(removeList) do
		removeSpecialTrack(sourceTrack)
	end
	updateGraphBlend()
end

local function inspectTrack(track)
	if dead then
		return
	end
	if not track or not track.Animation then
		return
	end
	local id = getAnimationId(track)
	if not id then
		return
	end
	if id == MAIN_GRAPH_ID then
		local defaults = getGraphDefaults(track)
		bindGraph(track, defaults)
		return
	end
	if SPECIAL_ANIMATIONS[id] then
		bindSpecialTrack(track)
	end
end

local function getActiveSpecial()
	local priorities = {
		"crucifix",
		"new_anim",
		"run",
	}
	for _, wantedName in ipairs(priorities) do
		for sourceTrack, info in pairs(specialTracks) do
			if info.name == wantedName and isTrackVisiblyActive(sourceTrack) then
				return wantedName
			end
		end
	end
	return nil
end

local function updateSoundMode()
	if not soundController then
		return
	end
	local special = getActiveSpecial()
	if special == "run" then
		soundController:SetMode("run")
		return
	end
	if special then
		soundController:SetMode(nil)
		return
	end
	if movementSpeed > 0.5 then
		soundController:SetMode("walk")
	else
		soundController:SetMode(nil)
	end
end

local function stopAllSpecialTracks()
	local removeList = {}
	for sourceTrack in pairs(specialTracks) do
		table.insert(removeList, sourceTrack)
	end
	for _, sourceTrack in ipairs(removeList) do
		removeSpecialTrack(sourceTrack)
	end
end

local function shutdown()
	if dead then
		return
	end
	dead = true
	disconnectFigureConnections()
	disconnectList(globalConnections)
	stopAllSpecialTracks()
	stopGraph()
	destroySmoothFollow()
	if soundController then
		soundController:Destroy()
		soundController = nil
	end
	if figure1 then
		pcall(function()
			figure1:Destroy()
		end)
		figure1 = nil
	end
	originalFigure = nil
	sourceAnimator = nil
	targetAnimator = nil
	sourceFollowPart = nil
	targetFollowPart = nil
	lastPosition = nil
	movementSpeed = 0
	movementSampleTimer = 0
	graphSourceTrack = nil
	graphTargetTrack = nil
	table.clear(graphParameters)
	table.clear(graphDefaults)
	table.clear(specialTracks)
end

local function loadReplacement()
	local success, objects = pcall(function()
		return game:GetObjects(FIGURE_ASSET_ID)
	end)
	if not success or not objects or not objects[1] then
		return nil
	end
	local model = objects[1]
	for i = 2, #objects do
		pcall(function()
			objects[i]:Destroy()
		end)
	end
	return model
end

bindFigure = function(figureRig)
	if dead or originalFigure then
		return
	end
	originalFigure = figureRig
	sourceAnimator = findAnimator(figureRig)
	if not sourceAnimator then
		shutdown()
		return
	end
	figure1 = loadReplacement()
	if not figure1 then
		shutdown()
		return
	end
	figure1.Name = "Figure1"
	figure1.Parent = workspace
	targetAnimator = getTargetAnimator(figure1)
	if not targetAnimator then
		shutdown()
		return
	end
	hideOriginal(figureRig)
	muteOriginal(figureRig)
	local initialPivot = getObjectPivot(figureRig)
	if initialPivot then
		figure1:PivotTo(initialPivot)
	end
	if not setupSmoothFollow(figureRig, figure1) then
		warn("[Figure1] 无法找到原 Figure 或 Figure1 的根部 BasePart，平滑跟随初始化失败。")
		shutdown()
		return
	end
	disconnectList(globalConnections)
	lastPosition = sourceFollowPart.Position
	soundController = SoundController.new(figure1)
	for _, track in ipairs(targetAnimator:GetPlayingAnimationTracks()) do
		pcall(function()
			track:Stop(0)
		end)
	end
	local success, tracks = pcall(function()
		return sourceAnimator:GetPlayingAnimationTracks()
	end)
	if success then
		for _, track in ipairs(tracks) do
			inspectTrack(track)
		end
	end
	connectFigure(sourceAnimator.AnimationPlayed, function(track)
		inspectTrack(track)
	end)
	connectFigure(figureRig.Destroying, shutdown)
	connectFigure(figureRig.AncestryChanged, function()
		if not figureRig:IsDescendantOf(workspace) then
			shutdown()
		end
	end)
	connectFigure(RunService.PreAnimation, function()
		if dead then
			return
		end
		syncGraph()
		syncSpecialTracks()
	end)
	connectFigure(RunService.Heartbeat, function(dt)
		if dead then
			return
		end
		if not originalFigure or not originalFigure.Parent then
			shutdown()
			return
		end
		if not figure1 or not figure1.Parent or not sourceFollowPart or not sourceFollowPart.Parent then
			shutdown()
			return
		end
		movementSampleTimer += dt
		if movementSampleTimer >= MOVEMENT_SAMPLE_INTERVAL then
			local position = sourceFollowPart.Position
			if lastPosition then
				movementSpeed = (position - lastPosition).Magnitude / movementSampleTimer
			end
			lastPosition = position
			movementSampleTimer = 0
		end
		updateSoundMode()
		if soundController then
			soundController:Step(dt)
		end
	end)
end

findExistingFigure = function()
	for _, object in ipairs(currentRooms:GetDescendants()) do
		if object.Name == "FigureRig" and (object:IsA("Model") or object:IsA("Folder")) then
			return object
		end
	end
	return nil
end

currentRooms = workspace:WaitForChild("CurrentRooms")

connectGlobal(currentRooms.DescendantAdded, function(object)
	if dead or originalFigure then
		return
	end
	if object.Name ~= "FigureRig" then
		return
	end
	if not object:IsA("Model") and not object:IsA("Folder") then
		return
	end
	bindFigure(object)
end)

local existingFigure = findExistingFigure()
if existingFigure then
	bindFigure(existingFigure)
end
end
-------
function entityBehaviors.GodOFOne()
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
task.wait(1)
require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("What this?",true)
task.wait(1)
require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).remind("???", true)
wait(1)
local Lighting = game:GetService("Lighting")
local Sky = Lighting:FindFirstChildOfClass("Sky") or Instance.new("Sky", Lighting)

Sky.SkyboxBk = "rbxassetid://15983968922"
Sky.SkyboxDn = "rbxassetid://15983966825"
Sky.SkyboxFt = "rbxassetid://15983965025"
Sky.SkyboxLf = "rbxassetid://15983967420"
Sky.SkyboxRt = "rbxassetid://15983966246"
Sky.SkyboxUp = "rbxassetid://15983964246"
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
		HeightOffset = 10},Lights = {Flicker = {Enabled = true,Duration = 10},Shatter = false,Repair = false},Earthquake = {Enabled = false},CameraShake = {Enabled = true,Range = 1500,Values = {0.5, 20, 0.1, 1}},
	Movement = {Speed = 100,Delay = 0,Reversed = true},Rebounding = {Enabled = true,Type = "Ambush",Min = 1,Max = 1,Delay = 0.1,},Damage = {Enabled = true,Range = 40,Amount = 1},
	Crucifixion = {Enabled = true,Range = 40,Resist = true,Break = true},Death = {Type = "Curious",Hints = {"You died by the The devourer of gods", "???", "Wait, who is this guy?","I’m not clear about his background, but anyway, you must be careful.","See you..."},Cause = ""},})
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
-----
function entityBehaviors.GodOfTwo()
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
local s = LoadCustomInstance(86700013599003, workspace)
if not s then
    return
end
local entity = s:FindFirstChildWhichIsA("BasePart")
entity.CFrame = GetRoom():WaitForChild("RoomEntrance").CFrame * CFrame.new(1, 0, 1)
end

function entityBehaviors.GodOFThree()
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

local assets = {
    "104227777289979",
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

function entityBehaviors.GodOFFour()
local entity = spawner.Create({
	Entity = {
		Name = "The Devourer Of Gods",
		Asset = "74255725774689",
		HeightOffset = 10},Lights = {Flicker = {Enabled = true,Duration = 1},Shatter = true,Repair = false},Earthquake = {Enabled = false},
	    CameraShake = {Enabled = true,Range = 1500,Values = {0.5, 20, 0.1, 1}},Movement = {Speed = 500,Delay = 0,Reversed = false},Rebounding = {Enabled = false,Type = "Blitz",Min = 1,Max = math.random(1, 2),Delay = math.random(10, 30) / 10},
	    Damage = {Enabled = true,Range = 200,Amount = 200},Crucifixion = {Enabled = true,Range = 40,Resist = true,Break = true},Death = {Type = "Curious",Hints = {"You died by the The devourer of gods", "???", "Wait, who is this guy?","I’m not clear about his background, but anyway, you must be careful.","See you..."},Cause = ""},})
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

local Z367_MUSIC_URL = "https://github.com/Zero0Star/RipperNewSound/blob/master/Z367Music.mp3?raw=true"
local Z367_MUSIC_FILENAME = "Z367Music_V36"
local Z367_MUSIC_SOUND_NAME = "Z367Music_Preloaded"
local Z367_MUSIC_VOLUME = 4.4

local function preloadZ367Music()
    local sound = workspace:FindFirstChild(Z367_MUSIC_SOUND_NAME)

    if sound and not sound:IsA("Sound") then
        sound:Destroy()
        sound = nil
    end

    if not sound then
        sound = Instance.new("Sound")
        sound.Name = Z367_MUSIC_SOUND_NAME
        sound.Looped = false
        sound.Parent = workspace
    end

    sound.Volume = Z367_MUSIC_VOLUME
    sound.Looped = false

    -- Never autoplay during preload.
    pcall(function()
        sound:Stop()
        sound.TimePosition = 0
    end)

    local ok, err = pcall(function()
        if type(writefile) ~= "function" or type(game.HttpGet) ~= "function" then
            error("executor file/http functions unavailable")
        end

        local path = Z367_MUSIC_FILENAME .. ".mp3"
        writefile(path, game:HttpGet(Z367_MUSIC_URL))

        local getter = getcustomasset or getsynasset
        if not getter then
            error("getcustomasset/getsynasset unavailable")
        end

        sound.SoundId = getter(path)

        -- Decode/cache the custom asset now so the first encounter does not
        -- wait for the sound to become ready after a target is already locked.
        pcall(function()
            game:GetService("ContentProvider"):PreloadAsync({sound})
        end)
    end)

    if not ok then
        warn("[Z-367] Music preload failed:", err)
    end

    return sound
end

local Z367_PRELOADED_MUSIC = preloadZ367Music()

function entityBehaviors.Z367Game()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local camera = workspace.CurrentCamera

--// Configuration
local CONFIG = {
    Duration = 42,
    MaxPressure = 5,

    -- Mouse physics
    MouseSensitivity = 0.00205,
    Friction = 0.875,
    MaxSpeed = 0.027,
    CenterRadius = 0.105,
    OuterLimit = 0.445,
    Spring = 0.00082,

    -- Pressure
    RecoveryRate = 1.45,
    BaseDrainRate = 0.48,
    DistanceDrain = 1.55,

    -- Phase thresholds: 0-25 / 25-50 / 50-75 / 75-100%
    Phase = {
        [1] = {
            MinEventDelay = 4.0,
            MaxEventDelay = 6.2,
            ImpactForce = 0.105, -- stronger than old early phase
            ShakeMagnitude = 18,
            ShakeRoughness = 120,
            ShakeFadeIn = 0.06,
            ShakeFadeOut = 0.28,
            ShakePosInfluence = 1.45,
            ShakeRotInfluence = 0.32,
            DrainMultiplier = 1.00,
            InputMultiplier = 1.00,
        },
        [2] = {
            MinEventDelay = 3.1,
            MaxEventDelay = 5.0,
            ImpactForce = 0.135,
            ShakeMagnitude = 22,
            ShakeRoughness = 145,
            ShakeFadeIn = 0.06,
            ShakeFadeOut = 0.30,
            ShakePosInfluence = 1.70,
            ShakeRotInfluence = 0.40,
            DrainMultiplier = 1.06,
            InputMultiplier = 0.98,
        },
        [3] = {
            MinEventDelay = 2.35,
            MaxEventDelay = 4.0,
            ImpactForce = 0.165,
            ShakeMagnitude = 26,
            ShakeRoughness = 170,
            ShakeFadeIn = 0.07,
            ShakeFadeOut = 0.34,
            ShakePosInfluence = 1.90,
            ShakeRotInfluence = 0.48,
            DrainMultiplier = 1.12,
            InputMultiplier = 0.96,
        },

        -- V3.1: Phase 4 is only a little easier, not trivial.
        [4] = {
            MinEventDelay = 2.75, -- V3.2 easier final phase
            MaxEventDelay = 4.45,
            ImpactForce = 0.150,  -- easier to recover from
            ShakeMagnitude = 30,
            ShakeRoughness = 200,
            ShakeFadeIn = 0.10,
            ShakeFadeOut = 0.22,
            ShakePosInfluence = 2.00,
            ShakeRotInfluence = 0.50,
            DrainMultiplier = 1.07,
            InputMultiplier = 0.95,
        },
    },

    -- Optional executor music.
    MusicUrl = Z367_MUSIC_URL,
    MusicFilename = Z367_MUSIC_FILENAME,

    -- Roblox asset fallbacks. Replace with your own if desired.
    ImpactSoundId = "",
    WarningSoundId = "",
    HeartbeatSoundId = "",
}

--// Runtime state
local state = {
    active = false,
    dead = false,
    ending = false,
    pressure = CONFIG.MaxPressure,
    remaining = CONFIG.Duration,
    progress = 0,
    phase = 1,
    ballPos = Vector2.new(0.5, 0.5),
    ballVelocity = Vector2.zero,
    inverted = false,
    blackout = false,
    distortion = 0,
    nextEventAt = 0,
    connections = {},
    tweens = {},
    music = nil,
    heartbeat = nil,
    oldMouseBehavior = UserInputService.MouseBehavior,
    oldMouseIcon = UserInputService.MouseIconEnabled,
}

--// Utilities
local function clamp01(x)
    return math.clamp(x, 0, 1)
end

local function randomUnit2()
    local a = math.random() * math.pi * 2
    return Vector2.new(math.cos(a), math.sin(a))
end

local function tween(obj, info, props)
    if not obj or not obj.Parent then return nil end
    local t = TweenService:Create(obj, info, props)
    table.insert(state.tweens, t)
    t:Play()
    return t
end

local function safeDestroy(x)
    if x and x.Parent then
        x:Destroy()
    end
end

local function new(className, props, parent)
    local obj = Instance.new(className)
    for k, v in pairs(props or {}) do
        obj[k] = v
    end
    obj.Parent = parent
    return obj
end

local function corner(parent, radius)
    return new("UICorner", {CornerRadius = UDim.new(0, radius or 8)}, parent)
end

local function stroke(parent, color, thickness, transparency)
    return new("UIStroke", {
        Color = color or Color3.fromRGB(255,255,255),
        Thickness = thickness or 1,
        Transparency = transparency or 0,
    }, parent)
end

--// Z-367 music is preloaded outside entityBehaviors.Z367Game().
-- The game body only starts/stops the persistent workspace Sound.

local function playOneShot(soundId, volume, speed)
    if not soundId or soundId == "" then return end
    local s = new("Sound", {
        SoundId = soundId,
        Volume = volume or 1,
        PlaybackSpeed = speed or 1,
    }, workspace)
    s:Play()
    Debris:AddItem(s, 5)
end

--// CameraShaker integration
-- Every major Z-367 impact routes through this function.
local function runCameraShake(magnitude, roughness, fadeIn, fadeOut, posInfluence, rotInfluence)
    local cameraShakerModule = ReplicatedStorage:FindFirstChild("CameraShaker")
    if not cameraShakerModule then
        return false
    end

    local ok = pcall(function()
        local CameraShaker = require(cameraShakerModule)
        local currentCamera = workspace.CurrentCamera

        local camShake = CameraShaker.new(
            Enum.RenderPriority.Camera.Value,
            function(shakeCf)
                currentCamera = workspace.CurrentCamera
                if currentCamera then
                    currentCamera.CFrame = currentCamera.CFrame * shakeCf
                end
            end
        )

        camShake:Start()
        camShake:ShakeOnce(
            magnitude or 30,
            roughness or 200,
            fadeIn or 0.1,
            fadeOut or 0.2,
            posInfluence or 2,
            rotInfluence or 0.5
        )

        task.delay((fadeIn or 0.1) + (fadeOut or 0.2) + 0.35, function()
            pcall(function()
                camShake:Stop()
            end)
        end)
    end)

    return ok
end

-- Short strong shake used by win/death sequences.
local function runFinalCameraShake()
    return runCameraShake(30, 200, 0.1, 0.2, 2, 0.5)
end

-- Fallback visual shake if CameraShaker isn't present.
local fallbackShake = {
    power = 0,
    endAt = 0,
}

local function requestFallbackShake(power, duration)
    fallbackShake.power = math.max(fallbackShake.power, power or 0)
    fallbackShake.endAt = math.max(fallbackShake.endAt, os.clock() + (duration or 0.25))
end

-- Full-minigame low-frequency camera motion.
-- This is an independent shaker that stays active for the WHOLE game.
-- The strong hit at 6 seconds is a separate effect and does not replace it.
local gameCameraShaker = nil

local function stopGameCameraShake()
    if gameCameraShaker then
        pcall(function()
            gameCameraShaker:Stop()
        end)
        gameCameraShaker = nil
    end
end

local function runGameCameraShake()
    stopGameCameraShake()

    local cameraShakerModule = ReplicatedStorage:FindFirstChild("CameraShaker")
    if not cameraShakerModule then
        -- Very small full-duration fallback if CameraShaker is unavailable.
        requestFallbackShake(0.004, CONFIG.Duration)
        return false
    end

    local ok = pcall(function()
        local CameraShaker = require(cameraShakerModule)

        gameCameraShaker = CameraShaker.new(
            Enum.RenderPriority.Camera.Value,
            function(shakeCf)
                local currentCamera = workspace.CurrentCamera
                if currentCamera and state.active then
                    currentCamera.CFrame = currentCamera.CFrame * shakeCf
                end
            end
        )

        gameCameraShaker:Start()

        -- User-requested full-game subtle shake.
        gameCameraShaker:ShakeOnce(
            10,
            10,
            0.1,
            CONFIG.Duration,
            2,
            0.5
        )
    end)

    if not ok then
        gameCameraShaker = nil
        requestFallbackShake(0.004, CONFIG.Duration)
        return false
    end

    return true
end

local function shakeForPhase(multiplier)
    if _G.Z367PlayModelBang then
        pcall(_G.Z367PlayModelBang)
    end
    local p = CONFIG.Phase[state.phase]
    multiplier = multiplier or 1

    local worked = runCameraShake(
        p.ShakeMagnitude * multiplier,
        p.ShakeRoughness,
        p.ShakeFadeIn,
        p.ShakeFadeOut,
        p.ShakePosInfluence,
        p.ShakeRotInfluence
    )

    if not worked then
        requestFallbackShake(0.010 * p.ShakeMagnitude / 18 * multiplier, p.ShakeFadeOut + 0.15)
    end
end

--// UI
local function buildUI()
    local old = playerGui:FindFirstChild("Z367_V31")
    if old then old:Destroy() end

    local gui = new("ScreenGui", {
        Name = "Z367_V31",
        IgnoreGuiInset = true,
        ResetOnSpawn = false,
        DisplayOrder = 999,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    }, playerGui)

    local root = new("Frame", {
        Name = "Root",
        Size = UDim2.fromScale(1,1),
        BackgroundColor3 = Color3.fromRGB(5,5,7),
        BackgroundTransparency = 0.46,
        BorderSizePixel = 0,
        ZIndex = 1,
    }, gui)

    -- Full-screen opening fade.
    -- IMPORTANT: keep it hidden until the minigame actually starts.
    -- The old version spawned this fully opaque during script initialization,
    -- which caused a permanent black screen while Z-367 was still chasing.
    local introFade = new("Frame", {
        Name = "GameFade",
        Size = UDim2.fromScale(1,1),
        BackgroundColor3 = Color3.new(0,0,0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Visible = false,
        Active = false,
        ZIndex = 1000,
    }, gui)

    local flash = new("Frame", {
        Name = "ImpactFlash",
        Size = UDim2.fromScale(1,1),
        BackgroundColor3 = Color3.fromRGB(255,245,245),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 800,
    }, gui)

    local redPulse = new("Frame", {
        Name = "DangerPulse",
        Size = UDim2.fromScale(1,1),
        BackgroundColor3 = Color3.fromRGB(170,0,0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 20,
    }, gui)

    -- Vignette using four gradients so no external image is required.
    local vignetteTop = new("Frame", {
        Size = UDim2.new(1,0,0.24,0),
        BackgroundColor3 = Color3.new(0,0,0),
        BackgroundTransparency = 0.25,
        BorderSizePixel = 0,
        ZIndex = 10,
    }, gui)
    local gt = new("UIGradient", {Rotation = 90}, vignetteTop)
    gt.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0,0),
        NumberSequenceKeypoint.new(1,1),
    })

    local vignetteBottom = vignetteTop:Clone()
    vignetteBottom.Position = UDim2.new(0,0,0.76,0)
    vignetteBottom.Parent = gui
    vignetteBottom.UIGradient.Rotation = -90

    local vignetteLeft = new("Frame", {
        Size = UDim2.new(0.18,0,1,0),
        BackgroundColor3 = Color3.new(0,0,0),
        BackgroundTransparency = 0.28,
        BorderSizePixel = 0,
        ZIndex = 10,
    }, gui)
    local gl = new("UIGradient", {Rotation = 0}, vignetteLeft)
    gl.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0,0),
        NumberSequenceKeypoint.new(1,1),
    })

    local vignetteRight = vignetteLeft:Clone()
    vignetteRight.Position = UDim2.new(0.82,0,0,0)
    vignetteRight.Parent = gui
    vignetteRight.UIGradient.Rotation = 180

    -- Scanlines
    local scanHolder = new("Frame", {
        Name = "Scanlines",
        Size = UDim2.fromScale(1,1),
        BackgroundTransparency = 1,
        ZIndex = 15,
    }, gui)

    for y = 0, 1, 0.018 do
        new("Frame", {
            Size = UDim2.new(1,0,0,1),
            Position = UDim2.new(0,0,y,0),
            BackgroundColor3 = Color3.fromRGB(255,255,255),
            BackgroundTransparency = 0.965,
            BorderSizePixel = 0,
            ZIndex = 15,
        }, scanHolder)
    end

    local title = new("TextLabel", {
        Name = "Title",
        AnchorPoint = Vector2.new(0.5,0),
        Position = UDim2.new(0.5,0,0.055,0),
        Size = UDim2.new(0.7,0,0,34),
        BackgroundTransparency = 1,
        Text = "Z-367 // CONTAINMENT INTERFACE",
        TextColor3 = Color3.fromRGB(218,218,218),
        TextTransparency = 1,
        Font = Enum.Font.Code,
        TextSize = 21,
        TextStrokeTransparency = 0.7,
        ZIndex = 30,
    }, gui)

    local subtitle = new("TextLabel", {
        AnchorPoint = Vector2.new(0.5,0),
        Position = UDim2.new(0.5,0,0.095,0),
        Size = UDim2.new(0.7,0,0,24),
        BackgroundTransparency = 1,
        Text = "MAINTAIN SIGNAL STABILITY",
        TextColor3 = Color3.fromRGB(145,145,150),
        TextTransparency = 1,
        Font = Enum.Font.Code,
        TextSize = 14,
        ZIndex = 30,
    }, gui)

    local arena = new("Frame", {
        Name = "Arena",
        AnchorPoint = Vector2.new(0.5,0.5),
        Position = UDim2.fromScale(0.5,0.52),
        Size = UDim2.fromOffset(410,410),
        BackgroundColor3 = Color3.fromRGB(12,12,15),
        BackgroundTransparency = 0.36,
        BorderSizePixel = 0,
        ZIndex = 30,
    }, gui)
    corner(arena, 205)
    local arenaStroke = stroke(arena, Color3.fromRGB(115,115,125), 2, 0.34)

    local ring2 = new("Frame", {
        AnchorPoint = Vector2.new(0.5,0.5),
        Position = UDim2.fromScale(0.5,0.5),
        Size = UDim2.fromOffset(270,270),
        BackgroundTransparency = 1,
        ZIndex = 31,
    }, arena)
    corner(ring2, 135)
    stroke(ring2, Color3.fromRGB(80,80,90), 1, 0.48)

    local safeZone = new("Frame", {
        Name = "SafeZone",
        AnchorPoint = Vector2.new(0.5,0.5),
        Position = UDim2.fromScale(0.5,0.5),
        Size = UDim2.fromOffset(88,88),
        BackgroundColor3 = Color3.fromRGB(185,185,190),
        BackgroundTransparency = 0.94,
        BorderSizePixel = 0,
        ZIndex = 33,
    }, arena)
    corner(safeZone, 44)
    local safeStroke = stroke(safeZone, Color3.fromRGB(200,200,205), 2, 0.18)

    local centerDot = new("Frame", {
        AnchorPoint = Vector2.new(0.5,0.5),
        Position = UDim2.fromScale(0.5,0.5),
        Size = UDim2.fromOffset(6,6),
        BackgroundColor3 = Color3.fromRGB(235,235,240),
        BorderSizePixel = 0,
        ZIndex = 36,
    }, arena)
    corner(centerDot, 6)

    local ballGlow = new("Frame", {
        AnchorPoint = Vector2.new(0.5,0.5),
        Position = UDim2.fromScale(0.5,0.5),
        Size = UDim2.fromOffset(42,42),
        BackgroundColor3 = Color3.fromRGB(220,220,230),
        BackgroundTransparency = 0.84,
        BorderSizePixel = 0,
        ZIndex = 34,
    }, arena)
    corner(ballGlow, 21)

    local ball = new("Frame", {
        Name = "ControlBall",
        AnchorPoint = Vector2.new(0.5,0.5),
        Position = UDim2.fromScale(0.5,0.5),
        Size = UDim2.fromOffset(19,19),
        BackgroundColor3 = Color3.fromRGB(225,225,232),
        BorderSizePixel = 0,
        ZIndex = 35,
    }, arena)
    corner(ball, 10)
    stroke(ball, Color3.fromRGB(255,255,255), 1, 0.4)

    local pressurePanel = new("Frame", {
        AnchorPoint = Vector2.new(0.5,1),
        Position = UDim2.new(0.5,0,0.92,0),
        Size = UDim2.fromOffset(520,62),
        BackgroundColor3 = Color3.fromRGB(8,8,10),
        BackgroundTransparency = 0.25,
        BorderSizePixel = 0,
        ZIndex = 30,
    }, gui)
    corner(pressurePanel, 6)
    stroke(pressurePanel, Color3.fromRGB(75,75,82), 1, 0.3)

    local pressureLabel = new("TextLabel", {
        Position = UDim2.fromOffset(12,6),
        Size = UDim2.new(1,-24,0,18),
        BackgroundTransparency = 1,
        Text = "SIGNAL PRESSURE",
        TextXAlignment = Enum.TextXAlignment.Left,
        TextColor3 = Color3.fromRGB(170,170,175),
        Font = Enum.Font.Code,
        TextSize = 13,
        ZIndex = 32,
    }, pressurePanel)

    local pressureBack = new("Frame", {
        Position = UDim2.fromOffset(12,31),
        Size = UDim2.new(1,-24,0,17),
        BackgroundColor3 = Color3.fromRGB(30,30,34),
        BorderSizePixel = 0,
        ZIndex = 32,
    }, pressurePanel)
    corner(pressureBack, 3)

    local pressureFill = new("Frame", {
        Name = "PressureFill",
        Size = UDim2.fromScale(1,1),
        BackgroundColor3 = Color3.fromRGB(195,195,200),
        BorderSizePixel = 0,
        ZIndex = 33,
    }, pressureBack)
    corner(pressureFill, 3)

    local timer = new("TextLabel", {
        AnchorPoint = Vector2.new(0.5,0),
        Position = UDim2.new(0.5,0,0.135,0),
        Size = UDim2.fromOffset(180,48),
        BackgroundTransparency = 1,
        Text = "01:01",
        TextColor3 = Color3.fromRGB(225,225,230),
        TextTransparency = 1,
        Font = Enum.Font.Code,
        TextSize = 34,
        TextStrokeTransparency = 0.72,
        ZIndex = 30,
    }, gui)

    local phaseText = new("TextLabel", {
        AnchorPoint = Vector2.new(0,0),
        Position = UDim2.new(0.025,0,0.04,0),
        Size = UDim2.fromOffset(240,30),
        BackgroundTransparency = 1,
        Text = "PHASE // 01",
        TextColor3 = Color3.fromRGB(135,135,145),
        TextTransparency = 1,
        TextXAlignment = Enum.TextXAlignment.Left,
        Font = Enum.Font.Code,
        TextSize = 15,
        ZIndex = 30,
    }, gui)

    local warning = new("TextLabel", {
        AnchorPoint = Vector2.new(0.5,0.5),
        Position = UDim2.fromScale(0.5,0.29),
        Size = UDim2.new(0.8,0,0,52),
        BackgroundTransparency = 1,
        Text = "",
        TextColor3 = Color3.fromRGB(255,75,75),
        TextTransparency = 1,
        TextStrokeTransparency = 0.35,
        Font = Enum.Font.Code,
        TextSize = 25,
        ZIndex = 120,
    }, gui)

    local glitchHolder = new("Frame", {
        Name = "GlitchHolder",
        Size = UDim2.fromScale(1,1),
        BackgroundTransparency = 1,
        ZIndex = 150,
    }, gui)

    local blur = Lighting:FindFirstChild("Z367_V31_Blur")
    if blur then blur:Destroy() end
    blur = new("BlurEffect", {Name="Z367_V31_Blur", Size=0}, Lighting)

    local color = Lighting:FindFirstChild("Z367_V31_Color")
    if color then color:Destroy() end
    color = new("ColorCorrectionEffect", {
        Name = "Z367_V31_Color",
        Brightness = -0.02,
        Contrast = 0.05,
        Saturation = -0.08,
        TintColor = Color3.fromRGB(240,240,246),
    }, Lighting)

    return {
        Gui = gui,
        Root = root,
        IntroFade = introFade,
        Flash = flash,
        RedPulse = redPulse,
        Title = title,
        Subtitle = subtitle,
        Arena = arena,
        ArenaStroke = arenaStroke,
        SafeZone = safeZone,
        SafeStroke = safeStroke,
        Ball = ball,
        BallGlow = ballGlow,
        PressureFill = pressureFill,
        PressureLabel = pressureLabel,
        Timer = timer,
        PhaseText = phaseText,
        Warning = warning,
        GlitchHolder = glitchHolder,
        Blur = blur,
        Color = color,
    }
end

-- Do not create the minigame UI during script initialization.
-- It is created only when startGame() is actually called for the locked player.
local ui = nil

--// Full game fade-in
local function runGameFadeIn()
    -- Only cover the screen once the minigame has REALLY started.
    ui.IntroFade.Visible = true
    ui.IntroFade.Active = false
    ui.IntroFade.BackgroundTransparency = 0
    ui.Title.TextTransparency = 1
    ui.Subtitle.TextTransparency = 1
    ui.Timer.TextTransparency = 1
    ui.PhaseText.TextTransparency = 1

    -- Short black hold makes the transition feel deliberate.
    task.wait(0.35)

    tween(
        ui.IntroFade,
        TweenInfo.new(1.65, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        {BackgroundTransparency = 1}
    )

    task.delay(0.22, function()
        tween(ui.Title, TweenInfo.new(0.65, Enum.EasingStyle.Quad), {TextTransparency = 0})
        tween(ui.Timer, TweenInfo.new(0.75, Enum.EasingStyle.Quad), {TextTransparency = 0})
    end)

    task.delay(0.46, function()
        tween(ui.Subtitle, TweenInfo.new(0.65, Enum.EasingStyle.Quad), {TextTransparency = 0})
        tween(ui.PhaseText, TweenInfo.new(0.65, Enum.EasingStyle.Quad), {TextTransparency = 0})
    end)

    -- Fail-safe: GameFade must never be allowed to remain over the game.
    task.delay(1.8, function()
        if ui.IntroFade and ui.IntroFade.Parent then
            ui.IntroFade.BackgroundTransparency = 1
            ui.IntroFade.Visible = false
            ui.IntroFade.Active = false
        end
    end)
end

--// UI effects
local function setWarning(text, duration, strong)
    if not state.active or state.ending then return end
    ui.Warning.Text = text
    ui.Warning.TextTransparency = 1
    ui.Warning.Position = UDim2.fromScale(0.5,0.29)

    tween(ui.Warning, TweenInfo.new(0.10, Enum.EasingStyle.Linear), {
        TextTransparency = 0,
        Position = UDim2.fromScale(0.5,0.285),
    })

    if strong then
        ui.Warning.TextSize = 29
    else
        ui.Warning.TextSize = 24
    end

    task.delay(duration or 0.65, function()
        if ui.Warning and ui.Warning.Parent then
            tween(ui.Warning, TweenInfo.new(0.24), {TextTransparency = 1})
        end
    end)
end

local function flashScreen(color, peakTransparency, inTime, outTime)
    ui.Flash.BackgroundColor3 = color or Color3.new(1,1,1)
    ui.Flash.BackgroundTransparency = 1

    tween(ui.Flash, TweenInfo.new(inTime or 0.035), {
        BackgroundTransparency = peakTransparency or 0.18
    })

    task.delay(inTime or 0.035, function()
        tween(ui.Flash, TweenInfo.new(outTime or 0.30, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        })
    end)
end

local function pulseDanger(amount)
    amount = clamp01(amount or 0.5)
    ui.RedPulse.BackgroundTransparency = 1
    tween(ui.RedPulse, TweenInfo.new(0.07), {
        BackgroundTransparency = 0.92 - amount * 0.34
    })
    task.delay(0.08, function()
        tween(ui.RedPulse, TweenInfo.new(0.45), {BackgroundTransparency = 1})
    end)
end

local function impactBlur(size)
    ui.Blur.Size = 0
    tween(ui.Blur, TweenInfo.new(0.055), {Size = size or 17})
    task.delay(0.07, function()
        tween(ui.Blur, TweenInfo.new(0.42, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = 0})
    end)
end

local function spawnGlitchSlice(intensity)
    if not ui.GlitchHolder or not ui.GlitchHolder.Parent then return end
    intensity = intensity or 1

    local h = math.random(2, math.max(3, math.floor(12 * intensity)))
    local y = math.random(5,95) / 100
    local offset = math.random(-22,22) * intensity

    local slice = new("Frame", {
        Position = UDim2.new(0,offset,y,0),
        Size = UDim2.new(1,0,0,h),
        BackgroundColor3 = (math.random() > 0.5)
            and Color3.fromRGB(220,225,235)
            or Color3.fromRGB(140,0,20),
        BackgroundTransparency = 0.70 + math.random() * 0.20,
        BorderSizePixel = 0,
        ZIndex = 151,
    }, ui.GlitchHolder)

    Debris:AddItem(slice, math.random(3,10)/100)
end

local function glitchBurst(intensity, duration)
    intensity = intensity or 1
    duration = duration or 0.3

    task.spawn(function()
        local finish = os.clock() + duration
        while state.active and os.clock() < finish do
            for _ = 1, math.max(1, math.floor(2 * intensity)) do
                spawnGlitchSlice(intensity)
            end

            local x = math.random(-5,5) * intensity
            local y = math.random(-3,3) * intensity
            ui.Arena.Position = UDim2.new(0.5,x,0.52,y)
            ui.Title.Position = UDim2.new(0.5,-x,0.055,0)

            task.wait(math.random(2,6)/100)
        end

        if ui.Arena and ui.Arena.Parent then
            ui.Arena.Position = UDim2.fromScale(0.5,0.52)
        end
        if ui.Title and ui.Title.Parent then
            ui.Title.Position = UDim2.new(0.5,0,0.055,0)
        end
    end)
end

--// Impact/event helpers
local function addForce(force, multiplier)
    state.ballVelocity += force * (multiplier or 1)
end

local function doImpact(strengthMultiplier, warningText)
    if not state.active or state.ending then return end

    local p = CONFIG.Phase[state.phase]
    strengthMultiplier = strengthMultiplier or 1

    setWarning(warningText or ">> IMPACT DETECTED <<", 0.45, true)
    playOneShot(CONFIG.WarningSoundId, 1.2, 1)

    -- Tiny telegraph.
    task.wait(math.max(0.10, 0.22 - state.phase * 0.025))

    local direction = randomUnit2()
    addForce(direction * p.ImpactForce * strengthMultiplier)

    -- V3.1: EVERY impact gets screen/camera shake.
    shakeForPhase(strengthMultiplier)

    flashScreen(Color3.fromRGB(255,245,245), 0.12, 0.025, 0.32)
    pulseDanger(0.55 + state.phase * 0.08)
    impactBlur(13 + state.phase * 3)
    glitchBurst(0.65 + state.phase * 0.12, 0.18 + state.phase * 0.035)
    playOneShot(CONFIG.ImpactSoundId, 1.8, 0.92 + math.random() * 0.12)
end

local function doDoubleImpact()
    if not state.active then return end
    setWarning("MULTIPLE CONTACTS", 0.55, true)
    doImpact(0.82, "CONTACT // 01")
    task.wait(0.22)
    if state.active then
        doImpact(0.78, "CONTACT // 02")
    end
end

local function doDistortion()
    if not state.active or state.ending then return end
    setWarning("SIGNAL INVERSION", 0.9, true)

    state.inverted = true
    state.distortion = math.max(state.distortion, 0.85)

    -- Distortion starts with a real camera hit too.
    shakeForPhase(0.58)
    glitchBurst(1.65, 0.8)
    impactBlur(19)
    pulseDanger(0.45)

    local oldTint = ui.Color.TintColor
    ui.Color.TintColor = Color3.fromRGB(205,225,255)
    ui.Color.Contrast = 0.18

    task.delay(state.phase == 4 and 1.45 or 1.7, function()
        state.inverted = false
        if ui.Color and ui.Color.Parent then
            ui.Color.TintColor = oldTint
            ui.Color.Contrast = 0.05
        end
    end)
end

local function doPressureSurge()
    if not state.active or state.ending then return end
    setWarning("PRESSURE SURGE", 0.75, true)

    -- Visual hit and camera shake on surge.
    shakeForPhase(0.72)
    flashScreen(Color3.fromRGB(255,70,70), 0.56, 0.05, 0.50)
    pulseDanger(0.8)
    impactBlur(15)
    glitchBurst(1.1, 0.42)

    -- Phase 4 made slightly less punishing.
    local drain = ({0.20,0.28,0.36,0.36})[state.phase]
    state.pressure = math.max(0, state.pressure - drain)

    addForce(randomUnit2() * CONFIG.Phase[state.phase].ImpactForce * 0.62)
end

local function doBlackout()
    if not state.active or state.ending then return end
    setWarning("VISUAL FEED LOST", 0.5, true)

    -- Entry impact.
    shakeForPhase(0.62)
    glitchBurst(1.35, 0.32)

    state.blackout = true
    tween(ui.Root, TweenInfo.new(0.10), {BackgroundTransparency = 0.02})
    tween(ui.Arena, TweenInfo.new(0.10), {BackgroundTransparency = 0.94})
    tween(ui.Ball, TweenInfo.new(0.10), {BackgroundTransparency = 0.82})
    tween(ui.SafeZone, TweenInfo.new(0.10), {BackgroundTransparency = 1})

    -- Phase 4 blackout shortened.
    local duration = ({0.62,0.78,0.92,0.88})[state.phase]

    task.delay(duration, function()
        if not state.active then return end
        state.blackout = false

        -- Restoration gets a smaller shake so every major visual jolt is felt.
        shakeForPhase(0.32)
        flashScreen(Color3.fromRGB(225,235,255), 0.34, 0.03, 0.28)
        tween(ui.Root, TweenInfo.new(0.22), {BackgroundTransparency = 0.46})
        tween(ui.Arena, TweenInfo.new(0.22), {BackgroundTransparency = 0.36})
        tween(ui.Ball, TweenInfo.new(0.22), {BackgroundTransparency = 0})
        tween(ui.SafeZone, TweenInfo.new(0.22), {BackgroundTransparency = 0.94})
    end)
end

local function doSignalCorruption()
    if not state.active or state.ending then return end
    setWarning("CORRUPTED INPUT", 0.8, false)
    glitchBurst(1.8, 0.65)
    shakeForPhase(0.45)
    impactBlur(11)

    state.distortion = 1
    addForce(randomUnit2() * CONFIG.Phase[state.phase].ImpactForce * 0.48)
end

local EVENT_FUNCTIONS = {
    Impact = function() doImpact(1.00) end,
    HeavyImpact = function() doImpact(1.22, ">> HEAVY IMPACT <<") end,
    DoubleImpact = doDoubleImpact,
    Distortion = doDistortion,
    Surge = doPressureSurge,
    Blackout = doBlackout,
    Corruption = doSignalCorruption,
}

local function chooseEvent()
    local phase = state.phase
    local pool

    if phase == 1 then
        pool = {"Impact","Impact","HeavyImpact","Corruption"}
    elseif phase == 2 then
        pool = {"Impact","HeavyImpact","HeavyImpact","Surge","Corruption","Blackout"}
    elseif phase == 3 then
        pool = {"HeavyImpact","HeavyImpact","DoubleImpact","Surge","Distortion","Blackout","Corruption"}
    else
        -- Phase 4 V3.1: fewer chained/double events, more single heavy impacts.
        pool = {
            "HeavyImpact","HeavyImpact","HeavyImpact",
            "Impact",
            "Surge","Surge",
            "Distortion",
            "Blackout",
            "Corruption",
            "DoubleImpact"
        }
    end

    return pool[math.random(1,#pool)]
end

local function scheduleNextEvent(now)
    local p = CONFIG.Phase[state.phase]
    state.nextEventAt = now + p.MinEventDelay + math.random() * (p.MaxEventDelay - p.MinEventDelay)
end

--// Phase handling
local function calculatePhase(progress)
    if progress < 0.25 then return 1 end
    if progress < 0.50 then return 2 end
    if progress < 0.75 then return 3 end
    return 4
end

local function enterPhase(newPhase)
    if newPhase == state.phase then return end
    state.phase = newPhase
    ui.PhaseText.Text = string.format("PHASE // %02d", newPhase)

    setWarning("PHASE " .. tostring(newPhase) .. " // ESCALATION", 0.9, true)

    -- Phase transition itself gets camera shake.
    shakeForPhase(0.55 + newPhase * 0.08)
    flashScreen(Color3.fromRGB(235,235,245), 0.52, 0.04, 0.42)
    glitchBurst(0.8 + newPhase * 0.18, 0.42)
end

--// Input
local function lockMouse()
    state.oldMouseBehavior = UserInputService.MouseBehavior
    state.oldMouseIcon = UserInputService.MouseIconEnabled
    UserInputService.MouseIconEnabled = false
    UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
end

local function restoreMouse()
    UserInputService.MouseBehavior = state.oldMouseBehavior
    UserInputService.MouseIconEnabled = state.oldMouseIcon
end

local function connectInput()
    table.insert(state.connections, UserInputService.InputChanged:Connect(function(input)
        if not state.active or state.ending then return end
        if input.UserInputType ~= Enum.UserInputType.MouseMovement then return end

        local delta = input.Delta
        local sign = state.inverted and -1 or 1
        local p = CONFIG.Phase[state.phase]

        local d = Vector2.new(delta.X, delta.Y)
        local distortionScale = 1

        if state.distortion > 0 then
            local wobble = Vector2.new(
                math.sin(os.clock()*17),
                math.cos(os.clock()*13)
            ) * state.distortion * 0.18
            d += d * wobble
            distortionScale = 1 - state.distortion * 0.10
        end

        state.ballVelocity += d
            * CONFIG.MouseSensitivity
            * p.InputMultiplier
            * distortionScale
            * sign
    end))
end

--// End sequences
local function disconnectAll()
    for _, c in ipairs(state.connections) do
        pcall(function() c:Disconnect() end)
    end
    table.clear(state.connections)
end

local function cleanup()
    state.active = false

    -- Stop the independent full-game micro shake only when the minigame ends.
    stopGameCameraShake()

    -- Defensive screen release. Even if an end sequence errors later,
    -- this prevents GameFade from trapping the player behind black.
    if ui and ui.IntroFade and ui.IntroFade.Parent then
        ui.IntroFade.BackgroundTransparency = 1
        ui.IntroFade.Visible = false
        ui.IntroFade.Active = false
    end

    disconnectAll()
    restoreMouse()

    for _, t in ipairs(state.tweens) do
        pcall(function() t:Cancel() end)
    end
    table.clear(state.tweens)

    -- Z367_PRELOADED_MUSIC is persistent and must not be destroyed here.
    -- Playback is controlled by the encounter controller/stopAmbient().

    if state.heartbeat then
        pcall(function()
            state.heartbeat:Stop()
            state.heartbeat:Destroy()
        end)
        state.heartbeat = nil
    end

    task.delay(0.2, function()
        safeDestroy(ui.Blur)
        safeDestroy(ui.Color)
    end)
end

local showSurviveEffect

local function surviveSequence()
    if state.ending then return end
    state.ending = true

    setWarning("SIGNAL STABILIZED", 1.3, true)
    runFinalCameraShake()
    flashScreen(Color3.fromRGB(235,245,255), 0.10, 0.06, 0.70)

    tween(ui.Blur, TweenInfo.new(0.7), {Size = 0})
    tween(ui.Root, TweenInfo.new(1.0), {BackgroundTransparency = 0.72})

    task.wait(1.15)

    ui.IntroFade.Visible = true
    ui.IntroFade.BackgroundTransparency = 1
    tween(ui.IntroFade, TweenInfo.new(0.85, Enum.EasingStyle.Quad), {BackgroundTransparency = 0})

    task.wait(0.9)
    cleanup()
    safeDestroy(ui.Gui)

    -- Success removes Z-367 immediately.
    showSurviveEffect()

    if _G.Z367IntegratedResult then
        pcall(_G.Z367IntegratedResult, "win")
    end
end

local killEffectPlayed = false
local isPlayerDead = false

local function showKillEffect()
    if killEffectPlayed then
        return
    end

    killEffectPlayed = true
    isPlayerDead = true

    local playerGui = player:WaitForChild("PlayerGui")
    local oldKillGui = playerGui:FindFirstChild("KillEffect")
    if oldKillGui then
        oldKillGui:Destroy()
    end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "KillEffect"
    screenGui.ResetOnSpawn = false
    screenGui.IgnoreGuiInset = true
    screenGui.DisplayOrder = 10000
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Parent = playerGui

    for _, child in ipairs(screenGui:GetChildren()) do
        child:Destroy()
    end

    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://112123002526111"
    sound.Volume = 4
    sound.Parent = workspace
    sound:Play()
    Debris:AddItem(sound, math.max(sound.TimeLength + 1, 3))

    local image = Instance.new("ImageLabel")
    image.Image = "rbxassetid://99207315574595"
    image.Size = UDim2.new(0, 10, 0, 10)
    image.Position = UDim2.new(0.5, 0, 0.5, 0)
    image.AnchorPoint = Vector2.new(0.5, 0.5)
    image.BackgroundTransparency = 1
    image.ScaleType = Enum.ScaleType.Fit
    image.SizeConstraint = Enum.SizeConstraint.RelativeXY
    image.ZIndex = 2
    image.Parent = screenGui

    TweenService:Create(
        image,
        TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Size = UDim2.new(1.5, 0, 1.5, 0)}
    ):Play()

    task.wait(0.3)

    local time = 0
    local duration = 0.8

    while time < duration and image.Parent do
        local dt = task.wait()
        time += dt

        local shakeX = math.sin(time * 30) * 0.002
        local shakeY = math.cos(time * 28) * 0.002

        image.Position = UDim2.new(0.5 + shakeX, 0, 0.5 + shakeY, 0)
    end

    -- Use the requested Doors/executor kill signal when available.
    -- Fallback to Humanoid.Health = 0 so failure still actually kills the player.
    local signalWorked = pcall(function()
        if type(replicatesignal) ~= "function" then
            error("replicatesignal unavailable")
        end
        replicatesignal(game.Players.LocalPlayer.Kill)
    end)

    if not signalWorked then
        local character = player.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        if humanoid and humanoid.Health > 0 then
            pcall(function()
                humanoid.Health = 0
            end)
        end
    end

    TweenService:Create(
        image,
        TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
        {ImageTransparency = 1}
    ):Play()

    task.wait(0.2)

    if image.Parent then
        image:Destroy()
    end

    task.wait(0.5)

    if screenGui.Parent then
        screenGui:Destroy()
    end
end

showSurviveEffect = function()
    if workspace:FindFirstChild("Z-367") then
        workspace["Z-367"]:Destroy()
    end
end

local function deathSequence()
    if state.ending then return end
    state.ending = true
    state.dead = true

    if ui and ui.Warning then
        ui.Warning.Text = "SIGNAL LOST"
        ui.Warning.TextColor3 = Color3.fromRGB(255,45,45)
        ui.Warning.TextTransparency = 0
    end

    runFinalCameraShake()
    requestFallbackShake(0.035,0.5)
    flashScreen(Color3.fromRGB(255,20,20), 0.08, 0.025, 0.30)
    glitchBurst(2.4, 0.42)
    impactBlur(28)

    task.wait(0.08)

    -- Exact Z-367 kill presentation requested by the user.
    showKillEffect()

    cleanup()
    safeDestroy(ui and ui.Gui)

    -- Only after the player has failed/died is Z-367 released to leave.
    if _G.Z367IntegratedResult then
        pcall(_G.Z367IntegratedResult, "lose")
    end
end

--// Main visual update
local function updatePressureVisual(percent, inCenter)
    percent = clamp01(percent)
    ui.PressureFill.Size = UDim2.new(percent,0,1,0)

    -- White -> amber -> red
    local r, g, b
    if percent > 0.55 then
        local t = (percent - 0.55) / 0.45
        r = 225
        g = math.floor(145 + 80*t)
        b = math.floor(110 + 110*t)
    else
        local t = percent / 0.55
        r = 235
        g = math.floor(45 + 100*t)
        b = math.floor(50 + 60*t)
    end

    ui.PressureFill.BackgroundColor3 = Color3.fromRGB(r,g,b)

    if percent < 0.38 then
        local pulse = (math.sin(os.clock()*8)+1)/2
        ui.RedPulse.BackgroundTransparency = 0.91 + pulse*0.07
        ui.PressureLabel.Text = "SIGNAL PRESSURE // CRITICAL"
        ui.PressureLabel.TextColor3 = Color3.fromRGB(255,85,85)
    elseif percent < 0.62 then
        ui.RedPulse.BackgroundTransparency = 1
        ui.PressureLabel.Text = "SIGNAL PRESSURE // UNSTABLE"
        ui.PressureLabel.TextColor3 = Color3.fromRGB(220,165,120)
    else
        ui.RedPulse.BackgroundTransparency = 1
        ui.PressureLabel.Text = "SIGNAL PRESSURE"
        ui.PressureLabel.TextColor3 = Color3.fromRGB(170,170,175)
    end

    ui.SafeStroke.Color = inCenter
        and Color3.fromRGB(215,225,220)
        or Color3.fromRGB(145,80,80)
end

local function updateTimer()
    local seconds = math.max(0, math.ceil(state.remaining))
    local mins = math.floor(seconds/60)
    local secs = seconds%60
    ui.Timer.Text = string.format("%02d:%02d", mins, secs)
end

-- Timestamp is set by the encounter controller exactly when the
-- preloaded music begins, so the 6-second climax stays synchronized.
local Z367MusicStartedAt = nil

--// Main
local function startGame()
    if state.active or state.ending then return end

    -- Rebuild UI if another cleanup/respawn removed it before the encounter starts.
    if not ui or not ui.Gui or not ui.Gui.Parent then
        ui = buildUI()
    end

    -- Nothing from the minigame exists onscreen before this point.
    ui.Gui.Enabled = true
    if ui.Blur then ui.Blur.Enabled = true end
    if ui.Color then ui.Color.Enabled = true end

    killEffectPlayed = false
    isPlayerDead = false

    state.active = true
    state.dead = false
    state.ending = false
    state.pressure = CONFIG.MaxPressure
    state.remaining = CONFIG.Duration
    state.progress = 0
    state.phase = 1
    state.ballPos = Vector2.new(0.5,0.5)
    state.ballVelocity = Vector2.zero
    state.inverted = false
    state.blackout = false
    state.distortion = 0

    lockMouse()
    connectInput()

    -- Music is NOT created here. It was preloaded when the script loaded
    -- and is started only after Z-367 has locked/approached a player.
    state.music = Z367_PRELOADED_MUSIC

    runGameFadeIn()

    -- Sync the six-second difficulty/climax transition to music playback.
    local gameStartedAt = Z367MusicStartedAt or os.clock()
    local warmupBurstPlayed = false

    -- The full 42-second micro shake is started by the shared encounter
    -- ambience so locked players and spectators begin it at the same moment.

    -- Keep random events out of the first 6 seconds.
    -- Passing +2 here means the first normal event lands roughly at 6-8.2s.
    scheduleNextEvent(gameStartedAt + 2.0)

    local last = gameStartedAt

    table.insert(state.connections, RunService.RenderStepped:Connect(function(dt)
        if not state.active or state.ending then return end

        local now = os.clock()
        dt = math.min(dt, 1/20)

        camera = workspace.CurrentCamera

        -- Fallback shake only when CameraShaker isn't available.
        if fallbackShake.endAt > now and camera then
            local p = fallbackShake.power
            local rx = math.rad((math.random()-0.5) * p * 90)
            local ry = math.rad((math.random()-0.5) * p * 90)
            local rz = math.rad((math.random()-0.5) * p * 50)
            local tx = (math.random()-0.5) * p
            local ty = (math.random()-0.5) * p
            camera.CFrame = camera.CFrame * CFrame.new(tx,ty,0) * CFrame.Angles(rx,ry,rz)
        elseif fallbackShake.endAt <= now then
            fallbackShake.power = 0
        end

        -- Time/phase
        state.remaining -= dt
        state.progress = clamp01(1 - state.remaining / CONFIG.Duration)

        local elapsed = now - gameStartedAt
        local warmup = elapsed < 6

        -- At exactly ~6 seconds, difficulty snaps from the easy opening
        -- into the normal game and gives one pronounced camera hit.
        if not warmupBurstPlayed and elapsed >= 6 then
            warmupBurstPlayed = true

            runCameraShake(
                34,   -- magnitude
                220,  -- roughness
                0.05, -- fade in
                0.62, -- fade out
                2.2,  -- position influence
                0.55  -- rotation influence
            )

            flashScreen(Color3.fromRGB(245,245,255), 0.34, 0.025, 0.32)
            glitchBurst(0.75, 0.20)
        end

        local phase = calculatePhase(state.progress)
        if phase ~= state.phase then
            enterPhase(phase)
            scheduleNextEvent(now + 0.35)
        end

        local phaseCfg = CONFIG.Phase[state.phase]

        -- First six seconds: deliberately very easy and calm.
        -- Afterwards: still less ordinary ball wandering than v3.4 so the
        -- 42-second game stays demanding without becoming exhausting.
        local driftStrength
        local randomStrength

        if warmup then
            driftStrength = 0.000035 + state.phase * 0.000008
            randomStrength = 0.000035
        else
            driftStrength = 0.000125 + state.phase * 0.000034
            randomStrength = 0.000110
        end

        state.ballVelocity += Vector2.new(
            math.sin(now*2.7 + state.phase) * driftStrength,
            math.cos(now*2.2 + state.phase*0.7) * driftStrength
        )

        -- Small random instability.
        state.ballVelocity += Vector2.new(
            (math.random()-0.5) * randomStrength,
            (math.random()-0.5) * randomStrength
        )

        -- Gentle spring toward center so control feels physical rather than impossible.
        local center = Vector2.new(0.5,0.5)
        local towardCenter = center - state.ballPos
        state.ballVelocity += towardCenter * CONFIG.Spring

        state.ballVelocity *= math.pow(CONFIG.Friction, dt*60)

        local maxSpeed = CONFIG.MaxSpeed

        if warmup then
            maxSpeed *= 0.58
        else
            -- Slightly lower ordinary movement ceiling for the shorter 42s game.
            maxSpeed *= 0.92
        end

        if state.phase == 4 then
            -- Preserve the final-phase mercy from the previous version.
            maxSpeed *= 0.94
        end

        if state.ballVelocity.Magnitude > maxSpeed then
            state.ballVelocity = state.ballVelocity.Unit * maxSpeed
        end

        state.ballPos += state.ballVelocity

        -- Circular-ish arena clamp using normalized center distance.
        local offset = state.ballPos - center
        local dist = offset.Magnitude
        if dist > CONFIG.OuterLimit then
            state.ballPos = center + offset.Unit * CONFIG.OuterLimit
            state.ballVelocity = -state.ballVelocity * 0.46

            -- Border impact also shakes the screen.
            shakeForPhase(0.22)
            pulseDanger(0.35)
            glitchBurst(0.38,0.10)
        end

        ui.Ball.Position = UDim2.fromScale(state.ballPos.X,state.ballPos.Y)
        ui.BallGlow.Position = ui.Ball.Position

        local safeDistance = (state.ballPos-center).Magnitude
        local inCenter = safeDistance <= CONFIG.CenterRadius

        if inCenter then
            state.pressure = math.min(
                CONFIG.MaxPressure,
                state.pressure + CONFIG.RecoveryRate * dt
            )
        else
            local outside = math.max(0, safeDistance-CONFIG.CenterRadius)
            local distancePenalty = outside * CONFIG.DistanceDrain

            local drain = (
                CONFIG.BaseDrainRate + distancePenalty
            ) * phaseCfg.DrainMultiplier

            -- Final phase V3.1 extra mercy.
            if state.phase == 4 then
                drain *= 0.92
            end

            state.pressure -= drain * dt
        end

        state.pressure = math.clamp(state.pressure,0,CONFIG.MaxPressure)
        updatePressureVisual(state.pressure/CONFIG.MaxPressure,inCenter)
        updateTimer()

        -- Distortion naturally decays.
        state.distortion = math.max(0,state.distortion-dt*0.65)

        -- Event scheduler
        -- No random attacks during the six-second easy opening.
        if not warmup and now >= state.nextEventAt then
            local eventName = chooseEvent()
            local fn = EVENT_FUNCTIONS[eventName]
            if fn then
                task.spawn(fn)
            end
            scheduleNextEvent(now)
        end

        if state.pressure <= 0 then
            task.spawn(deathSequence)
            return
        end

        if state.remaining <= 0 then
            task.spawn(surviveSequence)
            return
        end

        last = now
    end))
end

--// Safety cleanup if character disappears
table.insert(state.connections, player.CharacterRemoving:Connect(function()
    if state.active then
        cleanup()
        safeDestroy(ui.Gui)
    end
end))

-- Integrated controller calls startGame() only for the selected target.

_G.Z367StartSelectedMinigame = startGame


--========================================================

--========================================================
-- Z-367 Lock Detection
-- Only the player currently locked by Z-367 starts the minigame.
-- Other players only receive music / Bang / camera effects.
--========================================================
local Z367LockedPlayer = nil
local Z367EncounterStarted = false

local function isPlayerAlive(player)
    local char = player and player.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    local root = char and char:FindFirstChild("HumanoidRootPart")

    if hum and hum.Health > 0 and root then
        return true, root
    end

    return false, nil
end

local function getNearestAlivePlayer(position)
    local nearest = nil
    local nearestRoot = nil
    local shortest = math.huge

    for _, plr in ipairs(Players:GetPlayers()) do
        local alive, root = isPlayerAlive(plr)

        if alive and root then
            local distance = (root.Position - position).Magnitude

            if distance < shortest then
                shortest = distance
                nearest = plr
                nearestRoot = root
            end
        end
    end

    return nearest, nearestRoot, shortest
end

local function isThisPlayerLocked()
    -- Use the LocalPlayer captured at the top of this script.
    -- The old code referenced `LocalPlayer` before its later local declaration,
    -- so Lua resolved it as a global (usually nil), preventing the minigame.
    return Z367LockedPlayer == player
end

-- Z-367 TARGET / SPECTATOR CONTROLLER
-- 不创建、不检测、不替换 spawner；直接沿用你原脚本里的生成器环境。
--========================================================

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local ENTITY_SPEED = 70
local ACQUIRE_RANGE = 70
local GAME_TRIGGER_DISTANCE = 3
local HOLD_DISTANCE = 3
local TARGET_LOCKED = false
local SELECTED_PLAYER = nil
local SELECTED_USER_ID = nil
local entityModel = nil
local chaseConnection = nil
local encounterHoldConnection = nil
local selectedPlayerDeathConnection = nil
local departureConnection = nil
local lockedDepartureDirection = nil
local soundManagerConnection = nil
local soundSystemActive = false
local isShakingCamera = false
local chaseStartTime = 0
local BANG_VOLUME = 3.25
local DEPART_SPEED = 90
local DEPART_DISTANCE = 135
local bangSounds = {}
local attackSound = nil
local pandemoniumEyesBeam = nil
local resolved = false

-- Shared encounter generation. Incrementing this cancels delayed observer
-- cleanup from an older encounter without leaving background tasks behind.
local encounterSerial = 0

-- Shared spectator/target camera shaker for the entire 42-second encounter.
local ambientCameraShaker = nil
local CachedCameraShaker = nil

-- Forward declarations because target-death and spectator timeout callbacks
-- need these functions before their bodies appear later in the file.
local removeZ367
local releaseBackToSpawnerPath

local function aliveCharacter(plr)
    if not plr then return nil, nil, nil end
    local char = plr.Character
    if not char then return nil,nil,nil end
    local hum = char:FindFirstChildOfClass("Humanoid")
    local root = char:FindFirstChild("HumanoidRootPart")
    if not hum or hum.Health <= 0 or not root then return nil,nil,nil end
    return char, hum, root
end

local function nearestAlivePlayer(origin)
    local best, bestRoot, bestDistance
    for _, plr in ipairs(Players:GetPlayers()) do
        local _, hum, root = aliveCharacter(plr)
        if hum and root then
            local d = (root.Position-origin).Magnitude
            if (not bestDistance) or d < bestDistance then
                best, bestRoot, bestDistance = plr, root, d
            end
        end
    end
    return best, bestRoot, bestDistance
end

local function setEyes(enabled)
    if pandemoniumEyesBeam and pandemoniumEyesBeam:IsA("Beam") then
        pandemoniumEyesBeam.Enabled = enabled
    end
end

local function findEntityAudio()
    table.clear(bangSounds)
    local zModel = entityModel or Workspace:FindFirstChild("Z-367")
    if not zModel then return false end
    local pandemoniumPart = zModel:FindFirstChild("Pandemonium")
    if not pandemoniumPart then return false end

    pandemoniumEyesBeam = pandemoniumPart:FindFirstChild("PandemoniumEyes")
    setEyes(false)
    attackSound = pandemoniumPart:FindFirstChild("Attack")

    for i=1,4 do
        local snd = pandemoniumPart:FindFirstChild("Bang"..i)
        if snd and snd:IsA("Sound") then
            snd.Volume = BANG_VOLUME
            table.insert(bangSounds,snd)
        end
    end

    -- Preload model sounds BEFORE chasing starts. This avoids the spectator
    -- hearing Attack/Bang noticeably later than the locked player.
    local preloadList = {}
    if attackSound and attackSound:IsA("Sound") then
        table.insert(preloadList, attackSound)
    end
    for _, snd in ipairs(bangSounds) do
        table.insert(preloadList, snd)
    end

    if #preloadList > 0 then
        pcall(function()
            game:GetService("ContentProvider"):PreloadAsync(preloadList)
        end)
    end

    return true
end

local function playRandomBang()
    if #bangSounds == 0 then return end
    local snd = bangSounds[math.random(1,#bangSounds)]
    if snd then
        pcall(function()
            snd.Volume = BANG_VOLUME
            snd.TimePosition = 0
            snd:Play()
        end)
    end
end

-- Every major minigame shake can call this too.
_G.Z367PlayModelBang = playRandomBang

local function getCachedCameraShaker()
    if CachedCameraShaker then
        return CachedCameraShaker
    end

    local module = ReplicatedStorage:FindFirstChild("CameraShaker")
    if not module then
        return nil
    end

    local ok, result = pcall(require, module)
    if ok then
        CachedCameraShaker = result
        return result
    end

    return nil
end

local function stopAmbientMicroShake()
    if ambientCameraShaker then
        pcall(function()
            ambientCameraShaker:Stop()
        end)
        ambientCameraShaker = nil
    end
end

local function startAmbientMicroShake()
    stopAmbientMicroShake()

    local CameraShaker = getCachedCameraShaker()
    if not CameraShaker then
        return
    end

    pcall(function()
        ambientCameraShaker = CameraShaker.new(
            Enum.RenderPriority.Camera.Value,
            function(cf)
                if not soundSystemActive then
                    return
                end

                local cam = Workspace.CurrentCamera
                if cam then
                    cam.CFrame = cam.CFrame * cf
                end
            end
        )

        ambientCameraShaker:Start()

        -- Same requested low shake, but now it begins for EVERY client
        -- at encounter start and lasts throughout the entire 42 seconds.
        ambientCameraShaker:ShakeOnce(
            10,
            10,
            0.1,
            CONFIG.Duration,
            2,
            0.5
        )
    end)
end

local function spectatorCameraShake()
    local CameraShaker = getCachedCameraShaker()
    if not CameraShaker then return end

    pcall(function()
        local shaker = CameraShaker.new(
            Enum.RenderPriority.Camera.Value,
            function(cf)
                local cam = Workspace.CurrentCamera
                if cam then
                    cam.CFrame = cam.CFrame * cf
                end
            end
        )

        shaker:Start()
        shaker:ShakeOnce(12,80,0.08,0.32,1.1,0.25)
        task.delay(.7,function()
            pcall(function() shaker:Stop() end)
        end)
    end)
end

local function spectatorClimaxShake()
    local CameraShaker = getCachedCameraShaker()
    if not CameraShaker then return end

    pcall(function()
        local shaker = CameraShaker.new(
            Enum.RenderPriority.Camera.Value,
            function(cf)
                local cam = Workspace.CurrentCamera
                if cam then
                    cam.CFrame = cam.CFrame * cf
                end
            end
        )

        shaker:Start()
        shaker:ShakeOnce(
            34,
            220,
            0.05,
            0.62,
            2.2,
            0.55
        )

        task.delay(1.0,function()
            pcall(function() shaker:Stop() end)
        end)
    end)
end

local function startSoundManager()
    if soundManagerConnection then
        soundManagerConnection:Disconnect()
    end

    local bangTimer = 0
    local nextBangInterval = math.random(2,6)
    local climaxStarted = false

    soundManagerConnection = RunService.Heartbeat:Connect(function(dt)
        if not soundSystemActive then return end

        local elapsed = os.clock() - chaseStartTime

        -- At six seconds the encounter enters its climax on EVERY client.
        -- Fire one Bang immediately so spectator audio does not feel late.
        if not climaxStarted and elapsed >= 6 then
            climaxStarted = true
            bangTimer = 0
            nextBangInterval = math.random(2,6)

            playRandomBang()

            -- The locked player already gets the minigame's dedicated strong
            -- six-second shake. Spectators receive the matching camera hit here.
            if not isThisPlayerLocked() then
                spectatorClimaxShake()
            end
        end

        if climaxStarted and elapsed < (CONFIG.Duration + 6) then
            bangTimer += dt

            if bangTimer >= nextBangInterval then
                playRandomBang()
                spectatorCameraShake()

                bangTimer = 0
                nextBangInterval = math.random(2,6)
            end
        end
    end)
end

local function startAmbientForEveryone()
    if soundSystemActive then return end

    soundSystemActive = true
    chaseStartTime = os.clock()
    Z367MusicStartedAt = chaseStartTime

    encounterSerial += 1
    local thisEncounter = encounterSerial

    -- Music was downloaded and preloaded when this script loaded.
    -- Every client starts it as soon as Z-367 reaches the selected player,
    -- regardless of whether that client is the locked target or a spectator.
    if Z367_PRELOADED_MUSIC and Z367_PRELOADED_MUSIC.Parent then
        pcall(function()
            Z367_PRELOADED_MUSIC.Volume = Z367_MUSIC_VOLUME
            Z367_PRELOADED_MUSIC.TimePosition = 0
            Z367_PRELOADED_MUSIC:Play()
        end)
    end

    -- Full-duration micro shake also starts at the exact same encounter point.
    startAmbientMicroShake()
    startSoundManager()

    -- Spectator clients do not run the minigame, so they need their own
    -- encounter completion cleanup. At about the same moment the locked
    -- player would survive the 42-second game, remove their local Z-367 too.
    if not isThisPlayerLocked() then
        task.delay(CONFIG.Duration + 0.10, function()
            if encounterSerial ~= thisEncounter then return end
            if resolved or not soundSystemActive then return end

            resolved = true

            if removeZ367 then
                removeZ367()
            end
        end)
    end
end

local function stopAmbient()
    soundSystemActive=false
    isShakingCamera=false

    -- Cancel any pending observer-side 42 second cleanup from this encounter.
    encounterSerial += 1

    stopAmbientMicroShake()

    if soundManagerConnection then
        soundManagerConnection:Disconnect()
        soundManagerConnection=nil
    end

    if attackSound then
        pcall(function() attackSound:Stop() end)
        attackSound.Volume=1
    end

    for _,snd in ipairs(bangSounds) do
        pcall(function() snd:Stop() end)
    end

    -- Keep the preloaded Sound in workspace permanently.
    -- Only stop/reset playback between encounters.
    if Z367_PRELOADED_MUSIC and Z367_PRELOADED_MUSIC.Parent then
        pcall(function()
            Z367_PRELOADED_MUSIC:Stop()
            Z367_PRELOADED_MUSIC.TimePosition = 0
            Z367_PRELOADED_MUSIC.Volume = Z367_MUSIC_VOLUME
        end)
    end

    Z367MusicStartedAt = nil
end

local function stopZ367MusicOnly()
    if Z367_PRELOADED_MUSIC and Z367_PRELOADED_MUSIC.Parent then
        pcall(function()
            Z367_PRELOADED_MUSIC:Stop()
            Z367_PRELOADED_MUSIC.TimePosition = 0
            Z367_PRELOADED_MUSIC.Volume = Z367_MUSIC_VOLUME
        end)
    end

    Z367MusicStartedAt = nil
end

local function disconnectSelectedPlayerDeathWatcher()
    if selectedPlayerDeathConnection then
        selectedPlayerDeathConnection:Disconnect()
        selectedPlayerDeathConnection = nil
    end
end

local function watchSelectedPlayerDeath(plr)
    disconnectSelectedPlayerDeathWatcher()

    if not plr then
        return
    end

    local character = plr.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    if not humanoid then
        return
    end

    -- IMPORTANT: only the player selected/locked by THIS Z-367 is watched.
    -- Deaths of unrelated players do not affect the music.
    selectedPlayerDeathConnection = humanoid.Died:Connect(function()
        if SELECTED_PLAYER == plr or Z367LockedPlayer == plr then
            -- Only the player selected by THIS Z-367 matters.
            -- Their death immediately ends the encounter ambience on every
            -- client and returns Z-367 to its normal spawner path.
            stopZ367MusicOnly()

            if releaseBackToSpawnerPath then
                releaseBackToSpawnerPath()
            end
        end
    end)
end

local function disableCustomChase()
    if chaseConnection then
        chaseConnection:Disconnect()
        chaseConnection=nil
    end
end

local function disableEncounterHold()
    if encounterHoldConnection then
        encounterHoldConnection:Disconnect()
        encounterHoldConnection=nil
    end
end

local function startEncounterHold()
    disableEncounterHold()

    encounterHoldConnection = RunService.Heartbeat:Connect(function()
        if not TARGET_LOCKED or resolved then return end
        if not entityModel or not entityModel.Parent or not entityModel.PrimaryPart then return end
        if not SELECTED_PLAYER then return end

        local char = SELECTED_PLAYER.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if not root then
            -- Keep the entity at its last position until the failure result releases it.
            return
        end

        local frontPos = root.Position + root.CFrame.LookVector * HOLD_DISTANCE
        entityModel:SetPrimaryPartCFrame(CFrame.lookAt(frontPos, root.Position))

        -- Once held in front of the target, failure departure continues away
        -- from the player in the same forward direction.
        lockedDepartureDirection = root.CFrame.LookVector
    end)
end

local function disableDeparture()
    if departureConnection then
        departureConnection:Disconnect()
        departureConnection=nil
    end
end

local function startDeparture(direction)
    disableDeparture()

    if not entityModel or not entityModel.Parent or not entityModel.PrimaryPart then
        return
    end

    local dir = direction
    if not dir or dir.Magnitude < 0.001 then
        dir = entityModel.PrimaryPart.CFrame.LookVector
    else
        dir = dir.Unit
    end

    local travelled = 0

    departureConnection = RunService.Heartbeat:Connect(function(dt)
        if not entityModel or not entityModel.Parent or not entityModel.PrimaryPart then
            disableDeparture()
            return
        end

        local step = DEPART_SPEED * math.min(dt, 1/20)
        travelled += step

        local pos = entityModel.PrimaryPart.Position + dir * step
        entityModel:SetPrimaryPartCFrame(CFrame.lookAt(pos, pos + dir))

        if travelled >= DEPART_DISTANCE then
            disableDeparture()
            setEyes(false)
        end
    end)
end

removeZ367 = function()
    disableCustomChase()
    disableEncounterHold()
    disconnectSelectedPlayerDeathWatcher()
    disableDeparture()
    stopAmbient()
    setEyes(false)
    if entityModel and entityModel.Parent then
        entityModel:Destroy()
    else
        local z=Workspace:FindFirstChild("Z-367")
        if z then z:Destroy() end
    end
end

releaseBackToSpawnerPath = function()
    -- The selected/locked player died or failed.
    -- Stop every custom movement override and let the original entity spawner
    -- continue its normal path. This encounter is permanently resolved, so
    -- Z-367 will NOT select another player afterwards.
    TARGET_LOCKED = true
    resolved = true

    disableCustomChase()
    disableEncounterHold()
    disableDeparture()
    disconnectSelectedPlayerDeathWatcher()
    stopAmbient()
    setEyes(false)

    SELECTED_PLAYER = nil
    SELECTED_USER_ID = nil
    Z367LockedPlayer = nil
    lockedDepartureDirection = nil

    -- Intentionally DO NOT call startDeparture().
    -- With our CFrame overrides disconnected, the original spawner movement
    -- is free to resume from here.
end

_G.Z367IntegratedResult=function(result)
    if resolved then return end
    resolved=true
    if result=="win" then
        removeZ367()
    else
        releaseBackToSpawnerPath()
    end
end

local function beginSelectedPlayerEncounter()
    if not SELECTED_PLAYER or resolved then return end

    TARGET_LOCKED=true
    Z367LockedPlayer = SELECTED_PLAYER

    setEyes(true)

    -- Everyone gets the atmosphere.
    startAmbientForEveryone()

    -- Only the locked target gets the actual game.
    if isThisPlayerLocked() and not Z367EncounterStarted then
        local starter = _G.Z367StartSelectedMinigame
        if type(starter) == "function" then
            Z367EncounterStarted = true
            task.spawn(function()
                local ok, err = pcall(starter)
                if not ok then
                    -- Allow retry instead of permanently marking the encounter as started.
                    Z367EncounterStarted = false
                    warn("[Z-367] Minigame failed to start:", err)

                    -- Never leave an accidental fade over the player's screen.
                    if ui and ui.IntroFade and ui.IntroFade.Parent then
                        ui.IntroFade.BackgroundTransparency = 1
                        ui.IntroFade.Visible = false
                        ui.IntroFade.Active = false
                    end
                end
            end)
        end
    end
end

local function playAttackOnTargetLock()
    if not attackSound or not attackSound:IsA("Sound") then
        return
    end

    pcall(function()
        attackSound:Stop()
        attackSound.TimePosition = 0
        attackSound.Volume = 1
        attackSound:Play()
    end)
end

local function fadeAttackForEncounter()
    if not attackSound or not attackSound:IsA("Sound") then
        return
    end

    -- Z-367 has reached the player: keep Attack audible,
    -- but smoothly push it into the background under the music.
    pcall(function()
        TweenService:Create(
            attackSound,
            TweenInfo.new(1.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Volume = 0.1}
        ):Play()
    end)
end

local function startNearestPlayerChase()
    if not entityModel or not entityModel.PrimaryPart then return end
    disableCustomChase()

    chaseConnection=RunService.Heartbeat:Connect(function(dt)
        if resolved or not entityModel or not entityModel.Parent or not entityModel.PrimaryPart then return end

        -- Select exactly once. Dead players are ignored.
        if not SELECTED_PLAYER then
            local plr,root,d=getNearestAlivePlayer(entityModel.PrimaryPart.Position)

            if plr and d and d <= ACQUIRE_RANGE then
                SELECTED_PLAYER=plr
                SELECTED_USER_ID=plr.UserId
                Z367LockedPlayer=plr

                -- Only this selected player is watched for death.
                watchSelectedPlayerDeath(plr)

                -- Attack starts only after Z-367 has actually acquired a player.
                playAttackOnTargetLock()
            else
                setEyes(false)
                return
            end
        end

        local _,hum,targetRoot=aliveCharacter(SELECTED_PLAYER)
        if not hum or not targetRoot then
            -- Once Z-367 has selected somebody, losing that target ends this
            -- encounter. Restore the normal path and never lock a replacement.
            releaseBackToSpawnerPath()
            return
        end

        local pos=entityModel.PrimaryPart.Position
        local target=targetRoot.Position
        local delta=target-pos
        local distance=delta.Magnitude

        if distance <= GAME_TRIGGER_DISTANCE then
            -- Lock once at roughly 3 studs, start the minigame, and keep
            -- Z-367 held in front of THIS player for the whole minigame.
            -- It only leaves after the player fails/dies.
            lockedDepartureDirection = targetRoot.CFrame.LookVector

            disableCustomChase()

            -- Reaching the selected player's front is the common sync point
            -- on every client: Attack fades, music starts, Bang timing starts,
            -- full-duration micro shake starts, and only the locked player gets UI.
            fadeAttackForEncounter()
            beginSelectedPlayerEncounter()
            startEncounterHold()
            return
        end

        setEyes(true)
        local dir=delta.Unit
        local travel=math.min(ENTITY_SPEED*dt, math.max(0,distance-GAME_TRIGGER_DISTANCE))
        local newPos=pos+dir*travel
        entityModel:SetPrimaryPartCFrame(CFrame.new(newPos,target))
    end)
end

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

entity:SetCallback("OnSpawned",function()
    disconnectSelectedPlayerDeathWatcher()
    stopAmbientMicroShake()
    encounterSerial += 1

    resolved = false
    TARGET_LOCKED = false
    Z367EncounterStarted = false
    SELECTED_PLAYER = nil
    SELECTED_USER_ID = nil
    Z367LockedPlayer = nil
    lockedDepartureDirection = nil
    Z367MusicStartedAt = nil

    -- Ensure the persistent music is silent before this new encounter.
    if Z367_PRELOADED_MUSIC and Z367_PRELOADED_MUSIC.Parent then
        pcall(function()
            Z367_PRELOADED_MUSIC:Stop()
            Z367_PRELOADED_MUSIC.TimePosition = 0
            Z367_PRELOADED_MUSIC.Volume = Z367_MUSIC_VOLUME
        end)
    end

    entityModel=entity.Model
    if entityModel and not entityModel.PrimaryPart then
        entityModel.PrimaryPart=entityModel:FindFirstChild("Main")
            or entityModel:FindFirstChildWhichIsA("BasePart")
    end
    findEntityAudio()
    startNearestPlayerChase()
end)

entity:SetCallback("OnDespawning",function()
    disableCustomChase()
    disableEncounterHold()
    disconnectSelectedPlayerDeathWatcher()
    disableDeparture()

    -- If no player was ever locked, soundSystemActive is false and there
    -- is nothing pending/waiting for music playback. The preloaded Sound
    -- simply stays in workspace, stopped, ready for a future Z-367 call.
    stopAmbient()
    setEyes(false)
end)

entity:SetCallback("OnDamagePlayer",function(newHealth)
    if newHealth==0 then
        releaseBackToSpawnerPath()
    end
end)

entity:SetCallback("OnRebounding",function(startOfRebound)
    if not entityModel then return end
    local main=entityModel:FindFirstChild("Main")
    if not main then return end
    local attachment=main:FindFirstChild("Attachment")
    local attachmentSwitch=main:FindFirstChild("AttachmentSwitch")
    if not attachment or not attachmentSwitch then return end

    local footsteps=main:FindFirstChild("Footsteps")
    local playSound=main:FindFirstChild("PlaySound")
    local switch=main:FindFirstChild("Switch")
    local switchBack=main:FindFirstChild("SwitchBack")

    for _,c in ipairs(attachment:GetChildren()) do
        pcall(function() c.Enabled=not startOfRebound end)
    end
    for _,c in ipairs(attachmentSwitch:GetChildren()) do
        pcall(function() c.Enabled=startOfRebound end)
    end

    if startOfRebound then
        if footsteps then footsteps.PlaybackSpeed=.35 end
        if playSound then playSound.PlaybackSpeed=.25 end
        if switch then switch:Play() end
    else
        if footsteps then footsteps.PlaybackSpeed=.25 end
        if playSound then playSound.PlaybackSpeed=.16 end
        if switchBack then switchBack:Play() end
    end
end)

entity:Run()
end

function entityBehaviors.A60Ps1()
local entity = spawner.Create({
	Entity = {
		Name = "A60",
		Asset = "117633452506607",
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
		Speed = 350,
		Delay = 3,
		Reversed = false
	},
	Rebounding = {
		Enabled = true,
		Type = "ambush",
		Min = 5,
		Max = 5,
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
else
end
end

function entityBehaviors.A60PS2()
function DEATHMESSAGE(messages, deathCause)
    spawn(function()
        for _ = 1, 50 do
            wait()
            game:GetService("ReplicatedStorage").GameStats["Player_" .. game.Players.LocalPlayer.Name].Total.DeathCause.Value = deathCause
            firesignal(game:GetService("ReplicatedStorage").RemotesFolder.DeathHint.OnClientEvent, messages, "Blue")
        end
    end)
end

local originalDEATHMESSAGE = DEATHMESSAGE

local jumpscareActive = false
local entityTimerActive = false
local attackDetectionActive = true
local loopActive = false

DEATHMESSAGE = function(messages, deathCause)
    originalDEATHMESSAGE(messages, deathCause)
    
    if deathCause == "A-60" and not jumpscareActive then
        jumpscareActive = true

        spawn(function()
            local jumpSound = Instance.new("Sound")
            jumpSound.Parent = workspace
            jumpSound.Volume = 10
            jumpSound.SoundId = "rbxassetid://103879029437685"
            jumpSound:Play()

            wait(jumpSound.TimeLength)
            jumpSound:Destroy()
        end)
        
        local function PlayA60Jumpscare()
            local JumpscareGUI = Instance.new("ScreenGui")
            JumpscareGUI.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
            JumpscareGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            
            local JumpscareEnd = Instance.new("ImageLabel")
            JumpscareEnd.Name = "JumpscareEnd"
            JumpscareEnd.Parent = JumpscareGUI
            JumpscareEnd.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            JumpscareEnd.BackgroundTransparency = 1
            JumpscareEnd.Position = UDim2.new(0.468, 0, 0.455, 0)
            JumpscareEnd.Size = UDim2.new(0.064, 0, 0.088, 0)
            JumpscareEnd.Image = "rbxassetid://0"
            JumpscareEnd.ImageColor3 = Color3.fromRGB(255, 0, 4)
            JumpscareEnd.ZIndex = 10
            
            local FullScreen = Instance.new("ImageLabel")
            FullScreen.Name = "Full"
            FullScreen.Parent = JumpscareGUI
            FullScreen.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            FullScreen.BackgroundTransparency = 1
            FullScreen.Position = UDim2.new(-0.061, 0, -0.224, 0)
            FullScreen.Size = UDim2.new(1.122, 0, 1.447, 0)
            FullScreen.Image = "rbxassetid://11151804223"
            FullScreen.ImageTransparency = 1
            FullScreen.ZIndex = 5
            
            local A60 = workspace:FindFirstChild("A-60")
            if not A60 then
                JumpscareGUI:Destroy()
                return
            end
            
            local RushModel = A60:FindFirstChild("RushNew")
            if not RushModel then
                JumpscareGUI:Destroy()
                return
            end
            
            local Player = game.Players.LocalPlayer
            local Character = Player.Character
            if not Character then
                JumpscareGUI:Destroy()
                return
            end
            
            local Camera = workspace.CurrentCamera
            
            local CameraShaker
            local success, shakerModule = pcall(function()
                return require(game:GetService("ReplicatedStorage"):FindFirstChild("CameraShaker") or 
                       game:GetService("ReplicatedStorage"):WaitForChild("CameraShaker"))
            end)
            
            if success and shakerModule then
                CameraShaker = shakerModule.new(Enum.RenderPriority.Camera.Value, function(cameraShake)
                    Camera.CFrame = Camera.CFrame * cameraShake
                end)
                CameraShaker:Start()
            end
            
            local A60Clone = RushModel:Clone()
            A60Clone.Parent = Camera
            A60Clone.Name = "A-60_SCARE"
            
            for _, descendant in pairs(A60Clone:GetDescendants()) do
                if descendant:IsA("Sound") then
                    descendant:Destroy()
                end
            end
            
            local faceImages = A60Clone:FindFirstChild("IMAGEIDS")
            if faceImages then
                task.spawn(function()
                    while A60Clone.Parent do
                        local images = faceImages:GetChildren()
                        if #images > 0 then
                            local randomImage = images[math.random(1, #images)]
                            local mainFace = A60Clone:FindFirstChild("Main")
                            if mainFace and mainFace:FindFirstChild("Face") then
                                mainFace.Face.Texture = randomImage.Image
                            end
                        end
                        task.wait(math.random(0, 20) / 1000)
                    end
                end)
            end
            
            if CameraShaker then
                CameraShaker:ShakeOnce(25, 25, 0, 4, 90, 60)
            end
            
            local colorEffect = Instance.new("ColorCorrectionEffect")
            colorEffect.Parent = game:GetService("Lighting")
            
            game:GetService("TweenService"):Create(colorEffect, TweenInfo.new(0.5), {
                Brightness = 0.2,
                Contrast = 0.2,
                Saturation = -0.2,
                TintColor = Color3.fromRGB(255, 0, 4)
            }):Play()
            
            local targetOffset = Vector3.new(0, -1.2, -5)
            local lerpSpeed = 0.8
            
            task.spawn(function()
                local startTime = tick()
                while tick() - startTime < 0.5 and A60Clone.Parent do
                    local alpha = (tick() - startTime) / 0.5
                    A60Clone.CFrame = A60Clone.CFrame:Lerp(Camera.CFrame * CFrame.new(targetOffset), lerpSpeed)
                    task.wait()
                end
                
                local mainFace = A60Clone:FindFirstChild("Main")
                if mainFace and mainFace:FindFirstChild("Face") then
                    JumpscareEnd.Image = mainFace.Face.Texture
                end
                
                game:GetService("TweenService"):Create(JumpscareEnd, TweenInfo.new(0.5), {
                    Size = FullScreen.Size,
                    Position = FullScreen.Position,
                    Rotation = math.random(-20, 20)
                }):Play()
                
                game:GetService("TweenService"):Create(colorEffect, TweenInfo.new(10), {
                    Brightness = 0,
                    Contrast = 0,
                    Saturation = 0,
                    TintColor = Color3.fromRGB(255, 255, 255)
                }):Play()
                
                game:GetService("TweenService"):Create(A60Clone, TweenInfo.new(1), {
                    CFrame = Camera.CFrame * CFrame.new(Vector3.new(0, -1.2, 45))
                }):Play()
                
                task.wait(0.5)
                
                game:GetService("TweenService"):Create(JumpscareEnd, TweenInfo.new(0.5), {
                    ImageTransparency = 1
                }):Play()
                
                task.wait(0.5)
                
                A60Clone:Destroy()
                task.wait(2)
                colorEffect:Destroy()
                task.wait(1)
                JumpscareGUI:Destroy()
                jumpscareActive = false
            end)
        end
        
        PlayA60Jumpscare()
    end
end

local models = game:GetObjects("rbxassetid://117633452506607")
local figureModel = models[1]
figureModel.Parent = workspace
figureModel.Name = "A-60"

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
    local attackRange = 70
    local attackCooldown = 0.5
    local deathMessages = {
        "你被A-60击败了...",
        "巨大的嘈杂声中能感知到你的存在",
        "保持距离，寻找安全的位置"
    }
    
    spawn(function()
        while figureModel and figureModel.Parent and attackDetectionActive do
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
                                
                                humanoid:TakeDamage(100)
                                
                                DEATHMESSAGE(deathMessages, "A-60")
                                
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
            moveToPosition(nearest.Position, 140)
            
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
        moveToPosition(waypoint.Position, 140)
        
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
        moveToPosition(waypoint.Position, 140)
        
        if not figureModel or not figureModel.PrimaryPart then
            break
        end
        
        currentPos = figureModel.PrimaryPart.Position
    end
end

if not entityTimerActive then
    entityTimerActive = true
    loopActive = true
    
    setupAttackDetection()
    
    spawn(function()
        while loopActive and figureModel and figureModel.Parent do
            moveThroughWaypoints()
            wait(0.1)
        end
    end)
    
    spawn(function()
        wait(60)
        
        loopActive = false
        attackDetectionActive = false
        
        if figureModel and figureModel.Parent then
            figureModel:Destroy()
        end
        
        figureModel = nil
        entityTimerActive = false
    end)
end

spawn(function()
    wait(0.5)
    local face = workspace:WaitForChild("A-60"):WaitForChild("RushNew"):WaitForChild("Main"):WaitForChild("Face")
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
end

function entityBehaviors.XBramble()
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

function entityBehaviors.A200()
local entity = spawner.Create({Entity = {Name = "A-200",Asset = "125138842800011",HeightOffset = 1},Lights = {Flicker = {Enabled = false,Duration = 10},Shatter = false,Repair = false},Earthquake = {Enabled = false},CameraShake = {Enabled = true,Range = 200,
Values = {1.5, 1, 0.1, 1}},Movement = {Speed = 60,Delay = 5,Reversed = true},Rebounding = {Enabled = false,Type = "ambush",Min = 4,Max = 4,Delay = math.random(10, 30) / 10},Damage = {Enabled = true,Range = 100,Amount = 1},Crucifixion = {Enabled = true,Range = 100,Resist = false,Break = true},Death = {Type = "Guiding",Hints = {"你死于A-200", "竖起耳朵仔细辨别是一个麻烦", "但你不得不这么做", "你或许会在寂静那学到点什么"},Cause = ""}})
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

function entityBehaviors.AMIN60()
local entity = spawner.Create({Entity = {Name = "Amin-60",Asset = "134290844453819",HeightOffset = 0.8},Lights = {Flicker = {Enabled = false,Duration = 10},Shatter = true,Repair = false},Earthquake = {Enabled = false},CameraShake = {Enabled = true,Range = 200,Values = {1.5, 20, 0.1, 1}},Movement = {Speed = 400,Delay = 6.5,Reversed = false},Rebounding = {Enabled = true,Type = "ambush",Min = 10,Max = 10,Delay = math.random(10, 30) / 10},Damage = {Enabled = true,Range = 100,Amount = 125},Crucifixion = {Enabled = true,Range = 100,Resist = false,Break = true},Death = {Type = "Guiding",Hints = {"你死于Amin-60", "极大的嘈杂声会掩盖其他声音", "他比A60更加迅速敏捷", "仔细听取木板碎裂的声音"},Cause = ""}})
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

function entityBehaviors.Black60()
local entity = spawner.Create({Entity = {Name = "Black-A60",Asset = "96102326082560",HeightOffset = 0},Lights = {Flicker = {Enabled = false,Duration = 10},Shatter = true,Repair = false},Earthquake = {Enabled = false},CameraShake = {Enabled = true,Range = 200,Values = {1.5, 20, 0.1, 1}},Movement = {Speed = 350,Delay = 6.5,Reversed = false},Rebounding = {Enabled = true,Type = "ambush",Min = 10,Max = 10,Delay = math.random(10, 30) / 10},Damage = {Enabled = true,Range = 100,Amount = 125},Crucifixion = {Enabled = true,Range = 100,Resist = false,Break = true},Death = {Type = "Guiding",Hints = {"你死于BlackA60", "极大的嘈杂声会掩盖其他声音", "在不妥时使用十字架会更方便", "反复进柜子躲避它"},Cause = ""}})
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

function entityBehaviors.Silence()
local entity = spawner.Create({Entity = {Name = "Silence",Asset = "115741296805200",HeightOffset = 1},Lights = {Flicker = {Enabled = false,Duration = 0.1},Shatter = true,Repair = false},Earthquake = {Enabled = false},CameraShake = {Enabled = true,Range = 20,Values = {1.5, 20, 0.1, 1}},Movement = {Speed = 35,Delay = 2,Reversed = false},Rebounding = {Enabled = false,Type = "Blitz",Min = 1,Max = math.random(1, 2),Delay = math.random(10, 30) / 10},Damage = {Enabled = true,Range = 200,Amount = 125},Crucifixion = {Enabled = true,Range = 200,Resist = false,Break = true},Death = {Type = "Guiding",Hints = {"你被 Silence 吞噬了...", "你该学会不在寂静中消亡", "请仔细辨别环境中的声音", "他随时都可能出现"},Cause = ""}})
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

function entityBehaviors.ForstBite()
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

local s = LoadCustomInstance("83840759413024", workspace)
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
function entityBehaviors.INGODONE()
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

local MODEL_ID = 107995387840479
local LOOP_SOUND_ID = 139459003161851
local END_SOUND_ID = 101395573137763
local SPECTATOR_SOUND_ID = 9041745062

local FOLLOW_TIME = 5
local TOTAL_TIME = 54
local FADE_OUT_TIME = 3

local START_SAN = 100
local SAN_LOSS_PER_SECOND = 3

local ROOM_SAN_GAIN = 8

local MONSTER_DISTANCE = 13
local MONSTER_HEIGHT_OFFSET = -1.5

local LOOP_VOLUME = 5
local END_VOLUME = 1
local SPECTATOR_VOLUME = 1

local active = false
local ending = false
local currentSan = START_SAN
local sanityDeathTriggered = false

local RENDER_NAME = "UNNAMEABLE_CAMERA_" .. tostring(player.UserId)

local function isDeadOrSpectating()
	if player:GetAttribute("Spectating") == true then
		return true
	end

	if player:GetAttribute("Alive") == false then
		return true
	end

	local character = player.Character

	if character then
		local humanoid = character:FindFirstChildOfClass("Humanoid")

		if humanoid and humanoid.Health <= 0 then
			return true
		end
	end

	return false
end

local function playSpectatorSound()
	local sound = Instance.new("Sound")
	sound.Name = "IndescribableSpectator"
	sound.SoundId = "rbxassetid://" .. SPECTATOR_SOUND_ID
	sound.Volume = SPECTATOR_VOLUME
	sound.Looped = false
	sound.Parent = SoundService

	sound.Ended:Connect(function()
		if sound.Parent then
			sound:Destroy()
		end
	end)

	sound:Play()
end

local function createLoopSound()
	local sound = Instance.new("Sound")
	sound.Name = "UnnameableLoop"
	sound.SoundId = "rbxassetid://" .. LOOP_SOUND_ID
	sound.Volume = LOOP_VOLUME
	sound.Looped = true
	sound.Parent = SoundService
	sound:Play()

	return sound
end

local function playEndingSound()
	local sound = Instance.new("Sound")
	sound.Name = "UnnameableEnding"
	sound.SoundId = "rbxassetid://" .. END_SOUND_ID
	sound.Volume = END_VOLUME
	sound.Looped = false
	sound.Parent = SoundService

	sound.Ended:Connect(function()
		if sound.Parent then
			sound:Destroy()
		end
	end)

	sound:Play()
end

local function createSanUI()
	local gui = Instance.new("ScreenGui")
	gui.Name = "UnnameableSAN"
	gui.ResetOnSpawn = false
	gui.IgnoreGuiInset = true
	gui.DisplayOrder = 1000
	gui.Parent = player:WaitForChild("PlayerGui")

	local veil = Instance.new("Frame")
	veil.Size = UDim2.fromScale(1, 1)
	veil.BackgroundColor3 = Color3.fromRGB(175, 190, 225)
	veil.BackgroundTransparency = 0.99
	veil.BorderSizePixel = 0
	veil.ZIndex = 0
	veil.Parent = gui

	local ghostA = Instance.new("Frame")
	ghostA.Size = UDim2.new(1.1, 0, 1.1, 0)
	ghostA.AnchorPoint = Vector2.new(0.5, 0.5)
	ghostA.Position = UDim2.fromScale(0.5, 0.5)
	ghostA.BackgroundColor3 = Color3.fromRGB(125, 160, 235)
	ghostA.BackgroundTransparency = 0.997
	ghostA.BorderSizePixel = 0
	ghostA.ZIndex = 1
	ghostA.Parent = gui

	local ghostB = Instance.new("Frame")
	ghostB.Size = UDim2.new(1.1, 0, 1.1, 0)
	ghostB.AnchorPoint = Vector2.new(0.5, 0.5)
	ghostB.Position = UDim2.fromScale(0.5, 0.5)
	ghostB.BackgroundColor3 = Color3.fromRGB(235, 135, 175)
	ghostB.BackgroundTransparency = 0.998
	ghostB.BorderSizePixel = 0
	ghostB.ZIndex = 2
	ghostB.Parent = gui

	local holder = Instance.new("Frame")
	holder.AnchorPoint = Vector2.new(1, 0.5)
	holder.Position = UDim2.new(1, 220, 0.5, 0)
	holder.Size = UDim2.fromOffset(190, 65)
	holder.BackgroundColor3 = Color3.fromRGB(4, 4, 7)
	holder.BackgroundTransparency = 0.15
	holder.BorderSizePixel = 0
	holder.ZIndex = 10
	holder.Parent = gui

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 4)
	corner.Parent = holder

	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.fromRGB(110, 115, 130)
	stroke.Transparency = 0.35
	stroke.Thickness = 1
	stroke.Parent = holder

	local title = Instance.new("TextLabel")
	title.BackgroundTransparency = 1
	title.Position = UDim2.fromOffset(12, 5)
	title.Size = UDim2.new(1, -24, 0, 22)
	title.Font = Enum.Font.GothamMedium
	title.Text = "SAN"
	title.TextColor3 = Color3.fromRGB(190, 190, 200)
	title.TextSize = 14
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.ZIndex = 11
	title.Parent = holder

	local value = Instance.new("TextLabel")
	value.BackgroundTransparency = 1
	value.Position = UDim2.fromOffset(12, 25)
	value.Size = UDim2.new(1, -24, 0, 29)
	value.Font = Enum.Font.GothamBold
	value.Text = "100%"
	value.TextColor3 = Color3.fromRGB(235, 235, 240)
	value.TextSize = 23
	value.TextXAlignment = Enum.TextXAlignment.Left
	value.ZIndex = 11
	value.Parent = holder

	local barBG = Instance.new("Frame")
	barBG.Position = UDim2.new(0, 12, 1, -7)
	barBG.Size = UDim2.new(1, -24, 0, 2)
	barBG.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
	barBG.BorderSizePixel = 0
	barBG.ZIndex = 11
	barBG.Parent = holder

	local bar = Instance.new("Frame")
	bar.Size = UDim2.fromScale(1, 1)
	bar.BackgroundColor3 = Color3.fromRGB(205, 210, 220)
	bar.BorderSizePixel = 0
	bar.ZIndex = 12
	bar.Parent = barBG

	TweenService:Create(
		holder,
		TweenInfo.new(0.7, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
		{
			Position = UDim2.new(1, -35, 0.5, 0)
		}
	):Play()

	return {
		gui = gui,
		holder = holder,
		label = value,
		bar = bar,
		veil = veil,
		ghostA = ghostA,
		ghostB = ghostB
	}
end

local function createEffects()
	local blur = Instance.new("BlurEffect")
	blur.Name = "UnnameableBlur"
	blur.Size = 4
	blur.Parent = Lighting

	local color = Instance.new("ColorCorrectionEffect")
	color.Name = "UnnameableColor"
	color.Brightness = 0
	color.Contrast = 0
	color.Saturation = 0
	color.TintColor = Color3.new(1, 1, 1)
	color.Parent = Lighting

	local monochrome = Instance.new("ColorCorrectionEffect")
	monochrome.Name = "UnnameableMonochrome"
	monochrome.Brightness = 0
	monochrome.Contrast = 0
	monochrome.Saturation = 0
	monochrome.TintColor = Color3.new(1, 1, 1)
	monochrome.Parent = Lighting

	local bloom = Instance.new("BloomEffect")
	bloom.Name = "UnnameableBloom"
	bloom.Intensity = 0
	bloom.Size = 36
	bloom.Threshold = 0.65
	bloom.Parent = Lighting

	local depth = Instance.new("DepthOfFieldEffect")
	depth.Name = "UnnameableDepth"
	depth.FarIntensity = 0
	depth.NearIntensity = 0
	depth.FocusDistance = 12
	depth.InFocusRadius = 8
	depth.Parent = Lighting

	local rays = Instance.new("SunRaysEffect")
	rays.Name = "UnnameableRays"
	rays.Intensity = 0
	rays.Spread = 1
	rays.Parent = Lighting

	return {
		blur = blur,
		color = color,
		monochrome = monochrome,
		bloom = bloom,
		depth = depth,
		rays = rays
	}
end

local function loadMonster()
	local success, objects = pcall(function()
		return game:GetObjects("rbxassetid://" .. MODEL_ID)
	end)

	if not success or not objects or not objects[1] then
		return nil
	end

	local monster = objects[1]
	monster.Name = "不可名状"
	monster.Parent = workspace

	if monster:IsA("BasePart") then
		monster.Anchored = true
		monster.CanCollide = false
		monster.CanTouch = false
		monster.CanQuery = false
	end

	for _, object in ipairs(monster:GetDescendants()) do
		if object:IsA("BasePart") then
			object.Anchored = true
			object.CanCollide = false
			object.CanTouch = false
			object.CanQuery = false
		end
	end

	return monster
end

local function setMonsterCFrame(monster, cf)
	if not monster then
		return
	end

	if monster:IsA("Model") then
		monster:PivotTo(cf)
	elseif monster:IsA("BasePart") then
		monster.CFrame = cf
	end
end

local function fadeMonster(monster, duration)
	if not monster then
		return
	end

	if monster:IsA("BasePart") then
		TweenService:Create(
			monster,
			TweenInfo.new(duration),
			{
				Transparency = 1
			}
		):Play()
	end

	for _, object in ipairs(monster:GetDescendants()) do
		if object:IsA("BasePart") then
			TweenService:Create(
				object,
				TweenInfo.new(duration),
				{
					Transparency = 1
				}
			):Play()
		elseif object:IsA("Decal") or object:IsA("Texture") then
			TweenService:Create(
				object,
				TweenInfo.new(duration),
				{
					Transparency = 1
				}
			):Play()
		end
	end
end

local function updateSanDisplay(san, ui)
	san = math.clamp(san, 0, 100)

	if ui.label then
		ui.label.Text = math.floor(san) .. "%"
	end

	if ui.bar then
		TweenService:Create(
			ui.bar,
			TweenInfo.new(0.22, Enum.EasingStyle.Sine),
			{
				Size = UDim2.fromScale(san / 100, 1)
			}
		):Play()
	end
end

local function giveAchievement()
	task.spawn(function()
		pcall(function()
			local DoorsNotify = loadstring(
				game:HttpGet(
					"https://raw.githubusercontent.com/Guestly-Alt/Scripts/refs/heads/main/AchievementHolder.lua"
				)
			)()

			DoorsNotify({
				Style = "Completed!",
				Title = "Indescribable",
				Description = "A strange dream...",
				Reason = "Survive In Indescribable",
				Image = "rbxassetid://8178415737",
				Time = 5
			})
		end)
	end)
end

local function startUnnameable()
	if isDeadOrSpectating() then
		playSpectatorSound()
		return
	end

	if active or ending then
		return
	end

	active = true
	ending = false
	sanityDeathTriggered = false
	currentSan = START_SAN

	camera = workspace.CurrentCamera

	local eventStartTime = os.clock()
	local originalFOV = camera and camera.FieldOfView or 70

	local loopSound = createLoopSound()
	local monster = loadMonster()

	if not monster then
		active = false

		if loopSound then
			loopSound:Stop()
			loopSound:Destroy()
		end

		return
	end

	local ui = createSanUI()
	local effects = createEffects()

	local fadeValue = Instance.new("NumberValue")
	fadeValue.Value = 1

	local latestRoom = ReplicatedStorage
		:WaitForChild("GameData")
		:WaitForChild("LatestRoom")

	local roomConnection
	local deathConnection
	local characterConnection
	local aliveConnection
	local spectatingConnection

	local flipActive = false
	local flipStart = 0
	local flipDuration = 2
	local flipDirection = 1
	local nextFlip = os.clock() + math.random(4, 7)

	local finished = false

	local function disconnectAll()
		if roomConnection then
			roomConnection:Disconnect()
			roomConnection = nil
		end

		if deathConnection then
			deathConnection:Disconnect()
			deathConnection = nil
		end

		if characterConnection then
			characterConnection:Disconnect()
			characterConnection = nil
		end

		if aliveConnection then
			aliveConnection:Disconnect()
			aliveConnection = nil
		end

		if spectatingConnection then
			spectatingConnection:Disconnect()
			spectatingConnection = nil
		end
	end

	local function destroyImmediately()
		RunService:UnbindFromRenderStep(RENDER_NAME)

		disconnectAll()

		if loopSound then
			loopSound:Stop()
			loopSound:Destroy()
			loopSound = nil
		end

		if monster and monster.Parent then
			monster:Destroy()
		end

		for _, effect in pairs(effects) do
			if effect and effect.Parent then
				effect:Destroy()
			end
		end

		if ui.gui and ui.gui.Parent then
			ui.gui:Destroy()
		end

		if fadeValue then
			pcall(function()
				fadeValue:Destroy()
			end)
		end

		camera = workspace.CurrentCamera

		if camera then
			camera.FieldOfView = originalFOV
		end
	end

	local function failEvent()
		if finished then
			return
		end

		finished = true
		ending = true
		active = false

		destroyImmediately()

		ending = false
	end

	local function finishEvent(survived)
		if finished then
			return
		end

		finished = true
		ending = true
		active = false

		disconnectAll()

		if loopSound then
			loopSound:Stop()
			loopSound:Destroy()
			loopSound = nil
		end

		fadeMonster(monster, FADE_OUT_TIME)

		if ui.holder then
			TweenService:Create(
				ui.holder,
				TweenInfo.new(
					FADE_OUT_TIME,
					Enum.EasingStyle.Sine,
					Enum.EasingDirection.InOut
				),
				{
					Position = UDim2.new(1, 230, 0.5, 0),
					BackgroundTransparency = 1
				}
			):Play()
		end

		if ui.label then
			TweenService:Create(
				ui.label,
				TweenInfo.new(FADE_OUT_TIME),
				{
					TextTransparency = 1
				}
			):Play()
		end

		local fadeTween = TweenService:Create(
			fadeValue,
			TweenInfo.new(
				FADE_OUT_TIME,
				Enum.EasingStyle.Sine,
				Enum.EasingDirection.InOut
			),
			{
				Value = 0
			}
		)

		fadeTween:Play()
		fadeTween.Completed:Wait()

		RunService:UnbindFromRenderStep(RENDER_NAME)

		camera = workspace.CurrentCamera

		if camera then
			camera.FieldOfView = originalFOV
		end

		if monster and monster.Parent then
			monster:Destroy()
		end

		for _, effect in pairs(effects) do
			if effect and effect.Parent then
				effect:Destroy()
			end
		end

		if ui.gui and ui.gui.Parent then
			ui.gui:Destroy()
		end

		pcall(function()
			fadeValue:Destroy()
		end)

		playEndingSound()

		if survived and not sanityDeathTriggered then
			giveAchievement()
		end

		ending = false
	end

	local function bindHumanoid(character)
		if deathConnection then
			deathConnection:Disconnect()
			deathConnection = nil
		end

		if not character then
			return
		end

		local humanoid = character:FindFirstChildOfClass("Humanoid")

		if not humanoid then
			humanoid = character:WaitForChild("Humanoid", 5)
		end

		if humanoid then
			deathConnection = humanoid.Died:Connect(function()
				if not active then
					return
				end

				if sanityDeathTriggered then
					return
				end

				failEvent()
			end)
		end
	end

	bindHumanoid(player.Character)

	characterConnection = player.CharacterAdded:Connect(function()
		if not active then
			return
		end

		if not sanityDeathTriggered then
			failEvent()
		end
	end)

	aliveConnection = player:GetAttributeChangedSignal("Alive"):Connect(function()
		if not active or sanityDeathTriggered then
			return
		end

		if player:GetAttribute("Alive") == false then
			failEvent()
		end
	end)

	spectatingConnection = player:GetAttributeChangedSignal("Spectating"):Connect(function()
		if not active or sanityDeathTriggered then
			return
		end

		if player:GetAttribute("Spectating") == true then
			failEvent()
		end
	end)

	roomConnection = latestRoom.Changed:Connect(function()
		if not active or sanityDeathTriggered then
			return
		end

		currentSan = math.clamp(
			currentSan + ROOM_SAN_GAIN,
			0,
			100
		)

		updateSanDisplay(currentSan, ui)

		if ui.holder then
			ui.holder.Size = UDim2.fromOffset(204, 69)

			TweenService:Create(
				ui.holder,
				TweenInfo.new(
					0.35,
					Enum.EasingStyle.Back,
					Enum.EasingDirection.Out
				),
				{
					Size = UDim2.fromOffset(190, 65)
				}
			):Play()
		end
	end)

	RunService:BindToRenderStep(
		RENDER_NAME,
		Enum.RenderPriority.Camera.Value + 1,
		function()
			camera = workspace.CurrentCamera

			if not camera then
				return
			end

			local now = os.clock()
			local elapsed = now - eventStartTime
			local fade = fadeValue.Value

			local eventProgress = math.clamp(
				elapsed / TOTAL_TIME,
				0,
				1
			)

			local insanity = math.clamp(
				1 - currentSan / 100,
				0,
				1
			)

			local lateGame = math.clamp(
				(eventProgress - 0.3) / 0.7,
				0,
				1
			)

			lateGame = lateGame ^ 1.25

			local extremeLate = math.clamp(
				(eventProgress - 0.68) / 0.32,
				0,
				1
			)

			extremeLate = extremeLate ^ 1.35

			local finalPhase = math.clamp(
				(eventProgress - 0.86) / 0.14,
				0,
				1
			)

			if effects.monochrome then
				local monochromeProgress = math.clamp(
					(elapsed - 12) / 8,
					0,
					1
				)

				monochromeProgress =
					monochromeProgress
					* monochromeProgress
					* (3 - 2 * monochromeProgress)

				effects.monochrome.Saturation =
					-1
					* monochromeProgress
					* fade

				effects.monochrome.Contrast =
					0.14
					* monochromeProgress
					* fade

				effects.monochrome.Brightness =
					-0.03
					* monochromeProgress
					* fade
			end

			local flipAngle = 0

			if active
				and eventProgress >= 0.2
				and not flipActive
				and now >= nextFlip
			then
				flipActive = true
				flipStart = now

				flipDuration =
					2.5
					+ eventProgress * 3
					+ extremeLate * 1.8

				flipDirection =
					math.random(0, 1) == 0
					and -1
					or 1
			end

			if flipActive then
				local progress =
					(now - flipStart) / flipDuration

				if progress >= 1 then
					flipActive = false

					local minDelay =
						math.max(
							1.8,
							6.5
							- lateGame * 2.5
							- extremeLate * 1.5
						)

					local maxDelay =
						math.max(
							3,
							9
							- lateGame * 3
							- extremeLate * 2
						)

					nextFlip =
						now
						+ minDelay
						+ math.random()
						* (maxDelay - minDelay)
				else
					local curve =
						math.sin(progress * math.pi) ^ 0.4

					flipAngle =
						math.rad(180)
						* curve
						* flipDirection
						* fade
				end
			end

			local curveRoll =
				math.sin(now * 0.82)
				* math.rad(
					1.8
					+ eventProgress * 2.5
					+ lateGame * 2
				)

			local curveRoll2 =
				math.sin(now * 0.39 + 1.6)
				* math.rad(
					1
					+ eventProgress * 1.7
					+ lateGame * 1.3
				)

			local violentRoll =
				math.sin(now * 1.8)
				* math.rad(
					lateGame * 4
					+ extremeLate * 8
					+ finalPhase * 7
				)

			local noiseRoll =
				math.noise(now * 8, 0, 0)
				* math.rad(
					lateGame * 2.5
					+ extremeLate * 5
					+ finalPhase * 6
				)

			local microRoll =
				math.sin(now * 28)
				* math.rad(
					extremeLate * 1.3
					+ finalPhase * 3
				)

			local pitch =
				(
					math.sin(now * 0.68)
					* math.rad(
						0.5
						+ eventProgress * 1.6
						+ lateGame * 1.5
						+ extremeLate * 2.8
						+ finalPhase * 3
					)
					+
					math.noise(0, now * 8, 0)
					* math.rad(
						lateGame * 1.5
						+ extremeLate * 3.5
						+ finalPhase * 3
					)
				)
				* fade

			local yaw =
				(
					math.sin(now * 0.49)
					* math.rad(
						0.45
						+ eventProgress
						+ lateGame
						+ extremeLate * 2.5
					)
					+
					math.noise(now * 7, 20, 0)
					* math.rad(
						extremeLate * 2
						+ finalPhase * 2.5
					)
				)
				* fade

			local shake =
				(
					0.004
					+ eventProgress * 0.006
					+ lateGame * 0.018
					+ extremeLate * 0.06
					+ finalPhase * 0.08
				)
				* fade

			local shiftX =
				(
					math.sin(now * 1.45) * 0.012
					+
					math.noise(now * 18, 10, 0) * shake
					+
					math.sin(now * 25)
					* 0.025
					* extremeLate
					+
					math.sin(now * 39)
					* 0.025
					* finalPhase
				)
				* fade

			local shiftY =
				(
					math.cos(now * 1.12) * 0.01
					+
					math.noise(10, now * 19, 0) * shake
					+
					math.cos(now * 23)
					* 0.022
					* extremeLate
					+
					math.cos(now * 35)
					* 0.025
					* finalPhase
				)
				* fade

			camera.CFrame =
				camera.CFrame
				* CFrame.new(
					shiftX,
					shiftY,
					0
				)
				* CFrame.Angles(
					pitch,
					yaw,
					(
						curveRoll
						+ curveRoll2
						+ violentRoll
						+ noiseRoll
						+ microRoll
						+ flipAngle
					)
					* fade
				)

			local fovPulse =
				math.sin(now * 1.05)
				*
				(
					1.8
					+ eventProgress * 2
					+ lateGame * 4
					+ extremeLate * 5
					+ finalPhase * 3
				)
				* fade

			local fovNoise =
				math.noise(now * 2.5, 0, 0)
				*
				(
					extremeLate * 4
					+ finalPhase * 3
				)
				* fade

			camera.FieldOfView =
				originalFOV
				+ fovPulse
				+ fovNoise

			if effects.blur then
				local blurValue =
					6
					+ eventProgress ^ 1.3 * 19
					+ lateGame ^ 1.2 * 15
					+ extremeLate * 15
					+ finalPhase * 11
					+ insanity * 8
					+
					math.sin(now * 1.7)
					*
					(
						1.4
						+ lateGame * 2
						+ extremeLate * 2.5
					)

				effects.blur.Size =
					math.clamp(
						blurValue * fade,
						0,
						52
					)
			end

			if effects.color then
				effects.color.Contrast =
					(
						0.09
						+ eventProgress * 0.14
						+ lateGame * 0.2
						+ extremeLate * 0.17
						+ finalPhase * 0.1
						+
						math.sin(now * 0.8) * 0.04
					)
					* fade

				effects.color.Saturation =
					(
						-0.1
						- eventProgress * 0.08
						- lateGame * 0.12
						- extremeLate * 0.1
					)
					* fade

				effects.color.Brightness =
					(
						math.sin(now * 0.55) * 0.025
						+
						math.sin(now * 2.6)
						* extremeLate
						* 0.02
						+
						math.sin(now * 8)
						* finalPhase
						* 0.012
					)
					* fade

				local tintStrength =
					math.clamp(
						(
							0.13
							+ eventProgress * 0.12
							+ lateGame * 0.2
							+ extremeLate * 0.2
						)
						* fade,
						0,
						0.75
					)

				effects.color.TintColor =
					Color3.new(1, 1, 1):Lerp(
						Color3.fromRGB(
							155,
							180,
							225
						),
						tintStrength
					)
			end

			if effects.bloom then
				effects.bloom.Intensity =
					(
						0.35
						+ eventProgress * 0.35
						+ lateGame * 0.75
						+ extremeLate * 0.85
						+ finalPhase * 0.4
						+
						math.sin(now * 0.75) * 0.13
					)
					* fade

				effects.bloom.Size =
					34
					+ lateGame * 12
					+ extremeLate * 16
					+ finalPhase * 8
			end

			if effects.depth then
				effects.depth.FarIntensity =
					math.clamp(
						(
							0.08
							+ eventProgress * 0.13
							+ lateGame * 0.23
							+ extremeLate * 0.2
							+ finalPhase * 0.1
						)
						* fade,
						0,
						0.72
					)

				effects.depth.NearIntensity =
					math.clamp(
						(
							0.04
							+ lateGame * 0.2
							+ extremeLate * 0.18
							+ finalPhase * 0.1
						)
						* fade,
						0,
						0.5
					)

				effects.depth.FocusDistance =
					10
					+
					math.sin(now * 0.65)
					*
					(
						3
						+ lateGame * 4
						+ extremeLate * 5
						+ finalPhase * 4
					)

				effects.depth.InFocusRadius =
					math.max(
						1.5,
						8
						- lateGame * 3
						- extremeLate * 2
						- finalPhase * 1.5
					)
			end

			if effects.rays then
				effects.rays.Intensity =
					(
						0.015
						+ lateGame * 0.05
						+ extremeLate * 0.06
						+ finalPhase * 0.03
					)
					* fade
			end

			if ui.holder then
				local uiShake =
					(
						eventProgress * 1.5
						+ lateGame * 4
						+ extremeLate * 9
						+ finalPhase * 10
					)
					* fade

				ui.holder.Position =
					UDim2.new(
						1,
						-35
						+
						math.sin(now * 14) * uiShake
						+
						math.noise(now * 18, 0, 0) * uiShake,
						0.5,
						math.cos(now * 12) * uiShake
						+
						math.noise(0, now * 17, 0) * uiShake
					)
			end

			if ui.veil then
				ui.veil.BackgroundTransparency =
					math.clamp(
						0.994
						-
						(
							eventProgress * 0.012
							+ lateGame * 0.025
							+ extremeLate * 0.028
							+ finalPhase * 0.015
						)
						* fade,
						0.9,
						1
					)
			end

			if ui.ghostA then
				ui.ghostA.Position =
					UDim2.new(
						0.5,
						math.sin(now * 1.8)
						*
						(
							6
							+ eventProgress * 7
							+ lateGame * 13
							+ extremeLate * 16
							+ finalPhase * 9
						)
						* fade,
						0.5,
						math.cos(now * 1.35)
						*
						(
							4
							+ eventProgress * 6
							+ lateGame * 10
							+ extremeLate * 12
						)
						* fade
					)

				ui.ghostA.BackgroundTransparency =
					math.clamp(
						0.997
						-
						(
							eventProgress * 0.008
							+ lateGame * 0.018
							+ extremeLate * 0.02
							+ finalPhase * 0.01
						)
						* fade,
						0.93,
						1
					)
			end

			if ui.ghostB then
				ui.ghostB.Position =
					UDim2.new(
						0.5,
						-math.sin(now * 1.55)
						*
						(
							5
							+ eventProgress * 7
							+ lateGame * 12
							+ extremeLate * 15
							+ finalPhase * 8
						)
						* fade,
						0.5,
						-math.cos(now * 1.9)
						*
						(
							4
							+ eventProgress * 5
							+ lateGame * 9
							+ extremeLate * 11
						)
						* fade
					)

				ui.ghostB.BackgroundTransparency =
					math.clamp(
						0.998
						-
						(
							eventProgress * 0.007
							+ lateGame * 0.015
							+ extremeLate * 0.018
							+ finalPhase * 0.01
						)
						* fade,
						0.94,
						1
					)
			end
		end
	)

	task.spawn(function()
		while active do
			task.wait(1)

			if not active or sanityDeathTriggered then
				break
			end

			currentSan =
				math.clamp(
					currentSan - SAN_LOSS_PER_SECOND,
					0,
					100
				)

			updateSanDisplay(currentSan, ui)

			if currentSan <= 35 and math.random() > 0.78 then
				ui.label.Text = "??%"
			end

			if currentSan <= 15 and math.random() > 0.58 then
				local fakeValues = {
					"0%",
					"???",
					"-",
					"∞",
					tostring(math.random(101, 999)) .. "%"
				}

				ui.label.Text =
					fakeValues[
						math.random(1, #fakeValues)
					]
			end

			if currentSan <= 0 then
				if not sanityDeathTriggered then
					sanityDeathTriggered = true

					ui.label.Text = "0%"

					if ui.bar then
						ui.bar.Size = UDim2.fromScale(0, 1)
					end

					replicatesignal(
						game.Players.LocalPlayer.Kill
					)

					finishEvent(false)
				end

				break
			end
		end
	end)

	local followStart = os.clock()

	while active and os.clock() - followStart < FOLLOW_TIME do
		camera = workspace.CurrentCamera

		if camera then
			local camCF = camera.CFrame

			local position =
				camCF.Position
				+ camCF.LookVector * MONSTER_DISTANCE
				+ Vector3.new(
					0,
					MONSTER_HEIGHT_OFFSET,
					0
				)

			setMonsterCFrame(
				monster,
				CFrame.lookAt(
					position,
					camCF.Position
				)
			)
		end

		RunService.RenderStepped:Wait()
	end

	while active do
		RunService.Heartbeat:Wait()

		if not sanityDeathTriggered then
			if player:GetAttribute("Alive") == false
				or player:GetAttribute("Spectating") == true
			then
				failEvent()
				return
			end

			local character = player.Character
			local humanoid =
				character
				and character:FindFirstChildOfClass("Humanoid")

			if not character
				or not humanoid
				or humanoid.Health <= 0
			then
				failEvent()
				return
			end
		end

		if os.clock() - eventStartTime >= TOTAL_TIME then
			break
		end
	end

	if active and not sanityDeathTriggered then
		finishEvent(true)
	end
end

startUnnameable()
end


function entityBehaviors.SEEKEYES()
local RunService = game:GetService("RunService")
local camera = workspace.CurrentCamera
local flipActive = true
local flipStart = os.clock()
local flipDuration = 2
local flipDirection = 1
RunService:BindToRenderStep("ScreenFlipOnce", Enum.RenderPriority.Camera.Value + 1, function()
local now = os.clock()
local progress = (now - flipStart) / flipDuration
if progress >= 1 then
RunService:UnbindFromRenderStep("ScreenFlipOnce")
return
end
local curve = math.sin(progress * math.pi) ^ 0.4
local flipAngle = math.rad(180) * curve * flipDirection
camera.CFrame = camera.CFrame * CFrame.Angles(0, 0, flipAngle)
end)
end

function entityBehaviors.Subspace()
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

function entityBehaviors.INGODTWO()
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
                "下次见。"}, Cause = ""}})
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

function entityBehaviors.DELALL()
 local Event = game:GetService("ReplicatedStorage").RemotesFolder.AdminPanelRunCommand
Event:FireServer(
    "DELETE ALL",
    {}
)
local function deleteDirectChildModelsAndParts()
    local workspace = game:GetService("Workspace")
    local names = { "A-200", "A60", "Amin-60", "Black-A60", "Deer god","Black Hole Particle effect","DeerGod",
        "Frostbite", "@&%^#*$Indescribable God!@$*&^!Q(* ", "LightSpeed",
        "Rebound", "Ripper", "Following_ENEMY", "Silence","Dread","Muffler","Common Sence","Fluster","Kitty","Broken eyes","Angry Munci","Shadow","LEVEL0","Him","Hunger","WH1T3","Obsession","HimMoving","smiler", "Chainsmoker" } -- 保持不变
    for _, name in ipairs(names) do
        local child = workspace:FindFirstChild(name)
        if child and (child:IsA("Model") or child:IsA("Part")) then
            child:Destroy()
        end
    end
end
deleteDirectChildModelsAndParts()
end

function entityBehaviors.Smiler()
local entity = spawner.Create({Entity = {Name = "smiler",Asset = "108450814500304",HeightOffset = 0},Lights = {Flicker = {Enabled = true,Duration = 10},Shatter = false,Repair = false},Earthquake = {Enabled = false},CameraShake = {Enabled = true,Range = 200,Values = {1.5, 20, 0.1, 1}},Movement = {Speed = 450,Delay = 11,Reversed = false},Rebounding = {Enabled = true,Type = "ambush",Min = 8,Max = 8,Delay = math.random(10, 30) / 10},Damage = {Enabled = true,Range = 200,Amount = 125},Crucifixion = {Enabled = true,Range = 200,Resist = false,Break = true},Death = {Type = "Guiding",Hints = {"你死于Smiler", "或许你需要在Ambush那学会点东西", "在闪灯数秒后他会出现", "加油,我相信你可以做到"},Cause = ""}})
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
function entityBehaviors.WhoopDaShoop()
local RunService = game:GetService("RunService")
local modelId = 86112457302745
local loadedModel
local success, result = pcall(function()
    return game:GetObjects("rbxassetid://" .. modelId)[1]
end)
if success and result and result:IsA("Model") then
    loadedModel = result
    loadedModel.Parent = workspace
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
        if room:IsA("Model") then
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

local function deleteGroundskeeperSounds()
    local foundAny = false
    local function searchAndDelete(parent)
        for _, child in ipairs(parent:GetChildren()) do
            if child.Name == "Groundskeeper" and child:IsA("Model") then
                processDeleteSounds(child)
            end
            searchAndDelete(child)
        end
    end
    searchAndDelete(workspace)
    return foundAny
end

deleteGroundskeeperSounds()

local function setupSoundDeletionMonitor()
    local connections = {}
    local function processNewSound(sound)
        if not sound:IsA("Sound") then return end
        local current = sound
        while current and current ~= game do
            if current.Name == "Groundskeeper" and current:IsA("Model") then
                sound:Destroy()
                break
            end
            current = current.Parent
        end
    end
    local function monitorDescendantAdded(parent)
        local connection = parent.DescendantAdded:Connect(function(descendant)
            if descendant:IsA("Sound") then
                processNewSound(descendant)
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
    if not targetModel or not targetModel.PrimaryPart or not loadedModel or not loadedModel.PrimaryPart or not targetModel.PrimaryPart.Parent or not loadedModel.Parent then
        if followConnection then
            followConnection:Disconnect()
        end
        return
    end
    local targetCFrame = targetModel.PrimaryPart.CFrame
    loadedModel:PivotTo(targetCFrame)
end)

return function()
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
end

function entityBehaviors.WhoopDaShoopTwo()
 local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://138148333"
sound.Name = "WHOOP"
sound.Parent = workspace
sound:Play()

local targetModel = workspace:FindFirstChild("Following_ENEMY")
if not targetModel then return end

if not targetModel.PrimaryPart then
    local rootPart = targetModel:FindFirstChild("HumanoidRootPart") or targetModel:FindFirstChildWhichIsA("BasePart")
    if rootPart then targetModel.PrimaryPart = rootPart else return end
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
if not groundskeeperModel then return end

if not groundskeeperModel.PrimaryPart then
    local rootPart = groundskeeperModel:FindFirstChild("HumanoidRootPart") or groundskeeperModel:FindFirstChildWhichIsA("BasePart")
    if rootPart then groundskeeperModel.PrimaryPart = rootPart else return end
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
if groundskeeperModel and groundskeeperModel.PrimaryPart and laser1Model and laser1Model.PrimaryPart then
    laser1Model:PivotTo(groundskeeperModel.PrimaryPart.CFrame)
    hideModel(targetModel)
    laser1FollowConnection = RunService.Heartbeat:Connect(function()
        if not groundskeeperModel or not groundskeeperModel.PrimaryPart or not laser1Model or not laser1Model.PrimaryPart or 
           not groundskeeperModel.PrimaryPart.Parent or not laser1Model.Parent then
            if laser1FollowConnection then laser1FollowConnection:Disconnect() end
            return
        end
        laser1Model:PivotTo(groundskeeperModel.PrimaryPart.CFrame)
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
if groundskeeperModel and groundskeeperModel.PrimaryPart and laser2Model and laser2Model.PrimaryPart then
    laser2Model:PivotTo(groundskeeperModel.PrimaryPart.CFrame)
    hideModel(laser1Model)
    laser2FollowConnection = RunService.Heartbeat:Connect(function()
        if not groundskeeperModel or not groundskeeperModel.PrimaryPart or not laser2Model or not laser2Model.PrimaryPart or 
           not groundskeeperModel.PrimaryPart.Parent or not laser2Model.Parent then
            if laser2FollowConnection then laser2FollowConnection:Disconnect() end
            return
        end
        laser2Model:PivotTo(groundskeeperModel.PrimaryPart.CFrame)
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

function entityBehaviors.ChainSmoker()
local entity = spawner.Create({Entity = {Name = "Chainsmoker",Asset = "91743718986054",HeightOffset = 1},Lights = {Flicker = {Enabled = true,Duration = 1},Shatter = true,Repair = false},Earthquake = {Enabled = false},CameraShake = {Enabled = true,Range = 10,Values = {1.5, 20, 0.1, 1}},Movement = {Speed = 30,Delay = 1,Reversed = false},Rebounding = {Enabled = false,Type = "ambush",Min = 4,Max = 4,Delay = math.random(10, 30) / 10},Damage = {Enabled = true,Range = 5,Amount = 125},Crucifixion = {Enabled = true,Range = 20,Resist = false,Break = true},Death = {Type = "Guiding",Hints = {"你死于Chainsmoker", "......", "或许我不能告诉你他的信息", "总而言之，当心闪灯"},Cause = ""}})
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

local deerGodMusicUrl = "https://github.com/Zero0Star/RipperNewSound/blob/master/NoRunning.mp3?raw=true"
local cachedAudioAsset = GitAud(deerGodMusicUrl, "DeerGodMusic")
function entityBehaviors.Deergod()
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
            Asset = "92755817727288",
            HeightOffset = -0.8
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
                "看起来你真倒霉...", 
                "你被所谓的鹿神击杀了", 
                "那股强大的力量会把你拉入深渊",
                "十字架不能保证你的安全",
                "下次见"
            },
            Cause = "Deer God"
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

    if cachedAudioAsset then
        local musicInstance = Instance.new("Sound")
        musicInstance.SoundId = cachedAudioAsset
        musicInstance.Volume = 4
        musicInstance.Name = "DeerGodMusic_" .. tick()
        musicInstance.Parent = workspace
        musicInstance:Play()

        musicInstance.Ended:Connect(function()
            musicInstance:Destroy()
        end)
    end
end

function entityBehaviors.LightSpeed()
local entity = spawner.Create({Entity = {Name = "LightSpeed",Asset = "87015961601567",HeightOffset = 1},Lights = {Flicker = {Enabled = false,Duration = 0.1},Shatter = false,Repair = false},Earthquake = {Enabled = false},CameraShake = {Enabled = true,Range = 20,Values = {90, 50, 20, 20}},Movement = {Speed = 1400,Delay = 20,Reversed = false},Rebounding = {Enabled = false,Type = "Blitz",Min = 1,Max = math.random(1, 2),Delay = math.random(10, 30) / 10},Damage = {Enabled = true,Range = 50,Amount = 40},Crucifixion = {Enabled = true,Range = 50,Resist = false,Break = true},Death = {Type = "Guiding",Hints = {"你死于光速", "在他来临时保证自己以最快的速度作出反应", "伴随着灯光变黄与巨大的雷电轰鸣声", "或许并不致命但总是一个威胁"},Cause = ""}})
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

function entityBehaviors.A200Jump()
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

function entityBehaviors.Cease()
local Event = game:GetService("ReplicatedStorage").RemotesFolder.AdminPanelRunCommand
Event:FireServer(
    "LightRoom",
    {
        ["Light Color"] = Color3.new(0, 0.098297834396362, 1)
    }
)
local entity = spawner.Create({Entity = {Name = "Cease",Asset = "74118615017772",HeightOffset = 1},Lights = {Flicker = {Enabled = false,Duration = 10},Shatter = false,Repair = false},Earthquake = {Enabled = false},CameraShake = {Enabled = true,Range = 200,Values = {1.5, 20, 0.1, 1}},Movement = {Speed = 100,Delay = 5,Reversed = false},Rebounding = {Enabled = false,Type = "ambush",Min = 4,Max = 4,Delay = math.random(10, 30) / 10},Damage = {Enabled = false,Range = 100,Amount = 125},Crucifixion = {Enabled = true,Range = 100,Resist = false,Break = true},Death = {Type = "Guiding",Hints = {"CEASE", "你该学会辨别", "听取周围的声音", "反复进柜子躲避它"},Cause = ""}})
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

function entityBehaviors.SHADOWSW()
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

local s = LoadCustomInstance(76157710463326, workspace)  -- 可以直接使用数字ID
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
end

function entityBehaviors.CL()
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

function entityBehaviors.Shok()
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local function spawnShocker()
    local shockerModel = game:GetObjects("rbxassetid://129658537539698")[1]
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
end

function entityBehaviors.MLcur()
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
    anchor.Size = Vector3.new(0.01, 0.01, 0.01)
    anchor.Transparency = 1
    anchor.Anchored = true
    anchor.CanCollide = false
    anchor.CanTouch = false
    anchor.CanQuery = false
    anchor.Massless = true
    anchor.CFrame = entity.CFrame + Vector3.new(0, 6.5, 0)
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
    
    local reversalRed = cachedModel:FindFirstChild("Reversal Red")
    if not reversalRed then
        for _, descendant in ipairs(cachedModel:GetDescendants()) do
            if descendant.Name:lower() == "reversal red" then
                reversalRed = descendant
                break
            end
        end
    end
    
    if reversalRed then
        local doorsCrucifix = reversalRed:FindFirstChild("doors crucifix")
        if not doorsCrucifix then
            for _, descendant in ipairs(reversalRed:GetDescendants()) do
                if descendant:IsA("Sound") and descendant.Name:lower() == "doors crucifix" then
                    doorsCrucifix = descendant
                    break
                end
            end
        end
        
        if doorsCrucifix and doorsCrucifix:IsA("Sound") then
            local sound = doorsCrucifix:Clone()
            sound.Parent = workspace
            sound:Play()
            
            sound.Ended:Connect(function()
                if sound and sound.Parent then
                    sound:Destroy()
                end
            end)
        end
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

function entityBehaviors.Bombie()
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

function entityBehaviors.HUMANSW()
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

local s = LoadCustomInstance(131784429865597, workspace)
if not s then
    return
end

local entity = s:FindFirstChildWhichIsA("BasePart")
entity.CFrame = GetRoom():WaitForChild("RoomEntrance").CFrame * CFrame.new(-20, -2.5, -10)
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
end)
end


function entityBehaviors.CreakWhite()
local RunService = game:GetService("RunService")
local MODEL_ID = "rbxassetid://107076625314099"
local GRAPH_ID = "rbxassetid://94509516923082"
local creak = workspace
	:WaitForChild("LiveEntities")
	:WaitForChild("Creak")

local objects = game:GetObjects(MODEL_ID)
local clone = objects[1]

if not clone then
	return
end

clone.Name = "CreakMimic"
clone.Parent = workspace

local destroyed = false

local function cleanup()
	if destroyed then
		return
	end

	destroyed = true

	if clone and clone.Parent then
		clone:Destroy()
	end
end

creak.Destroying:Connect(cleanup)

creak.AncestryChanged:Connect(function(_, parent)
	if parent == nil then
		cleanup()
	end
end)

local function hide(obj)
	if obj:IsA("MeshPart") then
		obj.Transparency = 1
	end
end

for _, obj in ipairs(creak:GetDescendants()) do
	hide(obj)
end

creak.DescendantAdded:Connect(hide)

for _, obj in ipairs(clone:GetDescendants()) do
	if obj:IsA("BasePart") then
		obj.CanCollide = false
		obj.CanTouch = false
		obj.CanQuery = false
		obj.Massless = true
	end
end

local cloneRoot =
	clone:FindFirstChild("HumanoidRootPart", true)
	or clone.PrimaryPart
	or clone:FindFirstChildWhichIsA("BasePart", true)

if not cloneRoot then
	cleanup()
	return
end

cloneRoot.Anchored = true
cloneRoot.Massless = false

if clone:IsA("Model") then
	clone.PrimaryPart = cloneRoot
end

local function findAnimator(model)
	local controller =
		model:FindFirstChild("AnimationController", true)

	if controller then
		local animator =
			controller:FindFirstChildWhichIsA(
				"Animator",
				true
			)

		if animator then
			return animator
		end
	end

	return model:FindFirstChildWhichIsA(
		"Animator",
		true
	)
end

local sourceAnimator = findAnimator(creak)
local targetAnimator = findAnimator(clone)

if not sourceAnimator or not targetAnimator then
	cleanup()
	return
end

local function isGraph(track)
	local animation = track.Animation

	if not animation then
		return false
	end

	return
		animation.AnimationId == GRAPH_ID
		or animation.Name == "CreakGraph"
end

local sourceTrack

for _, track in ipairs(
	sourceAnimator:GetPlayingAnimationTracks()
) do
	if isGraph(track) then
		sourceTrack = track
		break
	end
end

sourceAnimator.AnimationPlayed:Connect(function(track)
	if destroyed then
		return
	end

	if isGraph(track) then
		sourceTrack = track
	end
end)

while not sourceTrack and not destroyed do
	task.wait(0.05)

	if destroyed or not creak.Parent then
		cleanup()
		return
	end

	for _, track in ipairs(
		sourceAnimator:GetPlayingAnimationTracks()
	) do
		if isGraph(track) then
			sourceTrack = track
			break
		end
	end
end

if destroyed then
	return
end

for _, track in ipairs(
	targetAnimator:GetPlayingAnimationTracks()
) do
	track:Stop(0)
end

local graphAnimation = Instance.new("Animation")
graphAnimation.Name = "CreakGraph"
graphAnimation.AnimationId = GRAPH_ID

local targetTrack =
	targetAnimator:LoadAnimation(graphAnimation)

local parameterNames = {}

local function updateParameterList()
	table.clear(parameterNames)

	if not sourceTrack then
		return
	end

	local success, defaults = pcall(function()
		return sourceTrack:GetParameterDefaults()
	end)

	if not success or type(defaults) ~= "table" then
		return
	end

	for name in pairs(defaults) do
		table.insert(parameterNames, name)
	end
end

updateParameterList()

local function syncParameters()
	if destroyed then
		return
	end

	local src = sourceTrack
	local dst = targetTrack

	if not src or not dst then
		return
	end

	for i = 1, #parameterNames do
		local name = parameterNames[i]

		local success, value = pcall(
			src.GetParameter,
			src,
			name
		)

		if success and value ~= nil then
			pcall(
				dst.SetParameter,
				dst,
				name,
				value
			)
		end
	end
end

syncParameters()

targetTrack:Play(0, 1, 1)

local lastSourceTrack = sourceTrack

local preAnimationConnection
local renderConnection

preAnimationConnection = RunService.PreAnimation:Connect(function()
	if destroyed then
		preAnimationConnection:Disconnect()
		return
	end

	if sourceTrack ~= lastSourceTrack then
		lastSourceTrack = sourceTrack
		updateParameterList()
	end

	syncParameters()
end)

renderConnection = RunService.RenderStepped:Connect(function()
	if destroyed then
		renderConnection:Disconnect()
		return
	end

	if not creak.Parent then
		cleanup()
		renderConnection:Disconnect()
		return
	end

	if not clone.Parent then
		renderConnection:Disconnect()
		return
	end

	clone:PivotTo(
		creak:GetPivot() * CFrame.new(0, 2.8, 0)
	)
end)
end
function entityBehaviors.CreakHard()
local RunService = game:GetService("RunService")

local MODEL_ID = "rbxassetid://122236943587712"
local GRAPH_ID = "rbxassetid://94509516923082"

local creak = workspace
	:WaitForChild("LiveEntities")
	:WaitForChild("Creak")

local objects = game:GetObjects(MODEL_ID)
local clone = objects[1]

if not clone then
	return
end

clone.Name = "CreakMimic"
clone.Parent = workspace

local destroyed = false

local function cleanup()
	if destroyed then
		return
	end

	destroyed = true

	if clone and clone.Parent then
		clone:Destroy()
	end
end

creak.Destroying:Connect(cleanup)

creak.AncestryChanged:Connect(function(_, parent)
	if parent == nil then
		cleanup()
	end
end)

local function hide(obj)
	if obj:IsA("MeshPart") then
		obj.Transparency = 1
	end
end

for _, obj in ipairs(creak:GetDescendants()) do
	hide(obj)
end

creak.DescendantAdded:Connect(hide)

for _, obj in ipairs(clone:GetDescendants()) do
	if obj:IsA("BasePart") then
		obj.CanCollide = false
		obj.CanTouch = false
		obj.CanQuery = false
		obj.Massless = true
	end
end

local cloneRoot =
	clone:FindFirstChild("HumanoidRootPart", true)
	or clone.PrimaryPart
	or clone:FindFirstChildWhichIsA("BasePart", true)

if not cloneRoot then
	cleanup()
	return
end

cloneRoot.Anchored = true
cloneRoot.Massless = false

if clone:IsA("Model") then
	clone.PrimaryPart = cloneRoot
end

local function findAnimator(model)
	local controller =
		model:FindFirstChild("AnimationController", true)

	if controller then
		local animator =
			controller:FindFirstChildWhichIsA(
				"Animator",
				true
			)

		if animator then
			return animator
		end
	end

	return model:FindFirstChildWhichIsA(
		"Animator",
		true
	)
end

local sourceAnimator = findAnimator(creak)
local targetAnimator = findAnimator(clone)

if not sourceAnimator or not targetAnimator then
	cleanup()
	return
end

local function isGraph(track)
	local animation = track.Animation

	if not animation then
		return false
	end

	return
		animation.AnimationId == GRAPH_ID
		or animation.Name == "CreakGraph"
end

local sourceTrack

for _, track in ipairs(
	sourceAnimator:GetPlayingAnimationTracks()
) do
	if isGraph(track) then
		sourceTrack = track
		break
	end
end

sourceAnimator.AnimationPlayed:Connect(function(track)
	if destroyed then
		return
	end

	if isGraph(track) then
		sourceTrack = track
	end
end)

while not sourceTrack and not destroyed do
	task.wait(0.05)

	if destroyed or not creak.Parent then
		cleanup()
		return
	end

	for _, track in ipairs(
		sourceAnimator:GetPlayingAnimationTracks()
	) do
		if isGraph(track) then
			sourceTrack = track
			break
		end
	end
end

if destroyed then
	return
end

for _, track in ipairs(
	targetAnimator:GetPlayingAnimationTracks()
) do
	track:Stop(0)
end

local graphAnimation = Instance.new("Animation")
graphAnimation.Name = "CreakGraph"
graphAnimation.AnimationId = GRAPH_ID

local targetTrack =
	targetAnimator:LoadAnimation(graphAnimation)

local parameterNames = {}

local function updateParameterList()
	table.clear(parameterNames)

	if not sourceTrack then
		return
	end

	local success, defaults = pcall(function()
		return sourceTrack:GetParameterDefaults()
	end)

	if not success or type(defaults) ~= "table" then
		return
	end

	for name in pairs(defaults) do
		table.insert(parameterNames, name)
	end
end

updateParameterList()

local function syncParameters()
	if destroyed then
		return
	end

	local src = sourceTrack
	local dst = targetTrack

	if not src or not dst then
		return
	end

	for i = 1, #parameterNames do
		local name = parameterNames[i]

		local success, value = pcall(
			src.GetParameter,
			src,
			name
		)

		if success and value ~= nil then
			pcall(
				dst.SetParameter,
				dst,
				name,
				value
			)
		end
	end
end

syncParameters()

targetTrack:Play(0, 1, 1)

local lastSourceTrack = sourceTrack

local preAnimationConnection
local renderConnection

preAnimationConnection = RunService.PreAnimation:Connect(function()
	if destroyed then
		preAnimationConnection:Disconnect()
		return
	end

	if sourceTrack ~= lastSourceTrack then
		lastSourceTrack = sourceTrack
		updateParameterList()
	end

	syncParameters()
end)

renderConnection = RunService.RenderStepped:Connect(function()
	if destroyed then
		renderConnection:Disconnect()
		return
	end

	if not creak.Parent then
		cleanup()
		renderConnection:Disconnect()
		return
	end

	if not clone.Parent then
		renderConnection:Disconnect()
		return
	end

	clone:PivotTo(
		creak:GetPivot()
	)
end)
end
function entityBehaviors.Booom()
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

function entityBehaviors.SuperDread()
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

local s = LoadCustomInstance(140017686556165, workspace) 
if not s then
    return
end

local entity = s:FindFirstChildWhichIsA("BasePart")
entity.CFrame = GetRoom():WaitForChild("RoomEntrance").CFrame * CFrame.new(0, 1, -15)
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
end)
end

function entityBehaviors.DreadJump()
local BLACK = Color3.new(0, 0, 0)
local WHITE = Color3.new(1, 1, 1)
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
    local soundId = GitAud(soundlink, filename)
    
    if not soundId then
        return nil
    end
    
    sound.SoundId = soundId
    sound.Parent = workspace
    sound.Name = filename .. "_" .. tick()
    sound.Volume = vol or 1
    sound.Loaded:Wait()
    sound:Play()
    return sound
end
local githubAudioUrl = "https://github.com/Zero0Star/RipperNewSound/blob/master/DreadJumpFace.mp3?raw=true"
local volume = 2
local saveName = "DreadNEW"
local part = Instance.new("Part")
part.Name = "Bound_" .. tick()
part.Parent = workspace
part.Size = Vector3.new(5, 5, 5)
part.Position = Vector3.new(0, 5, 0)
part.Anchored = true
part.Color = Color3.new(1, 0, 0)

local startSound = CustomGitSound(githubAudioUrl, volume, saveName)

if startSound then

    local isPlaying = true

    task.wait(3)
    local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local SHAKE_INTENSITY = 1
local SHAKE_DURATION = 15
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

    local function getAllParts()
        local parts = {}
        local function collectParts(object)
            for _, child in ipairs(object:GetChildren()) do
                if child:IsA("BasePart") then
                    table.insert(parts, child)
                end
                collectParts(child)
            end
        end
        collectParts(workspace)
        return parts
    end

    local allParts = getAllParts()
    
    local colorSwitchCoroutine = coroutine.create(function()
        local isBlack = true
        
        while isPlaying do

            local targetColor = isBlack and BLACK or WHITE
            isBlack = not isBlack

            for _, part in ipairs(allParts) do
                part.Color = targetColor
            end

            task.wait(0.01)
        end
    end)

    coroutine.resume(colorSwitchCoroutine)

    startSound.Ended:Connect(function()
        isPlaying = false
        startSound:Destroy()
    end)

    startSound.Stopped:Connect(function()
        isPlaying = false
        startSound:Destroy()
    end)
    
else
end
end

local ContentProvider = game:GetService("ContentProvider")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local MULTI_MONSTER_VOLUME = 2

local MULTI_MONSTER_MUSIC = {
    {
        Name = "M1",
        FileName = "MultiMonster1",
        URL = "https://github.com/Zero0Star/RipperNewSound/blob/master/MultiMonster1.mp3?raw=true"
    },
    {
        Name = "M2",
        FileName = "MultiMonster2",
        URL = "https://github.com/Zero0Star/RipperNewSound/blob/master/MultiMonster2.mp3?raw=true"
    },
    {
        Name = "M3",
        FileName = "MultiMonster3",
        URL = "https://github.com/Zero0Star/RipperNewSound/blob/master/MultiMonster3.mp3?raw=true"
    },
    {
        Name = "M4",
        FileName = "MultiMonster4",
        URL = "https://github.com/Zero0Star/RipperNewSound/blob/master/MultiMonster4.mp3?raw=true"
    }
}

local function preloadMultiMonsterMusic(info)
    local sound = workspace:FindFirstChild(info.Name)

    if sound and not sound:IsA("Sound") then
        sound:Destroy()
        sound = nil
    end

    if not sound then
        sound = Instance.new("Sound")
        sound.Name = info.Name
        sound.Parent = workspace
    end

    sound.Volume = MULTI_MONSTER_VOLUME
    sound.Looped = false

    pcall(function()
        sound:Stop()
        sound.TimePosition = 0
    end)

    local ok, err = pcall(function()
        if type(writefile) ~= "function" or type(game.HttpGet) ~= "function" then
            error("executor file/http functions unavailable")
        end

        local path = info.FileName .. ".mp3"
        writefile(path, game:HttpGet(info.URL))

        local getter = getcustomasset or getsynasset

        if not getter then
            error("getcustomasset/getsynasset unavailable")
        end

        sound.SoundId = getter(path)

        pcall(function()
            ContentProvider:PreloadAsync({sound})
        end)
    end)

    if not ok then
        warn("[MultiMonster] Failed to preload " .. info.Name .. ":", err)
    end

    return sound
end

local MULTI_MONSTER_SOUNDS = {}

for _, info in ipairs(MULTI_MONSTER_MUSIC) do
    MULTI_MONSTER_SOUNDS[info.Name] = preloadMultiMonsterMusic(info)
end

local GLITCH_CHARACTERS = {
    "#", "$", "%", "&",
    "0", "1", "3", "7",
    "/", "\\", "<", ">",
    "_", "-", "!", "?",
    "[", "]", "{", "}",
    "@", "*"
}

local function randomGlitchCharacter()
    return GLITCH_CHARACTERS[math.random(1, #GLITCH_CHARACTERS)]
end

local function corruptText(original, chance)
    local result = {}

    for i = 1, #original do
        local char = original:sub(i, i)

        if char ~= " " and math.random() < chance then
            result[#result + 1] = randomGlitchCharacter()
        else
            result[#result + 1] = char
        end
    end

    return table.concat(result)
end

local function createMultiMonsterUI()
    local player = Players.LocalPlayer

    if not player then
        return nil
    end

    local playerGui = player:WaitForChild("PlayerGui")
    local old = playerGui:FindFirstChild("MultiMonsterGlitchUI")

    if old then
        old:Destroy()
    end

    local gui = Instance.new("ScreenGui")
    gui.Name = "MultiMonsterGlitchUI"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.DisplayOrder = 999999
    gui.Parent = playerGui

    local text = Instance.new("TextLabel")
    text.Name = "GlitchText"
    text.AnchorPoint = Vector2.new(0.5, 1)
    text.Position = UDim2.new(0.5, 0, 0.88, 0)
    text.Size = UDim2.new(0.85, 0, 0, 85)
    text.BackgroundTransparency = 1
    text.Text = ""
    text.TextColor3 = Color3.fromRGB(255, 20, 20)
    text.TextStrokeColor3 = Color3.fromRGB(35, 0, 0)
    text.TextStrokeTransparency = 0.1
    text.TextSize = 32
    text.TextWrapped = true

    pcall(function()
        text.FontFace = Font.new("rbxassetid://11702779517")
    end)

    text.Parent = gui

    local timerText = Instance.new("TextLabel")
    timerText.Name = "TimerText"
    timerText.AnchorPoint = Vector2.new(0.5, 0.5)
    timerText.Position = UDim2.new(0.5, 0, -0.15, 0)
    timerText.Size = UDim2.new(0, 420, 0, 60)
    timerText.BackgroundTransparency = 1
    timerText.Text = "Time : 304"
    timerText.TextColor3 = Color3.fromRGB(255, 20, 20)
    timerText.TextStrokeColor3 = Color3.fromRGB(35, 0, 0)
    timerText.TextStrokeTransparency = 0.05
    timerText.TextSize = 30
    timerText.Visible = false

    pcall(function()
        timerText.FontFace = Font.new("rbxassetid://11702779517")
    end)

    timerText.Parent = gui

    local glitchLines = {}

    for i = 1, 7 do
        local line = Instance.new("Frame")
        line.Name = "GlitchLine_" .. i
        line.BorderSizePixel = 0
        line.BackgroundColor3 = Color3.fromRGB(math.random(180, 255), 0, 0)
        line.BackgroundTransparency = 0.55
        line.Size = UDim2.new(
            math.random(8, 35) / 100,
            0,
            0,
            math.random(1, 3)
        )
        line.Position = UDim2.new(
            math.random(5, 80) / 100,
            0,
            math.random(65, 92) / 100,
            0
        )
        line.Visible = false
        line.Parent = gui

        table.insert(glitchLines, line)
    end

    local timerLines = {}

    for i = 1, 4 do
        local line = Instance.new("Frame")
        line.Name = "TimerGlitchLine_" .. i
        line.BorderSizePixel = 0
        line.BackgroundColor3 = Color3.fromRGB(math.random(190, 255), 0, 0)
        line.BackgroundTransparency = 0.45
        line.Size = UDim2.new(0, math.random(50, 160), 0, math.random(1, 2))
        line.Position = UDim2.new(0.5, math.random(-170, 170), 0.08, math.random(-10, 10))
        line.Visible = false
        line.Parent = gui

        table.insert(timerLines, line)
    end

    return gui, text, glitchLines, timerText, timerLines
end

local function showGlitchSentence(label, lines, sentence, duration)
    if not label then
        return
    end

    local running = true
    local originalPosition = UDim2.new(0.5, 0, 0.88, 0)

    label.Text = sentence
    label.Visible = true
    label.TextTransparency = 0

    task.spawn(function()
        while running and label.Parent do
            label.Position = UDim2.new(
                0.5,
                math.random(-2, 2),
                0.88,
                math.random(-1, 1)
            )

            if math.random() < 0.26 then
                label.Text = corruptText(sentence, 0.08)
            else
                label.Text = sentence
            end

            if math.random() < 0.11 then
                label.TextTransparency = math.random(15, 50) / 100
            else
                label.TextTransparency = 0
            end

            for _, line in ipairs(lines) do
                line.Visible = math.random() < 0.11

                if line.Visible then
                    line.Position = UDim2.new(
                        math.random(8, 82) / 100,
                        0,
                        math.random(68, 92) / 100,
                        0
                    )

                    line.Size = UDim2.new(
                        math.random(8, 30) / 100,
                        0,
                        0,
                        math.random(1, 3)
                    )
                end
            end

            task.wait(math.random(4, 10) / 100)
        end
    end)

    task.wait(duration)

    running = false
    label.Text = sentence
    label.TextTransparency = 0
    label.Position = originalPosition

    for _, line in ipairs(lines) do
        line.Visible = false
    end
end

local function dropTimer(timerText)
    if not timerText then
        return
    end

    timerText.Visible = true
    timerText.Position = UDim2.new(0.38, 0, -0.18, 0)

    local points = {
        UDim2.new(0.42, 0, -0.05, 0),
        UDim2.new(0.57, 0, 0.015, 0),
        UDim2.new(0.46, 0, 0.055, 0),
        UDim2.new(0.52, 0, 0.075, 0),
        UDim2.new(0.5, 0, 0.08, 0)
    }

    local times = {
        0.12,
        0.14,
        0.12,
        0.1,
        0.1
    }

    for i, point in ipairs(points) do
        local tween = TweenService:Create(
            timerText,
            TweenInfo.new(
                times[i],
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out
            ),
            {
                Position = point
            }
        )

        tween:Play()
        tween.Completed:Wait()
    end

    timerText.Position = UDim2.new(0.5, 0, 0.08, 0)
end

local function startMultiMonsterTimer(timerText, timerLines)
    if not timerText then
        return
    end

    dropTimer(timerText)

    task.spawn(function()
        for timeLeft = 315, 0, -1 do
            if not timerText or not timerText.Parent then
                return
            end

            local normalText = "Time : " .. timeLeft
            local secondStart = os.clock()

            while os.clock() - secondStart < 1 do
                if not timerText.Parent then
                    return
                end

                timerText.Position = UDim2.new(
                    0.5,
                    math.random(-2, 2),
                    0.08,
                    math.random(-1, 1)
                )

                if math.random() < 0.3 then
                    timerText.Text = corruptText(normalText, 0.1)
                else
                    timerText.Text = normalText
                end

                if math.random() < 0.1 then
                    timerText.TextTransparency = math.random(10, 40) / 100
                else
                    timerText.TextTransparency = 0
                end

                if math.random() < 0.07 then
                    timerText.TextColor3 = Color3.fromRGB(255, 90, 90)
                else
                    timerText.TextColor3 = Color3.fromRGB(255, 20, 20)
                end

                for _, line in ipairs(timerLines or {}) do
                    line.Visible = math.random() < 0.12

                    if line.Visible then
                        line.Position = UDim2.new(
                            0.5,
                            math.random(-180, 180),
                            0.08,
                            math.random(-18, 18)
                        )

                        line.Size = UDim2.new(
                            0,
                            math.random(40, 170),
                            0,
                            math.random(1, 2)
                        )
                    end
                end

                task.wait(math.random(4, 9) / 100)
            end
        end

        if timerText and timerText.Parent then
            timerText.Text = "Time : 0"
            timerText.Position = UDim2.new(0.5, 0, 0.08, 0)
            timerText.TextTransparency = 0
            timerText.TextColor3 = Color3.fromRGB(255, 20, 20)
        end

        for _, line in ipairs(timerLines or {}) do
            line.Visible = false
        end
    end)
end

local function playSoundAndWait(sound)
    if not sound then
        return
    end

    sound:Stop()
    sound.TimePosition = 0
    sound:Play()
    sound.Ended:Wait()
end

function entityBehaviors.MultiMonster()
    local M1 = MULTI_MONSTER_SOUNDS.M1
    local M2 = MULTI_MONSTER_SOUNDS.M2
    local M3 = MULTI_MONSTER_SOUNDS.M3
    local M4 = MULTI_MONSTER_SOUNDS.M4

    if not M1 or not M2 or not M3 or not M4 then
        warn("[MultiMonster] Sounds are missing.")
        return
    end

    for _, sound in ipairs({M1, M2, M3, M4}) do
        pcall(function()
            sound:Stop()
            sound.TimePosition = 0
        end)
    end

    local gui, glitchText, glitchLines, timerText, timerLines = createMultiMonsterUI()

    M1:Play()

    task.spawn(function()
        local sentences = {
            "你来了。",
            "我不记得多少次遇到你。",
            "这很好玩吗。",
            "这很好笑吗。",
            "我讨厌这些。",
            "玩笑话总是让你开心。"
        }

        local timeout = 0

        while M1.TimeLength <= 0 and timeout < 5 do
            timeout += 0.05
            task.wait(0.05)
        end

        local totalTime = M1.TimeLength

        if totalTime <= 0 then
            totalTime = 18
        end

        local sentenceDuration = math.max(2, totalTime / #sentences)

        for _, sentence in ipairs(sentences) do
            if not M1.IsPlaying then
                break
            end

            showGlitchSentence(
                glitchText,
                glitchLines,
                sentence,
                sentenceDuration
            )
        end
    end)

    M1.Ended:Wait()

    if glitchText then
        glitchText.Text = ""
        glitchText.Visible = false
    end

    for _, line in ipairs(glitchLines or {}) do
        line.Visible = false
    end

    M2:Stop()
    M2.TimePosition = 0
    M2:Play()

    task.spawn(function()
        startMultiMonsterTimer(timerText, timerLines)
    end)

    M2.Ended:Wait()

    playSoundAndWait(M2)

    playSoundAndWait(M3)
    playSoundAndWait(M3)

    playSoundAndWait(M4)

    if gui then
        gui:Destroy()
    end
end

function entityBehaviors.LightOSs()
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

function entityBehaviors.LOOKSW()
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

local s = LoadCustomInstance(124094609630783, workspace)
if not s then
    return
end

local entity = s:FindFirstChildWhichIsA("BasePart")
entity.CFrame = GetRoom():WaitForChild("RoomEntrance").CFrame * CFrame.new(30, 1.2, -10)
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
end

local entityConfig = {
    ["rbxassetid://140338542312593"] = entityBehaviors.FigureSpawn,
    ["rbxassetid://140612367685491"] = entityBehaviors.GodOFOne,
    ["rbxassetid://140537774926087"] = entityBehaviors.GodOfTwo, 
    ["rbxassetid://140311790133562"] = entityBehaviors.GodOFThree,  
    ["rbxassetid://140083448239444"] = entityBehaviors.GodOFFour,     
    ["rbxassetid://111351357978027"] = entityBehaviors.Z367Game,     
    ["rbxassetid://8325526433"] = entityBehaviors.A60Ps1,    
    ["rbxassetid://139308622787703"] = entityBehaviors.A60PS2,       
    ["rbxassetid://140731983342235"] = entityBehaviors.A500RUN,     
    ["rbxassetid://116898205685143"] = entityBehaviors.XBramble,    
    ["rbxassetid://7298463798"] = entityBehaviors.A200,      
    ["rbxassetid://4004052860"] = entityBehaviors.AMIN60,    
    ["rbxassetid://4903742660"] = entityBehaviors.Black60,
    ["rbxassetid://3308152153"] = entityBehaviors.ForstBite,
    ["rbxassetid://138586264525744"] = entityBehaviors.INGODONE,
    ["rbxassetid://124942412759969"] = entityBehaviors.Subspace,
    ["rbxassetid://118662411300943"] = entityBehaviors.INGODTWO,
    ["rbxassetid://140736591220630"] = entityBehaviors.DELALL,
    ["rbxassetid://140721035016341"] = entityBehaviors.Smiler, 
    ["rbxassetid://140719303781203"] = entityBehaviors.WhoopDaShoop,
    ["rbxassetid://9044461391"] = entityBehaviors.WhoopDaShoopTwo,
    ["rbxassetid://18926010713"] = entityBehaviors.ChainSmoker,
    ["rbxassetid://110532875373161"] = entityBehaviors.Deergod,
    ["rbxassetid://1079408535"] = entityBehaviors.LightSpeed,
    ["rbxassetid://93679208285508"] = entityBehaviors.A200Jump,
    ["rbxassetid://96703287490096"] = entityBehaviors.HUMANSW, 
    ["rbxassetid://103515031866941"] = entityBehaviors.Cease, 
    ["rbxassetid://109318460496354"] = entityBehaviors.SHADOWSW, 
    ["rbxassetid://100192030036066"] = entityBehaviors.CL,
    ["rbxassetid://950"] = entityBehaviors.CURXT,
    ["rbxassetid://9113115842"] = entityBehaviors.Shok,
    ["rbxassetid://92260310162120"] = entityBehaviors.MLcur,
    ["rbxassetid://83742851388096"] = entityBehaviors.Bombie,
    ["rbxassetid://8307248039"] = entityBehaviors.Booom,
    ["rbxassetid://109690961059477"] = entityBehaviors.LightOSs,
    ["rbxassetid://85554051164113"] = entityBehaviors.FigureXF,
    ["rbxassetid://80450670780109"] = entityBehaviors.SuperDread,
    ["rbxassetid://140701104317815"] = entityBehaviors.DreadJump,
    ["rbxassetid://50"] = entityBehaviors.LOOKSW,
    ["rbxassetid://9999"] = entityBehaviors.SEEKEYES,
    ["rbxassetid://8888"] = entityBehaviors.HATREDJN,
    ["rbxassetid://43857"] = entityBehaviors.MultiMonster,
    ["rbxassetid://45343"] = entityBehaviors.CreakHard,
    ["rbxassetid://45344"] = entityBehaviors.CreakWhite,
    ["rbxassetid://135376180128296"] = entityBehaviors.Silence
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
-------
local hint = Instance.new("Hint", Workspace)
hint.Text = "Loading... Doors HardCore V10.5 By Mr.key & HeavenNow :)"
game.Debris:AddItem(hint, 3)