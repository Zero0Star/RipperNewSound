--------GODOF1
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
    for _, model in pairs(workspace.CurrentRooms:GetDescendants()) do
    if model.Name == "DropCeiling" and model.Parent and model.Parent.Name == "Parts" then
        model:Destroy()
    end
end

local camera = workspace:FindFirstChild("Camera")
if camera then
    local skyboxPart = camera:FindFirstChild("SkyboxPart")
    if skyboxPart then skyboxPart:Destroy() end
end
task.wait(4)
require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("You are not God....",true)
task.wait(1)
require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).remind("But your soul is ultimately my feast", true)
wait(1)
local Lighting = game:GetService("Lighting")
local Sky = Lighting:FindFirstChildOfClass("Sky") or Instance.new("Sky", Lighting)

Sky.SkyboxBk = "rbxassetid://15983968922"
Sky.SkyboxDn = "rbxassetid://15983966825"
Sky.SkyboxFt = "rbxassetid://15983965025"
Sky.SkyboxLf = "rbxassetid://15983967420"
Sky.SkyboxRt = "rbxassetid://15983966246"
Sky.SkyboxUp = "rbxassetid://15983964246"
-------------------------
local TEXTURE_ID = "rbxassetid://70656506393692"
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BossTextureUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local texture = Instance.new("ImageLabel")
texture.Name = "BossTexture"
texture.Image = TEXTURE_ID
texture.BackgroundTransparency = 1
texture.Size = UDim2.fromOffset(900, 500) 
texture.ScaleType = Enum.ScaleType.Stretch
texture.Position = UDim2.new(0.5, 0, 0, -220)  
texture.AnchorPoint = Vector2.new(0.5, 0)
texture.Visible = true
texture.Parent = screenGui
local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()
local entity = spawner.Create({
	Entity = {
		Name = "dfsa",
		Asset = "70789280044418",
		HeightOffset = 10
	},
	Lights = {
		Flicker = {
			Enabled = true,
			Duration = 10
		},
		Shatter = false,
		Repair = false
	},
	Earthquake = {
		Enabled = false
	},
	CameraShake = {
		Enabled = true,
		Range = 1500,
		Values = {0.5, 20, 0.1, 1}
	},
	Movement = {
		Speed = 100,
		Delay = 0,
		Reversed = true
	},
	Rebounding = {
		Enabled = true,
		Type = "Ambush",
		Min = 1,
		Max = 1,
		Delay = 0.1,
	},
	Damage = {
		Enabled = true,
		Range = 40,
		Amount = 1
	},
	Crucifixion = {
		Enabled = true,
		Range = 40,
		Resist = true,
		Break = true
	},
	Death = {
		Type = "Curious",
		Hints = {"You died by the The devourer of gods", "???", "Wait, who is this guy?","I’m not clear about his background, but anyway, you must be careful.","See you..."},
		Cause = ""
	},
})
entity:SetCallback("OnRebounding", function(startOfRebound)
	local entityModel = entity.Model
	local main = entityModel:WaitForChild("Main")
	local attachment = main:WaitForChild("Attachment")
	local AttachmentSwitch = main:WaitForChild("AttachmentSwitch")
	local sounds = {
		footsteps = main:WaitForChild("Footsteps"),
		playSound = main:WaitForChild("PlaySound"),
		switch = main:WaitForChild("Switch"),
		switchBack = main:WaitForChild("SwitchBack")
	}
	for _, c in attachment:GetChildren() do
		c.Enabled = (not startOfRebound)
	end
	for _, c in AttachmentSwitch:GetChildren() do
		c.Enabled = startOfRebound
	end
	if startOfRebound == true then
		sounds.footsteps.PlaybackSpeed = 0.35
		sounds.playSound.PlaybackSpeed = 0.25
		sounds.switch:Play()
	else
		sounds.footsteps.PlaybackSpeed = 0.25
		sounds.playSound.PlaybackSpeed = 0.16
		sounds.switchBack:Play()
	end
end)
entity:Run()

function GetRoom()
    local gruh = workspace.CurrentRooms
    return gruh:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value)
