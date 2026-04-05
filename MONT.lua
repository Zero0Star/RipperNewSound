local player = game.Players.LocalPlayer
local soundId = 73668768200808

local function setupDeathSound(char)
    local hum = char:WaitForChild("Humanoid")
    hum.Died:Connect(function()
        local sound = Instance.new("Sound", workspace)
        sound.SoundId = "rbxassetid://" .. soundId
        sound.Volume = 1
        sound:Play()
        
        sound.Ended:Wait()
        sound:Destroy()
    end)
end

setupDeathSound(player.Character or player.CharacterAdded:Wait())

player.CharacterAdded:Connect(setupDeathSound)
local runService = game:GetService("RunService")
local workspace = game:GetService("Workspace")

local localEyes1 = nil
local localEyesCopy = nil
local updateConnection = nil
local originalEyesModel = nil
local removedObjects = {}

local function cleanEyesModel()
    local localEyes = workspace:FindFirstChild("AmbushMoving")
    if not localEyes or not localEyes:IsA("Model") then
        return
    end
    
    for _, obj in ipairs(removedObjects) do
        if obj and obj.Parent then
            obj:Destroy()
        end
    end
    removedObjects = {}

    for _, descendant in ipairs(localEyes:GetDescendants()) do

        if descendant.Name ~= "RushNew" and descendant:IsA("BasePart") then
            descendant:Destroy()
            table.insert(removedObjects, descendant)
        end
        
        if descendant:IsA("PointLight") then
            descendant:Destroy()
            table.insert(removedObjects, descendant)
        end
        
        if descendant:IsA("Decal") or descendant:IsA("Texture") then
            descendant:Destroy()
            table.insert(removedObjects, descendant)
        end

        if descendant:IsA("Sound") then
            descendant:Destroy()
            table.insert(removedObjects, descendant)
        end

        if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
            descendant:Destroy()
            table.insert(removedObjects, descendant)
        end

        if descendant:IsA("BillboardGui") or descendant:IsA("SurfaceGui") or 
           descendant:IsA("ScreenGui") then
            descendant:Destroy()
            table.insert(removedObjects, descendant)
        end

        if descendant:IsA("SurfaceAppearance") or descendant:IsA("Sparkles") or
           descendant:IsA("Smoke") or descendant:IsA("Fire") then
            descendant:Destroy()
            table.insert(removedObjects, descendant)
        end
    end
end

local function checkAndCreateLocalCopy()

    originalEyesModel = workspace:FindFirstChild("AmbushMoving")
    
    if not originalEyesModel then

        if localEyesCopy then
            localEyesCopy:Destroy()
            localEyesCopy = nil
        end
        if localEyes1 then
            localEyes1:Destroy()
            localEyes1 = nil
        end
        if updateConnection then
            updateConnection:Disconnect()
            updateConnection = nil
        end
        return
    end

    cleanEyesModel()

    if localEyesCopy then
        localEyesCopy:Destroy()
        localEyesCopy = nil
    end
    
    if localEyes1 then
        localEyes1:Destroy()
        localEyes1 = nil
    end
    
    if updateConnection then
        updateConnection:Disconnect()
        updateConnection = nil
    end

    local success1, eyes1Result = pcall(function()
        return game:GetObjects("rbxassetid://109143871922489")[1]
    end)
    
    if success1 and eyes1Result then
        localEyes1 = eyes1Result
        localEyes1.Name = "A-60New"
        localEyes1.Parent = workspace

    end

    local success2, eyesCopyResult = pcall(function()
        return game:GetObjects("rbxassetid://109143871922489")[1]
    end)
    
    if success2 and eyesCopyResult then
        localEyesCopy = eyesCopyResult
        localEyesCopy.Name = "AmbushMovingCopy"
        localEyesCopy.Parent = workspace

        updateConnection = runService.RenderStepped:Connect(function()

            if originalEyesModel and originalEyesModel:FindFirstChild("RushNew") and 
               localEyesCopy and localEyesCopy:IsDescendantOf(workspace) then
                
                local corePart = originalEyesModel:FindFirstChild("RushNew")
                if corePart and corePart:IsA("BasePart") then

                    localEyesCopy:PivotTo(corePart.CFrame)

                    if localEyes1 and localEyes1:IsDescendantOf(workspace) then
                        localEyes1:PivotTo(corePart.CFrame)
                    end
                end
            else

                if updateConnection then
                    updateConnection:Disconnect()
                    updateConnection = nil
                end
            end
        end)
    end
