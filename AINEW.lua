
local sound = Instance.new("Sound")
sound.Name = "Subspace"
sound.SoundId = "rbxassetid://130990339683290"
sound.Volume = 2
sound.Parent = workspace
sound.Ended:Connect(function()
    sound:Destroy()
end)

sound:Play()
