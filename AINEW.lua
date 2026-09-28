
local sound = Instance.new("Sound")
sound.Name = "Subspace"
sound.SoundId = "rbxassetid://140278004623742"
sound.Volume = 2
sound.Parent = workspace
sound.Ended:Connect(function()
    sound:Destroy()
end)

sound:Play()