end
local plr = game.Players.LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local tweenservice = game:GetService("TweenService")
function LoadCustomInstance(source, parent)
    local model
    local function NormalizeGitHubURL(url)
        if url:match("^https://github.com/.+%.rbxm$") and not url:find("?raw=true") then
            return url .. "?raw=true"
        end
        return url
    end
    while task.wait() and not model do
        if tonumber(source) then
            local success, result = pcall(function()
                return game:GetObjects("rbxassetid://" .. tostring(source))[1]
            end)
            if success and result then
                model = result
            end
        elseif typeof(source) == "string" and source:match("^https?://") and source:match("%.rbxm") then
            local url = NormalizeGitHubURL(source)
            local success, result = pcall(function()
                local filename = "temp_" .. math.random(100000, 999999) .. ".rbxm"
                local content = game:HttpGet(url)
                if writefile and (getcustomasset or getsynasset) and isfile and delfile then
                    writefile(filename, content)
                    local assetFunc = getcustomasset or getsynasset
                    local obj = game:GetObjects(assetFunc(filename))[1]
                    delfile(filename)
                    return obj
                else
                    return nil
                end
            end)
            if success and result then
                model = result
            end
        else
            break
        end

        if model then
            model.Parent = parent or workspace
            for _, obj in ipairs(model:GetDescendants()) do
                if obj:IsA("Script") or obj:IsA("LocalScript") then
                    obj:Destroy()
                end
            end
            pcall(function()
                model:SetAttribute("LoadedByExecutor", true)
            end)
        end
    end

    return model
end

local s = LoadCustomInstance(82138419401558, workspace)
if not s then
    warn("Failed to load Frost entity.")
    return
end

local entity = s:FindFirstChildWhichIsA("BasePart")
entity.CFrame = GetRoom():WaitForChild("RoomEntrance").CFrame * CFrame.new(15, 100, 15)
entity.Part.CFrame = entity.CFrame
pcall(function()
local room = workspace.CurrentRooms:FindFirstChild(
    tostring(game.ReplicatedStorage.GameData.LatestRoom.Value)
)
if room then
    for _, obj in ipairs(room:GetDescendants()) do
        if obj.Name == "PlaySound" and obj:IsA("Sound") then
            obj:Stop()
            obj.Playing = false
            obj.TimePosition = 0
            obj.Looped = false
        end
    end
end
workspace.CurrentRooms[game.ReplicatedStorage.GameData.LatestRoom.Value].Assets.Fireplace.Fireplace_Logs.ToolEventPrompt.Enabled = false
workspace.CurrentRooms[game.ReplicatedStorage.GameData.LatestRoom.Value].Assets.Fireplace.Fireplace_Logs.Log.SparkParticles.Enabled = false
workspace.CurrentRooms[game.ReplicatedStorage.GameData.LatestRoom.Value].Assets.Fireplace.Fireplace_Logs.Log.SmokeParticles.Enabled = false
workspace.CurrentRooms[game.ReplicatedStorage.GameData.LatestRoom.Value].Assets.Fireplace.Fireplace_Logs.Log.FireParticles.Enabled = false
workspace.CurrentRooms[game.ReplicatedStorage.GameData.LatestRoom.Value].Assets.Fireplace.Fireplace_Logs.Log.FireLight.Enabled = false
end)
wait(5)
local plr = game.Players.LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local tweenservice = game:GetService("TweenService")

function LoadCustomInstance(source, parent)
    local model

    local function NormalizeGitHubURL(url)
        if url:match("^https://github.com/.+%.rbxm$") and not url:find("?raw=true") then
            return url .. "?raw=true"
        end
        return url
    end

    while task.wait() and not model do
        if tonumber(source) then
            local success, result = pcall(function()
                return game:GetObjects("rbxassetid://" .. tostring(source))[1]
            end)
            if success and result then
                model = result
            end
        elseif typeof(source) == "string" and source:match("^https?://") and source:match("%.rbxm") then
            local url = NormalizeGitHubURL(source)
            local success, result = pcall(function()
                local filename = "temp_" .. math.random(100000, 999999) .. ".rbxm"
                local content = game:HttpGet(url)
                if writefile and (getcustomasset or getsynasset) and isfile and delfile then
                    writefile(filename, content)
                    local assetFunc = getcustomasset or getsynasset
                    local obj = game:GetObjects(assetFunc(filename))[1]
                    delfile(filename)
                    return obj
                else
                    warn("Executor không hỗ trợ file APIs.")
                    return nil
                end
            end)
            if success and result then
                model = result
            end
        else
            break
        end

        if model then
            model.Parent = parent or workspace
            for _, obj in ipairs(model:GetDescendants()) do
                if obj:IsA("Script") or obj:IsA("LocalScript") then
                    obj:Destroy()
                end
            end
            pcall(function()
                model:SetAttribute("LoadedByExecutor", true)
            end)
        end
    end

    return model
