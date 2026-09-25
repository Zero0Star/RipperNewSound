local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local CONFIG = {

	MaxStamina = 100,
	SprintSpeed = 21,
	WalkSpeed = 12,
	ExhaustedSpeed = 8,
	DrainSpeed = 10.0,
	RegenSpeed = 1.9,
	ExhaustedRegenSpeed = 2,
	SprintKey = Enum.KeyCode.Q,

	NormalFOV = 70,
	SprintFOV = 80,
	FOVInTime = 0.35,
	FOVOutTime = 0.5,

	ExhaustedSoundId = "rbxassetid://8258601891",

	EffectImage = "rbxassetid://190596490",

	MobileButtonImage = "rbxassetid://111292680671790",
}

local MAIN_COLOR = Color3.fromRGB(255, 222, 189)
local LOW_COLOR = Color3.fromRGB(255, 45, 45)

local character
local humanoid

local stamina = CONFIG.MaxStamina
local isSprinting = false
local isExhausted = false
local canSprint = true

local sprintKeyDown = false
local mobileSprinting = false
local isMobile = UserInputService.TouchEnabled

local currentBarTween
local currentColorTween
local effectTween

local sprintFOVConnection
local fovTweenConnection
local fovAnimationId = 0

local MainGame

pcall(function()
	MainGame = require(
		playerGui
			:WaitForChild("MainUI")
			:WaitForChild("Initiator")
			:WaitForChild("Main_Game")
	)
end)
local staminaGui
local sprintContainer
local bar
local fill

local effectGui
local effect

local mobileGui
local sprintButton
local clickArea
local function getCamera()
	return workspace.CurrentCamera
end

local function easeOutQuad(alpha)
	return 1 - ((1 - alpha) ^ 2)
end

local function stopAllFOVControl()
	fovAnimationId += 1

	if sprintFOVConnection then
		sprintFOVConnection:Disconnect()
		sprintFOVConnection = nil
	end

	if fovTweenConnection then
		fovTweenConnection:Disconnect()
		fovTweenConnection = nil
	end
end

local function tweenFOV(fromFOV, toFOV, duration)
	local camera = getCamera()
	if not camera then
		return
	end

	stopAllFOVControl()

	fovAnimationId += 1
	local myId = fovAnimationId
	local startTime = os.clock()

	camera.FieldOfView = fromFOV

	fovTweenConnection = RunService.RenderStepped:Connect(function()
		if myId ~= fovAnimationId then
			return
		end

		local cam = getCamera()
		if not cam then
			return
		end

		local elapsed = os.clock() - startTime
		local alpha = math.clamp(elapsed / duration, 0, 1)
		local eased = easeOutQuad(alpha)

		cam.FieldOfView = fromFOV + (toFOV - fromFOV) * eased

		if alpha >= 1 then
			cam.FieldOfView = toFOV

			if fovTweenConnection then
				fovTweenConnection:Disconnect()
				fovTweenConnection = nil
			end
		end
	end)
end

local function startSprintFOV()
	local camera = getCamera()
	if not camera then
		return
	end

	stopAllFOVControl()

	local startFOV = camera.FieldOfView
	if startFOV < CONFIG.NormalFOV then
		startFOV = CONFIG.NormalFOV
	end

	tweenFOV(startFOV, CONFIG.SprintFOV, CONFIG.FOVInTime)

	task.delay(CONFIG.FOVInTime, function()
		if not isSprinting then
			return
		end

		local cam = getCamera()
		if not cam then
			return
		end

		cam.FieldOfView = CONFIG.SprintFOV

		if sprintFOVConnection then
			sprintFOVConnection:Disconnect()
		end

		sprintFOVConnection = RunService.RenderStepped:Connect(function()
			if not isSprinting then
				return
			end

			local currentCamera = getCamera()
			if currentCamera then
				currentCamera.FieldOfView = CONFIG.SprintFOV
			end
		end)
	end)
end

