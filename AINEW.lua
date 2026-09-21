local players = game:GetService("Players")
local runService = game:GetService("RunService")
local workspace = game:GetService("Workspace")

local localPlayer = players.LocalPlayer or players.PlayerAdded:Wait()

local texture_id = "rbxassetid://9835676490"

local partFolder = workspace:FindFirstChild("part") or Instance.new("Folder")
partFolder.Name = "part"
partFolder.Parent = workspace

local textureFolder = partFolder:FindFirstChild("texture") or Instance.new("Folder")
textureFolder.Name = "texture"
textureFolder.Parent = partFolder

local eyePart = partFolder:FindFirstChild("CustomWatcher") or Instance.new("Part")
eyePart.Name = "CustomWatcher"
eyePart.Size = Vector3.new(6, 6, 0.2)
eyePart.Transparency = 1
eyePart.CanCollide = false
eyePart.Anchored = true
eyePart.CastShadow = false
eyePart.Parent = partFolder

local decal = eyePart:FindFirstChild("WatcherDecal") or Instance.new("Decal")
decal.Name = "WatcherDecal"
decal.Texture = texture_id
decal.Face = Enum.NormalId.Front
decal.Parent = eyePart

local function teleportToPlayer()
    local character = localPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local hrp = character.HumanoidRootPart
        eyePart.CFrame = hrp.CFrame * CFrame.new(0, 2, -10)
    end
end

runService.Heartbeat:Connect(function()
    local character = localPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local hrp = character.HumanoidRootPart

        eyePart.CFrame = CFrame.lookAt(eyePart.Position, hrp.Position)

        local distance = (eyePart.Position - hrp.Position).Magnitude
        if distance > 18 then
            teleportToPlayer()
        end
    end
end)

if localPlayer.Character then
    teleportToPlayer()
end
localPlayer.CharacterAdded:Connect(function()
    task.wait(0.5)
    teleportToPlayer()
end)