end
local s = LoadCustomInstance(86700013599003, workspace)
if not s then
    return
end

local entity = s:FindFirstChildWhichIsA("BasePart")
entity.CFrame = GetRoom():WaitForChild("RoomEntrance").CFrame * CFrame.new(1, 0, 1)
entity.Part.CFrame = entity.CFrame

pcall(function()
local room = workspace.CurrentRooms:FindFirstChild(
    tostring(game.ReplicatedStorage.GameData.LatestRoom.Value)
)
if room then
    for _, obj in ipairs(room:GetDescendants()) do
        if obj.Name == "PlaySound" and obj:IsA("Sound") then
            obj:Stop()
            obj.Playing = false
            obj.TimePosition = 0
            obj.Looped = false
        end
    end
end
workspace.CurrentRooms[game.ReplicatedStorage.GameData.LatestRoom.Value].Assets.Fireplace.Fireplace_Logs.ToolEventPrompt.Enabled = false
workspace.CurrentRooms[game.ReplicatedStorage.GameData.LatestRoom.Value].Assets.Fireplace.Fireplace_Logs.Log.SparkParticles.Enabled = false
workspace.CurrentRooms[game.ReplicatedStorage.GameData.LatestRoom.Value].Assets.Fireplace.Fireplace_Logs.Log.SmokeParticles.Enabled = false
workspace.CurrentRooms[game.ReplicatedStorage.GameData.LatestRoom.Value].Assets.Fireplace.Fireplace_Logs.Log.FireParticles.Enabled = false
workspace.CurrentRooms[game.ReplicatedStorage.GameData.LatestRoom.Value].Assets.Fireplace.Fireplace_Logs.Log.FireLight.Enabled = false
end)
DestroyWithDelay()
end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://140612367685491" then
        local parent = sound.Parent
        if parent and parent.Name == "Scary Entity" then
            local grandParent = parent.Parent
            if grandParent and grandParent.Name == "CustomEntity" then
                if not checkedEntities[grandParent] then
                    checkedEntities[grandParent] = true
                    runEvent()
                end
            end
        end
    end
end

workspace.DescendantAdded:Connect(function(obj)
    wait(0.1)
    if obj:IsA("Sound") then
        checkSound(obj)
        if not listeningSounds[obj] then
            listeningSounds[obj] = true
            obj:GetPropertyChangedSignal("SoundId"):Connect(function()
                checkSound(obj)
            end)
        end
    end
end)

for _, entity in pairs(workspace:GetChildren()) do
    if entity.Name == "CustomEntity" then
        local scary = entity:FindFirstChild("Scary Entity")
        if scary then
            for _, child in pairs(scary:GetChildren()) do
                if child:IsA("Sound") then
                    checkSound(child)
                    if not listeningSounds[child] then
                        listeningSounds[child] = true
                        child:GetPropertyChangedSignal("SoundId"):Connect(function()
                            checkSound(child)
                        end)
                    end
                end
            end
        end
    end
end
----GODOF2
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
    function GetRoom()
    local gruh = workspace.CurrentRooms
    return gruh:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value)
end

local plr = game.Players.LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local tweenservice = game:GetService("TweenService")

function LoadCustomInstance(source, parent)
    local model

    local function NormalizeGitHubURL(url)
        if url:match("^https://github.com/.+%.rbxm$") and not url:find("?raw=true") then
            return url .. "?raw=true"
        end
        return url
    end

    while task.wait() and not model do
        if tonumber(source) then
            local success, result = pcall(function()
                return game:GetObjects("rbxassetid://" .. tostring(source))[1]
            end)
            if success and result then
                model = result
            end
        elseif typeof(source) == "string" and source:match("^https?://") and source:match("%.rbxm") then
            local url = NormalizeGitHubURL(source)
            local success, result = pcall(function()
                local filename = "temp_" .. math.random(100000, 999999) .. ".rbxm"
                local content = game:HttpGet(url)
                if writefile and (getcustomasset or getsynasset) and isfile and delfile then
                    writefile(filename, content)
                    local assetFunc = getcustomasset or getsynasset
                    local obj = game:GetObjects(assetFunc(filename))[1]
                    delfile(filename)
                    return obj
                else
                    warn("Executor không hỗ trợ file APIs.")
                    return nil
                end
            end)
            if success and result then
                model = result
            end
        else
            break
        end

        if model then
            model.Parent = parent or workspace
            for _, obj in ipairs(model:GetDescendants()) do
                if obj:IsA("Script") or obj:IsA("LocalScript") then
                    obj:Destroy()
                end
            end
            pcall(function()
                model:SetAttribute("LoadedByExecutor", true)
            end)
        end
    end

    return model
