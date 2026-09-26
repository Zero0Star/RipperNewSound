local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local targetPlayerName = "goat_qiu"
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
