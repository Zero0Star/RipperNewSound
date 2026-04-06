local checkedEntities = {}
local listeningSounds = {}
local function runEvent()
    function GitAud(soundgit, filename)
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
    
    function CustomGitSound(soundlink, vol, filename)
        local sound = Instance.new("Sound")
        sound.SoundId = GitAud(soundlink, filename)
        if not sound.SoundId then
            return
        end
        sound.Parent = workspace
        sound.Name = filename or "GitHub_Music"
        sound.Volume = vol or 1
        sound.Loaded:Wait()
        sound:Play()
        sound.Ended:Connect(function()
            sound:Destroy()
        end)
    end
    
    local githubAudioUrl = "https://github.com/Zero0Star/RipperMPSound/blob/master/RipperNewSound.mp3?raw=true"
    local volume = 2
    local saveName = "RipperSound"
    CustomGitSound(githubAudioUrl, volume, saveName)
    
    local TweenService = game:GetService("TweenService")
    local targetColor = Color3.fromRGB(255, 93, 93)
    local fadeDuration = 1
    local fadeInfo = TweenInfo.new(
        fadeDuration,
        Enum.EasingStyle.Linear,
        Enum.EasingDirection.Out
    )
    
    local function createFadeTween(object)
        if object:IsA("BasePart") or object:IsA("Light") then
            local tween = TweenService:Create(object, fadeInfo, {Color = targetColor})
            tween:Play()
            return tween
        end
        return nil
    end
    
    local function modifyObjectsWithTween()
        local allTweens = {}
        for _, room in pairs(workspace.CurrentRooms:GetChildren()) do
            if room:IsA("Model") then
                local assets = room:FindFirstChild("Assets")
                if assets then
                    for _, chandelier in pairs(assets:GetChildren()) do
                        if chandelier:IsA("Model") and chandelier.Name == "Chandelier" then
                            local lightFixture = chandelier:FindFirstChild("LightFixture")
                            if lightFixture then
                                local pointLight = lightFixture:FindFirstChild("PointLight")
                                if pointLight and pointLight:IsA("PointLight") then
                                    table.insert(allTweens, createFadeTween(pointLight))
                                end
                                local spotLight = lightFixture:FindFirstChild("SpotLight")
                                if spotLight and spotLight:IsA("SpotLight") then
                                    table.insert(allTweens, createFadeTween(spotLight))
                                end
                                local neon = lightFixture:FindFirstChild("Neon")
                                if neon and neon:IsA("BasePart") then
                                    table.insert(allTweens, createFadeTween(neon))
                                end
                            end
                        end
                    end
                    local lightFixtures = assets:FindFirstChild("Light_Fixtures")
                    if lightFixtures then
                        for _, lightStand in pairs(lightFixtures:GetChildren()) do
                            if lightStand:IsA("Model") and lightStand.Name == "LightStand" then
                                local lightFixture = lightStand:FindFirstChild("LightFixture")
                                if lightFixture then
                                    local pointLight = lightFixture:FindFirstChild("PointLight")
                                    if pointLight and pointLight:IsA("PointLight") then
                                        table.insert(allTweens, createFadeTween(pointLight))
                                    end
                                    local neon = lightFixture:FindFirstChild("Neon")
                                    if neon and neon:IsA("BasePart") then
                                        table.insert(allTweens, createFadeTween(neon))
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    
    coroutine.wrap(function()
        modifyObjectsWithTween()
    end)()
    
    local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()
    local entity = spawner.Create({
        Entity = {
            Name = "Ripper",
            Asset = "90276221585032",
            HeightOffset = 6
        },
        Lights = {
            Flicker = {
                Enabled = false,
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
            Range = 200,
            Values = {10, 50, 0.1, 1}
        },
        Movement = {
            Speed = 180,
            Delay = 7,
            Reversed = false
        },
        Rebounding = {
            Enabled = false,
            Type = "ambush",
            Min = 4,
            Max = 4,
            Delay = math.random(10, 30) / 10
        },
        Damage = {
            Enabled = true,
            Range = 100,
            Amount = 1
        },
        Crucifixion = {
            Enabled = true,
            Range = 100,
            Resist = false,
            Break = true
        },
        Death = {
            Type = "Guiding",
            Hints = {"你死于Ripper", "它会吼叫以示它的存在", "这么做时立刻躲起来!", "他会巡查所有未躲藏之处"},
            Cause = ""
        }
    })
    
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local SHAKE_INTENSITY = 0.4
    local SHAKE_DURATION = 5
    local SHAKE_SPEED = 70
    local player = Players.LocalPlayer
    if not player then return end
    
    local camera = workspace.CurrentCamera
    local startTime = tick()
    local originalPosition = camera.CFrame.Position
    local connection
    
    connection = RunService.RenderStepped:Connect(function()
        local elapsed = tick() - startTime
        if elapsed < SHAKE_DURATION then
            local decay = 1 - (elapsed / SHAKE_DURATION)
            local intensity = SHAKE_INTENSITY * decay
            local time = elapsed * SHAKE_SPEED
            local offset = Vector3.new(
                math.sin(time * 1.1) * intensity * 0.5 + math.random(-intensity, intensity) * 0.3,
                math.cos(time * 0.9) * intensity * 0.5 + math.random(-intensity, intensity) * 0.3,
                math.sin(time * 1.0) * intensity * 0.3
            )
            local lookVector = camera.CFrame.LookVector
            local upVector = camera.CFrame.UpVector
            local rightVector = camera.CFrame.RightVector
            local currentPos = camera.CFrame.Position
            local newPos = currentPos + offset
            camera.CFrame = CFrame.new(newPos, newPos + lookVector) * CFrame.Angles(0, 0, 0)
        else
            if connection then
                connection:Disconnect()
            end
        end
    end)
    
    entity:SetCallback("OnRebounding", function(startOfRebound)
        local entityModel = entity.Model
        if entityModel then
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
        end
    end)
    
    local function playSoundOnRipperRemoved()
        local ripper = workspace:FindFirstChild("Ripper")
        if not ripper then
            wait(3)
            ripper = workspace:FindFirstChild("Ripper")
            if not ripper then
                return
            end
        end
        local connection
        connection = workspace.ChildRemoved:Connect(function(child)
            if child and child.Name == "Ripper" then
                if connection then
                    connection:Disconnect()
                end
                local sound = Instance.new("Sound")
                sound.SoundId = "rbxassetid://1837829565"
                sound.Volume = 2
                sound.Looped = false
                sound.Parent = workspace
                wait(0.2)
                if sound.IsLoaded then
                    sound.Playing = true
                    local endedConnection
                    endedConnection = sound.Ended:Connect(function()
                        if endedConnection then
                            endedConnection:Disconnect()
                        end
                        sound:Destroy()
                    end)
                    delay(10, function()
                        if sound and sound.Parent then
                            sound:Destroy()
                        end
                    end)
                else
                    sound:Destroy()
                end
            end
        end)
        delay(30, function()
            if connection and connection.Connected then
                connection:Disconnect()
            end
        end)
    end
    
    delay(2, function()
        playSoundOnRipperRemoved()
    end)
    
    entity:Run()
end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://101665501585468" then
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
----Rebound
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
    function GitAud(soundgit, filename)
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
    function CustomGitSound(soundlink, vol, filename)
        local sound = Instance.new("Sound")
        sound.SoundId = GitAud(soundlink, filename)
        if not sound.SoundId then
            return
        end
        sound.Parent = workspace
        sound.Name = filename or "GitHub_Music"
        sound.Volume = vol or 1
        sound.Loaded:Wait()
        sound:Play()
        sound.Ended:Connect(function()
            sound:Destroy()
        end)
    end
    local githubAudioUrl = "https://github.com/Zero0Star/RipperMPSound/blob/master/ReboundSoundV1.mp3?raw=true"
    local volume = 2
    local saveName = "ReboundSweep"
    CustomGitSound(githubAudioUrl, volume, saveName)
    local part = Instance.new("Part")
    part.Name = "Bound"
    part.Parent = workspace
    game.Lighting.MainColorCorrection.TintColor = Color3.fromRGB(61, 171, 98)
    game.Lighting.MainColorCorrection.Contrast = 0.2
    game.Lighting.MainColorCorrection.Saturation = -0.7
    local tween = game:GetService("TweenService")
    tween:Create(game.Lighting.MainColorCorrection, TweenInfo.new(5), {Contrast = 0}):Play()
    tween:Create(game.Lighting.MainColorCorrection, TweenInfo.new(5), {Saturation = 0}):Play()
    local TW = tween:Create(game.Lighting.MainColorCorrection, TweenInfo.new(5), {TintColor = Color3.fromRGB(255, 255, 255)})
    TW:Play()
    local CameraShaker = require(game.ReplicatedStorage.CameraShaker)
    local camara = game.Workspace.CurrentCamera
    local camShake = CameraShaker.new(Enum.RenderPriority.Camera.Value, function(shakeCf)
        camara.CFrame = camara.CFrame * shakeCf
    end)
    camShake:Start()
    camShake:ShakeOnce(10, 3, 0.1, 6, 2, 0.5)
    local speed = math.random(350, 1050)
    local delay = {"2", "2.5", "1.5", "1", "2.1"}
    local randomDelay = delay[math.random(1, #delay)]
    wait(3)
    local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()
    local entity = spawner.Create({
        Entity = {Name = "Rebound", Asset = "102940663292742", HeightOffset = 3},
        Lights = {Flicker = {Enabled = false, Duration = 10}, Shatter = false, Repair = false},
        Earthquake = {Enabled = false},
        CameraShake = {Enabled = true, Range = 200, Values = {1.5, 20, 0.1, 1}},
        Movement = {Speed = 100, Delay = 5, Reversed = true},
        Rebounding = {Enabled = false, Type = "ambush", Min = 4, Max = 4, Delay = math.random(10, 30) / 10},
        Damage = {Enabled = true, Range = 100, Amount = 1},
        Crucifixion = {Enabled = true, Range = 100, Resist = false, Break = true},
        Death = {Type = "Guiding", Hints = {"你死于Rebound", "巨大的噪音震耳欲聋", "保持时刻警惕它的存在", "祝你好运"}, Cause = ""}
    })
    function GitAud(soundgit, filename)
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
    function CustomGitSound(soundlink, vol, filename)
        local sound = Instance.new("Sound")
        sound.SoundId = GitAud(soundlink, filename)
        if not sound.SoundId then
            return
        end
        sound.Parent = workspace
        sound.Name = filename or "GitHub_Music"
        sound.Volume = vol or 1
        sound.Loaded:Wait()
        sound:Play()
        sound.Ended:Connect(function()
            sound:Destroy()
        end)
    end
    local githubAudioUrl = "https://github.com/Zero0Star/RipperMPSound/blob/master/ReboundMovings.mp3?raw=true"
    local volume = 8
    local saveName = "ReboundMovings"
    CustomGitSound(githubAudioUrl, volume, saveName)
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
    game.ReplicatedStorage.GameData.LatestRoom.Changed:Wait()
    local CameraShaker = require(game.ReplicatedStorage.CameraShaker)
    local camara = game.Workspace.CurrentCamera
    local camShake = CameraShaker.new(Enum.RenderPriority.Camera.Value, function(shakeCf)
        camara.CFrame = camara.CFrame * shakeCf
    end)
    camShake:Start()
    camShake:ShakeOnce(10, 3, 0.1, 6, 2, 0.5)
    local speed = math.random(350, 1050)
    local delay = {"2", "2.5", "1.5", "1", "2.1"}
    local randomDelay = delay[math.random(1, #delay)]
    local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()
    local entity = spawner.Create({
        Entity = {Name = "Rebound", Asset = "102940663292742", HeightOffset = 3},
        Lights = {Flicker = {Enabled = false, Duration = 10}, Shatter = false, Repair = false},
        Earthquake = {Enabled = false},
        CameraShake = {Enabled = true, Range = 200, Values = {1.5, 20, 0.1, 1}},
        Movement = {Speed = 100, Delay = 5, Reversed = false},
        Rebounding = {Enabled = false, Type = "ambush", Min = 4, Max = 4, Delay = math.random(10, 30) / 10},
        Damage = {Enabled = true, Range = 100, Amount = 1},
        Crucifixion = {Enabled = true, Range = 100, Resist = false, Break = true},
        Death = {Type = "Guiding", Hints = {"你死于Rebound", "巨大的噪音震耳欲聋", "保持时刻警惕它的存在", "祝你好运"}, Cause = ""}
    })
    function GitAud(soundgit, filename)
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
    function CustomGitSound(soundlink, vol, filename)
        local sound = Instance.new("Sound")
        sound.SoundId = GitAud(soundlink, filename)
        if not sound.SoundId then
            return
        end
        sound.Parent = workspace
        sound.Name = filename or "GitHub_Music"
        sound.Volume = vol or 1
        sound.Loaded:Wait()
        sound:Play()
        sound.Ended:Connect(function()
            sound:Destroy()
        end)
    end
    local githubAudioUrl = "https://github.com/Zero0Star/RipperMPSound/blob/master/ReboundMovings.mp3?raw=true"
    local volume = 8
    local saveName = "ReboundMovings"
    CustomGitSound(githubAudioUrl, volume, saveName)
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
    game.ReplicatedStorage.GameData.LatestRoom.Changed:Wait()
    local CameraShaker = require(game.ReplicatedStorage.CameraShaker)
    local camara = game.Workspace.CurrentCamera
    local camShake = CameraShaker.new(Enum.RenderPriority.Camera.Value, function(shakeCf)
        camara.CFrame = camara.CFrame * shakeCf
    end)
    camShake:Start()
    camShake:ShakeOnce(10, 3, 0.1, 6, 2, 0.5)
    local speed = math.random(350, 1050)
    local delay = {"2", "2.5", "1.5", "1", "2.1"}
    local randomDelay = delay[math.random(1, #delay)]
    local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()
    local entity = spawner.Create({
        Entity = {Name = "Rebound", Asset = "102940663292742", HeightOffset = 3},
        Lights = {Flicker = {Enabled = false, Duration = 10}, Shatter = false, Repair = false},
        Earthquake = {Enabled = false},
        CameraShake = {Enabled = true, Range = 200, Values = {1.5, 20, 0.1, 1}},
        Movement = {Speed = 100, Delay = 5, Reversed = true},
        Rebounding = {Enabled = false, Type = "ambush", Min = 4, Max = 4, Delay = math.random(10, 30) / 10},
        Damage = {Enabled = true, Range = 100, Amount = 1},
        Crucifixion = {Enabled = true, Range = 100, Resist = false, Break = true},
        Death = {Type = "Guiding", Hints = {"你死于Rebound", "巨大的噪音震耳欲聋", "保持时刻警惕它的存在", "祝你好运"}, Cause = ""}
    })
    function GitAud(soundgit, filename)
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
    function CustomGitSound(soundlink, vol, filename)
        local sound = Instance.new("Sound")
        sound.SoundId = GitAud(soundlink, filename)
        if not sound.SoundId then
            return
        end
        sound.Parent = workspace
        sound.Name = filename or "GitHub_Music"
        sound.Volume = vol or 1
        sound.Loaded:Wait()
        sound:Play()
        sound.Ended:Connect(function()
            sound:Destroy()
        end)
    end
    local githubAudioUrl = "https://github.com/Zero0Star/RipperMPSound/blob/master/ReboundMovings.mp3?raw=true"
    local volume = 8
    local saveName = "ReboundMovings"
    CustomGitSound(githubAudioUrl, volume, saveName)
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
    game.ReplicatedStorage.GameData.LatestRoom.Changed:Wait()
    local CameraShaker = require(game.ReplicatedStorage.CameraShaker)
    local camara = game.Workspace.CurrentCamera
    local camShake = CameraShaker.new(Enum.RenderPriority.Camera.Value, function(shakeCf)
        camara.CFrame = camara.CFrame * shakeCf
    end)
    camShake:Start()
    camShake:ShakeOnce(10, 3, 0.1, 6, 2, 0.5)
    local speed = math.random(350, 1050)
    local delay = {"2", "2.5", "1.5", "1", "2.1"}
    local randomDelay = delay[math.random(1, #delay)]
    local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()
    local entity = spawner.Create({
        Entity = {Name = "Rebound", Asset = "102940663292742", HeightOffset = 3},
        Lights = {Flicker = {Enabled = false, Duration = 10}, Shatter = false, Repair = false},
        Earthquake = {Enabled = false},
        CameraShake = {Enabled = true, Range = 200, Values = {1.5, 20, 0.1, 1}},
        Movement = {Speed = 100, Delay = 5, Reversed = false},
        Rebounding = {Enabled = false, Type = "ambush", Min = 4, Max = 4, Delay = math.random(10, 30) / 10},
        Damage = {Enabled = true, Range = 100, Amount = 1},
        Crucifixion = {Enabled = true, Range = 100, Resist = false, Break = true},
        Death = {Type = "Guiding", Hints = {"你死于Rebound", "巨大的噪音震耳欲聋", "保持时刻警惕它的存在", "祝你好运"}, Cause = ""}
    })
    function GitAud(soundgit, filename)
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
    function CustomGitSound(soundlink, vol, filename)
        local sound = Instance.new("Sound")
        sound.SoundId = GitAud(soundlink, filename)
        if not sound.SoundId then
            return
        end
        sound.Parent = workspace
        sound.Name = filename or "GitHub_Music"
        sound.Volume = vol or 1
        sound.Loaded:Wait()
        sound:Play()
        sound.Ended:Connect(function()
            sound:Destroy()
        end)
    end
    local githubAudioUrl = "https://github.com/Zero0Star/RipperMPSound/blob/master/ReboundMovings.mp3?raw=true"
    local volume = 8
    local saveName = "ReboundMovings"
    CustomGitSound(githubAudioUrl, volume, saveName)
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
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://14093035297" then
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
---------A60
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
    local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()
local entity = spawner.Create({
	Entity = {
		Name = "A60",
		Asset = "117633452506607",
		HeightOffset = 0
	},
	Lights = {
		Flicker = {
			Enabled = false,
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
		Range = 200,
		Values = {1.5, 20, 0.1, 1}
	},
	Movement = {
		Speed = 350,
		Delay = 3,
		Reversed = false
	},
	Rebounding = {
		Enabled = true,
		Type = "ambush",
		Min = 5,
		Max = 5,
		Delay = math.random(10, 30) / 10
	},
	Damage = {
		Enabled = true,
		Range = 100,
		Amount = 125
	},
	Crucifixion = {
		Enabled = true,
		Range = 100,
		Resist = false,
		Break = true
	},
	Death = {
		Type = "Guiding",
		Hints = {"你死于A60", "...", "你会从Ambush那学会点什么", "他随时可能出现!"},
		Cause = ""
	}
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
local face = workspace:WaitForChild("A60"):WaitForChild("RushNew"):WaitForChild("Main"):WaitForChild("Face")
if face and face:IsA("ParticleEmitter") then
    while true do
        face.Texture = "rbxassetid://12145534911"
        wait(0.1)
        face.Texture = "rbxassetid://12145554242"
        wait(0.1)
        face.Texture = "rbxassetid://12145599498"
        wait(0.1)
        face.Texture = "rbxassetid://12145599275"
        wait(0.1)
        face.Texture = "rbxassetid://12155335619"
        wait(0.1)
        face.Texture = "rbxassetid://12145598814"
        wait(0.1)
        face.Texture = "rbxassetid://12146135062"
        wait(0.1)
        face.Texture = "rbxassetid://11378285585"
        wait(0.1)
    end
else
end
end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://8325526433" then
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
----------A200
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
    local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()
local entity = spawner.Create({
	Entity = {
		Name = "A-200",
		Asset = "103526452499813",
		HeightOffset = 1
	},
	Lights = {
		Flicker = {
			Enabled = false,
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
		Range = 200,
		Values = {1.5, 20, 0.1, 1}
	},
	Movement = {
		Speed = 60,
		Delay = 5,
		Reversed = true
	},
	Rebounding = {
		Enabled = false,
		Type = "ambush",
		Min = 4,
		Max = 4,
		Delay = math.random(10, 30) / 10
	},
	Damage = {
		Enabled = true,
		Range = 100,
		Amount = 1
	},
	Crucifixion = {
		Enabled = true,
		Range = 100,
		Resist = false,
		Break = true
	},
	Death = {
		Type = "Guiding",
		Hints = {"你死于A-200", "竖起耳朵仔细辨别是一个麻烦", "但你不得不这么做", "你或许会在寂静那学到点什么"},
		Cause = ""
	}
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

local sound = Instance.new("Sound")
sound.Name = "A200"  
sound.SoundId = "rbxassetid://2306939610"
sound.Volume = 0.1
sound.Looped = true
sound.Parent = workspace
sound:Play()

task.wait(10)
sound:Stop()
sound:Destroy()

end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://7298463798" then
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
----Amin60
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
    local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()
local entity = spawner.Create({
	Entity = {
		Name = "Amin-60",
		Asset = "134290844453819",
		HeightOffset = 0.8
	},
	Lights = {
		Flicker = {
			Enabled = false,
			Duration = 10
		},
		Shatter = true,
		Repair = false
	},
	Earthquake = {
		Enabled = false
	},
	CameraShake = {
		Enabled = true,
		Range = 200,
		Values = {1.5, 20, 0.1, 1}
	},
	Movement = {
		Speed = 400,
		Delay = 6.5,
		Reversed = false
	},
	Rebounding = {
		Enabled = true,
		Type = "ambush",
		Min = 10,
		Max = 10,
		Delay = math.random(10, 30) / 10
	},
	Damage = {
		Enabled = true,
		Range = 100,
		Amount = 125
	},
	Crucifixion = {
		Enabled = true,
		Range = 100,
		Resist = false,
		Break = true
	},
	Death = {
		Type = "Guiding",
		Hints = {"你死于Amin-60", "极大的嘈杂声会掩盖其他声音", "他比A60更加迅速敏捷", "仔细听取木板碎裂的声音"},
		Cause = ""
	}
})

---====== Debug entity ======---

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
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://4004052860" then
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
-------blackA60
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
    local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()
local entity = spawner.Create({
	Entity = {
		Name = "Black-A60",
		Asset = "96102326082560",
		HeightOffset = 0
	},
	Lights = {
		Flicker = {
			Enabled = false,
			Duration = 10
		},
		Shatter = true,
		Repair = false
	},
	Earthquake = {
		Enabled = false
	},
	CameraShake = {
		Enabled = true,
		Range = 200,
		Values = {1.5, 20, 0.1, 1}
	},
	Movement = {
		Speed = 350,
		Delay = 6.5,
		Reversed = false
	},
	Rebounding = {
		Enabled = true,
		Type = "ambush",
		Min = 10,
		Max = 10,
		Delay = math.random(10, 30) / 10
	},
	Damage = {
		Enabled = true,
		Range = 100,
		Amount = 125
	},
	Crucifixion = {
		Enabled = true,
		Range = 100,
		Resist = false,
		Break = true
	},
	Death = {
		Type = "Guiding",
		Hints = {"你死于BlackA60", "极大的嘈杂声会掩盖其他声音", "在不妥时使用十字架会更方便", "反复进柜子躲避它"},
		Cause = ""
	}
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
end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://4903742660" then
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
------silence
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
     local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()
local entity = spawner.Create({
	Entity = {
		Name = "Silence",
		Asset = "106570553068298",
		HeightOffset = 1
	},
	Lights = {
		Flicker = {
			Enabled = false,
			Duration = 0.1
		},
		Shatter = true,
		Repair = false
	},
	Earthquake = {
		Enabled = false
	},
	CameraShake = {
		Enabled = true,
		Range = 20,
		Values = {1.5, 20, 0.1, 1}
	},
	Movement = {
		Speed = 25,
		Delay = 2,
		Reversed = false
	},
	Rebounding = {
		Enabled = false,
		Type = "Blitz",
		Min = 1,
		Max = math.random(1, 2),
		Delay = math.random(10, 30) / 10
	},
	Damage = {
		Enabled = true,
		Range = 200,
		Amount = 125
	},
	Crucifixion = {
		Enabled = true,
		Range = 200,
		Resist = false,
		Break = true
	},
	Death = {
		Type = "Guiding",
		Hints = {"你被 Silence 吞噬了...", "你该学会不在寂静中消亡", "请仔细辨别环境中的声音", "他随时都可能出现"},
		Cause = ""
	}
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
end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://135376180128296" then
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
----------firstbite
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

local s = LoadCustomInstance("98436457371270", workspace)
if not s then
    warn("Frost entity.")
    return
end

local entity = s:FindFirstChildWhichIsA("BasePart")
entity.CFrame = GetRoom():WaitForChild("RoomEntrance").CFrame * CFrame.new(0, 5, -15)
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


local pointLight = Instance.new("PointLight")
pointLight.Color = Color3.new(255, 255, 255)
pointLight.Range = 60
pointLight.Brightness = 99999
pointLight.Parent = entity

tweenservice:Create(pointLight, TweenInfo.new(3), {
    Brightness = 0
}):Play()

local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://137044859218769"
sound.Looped = false
sound.Volume = 5
sound.Parent = s
sound:Play()

local frost = Instance.new("ColorCorrectionEffect")
frost.Parent = game.Lighting
tweenservice:Create(frost, TweenInfo.new(10), {
    TintColor = Color3.fromRGB(0, 0, 255),
    Saturation = -0.7,
    Contrast = 0.2
}):Play()

for _, v in ipairs({"face", "Heylois", "BlackTrai2l", "BlackTrai3l"}) do
    if entity:FindFirstChild("Attachment") and entity.Attachment:FindFirstChild(v) then
        entity.Attachment[v].Enabled = false
    end
end

wait(8)

for _, v in ipairs({"face", "Heylois", "BlackTrai2l", "BlackTrai3l"}) do
    if entity:FindFirstChild("Attachment") and entity.Attachment:FindFirstChild(v) then
        entity.Attachment[v].Enabled = true
    end
end

pcall(function() entity.Ambience:Play() end)
pcall(function() entity.AmbienceFar:Play() end)

local dmg = true
task.spawn(function()
    while dmg do
        wait(1)
        local lighter = chr:FindFirstChild("Lighter")
        local safe = false
        if lighter then
            local handle = lighter:FindFirstChild("Handle")
            if handle then
                local holder = handle:FindFirstChild("EffectsHolder")
                if holder then
                    local attach = holder:FindFirstChild("AttachOn")
                    if attach then
                        local main = attach:FindFirstChild("MainLight")
                        if main and main:IsA("PointLight") then
                            safe = main.Enabled
                        end
                    end
                end
            end
        end
        if not safe then
            pcall(function()
                chr.Humanoid.Health -= 5
                game.ReplicatedStorage.GameStats["Player_" .. plr.Name].Total.DeathCause.Value = "Frostbite"
                
                firesignal(game.ReplicatedStorage.RemotesFolder.DeathHint.OnClientEvent, {
                        "It's a bit cold here, isn't it?",
                        "You froze to death by something.",
                        "Maybe you need some cold prevention measures. I heard that humans are very sensitive to the cold..",
                        "Try using your lighter to keep warm.",
                        "This may be a bit tricky and noisy.",
                        "You should try again.",
                        "By the way, the name of the thing that killed you is Frostbite."
                    }, "Yellow")
                
            end)
        end
    end
end)

game.ReplicatedStorage.GameData.LatestRoom.Changed:Wait()
dmg = false

for _, v in ipairs({"face", "Heylois", "BlackTrai2l", "BlackTrai3l"}) do
    if entity:FindFirstChild("Attachment") and entity.Attachment:FindFirstChild(v) then
        entity.Attachment[v].Enabled = false
    end
end

pcall(function() entity.Ambience:Stop() end)
pcall(function() entity.AmbienceFar:Stop() end)

local des = Instance.new("Sound")
des.SoundId = "rbxassetid://111715441853991"
des.Looped = false
des.Volume = 2.5
des.Parent = s
des:Play()

wait(5)
s:Destroy()

tweenservice:Create(frost, TweenInfo.new(5), {
    TintColor = Color3.fromRGB(255, 255, 255),
    Saturation = 0,
    Contrast = 0
}):Play()
wait(5)
frost:Destroy()

end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://3308152153" then
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
----DEL ALL
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
     local Event = game:GetService("ReplicatedStorage").RemotesFolder.AdminPanelRunCommand
Event:FireServer(
    "DELETE ALL",
    {}
)
    local function deleteDirectChildModels()
    local workspace = game:GetService("Workspace")
    local modelNames = {
        "A-200", "A60", "Amin-60", "Black-A60", "Deer god", "DeerGod",
        "Frostbite", "@&%^#*$Indescribable God!@$*&^!Q(* ", "LightSpeed",
        "Rebound", "Ripper", "Following_ENEMY", "Silence", "smiler", "Chainsmoker"
    }
    
    for _, name in ipairs(modelNames) do
        local model = workspace:FindFirstChild(name)
        if model and model:IsA("Model") then
            model:Destroy()
        end
    end
end

deleteDirectChildModels()

end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://140736591220630" then
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
-----smiler
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
     local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()

local entity = spawner.Create({
	Entity = {
		Name = "smiler",
		Asset = "108450814500304",
		HeightOffset = 0
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
		Range = 200,
		Values = {1.5, 20, 0.1, 1}
	},
	Movement = {
		Speed = 450,
		Delay = 11,
		Reversed = false
	},
	Rebounding = {
		Enabled = true,
		Type = "ambush",
		Min = 8,
		Max = 8,
		Delay = math.random(10, 30) / 10
	},
	Damage = {
		Enabled = true,
		Range = 200,
		Amount = 125
	},
	Crucifixion = {
		Enabled = true,
		Range = 200,
		Resist = false,
		Break = true
	},
	Death = {
		Type = "Guiding",
		Hints = {"你死于Smiler", "或许你需要在Ambush那学会点东西", "在闪灯数秒后他会出现", "加油,我相信你可以做到"},
		Cause = ""
	}
})

entity:SetCallback("OnRebounding", function(startOfRebound)
	-- Variables for the entity
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

	-- Toggle particle emitters and lights within the entityModel
	-- To switch between green & red state
	for _, c in attachment:GetChildren() do
		c.Enabled = (not startOfRebound)
	end
	for _, c in AttachmentSwitch:GetChildren() do
		c.Enabled = startOfRebound
	end

	-- Play sounds
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
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://140721035016341" then
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
----CHAINSMKER
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
     local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()
local entity = spawner.Create({
	Entity = {
		Name = "Chainsmoker",
		Asset = "121250781195971",
		HeightOffset = 1
	},
	Lights = {
		Flicker = {
			Enabled = true,
			Duration = 1
		},
		Shatter = true,
		Repair = false
	},
	Earthquake = {
		Enabled = false
	},
	CameraShake = {
		Enabled = true,
		Range = 10,
		Values = {1.5, 20, 0.1, 1}
	},
	Movement = {
		Speed = 30,
		Delay = 1,
		Reversed = false
	},
	Rebounding = {
		Enabled = false,
		Type = "ambush",
		Min = 4,
		Max = 4,
		Delay = math.random(10, 30) / 10
	},
	Damage = {
		Enabled = true,
		Range = 100,
		Amount = 125
	},
	Crucifixion = {
		Enabled = true,
		Range = 10,
		Resist = false,
		Break = true
	},
	Death = {
		Type = "Guiding",
		Hints = {"你死于Chainsmoker", "......", "或许我不能告诉你他的信息", "总而言之，当心闪灯"},
		Cause = ""
	}
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
end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://18926010713" then
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
--------deergod
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
     local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()
    
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    
    local LocalPlayer = Players.LocalPlayer
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
    
    local entityModel
    local chaseConnection = nil
    local customSpeed = 20
    local activationRange = 75
    
    local entity = spawner.Create({
        Entity = {
            Name = "Deer god",
            Asset = "94961532857273",
            HeightOffset = -0.8
        },
        Lights = {
            Flicker = {
                Enabled = true,
                Duration = 50
            },
            Shatter = true,
            Repair = false
        },
        Earthquake = {
            Enabled = false
        },
        CameraShake = {
            Enabled = true,
            Range = 1500,
            Values = {0.5, 5, 0.1, 1}
        },
        Movement = {
            Speed = 20,
            Delay = 2,
            Reversed = false
        },
        Rebounding = {
            Enabled = false,
            Type = "Blitz",
            Min = 1,
            Max = math.random(1, 2),
            Delay = math.random(10, 30) / 10
        },
        Damage = {
            Enabled = true,
            Range = 10,
            Amount = 200
        },
        Crucifixion = {
            Enabled = true,
            Range = 40,
            Resist = true,
            Break = true
        },
        Death = {
            Type = "Curious",
            Hints = {
                "It seems you are so unfortunate...", 
                "You died by the Deer God", 
                "That powerful force will drag you into the abyss.",
                "The cross cannot guarantee your safety.",
                "See you next time."
            },
            Cause = ""
        }
    })

    local function startChaseSystem()
        if not entityModel or not entityModel.PrimaryPart then
            return
        end
    
        if chaseConnection then
            chaseConnection:Disconnect()
            chaseConnection = nil
        end
    
        chaseConnection = RunService.Heartbeat:Connect(function(dt)
    
            if not entityModel 
                or not entityModel.PrimaryPart 
                or not HumanoidRootPart 
                or not HumanoidRootPart.Parent 
            then 
                return 
            end
            
            local pos = entityModel.PrimaryPart.Position
            local target = HumanoidRootPart.Position
            local distance = (target - pos).Magnitude
    
            if distance <= activationRange then
                local dir = (target - pos).Unit
                local moveVec = dir * customSpeed * dt
                local newCFrame = CFrame.new(pos + moveVec, target)
                entityModel:SetPrimaryPartCFrame(newCFrame)
            end
    
        end)
        
    end

    entity:SetCallback("OnSpawned", function()
        entityModel = entity.Model

        if entityModel then
            if not entityModel.PrimaryPart then
                local primaryPart = entityModel:FindFirstChild("Main") or entityModel:FindFirstChildWhichIsA("BasePart")
                if primaryPart then
                    entityModel.PrimaryPart = primaryPart
                end
            end
        end
    
        startChaseSystem()
    end)
    
    entity:SetCallback("OnDespawning", function()
    
        if chaseConnection then
            chaseConnection:Disconnect()
            chaseConnection = nil
        end
    end)

    entity:SetCallback("OnDamagePlayer", function(newHealth)
        if newHealth == 0 then
    
            if chaseConnection then
                chaseConnection:Disconnect()
                chaseConnection = nil
            end
    
            if entityModel and entityModel.PrimaryPart then
                local currentPos = entityModel.PrimaryPart.Position
                local forwardDir = entityModel.PrimaryPart.CFrame.LookVector
                local targetPos = currentPos + forwardDir * 10
                
                entityModel:SetPrimaryPartCFrame(CFrame.new(currentPos, targetPos))
            end
        end
    end)
    
    entity:SetCallback("OnRebounding", function(startOfRebound)
        if not entityModel then return end
        
        local main = entityModel:FindFirstChild("Main")
        if not main then return end
        
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
    
    function GitAud(soundgit, filename)
        local url = soundgit
        local FileName = filename
        writefile(FileName .. ".mp3", game:HttpGet(url))
    
        return (getcustomasset or getsynasset)(FileName .. ".mp3")
    end
    
    function CustomGitSound(soundlink, vol, filename)
        local sound = Instance.new("Sound")
        sound.SoundId = GitAud(soundlink, filename)
        sound.Parent = workspace
        sound.Name = filename or "Music"
        sound.Volume = vol or 1
        sound:Play()
    end
    
    local targetAudioUrl = "https://github.com/eoyoustme/rebouna/blob/main/HesBehindYouRUN.mp3?raw=true"
    local volume = 4
    local localFileName = "DeerGod"
    CustomGitSound(targetAudioUrl, volume, localFileName)
end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://110532875373161" then
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
-------light
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
    local Event = game:GetService("ReplicatedStorage").RemotesFolder.AdminPanelRunCommand
Event:FireServer(
    "LightRoom",
    {
        ["Light Color"] = Color3.new(1, 0.90844488143921, 0)
    }
)
wait(1)
local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()
local entity = spawner.Create({
	Entity = {
		Name = "LightSpeed",
		Asset = "87015961601567",
		HeightOffset = 1
	},
	Lights = {
		Flicker = {
			Enabled = false,
			Duration = 0.1
		},
		Shatter = false,
		Repair = false
	},
	Earthquake = {
		Enabled = false
	},
	CameraShake = {
		Enabled = true,
		Range = 20,
		Values = {90, 50, 20, 20}
	},
	Movement = {
		Speed = 1400,
		Delay = 20,
		Reversed = false
	},
	Rebounding = {
		Enabled = false,
		Type = "Blitz",
		Min = 1,
		Max = math.random(1, 2),
		Delay = math.random(10, 30) / 10
	},
	Damage = {
		Enabled = true,
		Range = 50,
		Amount = 40
	},
	Crucifixion = {
		Enabled = true,
		Range = 50,
		Resist = false,
		Break = true
	},
	Death = {
		Type = "Guiding",
		Hints = {"你死于光速", "在他来临时保证自己以最快的速度作出反应", "伴随着灯光变黄与巨大的雷电轰鸣声", "或许并不致命但总是一个威胁"},
		Cause = ""
	}
})

---====== Debug entity ======---

entity:SetCallback("OnRebounding", function(startOfRebound)
	-- Variables for the entity
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
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://1079408535" then
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
----deergodjump..
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
    local Event = game:GetService("ReplicatedStorage").RemotesFolder.AdminPanelRunCommand
Event:FireServer(
    "Break Lights",
    {
        ["Lights Affected"] = 100,
        ["Affect All Rooms"] = true
    }
)
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

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

local function createJumpScareAtPlayer()
    local jumpModel = LoadCustomInstance(78610714185582, workspace)
    if not jumpModel then
        return
    end
    
    jumpModel.Name = "DGJF"
    
    local primaryPart
    if jumpModel:IsA("Model") then
        primaryPart = jumpModel.PrimaryPart or jumpModel:FindFirstChildWhichIsA("BasePart")
        if primaryPart then
            jumpModel.PrimaryPart = primaryPart
        end
    else
        primaryPart = jumpModel
    end
    
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if rootPart and primaryPart then
        local angle = math.random() * 2 * math.pi
        local distance = math.random(5, 15)
        local offset = Vector3.new(
            math.cos(angle) * distance,
            -0.8,
            math.sin(angle) * distance
        )
        
        local spawnPosition = rootPart.Position + offset
        
        if jumpModel:IsA("Model") and jumpModel.PrimaryPart then
            jumpModel:SetPrimaryPartCFrame(CFrame.new(spawnPosition))
        else
            jumpModel.CFrame = CFrame.new(spawnPosition)
        end
        
        local camera = workspace.CurrentCamera
        local originalCameraType = camera.CameraType
        local originalSubject = camera.CameraSubject
        
        camera.CameraType = Enum.CameraType.Scriptable
        
        local lookAtPos = primaryPart.Position
        local cameraPos = lookAtPos + Vector3.new(0, 3, -7)
        camera.CFrame = CFrame.lookAt(cameraPos, lookAtPos)
        
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = 0
            humanoid.JumpPower = 0
        end
        
        spawn(function()
            createScreenFlash()
        end)
        
        wait(5)

require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("你似乎不明白",true)
wait(2)
require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("躲藏永远躲避不了我",true)
wait(2)
        local TweenService = game:GetService("TweenService")

local function showFullscreenImage()
    local player = game.Players.LocalPlayer
    local gui = player:WaitForChild("PlayerGui")
    local screenGui = Instance.new("ScreenGui", gui)
    screenGui.Name = "FullscreenImage"
    screenGui.IgnoreGuiInset = true  
    
    local image = Instance.new("ImageLabel", screenGui)
    image.Name = "FullscreenImageLabel"
    
    image.Image = "rbxassetid://115142446909754"
    image.Size = UDim2.new(2, 0, 1, 0)
    image.Position = UDim2.new(-0.5, 0, 0, 0)
    image.BackgroundTransparency = 1
    image.ImageTransparency = 1

    image.ScaleType = Enum.ScaleType.Fit
    image.BackgroundColor3 = Color3.new(0, 0, 0)
    
    local fadeIn = TweenService:Create(image, TweenInfo.new(0.01, Enum.EasingStyle.Linear), {ImageTransparency = 0})
    fadeIn:Play()

    fadeIn.Completed:Wait()
local sound = Instance.new("Sound", workspace)
sound.SoundId = "rbxassetid://116282238939992"
sound.Volume = 1
sound:Play()

replicatesignal(game.Players.LocalPlayer.Kill)
    wait(0.1)

    local fadeOut = TweenService:Create(image, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {ImageTransparency = 1})
    fadeOut:Play()
    
sound.Ended:Wait()
sound:Destroy() 
    fadeOut.Completed:Wait()
    screenGui:Destroy()
end
showFullscreenImage()

        if humanoid then
            humanoid.WalkSpeed = 16
            humanoid.JumpPower = 50
        end
        
        if camera then
            camera.CameraType = originalCameraType
            camera.CameraSubject = originalSubject
        end
    end
    
    jumpModel:Destroy()
end

local function triggerJumpScare()
    if not character or not character.Parent then
        return
    end
    
    createJumpScareAtPlayer()
end

local ripperCheckConnection
local function startRipperCheck()
    if ripperCheckConnection then
        ripperCheckConnection:Disconnect()
    end
    
    ripperCheckConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if not character or not character.Parent then
            if ripperCheckConnection then
                ripperCheckConnection:Disconnect()
            end
            return
        end
        
        local ripperModel = workspace:FindFirstChild("Ripper")
        
        if not ripperModel then
            if ripperCheckConnection then
                ripperCheckConnection:Disconnect()
            end
            triggerJumpScare()
        end
    end)
end

for _, obj in pairs(workspace:GetChildren()) do
    if obj.Name == "DGJF" then
        obj:Destroy()
    end
end

startRipperCheck()

player.CharacterAdded:Connect(function(newChar)
    character = newChar
    wait(1)
    startRipperCheck()
end)
end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://140690368868329" then
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
----curilight
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
    local Event = game:GetService("ReplicatedStorage").RemotesFolder.AdminPanelRunCommand
    Event:FireServer("Break Lights", {["Lights Affected"] = 100, ["Affect All Rooms"] = true})
    task.wait(1)
    Event:FireServer("LightRoom", {["Light Color"] = Color3.new(0.80784314870834, 0.63644915819168, 0)})
    task.wait(0.1)
    Event:FireServer("DELETE ALL", {})
    task.wait(2)
    
    local function deleteDirectChildModels()
        for _, name in ipairs({"A-200", "A60", "Amin-60", "Black-A60", "Deer god", "DeerGod", "Frostbite", "@&%^#*$Indescribable God!@$*&^!Q(* ", "LightSpeed", "Rebound", "Ripper", "Following_ENEMY", "Silence", "smiler", "Chainsmoker"}) do
            local model = workspace:FindFirstChild(name)
            if model and model:IsA("Model") then model:Destroy() end
        end
    end
    deleteDirectChildModels()
    
    function GetRoom()
        return workspace.CurrentRooms:FindFirstChild(game.ReplicatedStorage.GameData.LatestRoom.Value)
    end
    
    function LoadCustomInstance(source)
        local model
        while task.wait() and not model do
            if tonumber(source) then
                local success, result = pcall(function() return game:GetObjects("rbxassetid://"..tostring(source))[1] end)
                if success and result then model = result end
            end
        end
        if model then
            model.Parent = workspace
            for _, obj in ipairs(model:GetDescendants()) do
                if obj:IsA("Script") or obj:IsA("LocalScript") then obj:Destroy() end
            end
        end
        return model
    end
    
    local s = LoadCustomInstance("78378481962514")
    if not s then return end
    s.Name = "CuriLight"
    
    local entity = s:FindFirstChildWhichIsA("BasePart")
    if entity then entity.CFrame = GetRoom():WaitForChild("RoomEntrance").CFrame * CFrame.new(0,5,-25) end
    
    pcall(function()
        local room = workspace.CurrentRooms:FindFirstChild(tostring(game.ReplicatedStorage.GameData.LatestRoom.Value))
        if room then
            for _, obj in ipairs(room:GetDescendants()) do
                if obj.Name == "PlaySound" and obj:IsA("Sound") then
                    obj:Stop() obj.Playing = false obj.TimePosition = 0 obj.Looped = false
                end
            end
            local fireplace = room.Assets.Fireplace.Fireplace_Logs
            fireplace.ToolEventPrompt.Enabled = false
            local log = fireplace.Log
            log.SparkParticles.Enabled = false
            log.SmokeParticles.Enabled = false
            log.FireParticles.Enabled = false
            log.FireLight.Enabled = false
        end
    end)
    task.wait(0.5)
    
    function GitAud(soundgit, filename)
        local url = soundgit
        local FileName = filename
        writefile(FileName..".mp3", game:HttpGet(url))
        return (getcustomasset or getsynasset)(FileName..".mp3")
    end
    function CustomGitSound(soundlink, vol, filename)
        local sound = Instance.new("Sound")
        sound.SoundId = GitAud(soundlink, filename)
        sound.Parent = workspace
        sound.Name = filename or "CL"
        sound.Volume = vol or 1
        sound:Play()
        return sound
    end
    
    local targetAudioUrl = "https://github.com/Zero0star/RipperMPSound/blob/master/CuriLightSpeak.mp3?raw=true"
    local volume = 2
    local localFileName = "CruiMu"
    
    local function setupCuriLightFeatures()
        local CuriLight = workspace:FindFirstChild("CuriLight")
        if not CuriLight or not CuriLight:IsA("Model") then return end
        
        local humanoid = CuriLight:FindFirstChildOfClass("Humanoid")
        if not humanoid then
            humanoid = Instance.new("Humanoid")
            humanoid.Name = "Humanoid"
            humanoid.WalkSpeed = 0
            humanoid.JumpPower = 0
            humanoid.AutoRotate = false
            humanoid.Parent = CuriLight
        end
        
        local function playAnimation()
            local animator = humanoid:FindFirstChildOfClass("Animator")
            if not animator then animator = Instance.new("Animator") animator.Parent = humanoid end
            
            local animationId = "rbxassetid://122746752555782"
            local success, errorMsg = pcall(function()
                local animation = Instance.new("Animation")
                animation.AnimationId = animationId
                animation.Name = "CuriLightAnimation"
                local animationTrack = humanoid:LoadAnimation(animation)
                if animationTrack then 
                    animationTrack.Looped = true
                    animationTrack:Play()
                    return animationTrack
                end
                return nil
            end)
            
            if not success then warn("NO:", errorMsg) end
        end
        
        playAnimation()
        
        local function getPrimaryPart(model)
            if model.PrimaryPart then return model.PrimaryPart end
            local parts = {"HumanoidRootPart", "Head", "Torso", "UpperTorso", "Part"}
            for _, partName in ipairs(parts) do
                local part = model:FindFirstChild(partName)
                if part and part:IsA("BasePart") then return part end
            end
            for _, child in ipairs(model:GetChildren()) do
                if child:IsA("BasePart") then return child end
            end
            return nil
        end
        
        local curiLightPart = getPrimaryPart(CuriLight)
        if not curiLightPart then return end
        
        local CONFIG = {ROTATION_SPEED = 5, SMOOTHNESS = 0.1, HEIGHT_OFFSET = 0, MAX_DISTANCE = 100, ENABLED = true}
        local lastUpdateTime = tick()
        local connection
        
        local function updateLookAt()
            if not CONFIG.ENABLED then return end
            local character = game.Players.LocalPlayer.Character
            if not character then return end
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            if not humanoidRootPart then return end
            local distance = (humanoidRootPart.Position - curiLightPart.Position).Magnitude
            if distance > CONFIG.MAX_DISTANCE then return end
            local targetPosition = humanoidRootPart.Position + Vector3.new(0, CONFIG.HEIGHT_OFFSET, 0)
            local curiLightPosition = curiLightPart.Position
            local direction = (targetPosition - curiLightPosition).Unit
            local targetLookAt = CFrame.lookAt(curiLightPosition, curiLightPosition + direction)
            local _, currentY, _ = curiLightPart.CFrame:ToOrientation()
            local _, targetY, _ = targetLookAt:ToOrientation()
            local yawDifference = targetY - currentY
            if yawDifference > math.pi then yawDifference = yawDifference - 2 * math.pi
            elseif yawDifference < -math.pi then yawDifference = yawDifference + 2 * math.pi end
            local deltaTime = tick() - lastUpdateTime
            lastUpdateTime = tick()
            local lerpAmount = 1 - math.exp(-CONFIG.ROTATION_SPEED * deltaTime)
            local lerpedY = currentY + yawDifference * lerpAmount
            local newCFrame = CFrame.new(curiLightPosition) * CFrame.Angles(0, lerpedY, 0)
            curiLightPart.CFrame = newCFrame
        end
        
        connection = game:GetService("RunService").Heartbeat:Connect(updateLookAt)
        
        game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
            if input.KeyCode == Enum.KeyCode.T and not gameProcessed then CONFIG.ENABLED = not CONFIG.ENABLED end
        end)
        
        return CuriLight, connection
    end
    
    local curiModel, curiConnection = setupCuriLightFeatures()
    task.wait(5)
    
    local sound = CustomGitSound(targetAudioUrl, volume, localFileName)
    
    task.wait(1)
    
    require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("Dead Again",true)
    task.wait(3)
    require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("You know better than I how to save yourself.",true)
    task.wait(2.5)
    require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("OH",true)
    task.wait(1.4)
    require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("I think you are using something called admin.",true)
    task.wait(2.8)
    require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("Sorry..",true)
    task.wait(2.2)
    require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("But my appearance is not to save you.",true)
    task.wait(2.5)
    require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("In short, be careful next time...",true)
    task.wait(2.2)
    require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("However, I will always keep an eye on you.",true)
    task.wait(4)
    require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("Okey..",true)
    task.wait(2)
    require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("See U Again",true)
    
    sound.Ended:Wait()
    
    if curiConnection then curiConnection:Disconnect() end
    if curiModel then curiModel:Destroy() end
end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://100192030036066" then
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
----shoker
local checkedEntities = {}
local listeningSounds = {}

local function runEvent()
    local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local function spawnShocker()
    local shockerModel = game:GetObjects("rbxassetid://101816407601314")[1]
    local camera = Workspace.CurrentCamera

    local rootPart = shockerModel:FindFirstChild("HumanoidRootPart") or shockerModel:FindFirstChildWhichIsA("Part")
    shockerModel.PrimaryPart = rootPart
    shockerModel:SetPrimaryPartCFrame(camera.CFrame * CFrame.new(0, 0, -7))
    shockerModel.Parent = Workspace

    local oogaBoogaaPart = shockerModel:WaitForChild("OOGA BOOGAAAA")
    local horrorScream = oogaBoogaaPart:WaitForChild("HORROR SCREAM 15")
    local boneSound = oogaBoogaaPart:FindFirstChild("Bone")

    local lookDuration = 2
    local lookStart = nil
    local hasTriggered = false
    local hasFallen = false

    local function fallToGround()
        if hasFallen then return end
        hasFallen = true

        oogaBoogaaPart.Anchored = false
        oogaBoogaaPart.CanCollide = false

        task.delay(2, function()
            if shockerModel then
                shockerModel:Destroy()
            end
        end)
    end

    local connection
    connection = game:GetService("RunService").RenderStepped:Connect(function()
        if not character or not character:FindFirstChild("HumanoidRootPart") then return end
        if hasTriggered then connection:Disconnect() return end

        local directionToShocker = (oogaBoogaaPart.Position - camera.CFrame.Position).Unit
        local playerLookVector = camera.CFrame.LookVector
        local dot = directionToShocker:Dot(playerLookVector)

        if dot > 0.85 then
            -- Đang nhìn
            if not lookStart then
                lookStart = tick()
            elseif tick() - lookStart >= lookDuration then
                hasTriggered = true
                connection:Disconnect()

                horrorScream:Play()
                if boneSound then boneSound:Play() end
                humanoid:TakeDamage(30)

                -- Tween lao tới player
                local targetPos = character.HumanoidRootPart.Position + Vector3.new(0, 2, 0)
                local tweenInfo = TweenInfo.new(1.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
                local tween = TweenService:Create(oogaBoogaaPart, tweenInfo, {Position = targetPos})
                tween:Play()

                tween.Completed:Connect(function()
                    -- Sau khi lao tới thì rơi xuống đất
                    fallToGround()
                end)

                -- Death message
                ReplicatedStorage.GameStats["Player_".. player.Name].Total.DeathCause.Value = "Shocker"
                firesignal(ReplicatedStorage.RemotesFolder.DeathHint.OnClientEvent, {
                    "You died to who you call Shocker...",
                    "Don't look at it or it stuns you!"
                }, "Blue")
            end
        else
            -- Không nhìn → ngã luôn
            connection:Disconnect()
            fallToGround()
        end
    end)

    -- Dự phòng
    task.delay(5, function()
        if not hasTriggered and not hasFallen then
            fallToGround()
        end
    end)

    -- Achievement
    local achievementGiver = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Custom%20Achievements/Source.lua"))()
    achievementGiver({
        Title = "Shocking Experience",
        Desc = "Look at me.",
        Reason = "Encounter Shocker.",
        Image = "rbxassetid://17857830685"
    })
end

spawnShocker()
end

local function checkSound(sound)
    if sound:IsA("Sound") and sound.SoundId == "rbxassetid://9113115842" then
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
-------seek2
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

local targetAudioUrl = "https://github.com/Sosnen/Ping-s-Dumbass-projects-/raw/main/Here%20i%20come%20but%20WHAT%20THE%20FUCK.mp3"
local newFileName = "SeekMusicNew"
local volume = 5

local CUSTOM_SEEK_MODEL_ID = "rbxassetid://91573224733706"

if Workspace:FindFirstChild("hardcoreInit") then
    return
else
    local hardcoreInit = Instance.new("BoolValue", Workspace)
    hardcoreInit.Name = "hardcoreInit"
end

local customSeekAudio = nil
local audioLoaded = false


local function loadAudioFromGitHub()
    spawn(function()
        pcall(function()

            local audioData = game:HttpGet(targetAudioUrl)

            customSeekAudio = Instance.new("Sound")
            customSeekAudio.Name = newFileName
            customSeekAudio.Volume = volume

            customSeekAudio.SoundId = "rbxassetid://" .. tostring(math.random(1000000, 9999999))

            local audioBuffer = Instance.new("AudioBuffer")
  
            customSeekAudio.Parent = Workspace

            audioLoaded = true

        end)
    end)
end

local function replaceSeekMusic()
    Workspace.DescendantAdded:Connect(function(descendant)
        if descendant.Parent ~= nil and descendant:IsA("Sound") then

            if descendant.Name == "SeekMusic" and descendant.Parent.Name == "SeekMovingNewClone" then

                descendant.Volume = volume

                if customSeekAudio and audioLoaded then

                    descendant:Stop()

                    local clonedAudio = customSeekAudio:Clone()
                    clonedAudio.Parent = descendant.Parent
                    clonedAudio.Name = "SeekMusic"

                    clonedAudio:Play()

                else

                    pcall(function()
                        local audioData = game:HttpGet(targetAudioUrl)
                        writefile(newFileName .. ".mp3", audioData)
                        local customAsset = (getcustomasset or getsynasset)(newFileName .. ".mp3")
                        descendant.SoundId = customAsset

                    end)
                end
            end
        end
    end)
end

local function replaceSeekModel()
    ReplicatedStorage.GameData.LatestRoom.Changed:Connect(function()

        wait(3.5)

        if not Workspace:FindFirstChild("SeekMovingNewClone") then
            return
        end
        
        local originalSeek = Workspace.SeekMovingNewClone
        local originalRig = originalSeek:FindFirstChild("SeekRig")
        if not originalRig then return end

        local customSeekModel = game:GetObjects(CUSTOM_SEEK_MODEL_ID)[1]
        customSeekModel.Name = "seek2"

        for _, child in pairs(customSeekModel.Figure:GetChildren()) do
            if child:IsA("Sound") then
                child:Stop()
            end
        end

        if originalRig.Head:FindFirstChild("Eye") then
            originalRig.Head.Eye:Destroy()
        end
        if originalRig.Head:FindFirstChild("Black") then
            originalRig.Head.Black:Destroy()
        end

        for _, child in pairs(originalRig:GetDescendants()) do
            if child.Name == "StringCheese" then
                child:Destroy()
            end
        end

        customSeekModel.Parent = Workspace
        local customRig = customSeekModel:FindFirstChild("SeekRig")

        customRig:FindFirstChild("Root").Anchored = true

        spawn(function()
            while RunService.Heartbeat:Wait() and originalSeek do
                if originalRig:FindFirstChild("Root") then
                    customRig:FindFirstChild("Root").CFrame = originalRig:FindFirstChild("Root").CFrame
                end
                
                for _, sound in pairs(originalSeek.Figure:GetChildren()) do
                    if sound:IsA("Sound") then
                        sound:Stop()
                    end
                end
                
                for _, part in pairs(originalRig:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.Transparency = 1
                    end
                end
            end
        end)

        require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game)

        repeat
            task.wait()
        until originalSeek.SeekMusic.IsPlaying == true

        spawn(function()
            wait(7)
            if customSeekModel and customSeekModel.Parent then
                local figure = customSeekModel.Figure
                figure.FootstepsFar:Play()
                figure.Footsteps:Play()
                figure.Splashing:Play()
                figure["Splashing Far"]:Play()
            end
        end)

        if customRig then
            local animController = customRig.AnimationController
            local raiseAnim = animController:LoadAnimation(customRig.AnimRaise)
            raiseAnim:Play()
            raiseAnim.Stopped:Wait()
            animController:LoadAnimation(customRig.AnimRun):Play()
        end
    end)
end

loadAudioFromGitHub()

replaceSeekMusic()
replaceSeekModel()

local hint = Instance.new("Hint", Workspace)
hint.Text = "HardCoreV0.1 By Mr.key"
game.Debris:AddItem(hint, 3)