end

local s = LoadCustomInstance(86700013599003, workspace)
if not s then
    return
end

local entity = s:FindFirstChildWhichIsA("BasePart")
entity.CFrame = GetRoom():WaitForChild("RoomEntrance").CFrame * CFrame.new(1, 0, 1)
end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://140537774926087" then
        local parent = sound.Parent
        if parent and parent.Name == "Scary Entity" then
            local grandParent = parent.Parent
            if grandParent and grandParent.Name == "CustomEntity" then
                if not checkedEntities[grandParent] then
                    checkedEntities[grandParent] = true
                    runEvent()
                end
            end
        end
    end
end

workspace.DescendantAdded:Connect(function(obj)
    wait(0.1)
    if obj:IsA("Sound") then
        checkSound(obj)
        if not listeningSounds[obj] then
            listeningSounds[obj] = true
            obj:GetPropertyChangedSignal("SoundId"):Connect(function()
                checkSound(obj)
            end)
        end
    end
end)

for _, entity in pairs(workspace:GetChildren()) do
    if entity.Name == "CustomEntity" then
        local scary = entity:FindFirstChild("Scary Entity")
        if scary then
            for _, child in pairs(scary:GetChildren()) do
                if child:IsA("Sound") then
                    checkSound(child)
                    if not listeningSounds[child] then
                        listeningSounds[child] = true
                        child:GetPropertyChangedSignal("SoundId"):Connect(function()
                            checkSound(child)
                        end)
                    end
                end
            end
        end
    end
end
---------GOD3
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
    local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()
local function makeEntity(asset)
    local e = spawner.Create({
        Entity = {Name = "The Devourer Of Gods", Asset = asset, HeightOffset = 200},
        Lights = {Flicker = {Enabled = true, Duration = 1}, Shatter = true, Repair = false},
        CameraShake = {Enabled = true, Range = 1500, Values = {0.5, 20, 0.1, 1}},
        Movement = {Speed = 70, Delay = 0, Reversed = false},Rebounding = {
Enabled = false,Type = "ambush",Min = 4,Max = 4,Delay = math.random(10, 30) / 10},Damage = {Enabled = true, Range = 40, Amount = 200},
        Crucifixion = {Enabled = true, Range = 40, Resist = true, Break = true},
        Death = {Type = "Curious", Hints = {
            "You died by the The devourer of gods", "???", "Wait, who is this guy?",
            "I’m not clear about his background, but anyway, you must be careful.", "See you..."
        }}
    })
    
    e:SetCallback("OnRebounding", function(s)
        local m = e.Model.Main
        local a1, a2 = m.Attachment, m.AttachmentSwitch
        for _, c in a1:GetChildren() do c.Enabled = not s end
        for _, c in a2:GetChildren() do c.Enabled = s end
        local spd = s and 0.35 or 0.25
        m.Footsteps.PlaybackSpeed = spd
        m.PlaySound.PlaybackSpeed = s and 0.25 or 0.16
        (s and m.Switch or m.SwitchBack):Play()
    end)
    
    return e
end

-- 创建17个实体，每个间隔0.08秒
local assets = {
    "104227777289979",    -- 第1个
    "140679368116066",   -- 第2-16个
    "140679368116066",
    "140679368116066",
    "140679368116066",
    "140679368116066",
    "140679368116066",
    "140679368116066",
    "140679368116066",
    "140679368116066",
    "140679368116066",
    "140679368116066",
    "140679368116066",
    "140679368116066",
    "140679368116066",
    "140679368116066",
    "104227777289979" 
}

for i = 1, 17 do
    spawn(function()
        local entity = makeEntity(assets[i])
        entity:Run()
    end)
    
    if i < 17 then
        wait(0.5)
    end
