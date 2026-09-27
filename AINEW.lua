
require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("Just kidding",true)
local sound = Instance.new("Sound")
sound.Name = "Subspace"
sound.SoundId = "rbxassetid://133312610824902"
sound.Volume = 1
sound.Parent = workspace

sound.Ended:Connect(function()
    sound:Destroy()
end)

sound:Play()
