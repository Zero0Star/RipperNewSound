local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Remotes = ReplicatedStorage:WaitForChild("RemotesFolder")
local BeginDeathAudio = function() end

local DeathTypes = {
	["Yellow"] = {"yellow", "curious"},
	["Blue"] = {"blue", "guiding"}
}

local function DeathHint(hints, deathType)
	if typeof(hints) ~= "table" or #hints == 0 then
		return
	end

	local MainUI = PlayerGui:WaitForChild("MainUI")
	local Death = MainUI:WaitForChild("Death")

	BeginDeathAudio()

	Death:GetPropertyChangedSignal("Visible"):Wait()

	deathType = tostring(deathType or "Guiding"):lower()

	local colour

	for name, values in next, DeathTypes do
		if table.find(values, deathType) then
			colour = name
			break
		end
	end

	if not colour then
		local MainGame = MainUI:WaitForChild("Initiator"):WaitForChild("Main_Game")
		local Health = MainGame:WaitForChild("Health")
		local Music = Health:WaitForChild("Music")

		for _, c in next, Music:GetChildren() do
			if c.Name:lower() == deathType then
				colour = c.Name
				break
			end
		end
	end

	colour = colour or "Blue"

	if firesignal then
		firesignal(
			Remotes.DeathHint.OnClientEvent,
			hints,
			colour
		)
	end
end

local Camera = workspace.CurrentCamera

local deathActive = true
local endingInProgress = false
local stopDeath = function() end

local function HasDeathBackground()
	return Camera:FindFirstChild("DeathBackgroundBlue", true) ~= nil
end

local function LockDeath()
	if not deathActive then
		return
	end

	deathActive = false
	stopDeath()
end

Camera.DescendantRemoving:Connect(function(child)
	if child:IsA("Model") and child.Name == "DeathBackgroundBlue" then
		task.defer(function()
			if not HasDeathBackground() then
				LockDeath()
			end
		end)
	end
end)

local processed = {}

local function Process(model)
	if not model:IsA("Model") or model.Name ~= "DeathBackgroundBlue" then
		return
	end

	if processed[model] then
		return
	end

	local lights = model:FindFirstChild("Lights")
	if not lights then return end

	local bigLight = lights:FindFirstChild("BigLight")
	if not bigLight or not bigLight:IsA("BasePart") then return end

	processed[model] = true

	local clone = bigLight:Clone()
	clone.Name = "moon"
	clone.CFrame = bigLight.CFrame * CFrame.new(-125, -46, 0)
	clone.Parent = lights

	local yellowClone = bigLight:Clone()
	yellowClone.Name = "sun"
	yellowClone.CFrame = bigLight.CFrame * CFrame.new(125, -46, 0)
	yellowClone.Parent = lights

	bigLight.CFrame = bigLight.CFrame * CFrame.new(0, -25, 0)

	for _, obj in {bigLight, clone, yellowClone} do
	obj.Size = obj.Size * 3

	for _, v in obj:GetDescendants() do
		if v:IsA("BasePart") then
			v.Size = v.Size * 3

		elseif v:IsA("ParticleEmitter") then
			local keypoints = {}

			for _, keypoint in v.Size.Keypoints do
				table.insert(keypoints, NumberSequenceKeypoint.new(
					keypoint.Time,
					keypoint.Value * 3,
					keypoint.Envelope * 3
				))
			end

			v.Size = NumberSequence.new(keypoints)
		end
	end