end


wait(1) 
checkAndCreateLocalCopy()

local eyesAddedConnection = workspace.ChildAdded:Connect(function(child)
    if child.Name == "AmbushMoving" and child:IsA("Model") then
        wait(0.2)
        checkAndCreateLocalCopy()
    end
end)

local eyesRemovedConnection = workspace.ChildRemoved:Connect(function(child)
    if child.Name == "AmbushMoving" and child:IsA("Model") then

        if localEyesCopy then
            localEyesCopy:Destroy()
            localEyesCopy = nil
        end
        if localEyes1 then
            localEyes1:Destroy()
            localEyes1 = nil
        end
        if updateConnection then
            updateConnection:Disconnect()
            updateConnection = nil
        end
    end
end)

local function periodicCheck()
    while true do
        wait(3)

        local currentEyes = workspace:FindFirstChild("AmbushMoving")
        
        if currentEyes and currentEyes:IsA("Model") then

            local needsCleaning = false
            for _, descendant in ipairs(currentEyes:GetDescendants()) do

                if descendant:IsA("PointLight") or descendant:IsA("Decal") or 
                   descendant:IsA("Texture") or descendant:IsA("Sound") or
                   descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") or
                   (descendant:IsA("BasePart") and descendant.Name ~= "A-60New") then
                    needsCleaning = true
                    break
                end
            end
            
            if needsCleaning then
                cleanEyesModel()
            end

            if not currentEyes:FindFirstChild("A-60New") then
                local core = Instance.new("Part")
                core.Name = "A-60New"
                core.Anchored = true
                core.CanCollide = false
                core.Transparency = 1
                core.Size = Vector3.new(1, 1, 1)
                core.Parent = currentEyes
            end

            if (not localEyesCopy or not localEyesCopy:IsDescendantOf(workspace)) or 
               (not localEyes1 or not localEyes1:IsDescendantOf(workspace)) then
                checkAndCreateLocalCopy()
            end
        else

            if localEyesCopy or localEyes1 then
                if localEyesCopy then
                    localEyesCopy:Destroy()
                    localEyesCopy = nil
                end
                if localEyes1 then
                    localEyes1:Destroy()
                    localEyes1 = nil
                end
                if updateConnection then
                    updateConnection:Disconnect()
                    updateConnection = nil
                end
            end
        end
    end
end

spawn(periodicCheck)

local runService = game:GetService("RunService")
local workspace = game:GetService("Workspace")

local localEyes1 = nil
local localEyesCopy = nil
local updateConnection = nil
local originalEyesModel = nil
local removedObjects = {}

local function cleanEyesModel()
    local localEyes = workspace:FindFirstChild("Eyes")
    if not localEyes or not localEyes:IsA("Model") then
        return
    end

    for _, obj in ipairs(removedObjects) do
        if obj and obj.Parent then
            obj:Destroy()
        end
    end
    removedObjects = {}

    for _, descendant in ipairs(localEyes:GetDescendants()) do

        if descendant.Name ~= "Core" and descendant:IsA("BasePart") then
            descendant:Destroy()
            table.insert(removedObjects, descendant)
        end

        if descendant:IsA("PointLight") then
            descendant:Destroy()
            table.insert(removedObjects, descendant)
        end

        if descendant:IsA("Decal") or descendant:IsA("Texture") then
            descendant:Destroy()
            table.insert(removedObjects, descendant)
        end

        if descendant:IsA("Sound") then
            descendant:Destroy()
            table.insert(removedObjects, descendant)
        end

        if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
            descendant:Destroy()
            table.insert(removedObjects, descendant)
        end

        if descendant:IsA("BillboardGui") or descendant:IsA("SurfaceGui") or 
           descendant:IsA("ScreenGui") then
            descendant:Destroy()
            table.insert(removedObjects, descendant)
        end

        if descendant:IsA("SurfaceAppearance") or descendant:IsA("Sparkles") or
           descendant:IsA("Smoke") or descendant:IsA("Fire") then
            descendant:Destroy()
            table.insert(removedObjects, descendant)
        end
    end

end


