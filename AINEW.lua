local sound = Instance.new("Sound")
sound.Name = "Subspace"
sound.SoundId = "rbxassetid://124233495227925"
sound.Volume = 1
sound.Parent = workspace

sound.Ended:Connect(function()
    sound:Destroy()
end)

sound:Play()