local function stopSprintFOV()
	local camera = getCamera()
	if not camera then
		return
	end

	if sprintFOVConnection then
		sprintFOVConnection:Disconnect()
		sprintFOVConnection = nil
	end

	if fovTweenConnection then
		fovTweenConnection:Disconnect()
		fovTweenConnection = nil
	end

	fovAnimationId += 1

	local fromFOV = camera.FieldOfView
	local myId = fovAnimationId
	local startTime = os.clock()

	fovTweenConnection = RunService.RenderStepped:Connect(function()
		if myId ~= fovAnimationId then
			return
		end

		local cam = getCamera()
		if not cam then
			return
		end

		local elapsed = os.clock() - startTime
		local alpha = math.clamp(elapsed / CONFIG.FOVOutTime, 0, 1)
		local eased = easeOutQuad(alpha)

		cam.FieldOfView = fromFOV + (CONFIG.NormalFOV - fromFOV) * eased

		if alpha >= 1 then
			cam.FieldOfView = CONFIG.NormalFOV

			if fovTweenConnection then
				fovTweenConnection:Disconnect()
				fovTweenConnection = nil
			end
		end
	end)
end

local function createUI()
	local oldStamina = playerGui:FindFirstChild("StaminaGui")
	if oldStamina then
		oldStamina:Destroy()
	end

	local oldEffect = playerGui:FindFirstChild("SprintEffectGui")
	if oldEffect then
		oldEffect:Destroy()
	end

	local oldMobile = playerGui:FindFirstChild("MobileSprintGui")
	if oldMobile then
		oldMobile:Destroy()
	end

	staminaGui = Instance.new("ScreenGui")
	staminaGui.Name = "StaminaGui"
	staminaGui.Parent = playerGui
	staminaGui.Enabled = true
	staminaGui.ResetOnSpawn = false
	staminaGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	sprintContainer = Instance.new("Frame")
	sprintContainer.Name = "Sprint"
	sprintContainer.Parent = staminaGui
	sprintContainer.AnchorPoint = Vector2.new(0, 1)
	sprintContainer.BackgroundTransparency = 1
	sprintContainer.Position = UDim2.new(0.931555569, 0, 0.987179458, 0)
	sprintContainer.Size = UDim2.new(0.0556001104, 0, 0.0756410286, 0)
	sprintContainer.ZIndex = 1005

	bar = Instance.new("Frame")
	bar.Name = "Bar"
	bar.Parent = sprintContainer
	bar.AnchorPoint = Vector2.new(1, 0.5)
	bar.Position = UDim2.new(0, 53, 0.5, 0)
	bar.Size = UDim2.new(0, 360, 0, 32)
	bar.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
	bar.BackgroundTransparency = 0.1
	bar.BorderSizePixel = 0
	bar.ZIndex = 1005

	local barCorner = Instance.new("UICorner")
	barCorner.CornerRadius = UDim.new(0, 9)
	barCorner.Parent = bar

	local barPadding = Instance.new("UIPadding")
	barPadding.Parent = bar
	barPadding.PaddingTop = UDim.new(0, 4)
	barPadding.PaddingBottom = UDim.new(0, 4)
	barPadding.PaddingLeft = UDim.new(0, 4)
	barPadding.PaddingRight = UDim.new(0, 4)

	fill = Instance.new("Frame")
	fill.Name = "Fill"
	fill.Parent = bar
	fill.AnchorPoint = Vector2.new(0, 0.5)
	fill.Position = UDim2.new(0, 0, 0.5, 0)
	fill.Size = UDim2.new(1, 0, 1, 0)
	fill.BackgroundColor3 = MAIN_COLOR
	fill.BackgroundTransparency = 0
	fill.BorderSizePixel = 0
	fill.ZIndex = 1006

	local fillCorner = Instance.new("UICorner")
	fillCorner.CornerRadius = UDim.new(0, 6)
	fillCorner.Parent = fill

	effectGui = Instance.new("ScreenGui")
	effectGui.Name = "SprintEffectGui"
	effectGui.Parent = playerGui
	effectGui.IgnoreGuiInset = true
	effectGui.ResetOnSpawn = false
	effectGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	effect = Instance.new("ImageLabel")
	effect.Name = "Effect"
	effect.Parent = effectGui
	effect.BackgroundTransparency = 1
	effect.BorderSizePixel = 0
	effect.Position = UDim2.new(0, 0, 0, 0)
	effect.Size = UDim2.new(1, 0, 1, 0)
	effect.Image = CONFIG.EffectImage
	effect.ImageColor3 = Color3.fromRGB(0, 0, 0)
	effect.ImageTransparency = 1
	effect.ZIndex = 999

	if isMobile then
		mobileGui = Instance.new("ScreenGui")
		mobileGui.Name = "MobileSprintGui"
		mobileGui.Parent = playerGui
		mobileGui.IgnoreGuiInset = true
		mobileGui.ResetOnSpawn = false
		mobileGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

		sprintButton = Instance.new("ImageLabel")
		sprintButton.Name = "SprintButton"
		sprintButton.Parent = mobileGui
		sprintButton.Size = UDim2.new(0.25, 0, 0.2, 0)
		sprintButton.Position = UDim2.new(0.8, 0, 0.25, 0)
		sprintButton.BackgroundTransparency = 1
		sprintButton.BorderSizePixel = 0
		sprintButton.Image = CONFIG.MobileButtonImage
		sprintButton.ImageColor3 = MAIN_COLOR
		sprintButton.ImageTransparency = 0
		sprintButton.ScaleType = Enum.ScaleType.Fit
		sprintButton.ZIndex = 20

		clickArea = Instance.new("TextButton")
		clickArea.Name = "ClickArea"
		clickArea.Parent = sprintButton
		clickArea.BackgroundTransparency = 1
		clickArea.BorderSizePixel = 0
		clickArea.Size = UDim2.new(1, 0, 1, 0)
		clickArea.Text = ""
		clickArea.AutoButtonColor = false
		clickArea.ZIndex = 21

		-- 手机端独立缩小体力条，电脑端保持原样
		if isMobile then
			sprintContainer.Size = UDim2.new(0.04, 0, 0.04, 0)
			bar.Size = UDim2.new(0, 220, 0, 20)
		end
	end
