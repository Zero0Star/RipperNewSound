local Sound = workspace.HardCoreSound.FUN1
local LatestRoom = game.ReplicatedStorage.GameData.LatestRoom
local TweenService = game:GetService("TweenService")

Sound.Looped = true
Sound:Play()

for i = 1, 49 do
    LatestRoom.Changed:Wait()
end

local Tween = TweenService:Create(Sound, TweenInfo.new(3), {Volume = 0})
Tween:Play()
Tween.Completed:Wait()

Sound:Stop()