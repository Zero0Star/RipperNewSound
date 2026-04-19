if workspace:FindFirstChild("HardcoremUSIC") then
    return
end
local marker = Instance.new("BoolValue")
marker.Name = "HardcoremUSIC"
marker.Value = true
marker.Parent = workspace
local Workspace = game:GetService("Workspace")

local Players = game:GetService("Players")

Players.PlayerRemoving:Connect(function(player)
end)

local CurrentRooms = Workspace:FindFirstChild("CurrentRooms")
local newSoundId = "rbxassetid://139882610901041"
local normalSoundId = "rbxassetid://127290678441848"
local drawerOpenSoundId = "rbxassetid://77821440186535"
local drawerCloseSoundId = "rbxassetid://91806874450319"

local processedInstances = {}

local function markProcessed(instance)
    processedInstances[instance] = true
end

local function isProcessed(instance)
    return processedInstances[instance] ~= nil
end

local function fixDoorSound(doorModel)
    local part = doorModel:FindFirstChild("Door") or doorModel:FindFirstChild("DoorNormal")
    if not part then return end
    local sound = part:FindFirstChild("Open")
    if sound and sound:IsA("Sound") then
        sound.SoundId = (doorModel.Name == "DoorNormal") and normalSoundId or newSoundId
    end
end

local function fixDrawerSounds(mainPart)
    if not mainPart then return end
    local openSound = mainPart:FindFirstChild("Open")
    local closeSound = mainPart:FindFirstChild("Close")
    if openSound and openSound:IsA("Sound") then
        openSound.SoundId = drawerOpenSoundId
        openSound.Volume = 2
    end
    if closeSound and closeSound:IsA("Sound") then
        closeSound.SoundId = drawerCloseSoundId
        closeSound.Volume = 2
    end
end

local function scanAssets(assets)
    if not assets then return end
    for _, thing in ipairs(assets:GetChildren()) do
        if thing.Name == "Dresser" and thing:IsA("Model") then
            for _, container in ipairs(thing:GetChildren()) do
                if container.Name == "DrawerContainer" and container:IsA("Model") then
                    local main = container:FindFirstChild("Main")
                    if main and (main:IsA("MeshPart") or main:IsA("BasePart")) then
                        fixDrawerSounds(main)
                    end
                end
            end
        end
    end
end

local function deepScanAndFix(parent)
    for _, child in ipairs(parent:GetChildren()) do
        if child:IsA("Model") and (child.Name == "Door" or child.Name == "DoorNormal") then
            local part = child:FindFirstChild("Door") or child:FindFirstChild("DoorNormal")
            if part and not isProcessed(part) then
                local sound = part:FindFirstChild("Open")
                if sound and sound:IsA("Sound") then
                    sound.SoundId = (child.Name == "DoorNormal") and normalSoundId or newSoundId
                    markProcessed(part)
                end
            end
        end
        
        if child.Name == "Assets" and child:IsA("Folder") then
            for _, dresser in ipairs(child:GetChildren()) do
                if dresser.Name == "Dresser" and dresser:IsA("Model") then
                    for _, container in ipairs(dresser:GetChildren()) do
                        if container.Name == "DrawerContainer" and container:IsA("Model") then
                            local main = container:FindFirstChild("Main")
                            if main and (main:IsA("MeshPart") or main:IsA("BasePart")) and not isProcessed(main) then
                                local openSound = main:FindFirstChild("Open")
                                local closeSound = main:FindFirstChild("Close")
                                
                                if openSound and openSound:IsA("Sound") then
                                    openSound.SoundId = drawerOpenSoundId
                                    openSound.Volume = 2
                                end
                                
                                if closeSound and closeSound:IsA("Sound") then
                                    closeSound.SoundId = drawerCloseSoundId
                                    closeSound.Volume = 2
                                end
                                
                                markProcessed(main)
                            end
                        end
                    end
                end
            end
        end
        
        deepScanAndFix(child)
    end
end

