local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local FollowPlayerName = "woshiniruier"
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