end

	for _, v in bigLight:GetDescendants() do
		if v:IsA("ParticleEmitter") then
			local keypoints = {}

			for _, keypoint in v.Color.Keypoints do
				local _, s, brightness = keypoint.Value:ToHSV()

				table.insert(keypoints, ColorSequenceKeypoint.new(
					keypoint.Time,
					Color3.fromHSV(0, s, brightness)
				))
			end

			v.Color = ColorSequence.new(keypoints)

			if v.Name == "Moon" then
				v.Texture = "rbxassetid://118944869528793"
			end

		elseif v:IsA("PointLight")
			or v:IsA("SpotLight")
			or v:IsA("SurfaceLight") then

			local _, s, brightness = v.Color:ToHSV()
			v.Color = Color3.fromHSV(0, s, brightness)
		end
	end

	local _, s, brightness = bigLight.Color:ToHSV()
	bigLight.Color = Color3.fromHSV(0, s, brightness)

	for _, v in yellowClone:GetDescendants() do
		if v:IsA("ParticleEmitter") then
			local keypoints = {}

			for _, keypoint in v.Color.Keypoints do
				local _, s, brightness = keypoint.Value:ToHSV()

				table.insert(keypoints, ColorSequenceKeypoint.new(
					keypoint.Time,
					Color3.fromHSV(60 / 360, s, brightness)
				))
			end

			v.Color = ColorSequence.new(keypoints)

			if v.Name == "Moon" then
				v.Texture = "rbxassetid://86241508648783"
			end

		elseif v:IsA("PointLight")
			or v:IsA("SpotLight")
			or v:IsA("SurfaceLight") then

			local _, s, brightness = v.Color:ToHSV()
			v.Color = Color3.fromHSV(60 / 360, s, brightness)
		end
	end

	local _, ys, ybrightness = yellowClone.Color:ToHSV()
	yellowClone.Color = Color3.fromHSV(60 / 360, ys, ybrightness)

	local parts = {}

	for _, v in lights:GetChildren() do
		if v:IsA("BasePart") and v.Name == "Part" then
			table.insert(parts, v)
		end
	end

	if #parts == 3 then
		local spot1 = parts[1]:FindFirstChildWhichIsA("SpotLight")
		if spot1 then
			spot1.Color = Color3.fromRGB(130, 211, 255)
		end

		local spot2 = parts[2]:FindFirstChildWhichIsA("SpotLight")
		if spot2 then
			local _, s, brightness = spot2.Color:ToHSV()
			spot2.Color = Color3.fromHSV(60 / 360, s, brightness)
		end

		local spot3 = parts[3]:FindFirstChildWhichIsA("SpotLight")
		if spot3 then
			local _, s, brightness = spot3.Color:ToHSV()
			spot3.Color = Color3.fromHSV(0, s, brightness)
		end
	end

	local fog = model:FindFirstChild("FogAndSmaller")

	if fog and fog:IsA("BasePart") then
		local fogClone = fog:Clone()
		fogClone.CFrame = fog.CFrame * CFrame.new(-30,0,0)
		fogClone.Size = fog.Size
		fogClone.Parent = fog.Parent

		local yellowFogClone = fog:Clone()
		yellowFogClone.Name = "FogAndSmallerYellow"
		yellowFogClone.CFrame = fog.CFrame * CFrame.new(30,0,0)
		yellowFogClone.Size = fog.Size
		yellowFogClone.Parent = fog.Parent

		for _, fogPart in {fog, fogClone, yellowFogClone} do
	for _, v in fogPart:GetDescendants() do
		if v:IsA("ParticleEmitter") then
			local keypoints = {}

			for _, keypoint in v.Size.Keypoints do
				table.insert(keypoints, NumberSequenceKeypoint.new(
					keypoint.Time,
					keypoint.Value * 1.7,
					keypoint.Envelope * 1.7
				))
			end

			v.Size = NumberSequence.new(keypoints)
		end
	end
end

fogClone:GetPropertyChangedSignal("Size"):Connect(function()
	if fogClone.Size ~= fog.Size then
		fogClone.Size = fog.Size
	end
end)