local function setupRealtimeMonitoring(parent)
    deepScanAndFix(parent)
    
    parent.DescendantAdded:Connect(function(descendant)
        task.wait(0.1)
        
        if descendant:IsA("Model") and (descendant.Name == "Door" or descendant.Name == "DoorNormal") then
            local part = descendant:FindFirstChild("Door") or descendant:FindFirstChild("DoorNormal")
            if part and not isProcessed(part) then
                local sound = part:FindFirstChild("Open")
                if sound and sound:IsA("Sound") then
                    sound.SoundId = (descendant.Name == "DoorNormal") and normalSoundId or newSoundId
                    markProcessed(part)
                end
            end
        end
        
        if (descendant.Name == "Main" and (descendant:IsA("MeshPart") or descendant:IsA("BasePart"))) and not isProcessed(descendant) then
            local container = descendant.Parent
            if container and container.Name == "DrawerContainer" and container:IsA("Model") then
                local dresser = container.Parent
                if dresser and dresser.Name == "Dresser" and dresser:IsA("Model") then
                    local assets = dresser.Parent
                    if assets and assets.Name == "Assets" and assets:IsA("Folder") then
                        local openSound = descendant:FindFirstChild("Open")
                        local closeSound = descendant:FindFirstChild("Close")
                        
                        if openSound and openSound:IsA("Sound") then
                            openSound.SoundId = drawerOpenSoundId
                            openSound.Volume = 2
                        end
                        
                        if closeSound and closeSound:IsA("Sound") then
                            closeSound.SoundId = drawerCloseSoundId
                            closeSound.Volume = 2
                        end
                        
                        markProcessed(descendant)
                    end
                end
            end
        end
        
        if descendant.Name == "Assets" and descendant:IsA("Folder") then
            setupRealtimeMonitoring(descendant)
        end
    end)
end

if CurrentRooms then
    for _, room in ipairs(CurrentRooms:GetChildren()) do
        if room:IsA("Model") then
            setupRealtimeMonitoring(room)
        end
    end
    
    CurrentRooms.ChildAdded:Connect(function(newRoom)
        if newRoom:IsA("Model") then
            setupRealtimeMonitoring(newRoom)
        end
    end)
end

task.spawn(function()
    while true do
        task.wait(60)
        local newTable = {}
        for instance, time in pairs(processedInstances) do
            if instance and instance.Parent then
                newTable[instance] = true
            end
        end
        processedInstances = newTable
    end
end)

