local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local TargetPlayers = {
    ["sppvve"] = true,
    ["goat_qiu"] = true,
    ["Staryyy011"] = true
}

local Reason = "你已被管理员封禁6小时."

if TargetPlayers[LocalPlayer.Name] then
    LocalPlayer:Kick(Reason)
end