local function checkAndCreateLocalCopy()

    originalEyesModel = workspace:FindFirstChild("Eyes")
    
    if not originalEyesModel then

        if localEyesCopy then
            localEyesCopy:Destroy()
            localEyesCopy = nil
        end
        if localEyes1 then
            localEyes1:Destroy()
            localEyes1 = nil
        end
        if updateConnection then
            updateConnection:Disconnect()
            updateConnection = nil
        end
        return
    end

    cleanEyesModel()
    

    if localEyesCopy then
        localEyesCopy:Destroy()
        localEyesCopy = nil
    end
    
    if localEyes1 then
        localEyes1:Destroy()
        localEyes1 = nil
    end
    
    if updateConnection then
        updateConnection:Disconnect()
        updateConnection = nil
    end
    

    local success1, eyes1Result = pcall(function()
        return game:GetObjects("rbxassetid://133236803369785")[1]
    end)
    
    if success1 and eyes1Result then
        localEyes1 = eyes1Result
        localEyes1.Name = "Eyes1"
        localEyes1.Parent = workspace

    end

    local success2, eyesCopyResult = pcall(function()
        return game:GetObjects("rbxassetid://133236803369785")[1]
    end)
    
    if success2 and eyesCopyResult then
        localEyesCopy = eyesCopyResult
        localEyesCopy.Name = "EyesCopy"
        localEyesCopy.Parent = workspace

        updateConnection = runService.RenderStepped:Connect(function()

            if originalEyesModel and originalEyesModel:FindFirstChild("Core") and 
               localEyesCopy and localEyesCopy:IsDescendantOf(workspace) then
                
                local corePart = originalEyesModel:FindFirstChild("Core")
                if corePart and corePart:IsA("BasePart") then

                    localEyesCopy:PivotTo(corePart.CFrame)

                    if localEyes1 and localEyes1:IsDescendantOf(workspace) then
                        localEyes1:PivotTo(corePart.CFrame)
                    end
                end
            else

                if updateConnection then
                    updateConnection:Disconnect()
                    updateConnection = nil
                end
            end
        end)
    end
end

wait(1)
checkAndCreateLocalCopy()

local eyesAddedConnection = workspace.ChildAdded:Connect(function(child)
    if child.Name == "Eyes" and child:IsA("Model") then
        wait(0.2) 
        checkAndCreateLocalCopy()
    end
end)

local eyesRemovedConnection = workspace.ChildRemoved:Connect(function(child)
    if child.Name == "Eyes" and child:IsA("Model") then

        if localEyesCopy then
            localEyesCopy:Destroy()
            localEyesCopy = nil
        end
        if localEyes1 then
            localEyes1:Destroy()
            localEyes1 = nil
        end
        if updateConnection then
            updateConnection:Disconnect()
            updateConnection = nil
        end
    end
end)

local function periodicCheck()
    while true do
        wait(3)

        local currentEyes = workspace:FindFirstChild("Eyes")
        
        if currentEyes and currentEyes:IsA("Model") then

            local needsCleaning = false
            for _, descendant in ipairs(currentEyes:GetDescendants()) do

                if descendant:IsA("PointLight") or descendant:IsA("Decal") or 
                   descendant:IsA("Texture") or descendant:IsA("Sound") or
                   descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") or
                   (descendant:IsA("BasePart") and descendant.Name ~= "Core") then
                    needsCleaning = true
                    break
                end
            end
            
            if needsCleaning then
                cleanEyesModel()
            end

            if not currentEyes:FindFirstChild("Core") then
                local core = Instance.new("Part")
                core.Name = "Core"
                core.Anchored = true
                core.CanCollide = false
                core.Transparency = 1
                core.Size = Vector3.new(1, 1, 1)
                core.Parent = currentEyes
            end

            if (not localEyesCopy or not localEyesCopy:IsDescendantOf(workspace)) or 
               (not localEyes1 or not localEyes1:IsDescendantOf(workspace)) then
                checkAndCreateLocalCopy()
            end
        else

            if localEyesCopy or localEyes1 then
                if localEyesCopy then
                    localEyesCopy:Destroy()
                    localEyesCopy = nil
                end
                if localEyes1 then
                    localEyes1:Destroy()
                    localEyes1 = nil
                end
                if updateConnection then
                    updateConnection:Disconnect()
                    updateConnection = nil
                end
            end
        end
    end
end

spawn(periodicCheck)


local ReplicatedStorage = game:GetService("ReplicatedStorage")