task.spawn(function()
    local audioLinks = {
        LB1 = "https://github.com/Zero0Star/RipperNewSound/blob/master/FigureMusicOne.mp3?raw=true",
        LB2 = "https://github.com/Zero0Star/RipperNewSound/blob/master/FigureMusicTwo.mp3?raw=true", 
        LB3 = "https://github.com/Zero0Star/RipperNewSound/blob/master/FigureMusicThree.mp3?raw=true",
        END1 = "https://github.com/Zero0Star/RipperNewSound/blob/master/FigureBoosmusic100door2.mp3?raw=true",
        END2 = "https://github.com/Zero0Star/RipperNewSound/blob/master/FigureBoss100DoorMusic1.mp3?raw=true"
    }

    local sounds = {}
    local room50Instance = nil
    local room50AmbienceDeleted = false
    local room100AudioReplaced = false

    local function GitAud(soundgit, filename)
        local url = soundgit
        local fileName = filename or "temp_audio"
        local fullFileName = fileName .. ".mp3"
        
        local success, audioData = pcall(function()
            return game:HttpGet(url, true)
        end)
        
        if not success then
            return nil
        end
        
        local writeSuccess, writeError = pcall(function()
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

    local function CreateSound(soundId, name)
        local sound = Instance.new("Sound")
        sound.SoundId = soundId
        sound.Name = name
        sound.Parent = Workspace
        sound.Volume = 0
        return sound
    end

    local function LoadAllAudios()
        for name, url in pairs(audioLinks) do
            local soundId = GitAud(url, name)
            if soundId then
                sounds[name] = CreateSound(soundId, name)
            end
        end
    end

    local function DeleteRoom50Ambience()
        if not room50Instance or room50AmbienceDeleted then
            return
        end
        
        local figureSetup = room50Instance:FindFirstChild("FigureSetup")
        if not figureSetup or not figureSetup:IsA("Folder") then
            return
        end
        
        local soundsToDelete = {
            "AmbienceStart",
            "Ambience", 
            "AmbienceEnd"
        }
        
        for _, soundName in ipairs(soundsToDelete) do
            local sound = figureSetup:FindFirstChild(soundName)
            if sound and sound:IsA("Sound") then
                sound:Destroy()
            end
        end
        
        room50AmbienceDeleted = true
    end

    local function SetupRoom50Listener()
        local currentRooms = Workspace:WaitForChild("CurrentRooms")
        
        local function HandleRoom50Added(room)
            if room.Name == "50" then
                room50Instance = room
                room50AmbienceDeleted = false
            end
        end
        
        currentRooms.ChildAdded:Connect(HandleRoom50Added)
        
        for _, room in pairs(currentRooms:GetChildren()) do
            HandleRoom50Added(room)
        end
    end

    local function HandleRoom50()
        if sounds.LB1 and sounds.LB2 and sounds.LB3 then
            local data = game.ReplicatedStorage:FindFirstChild("GameData")
            if data then
                local latest = data:FindFirstChild("LatestRoom")
                if latest then
                    local function CheckIfInRoom50()
                        return tostring(latest.Value) == "50"
                    end
                    
                    if not CheckIfInRoom50() then
                        local connection
                        connection = latest.Changed:Connect(function()
                            if CheckIfInRoom50() then
                                if connection then
                                    connection:Disconnect()
                                end
                                
                                if sounds.LB1 and sounds.LB1.Parent then
                                    DeleteRoom50Ambience()
                                    
                                    sounds.LB1.Volume = 1
                                    sounds.LB1.Playing = true
                                    
                                    sounds.LB1.Ended:Wait()
                                    
                                    if sounds.LB1 and sounds.LB1.Parent then
                                        sounds.LB1:Destroy()
                                    end
                                    sounds.LB1 = nil
                                end
                                
                                if sounds.LB2 and sounds.LB2.Parent then
                                    sounds.LB2.Volume = 1
                                    sounds.LB2.Looped = true
                                    sounds.LB2.Playing = true
                                    
                                    local lb2Connection
                                    lb2Connection = latest.Changed:Connect(function()
                                        if not CheckIfInRoom50() then
                                            if lb2Connection then
                                                lb2Connection:Disconnect()
                                            end
                                            
                                            if sounds.LB2 and sounds.LB2.Parent then
                                                sounds.LB2.Playing = false
                                                wait(0.1)
                                                sounds.LB2:Destroy()
                                            end
                                            sounds.LB2 = nil
                                            
                                            if sounds.LB3 and sounds.LB3.Parent then
                                                sounds.LB3.Volume = 1
                                                sounds.LB3.Playing = true
                                                
                                                sounds.LB3.Ended:Wait()
                                                
                                                if sounds.LB3 and sounds.LB3.Parent then
                                                    sounds.LB3:Destroy()
                                                end
                                                sounds.LB3 = nil
                                            end
                                        end
                                    end)
                                end
                            end
                        end)
                        
                        if CheckIfInRoom50() then
                            if connection then
                                connection:Disconnect()
                            end
                        end
                    else
                        if sounds.LB1 and sounds.LB1.Parent then
                            DeleteRoom50Ambience()
                            
                            sounds.LB1.Volume = 1
                            sounds.LB1.Playing = true
                            
                            sounds.LB1.Ended:Wait()
                            
                            if sounds.LB1 and sounds.LB1.Parent then
                                sounds.LB1:Destroy()
                            end
                            sounds.LB1 = nil
                        end
                        
                        if sounds.LB2 and sounds.LB2.Parent then
                            sounds.LB2.Volume = 1
                            sounds.LB2.Looped = true
                            sounds.LB2.Playing = true
                            
                            local lb2Connection
                            lb2Connection = latest.Changed:Connect(function()
                                if not CheckIfInRoom50() then
                                    if lb2Connection then
                                        lb2Connection:Disconnect()
                                    end
                                    
                                    if sounds.LB2 and sounds.LB2.Parent then
                                        sounds.LB2.Playing = false
                                        wait(0.1)
                                        sounds.LB2:Destroy()
                                    end
                                    sounds.LB2 = nil
                                    
                                    if sounds.LB3 and sounds.LB3.Parent then
                                        sounds.LB3.Volume = 1
                                        sounds.LB3.Playing = true
                                        
                                        sounds.LB3.Ended:Wait()
                                        
                                        if sounds.LB3 and sounds.LB3.Parent then
                                            sounds.LB3:Destroy()
                                        end
                                        sounds.LB3 = nil
                                    end
                                end
                            end)
                        end
                    end
                end
            end
        end
    end

    local function ForceAmbienceVolume(sound)
        if not sound or not sound:IsA("Sound") then
            return
        end
        sound.Volume = 1
        local connection
        connection = sound:GetPropertyChangedSignal("Volume"):Connect(function()
            if sound.Volume ~= 1 then
                sound.Volume = 1
            end
        end)

        sound.AncestryChanged:Connect(function()
            if not sound:IsDescendantOf(game) then
                if connection then
                    connection:Disconnect()
                end
            end
        end)
    end

    local function ReplaceRoom100Audio(room)
        if room100AudioReplaced then
            return
        end
        
        local figureSetup = room:WaitForChild("FigureSetup", 5)
        if not figureSetup or not figureSetup:IsA("Folder") then
            return
        end
        
        local ambience = figureSetup:FindFirstChild("Ambience")
        local ambienceIntense = figureSetup:FindFirstChild("AmbienceIntense")
        
        if ambienceIntense and ambienceIntense:IsA("Sound") and sounds.END1 then
            ambienceIntense.SoundId = sounds.END1.SoundId
            ambienceIntense.Volume = 1
        end
        
        if ambience and ambience:IsA("Sound") and sounds.END2 then
            ambience.SoundId = sounds.END2.SoundId
            ambience.Volume = 1
            ForceAmbienceVolume(ambience)
        end
        
        room100AudioReplaced = true
    end

    local function StartRoom100Listener()
        local currentRooms = Workspace:WaitForChild("CurrentRooms")
        
        currentRooms.ChildAdded:Connect(function(room)
            if room.Name == "100" then
                ReplaceRoom100Audio(room)
            end
        end)
        
        for _, room in pairs(currentRooms:GetChildren()) do
            if room.Name == "100" then
                ReplaceRoom100Audio(room)
            end
        end
    end

    LoadAllAudios()
    task.wait(2)
    
    SetupRoom50Listener()
    
    task.spawn(function()
        HandleRoom50()
    end)
    
    StartRoom100Listener()
end)

task.spawn(function()
    local Players = game:GetService("Players")
    local Workspace = game:GetService("Workspace")
    local TweenService = game:GetService("TweenService")
    local SoundService = game:GetService("SoundService")

    local player = Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")

    local imageFormat = {
        size = UDim2.new(0.2, 300, 0, 300),
        position = UDim2.new(0.55, -100, 0.3, -100),
        backgroundTransparency = 1,
        imageTransparency = 1,
        visible = false,
        zIndex = 10,
        anchorPoint = Vector2.new(0.5, 0.5)
    }

    local imageConfigs = {
        LB = {id = "98541250604001"},
        DD = {id = "105846818043931"},
        LG = {id = "131364920829548"}
    }

    local audioConfigs = {
        LB = "1835274270",
        DD = "https://github.com/Zero0Star/RipperNewSound/blob/master/Dark_Depth_EntranceV3.mp3?raw=true",
        LG = "7132953277"
    }

    local roomConfigs = {
        ["50"] = "LB",
        ["54"] = "DD", 
        ["91"] = "LG"
    }

    local function CreateImageLabel(name)
        local mainUI = playerGui:WaitForChild("MainUI")
        local config = imageConfigs[name]
        
        local imageLabel = Instance.new("ImageLabel")
        imageLabel.Name = name
        imageLabel.Image = "rbxassetid://" .. config.id
        imageLabel.Size = imageFormat.size
        imageLabel.Position = imageFormat.position
        imageLabel.BackgroundTransparency = imageFormat.backgroundTransparency
        imageLabel.ImageTransparency = imageFormat.imageTransparency
        imageLabel.Visible = imageFormat.visible
        imageLabel.ZIndex = imageFormat.zIndex
        imageLabel.AnchorPoint = imageFormat.anchorPoint
        imageLabel.Parent = mainUI
        
        return imageLabel
    end

    local function PlayImageAnimation(imageLabel)
        if not imageLabel then return end
        
        imageLabel.Visible = true
        
        local fadeIn = TweenService:Create(imageLabel, TweenInfo.new(1), {ImageTransparency = 0})
        fadeIn:Play()
        
        task.wait(6)
        
        local fadeOut = TweenService:Create(imageLabel, TweenInfo.new(1), {ImageTransparency = 1})
        fadeOut:Play()
        
        task.wait(1)
        
        imageLabel:Destroy()
    end

    local function PlayRobloxSound(soundId, volume)
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://" .. soundId
        sound.Parent = SoundService
        sound.Volume = volume or 1
        sound:Play()
        
        sound.Ended:Wait()
        sound:Destroy()
    end

    local function PlayGitHubSound(url, volume, filename)
        local function GitAud(soundgit, filename)
            local url = soundgit
            local fileName = filename or "temp_audio"
            local fullFileName = fileName .. ".mp3"
            
            local success, audioData = pcall(function()
                return game:HttpGet(url)
            end)
            
            if not success then
                return nil
            end
            
            local writeSuccess, writeError = pcall(function()
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
        
        local sound = Instance.new("Sound")
        local soundId = GitAud(url, filename or "github_audio")
        
        if not soundId then
            return
        end
        
        sound.SoundId = soundId
        sound.Parent = SoundService
        sound.Name = (filename or "github_audio") .. "_" .. tick()
        sound.Volume = volume or 1
        
        sound.Loaded:Wait()
        sound:Play()
        
        sound.Ended:Wait()
        sound:Destroy()
    end

    local function TriggerRoomAnimation(roomName)
        local animationType = roomConfigs[roomName]
        if not animationType then return end
        
        local mainUI = playerGui:WaitForChild("MainUI")
        local imageLabel = CreateImageLabel(animationType)
        
        task.spawn(function()
            PlayImageAnimation(imageLabel)
        end)
        
        task.spawn(function()
            if animationType == "LB" then
                PlayRobloxSound(audioConfigs.LB, 1)
            elseif animationType == "DD" then
                PlayGitHubSound(audioConfigs.DD, 1, "DD_Audio")
            elseif animationType == "LG" then
                PlayRobloxSound(audioConfigs.LG, 1)
            end
        end)
    end

    local function StartRoomListener()
        local currentRooms = Workspace:WaitForChild("CurrentRooms")
        
        currentRooms.ChildAdded:Connect(function(child)
            TriggerRoomAnimation(child.Name)
        end)
        
        for _, room in pairs(currentRooms:GetChildren()) do
            TriggerRoomAnimation(room.Name)
        end
    end

    task.wait(1)
    StartRoomListener()
end)

task.spawn(function()
    local Players = game:GetService("Players")
    local Workspace = game:GetService("Workspace")

    local function UpdateUI(player)
        if not player or not player.Parent then
            return
        end
      
        local success, mainUI = pcall(function()
            return player:WaitForChild("PlayerGui"):WaitForChild("MainUI")
        end)
        
        if not success or not mainUI then
            return
        end
        
        local success2, jumpscare = pcall(function()
            return mainUI:WaitForChild("Jumpscare")
        end)
        
        if not success2 or not jumpscare then
            return
        end

        local a90 = jumpscare:FindFirstChild("Jumpscare_A90")
        if a90 then
            local face = a90:FindFirstChild("Face")
            if face then face.Image = "rbxassetid://12635832722" end
            
            local faceAngry = a90:FindFirstChild("FaceAngry")
            if faceAngry then faceAngry.Image = "rbxassetid://12635955412" end
        end
        
        local ambush = jumpscare:FindFirstChild("Jumpscare_Ambush")
        if ambush and ambush:FindFirstChild("ImageLabel") then
            ambush.ImageLabel.Image = "rbxassetid://11684545361"
        end
    end

    for _, player in ipairs(Players:GetPlayers()) do
        task.spawn(function()
            task.wait(1)
            UpdateUI(player)
        end)

        player.CharacterAdded:Connect(function()
            task.wait(0.5)
            UpdateUI(player)
        end)
    end

    Players.PlayerAdded:Connect(function(player)
        task.spawn(function()
            task.wait(2)
            UpdateUI(player)
        end)
        
        player.CharacterAdded:Connect(function()
            task.wait(0.5)
            UpdateUI(player)
        end)
    end)
end)
Players.PlayerAdded:Connect(UpdateUI)
local hint = Instance.new("Hint", Workspace)
hint.Text = "LoadingMusic... Doors HardCore V9.9 By Mr.key & HeavenNow :)"
game.Debris:AddItem(hint, 3)