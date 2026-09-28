
local sound = Instance.new("Sound")
sound.Name = "Subspace"
sound.SoundId = "rbxassetid://138257446252471"
sound.Volume = 10
sound.Parent = workspace
sound.Ended:Connect(function()
    sound:Destroy()
end)

sound:Play()
