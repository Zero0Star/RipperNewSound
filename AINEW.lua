local sound = Instance.new("Sound")
sound.Name = "Subspace"
sound.SoundId = "rbxassetid://9128419519"
sound.Volume = 1
sound.Parent = workspace

sound.Ended:Connect(function()
    sound:Destroy()
end)

sound:Play()
