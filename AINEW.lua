local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local function applyFlipToAll()
	for _, player in ipairs(Players:GetPlayers()) do
		local char = player.Character
		if char and char:FindFirstChild("HumanoidRootPart") then
			local root = char.HumanoidRootPart
			root.CFrame = CFrame.new(root.Position) * CFrame.Angles(math.pi, 0, 0)
		end
	end
end

RunService.Heartbeat:Connect(applyFlipToAll)

local function playSound(id, vol, speed)
	local sound = Instance.new("Sound")
	sound.SoundId = "rbxassetid://" .. id
	sound.Volume = vol
	sound.PlaybackSpeed = speed
	sound.Parent = workspace
	sound.Ended:Connect(function()
		sound:Destroy()
	end)
	sound:Play()
end

playSound("129084748747846", 1, 0.8)
task.wait(1)
playSound("135669001382610", 5, 0.5)
task.wait(8)
playSound("134282584923413", 3, 1.3)