yellowFogClone:GetPropertyChangedSignal("Size"):Connect(function()
	if yellowFogClone.Size ~= fog.Size then
		yellowFogClone.Size = fog.Size
	end
end)

		for _, v in fog:GetDescendants() do
			if v:IsA("BasePart") then
				local _, s, brightness = v.Color:ToHSV()
				v.Color = Color3.fromHSV(0, s, brightness)

			elseif v:IsA("ParticleEmitter") then
				local keypoints = {}

				for _, keypoint in v.Color.Keypoints do
					local _, s, brightness = keypoint.Value:ToHSV()

					table.insert(keypoints, ColorSequenceKeypoint.new(
						keypoint.Time,
						Color3.fromHSV(0, s, brightness)
					))
				end

				v.Color = ColorSequence.new(keypoints)

			elseif v:IsA("PointLight")
				or v:IsA("SpotLight")
				or v:IsA("SurfaceLight") then

				local _, s, brightness = v.Color:ToHSV()
				v.Color = Color3.fromHSV(0, s, brightness)
			end
		end

		for _, v in yellowFogClone:GetDescendants() do
			if v:IsA("BasePart") then
				local _, s, brightness = v.Color:ToHSV()
				v.Color = Color3.fromHSV(60 / 360, s, brightness)

			elseif v:IsA("ParticleEmitter") then
				local keypoints = {}

				for _, keypoint in v.Color.Keypoints do
					local _, s, brightness = keypoint.Value:ToHSV()

					table.insert(keypoints, ColorSequenceKeypoint.new(
						keypoint.Time,
						Color3.fromHSV(60 / 360, s, brightness)
					))
				end

				v.Color = ColorSequence.new(keypoints)

			elseif v:IsA("PointLight")
				or v:IsA("SpotLight")
				or v:IsA("SurfaceLight") then

				local _, s, brightness = v.Color:ToHSV()
				v.Color = Color3.fromHSV(60 / 360, s, brightness)
			end
		end
	end
end

Camera.DescendantAdded:Connect(function(instance)
	if instance.Name == "DeathBackgroundBlue" then
		Process(instance)
	end
end)

local existing = Camera:FindFirstChild("DeathBackgroundBlue")
if existing then
	Process(existing)
end

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local MainUI = PlayerGui:WaitForChild("MainUI")
local MainGame = MainUI:WaitForChild("Initiator"):WaitForChild("Main_Game")
local Health = MainGame:WaitForChild("Health")
local Music = Health:WaitForChild("Music")

local function GetGitSound(GithubSnd, SoundName)
	local url = GithubSnd
	if not isfile(SoundName .. ".mp3") then
		writefile(SoundName .. ".mp3", game:HttpGet(url))
	end
	local sound = Instance.new("Sound")
	sound.SoundId = (getcustomasset or getsynasset)(SoundName .. ".mp3")
	return sound
end

local blueSound = Music:WaitForChild("Blue")
local originalBlueSoundId = blueSound.SoundId
local originalBluePlaybackSpeed = blueSound.PlaybackSpeed
local originalBlueVolume = blueSound.Volume
local originalBluePlaying = blueSound.Playing
local gitSoundTemp = GetGitSound("https://github.com/lynguyen26031993-design/-u/raw/refs/heads/main/Lhouijie%20Almendras%20-%20theme%203%20atchitects%20-%201786262801229%202026-08-09%2012_06.mp3?raw=true", "vjjdjjjfjhh")

blueSound.SoundId = gitSoundTemp.SoundId
blueSound.PlaybackSpeed = 1
blueSound.Volume = 2

gitSoundTemp:Destroy()

local storedVolumes = {}
local volumeConnections = {}
local workspaceAudioConnection
local musicAudioConnection
local deathAudioStarted = false
local deathAudioRestored = false

local function ShouldMuteAudio(instance)
	return instance:IsA("Sound")
		and instance ~= blueSound
		and (instance:IsDescendantOf(workspace) or instance:IsDescendantOf(Music))
end

