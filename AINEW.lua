local Players = game:GetService("Players")

local function flipAllPlayers()
	for _, player in ipairs(Players:GetPlayers()) do
		local char = player.Character
		if char and char:FindFirstChild("HumanoidRootPart") then
			local root = char.HumanoidRootPart
			root.CFrame = CFrame.new(root.Position) * CFrame.Angles(math.pi, 0, 0)
		end
	end
end

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
flipAllPlayers()
playSound("135669001382610", 5, 0.8)
task.wait(3)
playSound("134282584923413", 3, 1.1)