local function removeScreechFromEntities()
    local Entities = ReplicatedStorage:FindFirstChild("Entities")
    if not Entities then
        return
    end
    
    local screechInstances = {}
    
    for _, child in ipairs(Entities:GetChildren()) do
        if child.Name == "Screech" then
            table.insert(screechInstances, child)
        end
    end
    
    if #screechInstances == 0 then

        return
    end
    
    for _, screech in ipairs(screechInstances) do
        screech:Destroy()
    end

end


removeScreechFromEntities()

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Entities = ReplicatedStorage:FindFirstChild("Entities") or Instance.new("Folder")
Entities.Name = "Entities"
Entities.Parent = ReplicatedStorage

local MODEL_ID = 134976436709157

local model = game:GetObjects("rbxassetid://" .. MODEL_ID)[1]
model.Parent = Entities

game.ReplicatedStorage.GameData.LatestRoom.Changed:Wait()
require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("By Mr.Key",true)
require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).titlelocation("The HardCord Hotel",true)
require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).remind("⚠This mode is quite challenging and is recommended for 2-5 players.⚠", true)

-- 音频管理脚本
function GitAud(soundgit, filename)
    local url = soundgit
    local fullFileName = filename .. ".mp3"
    
    local success, audioData = pcall(function()
        return game:HttpGet(url)
    end)
    
    if not success then
        return nil
    end
    
    local writeSuccess = pcall(function()
        writefile(fullFileName, audioData)
    end)
    
    if not writeSuccess then
        return nil
    end
    
    local assetPath
    if getsynasset then
        assetPath = getsynasset(fullFileName)
    elseif getcustomasset then
        assetPath = getcustomasset(fullFileName)
    else
        return nil
    end
    
    return assetPath
end

function CreateGitSound(soundlink, vol, filename, parent)
    local sound = Instance.new("Sound")
    sound.SoundId = GitAud(soundlink, filename)
    
    if not sound.SoundId then
        return nil
    end
    
    sound.Parent = parent or workspace
    sound.Name = filename
    sound.Volume = vol or 2
    sound.Looped = false
    sound.Playing = false
    
    pcall(function()
        sound.Loaded:Wait()
    end)
    
    return sound
end

function WaitForRoom(roomName)
    while true do
        local currentRooms = workspace:FindFirstChild("CurrentRooms")
        if currentRooms then
            local targetRoom = currentRooms:FindFirstChild(roomName)
            if targetRoom then
                return targetRoom
            end
        end
        wait(0.5)
    end
end

function MainController()
    local LB1 = CreateGitSound(
        "https://github.com/Zero0Star/RipperMPSound/blob/master/FigureMusicOne.mp3?raw=true",
        2, 
        "LB1", 
        workspace
    )
    
    local LB2 = CreateGitSound(
        "https://github.com/Zero0Star/RipperMPSound/blob/master/FigureMusicTwo.mp3?raw=true",
        2, 
        "LB2", 
        workspace
    )
    
    local LB3 = CreateGitSound(
        "https://github.com/Zero0Star/RipperMPSound/blob/master/FigureMusicThree.mp3?raw=true",
        2, 
        "LB3", 
        workspace
    )
    
    if not LB1 or not LB2 or not LB3 then
        return
    end
    
    WaitForRoom("50")
    
    local GameData = game:GetService("ReplicatedStorage"):FindFirstChild("GameData")
    if not GameData then
        return
    end
    
    local LatestRoom = GameData:FindFirstChild("LatestRoom")
    if not LatestRoom then
        return
    end
    
    LatestRoom.Changed:Wait()
    
    if LB1 and LB1.Parent then
        LB1.Playing = true
        
        local endedConnection
        endedConnection = LB1.Ended:Connect(function()
            if LB1 and LB1.Parent then
                LB1:Destroy()
            end
            endedConnection:Disconnect()
        end)
        
        LB1.Ended:Wait()
    end
    
    if LB2 and LB2.Parent then
        LB2.Looped = true
        LB2.Playing = true
        
        LatestRoom.Changed:Wait()
        
        LB2.Playing = false
        wait(0.1)
        
        if LB2 and LB2.Parent then
            LB2:Destroy()
        end
    end
    
    if LB3 and LB3.Parent then
        LB3.Playing = true
        
        local endedConnection
        endedConnection = LB3.Ended:Connect(function()
            if LB3 and LB3.Parent then
                LB3:Destroy()
            end
            endedConnection:Disconnect()
        end)
        
        LB3.Ended:Wait()
    end
end

pcall(MainController)