local function MuteAudio(instance)
	if not deathAudioStarted or not ShouldMuteAudio(instance) or storedVolumes[instance] ~= nil then
		return
	end

	storedVolumes[instance] = instance.Volume
	volumeConnections[instance] = instance:GetPropertyChangedSignal("Volume"):Connect(function()
		if deathAudioStarted and ShouldMuteAudio(instance) and instance.Volume ~= 0 then
			instance.Volume = 0
		end
	end)
	instance.Volume = 0
end

local function RestoreDeathAudio()
	if not deathAudioStarted then
		return
	end

	deathAudioStarted = false
	deathAudioRestored = true

	if workspaceAudioConnection then
		workspaceAudioConnection:Disconnect()
		workspaceAudioConnection = nil
	end

	if musicAudioConnection then
		musicAudioConnection:Disconnect()
		musicAudioConnection = nil
	end

	for _, connection in pairs(volumeConnections) do
		connection:Disconnect()
	end
	table.clear(volumeConnections)

	for sound, originalVolume in pairs(storedVolumes) do
		if sound.Parent then
			sound.Volume = originalVolume
		end
	end
	table.clear(storedVolumes)

	blueSound:Stop()
	blueSound.SoundId = originalBlueSoundId
	blueSound.PlaybackSpeed = originalBluePlaybackSpeed
	blueSound.Volume = originalBlueVolume
	if originalBluePlaying then
		blueSound:Play()
	end
end

BeginDeathAudio = function()
	if deathAudioStarted or deathAudioRestored then
		return
	end

	deathAudioStarted = true

	for _, instance in ipairs(workspace:GetDescendants()) do
		MuteAudio(instance)
	end

	for _, instance in ipairs(Music:GetDescendants()) do
		MuteAudio(instance)
	end

	workspaceAudioConnection = workspace.DescendantAdded:Connect(MuteAudio)
	musicAudioConnection = Music.DescendantAdded:Connect(MuteAudio)

	if not blueSound.Playing then
		blueSound:Play()
	end
end


local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local Camera = workspace:WaitForChild("Camera")

local function IsDeathBackground(obj)
	return obj:IsA("Model") and obj.Name == "DeathBackgroundBlue"
end

local function RunScript()
	if not deathActive or not HasDeathBackground() then
		return
	end

Camera.FieldOfView = 120

Camera:GetPropertyChangedSignal("FieldOfView"):Connect(function()
	Camera.FieldOfView = 120
end)

	local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

local Gui = Instance.new("ScreenGui")
Gui.Name = "DeathTextGui"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = true
Gui.DisplayOrder = 999999
Gui.Parent = PlayerGui

local GuidingText = Instance.new("TextLabel")
GuidingText.Name = "GuidingText"
GuidingText.AnchorPoint = Vector2.new(0.5, 0.5)
GuidingText.Position = UDim2.new(0.55, -250, 0.39, 0)
GuidingText.Size = UDim2.fromOffset(900, 250)
GuidingText.BackgroundTransparency = 1
GuidingText.BorderSizePixel = 0
GuidingText.Visible = false
GuidingText.ZIndex = 999999
GuidingText.Font = Enum.Font.Oswald
GuidingText.TextColor3 = Color3.fromRGB(158, 239, 255)
GuidingText.TextSize = 33
GuidingText.TextWrapped = true
GuidingText.TextScaled = false
GuidingText.TextXAlignment = Enum.TextXAlignment.Center
GuidingText.TextYAlignment = Enum.TextYAlignment.Center
GuidingText.TextTransparency = 0
GuidingText.Parent = Gui

local MisText = Instance.new("TextLabel")
MisText.Name = "MisText"
MisText.AnchorPoint = Vector2.new(0.5, 0.5)
MisText.Position = UDim2.new(0.81, -250, 0.45, 0)
MisText.Size = UDim2.fromOffset(900, 250)
MisText.BackgroundTransparency = 1
MisText.BorderSizePixel = 0
MisText.Visible = false
MisText.ZIndex = 999999
MisText.Font = Enum.Font.Oswald
MisText.TextColor3 = Color3.fromRGB(255, 92, 92)
MisText.TextSize = 33
MisText.TextWrapped = true
MisText.TextScaled = false
MisText.TextXAlignment = Enum.TextXAlignment.Center
MisText.TextYAlignment = Enum.TextYAlignment.Center
MisText.TextTransparency = 0
MisText.Parent = Gui

