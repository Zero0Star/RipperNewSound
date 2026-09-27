
require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("今天你将会非常幸运。",true)
wait(5)
require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("你获取了1000/1的概率。",true)
wait(3)
require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("这是非常伟大的决定。",true)
wait(5)
require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("而这个决定是。",true)
wait(2)
local sound = Instance.new("Sound")
sound.Name = "Subspace"
sound.SoundId = "rbxassetid://135669001382610"
sound.Volume = 2
sound.Parent = workspace
require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("你死了",true)
sound.Ended:Connect(function()
    sound:Destroy()
end)

sound:Play()