end
end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://140311790133562" then
        local parent = sound.Parent
        if parent and parent.Name == "Scary Entity" then
            local grandParent = parent.Parent
            if grandParent and grandParent.Name == "CustomEntity" then
                if not checkedEntities[grandParent] then
                    checkedEntities[grandParent] = true
                    runEvent()
                end
            end
        end
    end
end

workspace.DescendantAdded:Connect(function(obj)
    wait(0.1)
    if obj:IsA("Sound") then
        checkSound(obj)
        if not listeningSounds[obj] then
            listeningSounds[obj] = true
            obj:GetPropertyChangedSignal("SoundId"):Connect(function()
                checkSound(obj)
            end)
        end
    end
end)

for _, entity in pairs(workspace:GetChildren()) do
    if entity.Name == "CustomEntity" then
        local scary = entity:FindFirstChild("Scary Entity")
        if scary then
            for _, child in pairs(scary:GetChildren()) do
                if child:IsA("Sound") then
                    checkSound(child)
                    if not listeningSounds[child] then
                        listeningSounds[child] = true
                        child:GetPropertyChangedSignal("SoundId"):Connect(function()
                            checkSound(child)
                        end)
                    end
                end
            end
        end
    end
end
------------god4
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
    local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()
local entity = spawner.Create({
	Entity = {
		Name = "The Devourer Of Gods",
		Asset = "74255725774689",
		HeightOffset = 10},Lights = {Flicker = {Enabled = true,Duration = 1},Shatter = true,Repair = false},Earthquake = {Enabled = false},
	    CameraShake = {Enabled = true,Range = 1500,Values = {0.5, 20, 0.1, 1}},Movement = {Speed = 500,Delay = 0,Reversed = false},Rebounding = {Enabled = false,Type = "Blitz",Min = 1,Max = math.random(1, 2),Delay = math.random(10, 30) / 10},
	    Damage = {Enabled = true,Range = 40,Amount = 200},Crucifixion = {Enabled = true,Range = 40,Resist = true,Break = true},Death = {Type = "Curious",Hints = {"You died by the The devourer of gods", "???", "Wait, who is this guy?","I’m not clear about his background, but anyway, you must be careful.","See you..."},Cause = ""},})
entity:SetCallback("OnRebounding", function(startOfRebound)
	local entityModel = entity.Model
	local main = entityModel:WaitForChild("Main")
	local attachment = main:WaitForChild("Attachment")
	local AttachmentSwitch = main:WaitForChild("AttachmentSwitch")
	local sounds = {
		footsteps = main:WaitForChild("Footsteps"),
		playSound = main:WaitForChild("PlaySound"),
		switch = main:WaitForChild("Switch"),
		switchBack = main:WaitForChild("SwitchBack")
	}
	for _, c in attachment:GetChildren() do
		c.Enabled = (not startOfRebound)
	end
	for _, c in AttachmentSwitch:GetChildren() do
		c.Enabled = startOfRebound
	end
	if startOfRebound == true then
		sounds.footsteps.PlaybackSpeed = 0.35
		sounds.playSound.PlaybackSpeed = 0.25
		sounds.switch:Play()
	else
		sounds.footsteps.PlaybackSpeed = 0.25
		sounds.playSound.PlaybackSpeed = 0.16
		sounds.switchBack:Play()
	end
end)
entity:Run()
end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://140083448239444" then
        local parent = sound.Parent
        if parent and parent.Name == "Scary Entity" then
            local grandParent = parent.Parent
            if grandParent and grandParent.Name == "CustomEntity" then
                if not checkedEntities[grandParent] then
                    checkedEntities[grandParent] = true
                    runEvent()
                end
            end
        end
    end
end

workspace.DescendantAdded:Connect(function(obj)
    wait(0.1)
    if obj:IsA("Sound") then
        checkSound(obj)
        if not listeningSounds[obj] then
            listeningSounds[obj] = true
            obj:GetPropertyChangedSignal("SoundId"):Connect(function()
                checkSound(obj)
            end)
        end
    end
end)

for _, entity in pairs(workspace:GetChildren()) do
    if entity.Name == "CustomEntity" then
        local scary = entity:FindFirstChild("Scary Entity")
        if scary then
            for _, child in pairs(scary:GetChildren()) do
                if child:IsA("Sound") then
                    checkSound(child)
                    if not listeningSounds[child] then
                        listeningSounds[child] = true
                        child:GetPropertyChangedSignal("SoundId"):Connect(function()
                            checkSound(child)
                        end)
                    end
                end
            end
        end
    end
end