local CuriousText = Instance.new("TextLabel")
CuriousText.Name = "CuriousText"
CuriousText.AnchorPoint = Vector2.new(0.5, 0.5)
CuriousText.Position = UDim2.new(1.1, -250, 0.39, 0)
CuriousText.Size = UDim2.fromOffset(900, 250)
CuriousText.BackgroundTransparency = 1
CuriousText.BorderSizePixel = 0
CuriousText.Visible = false
CuriousText.ZIndex = 999999
CuriousText.Font = Enum.Font.Oswald
CuriousText.TextColor3 = Color3.fromRGB(255, 239, 158)
CuriousText.TextSize = 33
CuriousText.TextWrapped = true
CuriousText.TextScaled = false
CuriousText.TextXAlignment = Enum.TextXAlignment.Center
CuriousText.TextYAlignment = Enum.TextYAlignment.Center
CuriousText.TextTransparency = 0
CuriousText.Parent = Gui


local function StartGuidingAnimation()
	task.spawn(function()
		while GuidingText and GuidingText.Parent do
			local tween1 = TweenService:Create(GuidingText, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Rotation = 2})
			tween1:Play()
			tween1.Completed:Wait()
			if not GuidingText or not GuidingText.Parent then break end

			local tween2 = TweenService:Create(GuidingText, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Rotation = -2})
			tween2:Play()
			tween2.Completed:Wait()
		end
	end)
end

local guidingVersion = 0
local guidingTween
local function TypeGuiding(text)
	if not deathActive or not HasDeathBackground() then
		return
	end

	guidingVersion += 1
	local currentVersion = guidingVersion
	if guidingTween then guidingTween:Cancel() guidingTween = nil end

	GuidingText.Visible = true
	GuidingText.TextTransparency = 0
	GuidingText.Text = ""

	local words = {}
	for word in text:gmatch("%S+") do table.insert(words, word) end
	local lines, line = {}, {}
	for _, word in ipairs(words) do
		table.insert(line, word)
		if #line == 6 then table.insert(lines, table.concat(line, " ")); line = {} end
	end
	if #line > 0 then table.insert(lines, table.concat(line, " ")) end
	local formattedText = table.concat(lines, "\n")

	for i = 1, #formattedText do
		if not deathActive or not HasDeathBackground() or currentVersion ~= guidingVersion then
	return
end
		GuidingText.Text = formattedText:sub(1, i)
		task.wait(0.02)
	end

	local cooldownEnd = os.clock() + 5
	while os.clock() < cooldownEnd do
		if currentVersion ~= guidingVersion then return end
		task.wait()
	end
	if currentVersion ~= guidingVersion then return end

	guidingTween = TweenService:Create(GuidingText, TweenInfo.new(1, Enum.EasingStyle.Linear), {TextTransparency = 1})
	guidingTween:Play()
	while guidingTween.PlaybackState == Enum.PlaybackState.Playing do
		if currentVersion ~= guidingVersion then
			guidingTween:Cancel() guidingTween = nil
			GuidingText.TextTransparency = 0
			GuidingText.Visible = false
			return
		end
		task.wait()
	end
	if currentVersion == guidingVersion then
		guidingTween = nil
		GuidingText.Text = ""
		GuidingText.Visible = false
	end
end


local function StartMisAnimation()
	task.spawn(function()
		while MisText and MisText.Parent do
			local tween1 = TweenService:Create(MisText, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Rotation = 2})
			tween1:Play()
			tween1.Completed:Wait()
			if not MisText or not MisText.Parent then break end

			local tween2 = TweenService:Create(MisText, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Rotation = -2})
			tween2:Play()
			tween2.Completed:Wait()
		end
	end)