end
local function getStaminaColor()
	local percent = math.clamp(stamina / CONFIG.MaxStamina, 0, 1)
	return MAIN_COLOR:Lerp(LOW_COLOR, 1 - percent)
end

local function updateBar(smooth)
	if not fill then
		return
	end

	local percent = math.clamp(stamina / CONFIG.MaxStamina, 0, 1)
	local targetSize = UDim2.new(percent, 0, 1, 0)
	local targetColor = getStaminaColor()

	if currentBarTween then
		currentBarTween:Cancel()
	end

	if currentColorTween then
		currentColorTween:Cancel()
	end

	if smooth then
		currentBarTween = TweenService:Create(
			fill,
			TweenInfo.new(0.08, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
			{Size = targetSize}
		)

		currentColorTween = TweenService:Create(
			fill,
			TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{BackgroundColor3 = targetColor}
		)

		currentBarTween:Play()
		currentColorTween:Play()
	else
		fill.Size = targetSize
		fill.BackgroundColor3 = targetColor
	end
end
local function tweenEffect(transparency, duration)
	if not effect then
		return
	end

	if effectTween then
		effectTween:Cancel()
	end

	effectTween = TweenService:Create(
		effect,
		TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		{ImageTransparency = transparency}
	)

	effectTween:Play()
end

local function playExhaustedSound()
	local sound = Instance.new("Sound")
	sound.SoundId = CONFIG.ExhaustedSoundId
	sound.Volume = 0.8
	sound.PlayOnRemove = true
	sound.Parent = workspace
	sound:Destroy()
end

local function showExhaustedCaption()

	if MainGame and type(MainGame.caption) == "function" then
		pcall(function()
			MainGame.caption("我需要短暂休息...", true)
		end)
		return
	end

	pcall(function()
		if firesignal then
			firesignal(
				game.ReplicatedStorage.Bricks.Caption.OnClientEvent,
				"You're exhausted."
			)
		end
	end)
end

local function setupCharacter(newCharacter)
	character = newCharacter
	humanoid = newCharacter:WaitForChild("Humanoid")

	stamina = CONFIG.MaxStamina
	isSprinting = false
	isExhausted = false
	canSprint = true
	sprintKeyDown = false
	mobileSprinting = false

	stopAllFOVControl()

	local camera = getCamera()
	if camera then
		camera.FieldOfView = CONFIG.NormalFOV
	end

	humanoid:SetAttribute("SpeedBoost", 0)
	humanoid.WalkSpeed = CONFIG.WalkSpeed

	if effect then
		effect.ImageTransparency = 1
	end

	updateBar(false)
end
local function canStartSprint()
	if not canSprint or isExhausted or isSprinting then
		return false
	end

	if not humanoid or not humanoid.Parent then
		return false
	end

	if stamina <= 0 then
		return false
	end

	return true
end

local function startSprint()
	if not canStartSprint() then
		return
	end

	isSprinting = true

	humanoid:SetAttribute("SpeedBoost", CONFIG.SprintSpeed - CONFIG.WalkSpeed)
	humanoid.WalkSpeed = CONFIG.SprintSpeed

	startSprintFOV()

	tweenEffect(0.15, 0.35)

	if sprintButton then
		TweenService:Create(
			sprintButton,
			TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{ImageTransparency = 0.15}
		):Play()
	end
end

local function stopSprint()
	if not isSprinting then
		return
	end

	isSprinting = false

	stopSprintFOV()

	if humanoid and humanoid.Parent then
		humanoid:SetAttribute("SpeedBoost", 0)

		if isExhausted then
			humanoid.WalkSpeed = CONFIG.ExhaustedSpeed
		else
			humanoid.WalkSpeed = CONFIG.WalkSpeed
		end
	end

	if not isExhausted then
		tweenEffect(1, 0.7)
	end

	if sprintButton then
		TweenService:Create(
			sprintButton,
			TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{ImageTransparency = 0}
		):Play()
	end
end

local function enterExhausted()
	if isExhausted then
		return
	end

	isExhausted = true
	canSprint = false
	isSprinting = false
	sprintKeyDown = false
	mobileSprinting = false
	stamina = 0

	updateBar(true)

	if humanoid and humanoid.Parent then
		humanoid:SetAttribute("SpeedBoost", 0)
		humanoid.WalkSpeed = CONFIG.ExhaustedSpeed
	end

	stopSprintFOV()
	showExhaustedCaption()
	playExhaustedSound()

	tweenEffect(0, 0.25)

	task.delay(0.25, function()
		if isExhausted then
			tweenEffect(1, 10)
		end
	end)

	if sprintButton then
		TweenService:Create(
			sprintButton,
			TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{ImageTransparency = 0.45}
		):Play()
	end
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then
		return
	end

	if input.KeyCode == CONFIG.SprintKey then
		sprintKeyDown = true
		startSprint()
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.KeyCode ~= CONFIG.SprintKey then
		return
	end

	sprintKeyDown = false

	if isSprinting then
		stopSprint()
	end
end)
local function bindMobileButton()
	if not isMobile or not clickArea then
		return
	end

	clickArea.MouseButton1Down:Connect(function()
		if isExhausted then
			return
		end

		mobileSprinting = true
		startSprint()
	end)

	clickArea.MouseButton1Up:Connect(function()
		mobileSprinting = false

		if isSprinting then
			stopSprint()
		end
	end)

	clickArea.MouseLeave:Connect(function()
		if mobileSprinting then
			mobileSprinting = false

			if isSprinting then
				stopSprint()
			end
		end
	end)
