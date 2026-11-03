local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local TargetPlayers = {
    ["sppvve"] = true,
    ["goat_qiu"] = true,
    ["Staryyy011"] = true
}

local Reason = "You have been warned once for 'prohibited use of third-party scripts'."

if TargetPlayers[LocalPlayer.Name] then
    LocalPlayer:Kick(Reason)
end