end

local misVersion = 0
local misTween
local function TypeMis(text)
	if not deathActive or not HasDeathBackground() then
		return
	end

	misVersion += 1
	local currentVersion = misVersion
	if misTween then misTween:Cancel() misTween = nil end

	MisText.Visible = true
	MisText.TextTransparency = 0
	MisText.Text = ""

	local words = {}
	for word in text:gmatch("%S+") do table.insert(words, word) end
	local lines, line = {}, {}
	for _, word in ipairs(words) do
		table.insert(line, word)
		if #line == 6 then table.insert(lines, table.concat(line, " ")); line = {} end
	end
	if #line > 0 then table.insert(lines, table.concat(line, " ")) end
	local formattedText = table.concat(lines, "\n")

	for i = 1, #formattedText do
		if not deathActive or not HasDeathBackground() or currentVersion ~= misVersion then
	return
end
		MisText.Text = formattedText:sub(1, i)
		task.wait(0.02)
	end

	local cooldownEnd = os.clock() + 5
	while os.clock() < cooldownEnd do
		if currentVersion ~= misVersion then return end
		task.wait()
	end
	if currentVersion ~= misVersion then return end

	misTween = TweenService:Create(MisText, TweenInfo.new(1, Enum.EasingStyle.Linear), {TextTransparency = 1})
	misTween:Play()
	while misTween.PlaybackState == Enum.PlaybackState.Playing do
		if currentVersion ~= misVersion then
			misTween:Cancel() misTween = nil
			MisText.TextTransparency = 0
			MisText.Visible = false
			return
		end
		task.wait()
	end
	if currentVersion == misVersion then
		misTween = nil
		MisText.Text = ""
		MisText.Visible = false
	end
end


local function StartCuriousAnimation()
	task.spawn(function()
		while CuriousText and CuriousText.Parent do
			local tween1 = TweenService:Create(CuriousText, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Rotation = 2})
			tween1:Play()
			tween1.Completed:Wait()
			if not CuriousText or not CuriousText.Parent then break end

			local tween2 = TweenService:Create(CuriousText, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Rotation = -2})
			tween2:Play()
			tween2.Completed:Wait()
		end
	end)
end

local curiousVersion = 0
local curiousTween
local function TypeCurious(text)
	if not deathActive or not HasDeathBackground() then
		return
	end

	curiousVersion += 1
	local currentVersion = curiousVersion
	if curiousTween then curiousTween:Cancel() curiousTween = nil end

	CuriousText.Visible = true
	CuriousText.TextTransparency = 0
	CuriousText.Text = ""

	local words = {}
	for word in text:gmatch("%S+") do table.insert(words, word) end
	local lines, line = {}, {}
	for _, word in ipairs(words) do
		table.insert(line, word)
		if #line == 6 then table.insert(lines, table.concat(line, " ")); line = {} end
	end
	if #line > 0 then table.insert(lines, table.concat(line, " ")) end
	local formattedText = table.concat(lines, "\n")

	for i = 1, #formattedText do
		if not deathActive or not HasDeathBackground() or currentVersion ~= curiousVersion then
	return
end
		CuriousText.Text = formattedText:sub(1, i)
		task.wait(0.02)
	end

	local cooldownEnd = os.clock() + 5
	while os.clock() < cooldownEnd do
		if currentVersion ~= curiousVersion then return end
		task.wait()
	end
	if currentVersion ~= curiousVersion then return end

	curiousTween = TweenService:Create(CuriousText, TweenInfo.new(1, Enum.EasingStyle.Linear), {TextTransparency = 1})
	curiousTween:Play()
	while curiousTween.PlaybackState == Enum.PlaybackState.Playing do
		if currentVersion ~= curiousVersion then
			curiousTween:Cancel() curiousTween = nil
			CuriousText.TextTransparency = 0
			CuriousText.Visible = false
			return
		end
		task.wait()
	end
	if currentVersion == curiousVersion then
		curiousTween = nil
		CuriousText.Text = ""
		CuriousText.Visible = false
	end