end
RunService.RenderStepped:Connect(function(dt)
	if not humanoid or not humanoid.Parent then
		return
	end

	local wantsSprint = sprintKeyDown or mobileSprinting

	if isSprinting and wantsSprint and not isExhausted then

		stamina = math.max(stamina - CONFIG.DrainSpeed * dt, 0)
		updateBar(true)

		if stamina <= 0 then
			enterExhausted()
		end
	else
		if isSprinting and not wantsSprint then
			stopSprint()
		end

		if stamina < CONFIG.MaxStamina then
			if isExhausted then

				stamina = math.min(
					stamina + CONFIG.ExhaustedRegenSpeed * dt,
					CONFIG.MaxStamina
				)
			else

				stamina = math.min(
					stamina + CONFIG.RegenSpeed * dt,
					CONFIG.MaxStamina
				)
			end

			updateBar(true)
		end

		if isExhausted and stamina >= CONFIG.MaxStamina then
			stamina = CONFIG.MaxStamina
			isExhausted = false
			canSprint = true

			humanoid.WalkSpeed = CONFIG.WalkSpeed
			tweenEffect(1, 1)

			if sprintButton then
				TweenService:Create(
					sprintButton,
					TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{ImageTransparency = 0}
				):Play()
			end
		end
	end
end)

createUI()
bindMobileButton()

setupCharacter(player.Character or player.CharacterAdded:Wait())

player.CharacterAdded:Connect(function(newCharacter)
	task.wait()
	setupCharacter(newCharacter)
end)

return {
	GetStamina = function()
		return stamina
	end,

	GetMaxStamina = function()
		return CONFIG.MaxStamina
	end,

	IsSprinting = function()
		return isSprinting
	end,

	IsExhausted = function()
		return isExhausted
	end,
}