end

stopDeath = function()
	guidingVersion += 1
	misVersion += 1
	curiousVersion += 1

	if guidingTween then
		guidingTween:Cancel()
		guidingTween = nil
	end

	if misTween then
		misTween:Cancel()
		misTween = nil
	end

	if curiousTween then
		curiousTween:Cancel()
		curiousTween = nil
	end

	if GuidingText then
		GuidingText:Destroy()
	end

	if MisText then
		MisText:Destroy()
	end

	if CuriousText then
		CuriousText:Destroy()
	end

	if Gui then
		Gui:Destroy()
	end

	if not endingInProgress then
		RestoreDeathAudio()
	end
end


StartGuidingAnimation()
StartMisAnimation()
StartCuriousAnimation()

local r = math.random(1,3)

if r == 1 then
task.wait(4)
if not deathActive or not HasDeathBackground() then return end

task.spawn(TypeGuiding, "You're back. I'm sorry.. we watched the whole thing.")

task.wait(4)
if not deathActive or not HasDeathBackground() then return end

task.spawn(TypeGuiding, "Whatever that was.. it clearly wasn't itself. It were Ripper.. then it wasn't Ripper.")

task.wait(4)
if not deathActive or not HasDeathBackground() then return end

task.spawn(TypeGuiding, "It has no shape of its own. It borrows. It mimics..")

task.wait(3.5)
if not deathActive or not HasDeathBackground() then return end

task.spawn(TypeCurious, "Nothing in my records matches it. Nothing. That never happens.")

task.wait(5)
if not deathActive or not HasDeathBackground() then return end

task.spawn(TypeCurious, "Give me time. I'll dig. Next time we speak. I'll know more.")

task.wait(4)
if not deathActive or not HasDeathBackground() then return end

task.spawn(TypeMis, "...are you hurt?")

task.wait(3.5)
if not deathActive or not HasDeathBackground() then return end

task.spawn(TypeMis, "I don't understand this one. I don't like NOT understanding.")

task.wait(4)
if not deathActive or not HasDeathBackground() then return end

task.spawn(TypeGuiding, "Stay near the others. And keep your eyes off it when you can.")
elseif r == 2 then

task.wait(4)
if not deathActive or not HasDeathBackground() then return end

task.spawn(TypeCurious, "Still cataloguing. It refuses to stay one thing long enough to")

task.wait(4)
if not deathActive or not HasDeathBackground() then return end

task.spawn(TypeGuiding, "Then don't name it. Outlast it. ")

task.wait(6)
if not deathActive or not HasDeathBackground() then return end

task.spawn(TypeMis, "I almost had it. For a second, I had it.")

task.wait(5)
if not deathActive or not HasDeathBackground() then return end

task.spawn(TypeGuiding, "There was nothing more we could do from here.")

task.wait(5)
if not deathActive or not HasDeathBackground() then return end

task.spawn(TypeMis, "Next run. Next run I will be faster.")
task.wait(7)
elseif r == 3 then
task.wait(4)
if not deathActive or not HasDeathBackground() then return end

task.spawn(TypeCurious, "Every copy it wears is slightly wrong.")

task.wait(6)
if not deathActive or not HasDeathBackground() then return end

task.spawn(TypeGuiding, "If something feels wrong, treat it as")

task.wait(6)
if not deathActive or not HasDeathBackground() then return end

task.spawn(TypeMis, "Or just run. Running also works. ")

task.wait(6)
if not deathActive or not HasDeathBackground() then return end

task.spawn(TypeGuiding, "We'll be watching. We always are. ")
task.wait(7)
end

endingInProgress = true

local Players = game:GetService("Players")
local gui2 = Instance.new("ScreenGui")
gui2.Name = "ImageGui"
gui2.IgnoreGuiInset = true
gui2.ResetOnSpawn = false
gui2.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")

local image2 = Instance.new("ImageLabel")
image2.Size = UDim2.fromScale(1, 1)
image2.Position = UDim2.fromScale(0, 0)
image2.BackgroundTransparency = 1
image2.Image = "rbxassetid://72568867702176"
image2.ScaleType = Enum.ScaleType.Stretch
image2.Parent = gui2
image2.ZIndex = 999999
image2.Visible = false

task.wait(8)
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

local gui = Instance.new("ScreenGui")
gui.Name = "ImageFade"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")

local image = Instance.new("ImageLabel")
image.Size = UDim2.fromScale(1, 1)
image.Position = UDim2.fromScale(0, 0)
image.BackgroundTransparency = 1
image.Image = "rbxassetid://116600254264450"
image.ImageTransparency = 1
image.ZIndex = 999998
image.ScaleType = Enum.ScaleType.Stretch
image.Parent = gui

local running = true

task.spawn(function()
	while running do
		task.wait(0.3)
		if not running then break end
		image.Image = "rbxassetid://125298203990706"

		task.wait(0.3)
		if not running then break end
		image.Image = "rbxassetid://116600254264450"
	end
end)

local tween = TweenService:Create(
	image,
	TweenInfo.new(4, Enum.EasingStyle.Linear),
	{ImageTransparency = 0}
)

task.delay(3.3, function()
	local ended = Instance.new("Sound")
	ended.SoundId = "rbxassetid://96377507894391"
	ended.Volume = 3
	ended.TimePosition = 0.2
	ended.Parent = workspace
	ended:Play()

	local startedAt = os.clock()
	task.spawn(function()
		while ended.Parent do
			if ended.TimeLength > 0 and ended.TimeLength - ended.TimePosition <= 1 then
				break
			end
			if os.clock() - startedAt >= 12 then
				break
			end
			task.wait(0.1)
		end

		if image2.Parent then
			image2.Visible = true
		end
		task.wait(1)

		gui:Destroy()
		gui2:Destroy()

		local blackGui = Instance.new("ScreenGui")
		blackGui.Name = "BlackFade"
		blackGui.IgnoreGuiInset = true
		blackGui.ResetOnSpawn = false
		blackGui.Parent = PlayerGui

		local frame = Instance.new("Frame")
		frame.Size = UDim2.fromScale(1, 1)
		frame.Position = UDim2.fromScale(0, 0)
		frame.BackgroundColor3 = Color3.new(0, 0, 0)
		frame.BorderSizePixel = 0
		frame.Parent = blackGui

		task.wait(2)

		local blackFade = TweenService:Create(
			frame,
			TweenInfo.new(3, Enum.EasingStyle.Linear),
			{BackgroundTransparency = 1}
		)
		blackFade:Play()
		blackFade.Completed:Wait()

		ended:Stop()
		ended:Destroy()
		blackGui:Destroy()
		RestoreDeathAudio()
	end)
end)

tween:Play()
tween.Completed:Wait()

running = false
end

local triggered = false
local connection

local function Trigger()
	if triggered or not deathActive or not HasDeathBackground() then
		return
	end

	triggered = true
	BeginDeathAudio()
	task.spawn(DeathHint, {"", "", "", "", "", "", "", ""}, "Guiding")

	if connection then
		connection:Disconnect()
		connection = nil
	end

	RunScript()
end

for _, obj in ipairs(Camera:GetDescendants()) do
	if IsDeathBackground(obj) then
		Trigger()
		break
	end
end

if not triggered then
	connection = Camera.DescendantAdded:Connect(function(obj)
		if IsDeathBackground(obj) then
			Trigger()
		end
	end)
end

