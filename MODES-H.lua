
if workspace:FindFirstChild("hardcoreInit") then
    return
else
    local vu1 = 7
    local vu2 = 0
    local v3 = tick()
    local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()
    local vu4 = Instance.new("Hint", workspace)
    vu4.Text = "Started Loading Hardcore"
    function updt()
        game:GetService("RunService").RenderStepped:Wait()
        vu2 = vu2 + 1
        vu4.Text = string.format("Loading Hardcore... %s / %s", tostring(vu2), tostring(vu1))
    end
    local vu5 = game:GetObjects("rbxassetid://85104600103168")[1]
    updt()
    -- Dread now loads its new model when the unchanged event timer fires.
    updt()
    updt()
   
    local Workspace = game:GetService("Workspace")
    local assetFunction = getcustomasset or getsynasset

    assert(type(writefile) == "function", "writefile unavailable")
    assert(type(readfile) == "function", "readfile unavailable")
    assert(type(isfile) == "function", "isfile unavailable")
    assert(type(makefolder) == "function", "makefolder unavailable")
    assert(type(isfolder) == "function", "isfolder unavailable")
    assert(type(assetFunction) == "function", "custom asset unavailable")

    local folder = Workspace:FindFirstChild("HardCoreSound")

    if folder and not folder:IsA("Folder") then
        folder:Destroy()
        folder = nil
    end

    if not folder then
        folder = Instance.new("Folder")
        folder.Name = "HardCoreSound"
        folder.Parent = Workspace
    end

    local cacheFolder = "HardCoreMusicCache"

    if not isfolder(cacheFolder) then
        makefolder(cacheFolder)
    end

    local rawNew = "https://raw.githubusercontent.com/Zero0Star/RipperNewSound/master/"
    local rawMP = "https://raw.githubusercontent.com/Zero0Star/RipperMPSound/master/"

    local soundsData = {
        {url = rawNew .. "DreadJumpFace.mp3", name = "DreadJump", vol = 5},
        {url = rawMP .. "RipperNewSound.mp3", name = "RipperBackgroundSound", vol = 1},
        {url = rawNew .. "RipperDoorend.mp3", name = "RipperExplosionSound", vol = 1},
        {url = rawMP .. "ReboundSoundV1.mp3", name = "ReboundSweep", vol = 1},
        {url = rawMP .. "ReboundMovings.mp3", name = "ReboundMovings", vol = 1},
        {url = rawNew .. "Silence.mp3", name = "Silence", vol = 1},
        {url = rawNew .. "SilenceFar.mp3", name = "SilenceFar", vol = 1},
        {url = rawNew .. "NoRunning.mp3", name = "DeerGodMusic", vol = 1},
        {url = rawNew .. "DeerJumpScary.mp3", name = "DeerDeath", vol = 1},
        {url = rawNew .. "ScribbletEnd.mp3", name = "EndS", vol = 1},
        {url = rawNew .. "ScribbletStart.mp3", name = "StartS", vol = 1},
        {url = rawNew .. "FrostbitePhase1.mp3", name = "F1", vol = 1},
        {url = rawNew .. "FrostbitePhase2.mp3", name = "F2", vol = 1},
        {url = rawNew .. "FrostbiteEnd.mp3", name = "F3", vol = 1}
    }

    local MAX_CONCURRENT = 4
    local RETRY_DELAY = 1
    local MAX_RETRY_DELAY = 8

    local function getFilePath(data)
        return cacheFolder .. "/" .. data.name .. ".mp3"
    end

    local function isValidMP3(content)
        if type(content) ~= "string" then
            return false
        end

        if #content < 128 then
            return false
        end

        if content:sub(1, 3) == "ID3" then
            return true
        end

        local first, second = content:byte(1, 2)

        if first == 255 and second and second >= 224 then
            return true
        end

        return false
    end

    local function verifyFile(data)
        local path = getFilePath(data)

        local existsOK, exists = pcall(isfile, path)

        if not existsOK or not exists then
            return false
        end

        local readOK, content = pcall(readfile, path)

        if not readOK then
            return false
        end

        return isValidMP3(content)
    end

    local function downloadAudio(data)
        local path = getFilePath(data)

        local success, content = pcall(function()
            return game:HttpGet(data.url, true)
        end)

        if not success or not isValidMP3(content) then
            return false
        end

        local writeOK = pcall(function()
            writefile(path, content)
        end)

        if not writeOK then
            return false
        end

        if not verifyFile(data) then
            return false
        end

        return true
    end

    local function downloadBatch(list)
        if #list == 0 then
            return
        end

        local index = 0
        local finished = 0
        local workerCount = math.min(MAX_CONCURRENT, #list)

        for _ = 1, workerCount do
            task.spawn(function()
                while true do
                    index += 1

                    local data = list[index]

                    if not data then
                        break
                    end

                    pcall(downloadAudio, data)
                end

                finished += 1
            end)
        end

        repeat
            task.wait(0.05)
        until finished >= workerCount
    end

    local function collectMissingFiles()
        local missing = {}

        for _, data in ipairs(soundsData) do
            if not verifyFile(data) then
                missing[#missing + 1] = data
            end
        end

        return missing
    end

    local function createSound(data)
        if not verifyFile(data) then
            return false
        end

        local existing = folder:FindFirstChild(data.name)

        if existing and not existing:IsA("Sound") then
            existing:Destroy()
            existing = nil
        end

        if existing and existing.SoundId ~= "" then
            existing.Volume = data.vol
            return true
        end

        local success, assetId = pcall(function()
            return assetFunction(getFilePath(data))
        end)

        if not success or type(assetId) ~= "string" or assetId == "" then
            return false
        end

        local sound = existing

        if not sound then
            sound = Instance.new("Sound")
            sound.Name = data.name
        end

        sound.SoundId = assetId
        sound.Volume = data.vol
        sound.Looped = false
        sound.Parent = folder

        return true
    end

    local function verifySoundsFolder()
        for _, data in ipairs(soundsData) do
            local sound = folder:FindFirstChild(data.name)

            if not sound then
                return false
            end

            if not sound:IsA("Sound") then
                return false
            end

            if sound.SoundId == "" then
                return false
            end

            if not verifyFile(data) then
                return false
            end
        end

        return true
    end

    local function initializeAllSounds()
        local retryDelay = RETRY_DELAY

        while true do
            local missing = collectMissingFiles()

            if #missing > 0 then
                for _, data in ipairs(missing) do
                    local existing = folder:FindFirstChild(data.name)

                    if existing then
                        existing:Destroy()
                    end
                end

                downloadBatch(missing)
            end

            missing = collectMissingFiles()

            if #missing == 0 then
                local registered = true

                for _, data in ipairs(soundsData) do
                    if not createSound(data) then
                        registered = false
                    end
                end

                if registered then
                    local finalMissing = collectMissingFiles()

                    if #finalMissing == 0 and verifySoundsFolder() then
                        return true
                    end
                end
            end

            task.wait(retryDelay)
            retryDelay = math.min(retryDelay * 1.5, MAX_RETRY_DELAY)
        end
    end

    vu4.Text = "Downloading Hardcore Audio..."
    initializeAllSounds()

    local allFilesValid = false

    while not allFilesValid do
        local missing = collectMissingFiles()

        if #missing == 0 and verifySoundsFolder() then
            allFilesValid = true
        else
            if #missing > 0 then
                for _, data in ipairs(missing) do
                    local existing = folder:FindFirstChild(data.name)

                    if existing then
                        existing:Destroy()
                    end
                end

                downloadBatch(missing)
            end

            if #collectMissingFiles() == 0 then
                for _, data in ipairs(soundsData) do
                    createSound(data)
                end
            end

            task.wait(1)
        end
    end

    local legacySoundData = {
        {url = "https://github.com/Sosnen/Ping-s-Dumbass-projects-/blob/main/Ambience_Infirmary_Entrence.mp3?raw=true", name = "Legacy_Infirmary", vol = 1},
        {url = "https://github.com/Sosnen/Ping-s-Dumbass-projects-/raw/main/Figure%20Ambience.mp3?raw=true", name = "Legacy_FigureAmbience", vol = 1},
        {url = "https://github.com/Sosnen/Ping-s-Dumbass-projects-/blob/main/Figure%20End.mp3?raw=true", name = "Legacy_FigureEnd", vol = 1},
        {url = "https://github.com/Sosnen/Ping-s-Dumbass-projects-/blob/main/Figure%20Start.mp3?raw=true", name = "Legacy_FigureStart", vol = 1}
    }

    local function getLegacySound(data)
        if not verifyFile(data) and not downloadAudio(data) then
            warn("Hardcore legacy audio unavailable: " .. data.name)
            return nil
        end
        if not createSound(data) then
            warn("Hardcore legacy audio registration failed: " .. data.name)
            return nil
        end
        return folder:FindFirstChild(data.name)
    end

    local legacySounds = {}
    for _, data in ipairs(legacySoundData) do
        legacySounds[data.name] = getLegacySound(data)
    end

    local vu24 = legacySounds.Legacy_DreadDeath or Instance.new("Sound")
    local vu25 = legacySounds.Legacy_Infirmary and legacySounds.Legacy_Infirmary.SoundId or ""
    local vu28 = legacySounds.Legacy_FigureAmbience and legacySounds.Legacy_FigureAmbience.SoundId or ""
    local vu29 = legacySounds.Legacy_FigureEnd and legacySounds.Legacy_FigureEnd.SoundId or ""
    local vu30 = legacySounds.Legacy_FigureStart and legacySounds.Legacy_FigureStart.SoundId or ""
    vu4.Text = "Done! Took: " .. tostring(tick() - v3)
    game.Debris:AddItem(vu4, 3)
    local vu31 = {
        MainGame = require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game)
    }
    local vu32 = false
    local vu33 = false
    local vu34 = game:GetService("ReplicatedStorage").Sounds:FindFirstChild("LA_The Hotel")
    function PreloadSounds(p35, p36)
        if not game:GetService("ReplicatedStorage").Sounds:FindFirstChild("LA_" .. p35) then
            Sound = vu34:Clone()
            Sound.SoundId = p36
            Sound.Parent = game:GetService("ReplicatedStorage").Sounds
            Sound.Name = "LA_" .. p35
        end
    end
    print("Loade")
    game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.Health.Music.Blue.SoundId = "rbxassetid://10472612727"
    game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.Health.Music.Blue.Pitch = 0.55
    game.Lighting.FogColor = Color3.fromRGB(0, 0, 0)
    game.Lighting.FogStart = 5
    game.Lighting.FogEnd = 800
    game.ReplicatedStorage.Sounds.BulbZap.SoundId = "rbxassetid://4398878054"
    local v37 = game.ReplicatedStorage.GameData.LatestRoom.Value
    local v38 = workspace.CurrentRooms[v37]
    function changedoormaterial(p39)
        p39.Door.Material = "DiamondPlate"
        p39.Door.Color = Color3.fromRGB(80, 80, 80)
        p39.Door.Sign.Material = "Metal"
        p39.Door.Sign.Color = Color3.fromRGB(111, 111, 111)
        p39.Sign.Stinker.TextColor3 = Color3.new(0.8, 0.8, 0.8)
        p39.Sign.Stinker.Highlight.TextColor3 = Color3.new(0.6, 0.6, 0.6)
    end
    function message2(p40, p41)
        PreloadSounds(p40, p41)
        gameid = game.PlaceId
        Length = Length or 5
        if gameid ~= 6839171747 then
            if gameid == 6516141723 then
                game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Lobby.Reminder.Enabled = true
                M = require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Lobby)
            end
        else
            game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.Reminder.Enabled = true
            M = require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game)
        end
        M.titlelocation(p40)
    end
    local function vu43(p42)
        vu31.MainGame.caption(p42, true, 4)
    end
    local seekLightReplacementDelay = 0
    -- Hardcore room appearance: replacement visuals for lights, windows and chandeliers.
    -- Originals stay in place; the old ChangeStyle deletion/replacement pipeline remains disabled.
    task.spawn(function()
        local CurrentRooms = workspace:WaitForChild("CurrentRooms")

        local function loadTemplate(assetId)
            local ok, objects = pcall(function()
                return game:GetObjects("rbxassetid://" .. assetId)
            end)
            if not ok or not objects or #objects == 0 then
                return nil
            end
            local template = objects[1]
            template.Parent = nil
            return template
        end

        local LightTemplate = loadTemplate("115669442831464")
        local WindowTemplate = loadTemplate("88364164011150")
        local ChandelierTemplate = loadTemplate("137882841439230")
        local SpawnedLight = setmetatable({}, { __mode = "k" })
        local SpawnedWindow = setmetatable({}, { __mode = "k" })
        local SpawnedChandelier = setmetatable({}, { __mode = "k" })

        local function getCFrame(object)
            if not object then return nil end
            if object:IsA("Attachment") then return object.WorldCFrame end
            if object:IsA("BasePart") then return object.CFrame end
            if object:IsA("Model") then return object:GetPivot() end
            local nestedModel = object:FindFirstChildWhichIsA("Model", true)
            if nestedModel then return nestedModel:GetPivot() end
            local part = object:FindFirstChildWhichIsA("BasePart", true)
            return part and part.CFrame or nil
        end

        local function moveObject(object, targetCFrame)
            if not object or not targetCFrame then return false end
            if object:IsA("Model") then
                object:PivotTo(targetCFrame)
                return true
            elseif object:IsA("BasePart") then
                object.CFrame = targetCFrame
                return true
            end
            local parts = {}
            for _, descendant in ipairs(object:GetDescendants()) do
                if descendant:IsA("BasePart") then
                    parts[#parts + 1] = descendant
                end
            end
            if #parts == 0 then return false end
            local rootCFrame = parts[1].CFrame
            for _, part in ipairs(parts) do
                local relative = rootCFrame:ToObjectSpace(part.CFrame)
                part.CFrame = targetCFrame * relative
            end
            return true
        end

        local function validLightFixture(lightFixture)
            if not lightFixture:IsA("BasePart") or lightFixture.Name ~= "LightFixture" then
                return false
            end
            local stand = lightFixture.Parent
            local fixtures = stand and stand.Parent
            local assets = fixtures and fixtures.Parent
            local room = assets and assets.Parent
            return stand ~= nil and stand.Name == "LightStand"
                and fixtures ~= nil and fixtures.Name == "Light_Fixtures"
                and assets ~= nil and assets.Name == "Assets"
                and room ~= nil and room.Parent == CurrentRooms
        end

        local function validWindow(window)
            if window.Name ~= "Window" then return false end
            local parent = window.Parent
            if not parent then return false end
            if parent.Name == "Assets" then
                return parent.Parent ~= nil and parent.Parent.Parent == CurrentRooms
            end
            if parent.Name == "Windows" then
                local assets = parent.Parent
                return assets ~= nil and assets.Name == "Assets"
                    and assets.Parent ~= nil and assets.Parent.Parent == CurrentRooms
            end
            return false
        end

        -- Chandelier targets follow the original item reference: Assets/Chandelier
        -- and Assets/Light_Fixtures/Chandelier, each under CurrentRooms.
        local function validChandelier(chandelier)
            if chandelier.Name ~= "Chandelier" then return false end
            local parent = chandelier.Parent
            if not parent then return false end
            if parent.Name == "Assets" then
                return parent.Parent ~= nil and parent.Parent.Parent == CurrentRooms
            end
            if parent.Name == "Light_Fixtures" then
                local assets = parent.Parent
                return assets ~= nil and assets.Name == "Assets"
                    and assets.Parent ~= nil and assets.Parent.Parent == CurrentRooms
            end
            return false
        end

        local function spawnForTarget(target, template, tracked, isValid, name, location, parentForClone)
            if not template or not target or not target.Parent
                or not target:IsDescendantOf(CurrentRooms) or not isValid(target) then
                return
            end
            local existing = tracked[target]
            if existing == true or (typeof(existing) == "Instance" and existing.Parent) then
                return
            end
            local placeAt = location and location(target) or target
            local cframe = getCFrame(placeAt)
            if not cframe then return end
            tracked[target] = true
            local clone = template:Clone()
            clone.Name = name
            clone.Parent = parentForClone and parentForClone(target) or target.Parent
            if not moveObject(clone, cframe) then
                clone:Destroy()
                tracked[target] = nil
                return
            end
            tracked[target] = clone
            target.AncestryChanged:Connect(function()
                if not target:IsDescendantOf(CurrentRooms) then
                    local current = tracked[target]
                    if typeof(current) == "Instance" and current.Parent then
                        current:Destroy()
                    end
                    tracked[target] = nil
                end
            end)
        end

        local function spawnLight(lightFixture)
            spawnForTarget(lightFixture, LightTemplate, SpawnedLight, validLightFixture,
                "LoadedLight_New", function(target)
                    return target:FindFirstChild("Neon")
                end, function(target)
                    return target
                end)
        end

        local function spawnWindow(window)
            spawnForTarget(window, WindowTemplate, SpawnedWindow, validWindow,
                "LoadedWindow_88364164011150")
        end

        local function spawnChandelier(chandelier)
            spawnForTarget(chandelier, ChandelierTemplate, SpawnedChandelier,
                validChandelier, "LoadedChandelier_New")
        end

        local function checkInstance(instance)
            if not instance or not instance.Parent then return end
            if instance.Name == "LightFixture" and instance:IsA("BasePart") then
                task.defer(spawnLight, instance)
            elseif instance.Name == "Neon" then
                local lightFixture = instance.Parent
                if lightFixture and lightFixture.Name == "LightFixture"
                    and lightFixture:IsA("BasePart") then
                    task.defer(spawnLight, lightFixture)
                end
            elseif instance.Name == "Window" then
                task.defer(spawnWindow, instance)
            elseif instance.Name == "Chandelier" then
                task.defer(spawnChandelier, instance)
            end
        end

        local function scanRoom(room)
            if not room or room.Parent ~= CurrentRooms then return end
            for _, descendant in ipairs(room:GetDescendants()) do
                checkInstance(descendant)
            end
        end

        for _, room in ipairs(CurrentRooms:GetChildren()) do
            task.spawn(scanRoom, room)
        end
        CurrentRooms.ChildAdded:Connect(function(room)
            task.defer(scanRoom, room)
        end)
        CurrentRooms.DescendantAdded:Connect(checkInstance)
    end)


    local v56, v57, v58 = pairs(game.ReplicatedStorage.Misc.Eyes:GetDescendants())
    local vu59 = vu31
    while true do
        local v60
        v58, v60 = v56(v57, v58)
        if v58 == nil then
            break
        end
        if v60.Name == "Eye" and v60:IsA("Model") then
            v60:FindFirstChild("Veins").Decal.Texture = "rbxassetid://1882220622"
        end
    end
    spawn(function()
        game.ReplicatedStorage.GameData.LatestRoom.Changed:Wait()
    end)
    local vu61 = false
    game.ReplicatedStorage.GameData.LatestRoom.Changed:Connect(function(p62)
        if seekLightReplacementDelay > 0 then
            seekLightReplacementDelay = math.max(seekLightReplacementDelay - 1, 0)
        end

        if vu61 then
            if p62 == 3 then
            elseif p62 > 2 and (workspace.CurrentRooms[p62]:FindFirstChild("Assets"):FindFirstChild("Bed_Infirmary") and p62 < 80) then
                Sound = vu25
                message2("The Infirmary", Sound)
            elseif p62 > 1 and (workspace.CurrentRooms[p62]:FindFirstChild("Assets"):FindFirstChild("Garden_LanternUnique") and p62 < 99) then
                message2("The CourtYard", "rbxassetid://7132953277")
            end
            if p62 == 4 then
                vu33 = true
                vu32 = true
            elseif p62 == 6 then
                message2("The Lonely Garden", "rbxassetid://1847269119")
            elseif p62 == 7 then
                message2("The Abandoned Power Station", "rbxassetid://1837449237")
            end
            local v63 = game.ReplicatedStorage.GameData.LatestRoom.Value
            local v64 = workspace.CurrentRooms[v63]
        else
            if p62 == 49 then
            elseif p62 > 64 and (workspace.CurrentRooms[p62]:FindFirstChild("Assets"):FindFirstChild("Bed_Infirmary") and p62 < 80) then
                Sound = vu25
                message2("The Infirmary", Sound)
            elseif p62 > 80 and (workspace.CurrentRooms[p62]:FindFirstChild("Assets"):FindFirstChild("Garden_LanternUnique") and p62 < 99) then
                message2("The CourtYard", "rbxassetid://7132953277")
            end
            if p62 == 53 then
                vu33 = true
                vu32 = true
            elseif p62 == 90 then
                message2("The Lonely Garden", "rbxassetid://1847269119")
            elseif p62 == 100 then
                message2("The Abandoned Power Station", "rbxassetid://1837449237")
            end
            local v65 = game.ReplicatedStorage.GameData.LatestRoom.Value
            local v66 = workspace.CurrentRooms[v65]
        end
    end)
    workspace.Ambience_Dark.Played:Connect(function()
        vu33 = true
        wait(0.01)
        workspace.Ambience_Dark:Stop()
        game.Lighting.FogStart = 10
        game.Lighting.FogEnd = 10000000
    end)
    local v67 = game.Players.LocalPlayer.PlayerGui
    local v68 = Instance.new("Frame")
    local v69 = Instance.new("ImageLabel")
    local v70 = Instance.new("UICorner")
    local v71 = Instance.new("UIPadding")
    local v72 = Instance.new("Frame")
    local v73 = Instance.new("UICorner")
    local v74 = Instance.new("UIPadding")
    local vu75 = Instance.new("Frame")
    local v76 = Instance.new("UICorner")
    local v77 = Instance.new("ScreenGui")
    v77.Name = "StaminaGui"
    v77.ResetOnSpawn = false
    v77.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    v77.Enabled = true
    v77.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    v68.Name = "Sprint"
    v68.Parent = v77
    v68.AnchorPoint = Vector2.new(0, 1)
    v68.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    v68.BackgroundTransparency = 1
    v68.Position = UDim2.new(1.05, 0, 0.985, 0)
    v68.Size = UDim2.new(0.039, 0, 0.055, 0)
    v68.SizeConstraint = Enum.SizeConstraint.RelativeYY
    v68.ZIndex = 1005
    v69.Parent = v68
    v69.BackgroundColor3 = Color3.fromRGB(255, 222, 189)
    v69.Size = UDim2.new(1, 0, 1, 0)
    v69.SizeConstraint = Enum.SizeConstraint.RelativeYY
    v69.Visible = false
    v70.CornerRadius = UDim.new(1, 0)
    v70.Parent = v69
    v71.Parent = v68
    v71.PaddingBottom = UDim.new(0.300000012, - 5)
    v71.PaddingLeft = UDim.new(0.0199999996, 0)
    v71.PaddingRight = UDim.new(0.0500000007, - 15)
    v71.PaddingTop = UDim.new(0.300000012, - 5)
    v72.Name = "Bar"
    v72.Parent = v68
    v72.AnchorPoint = Vector2.new(0, 0.5)
    v72.BackgroundColor3 = Color3.fromRGB(56, 46, 39)
    v72.BackgroundTransparency = 0.7
    v72.Position = UDim2.new(-8.2, 0, 0.5, 0)
    v72.Size = UDim2.new(5.5, 0, 0.75, 0)
    v72.ZIndex = 0
    v73.CornerRadius = UDim.new(0.25, 0)
    v73.Parent = v72
    v74.Parent = v72
    v74.PaddingBottom = UDim.new(0, 4)
    v74.PaddingLeft = UDim.new(0, 4)
    v74.PaddingRight = UDim.new(0, 4)
    v74.PaddingTop = UDim.new(0, 4)
    vu75.Name = "Fill"
    vu75.Parent = v72
    vu75.AnchorPoint = Vector2.new(0, 0.5)
    vu75.BackgroundColor3 = Color3.fromRGB(213, 185, 158)
    vu75.Position = UDim2.new(0, 0, 0.5, 0)
    vu75.Size = UDim2.new(1, 0, 1, 0)
    vu75.ZIndex = 2
    v76.CornerRadius = UDim.new(0.25, 0)
    v76.Parent = vu75
    local v78 = Instance.new("ScreenGui")
    local vu79 = Instance.new("ImageLabel")
    v78.IgnoreGuiInset = true
    v78.Name = "erm"
    v78.ResetOnSpawn = false
    v78.Parent = v67
    v78.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    vu79.Parent = v78
    vu79.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    vu79.BackgroundTransparency = 1
    vu79.Size = UDim2.new(1, 0, 0.998717964, 0)
    vu79.Image = "rbxassetid://190596490"
    vu79.ImageColor3 = Color3.fromRGB(0, 0, 0)
    vu79.ImageTransparency = 1
    -- Sprint controller: keep the UI across respawns and rebind every new character.
    local sprintPlayers = game:GetService("Players")
    local sprintInput = game:GetService("UserInputService")
    local sprintRunService = game:GetService("RunService")
    local sprintPlayer = sprintPlayers.LocalPlayer
    local sprintCharacter = nil
    local sprintHumanoid = nil
    local sprintBindSerial = 0
    local sprintCharacterConnections = {}
    local sprintVitaminTools = {}
    local sprintMaxStamina = 100
    local sprintStamina = sprintMaxStamina
    local sprintExhausted = false
    local sprintKeyHeld = false
    local sprintMobileToggled = false
    local sprintNeedsKeyRelease = false
    local sprintVitaminCooldown = false
    local sprintDrainClock = 0
    local sprintRecoverClock = 0
    isSprinting = false

    local sprintOverlayTween = game.TweenService:Create(vu79, TweenInfo.new(12), {
        ImageTransparency = 0
    })

    local function updateSprintBar()
        vu75.Size = UDim2.new(sprintStamina / sprintMaxStamina, 1, 1, 0)
    end

    local function getSprintMovementState()
        local mainGame = vu59 and vu59.MainGame
        if not mainGame then
            return false, false
        end
        local ok, crouching, chase = pcall(function()
            return mainGame.crouching, mainGame.chase
        end)
        if not ok then
            return false, false
        end
        return crouching == true, chase == true
    end

    -- Only modify the CURRENT local character. The previous hook intercepted
    -- every Humanoid and continued referring to the character that had died.
    local oldSprintNewIndex
    oldSprintNewIndex = hookmetamethod(game, "__newindex", newcclosure(function(object, property, value)
        if property == "WalkSpeed" and object == sprintHumanoid
            and type(value) == "number" and value >= 0 then
            local crouching, chase = getSprintMovementState()
            if chase then
                value = crouching and 15 or 27
            elseif crouching then
                value = isSprinting and 12 or 10
            else
                value = isSprinting and 20 or 13
            end
        end
        return oldSprintNewIndex(object, property, value)
    end))

    local function setSprintActive(active)
        active = active == true
        if isSprinting == active then
            return
        end
        isSprinting = active

        local humanoid = sprintHumanoid
        if humanoid and humanoid.Parent and humanoid.Health > 0 then
            humanoid:SetAttribute("SpeedBoost", active and 4 or 0)
            humanoid.WalkSpeed = active and 21 or 12
        end

        if active then
            sprintOverlayTween:Play()
        else
            sprintOverlayTween:Pause()
            game.TweenService:Create(vu79, TweenInfo.new(1), {
                ImageTransparency = 1
            }):Play()
        end
    end

    local function playSprintExhaustion()
        pcall(function()
            vu43("You're exhausted.")
        end)
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://8258601891"
        sound.Volume = 0.8
        sound.PlayOnRemove = true
        sound.Parent = workspace
        sound:Destroy()
        game.TweenService:Create(vu79, TweenInfo.new(0.3), {
            ImageTransparency = 0
        }):Play()
        task.delay(0.3, function()
            if vu79.Parent then
                game.TweenService:Create(vu79, TweenInfo.new(10), {
                    ImageTransparency = 1
                }):Play()
            end
        end)
    end

    local function clearSprintCharacterConnections()
        for _, connection in ipairs(sprintCharacterConnections) do
            connection:Disconnect()
        end
        table.clear(sprintCharacterConnections)
        table.clear(sprintVitaminTools)
    end

    local function resetSprintForCharacter()
        -- Invalidate any held input and give a revived character a full bar.
        sprintKeyHeld = false
        sprintMobileToggled = false
        sprintNeedsKeyRelease = false
        sprintExhausted = false
        sprintVitaminCooldown = false
        sprintStamina = sprintMaxStamina
        sprintDrainClock = 0
        sprintRecoverClock = 0
        setSprintActive(false)
        isSprinting = false
        sprintOverlayTween:Cancel()
        vu79.ImageTransparency = 1
        updateSprintBar()
        v77.Enabled = true
    end

    local function bindSprintHumanoid(humanoid, serial)
        if sprintBindSerial ~= serial or not humanoid or not humanoid.Parent then
            return
        end
        if sprintHumanoid == humanoid then
            return
        end
        sprintHumanoid = humanoid
        humanoid:SetAttribute("SpeedBoost", 0)
        if humanoid.Health > 0 then
            humanoid.WalkSpeed = 12
        end
        local died = false
        table.insert(sprintCharacterConnections, humanoid.Died:Connect(function()
            if sprintBindSerial ~= serial or sprintHumanoid ~= humanoid then
                return
            end
            died = true
            sprintKeyHeld = false
            sprintMobileToggled = false
            setSprintActive(false)
        end))
        -- Some revival systems restore Health on the same Humanoid rather
        -- than firing CharacterAdded. Handle both revival methods.
        table.insert(sprintCharacterConnections, humanoid.HealthChanged:Connect(function(health)
            if died and health > 0 and sprintBindSerial == serial
                and sprintHumanoid == humanoid then
                died = false
                resetSprintForCharacter()
                humanoid:SetAttribute("SpeedBoost", 0)
                humanoid.WalkSpeed = 12
            end
        end))
    end

    local function refreshSprintMainGame(serial)
        -- MainUI/Main_Game can be recreated when DOORS revives the player.
        local playerGui = sprintPlayer:FindFirstChildOfClass("PlayerGui")
        local mainUI = playerGui and playerGui:WaitForChild("MainUI", 10)
        local initiator = mainUI and mainUI:WaitForChild("Initiator", 10)
        local module = initiator and initiator:WaitForChild("Main_Game", 10)
        if module and module:IsA("ModuleScript") then
            local ok, mainGame = pcall(require, module)
            if ok and sprintBindSerial == serial then
                vu59.MainGame = mainGame
            end
        end
    end

    local function bindSprintCharacter(character)
        if sprintCharacter == character then
            return
        end
        sprintBindSerial += 1
        local serial = sprintBindSerial
        clearSprintCharacterConnections()
        sprintCharacter = character
        sprintHumanoid = nil
        resetSprintForCharacter()

        local function bindVitamins(tool)
            if not tool:IsA("Tool") or tool.Name ~= "Vitamins"
                or sprintVitaminTools[tool] then
                return
            end
            sprintVitaminTools[tool] = true
            table.insert(sprintCharacterConnections, tool.Activated:Connect(function()
                if serial ~= sprintBindSerial or sprintVitaminCooldown then
                    return
                end
                local humanoid = sprintHumanoid
                if not humanoid or not humanoid.Parent or humanoid.Health <= 0 then
                    return
                end
                sprintVitaminCooldown = true
                humanoid.Health = humanoid.Health + 30
                sprintStamina = sprintMaxStamina
                sprintExhausted = false
                updateSprintBar()
                task.delay(10, function()
                    if sprintBindSerial == serial then
                        sprintVitaminCooldown = false
                    end
                end)
            end))
        end

        table.insert(sprintCharacterConnections, character.ChildAdded:Connect(function(child)
            if serial ~= sprintBindSerial then
                return
            end
            if child:IsA("Humanoid") then
                resetSprintForCharacter()
                bindSprintHumanoid(child, serial)
            else
                bindVitamins(child)
            end
        end))

        for _, child in ipairs(character:GetChildren()) do
            bindVitamins(child)
        end

        task.spawn(function()
            local humanoid = character:FindFirstChildWhichIsA("Humanoid")
                or character:WaitForChild("Humanoid", 10)
            if serial == sprintBindSerial and humanoid then
                bindSprintHumanoid(humanoid, serial)
            end
        end)
        task.spawn(refreshSprintMainGame, serial)
    end

    sprintPlayer.CharacterRemoving:Connect(function(character)
        if character == sprintCharacter then
            sprintBindSerial += 1
            clearSprintCharacterConnections()
            sprintCharacter = nil
            sprintHumanoid = nil
            resetSprintForCharacter()
        end
    end)
    sprintPlayer.CharacterAdded:Connect(bindSprintCharacter)
    if sprintPlayer.Character then
        bindSprintCharacter(sprintPlayer.Character)
    end

    if sprintInput.TouchEnabled then
        local mobileGui = Instance.new("ScreenGui")
        mobileGui.Name = "StaminaGui"
        mobileGui.ResetOnSpawn = false
        mobileGui.Enabled = true
        mobileGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        mobileGui.Parent = sprintPlayer:WaitForChild("PlayerGui")
        local sprintButton = Instance.new("TextButton")
        sprintButton.Name = "SprintButton"
        sprintButton.BackgroundTransparency = 0.5
        sprintButton.BackgroundColor3 = Color3.new(0, 0, 0)
        sprintButton.Position = UDim2.new(1, -200, 1, -250)
        sprintButton.Size = UDim2.new(0, 65, 0, 65)
        sprintButton.Text = "Sprint"
        sprintButton.TextColor3 = Color3.new(1, 1, 1)
        sprintButton.FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Light)
        sprintButton.TextScaled = true
        sprintButton.Parent = mobileGui
        Instance.new("UICorner", sprintButton).CornerRadius = UDim.new(0, 50)
        local stroke = Instance.new("UIStroke", sprintButton)
        stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        stroke.Thickness = 2
        sprintButton.MouseButton1Click:Connect(function()
            local crouching = getSprintMovementState()
            if not sprintHumanoid or sprintHumanoid.Health <= 0 or sprintExhausted
                or crouching or not sprintCharacter
                or sprintCharacter:GetAttribute("Hiding") then
                sprintMobileToggled = false
                return
            end
            sprintMobileToggled = not sprintMobileToggled
        end)
    end

    sprintInput.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == Enum.KeyCode.Q then
            if not sprintNeedsKeyRelease then
                sprintKeyHeld = true
            end
        end
    end)
    sprintInput.InputEnded:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.Q then
            sprintKeyHeld = false
            sprintNeedsKeyRelease = false
        end
    end)

    -- Single lifetime stamina loop. Unlike the original nested InputBegan loops,
    -- this loop never keeps a reference to a dead Humanoid after a respawn.
    sprintRunService.Heartbeat:Connect(function(dt)
        local humanoid = sprintHumanoid
        if not (humanoid and humanoid.Parent and humanoid.Health > 0
            and sprintCharacter == sprintPlayer.Character) then
            if isSprinting then
                setSprintActive(false)
            end
            return
        end

        local crouching = getSprintMovementState()
        local hiding = sprintCharacter:GetAttribute("Hiding") == true
        local wantsSprint = sprintKeyHeld or sprintMobileToggled
        local allowed = wantsSprint and not sprintExhausted and sprintStamina > 0
            and not crouching and not hiding

        setSprintActive(allowed)
        if allowed then
            sprintRecoverClock = 0
            sprintDrainClock += dt
            while sprintDrainClock >= 0.06 and sprintStamina > 0 do
                sprintDrainClock -= 0.06
                sprintStamina -= 1
            end
            updateSprintBar()
            if sprintStamina <= 0 then
                sprintStamina = 0
                sprintExhausted = true
                sprintNeedsKeyRelease = sprintKeyHeld
                sprintKeyHeld = false
                sprintMobileToggled = false
                setSprintActive(false)
                playSprintExhaustion()
            end
        else
            sprintDrainClock = 0
            if sprintStamina < sprintMaxStamina then
                sprintRecoverClock += dt
                local recoveryInterval = sprintInput.TouchEnabled
                    and (sprintExhausted and 0.075 or 0.06) or 0.12
                while sprintRecoverClock >= recoveryInterval
                    and sprintStamina < sprintMaxStamina do
                    sprintRecoverClock -= recoveryInterval
                    sprintStamina += 1
                end
                updateSprintBar()
            else
                sprintRecoverClock = 0
            end
            if sprintStamina >= sprintMaxStamina then
                sprintExhausted = false
            end
        end
    end)
    function DEATHMESSAGE(pu109, pu110)
        spawn(function()
            for _ = 1, 50 do
                wait()
                game:GetService("ReplicatedStorage").GameStats["Player_" .. game.Players.LocalPlayer.Name].Total.DeathCause.Value = pu110
                firesignal(game:GetService("ReplicatedStorage").RemotesFolder.DeathHint.OnClientEvent, pu109, "Blue")
            end
        end)
    end

    do
        local Players = game:GetService("Players")
        local Workspace = game:GetService("Workspace")
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local TweenService = game:GetService("TweenService")
        local SoundService = game:GetService("SoundService")
        local RunService = game:GetService("RunService")
        local Lighting = game:GetService("Lighting")
        local Debris = game:GetService("Debris")

        local player = Players.LocalPlayer
        local playerGui = player:WaitForChild("PlayerGui")
        local gameData = ReplicatedStorage:WaitForChild("GameData")
        local latestRoom = gameData:WaitForChild("LatestRoom")
        local currentRooms = Workspace:WaitForChild("CurrentRooms")

        local room50SequenceStarted = false
        local cachedStartPosition = nil
        local cachedWaypointPositions = {}
        local commonSenceModel = nil
        local commonSenceActive = false
        local a60Model = nil
        local a60Active = false
        local jumpscareActive = false
        local room50DeathMessage

local function getObjectCFrame(object)
    if not object then
        return CFrame.new()
    end

    if object:IsA("Model") then
        return object:GetPivot()
    end

    if object:IsA("BasePart") then
        return object.CFrame
    end

    return CFrame.new()
end

local function setObjectCFrame(object, targetCFrame)
    if not object then
        return
    end

    if object:IsA("Model") then
        object:PivotTo(targetCFrame)
    elseif object:IsA("BasePart") then
        object.CFrame = targetCFrame
    end
end

local function ensurePrimaryPart(model)
    if not model then
        return false
    end

    if model:IsA("BasePart") then
        return true
    end

    if not model:IsA("Model") then
        return false
    end

    if not model.PrimaryPart then
        for _, part in ipairs(model:GetDescendants()) do
            if part:IsA("BasePart") then
                model.PrimaryPart = part
                break
            end
        end
    end

    return model.PrimaryPart ~= nil
end

local function getRoom50Data()
    local room50 = currentRooms:FindFirstChild("50")
    if not room50 then
        room50 = currentRooms:WaitForChild("50", 10)
    end

    if not room50 then
        return nil, {}
    end

    local door = room50:FindFirstChild("Door", true)
    local hidden = door and door:FindFirstChild("Hidden")
    local startPosition = hidden and hidden:IsA("BasePart") and hidden.Position or nil

    local figureSetup = room50:FindFirstChild("FigureSetup")
    local nodesFolder = figureSetup and figureSetup:FindFirstChild("FigureNodes")
    local waypoints = {}

    if nodesFolder then
        for _, waypoint in ipairs(nodesFolder:GetChildren()) do
            if waypoint:IsA("BasePart") then
                table.insert(waypoints, waypoint.Position)
            end
        end
    end

    return startPosition, waypoints
end

local function loadAssetModel(assetId)
    local ok, models = pcall(function()
        return game:GetObjects("rbxassetid://" .. tostring(assetId))
    end)

    if ok and type(models) == "table" and models[1] then
        return models[1]
    end

    return nil
end
local function shatterLatestRoom()
    local speed = 100
    local shatterAmount = 100
    local latestRoomValue = latestRoom.Value
    local room = currentRooms:FindFirstChild(tostring(latestRoomValue))

    if not room then
        return
    end

    pcall(function()
        local modulesClient = ReplicatedStorage:WaitForChild("ModulesClient")
        local moduleEvents = require(modulesClient:WaitForChild("Module_Events"))
        moduleEvents.shatter(room, speed, shatterAmount, Random.new(tick()))
    end)
end
local function startIconGlitchMonitor()
    local active = true
    local connections = {}
    local watchedPermUIs = {}
    local watchedHints = {}
    local watchedIcons = {}
    local symbols = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "#", "￥", "*", "!"}

    local function connect(signal, callback)
        local connection = signal:Connect(callback)
        table.insert(connections, connection)
        return connection
    end

    local function scrambleTextLabel(label)
        if not active or not label or not label:IsA("TextLabel") then
            return
        end

        label.Text = symbols[math.random(1, #symbols)]
    end

    local function watchIcon(icon)
        if not active or not icon or icon.Name ~= "Icon" then
            return
        end

        for _, descendant in ipairs(icon:GetDescendants()) do
            if descendant:IsA("TextLabel") then
                scrambleTextLabel(descendant)
            end
        end

        if watchedIcons[icon] then
            return
        end

        watchedIcons[icon] = true

        connect(icon.DescendantAdded, function(descendant)
            if descendant:IsA("TextLabel") then
                scrambleTextLabel(descendant)
            elseif descendant.Name == "TextLabel" then
                scrambleTextLabel(descendant)
            end
        end)

        local directLabel = icon:FindFirstChild("TextLabel")
        if directLabel and directLabel:IsA("TextLabel") then
            scrambleTextLabel(directLabel)
        end
    end

    local function inspectHintDescendant(descendant)
        if not active then
            return
        end

        if descendant.Name == "Icon" then
            watchIcon(descendant)
        elseif descendant:IsA("TextLabel") and descendant.Parent and descendant.Parent.Name == "Icon" then
            scrambleTextLabel(descendant)
        end
    end

    local function watchHints(hints)
        if not active or not hints or watchedHints[hints] then
            return
        end

        watchedHints[hints] = true

        for _, descendant in ipairs(hints:GetDescendants()) do
            inspectHintDescendant(descendant)
        end

        connect(hints.DescendantAdded, inspectHintDescendant)

        for _, child in ipairs(hints:GetChildren()) do
            if child.Name == "Icon" then
                watchIcon(child)
            end
        end
    end

    local function watchPermUI(permUI)
        if not active or not permUI or watchedPermUIs[permUI] then
            return
        end

        watchedPermUIs[permUI] = true

        for _, descendant in ipairs(permUI:GetDescendants()) do
            if descendant.Name == "Hints" then
                watchHints(descendant)
            elseif descendant.Name == "Icon" then
                watchIcon(descendant)
            end
        end

        connect(permUI.DescendantAdded, function(descendant)
            if not active then
                return
            end

            if descendant.Name == "Hints" then
                watchHints(descendant)
            elseif descendant.Name == "Icon" then
                watchIcon(descendant)
            elseif descendant:IsA("TextLabel") and descendant.Parent and descendant.Parent.Name == "Icon" then
                scrambleTextLabel(descendant)
            end
        end)
    end

    local function scanForPermUI()
        if not active then
            return
        end

        local permUI = playerGui:FindFirstChild("PermUI") or player:FindFirstChild("PermUI")
        if permUI then
            watchPermUI(permUI)
        end
    end

    scanForPermUI()

    connect(playerGui.DescendantAdded, function(descendant)
        if not active then
            return
        end

        if descendant.Name == "PermUI" then
            watchPermUI(descendant)
        elseif descendant.Name == "Hints" then
            watchHints(descendant)
        elseif descendant.Name == "Icon" then
            watchIcon(descendant)
        elseif descendant:IsA("TextLabel") and descendant.Parent and descendant.Parent.Name == "Icon" then
            scrambleTextLabel(descendant)
        end
    end)

    connect(player.DescendantAdded, function(descendant)
        if not active then
            return
        end

        if descendant.Name == "PermUI" then
            watchPermUI(descendant)
        elseif descendant.Name == "Hints" then
            watchHints(descendant)
        elseif descendant.Name == "Icon" then
            watchIcon(descendant)
        elseif descendant:IsA("TextLabel") and descendant.Parent and descendant.Parent.Name == "Icon" then
            scrambleTextLabel(descendant)
        end
    end)

    return function()
        if not active then
            return
        end

        active = false

        for _, connection in ipairs(connections) do
            pcall(function()
                connection:Disconnect()
            end)
        end

        table.clear(connections)
    end
end

local function moveToPosition(model, targetPosition, speed, heightOffset, isActive)
    if not model or not model.Parent then
        return
    end

    local startCFrame = getObjectCFrame(model)
    local startPosition = startCFrame.Position
    local endPosition = Vector3.new(
        targetPosition.X,
        targetPosition.Y + (heightOffset or 3),
        targetPosition.Z
    )

    local distance = (endPosition - startPosition).Magnitude
    if distance <= 0.001 then
        return
    end

    local duration = distance / math.max(speed, 1)
    local startTime = tick()

    while tick() - startTime < duration do
        if not model or not model.Parent or (isActive and not isActive()) then
            return
        end

        local progress = math.min((tick() - startTime) / duration, 1)
        local currentPosition = startPosition:Lerp(endPosition, progress)
        setObjectCFrame(model, CFrame.new(currentPosition))
        RunService.Heartbeat:Wait()
    end

    if model and model.Parent and (not isActive or isActive()) then
        setObjectCFrame(model, CFrame.new(endPosition))
    end
end

local function getNearestWaypoint(currentPosition, remainingWaypoints, heightOffset)
    local nearestIndex = nil
    local nearestDistance = math.huge

    for index, waypointPosition in ipairs(remainingWaypoints) do
        local adjustedPosition = Vector3.new(
            waypointPosition.X,
            waypointPosition.Y + (heightOffset or 3),
            waypointPosition.Z
        )

        local distance = (adjustedPosition - currentPosition).Magnitude
        if distance < nearestDistance then
            nearestDistance = distance
            nearestIndex = index
        end
    end

    return nearestIndex
end

local function moveThroughWaypointsOnce(model, waypointPositions, speed, isActive)
    if not model or not model.Parent or #waypointPositions == 0 then
        return
    end

    local remainingWaypoints = {}
    for _, waypointPosition in ipairs(waypointPositions) do
        table.insert(remainingWaypoints, waypointPosition)
    end

    local visitedWaypoints = {}
    local currentPosition = getObjectCFrame(model).Position

    while #remainingWaypoints > 0 do
        if not model or not model.Parent or (isActive and not isActive()) then
            break
        end

        local nearestIndex = getNearestWaypoint(currentPosition, remainingWaypoints, 3)
        if not nearestIndex then
            break
        end

        local waypointPosition = remainingWaypoints[nearestIndex]
        moveToPosition(model, waypointPosition, speed, 3, isActive)

        if not model or not model.Parent or (isActive and not isActive()) then
            break
        end

        currentPosition = getObjectCFrame(model).Position
        table.insert(visitedWaypoints, waypointPosition)
        table.remove(remainingWaypoints, nearestIndex)
    end

    for index = #visitedWaypoints - 1, 1, -1 do
        if not model or not model.Parent or (isActive and not isActive()) then
            break
        end

        moveToPosition(model, visitedWaypoints[index], speed, 3, isActive)
        currentPosition = getObjectCFrame(model).Position
    end

    for index = 2, #visitedWaypoints do
        if not model or not model.Parent or (isActive and not isActive()) then
            break
        end

        moveToPosition(model, visitedWaypoints[index], speed, 3, isActive)
        currentPosition = getObjectCFrame(model).Position
    end
end

local function hasLineOfSightToCharacter(entity, entityPosition, playerPosition, character)
    local direction = playerPosition - entityPosition
    if direction.Magnitude <= 0.001 then
        return true
    end

    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    raycastParams.FilterDescendantsInstances = {entity}
    raycastParams.IgnoreWater = true

    local result = Workspace:Raycast(entityPosition, direction, raycastParams)
    return result ~= nil and result.Instance ~= nil and result.Instance:IsDescendantOf(character)
end

local function setupAttackDetection(entity, attackRange, damage, deathMessages, deathCause, isActive)
    task.spawn(function()
        local isAttacking = false

        while entity and entity.Parent and isActive() do
            task.wait(0.5)

            local character = player.Character
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")
            local rootPart = character and character:FindFirstChild("HumanoidRootPart")

            if humanoid and rootPart and humanoid.Health > 0 and entity and entity.Parent and isActive() then
                local entityPosition = getObjectCFrame(entity).Position
                local playerPosition = rootPart.Position
                local distance = (playerPosition - entityPosition).Magnitude

                if distance <= attackRange and hasLineOfSightToCharacter(entity, entityPosition, playerPosition, character) then
                    if not isAttacking then
                        isAttacking = true

                        pcall(function()
                            humanoid:TakeDamage(damage)
                        end)

                        room50DeathMessage(deathMessages, deathCause)
                        task.wait(1)
                        isAttacking = false
                    end
                end
            end
        end
    end)
end

local function playA60Jumpscare()
    local jumpSound = Instance.new("Sound")
    jumpSound.Parent = Workspace
    jumpSound.Volume = 10
    jumpSound.SoundId = "rbxassetid://103879029437685"
    jumpSound:Play()
    Debris:AddItem(jumpSound, 20)

    local jumpscareGui = Instance.new("ScreenGui")
    jumpscareGui.Name = "A60Jumpscare"
    jumpscareGui.ResetOnSpawn = false
    jumpscareGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    jumpscareGui.Parent = playerGui

    local jumpscareEnd = Instance.new("ImageLabel")
    jumpscareEnd.Name = "JumpscareEnd"
    jumpscareEnd.Parent = jumpscareGui
    jumpscareEnd.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    jumpscareEnd.BackgroundTransparency = 1
    jumpscareEnd.Position = UDim2.new(0.468, 0, 0.455, 0)
    jumpscareEnd.Size = UDim2.new(0.064, 0, 0.088, 0)
    jumpscareEnd.Image = "rbxassetid://0"
    jumpscareEnd.ImageColor3 = Color3.fromRGB(255, 0, 4)
    jumpscareEnd.ZIndex = 10

    local fullScreen = Instance.new("ImageLabel")
    fullScreen.Name = "Full"
    fullScreen.Parent = jumpscareGui
    fullScreen.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    fullScreen.BackgroundTransparency = 1
    fullScreen.Position = UDim2.new(-0.061, 0, -0.224, 0)
    fullScreen.Size = UDim2.new(1.122, 0, 1.447, 0)
    fullScreen.Image = "rbxassetid://11151804223"
    fullScreen.ImageTransparency = 1
    fullScreen.ZIndex = 5

    local entity = Workspace:FindFirstChild("A-60")
    local rushModel = entity and entity:FindFirstChild("RushNew")

    if not rushModel then
        jumpscareGui:Destroy()
        jumpscareActive = false
        return
    end

    local camera = Workspace.CurrentCamera
    if not camera then
        jumpscareGui:Destroy()
        jumpscareActive = false
        return
    end

    local cameraShaker = nil
    local shakerModuleScript = ReplicatedStorage:FindFirstChild("CameraShaker")

    if not shakerModuleScript then
        pcall(function()
            shakerModuleScript = ReplicatedStorage:WaitForChild("CameraShaker", 2)
        end)
    end

    if shakerModuleScript then
        local success, shakerModule = pcall(require, shakerModuleScript)
        if success and shakerModule then
            pcall(function()
                cameraShaker = shakerModule.new(Enum.RenderPriority.Camera.Value, function(cameraShake)
                    local currentCamera = Workspace.CurrentCamera
                    if currentCamera then
                        currentCamera.CFrame = currentCamera.CFrame * cameraShake
                    end
                end)
                cameraShaker:Start()
                cameraShaker:ShakeOnce(25, 25, 0, 4, 90, 60)
            end)
        end
    end

    local a60Clone = rushModel:Clone()
    a60Clone.Name = "A-60_SCARE"
    a60Clone.Parent = camera

    for _, descendant in ipairs(a60Clone:GetDescendants()) do
        if descendant:IsA("Sound") then
            descendant:Destroy()
        end
    end

    local faceImages = a60Clone:FindFirstChild("IMAGEIDS", true)
    if faceImages then
        task.spawn(function()
            while a60Clone.Parent do
                local images = faceImages:GetChildren()
                if #images > 0 then
                    local randomImage = images[math.random(1, #images)]
                    local mainFace = a60Clone:FindFirstChild("Main", true)
                    local face = mainFace and mainFace:FindFirstChild("Face")
                    if face then
                        pcall(function()
                            face.Texture = randomImage.Image
                        end)
                    end
                end
                task.wait(math.random(0, 20) / 1000)
            end
        end)
    end

    local colorEffect = Instance.new("ColorCorrectionEffect")
    colorEffect.Parent = Lighting

    TweenService:Create(colorEffect, TweenInfo.new(0.5), {
        Brightness = 0.2,
        Contrast = 0.2,
        Saturation = -0.2,
        TintColor = Color3.fromRGB(255, 0, 4)
    }):Play()

    local targetOffset = Vector3.new(0, -1.2, -5)
    local startCFrame = camera.CFrame * CFrame.new(0, -1.2, -20)
    local targetCFrame = camera.CFrame * CFrame.new(targetOffset)
    setObjectCFrame(a60Clone, startCFrame)

    local approachStart = tick()
    while tick() - approachStart < 0.5 and a60Clone.Parent do
        local alpha = math.clamp((tick() - approachStart) / 0.5, 0, 1)
        setObjectCFrame(a60Clone, startCFrame:Lerp(targetCFrame, alpha))
        task.wait()
    end

    local mainFace = a60Clone:FindFirstChild("Main", true)
    local face = mainFace and mainFace:FindFirstChild("Face")

    if face then
        pcall(function()
            jumpscareEnd.Image = face.Texture
        end)
    end

    TweenService:Create(jumpscareEnd, TweenInfo.new(0.5), {
        Size = fullScreen.Size,
        Position = fullScreen.Position,
        Rotation = math.random(-20, 20)
    }):Play()

    TweenService:Create(colorEffect, TweenInfo.new(10), {
        Brightness = 0,
        Contrast = 0,
        Saturation = 0,
        TintColor = Color3.fromRGB(255, 255, 255)
    }):Play()

    local retreatStart = getObjectCFrame(a60Clone)
    local retreatEnd = camera.CFrame * CFrame.new(0, -1.2, 45)
    local retreatTime = tick()

    while tick() - retreatTime < 1 and a60Clone.Parent do
        local alpha = math.clamp((tick() - retreatTime) / 1, 0, 1)
        setObjectCFrame(a60Clone, retreatStart:Lerp(retreatEnd, alpha))
        task.wait()
    end

    task.wait(0.5)

    TweenService:Create(jumpscareEnd, TweenInfo.new(0.5), {
        ImageTransparency = 1
    }):Play()

    task.wait(0.5)

    if a60Clone.Parent then
        a60Clone:Destroy()
    end

    task.wait(2)

    if colorEffect.Parent then
        colorEffect:Destroy()
    end

    task.wait(1)

    if jumpscareGui.Parent then
        jumpscareGui:Destroy()
    end

    if cameraShaker then
        pcall(function()
            cameraShaker:Stop()
        end)
    end

    jumpscareActive = false
end
local function spawnA60()
    if a60Active then
        return
    end

    local model = loadAssetModel("117633452506607")
    if not model then
        return
    end

    a60Model = model
    a60Model.Name = "A-60"
    a60Model.Parent = Workspace

    ensurePrimaryPart(a60Model)

    if not cachedStartPosition or #cachedWaypointPositions == 0 then
        local startPosition, waypoints = getRoom50Data()
        if startPosition then
            cachedStartPosition = startPosition
        end
        if #waypoints > 0 then
            cachedWaypointPositions = waypoints
        end
    end

    if cachedStartPosition then
        setObjectCFrame(a60Model, CFrame.new(cachedStartPosition + Vector3.new(0, 3, 0)))
    end

    a60Active = true

    local deathMessages = {
        "You were defeated by A-60...",
        "Amid the huge noise, I can sense your presence.",
        "Keep your distance and find a safe spot"
    }

    local function isA60Active()
        return a60Active and a60Model == model and model.Parent ~= nil
    end

    setupAttackDetection(model, 70, 100, deathMessages, "A-60", isA60Active)

    task.spawn(function()
        while isA60Active() do
            moveThroughWaypointsOnce(model, cachedWaypointPositions, 140, isA60Active)
            task.wait(0.1)
        end
    end)

    task.spawn(function()
        local rushNew = model:FindFirstChild("RushNew", true)
        local main = rushNew and rushNew:FindFirstChild("Main", true)
        local face = main and main:FindFirstChild("Face")

        if face and face:IsA("ParticleEmitter") then
            local textures = {
                "rbxassetid://12145534911",
                "rbxassetid://12145554242",
                "rbxassetid://12145599498",
                "rbxassetid://12145599275",
                "rbxassetid://12155335619",
                "rbxassetid://12145598814",
                "rbxassetid://12146135062",
                "rbxassetid://11378285585"
            }

            local index = 1
            while isA60Active() and face.Parent do
                face.Texture = textures[index]
                index = index + 1
                if index > #textures then
                    index = 1
                end
                task.wait(0.1)
            end
        end
    end)

    task.delay(60, function()
        if a60Model == model then
            a60Active = false
            if model and model.Parent then
                model:Destroy()
            end
            a60Model = nil
        end
    end)
end

local function spawnCommonSence()
    if commonSenceActive then
        return
    end

    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local RunService = game:GetService("RunService")

    local Player = Players.LocalPlayer

    local OldEntity = workspace:FindFirstChild("Common Sence")
    if OldEntity then
        pcall(function()
            OldEntity:Destroy()
        end)
    end

    local function setDeathCause(cause)
        local gameStats = ReplicatedStorage:FindFirstChild("GameStats")
        if not gameStats then
            return
        end
        local playerStats = gameStats:FindFirstChild("Player_" .. Player.Name)
        if not playerStats then
            return
        end
        local total = playerStats:FindFirstChild("Total")
        if not total then
            return
        end
        local deathCause = total:FindFirstChild("DeathCause")
        if deathCause then
            deathCause.Value = cause
        end
    end

    local success, models = pcall(function()
        return game:GetObjects("rbxassetid://112572076699068")
    end)
    if not success or not models or not models[1] then
        return
    end

    local figureModel = models[1]
    figureModel.Name = "Common Sence"
    figureModel.Parent = workspace

    local EntityRunning = true
    local IsAttacking = false
    commonSenceModel = figureModel
    commonSenceActive = true

    local function destroyEntity()
        if not EntityRunning then
            return
        end
        EntityRunning = false
        commonSenceActive = false
        if commonSenceModel == figureModel then
            commonSenceModel = nil
        end
        if figureModel then
            pcall(function()
                figureModel:Destroy()
            end)
        end
    end

    local CurrentRooms = workspace:FindFirstChild("CurrentRooms")
    if not CurrentRooms then
        destroyEntity()
        return
    end

    local room50 = CurrentRooms:FindFirstChild("50")
    if not room50 then
        destroyEntity()
        return
    end

    local startModel = room50:FindFirstChild("Door", true)
    if not startModel then
        destroyEntity()
        return
    end

    local startPart = startModel:FindFirstChild("Hidden")
    if not startPart or not startPart:IsA("BasePart") then
        destroyEntity()
        return
    end

    local FigureSetup = room50:FindFirstChild("FigureSetup")
    if not FigureSetup then
        destroyEntity()
        return
    end

    local FigureNodesFolder = FigureSetup:FindFirstChild("FigureNodes")
    if not FigureNodesFolder then
        destroyEntity()
        return
    end

    local allWaypoints = {}
    for _, waypoint in ipairs(FigureNodesFolder:GetChildren()) do
        if waypoint:IsA("BasePart") then
            table.insert(allWaypoints, waypoint)
        end
    end
    if #allWaypoints == 0 then
        destroyEntity()
        return
    end

    if not figureModel.PrimaryPart then
        for _, object in ipairs(figureModel:GetDescendants()) do
            if object:IsA("BasePart") then
                figureModel.PrimaryPart = object
                break
            end
        end
    end
    if not figureModel.PrimaryPart then
        destroyEntity()
        return
    end

    local HEIGHT_OFFSET = 3
    local startPosition = Vector3.new(
        startPart.Position.X,
        startPart.Position.Y + HEIGHT_OFFSET,
        startPart.Position.Z
    )
    figureModel:PivotTo(CFrame.new(startPosition))

    -- Preserve the original room-50 sequence's A-60 trigger timing.
    task.delay(120, function()
        spawnA60()
    end)

    local LatestRoom = ReplicatedStorage:WaitForChild("GameData"):WaitForChild("LatestRoom")
    local StartingRoomValue = LatestRoom.Value

    task.spawn(function()
        while EntityRunning do
            LatestRoom.Changed:Wait()
            if not EntityRunning then
                break
            end
            if LatestRoom.Value ~= StartingRoomValue then
                destroyEntity()
                break
            end
        end
    end)

    local function entityAlive()
        return EntityRunning
            and figureModel
            and figureModel.Parent
            and figureModel.PrimaryPart
    end

    local function moveToPosition(targetPosition, speed)
        if not entityAlive() then
            return false
        end
        local currentPivot = figureModel:GetPivot()
        local startPos = currentPivot.Position
        local endPos = Vector3.new(
            targetPosition.X,
            targetPosition.Y + HEIGHT_OFFSET,
            targetPosition.Z
        )
        local distance = (endPos - startPos).Magnitude
        if distance <= 0.01 then
            figureModel:PivotTo(CFrame.new(endPos))
            return true
        end
        local duration = distance / speed
        local elapsed = 0
        local updateAccumulator = 0
        while elapsed < duration do
            if not entityAlive() then
                return false
            end
            local deltaTime = RunService.Heartbeat:Wait()
            elapsed += deltaTime
            updateAccumulator += deltaTime
            if updateAccumulator >= 1 / 30 or elapsed >= duration then
                updateAccumulator = 0
                local progress = math.clamp(elapsed / duration, 0, 1)
                local currentPos = startPos:Lerp(endPos, progress)
                figureModel:PivotTo(CFrame.new(currentPos))
            end
        end
        if entityAlive() then
            figureModel:PivotTo(CFrame.new(endPos))
            return true
        end
        return false
    end

    local function getNearestWaypoint(currentPos, remainingWaypoints)
        local nearest = nil
        local nearestDistance = math.huge
        for _, waypoint in ipairs(remainingWaypoints) do
            if waypoint and waypoint.Parent then
                local waypointPosition = Vector3.new(
                    waypoint.Position.X,
                    waypoint.Position.Y + HEIGHT_OFFSET,
                    waypoint.Position.Z
                )
                local distance = (waypointPosition - currentPos).Magnitude
                if distance < nearestDistance then
                    nearestDistance = distance
                    nearest = waypoint
                end
            end
        end
        return nearest
    end

    local function setupAttackDetection()
        local ATTACK_RANGE = 10
        local ATTACK_COOLDOWN = 0.5
        local DAMAGE = 70
        task.spawn(function()
            while entityAlive() do
                task.wait(ATTACK_COOLDOWN)
                if not entityAlive() then
                    break
                end
                local Character = Player.Character
                if not Character then
                    continue
                end
                local Humanoid = Character:FindFirstChildOfClass("Humanoid")
                local RootPart = Character:FindFirstChild("HumanoidRootPart")
                if not Humanoid or not RootPart or Humanoid.Health <= 0 then
                    continue
                end
                if IsAttacking then
                    continue
                end
                local EntityRoot = figureModel.PrimaryPart
                if not EntityRoot then
                    break
                end
                local entityPosition = EntityRoot.Position
                local playerPosition = RootPart.Position
                local offset = playerPosition - entityPosition
                local distance = offset.Magnitude
                if distance > ATTACK_RANGE then
                    continue
                end
                if distance <= 0.05 then
                    IsAttacking = true
                    local WillDie = Humanoid.Health <= DAMAGE
                    if WillDie then
                        setDeathCause("Common Sence")
                    end
                    Humanoid:TakeDamage(DAMAGE)
                    task.wait(1)
                    IsAttacking = false
                    continue
                end
                local raycastParams = RaycastParams.new()
                raycastParams.FilterType = Enum.RaycastFilterType.Exclude
                raycastParams.FilterDescendantsInstances = { figureModel }
                raycastParams.IgnoreWater = true
                local result = workspace:Raycast(entityPosition, offset, raycastParams)
                if result and result.Instance and result.Instance:IsDescendantOf(Character) then
                    IsAttacking = true
                    local WillDie = Humanoid.Health <= DAMAGE
                    if WillDie then
                        setDeathCause("Common Sence")
                    end
                    Humanoid:TakeDamage(DAMAGE)
                    task.wait(1)
                    IsAttacking = false
                end
            end
        end)
    end

    local function moveThroughWaypoints()
        if not entityAlive() then
            return
        end
        local remainingWaypoints = {}
        for _, waypoint in ipairs(allWaypoints) do
            table.insert(remainingWaypoints, waypoint)
        end
        local visitedWaypoints = {}
        local currentPos = figureModel.PrimaryPart.Position
        while #remainingWaypoints > 0 and entityAlive() do
            local nearest = getNearestWaypoint(currentPos, remainingWaypoints)
            if not nearest then
                break
            end
            local moved = moveToPosition(nearest.Position, 14)
            if not moved or not entityAlive() then
                break
            end
            currentPos = figureModel.PrimaryPart.Position
            table.insert(visitedWaypoints, nearest)
            for index, waypoint in ipairs(remainingWaypoints) do
                if waypoint == nearest then
                    table.remove(remainingWaypoints, index)
                    break
                end
            end
        end
        for index = #visitedWaypoints - 1, 1, -1 do
            if not entityAlive() then
                break
            end
            local waypoint = visitedWaypoints[index]
            local moved = moveToPosition(waypoint.Position, 14)
            if not moved then
                break
            end
        end
        for index = 2, #visitedWaypoints do
            if not entityAlive() then
                break
            end
            local waypoint = visitedWaypoints[index]
            local moved = moveToPosition(waypoint.Position, 14)
            if not moved then
                break
            end
        end
    end

    setupAttackDetection()
    moveThroughWaypoints()
end

        room50DeathMessage = function(messages, deathCause)
            if type(DEATHMESSAGE) == "function" then
                DEATHMESSAGE(messages, deathCause)
            end

            if deathCause == "A-60" and not jumpscareActive then
                jumpscareActive = true
                task.spawn(playA60Jumpscare)
            end
        end

        local function playNewRoom50Title()
            local mainUI = playerGui:WaitForChild("MainUI", 10)
            if mainUI then
                local imageLabel = Instance.new("ImageLabel")
                imageLabel.Name = "LB"
                imageLabel.Image = "rbxassetid://98541250604001"
                imageLabel.Size = UDim2.new(0.2, 300, 0, 300)
                imageLabel.Position = UDim2.new(0.55, -100, 0.3, -100)
                imageLabel.BackgroundTransparency = 1
                imageLabel.ImageTransparency = 1
                imageLabel.Visible = false
                imageLabel.ZIndex = 10
                imageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
                imageLabel.Parent = mainUI
                task.spawn(function()
                    imageLabel.Visible = true
                    game:GetService("TweenService"):Create(imageLabel, TweenInfo.new(1), {ImageTransparency = 0}):Play()
                    task.wait(6)
                    if imageLabel.Parent then
                        game:GetService("TweenService"):Create(imageLabel, TweenInfo.new(1), {ImageTransparency = 1}):Play()
                        task.wait(1)
                        if imageLabel.Parent then
                            imageLabel:Destroy()
                        end
                    end
                end)
            end
            task.spawn(function()
                local sound = Instance.new("Sound")
                sound.SoundId = "rbxassetid://1835274270"
                sound.Volume = 1
                sound.Parent = game:GetService("SoundService")
                sound:Play()
                game:GetService("Debris"):AddItem(sound, 90)
            end)
        end

        local function handleRoom50(room)
            if not room or not room:IsA("Model") or room.Name ~= "50" or room50SequenceStarted then
                return
            end

            room50SequenceStarted = true
            playNewRoom50Title()
            task.spawn(function()
                latestRoom.Changed:Wait()
                task.wait(6)
                shatterLatestRoom()
                spawnCommonSence()
            end)
        end

        for _, room in ipairs(currentRooms:GetChildren()) do
            handleRoom50(room)
        end

        currentRooms.ChildAdded:Connect(handleRoom50)
    end

    if game.ReplicatedStorage.GameData.LatestRoom.Value <= 1 then
        game:GetService("ReplicatedStorage").GameData.LatestRoom.Changed:Connect(function(p111)
            if game:GetService("Workspace").CurrentRooms[p111]:FindFirstChild("PathfindNodes") then
                L = game:GetService("Workspace").CurrentRooms[p111].PathfindNodes:Clone()
                L.Parent = game:GetService("Workspace").CurrentRooms[p111]
                L = game:GetService("Workspace").CurrentRooms[p111].PathfindNodes:Clone()
                L.Parent = game:GetService("Workspace").CurrentRooms[p111]
                L.Name = "Nodes"
            end
        end)
        delay(0, function()
            game:GetService("Players").LocalPlayer.PlayerGui.MainUI.AchievementsHolder.ChildAdded:Connect(function(p112)
                if p112.Name == "LiveAchievement" and (BadgeId or getgenv().BadgeId) then
                    local v113, v114 = pcall(function()
                        return game:GetService("BadgeService"):GetBadgeInfoAsync(BadgeId).IconImageId
                    end)
                    if v113 then
                        print(v114)
                        p112.Frame.ImageLabel.Image = "rbxassetid://" .. tostring(v114)
                    end
                end
            end)
        end)
        Instance.new("BoolValue", workspace).Name = "hardcoreInit"
        game:GetService("ReplicatedStorage").GameData.LatestRoom:GetPropertyChangedSignal("Value"):Wait()
        delay(0, function()
            local v115 = {
                "Have fun! (you wont)",
                "Good luck!",
                "idk",
                "Do Not.",
                ":3",
                "WHATTT?",
                "..."
            }
           vu43("Hardcore Initiated")
            task.wait(2)
            vu43("Made by Noonie & Ping (Original author, partly made the models and audio!)")
            task.wait(2)
            vu43("Some Hardcore Reignite making a comeback")
            task.wait(4)
            vu43("This version reset was done by HeavenNow")
            wait(2)
            vu43("Don't use admin, can be played by multiple people")
            wait(2)
            vu43(v115[math.random(1, # v115)])
        end)
        delay(0, function()
            ({}).Functions = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Functions.lua"))()
            workspace.DescendantAdded:Connect(function(p116)
                if p116.Parent ~= nil and (p116 ~= nil and p116:IsA("Sound")) then
                    if p116.Parent.Name == "FigureSetup" then
                        if p116.Name == "Ambience" then
                            p116.SoundId = vu28
                        end
                        if p116.Name == "AmbienceEnd" then
                            p116.SoundId = vu29
                        end
                        if p116.Name == "AmbienceStart" then
                            p116.SoundId = vu30
                        end
                    end
                end
            end)
        end)
        do
            local Players = game:GetService("Players")
            local ReplicatedStorage = game:GetService("ReplicatedStorage")
            local Workspace = game:GetService("Workspace")
            local RunService = game:GetService("RunService")

            local LocalPlayer = Players.LocalPlayer
            local GameData = ReplicatedStorage:WaitForChild("GameData")
            local LatestRoom = GameData:WaitForChild("LatestRoom")

            local targetAudioUrl = "https://github.com/Sosnen/Ping-s-Dumbass-projects-/raw/main/Here%20i%20come%20but%20WHAT%20THE%20FUCK.mp3"
            local newFileName = "SeekMusicNew"
            local volume = 5

            local CUSTOM_SEEK_MODEL_ID = "rbxassetid://130623849945429"


            local seekMusicAsset = nil
            local audioLoaded = false
            local audioLoading = false

            local currentCustomSeek = nil
            local currentContext = nil

            local chaseCount = 0

            local pendingSeeks = {}
            local processedSeeks = {}

            local chaseConfigs = {
                [1] = {
                    totalRooms = 6,
                    shatterUntil = 5,
                    flipMin = 2,
                    flipMax = 8,
                    flipDuration = 5,
                    flipDirection = 2
                },

                [2] = {
                    totalRooms = 8,
                    shatterUntil = 7,
                    flipMin = 2,
                    flipMax = 10,
                    flipDuration = 7,
                    flipDirection = 2
                }
            }

            local function applySeekMusic(sound)
                if not sound or not sound:IsA("Sound") then
                    return
                end

                if sound.Name ~= "SeekMusic" then
                    return
                end

                if not sound.Parent then
                    return
                end

                if sound.Parent.Name ~= "SeekMovingNewClone" then
                    return
                end

                sound.Volume = volume

                if audioLoaded and seekMusicAsset then
                    sound.SoundId = seekMusicAsset
                end
            end

            local function loadAudioFromGitHub()
                if audioLoading or audioLoaded then
                    return
                end

                audioLoading = true

                task.spawn(function()
                    local success, result = pcall(function()
                        local audioData = game:HttpGet(targetAudioUrl)

                        writefile(newFileName .. ".mp3", audioData)

                        local assetLoader = getcustomasset or getsynasset

                        return assetLoader(newFileName .. ".mp3")
                    end)

                    audioLoading = false

                    if success and result then
                        seekMusicAsset = result
                        audioLoaded = true

                        for _, descendant in ipairs(Workspace:GetDescendants()) do
                            applySeekMusic(descendant)
                        end
                    end
                end)
            end

            local function replaceSeekMusic()
                Workspace.DescendantAdded:Connect(function(descendant)
                    if descendant:IsA("Sound") then
                        applySeekMusic(descendant)

                        if descendant.Name == "SeekMusic"
                            and descendant.Parent
                            and descendant.Parent.Name == "SeekMovingNewClone" then

                            if not audioLoaded then
                                loadAudioFromGitHub()
                            end
                        end
                    end
                end)

                for _, descendant in ipairs(Workspace:GetDescendants()) do
                    applySeekMusic(descendant)
                end
            end

            local function stopScreenFlip(context)
                if not context then
                    return
                end

                if context.flipActive then
                    RunService:UnbindFromRenderStep(context.flipName)
                    context.flipActive = false
                end
            end

            local function startScreenFlip(context)
                if not context.active then
                    return
                end

                if context.finished then
                    return
                end

                if context.flipActive then
                    return
                end

                local config = context.config

                if not config then
                    return
                end

                context.flipActive = true

                local flipStart = os.clock()
                local flipDuration = config.flipDuration
                local flipDirection = config.flipDirection

                RunService:BindToRenderStep(
                    context.flipName,
                    Enum.RenderPriority.Camera.Value + 1,
                    function()
                        if not context.active or context.finished then
                            stopScreenFlip(context)
                            return
                        end

                        local camera = Workspace.CurrentCamera

                        if not camera then
                            return
                        end

                        local now = os.clock()
                        local progress = (now - flipStart) / flipDuration

                        if progress >= 1 then
                            stopScreenFlip(context)
                            return
                        end

                        local curve = math.sin(progress * math.pi) ^ 0.4

                        local flipAngle = math.rad(360) * curve * flipDirection

                        camera.CFrame = camera.CFrame * CFrame.Angles(
                            0,
                            0,
                            flipAngle
                        )
                    end
                )
            end

            local function startRandomFlipLoop(context)
                if not context.config then
                    return
                end

                if context.flipLoopStarted then
                    return
                end

                context.flipLoopStarted = true

                task.spawn(function()
                    local config = context.config
                    local randomGenerator = Random.new()

                    while context.active and not context.finished do
                        local randomDelay = randomGenerator:NextNumber(
                            config.flipMin,
                            config.flipMax
                        )

                        task.wait(randomDelay)

                        if not context.active or context.finished then
                            break
                        end

                        if not context.flipActive then
                            startScreenFlip(context)
                        end
                    end

                    context.flipLoopStarted = false
                end)
            end

            local function shatterCurrentRoom(context, roomNumber)
                task.spawn(function()
                    if not context.active or context.finished then
                        return
                    end

                    local currentRooms = Workspace:FindFirstChild("CurrentRooms")

                    if not currentRooms then
                        return
                    end

                    local roomName = tostring(roomNumber)

                    local room = currentRooms:FindFirstChild(roomName)

                    if not room then
                        room = currentRooms:WaitForChild(roomName, 2)
                    end

                    if not room then
                        return
                    end

                    if not context.active or context.finished then
                        return
                    end

                    pcall(function()
                        local Speed = 100
                        local ShatterAmount = 100

                        require(
                            ReplicatedStorage.ModulesClient.Module_Events
                        ).shatter(
                            room,
                            Speed,
                            ShatterAmount,
                            Random.new(tick())
                        )
                    end)
                end)
            end

            local function showChaseCaption()
                pcall(function()
                    require(
                        LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game
                    ).caption("Use your strength!!!", true)
                end)
            end

            local function playCustomSeekSounds(context)
                if not context.active then
                    return
                end

                local customSeekModel = context.customSeek

                if not customSeekModel or not customSeekModel.Parent then
                    return
                end

                local figure = customSeekModel:FindFirstChild("Figure")

                if not figure then
                    return
                end

                for _, child in ipairs(figure:GetChildren()) do
                    if child:IsA("Sound") then
                        child:Play()
                    end
                end
            end

            local function stopChaseEffects(context)
                if not context then
                    return
                end

                context.finished = true

                stopScreenFlip(context)

                if context.roomConnection then
                    context.roomConnection:Disconnect()
                    context.roomConnection = nil
                end
            end

            local function onChaseRoomChanged(context)
                if not context.active then
                    return
                end

                if context.finished then
                    return
                end

                if not context.config then
                    return
                end

                context.roomChanges = context.roomChanges + 1

                local roomChangeCount = context.roomChanges
                local config = context.config

                if roomChangeCount == 1 then
                    showChaseCaption()

                    playCustomSeekSounds(context)

                    startRandomFlipLoop(context)
                end

                if roomChangeCount <= config.shatterUntil then
                    local roomNumber = LatestRoom.Value

                    shatterCurrentRoom(context, roomNumber)
                end

                if roomChangeCount >= config.totalRooms then
                    stopChaseEffects(context)
                end
            end

            local function cleanupOldSeekModel(context)
                if not context then
                    return
                end

                context.active = false
                context.finished = true

                stopScreenFlip(context)

                if context.roomConnection then
                    context.roomConnection:Disconnect()
                    context.roomConnection = nil
                end

                if context.followConnection then
                    context.followConnection:Disconnect()
                    context.followConnection = nil
                end

                if context.ancestryConnection then
                    context.ancestryConnection:Disconnect()
                    context.ancestryConnection = nil
                end

                if context.customSeek and context.customSeek.Parent then
                    context.customSeek:Destroy()
                end

                if currentCustomSeek == context.customSeek then
                    currentCustomSeek = nil
                end

                if currentContext == context then
                    currentContext = nil
                end
            end

            local function playSeekAnimations(context)
                task.spawn(function()
                    local customRig = context.customRig

                    if not customRig then
                        return
                    end

                    local animController = customRig:FindFirstChild("AnimationController")
                    local raiseAnimation = customRig:FindFirstChild("AnimRaise")
                    local runAnimation = customRig:FindFirstChild("AnimRun")

                    if not animController or not raiseAnimation or not runAnimation then
                        return
                    end

                    local animator = animController:FindFirstChildOfClass("Animator")
                        or animController

                    pcall(function()
                        local raiseAnim = animator:LoadAnimation(raiseAnimation)

                        if not context.active then
                            return
                        end

                        raiseAnim:Play()
                        raiseAnim.Stopped:Wait()

                        if not context.active then
                            return
                        end

                        local runAnim = animator:LoadAnimation(runAnimation)

                        runAnim:Play()
                    end)
                end)
            end

            local function playDelayedSeekSounds(context)
                task.delay(7, function()
                    if not context.active then
                        return
                    end

                    local customSeekModel = context.customSeek

                    if not customSeekModel or not customSeekModel.Parent then
                        return
                    end

                    local figure = customSeekModel:FindFirstChild("Figure")

                    if not figure then
                        return
                    end

                    local soundNames = {
                        "FootstepsFar",
                        "Footsteps",
                        "Splashing",
                        "Splashing Far"
                    }

                    for _, soundName in ipairs(soundNames) do
                        local sound = figure:FindFirstChild(soundName)

                        if sound and sound:IsA("Sound") then
                            sound:Play()
                        end
                    end
                end)
            end

            local function waitForSeekChase(context)
                task.spawn(function()
                    local originalSeek = context.originalSeek

                    while context.active and originalSeek.Parent do
                        local seekMusic = originalSeek:FindFirstChild("SeekMusic")

                        if seekMusic and seekMusic:IsA("Sound") and seekMusic.IsPlaying then
                            if context.config then
                                context.roomConnection = LatestRoom.Changed:Connect(function()
                                    onChaseRoomChanged(context)
                                end)
                            end

                            playDelayedSeekSounds(context)
                            playSeekAnimations(context)

                            return
                        end

                        task.wait(0.1)
                    end
                end)
            end

            local function replaceSeekModel(originalSeek)
                if not originalSeek or not originalSeek.Parent then
                    return
                end

                if processedSeeks[originalSeek] then
                    return
                end

                local originalRig = originalSeek:FindFirstChild("SeekRig")

                if not originalRig then
                    return
                end

                local originalRoot = originalRig:FindFirstChild("Root")

                if not originalRoot then
                    return
                end

                local customSeekModel

                local success = pcall(function()
                    customSeekModel = game:GetObjects(CUSTOM_SEEK_MODEL_ID)[1]
                end)

                if not success or not customSeekModel then
                    return
                end

                local customRig = customSeekModel:FindFirstChild("SeekRig")
                local figure = customSeekModel:FindFirstChild("Figure")

                if not customRig or not figure then
                    customSeekModel:Destroy()
                    return
                end

                local customRoot = customRig:FindFirstChild("Root")

                if not customRoot then
                    customSeekModel:Destroy()
                    return
                end

                if currentContext then
                    cleanupOldSeekModel(currentContext)
                end

                processedSeeks[originalSeek] = true

                chaseCount = chaseCount + 1
                local chaseConfig = chaseConfigs[chaseCount]
                seekLightReplacementDelay = chaseConfig and chaseConfig.totalRooms or 0

                customSeekModel.Name = "seek2"

                for _, child in ipairs(figure:GetChildren()) do
                    if child:IsA("Sound") then
                        child:Stop()
                    end
                end

                local originalHead = originalRig:FindFirstChild("Head")

                if originalHead then
                    local eye = originalHead:FindFirstChild("Eye")
                    local black = originalHead:FindFirstChild("Black")

                    if eye then
                        eye:Destroy()
                    end

                    if black then
                        black:Destroy()
                    end
                end

                for _, child in ipairs(originalRig:GetDescendants()) do
                    if child.Name == "StringCheese" then
                        child:Destroy()
                    end
                end

                customSeekModel.Parent = Workspace
                currentCustomSeek = customSeekModel

                customRoot.Anchored = true

                local context = {
                    originalSeek = originalSeek,
                    originalRig = originalRig,
                    originalRoot = originalRoot,

                    customSeek = customSeekModel,
                    customRig = customRig,
                    customRoot = customRoot,

                    chaseNumber = chaseCount,
                    config = chaseConfig,

                    roomChanges = 0,

                    active = true,
                    finished = false,

                    flipActive = false,
                    flipLoopStarted = false,

                    flipName = "ScreenFlipOnce_" .. tostring(chaseCount),

                    roomConnection = nil,
                    followConnection = nil,
                    ancestryConnection = nil
                }

                currentContext = context

                context.followConnection = RunService.Heartbeat:Connect(function()
                    if not context.active then
                        return
                    end

                    if not originalSeek.Parent or not customSeekModel.Parent then
                        cleanupOldSeekModel(context)
                        return
                    end

                    local originalRigRoot = originalRig:FindFirstChild("Root")
                    local customRigRoot = customRig:FindFirstChild("Root")

                    if originalRigRoot and customRigRoot then
                        customRigRoot.CFrame = originalRigRoot.CFrame
                    end

                    local originalFigure = originalSeek:FindFirstChild("Figure")

                    if originalFigure then
                        for _, sound in ipairs(originalFigure:GetChildren()) do
                            if sound:IsA("Sound") then
                                sound:Stop()
                            end
                        end
                    end

                    for _, part in ipairs(originalRig:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.Transparency = 1
                        end
                    end
                end)

                context.ancestryConnection = originalSeek.AncestryChanged:Connect(function(_, parent)
                    if parent == nil then
                        cleanupOldSeekModel(context)
                    end
                end)

                waitForSeekChase(context)
            end

            local function scheduleSeekReplacement(originalSeek)
                if not originalSeek then
                    return
                end

                if originalSeek.Name ~= "SeekMovingNewClone" then
                    return
                end

                if processedSeeks[originalSeek] then
                    return
                end

                if pendingSeeks[originalSeek] then
                    return
                end

                pendingSeeks[originalSeek] = true

                task.delay(3.5, function()
                    pendingSeeks[originalSeek] = nil

                    if not originalSeek.Parent then
                        return
                    end

                    if processedSeeks[originalSeek] then
                        return
                    end

                    replaceSeekModel(originalSeek)
                end)
            end

            local function initializeSeekReplacement()
                Workspace.ChildAdded:Connect(function(child)
                    if child.Name == "SeekMovingNewClone" then
                        scheduleSeekReplacement(child)
                    end
                end)

                LatestRoom.Changed:Connect(function()
                    local originalSeek = Workspace:FindFirstChild("SeekMovingNewClone")

                    if originalSeek then
                        scheduleSeekReplacement(originalSeek)
                    end
                end)

                local existingSeek = Workspace:FindFirstChild("SeekMovingNewClone")

                if existingSeek then
                    scheduleSeekReplacement(existingSeek)
                end
            end

            loadAudioFromGitHub()
            replaceSeekMusic()
            initializeSeekReplacement()
        end
        -- Deer God only runs outside the Figure library (room 50) and Seek chase.
        local function isDeerGodRestrictedPhase()
            local data = game:GetService("ReplicatedStorage"):FindFirstChild("GameData")
            local latest = data and data:FindFirstChild("LatestRoom")
            if latest and tonumber(latest.Value) == 50 then
                return true
            end

            -- DOORS versions use different names for the Seek movement model.
            if workspace:FindFirstChild("SeekMovingNewClone")
                or workspace:FindFirstChild("SeekMovingNew")
                or workspace:FindFirstChild("SeekMoving")
                or workspace:FindFirstChild("SeekMov") then
                return true
            end

            -- Covers Seek chase frames before or after the moving model exists.
            local main = vu31 and vu31.MainGame
            if main and main.chase then
                return true
            end
            return false
        end
        task.spawn(function()
            while task.wait(450) do
                if isDeerGodRestrictedPhase() then
                    continue
                end

                -- Execute the uploaded Deer God as a separate event, rather than
                -- retaining the old entity-spawner version alongside it.
                local ok, message = xpcall(function()
                    local Players = game:GetService("Players")
                    local RunService = game:GetService("RunService")
                    local TweenService = game:GetService("TweenService")
                    local ReplicatedStorage = game:GetService("ReplicatedStorage")
                    local InsertService = game:GetService("InsertService")
                    local ContentProvider = game:GetService("ContentProvider")
                    local SoundService = game:GetService("SoundService")
                    local Lighting = game:GetService("Lighting")
                    local Workspace = game:GetService("Workspace")

                    local player = Players.LocalPlayer

                    if not RunService:IsClient() then
                        return
                    end

                    if not player then
                        return
                    end

                    local playerGui = player:WaitForChild("PlayerGui", 15)
                    if not playerGui then
                        return
                    end

                    local ENTITY_ASSET_ID = 104577643723831
                    local DEATH_ASSET_ID = 83935353406484
                    local VICTIM_ANIMATION_ID = "rbxassetid://131382303107033"
                    local SPEED = 12
                    local CHASE_RANGE = 75
                    local HIT_RANGE = 10
                    local MAX_ROOMS = 15
                    local HEIGHT_OFFSET = Vector3.new(0, 2.4, 0)
                    local DEATH_POSITION = Vector3.new(244, -304, -6)
                    local DEATH_SECONDS = 15
                    local CAMERA_SHAKE_INTERVAL = 0.8
                    local CAMERA_SHAKE_MAX_DISTANCE = 300
                    local CAMERA_SHAKE_MIN_MAGNITUDE = 0.5
                    local CAMERA_SHAKE_MAX_MAGNITUDE = 5
                    local START_SEARCH_TIMEOUT = 25
                    local WAYPOINT_PASS_RADIUS = 3

                    local function loadModel(assetId, fallbackName)
                        local ok, objects = pcall(function()
                            return game:GetObjects("rbxassetid://" .. tostring(assetId))
                        end)
                        if ok and type(objects) == "table" then
                            for _, object in ipairs(objects) do
                                if object:IsA("Model") then
                                    local children = object:GetChildren()
                                    if #children == 1 and children[1]:IsA("Model")
                                        and not object:FindFirstChildWhichIsA("BasePart", true) then
                                        local nested = children[1]
                                        nested.Parent = nil
                                        object:Destroy()
                                        return nested
                                    end
                                    return object
                                end
                            end
                        end

                        local template = ReplicatedStorage:FindFirstChild(fallbackName, true)
                        if template and template:IsA("Model") then
                            return template:Clone()
                        end

                        local loaded, container = pcall(function()
                            return InsertService:LoadAsset(assetId)
                        end)
                        if loaded and container and container:IsA("Model") then
                            local children = container:GetChildren()
                            if #children == 1 and children[1]:IsA("Model") then
                                local nested = children[1]
                                nested.Parent = nil
                                container:Destroy()
                                return nested
                            end
                            if container:FindFirstChildWhichIsA("BasePart", true) then
                                return container
                            end
                            container:Destroy()
                        end
                        return nil
                    end

                    local function prepareModel(model)
                        for _, object in ipairs(model:GetDescendants()) do
                            if object:IsA("BasePart") then
                                object.Anchored = true
                                object.CanCollide = false
                                object.CanTouch = false
                                object.CanQuery = false
                            elseif object:IsA("Script") or object:IsA("LocalScript") then
                                object.Disabled = true
                            end
                        end
                        if not model.PrimaryPart then
                            local primary = model:FindFirstChild("Main", true)
                                or model:FindFirstChild("HumanoidRootPart", true)
                                or model:FindFirstChildWhichIsA("BasePart", true)
                            if primary and primary:IsA("BasePart") then
                                model.PrimaryPart = primary
                            end
                        end
                    end

                    local function getRooms()
                        local folder = Workspace:FindFirstChild("CurrentRooms")
                        local result = {}
                        if folder then
                            for _, room in ipairs(folder:GetChildren()) do
                                if room:IsA("Model") then
                                    local number = tonumber(room.Name)
                                    if number and number ~= 50 then
                                        result[#result + 1] = { Number = number, Room = room }
                                    end
                                end
                            end
                        end
                        table.sort(result, function(a, b)
                            return a.Number < b.Number
                        end)
                        return result
                    end

                    local function getNodes(room)
                        local result = {}
                        local folder = room:FindFirstChild("PathfindNodes")

                        if folder then
                            for _, object in ipairs(folder:GetChildren()) do
                                if object:IsA("BasePart") then
                                    result[#result + 1] = object
                                end
                            end
                        end

                        table.sort(result, function(a, b)
                            local aNumber = tonumber(a.Name)
                            local bNumber = tonumber(b.Name)

                            if aNumber and bNumber then
                                return aNumber < bNumber
                            elseif aNumber then
                                return true
                            elseif bNumber then
                                return false
                            end

                            return a.Name < b.Name
                        end)

                        return result
                    end

                    local function getRoomExit(room)
                        local roomExit = room:FindFirstChild("RoomExit")
                        if roomExit and roomExit:IsA("BasePart") then
                            return roomExit
                        end
                        return nil
                    end

                    local function getAliveCharacter(targetPlayer)
                        if not targetPlayer or targetPlayer.Parent ~= Players then
                            return nil, nil, nil
                        end
                        local character = targetPlayer.Character
                        if not character or not character:IsDescendantOf(Workspace) then
                            return nil, nil, nil
                        end
                        local root = character:FindFirstChild("HumanoidRootPart")
                        local humanoid = character:FindFirstChildWhichIsA("Humanoid")
                        if not root or not root:IsA("BasePart") or not humanoid or humanoid.Health <= 0 then
                            return nil, nil, nil
                        end
                        return character, root, humanoid
                    end

                    local function approach(model, targetPosition, dt)
                        local pivot = model:GetPivot()
                        local position = pivot.Position
                        local difference = targetPosition - position
                        local distance = difference.Magnitude
                        if distance <= 0.05 then
                            return true
                        end
                        local step = math.min(distance, SPEED * math.min(dt, 0.1))
                        local nextPosition = position + difference.Unit * step
                        local forward = Vector3.new(difference.X, 0, difference.Z)
                        local rotation = pivot.Rotation
                        if forward.Magnitude > 0.001 then
                            rotation = CFrame.lookAt(Vector3.zero, forward.Unit).Rotation
                        end
                        model:PivotTo(CFrame.new(nextPosition) * rotation)
                        return distance - step <= 0.05
                    end

                    local pathMovement = nil

                    local function moveAlongOriginalRipperPath(model, node, deltaTime)
                        if not pathMovement or pathMovement.Node ~= node then
                            local startCFrame = model:GetPivot()
                            local targetCFrame = node.CFrame + HEIGHT_OFFSET
                            pathMovement = {
                                Node = node,
                                StartCFrame = startCFrame,
                                TargetCFrame = targetCFrame,
                                TotalDistance = (targetCFrame.Position - startCFrame.Position).Magnitude,
                                Travelled = 0
                            }
                        end

                        local state = pathMovement
                        if state.TotalDistance <= 0.001 then
                            model:PivotTo(state.TargetCFrame)
                            pathMovement = nil
                            return true
                        end

                        state.Travelled = math.min(
                            state.Travelled + SPEED * math.min(deltaTime, 0.1),
                            state.TotalDistance
                        )

                        model:PivotTo(
                            state.StartCFrame:Lerp(
                                state.TargetCFrame,
                                state.Travelled / state.TotalDistance
                            )
                        )

                        if state.Travelled >= state.TotalDistance then
                            pathMovement = nil
                            return true
                        end

                        return false
                    end

                    local function rayCanHit(model, character)
                        local origin = model.PrimaryPart and model.PrimaryPart.Position or model:GetPivot().Position
                        local params = RaycastParams.new()
                        params.FilterType = Enum.RaycastFilterType.Exclude

                        for _, name in ipairs({ "HumanoidRootPart", "Head", "UpperTorso", "Torso", "LowerTorso" }) do
                            local part = character:FindFirstChild(name)
                            if part and part:IsA("BasePart") then
                                local direction = part.Position - origin
                                if direction.Magnitude <= HIT_RANGE and direction.Magnitude > 0.001 then
                                    local exclusions = { model }
                                    for _ = 1, 10 do
                                        params.FilterDescendantsInstances = exclusions
                                        local result = Workspace:Raycast(origin, direction, params)
                                        if not result or result.Instance:IsDescendantOf(character) then
                                            return true
                                        end

                                        local obstacle = result.Instance
                                        local nodeFolder = obstacle:FindFirstAncestor("PathfindNodes")
                                        if nodeFolder or (obstacle:IsA("BasePart")
                                            and obstacle.Transparency >= 0.98 and not obstacle.CanCollide) then
                                            exclusions[#exclusions + 1] = obstacle
                                        else
                                            break
                                        end
                                    end
                                end
                            end
                        end

                        return false
                    end

                    local entity = loadModel(ENTITY_ASSET_ID, "DeerGodModel")
                    if not entity then
                        return
                    end

                    local deathTemplate = loadModel(DEATH_ASSET_ID, "DeerGodDeathModel")
                    prepareModel(entity)
                    if deathTemplate then
                        prepareModel(deathTemplate)
                        pcall(function()
                            ContentProvider:PreloadAsync({ deathTemplate })
                        end)
                    end

                    local animation = Instance.new("Animation")
                    animation.Name = "DeerGodVictimAnimation"
                    animation.AnimationId = VICTIM_ANIMATION_ID
                    pcall(function()
                        ContentProvider:PreloadAsync({ animation })
                    end)

                    local rooms = {}
                    local startIndex = nil
                    local startRoom = nil
                    local startNode = nil
                    local startNodes = nil
                    local initialSearchStarted = os.clock()
                    while not startNode and os.clock() - initialSearchStarted < START_SEARCH_TIMEOUT do
                        if isDeerGodRestrictedPhase() then
                            break
                        end
                        rooms = getRooms()
                        local candidateStartIndex = 1
                        if #rooms > 10 then
                            candidateStartIndex = #rooms - 8
                        end

                        for index = candidateStartIndex, #rooms do
                            local data = rooms[index]
                            local nodes = getNodes(data.Room)
                            local candidateNode = nodes[1] or getRoomExit(data.Room)

                            if candidateNode and candidateNode:IsA("BasePart") then
                                startIndex = index
                                startRoom = data.Room
                                startNodes = nodes
                                startNode = candidateNode
                                break
                            end
                        end

                        if not startNode then
                            task.wait(0.5)
                        end
                    end

                    if isDeerGodRestrictedPhase() or not startNode or not startNode.Parent then
                        entity:Destroy()
                        if deathTemplate then
                            deathTemplate:Destroy()
                        end
                        animation:Destroy()
                        return
                    end

                    entity.Name = "Deer God"
                    entity:PivotTo(startNode.CFrame + HEIGHT_OFFSET)
                    entity.Parent = Workspace

                    local saySounds = {}
                    for index = 1, 5 do
                        local saySound = entity:FindFirstChild("Say" .. index, true)
                        if saySound and saySound:IsA("Sound") then
                            saySound.Looped = false
                            saySounds[#saySounds + 1] = saySound
                        end
                    end

                    local ambientSounds = {}
                    local soundNames = { PlaySound = true, Footsteps = true, Music = true }
                    for _, descendant in ipairs(entity:GetDescendants()) do
                        if descendant:IsA("Sound") and soundNames[descendant.Name] then
                            descendant.Looped = true
                            descendant.TimePosition = 0
                            descendant:Play()
                            ambientSounds[#ambientSounds + 1] = descendant
                        end
                    end

                    local hardCoreMusicFolder = Workspace:FindFirstChild("HardCoreSound")
                    if hardCoreMusicFolder then
                        for _, name in ipairs({ "DeerGodMusic", "DeerMusic", "DeerGodBackgroundSound", "DeerBackgroundSound" }) do
                            local music = hardCoreMusicFolder:FindFirstChild(name)
                            if music and music:IsA("Sound") then
                                music:Stop()
                                music.TimePosition = 0
                                music.Looped = true
                                music:Play()
                                ambientSounds[#ambientSounds + 1] = music
                                break
                            end
                        end
                    end

                    local running = true
                    local errorParticlesGui = nil
                    local errorParticlesConnection = nil
                    local cutsceneActive = false
                    local cutsceneSerial = 0
                    local cutsceneConnection = nil
                    local cutsceneState = nil
                    local activeDeerDeathModel = nil
                    local lockedPlayer = nil
                    local lockedCharacter = nil
                    local victimSpeedConnection = nil
                    local victimSpeedHumanoid = nil
                    local victimOriginalWalkSpeed = nil
                    local hitCharacters = setmetatable({}, { __mode = "k" })
                    local currentGoal = nil
                    local currentRoomNumber = rooms[startIndex].Number
                    local roomsEntered = 1
                    local visited = setmetatable({}, { __mode = "k" })
                    local routeProgressByRoom = {}
                    local completedNodeKeys = {}
                    local completedRoomExits = {}
                    local finished = false

                    local function getStableNodeKey(roomNumber, node)
                        local position = node.Position
                        return tostring(roomNumber) .. ":" .. node.Name .. ":" .. string.format(
                            "%.1f:%.1f:%.1f", position.X, position.Y, position.Z
                        )
                    end

                    local function completeNode(roomNumber, node, nodeIndex, isExit)
                        visited[node] = true
                        if isExit then
                            completedRoomExits[roomNumber] = true
                        else
                            local previous = routeProgressByRoom[roomNumber] or 0
                            if nodeIndex > previous then
                                routeProgressByRoom[roomNumber] = nodeIndex
                            end
                            completedNodeKeys[getStableNodeKey(roomNumber, node)] = true
                        end
                    end

                    local function nodeAlreadyCompleted(roomNumber, node, nodeIndex, isExit)
                        if visited[node] then
                            return true
                        end
                        if isExit then
                            return completedRoomExits[roomNumber] == true
                        end
                        return nodeIndex <= (routeProgressByRoom[roomNumber] or 0)
                            or completedNodeKeys[getStableNodeKey(roomNumber, node)] == true
                    end

                    if #startNodes > 0 then
                        for index, node in ipairs(startNodes) do
                            if node == startNode then
                                completeNode(currentRoomNumber, node, index, false)
                                break
                            end
                        end
                    else
                        completeNode(currentRoomNumber, startNode, 0, true)
                    end

                    local ERROR_PARTICLE_TEXTURES = {
                        "rbxassetid://6214195404",
                        "rbxassetid://12293713542",
                        "rbxassetid://7144894845"
                    }

                    local function stopErrorParticles()
                        if errorParticlesConnection then
                            errorParticlesConnection:Disconnect()
                            errorParticlesConnection = nil
                        end
                        if errorParticlesGui then
                            errorParticlesGui:Destroy()
                            errorParticlesGui = nil
                        end
                    end

                    local function startErrorParticles()
                        stopErrorParticles()

                        local old = playerGui:FindFirstChild("DeerGodErrorParticles")
                        if old then
                            old:Destroy()
                        end

                        local gui = Instance.new("ScreenGui")
                        gui.Name = "DeerGodErrorParticles"
                        gui.IgnoreGuiInset = true
                        gui.ResetOnSpawn = false
                        gui.DisplayOrder = 75
                        gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                        gui.Parent = playerGui
                        errorParticlesGui = gui

                        local sprites = {}
                        local expiration = {}
                        for index = 1, 30 do
                            local sprite = Instance.new("ImageLabel")
                            sprite.Name = "ErrorParticle" .. index
                            sprite.BorderSizePixel = 0
                            sprite.BackgroundTransparency = 1
                            sprite.Image = ERROR_PARTICLE_TEXTURES[math.random(1, #ERROR_PARTICLE_TEXTURES)]
                            sprite.ImageTransparency = 1
                            sprite.ScaleType = Enum.ScaleType.Crop
                            sprite.Visible = false
                            sprite.ZIndex = 2
                            sprite.Parent = gui
                            sprites[index] = sprite
                            expiration[index] = 0
                        end

                        local strips = {}
                        local stripExpiration = {}
                        for index = 1, 5 do
                            local strip = Instance.new("Frame")
                            strip.Name = "ErrorScanline" .. index
                            strip.BackgroundColor3 = Color3.fromRGB(200, 40, 70)
                            strip.BackgroundTransparency = 0.6
                            strip.BorderSizePixel = 0
                            strip.Visible = false
                            strip.ZIndex = 1
                            strip.Parent = gui
                            strips[index] = strip
                            stripExpiration[index] = 0
                        end

                        local startedAt = os.clock()
                        local nextBurst = startedAt
                        local nextStrip = startedAt
                        local spriteIndex = 0
                        local stripIndex = 0

                        errorParticlesConnection = RunService.RenderStepped:Connect(function()
                            if not running or not gui.Parent or os.clock() - startedAt >= 60 then
                                stopErrorParticles()
                                return
                            end

                            local now = os.clock()

                            if now >= nextBurst then
                                nextBurst = now + 0.055 + math.random() * 0.055
                                for _ = 1, math.random(3, 7) do
                                    spriteIndex = spriteIndex % #sprites + 1
                                    local sprite = sprites[spriteIndex]
                                    sprite.Image = ERROR_PARTICLE_TEXTURES[math.random(1, #ERROR_PARTICLE_TEXTURES)]
                                    sprite.ImageColor3 = math.random() < 0.55
                                        and Color3.fromRGB(math.random(190, 255), math.random(70, 150), math.random(90, 170))
                                        or Color3.fromRGB(math.random(150, 230), math.random(200, 255), 255)
                                    sprite.ImageTransparency = math.random(25, 70) / 100
                                    sprite.Position = UDim2.fromScale(math.random(), math.random())
                                    sprite.Size = UDim2.fromOffset(math.random(6, 90), math.random(3, 36))
                                    sprite.Rotation = math.random(-14, 14)
                                    sprite.Visible = true
                                    expiration[spriteIndex] = now + math.random(7, 22) / 100
                                end
                            end

                            if now >= nextStrip then
                                nextStrip = now + 0.10 + math.random() * 0.17
                                stripIndex = stripIndex % #strips + 1
                                local strip = strips[stripIndex]
                                strip.BackgroundColor3 = math.random() < 0.6
                                    and Color3.fromRGB(210, 35, 65)
                                    or Color3.fromRGB(105, 210, 230)
                                strip.BackgroundTransparency = math.random(40, 80) / 100
                                strip.Position = UDim2.fromScale(math.random() * 0.6, math.random())
                                strip.Size = UDim2.new(math.random(20, 90) / 100, 0, 0, math.random(2, 7))
                                strip.Visible = true
                                stripExpiration[stripIndex] = now + math.random(5, 14) / 100
                            end

                            for index, sprite in ipairs(sprites) do
                                if sprite.Visible and now >= expiration[index] then
                                    sprite.Visible = false
                                end
                            end
                            for index, strip in ipairs(strips) do
                                if strip.Visible and now >= stripExpiration[index] then
                                    strip.Visible = false
                                end
                            end
                        end)
                    end

                    local function setDeathCause(targetPlayer)
                        local gameStats = ReplicatedStorage:FindFirstChild("GameStats")
                        local playerStats = gameStats and gameStats:FindFirstChild("Player_" .. targetPlayer.Name)
                        local total = playerStats and playerStats:FindFirstChild("Total")
                        local deathCause = total and total:FindFirstChild("DeathCause")
                        if deathCause and deathCause:IsA("StringValue") then
                            deathCause.Value = "Deer God"
                        end
                    end

                    local function playVictimAnimation(humanoid)
                        local animator = humanoid:FindFirstChildWhichIsA("Animator")
                        if not animator then
                            animator = Instance.new("Animator")
                            animator.Parent = humanoid
                        end
                        local ok, track = pcall(function()
                            return animator:LoadAnimation(animation)
                        end)
                        if ok and track then
                            track.Looped = true
                            track.Priority = Enum.AnimationPriority.Action4
                            track:Play(0.1)
                            return track
                        end
                        return nil
                    end

                    local function pauseAmbientSounds()
                        for _, sound in ipairs(ambientSounds) do
                            if sound and sound.Parent and sound.IsPlaying then
                                sound:Pause()
                            end
                        end

                        local hardCoreFolder = Workspace:FindFirstChild("HardCoreSound")
                        if hardCoreFolder then
                            for _, object in ipairs(hardCoreFolder:GetDescendants()) do
                                if object:IsA("Sound") and object.Name ~= "DeerDeath" and object.IsPlaying then
                                    object:Pause()
                                end
                            end
                        end
                    end

                    local function restoreCutscene()
                        if cutsceneConnection then
                            cutsceneConnection:Disconnect()
                            cutsceneConnection = nil
                        end
                        if not cutsceneState then
                            return
                        end
                        local state = cutsceneState
                        cutsceneState = nil
                        local camera = state.Camera
                        if camera and camera.Parent then
                            camera.CameraType = state.CameraType
                            local character = player.Character
                            local humanoid = character and character:FindFirstChildWhichIsA("Humanoid")
                            if humanoid then
                                camera.CameraSubject = humanoid
                            elseif state.CameraSubject and state.CameraSubject.Parent then
                                camera.CameraSubject = state.CameraSubject
                            end
                        end
                        Lighting.FogColor = state.FogColor
                        Lighting.FogStart = state.FogStart
                        Lighting.FogEnd = state.FogEnd
                        if state.ColorEffect then
                            state.ColorEffect:Destroy()
                        end
                        if state.RedGui then
                            state.RedGui:Destroy()
                        end
                        if state.DeerDeathSound then
                            state.DeerDeathSound:Stop()
                            state.DeerDeathSound:Destroy()
                        end
                    end

                    local function startCutscene(deathModel)
                        local camera = Workspace.CurrentCamera
                        if not camera then
                            return
                        end
                        restoreCutscene()
                        local state = {
                            Camera = camera,
                            CameraType = camera.CameraType,
                            CameraSubject = camera.CameraSubject,
                            FogColor = Lighting.FogColor,
                            FogStart = Lighting.FogStart,
                            FogEnd = Lighting.FogEnd
                        }
                        cutsceneState = state

                        local redGui = Instance.new("ScreenGui")
                        redGui.Name = "DeerGodRedHaze"
                        redGui.IgnoreGuiInset = true
                        redGui.ResetOnSpawn = false
                        redGui.DisplayOrder = 90
                        redGui.Parent = playerGui
                        local veil = Instance.new("Frame")
                        veil.Size = UDim2.fromScale(1, 1)
                        veil.BackgroundColor3 = Color3.fromRGB(130, 20, 25)
                        veil.BackgroundTransparency = 0.94
                        veil.BorderSizePixel = 0
                        veil.Parent = redGui
                        state.RedGui = redGui

                        local effect = Instance.new("ColorCorrectionEffect")
                        effect.Name = "DeerGodDeathColor"
                        effect.TintColor = Color3.fromRGB(255, 190, 190)
                        effect.Saturation = -0.15
                        effect.Contrast = 0.1
                        effect.Parent = Lighting
                        state.ColorEffect = effect

                        Lighting.FogColor = Color3.fromRGB(100, 35, 40)
                        Lighting.FogStart = 5
                        Lighting.FogEnd = 50

                        local end1 = deathModel and deathModel:FindFirstChild("END1", true)
                        local end2 = deathModel and deathModel:FindFirstChild("END2", true)

                        if end1 and end1:IsA("BasePart") and end2 and end2:IsA("BasePart") then
                            local fromPosition = end1.Position
                            local toPosition = end2.Position
                            local difference = toPosition - fromPosition
                            local forward = difference.Magnitude > 0.001
                                and difference.Unit or end1.CFrame.LookVector
                            local cameraStartedAt = os.clock()
                            local startingCameraCFrame = CFrame.lookAt(fromPosition, fromPosition + forward)

                            camera.CameraType = Enum.CameraType.Scriptable
                            camera.CFrame = startingCameraCFrame
                            camera.Focus = CFrame.new(toPosition)

                            cutsceneConnection = RunService.RenderStepped:Connect(function()
                                local currentCamera = Workspace.CurrentCamera
                                if cutsceneActive and currentCamera then
                                    local alpha = math.clamp(
                                        (os.clock() - cameraStartedAt) / DEATH_SECONDS,
                                        0,
                                        1
                                    )
                                    local eased = alpha * alpha * (3 - 2 * alpha)
                                    local position = fromPosition:Lerp(toPosition, eased)
                                    currentCamera.CameraType = Enum.CameraType.Scriptable
                                    currentCamera.CFrame = CFrame.lookAt(position, position + forward)
                                    currentCamera.Focus = CFrame.new(toPosition)
                                end
                            end)
                        end

                        local hardCoreSound = Workspace:FindFirstChild("HardCoreSound")
                        local original = hardCoreSound and hardCoreSound:FindFirstChild("DeerDeath")
                        if original and original:IsA("Sound") then
                            local sound = original:Clone()
                            sound.Looped = false
                            sound.TimePosition = 0
                            sound.Parent = SoundService
                            sound:Play()
                            state.DeerDeathSound = sound
                        end
                    end

                    local function killTargetLocally(targetPlayer, targetCharacter)
                        setDeathCause(targetPlayer)
                        if targetPlayer == player and typeof(replicatesignal) == "function" then
                            pcall(function()
                                replicatesignal(player.Kill)
                            end)
                        end
                        local character = targetPlayer.Character
                        if character == targetCharacter then
                            local humanoid = character:FindFirstChildWhichIsA("Humanoid")
                            if humanoid and humanoid.Health > 0 then
                                humanoid.Health = 0
                            end
                        end
                    end

                    local function restoreVictimWalkSpeed()
                        if victimSpeedConnection then
                            victimSpeedConnection:Disconnect()
                            victimSpeedConnection = nil
                        end

                        if victimSpeedHumanoid and victimSpeedHumanoid.Parent and victimOriginalWalkSpeed ~= nil then
                            victimSpeedHumanoid.WalkSpeed = victimOriginalWalkSpeed
                        end

                        victimSpeedHumanoid = nil
                        victimOriginalWalkSpeed = nil
                    end

                    local function lockVictimWalkSpeed(humanoid)
                        restoreVictimWalkSpeed()

                        if not humanoid or not humanoid.Parent then
                            return
                        end

                        victimSpeedHumanoid = humanoid
                        victimOriginalWalkSpeed = humanoid.WalkSpeed
                        humanoid.WalkSpeed = -20

                        victimSpeedConnection = RunService.Heartbeat:Connect(function()
                            if not cutsceneActive or not victimSpeedHumanoid or not victimSpeedHumanoid.Parent then
                                restoreVictimWalkSpeed()
                                return
                            end

                            if victimSpeedHumanoid.WalkSpeed ~= -20 then
                                victimSpeedHumanoid.WalkSpeed = -20
                            end
                        end)
                    end

                    local function playDeathScene(targetPlayer, targetCharacter, targetHumanoid)
                        if targetPlayer ~= player or cutsceneActive or not running then
                            return
                        end
                        cutsceneActive = true
                        lockVictimWalkSpeed(targetHumanoid)
                        pauseAmbientSounds()
                        cutsceneSerial = cutsceneSerial + 1
                        local serial = cutsceneSerial
                        hitCharacters[targetCharacter] = true

                        local track = playVictimAnimation(targetHumanoid)
                        local deathModel = nil
                        if deathTemplate then
                            deathModel = deathTemplate:Clone()
                            deathModel.Name = "DeerGodDeathScene"
                            deathModel:PivotTo(CFrame.new(DEATH_POSITION))
                            deathModel.Parent = Workspace
                            activeDeerDeathModel = deathModel
                        end

                        if targetPlayer == player then
                            startCutscene(deathModel)
                        end

                        task.delay(DEATH_SECONDS, function()
                            if serial ~= cutsceneSerial then
                                restoreVictimWalkSpeed()
                                if track then
                                    track:Stop(0)
                                    track:Destroy()
                                end
                                if deathModel then
                                    deathModel:Destroy()
                                end
                                return
                            end

                            local camera = Workspace.CurrentCamera
                            if targetPlayer == player and camera and cutsceneState and cutsceneState.Camera == camera then
                                local end1 = deathModel and deathModel:FindFirstChild("END1", true)
                                local end2 = deathModel and deathModel:FindFirstChild("END2", true)
                                if end1 and end1:IsA("BasePart") and end2 and end2:IsA("BasePart") then
                                    local direction = end2.Position - end1.Position
                                    local forward = direction.Magnitude > 0.001 and direction.Unit or end1.CFrame.LookVector
                                    camera.CameraType = Enum.CameraType.Scriptable
                                    camera.CFrame = CFrame.lookAt(end2.Position, end2.Position + forward)
                                    camera.Focus = CFrame.new(end2.Position + forward * 10)
                                end
                            end

                            killTargetLocally(targetPlayer, targetCharacter)

                            task.delay(0.8, function()
                                if serial ~= cutsceneSerial then
                                    restoreVictimWalkSpeed()
                                    if track then
                                        track:Stop(0)
                                        track:Destroy()
                                    end
                                    if deathModel then
                                        deathModel:Destroy()
                                    end
                                    return
                                end

                                restoreVictimWalkSpeed()
                                if track then
                                    track:Stop(0)
                                    track:Destroy()
                                end
                                if deathModel then
                                    deathModel:Destroy()
                                end
                                if targetPlayer == player then
                                    restoreCutscene()
                                end
                                if lockedPlayer == targetPlayer and lockedCharacter == targetCharacter then
                                    lockedPlayer = nil
                                    lockedCharacter = nil
                                end
                                cutsceneActive = false
                            end)
                        end)
                    end

                    local shakeLoopSerial = 0

                    local function startDistanceShake()
                        shakeLoopSerial = shakeLoopSerial + 1
                        local serial = shakeLoopSerial
                        local cameraShaker = nil
                        local shakerModule = ReplicatedStorage:FindFirstChild("CameraShaker")

                        if shakerModule then
                            local loaded, CameraShaker = pcall(require, shakerModule)
                            if loaded and CameraShaker then
                                local created, shaker = pcall(function()
                                    local instance = CameraShaker.new(
                                        Enum.RenderPriority.Camera.Value + 1,
                                        function(shakeCFrame)
                                            local camera = Workspace.CurrentCamera
                                            if camera and not cutsceneActive then
                                                camera.CFrame = camera.CFrame * shakeCFrame
                                            end
                                        end
                                    )
                                    instance:Start()
                                    return instance
                                end)
                                if created then
                                    cameraShaker = shaker
                                end
                            end
                        end

                        task.spawn(function()
                            while running and entity and entity.Parent and serial == shakeLoopSerial do
                                if not cutsceneActive then
                                    local _, root, humanoid = getAliveCharacter(player)
                                    local distance = math.huge
                                    if root then
                                        distance = (root.Position - entity:GetPivot().Position).Magnitude
                                    end

                                    local proximity = math.clamp(
                                        1 - distance / CAMERA_SHAKE_MAX_DISTANCE,
                                        0,
                                        1
                                    )
                                    local magnitude = CAMERA_SHAKE_MIN_MAGNITUDE
                                        + (CAMERA_SHAKE_MAX_MAGNITUDE - CAMERA_SHAKE_MIN_MAGNITUDE) * proximity

                                    if cameraShaker then
                                        pcall(function()
                                            cameraShaker:ShakeOnce(magnitude, 10, 0.05, 0.4)
                                        end)
                                    elseif humanoid then
                                        local originalOffset = humanoid.CameraOffset
                                        local offset = Vector3.new(
                                            math.random(-100, 100) / 100,
                                            math.random(-100, 100) / 100,
                                            math.random(-50, 50) / 100
                                        ) * magnitude

                                        local inTween = TweenService:Create(
                                            humanoid,
                                            TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                            { CameraOffset = originalOffset + offset }
                                        )
                                        local outTween = TweenService:Create(
                                            humanoid,
                                            TweenInfo.new(0.28, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                            { CameraOffset = originalOffset }
                                        )

                                        inTween:Play()
                                        task.delay(0.09, function()
                                            if humanoid and humanoid.Parent then
                                                outTween:Play()
                                            end
                                        end)
                                    end
                                end

                                task.wait(CAMERA_SHAKE_INTERVAL)
                            end

                            if cameraShaker then
                                pcall(function()
                                    cameraShaker:Stop()
                                end)
                            end
                        end)
                    end

                    local function getNearestPlayer(position)
                        local nearest = nil
                        local nearestDistance = CHASE_RANGE
                        for _, candidate in ipairs(Players:GetPlayers()) do
                            local character, root = getAliveCharacter(candidate)
                            if character and root and not hitCharacters[character] then
                                local distance = (root.Position - position).Magnitude
                                if distance <= nearestDistance then
                                    nearestDistance = distance
                                    nearest = candidate
                                end
                            end
                        end
                        return nearest
                    end

                    local function findRouteGoal()
                        if currentGoal then
                            local room = currentGoal.Room
                            local node = currentGoal.Node
                            if room and room.Parent and node and node:IsDescendantOf(room)
                                and not nodeAlreadyCompleted(
                                    currentGoal.RoomNumber, node, currentGoal.Index, currentGoal.IsExit
                                ) then
                                return currentGoal
                            end
                            currentGoal = nil
                            pathMovement = nil
                        end

                        local orderedRooms = getRooms()
                        if #orderedRooms == 0 then
                            return "finished"
                        end

                        local roomIndex = nil
                        for index, data in ipairs(orderedRooms) do
                            if data.Number >= currentRoomNumber then
                                roomIndex = index
                                break
                            end
                        end
                        if not roomIndex then
                            return "finished"
                        end

                        local targetRoomIndex = math.max(1, #orderedRooms - 1)

                        for index = roomIndex, targetRoomIndex do
                            local roomData = orderedRooms[index]
                            local room = roomData.Room
                            local nodes = getNodes(room)
                            local nextNode = nil
                            local nextIndex = 0
                            local isExit = false

                            if #nodes > 0 then
                                for nodeIndex, node in ipairs(nodes) do
                                    if not nodeAlreadyCompleted(roomData.Number, node, nodeIndex, false) then
                                        nextNode = node
                                        nextIndex = nodeIndex
                                        break
                                    end
                                end
                            else
                                local roomExit = getRoomExit(room)
                                if roomExit and not nodeAlreadyCompleted(roomData.Number, roomExit, 0, true) then
                                    nextNode = roomExit
                                    isExit = true
                                end
                            end

                            if nextNode then
                                if roomData.Number > currentRoomNumber then
                                    if roomsEntered >= MAX_ROOMS then
                                        return "finished"
                                    end
                                    currentRoomNumber = roomData.Number
                                    roomsEntered = roomsEntered + 1
                                end

                                currentGoal = {
                                    Room = room,
                                    RoomNumber = roomData.Number,
                                    Node = nextNode,
                                    Index = nextIndex,
                                    IsExit = isExit
                                }
                                return currentGoal
                            end

                            if roomsEntered >= MAX_ROOMS then
                                return "finished"
                            end
                        end

                        return "finished"
                    end

                    local lastChasePosition = nil
                    local lastChaseProgressCheck = 0

                    local function markWaypointsPassedDuringChase(fromPosition, toPosition)
                        local travel = toPosition - fromPosition
                        local distanceSquared = travel:Dot(travel)
                        if distanceSquared <= 0.0001 then
                            return
                        end

                        local orderedRooms = getRooms()
                        local targetRoomIndex = math.max(1, #orderedRooms - 1)
                        local laterRoomsToEnter = MAX_ROOMS - roomsEntered

                        for roomIndex = 1, targetRoomIndex do
                            local roomData = orderedRooms[roomIndex]
                            if roomData.Number >= currentRoomNumber then
                                if roomData.Number > currentRoomNumber then
                                    if laterRoomsToEnter <= 0 then
                                        break
                                    end
                                    laterRoomsToEnter = laterRoomsToEnter - 1
                                end

                                local nodes = getNodes(roomData.Room)
                                if #nodes > 0 then
                                    for index, node in ipairs(nodes) do
                                        if not nodeAlreadyCompleted(roomData.Number, node, index, false) then
                                            local waypointPosition = node.Position + HEIGHT_OFFSET
                                            local fraction = math.clamp(
                                                (waypointPosition - fromPosition):Dot(travel) / distanceSquared,
                                                0,
                                                1
                                            )
                                            local nearestPosition = fromPosition + travel * fraction
                                            if (nearestPosition - waypointPosition).Magnitude <= WAYPOINT_PASS_RADIUS then
                                                completeNode(roomData.Number, node, index, false)
                                            end
                                        end
                                    end
                                else
                                    local roomExit = getRoomExit(roomData.Room)
                                    if roomExit and not nodeAlreadyCompleted(roomData.Number, roomExit, 0, true) then
                                        local waypointPosition = roomExit.Position + HEIGHT_OFFSET
                                        local fraction = math.clamp(
                                            (waypointPosition - fromPosition):Dot(travel) / distanceSquared,
                                            0,
                                            1
                                        )
                                        local nearestPosition = fromPosition + travel * fraction
                                        if (nearestPosition - waypointPosition).Magnitude <= WAYPOINT_PASS_RADIUS then
                                            completeNode(roomData.Number, roomExit, 0, true)
                                        end
                                    end
                                end
                            end
                        end

                        if currentGoal and nodeAlreadyCompleted(
                            currentGoal.RoomNumber, currentGoal.Node, currentGoal.Index, currentGoal.IsExit
                        ) then
                            currentGoal = nil
                            pathMovement = nil
                        end
                    end

                    local function finish()
                        if finished then
                            return
                        end
                        finished = true
                        running = false
                        shakeLoopSerial = shakeLoopSerial + 1
                        cutsceneSerial = cutsceneSerial + 1
                        restoreVictimWalkSpeed()
                        restoreCutscene()
                        stopErrorParticles()
                        if activeDeerDeathModel then
                            if activeDeerDeathModel.Parent then
                                activeDeerDeathModel:Destroy()
                            end
                            activeDeerDeathModel = nil
                        end
                        for _, sound in ipairs(ambientSounds) do
                            if sound.Parent then
                                sound:Stop()
                            end
                        end
                        for _, sound in ipairs(saySounds) do
                            if sound.Parent then
                                sound:Stop()
                            end
                        end
                        if entity and entity.Parent then
                            entity:Destroy()
                        end
                        if deathTemplate then
                            deathTemplate:Destroy()
                            deathTemplate = nil
                        end
                        animation:Destroy()
                    end

                    startDistanceShake()
                    startErrorParticles()

                    task.spawn(function()
                        while running and entity and entity.Parent do
                            task.wait(math.random(5, 10))
                            if not running or not entity or not entity.Parent then
                                break
                            end

                            local availableSounds = {}
                            for _, sound in ipairs(saySounds) do
                                if sound and sound.Parent and sound:IsDescendantOf(entity) then
                                    availableSounds[#availableSounds + 1] = sound
                                end
                            end

                            if #availableSounds > 0 then
                                for _, sound in ipairs(availableSounds) do
                                    if sound.IsPlaying then
                                        sound:Stop()
                                    end
                                end

                                local selectedSound = availableSounds[math.random(1, #availableSounds)]
                                selectedSound.TimePosition = 0
                                selectedSound:Play()
                            end
                        end

                        for _, sound in ipairs(saySounds) do
                            if sound and sound.Parent and sound.IsPlaying then
                                sound:Stop()
                            end
                        end
                    end)

                    while running and entity.Parent do
                        local deltaTime = RunService.Heartbeat:Wait()
                        if isDeerGodRestrictedPhase() then
                            break
                        end

                        if not cutsceneActive then
                            if lockedPlayer then
                                local character = getAliveCharacter(lockedPlayer)
                                if character ~= lockedCharacter then
                                    lockedPlayer = nil
                                    lockedCharacter = nil
                                end
                            end

                            if not lockedPlayer then
                                lockedPlayer = getNearestPlayer(entity:GetPivot().Position)
                                lockedCharacter = lockedPlayer and lockedPlayer.Character or nil
                            end

                            if lockedPlayer then
                                pathMovement = nil
                                local character, root, humanoid = getAliveCharacter(lockedPlayer)
                                if character and root and humanoid and character == lockedCharacter then
                                    if not lastChasePosition then
                                        lastChasePosition = entity:GetPivot().Position
                                    end
                                    local previousPosition = lastChasePosition
                                    approach(entity, root.Position, deltaTime)
                                    local currentPosition = entity:GetPivot().Position
                                    if os.clock() - lastChaseProgressCheck >= 0.1 then
                                        markWaypointsPassedDuringChase(previousPosition, currentPosition)
                                        lastChasePosition = currentPosition
                                        lastChaseProgressCheck = os.clock()
                                    end
                                else
                                    lockedPlayer = nil
                                    lockedCharacter = nil
                                    if lastChasePosition then
                                        markWaypointsPassedDuringChase(lastChasePosition, entity:GetPivot().Position)
                                    end
                                    lastChasePosition = nil
                                    lastChaseProgressCheck = 0
                                end
                            else
                                if lastChasePosition then
                                    markWaypointsPassedDuringChase(lastChasePosition, entity:GetPivot().Position)
                                end
                                lastChasePosition = nil
                                lastChaseProgressCheck = 0
                                local goal = findRouteGoal()
                                if goal == "finished" then
                                    break
                                elseif goal then
                                    local room = goal.Room
                                    local node = goal.Node
                                    if room.Parent and node:IsDescendantOf(room) then
                                        if moveAlongOriginalRipperPath(entity, node, deltaTime) then
                                            completeNode(goal.RoomNumber, node, goal.Index, goal.IsExit)
                                            currentGoal = nil
                                        end
                                    else
                                        currentGoal = nil
                                        pathMovement = nil
                                    end
                                else
                                    break
                                end
                            end

                            local myCharacter, myRoot, myHumanoid = getAliveCharacter(player)
                            if myCharacter and myRoot and myHumanoid
                                and not hitCharacters[myCharacter]
                                and not isDeerGodRestrictedPhase()
                                and rayCanHit(entity, myCharacter) then
                                playDeathScene(player, myCharacter, myHumanoid)
                            end
                        end
                    end

                    finish()
                end, function(err)
                    return tostring(err)
                end)
                if not ok then
                    warn("Hardcore Deer God event failed: " .. tostring(message))
                end
            end
        end)

        task.spawn(function()
            while task.wait(320) do
                if workspace:FindFirstChild("SeekMovingNewClone") then
                    continue
                end
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local NEAR_SOUND_DISTANCE = 115
local FAR_MAX_DISTANCE = 360
local FAR_MIN_VOLUME = 0.02
local MODEL_Y_OFFSET = -15
local SOUND_CONFIRM_TIME = 0.08

local HardCoreSound = workspace:WaitForChild("HardCoreSound")

local SilenceSound =
    HardCoreSound:WaitForChild("Silence")

local SilenceFarSound =
    HardCoreSound:WaitForChild("SilenceFar")

SilenceSound.Volume = 5
SilenceSound.Looped = false

SilenceFarSound.Volume = 1
SilenceFarSound.Looped = false

local player = Players.LocalPlayer

local function GetPlayerPosition1()
    local character = player.Character

    if character then
        local root = character:FindFirstChild("HumanoidRootPart")

        if root then
            return root.Position
        end
    end

    local camera = workspace.CurrentCamera

    if camera then
        return camera.CFrame.Position
    end

    return Vector3.zero
end

local function GetDistance1(position)
    return (GetPlayerPosition1() - position).Magnitude
end

local function ResetSound1(sound)
    sound:Stop()

    pcall(function()
        sound.TimePosition = 0
    end)
end

local function GetFarVolume1(distance)
    if distance <= NEAR_SOUND_DISTANCE then
        return 1
    end

    if distance >= FAR_MAX_DISTANCE then
        return FAR_MIN_VOLUME
    end

    local alpha =
        (distance - NEAR_SOUND_DISTANCE)
        / (FAR_MAX_DISTANCE - NEAR_SOUND_DISTANCE)

    local volume =
        (1 - alpha) ^ 1.25

    return math.clamp(
        volume,
        FAR_MIN_VOLUME,
        1
    )
end

local shakeID = 0
local currentShake = nil
local currentShakeOffset = CFrame.new()
local currentOriginalFOV = nil

local function StopShake1()
    local camera = workspace.CurrentCamera

    if currentShake then
        pcall(function()
            RunService:UnbindFromRenderStep(currentShake)
        end)
    end

    if camera then
        pcall(function()
            camera.CFrame =
                camera.CFrame
                * currentShakeOffset:Inverse()
        end)

        if currentOriginalFOV then
            camera.FieldOfView =
                currentOriginalFOV
        end
    end

    currentShake = nil
    currentShakeOffset = CFrame.new()
    currentOriginalFOV = nil
end

local function SilenceShake1(entityPosition)
    local camera = workspace.CurrentCamera

    if not camera then
        return
    end

    StopShake1()

    shakeID += 1

    local bindName =
        "SilenceShake_" .. shakeID

    currentShake = bindName
    currentShakeOffset = CFrame.new()

    local distance =
        GetDistance1(entityPosition)

    local distancePower =
        math.clamp(
            1 - ((distance - 8) / 190),
            0.05,
            1
        )

    local shakeStrength =
        0.2
        + ((distancePower ^ 1.35) * 3.8)

    local originalFOV =
        camera.FieldOfView

    currentOriginalFOV =
        originalFOV

    local targetFOV =
        math.clamp(
            originalFOV
            + 72 * distancePower,
            originalFOV,
            120
        )

    local attackTime = 0.07
    local fadeTime = 2.1
    local totalTime =
        attackTime + fadeTime

    local started =
        os.clock()

    RunService:BindToRenderStep(
        bindName,
        Enum.RenderPriority.Camera.Value + 1,
        function()
            if currentShake ~= bindName then
                return
            end

            local elapsed =
                os.clock() - started

            if elapsed >= totalTime then
                camera.CFrame =
                    camera.CFrame
                    * currentShakeOffset:Inverse()

                currentShakeOffset =
                    CFrame.new()

                camera.FieldOfView =
                    originalFOV

                RunService:UnbindFromRenderStep(
                    bindName
                )

                if currentShake == bindName then
                    currentShake = nil
                    currentOriginalFOV = nil
                end

                return
            end

            local envelope
            local fov

            if elapsed <= attackTime then
                local alpha =
                    math.clamp(
                        elapsed / attackTime,
                        0,
                        1
                    )

                local impact =
                    1 - ((1 - alpha) ^ 5)

                envelope = impact

                fov =
                    originalFOV
                    + (
                        targetFOV
                        - originalFOV
                    )
                    * impact
            else
                local alpha =
                    math.clamp(
                        (elapsed - attackTime)
                        / fadeTime,
                        0,
                        1
                    )

                envelope =
                    (1 - alpha) ^ 1.3

                fov =
                    originalFOV
                    + (
                        targetFOV
                        - originalFOV
                    )
                    * envelope
            end

            camera.FieldOfView =
                fov

            local t =
                math.max(
                    elapsed - attackTime,
                    0
                )

            local wave1 =
                math.sin(
                    t * math.pi * 9.4
                )

            local wave2 =
                math.sin(
                    t * math.pi * 15.8
                    + 0.75
                )

            local wave3 =
                math.sin(
                    t * math.pi * 22.2
                    + 1.6
                )

            local verticalWave =
                math.sin(
                    t * math.pi * 12.6
                    + 1.15
                )

            local rollWave =
                math.sin(
                    t * math.pi * 10.1
                    + 0.35
                )

            local pitchWave =
                math.sin(
                    t * math.pi * 7.5
                    + 1.1
                )

            local x =
                (
                    wave1 * 0.22
                    + wave2 * 0.07
                    + wave3 * 0.025
                )
                * shakeStrength
                * envelope

            local y =
                verticalWave
                * 0.032
                * shakeStrength
                * envelope

            local yaw =
                (
                    wave1 * math.rad(0.6)
                    + wave2 * math.rad(0.18)
                )
                * shakeStrength
                * envelope

            local roll =
                rollWave
                * math.rad(0.88)
                * shakeStrength
                * envelope

            local pitch =
                pitchWave
                * math.rad(0.14)
                * shakeStrength
                * envelope

            local newOffset =
                CFrame.new(
                    x,
                    y,
                    0
                )
                * CFrame.Angles(
                    pitch,
                    yaw,
                    roll
                )

            camera.CFrame =
                camera.CFrame
                * currentShakeOffset:Inverse()
                * newOffset

            currentShakeOffset =
                newOffset
        end
    )
end

local jumpscareActive = false
local jumpscareFinished = false

local ceaseFreezeActive = false
local ceaseSpeedScale = 1
local ceaseEventRunning = false
local ceaseSilenceModel = nil
local ceaseFreezeCycle = 0
local ceaseSavedEffects = {}
local ceaseEffectConnection = nil
local ceaseClockConnection = nil
local ceaseVirtualClock = 0
local ceaseHandledModels = setmetatable({}, {__mode = "k"})
local ceaseRefreshWatcher = nil

local function CeaseTime1()
    return ceaseVirtualClock
end

local function CeaseEasing1(alpha)
    alpha = math.clamp(alpha, 0, 1)
    return alpha * alpha * (3 - 2 * alpha)
end

local function CeaseApply1(scale)
    ceaseSpeedScale = math.clamp(scale, 0, 1)

    for object, saved in pairs(ceaseSavedEffects) do
        if object.Parent then
            if saved.Type == "Particle" then
                pcall(function()
                    object.TimeScale = saved.TimeScale * ceaseSpeedScale
                end)
            else
                pcall(function()
                    object.PlaybackSpeed = saved.PlaybackSpeed * ceaseSpeedScale
                end)
                pcall(function()
                    object.Volume = saved.Volume * ceaseSpeedScale
                end)
            end
        end
    end
end

local function CeaseTrack1(object)
    if ceaseSavedEffects[object] then
        return
    end

    if object:IsA("ParticleEmitter") then
        ceaseSavedEffects[object] = {
            Type = "Particle",
            TimeScale = object.TimeScale
        }
    elseif object:IsA("Sound") then
        ceaseSavedEffects[object] = {
            Type = "Sound",
            PlaybackSpeed = object.PlaybackSpeed,
            Volume = object.Volume
        }
    else
        return
    end

    local saved = ceaseSavedEffects[object]
    if saved.Type == "Particle" then
        pcall(function()
            object.TimeScale = saved.TimeScale * ceaseSpeedScale
        end)
    else
        pcall(function()
            object.PlaybackSpeed = saved.PlaybackSpeed * ceaseSpeedScale
        end)
        pcall(function()
            object.Volume = saved.Volume * ceaseSpeedScale
        end)
    end
end

local function CeaseRestore1()
    ceaseFreezeCycle += 1

    if ceaseEffectConnection then
        ceaseEffectConnection:Disconnect()
        ceaseEffectConnection = nil
    end

    for object, saved in pairs(ceaseSavedEffects) do
        if object.Parent then
            if saved.Type == "Particle" then
                pcall(function()
                    object.TimeScale = saved.TimeScale
                end)
            else
                pcall(function()
                    object.PlaybackSpeed = saved.PlaybackSpeed
                    object.Volume = saved.Volume
                end)
            end
        end
    end

    table.clear(ceaseSavedEffects)
    ceaseSpeedScale = 1
    ceaseFreezeActive = false

    if ceaseEventRunning and ceaseRefreshWatcher then
        ceaseRefreshWatcher()
    end
end

local function CeaseStart1(ceaseModel)
    if not ceaseEventRunning or ceaseFreezeActive
        or not ceaseSilenceModel or not ceaseSilenceModel.Parent
        or jumpscareActive or jumpscareFinished
        or ceaseHandledModels[ceaseModel]
    then
        return
    end

    ceaseHandledModels[ceaseModel] = true
    ceaseFreezeActive = true
    ceaseFreezeCycle += 1
    local cycle = ceaseFreezeCycle

    for _, object in ipairs(ceaseSilenceModel:GetDescendants()) do
        CeaseTrack1(object)
    end

    CeaseTrack1(SilenceSound)
    CeaseTrack1(SilenceFarSound)

    ceaseEffectConnection = ceaseSilenceModel.DescendantAdded:Connect(function(object)
        if ceaseEventRunning and ceaseFreezeCycle == cycle then
            CeaseTrack1(object)
        end
    end)

    task.spawn(function()
        local function valid()
            return ceaseEventRunning
                and ceaseFreezeCycle == cycle
                and ceaseSilenceModel ~= nil
                and ceaseSilenceModel.Parent ~= nil
                and not jumpscareFinished
        end

        local function transition(fromScale, toScale, duration)
            local started = os.clock()

            while valid() do
                local alpha = math.clamp((os.clock() - started) / duration, 0, 1)
                local eased = CeaseEasing1(alpha)
                CeaseApply1(fromScale + (toScale - fromScale) * eased)

                if alpha >= 1 then
                    return true
                end

                RunService.Heartbeat:Wait()
            end

            return false
        end

        if not transition(1, 0, 2.25) then
            if ceaseFreezeCycle == cycle then
                CeaseRestore1()
            end
            return
        end

        local started = os.clock()
        while os.clock() - started < 13 do
            if not valid() then
                if ceaseFreezeCycle == cycle then
                    CeaseRestore1()
                end
                return
            end
            task.wait(0.05)
        end

        if not transition(0, 1, 2) then
            if ceaseFreezeCycle == cycle then
                CeaseRestore1()
            end
            return
        end

        if ceaseFreezeCycle == cycle then
            CeaseRestore1()
        end
    end)
end

local function CeaseStop1()
    ceaseEventRunning = false
    CeaseRestore1()

    if ceaseClockConnection then
        ceaseClockConnection:Disconnect()
        ceaseClockConnection = nil
    end

    ceaseSilenceModel = nil
end


local function TriggerJumpscare1()
    if jumpscareActive or jumpscareFinished or ceaseFreezeActive then
        return
    end

    jumpscareActive = true

    ResetSound1(SilenceFarSound)
    ResetSound1(SilenceSound)

    SilenceSound.Volume = 5
    SilenceSound:Play()

    StopShake1()

    local character =
        player.Character

    if not character then
        jumpscareActive = false
        return
    end

    local humanoid =
        character:FindFirstChildOfClass(
            "Humanoid"
        )

    local playerGui =
        player:WaitForChild(
            "PlayerGui"
        )

    local oldGui =
        playerGui:FindFirstChild(
            "SilenceJumpscare"
        )

    if oldGui then
        oldGui:Destroy()
    end

    local gui =
        Instance.new("ScreenGui")

    gui.Name =
        "SilenceJumpscare"

    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.DisplayOrder = 1000000

    gui.ZIndexBehavior =
        Enum.ZIndexBehavior.Sibling

    gui.Parent =
        playerGui

    local black =
        Instance.new("Frame")

    black.Size =
        UDim2.fromScale(1, 1)

    black.Position =
        UDim2.fromScale(0, 0)

    black.BackgroundColor3 =
        Color3.new(0, 0, 0)

    black.BorderSizePixel = 0
    black.ZIndex = 1
    black.Parent = gui

    local snow =
        Instance.new("ImageLabel")

    snow.AnchorPoint =
        Vector2.new(0.5, 0.5)

    snow.Position =
        UDim2.fromScale(0.5, 0.5)

    snow.Size =
        UDim2.fromScale(1.1, 1.1)

    snow.BackgroundTransparency = 1
    snow.ImageTransparency = 0

    snow.ScaleType =
        Enum.ScaleType.Stretch

    snow.ZIndex = 2
    snow.Parent = gui

    local jumpscare =
        Instance.new("ImageLabel")

    jumpscare.AnchorPoint =
        Vector2.new(0.5, 0.5)

    jumpscare.Position =
        UDim2.fromScale(0.5, 0.5)

    jumpscare.Size =
        UDim2.fromScale(1.02, 1.02)

    jumpscare.BackgroundTransparency = 1

    jumpscare.Image =
        "rbxassetid://14359776338"

    jumpscare.ImageTransparency = 0

    jumpscare.ScaleType =
        Enum.ScaleType.Stretch

    jumpscare.ZIndex = 3
    jumpscare.Parent = gui

    local snowImages = {
        "rbxassetid://117266253034518",
        "rbxassetid://8454012934",
        "rbxassetid://122347391038526"
    }

    snow.Image =
        snowImages[1]

    local camera =
        workspace.CurrentCamera

    local originalFOV =
        camera and camera.FieldOfView or 70

    local duration = 0.8
    local started = os.clock()
    local snowIndex = 1
    local lastSnow = 0

    while true do
        local elapsed =
            os.clock() - started

        local alpha =
            math.clamp(
                elapsed / duration,
                0,
                1
            )

        if elapsed - lastSnow >= 0.045 then
            lastSnow = elapsed

            snowIndex += 1

            if snowIndex > #snowImages then
                snowIndex = 1
            end

            snow.Image =
                snowImages[snowIndex]
        end

        local curve =
            1 - ((1 - alpha) ^ 3)

        local pulse =
            math.sin(
                alpha
                * math.pi
                * 9
            )

        local scale =
            1.02
            + curve * 0.12
            + pulse
            * 0.014
            * (1 - alpha)

        jumpscare.Size =
            UDim2.fromScale(
                scale,
                scale
            )

        jumpscare.Rotation =
            math.sin(
                alpha
                * math.pi
                * 11
            )
            * 0.75
            * (1 - alpha)

        local snowScale =
            1.1
            + math.sin(
                alpha
                * math.pi
                * 13
            )
            * 0.02

        snow.Size =
            UDim2.fromScale(
                snowScale,
                snowScale
            )

        if camera then
            camera.FieldOfView =
                originalFOV
                + 8 * curve
                + (
                    math.sin(
                        alpha
                        * math.pi
                        * 8
                    )
                    * 1.5
                    * (1 - alpha)
                )
        end

        if alpha >= 1 then
            break
        end

        RunService.RenderStepped:Wait()
    end

    if humanoid and humanoid.Parent and not ceaseFreezeActive then
        humanoid:TakeDamage(100)
    end

    local fadeDuration =
        0.45

    local fadeStarted =
        os.clock()

    while true do
        local alpha =
            math.clamp(
                (os.clock() - fadeStarted)
                / fadeDuration,
                0,
                1
            )

        local eased =
            1 - ((1 - alpha) ^ 3)

        jumpscare.ImageTransparency =
            eased

        snow.ImageTransparency =
            eased

        black.BackgroundTransparency =
            eased

        jumpscare.Size =
            UDim2.fromScale(
                1.14
                + eased * 0.04,
                1.14
                + eased * 0.04
            )

        if camera then
            camera.FieldOfView =
                originalFOV
                + 8
                * (1 - eased)
        end

        if alpha >= 1 then
            break
        end

        RunService.RenderStepped:Wait()
    end

    if camera then
        camera.FieldOfView =
            originalFOV
    end

    gui:Destroy()

    jumpscareFinished = true
    jumpscareActive = false
end

local soundWatchConnection = nil
local soundConnections = {}
local soundConfirmTokens = {}
local nearSilence = false

local function IsRealPlayingSound1(object)
    if not object then
        return false
    end

    if not object:IsA("Sound") then
        return false
    end

    local character =
        player.Character

    if not character then
        return false
    end

    if not object:IsDescendantOf(character) then
        return false
    end

    if object.SoundId == "" then
        return false
    end

    if object.Volume <= 0 then
        return false
    end

    if not object.Playing then
        return false
    end

    return true
end

local function CancelSoundConfirmation1(sound)
    soundConfirmTokens[sound] =
        (soundConfirmTokens[sound] or 0) + 1
end

local function ConfirmPlayingSound1(sound)
    if not nearSilence then
        return
    end

    if jumpscareActive or jumpscareFinished or ceaseFreezeActive then
        return
    end

    if not IsRealPlayingSound1(sound) then
        return
    end

    soundConfirmTokens[sound] =
        (soundConfirmTokens[sound] or 0) + 1

    local token =
        soundConfirmTokens[sound]

    task.delay(
        SOUND_CONFIRM_TIME,
        function()
            if not nearSilence then
                return
            end

            if jumpscareActive or jumpscareFinished or ceaseFreezeActive then
                return
            end

            if soundConfirmTokens[sound] ~= token then
                return
            end

            if not sound or not sound.Parent then
                return
            end

            if not IsRealPlayingSound1(sound) then
                return
            end

            task.spawn(
                TriggerJumpscare1
            )
        end
    )
end

local function DisconnectWatchedSound1(sound)
    local connections =
        soundConnections[sound]

    if connections then
        for _, connection in ipairs(
            connections
        ) do
            if connection then
                connection:Disconnect()
            end
        end
    end

    soundConnections[sound] = nil
    soundConfirmTokens[sound] = nil
end

local function WatchSound1(sound)
    if not sound:IsA("Sound") then
        return
    end

    DisconnectWatchedSound1(sound)

    soundConnections[sound] = {}

    table.insert(
        soundConnections[sound],
        sound:GetPropertyChangedSignal(
            "Playing"
        ):Connect(function()
            if sound.Playing then
                ConfirmPlayingSound1(sound)
            else
                CancelSoundConfirmation1(sound)
            end
        end)
    )

    table.insert(
        soundConnections[sound],
        sound.AncestryChanged:Connect(
            function()
                local character =
                    player.Character

                if
                    not character
                    or not sound:IsDescendantOf(character)
                then
                    CancelSoundConfirmation1(sound)
                    DisconnectWatchedSound1(sound)
                end
            end
        )
    )

    if sound.Playing then
        ConfirmPlayingSound1(sound)
    end
end

local function StopSoundWatcher1()
    nearSilence = false

    if soundWatchConnection then
        soundWatchConnection:Disconnect()
        soundWatchConnection = nil
    end

    local sounds = {}

    for sound in pairs(
        soundConnections
    ) do
        table.insert(
            sounds,
            sound
        )
    end

    for _, sound in ipairs(
        sounds
    ) do
        CancelSoundConfirmation1(sound)
        DisconnectWatchedSound1(sound)
    end

    table.clear(
        soundConfirmTokens
    )
end

local function StartSoundWatcher1()
    StopSoundWatcher1()

    local character =
        player.Character

    if not character then
        return
    end

    nearSilence = true

    for _, object in ipairs(
        character:GetDescendants()
    ) do
        if object:IsA("Sound") then
            WatchSound1(object)
        end
    end

    soundWatchConnection =
        character.DescendantAdded:Connect(
            function(object)
                if not nearSilence then
                    return
                end

                if object:IsA("Sound") then
                    WatchSound1(object)
                end
            end
        )
end

ceaseRefreshWatcher = function()
    if nearSilence and not jumpscareActive and not jumpscareFinished then
        StartSoundWatcher1()
    end
end

local audioToken = 0

local function StartRoomAudio1(
    entityPosition,
    totalDuration
)
    audioToken += 1

    local token =
        audioToken

    ResetSound1(SilenceSound)
    ResetSound1(SilenceFarSound)

    task.spawn(
        SilenceShake1,
        entityPosition
    )

    task.spawn(function()
        local started =
            CeaseTime1()

        local currentMode =
            nil

        while
            audioToken == token
            and not jumpscareFinished
            and CeaseTime1() - started < totalDuration
        do
            if ceaseFreezeActive then
                RunService.Heartbeat:Wait()
            else
                local distance =
                    GetDistance1(
                        entityPosition
                    )

                if distance <= NEAR_SOUND_DISTANCE then
                    if currentMode ~= "near" then
                        ResetSound1(
                            SilenceFarSound
                        )

                        ResetSound1(
                            SilenceSound
                        )

                        SilenceSound.Volume =
                            5

                        SilenceSound:Play()

                        currentMode =
                            "near"
                    end

                    if not nearSilence then
                        StartSoundWatcher1()
                    end
                else
                    if nearSilence then
                        StopSoundWatcher1()
                    end

                    local farVolume =
                        GetFarVolume1(
                            distance
                        )

                    if currentMode ~= "far" then
                        ResetSound1(
                            SilenceSound
                        )

                        ResetSound1(
                            SilenceFarSound
                        )

                        SilenceFarSound.Volume =
                            farVolume

                        SilenceFarSound:Play()

                        currentMode =
                            "far"
                    else
                        SilenceFarSound.Volume =
                            farVolume
                    end
                end

                RunService.Heartbeat:Wait()
            end
        end

        if nearSilence then
            StopSoundWatcher1()
        end
    end)
end

    jumpscareActive = false
    jumpscareFinished = false

    StopSoundWatcher1()

    local CurrentRooms =
        workspace:WaitForChild(
            "CurrentRooms"
        )

    local rooms = {}

    for _, room in ipairs(
        CurrentRooms:GetChildren()
    ) do
        local number =
            tonumber(room.Name)

        if
            number
            and number >= 1
            
        then
            table.insert(
                rooms,
                {
                    Number = number,
                    Room = room
                }
            )
        end
    end

    table.sort(
        rooms,
        function(a, b)
            return
                a.Number
                < b.Number
        end
    )

    if #rooms == 0 then
        return
    end

    local loaded =
        game:GetObjects(
            "rbxassetid://131690436250513"
        )

    local Silence =
        loaded[1]

    if not Silence then
        return
    end

    if not Silence:IsA("Model") then
        local holder =
            Instance.new("Model")

        holder.Name =
            "Silence"

        Silence.Parent =
            holder

        Silence =
            holder
    end

    Silence.Name =
        "Silence"

    Silence.Parent =
        workspace

    CeaseStop1()
    ceaseVirtualClock = 0
    ceaseSilenceModel = Silence
    ceaseEventRunning = true
    ceaseClockConnection = RunService.Heartbeat:Connect(function(dt)
        if ceaseEventRunning then
            ceaseVirtualClock += dt * ceaseSpeedScale
        end
    end)

    task.spawn(function()
        while ceaseEventRunning and ceaseSilenceModel == Silence and Silence.Parent do
            local ceaseModel = workspace:FindFirstChild("Cease", true)
            if ceaseModel and ceaseModel:IsA("Model") and not ceaseHandledModels[ceaseModel] then
                CeaseStart1(ceaseModel)
            end
            task.wait(0.1)
        end
    end)

    for _, object in ipairs(
        Silence:GetDescendants()
    ) do
        if object:IsA("BasePart") then
            object.Anchored = true
            object.CanCollide = false
            object.CanTouch = false
            object.CanQuery = false
        end
    end

    local modelRotation =
        Silence:GetPivot().Rotation

    Silence:PivotTo(
        CFrame.new(
            0,
            0,
            0
        )
        * modelRotation
    )

    local modelBoxCF,
        modelBoxSize =
        Silence:GetBoundingBox()

    local modelBottom =
        modelBoxCF.Position.Y
        - modelBoxSize.Y * 0.5

    local bottomOffset =
        -modelBottom

    local function GetRoomSize1(room)
        if room:IsA("Model") then
            local _, size =
                room:GetBoundingBox()

            return size
        end

        if room:IsA("BasePart") then
            return room.Size
        end

        return Vector3.new(
            30,
            20,
            30
        )
    end

    local function FindFloor1(room)
        local entrance =
            room:FindFirstChild(
                "RoomEntrance"
            )

        if not entrance then
            entrance =
                room:FindFirstChild(
                    "RoomEntrance",
                    true
                )
        end

        if
            entrance
            and entrance:IsA("BasePart")
        then
            local targetCF =
                entrance.CFrame
                * CFrame.new(
                    0,
                    0,
                    -15
                )

            local target =
                targetCF.Position

            local params =
                RaycastParams.new()

            params.FilterType =
                Enum.RaycastFilterType.Include

            params.FilterDescendantsInstances = {
                room
            }

            params.IgnoreWater =
                true

            local origin =
                target
                + Vector3.new(
                    0,
                    35,
                    0
                )

            local result =
                workspace:Raycast(
                    origin,
                    Vector3.new(
                        0,
                        -90,
                        0
                    ),
                    params
                )

            if result then
                return
                    result.Position,
                    GetRoomSize1(room)
            end

            return
                target,
                GetRoomSize1(room)
        end

        if room:IsA("Model") then
            local cf, size =
                room:GetBoundingBox()

            local params =
                RaycastParams.new()

            params.FilterType =
                Enum.RaycastFilterType.Include

            params.FilterDescendantsInstances = {
                room
            }

            params.IgnoreWater =
                true

            local origin =
                cf.Position
                + Vector3.new(
                    0,
                    size.Y * 0.5 + 10,
                    0
                )

            local result =
                workspace:Raycast(
                    origin,
                    Vector3.new(
                        0,
                        -(size.Y + 30),
                        0
                    ),
                    params
                )

            if result then
                return
                    result.Position,
                    size
            end

            return
                Vector3.new(
                    cf.Position.X,
                    cf.Position.Y
                    - size.Y * 0.5,
                    cf.Position.Z
                ),
                size
        end

        if room:IsA("BasePart") then
            return
                room.Position
                - Vector3.new(
                    0,
                    room.Size.Y * 0.5,
                    0
                ),
                room.Size
        end

        return
            Vector3.zero,
            Vector3.new(
                30,
                20,
                30
            )
    end

    local function PivotSilence1(position)
        Silence:PivotTo(
            CFrame.new(position)
            * modelRotation
        )
    end

    local function MoveVertical1(
        startPosition,
        endPosition,
        duration,
        descending
    )
        local started =
            CeaseTime1()

        while true do
            if jumpscareFinished then
                return false
            end

            local alpha =
                math.clamp(
                    (CeaseTime1() - started)
                    / duration,
                    0,
                    1
                )

            local eased

            if descending then
                eased =
                    1
                    - ((1 - alpha) ^ 4)
            else
                eased =
                    alpha ^ 4
            end

            PivotSilence1(
                startPosition:Lerp(
                    endPosition,
                    eased
                )
            )

            if alpha >= 1 then
                break
            end

            RunService.RenderStepped:Wait()
        end

        PivotSilence1(
            endPosition
        )

        return true
    end

    local MAX_SILENCE_ROOMS = 10

    local startRoomIndex = 1

    if #rooms > MAX_SILENCE_ROOMS then
        startRoomIndex = #rooms - 8
    end

    for roomIndex = startRoomIndex, #rooms do

        local data = rooms[roomIndex]
        if jumpscareFinished then
            break
        end

        while ceaseFreezeActive and not jumpscareFinished do
            RunService.Heartbeat:Wait()
        end

        if jumpscareFinished then
            break
        end

        local floorPosition,
            roomSize =
            FindFloor1(
                data.Room
            )

        local landingPosition =
            floorPosition
            + Vector3.new(
                0,
                bottomOffset
                + MODEL_Y_OFFSET,
                0
            )

        local spawnHeight =
            math.max(
                roomSize.Y + 35,
                45
            )

        local upperPosition =
            landingPosition
            + Vector3.new(
                0,
                spawnHeight,
                0
            )

        PivotSilence1(
            upperPosition
        )

        StartRoomAudio1(
            landingPosition,
            5.2
        )

        local moved =
            MoveVertical1(
                upperPosition,
                landingPosition,
                0.52,
                true
            )

        if not moved then
            break
        end

        local holdStarted =
            CeaseTime1()

        while
            CeaseTime1()
            - holdStarted
            < 4
        do
            if jumpscareFinished then
                break
            end

            RunService.Heartbeat:Wait()
        end

        if jumpscareFinished then
            break
        end

        moved =
            MoveVertical1(
                landingPosition,
                upperPosition,
                0.42,
                false
            )

        if not moved then
            break
        end
    end

    while ceaseFreezeActive and not jumpscareFinished do
        RunService.Heartbeat:Wait()
    end

    audioToken += 1

    StopSoundWatcher1()
    CeaseStop1()

    ResetSound1(
        SilenceFarSound
    )

    if Silence and Silence.Parent then
        Silence:Destroy()
end
            end
        end)

        -- Rebound cannot start or remain active in the Figure library or a Seek chase.
        local function isReboundProtectedArea()
            local workspaceService = game:GetService("Workspace")
            local storage = game:GetService("ReplicatedStorage")
            local rooms = workspaceService:FindFirstChild("CurrentRooms")
            local data = storage:FindFirstChild("GameData")
            local latest = data and data:FindFirstChild("LatestRoom")
            local number = latest and tonumber(latest.Value)

            if number == 50 then
                return true
            end
            -- Room 50 can be preloaded at door 49; don't permanently disable
            -- Rebound just because old room 50 still exists after leaving it.
            if rooms and rooms:FindFirstChild("50") and number and number >= 49 and number <= 50 then
                return true
            end
            if workspaceService:FindFirstChild("SeekMovingNewClone")
                or workspaceService:FindFirstChild("SeekMov") then
                return true
            end
            if vu31 and vu31.MainGame and vu31.MainGame.chase then
                return true
            end
            return false
        end

        task.spawn(function()
            while task.wait(335) do
                -- Skip only this cycle when the event would occur in Seek/room 50.
                if isReboundProtectedArea() then
                    continue
                end
                game.ReplicatedStorage.GameData.LatestRoom:GetPropertyChangedSignal("Value"):Wait()
                if isReboundProtectedArea() then
                    continue
                end
local RunService = game:GetService("RunService")
    local ceaseHandledModels = setmetatable({}, { __mode = "k" })

    local testModelId = 126219950276870
    local reboundTemplate = nil
    local CameraShaker = require(game.ReplicatedStorage.CameraShaker)

    if _G.__ReboundMainCameraShake then
        pcall(function()
            _G.__ReboundMainCameraShake:Stop()
        end)
        _G.__ReboundMainCameraShake = nil
    end

    local reboundCameraShake = CameraShaker.new(
        Enum.RenderPriority.Camera.Value + 30,
        function(shakeCFrame)
            local activeCamera = workspace.CurrentCamera
            if activeCamera then
                activeCamera.CFrame = activeCamera.CFrame * shakeCFrame
            end
        end
    )
    reboundCameraShake:Start()
    _G.__ReboundMainCameraShake = reboundCameraShake

    local reboundCameraShakeStopped = false
    local function stopReboundCameraShake()
        if reboundCameraShakeStopped then
            return
        end
        reboundCameraShakeStopped = true
        pcall(function()
            reboundCameraShake:Stop()
        end)
        if _G.__ReboundMainCameraShake == reboundCameraShake then
            _G.__ReboundMainCameraShake = nil
        end
    end

    local function PlayPreloadedSound(soundName, volume)
        volume = volume or 1
        local soundFolder = workspace:FindFirstChild("HardCoreSound")
        if not soundFolder then
            return nil
        end

        local sound = soundFolder:FindFirstChild(soundName)
        if sound and sound:IsA("Sound") then
            sound.Volume = volume
            sound:Play()
            return sound
        end

        return nil
    end

    local function GetMaxExistingRoom()
        local rooms = workspace.CurrentRooms:GetChildren()
        local maxNum = 0
        for _, room in ipairs(rooms) do
            local num = tonumber(room.Name)
            if num and num > maxNum then
                maxNum = num
            end
        end
        return maxNum
    end

    local Players = game:GetService("Players")
    local reboundSealed = false
    local doorSignal = nil
    local movingSoundForWave = nil
    local sweepSoundForEvent = nil
    local reboundMarkerPart = nil
    local reboundPhaseRunning = true

    local function cancelReboundForProtectedArea()
        if not reboundPhaseRunning or reboundSealed then
            return
        end
        reboundSealed = true
        if movingSoundForWave and movingSoundForWave.Parent then
            movingSoundForWave:Stop()
        end
        if sweepSoundForEvent and sweepSoundForEvent.Parent then
            sweepSoundForEvent:Stop()
        end
        if reboundMarkerPart and reboundMarkerPart.Parent then
            reboundMarkerPart:Destroy()
        end
        for _, object in ipairs(workspace:GetChildren()) do
            if object.Name == "Rebound" then
                object:Destroy()
            end
        end
        if doorSignal then
            doorSignal:Fire() -- Release a pending door wait without creating a new wave.
        end
        stopReboundCameraShake()
    end

    task.spawn(function()
        while reboundPhaseRunning and not reboundSealed do
            if isReboundProtectedArea() then
                cancelReboundForProtectedArea()
                break
            end
            task.wait(0.1)
        end
    end)

    local function easeCrucifix(alpha)
        alpha = math.clamp(alpha, 0, 1)
        return alpha * alpha * (3 - 2 * alpha)
    end

    local function getCrucifixTool(character)
        if not character or not character:IsA("Model") then
            return nil
        end

        local directTool = character:FindFirstChild("Crucifix")
        if directTool and directTool:IsA("Tool") then
            return directTool
        end

        for _, descendant in ipairs(character:GetDescendants()) do
            if descendant.Name == "Crucifix" and descendant:IsA("Tool") then
                return descendant
            end
        end

        return nil
    end

    local function getCharacterFromRaycastHit(hitInstance)
        local current = hitInstance

        while current and current ~= workspace do
            if current:IsA("Model") and Players:GetPlayerFromCharacter(current) then
                return current
            end

            current = current.Parent
        end

        return nil
    end

    local function rayEntryDistanceToPart(origin, directionUnit, part)
        if not part or not part.Parent or not part:IsA("BasePart") then
            return nil
        end

        local localOrigin = part.CFrame:PointToObjectSpace(origin)
        local localDirection = part.CFrame:VectorToObjectSpace(directionUnit)
        local half = part.Size * 0.5
        local entry, exit = 0, math.huge

        for _, axis in ipairs({ "X", "Y", "Z" }) do
            local position = localOrigin[axis]
            local velocity = localDirection[axis]
            local extent = half[axis]
            if math.abs(velocity) < 0.00001 then
                if position < -extent or position > extent then
                    return nil
                end
            else
                local near = (-extent - position) / velocity
                local far = (extent - position) / velocity
                if near > far then
                    near, far = far, near
                end
                entry = math.max(entry, near)
                exit = math.min(exit, far)
                if exit < entry then
                    return nil
                end
            end
        end

        return entry
    end

    local function getCrucifixVisualStates(root, shouldInclude, onlyRoot)
        local states = {}

        local function capture(object)
            if shouldInclude and not shouldInclude(object) then
                return
            end

            if object:IsA("BasePart") or object:IsA("Decal")
                or object:IsA("Texture") then
                table.insert(states, {
                    Object = object,
                    Kind = "Transparency",
                    Original = object.Transparency
                })
            elseif object:IsA("ParticleEmitter") or object:IsA("Beam")
                or object:IsA("Trail") then
                table.insert(states, {
                    Object = object,
                    Kind = "Sequence",
                    Original = object.Transparency
                })
            elseif object:IsA("Light") then
                table.insert(states, {
                    Object = object,
                    Kind = "Brightness",
                    Original = object.Brightness
                })
            elseif object:IsA("Highlight") then
                table.insert(states, {
                    Object = object,
                    Kind = "Highlight",
                    Fill = object.FillTransparency,
                    Outline = object.OutlineTransparency
                })
            elseif object:IsA("Smoke") then
                table.insert(states, {
                    Object = object,
                    Kind = "Smoke",
                    Original = object.Opacity
                })
            elseif object:IsA("Fire") then
                table.insert(states, {
                    Object = object,
                    Kind = "Fire",
                    Size = object.Size,
                    Heat = object.Heat
                })
            elseif object:IsA("Sound") then
                table.insert(states, {
                    Object = object,
                    Kind = "Sound",
                    Original = object.Volume
                })
            elseif object:IsA("GuiObject") then
                local state = {
                    Object = object,
                    Kind = "GuiObject",
                    Background = object.BackgroundTransparency
                }

                if object:IsA("ImageLabel") or object:IsA("ImageButton") then
                    state.Image = object.ImageTransparency
                end

                if object:IsA("TextLabel") or object:IsA("TextButton")
                    or object:IsA("TextBox") then
                    state.Text = object.TextTransparency
                end

                table.insert(states, state)
            end
        end

        capture(root)
        if not onlyRoot then
            for _, descendant in ipairs(root:GetDescendants()) do
                capture(descendant)
            end
        end

        return states
    end

    local function crucifixFadedSequence(original, factor)
        local keypoints = {}

        for _, keypoint in ipairs(original.Keypoints) do
            local nextTransparency = 1 - (1 - keypoint.Value) * factor
            table.insert(keypoints, NumberSequenceKeypoint.new(
                keypoint.Time,
                math.clamp(nextTransparency, 0, 1),
                keypoint.Envelope * factor
            ))
        end

        return NumberSequence.new(keypoints)
    end

    local function setCrucifixVisualFactor(states, factor)
        factor = math.clamp(factor, 0, 1)

        for _, state in ipairs(states) do
            local object = state.Object

            if object and object.Parent then
                if state.Kind == "Transparency" then
                    object.Transparency = 1 - (1 - state.Original) * factor
                elseif state.Kind == "Sequence" then
                    object.Transparency = crucifixFadedSequence(state.Original, factor)
                elseif state.Kind == "Brightness" then
                    object.Brightness = state.Original * factor
                elseif state.Kind == "Highlight" then
                    object.FillTransparency = 1 - (1 - state.Fill) * factor
                    object.OutlineTransparency = 1 - (1 - state.Outline) * factor
                elseif state.Kind == "Smoke" then
                    object.Opacity = state.Original * factor
                elseif state.Kind == "Fire" then
                    object.Size = state.Size * factor
                    object.Heat = state.Heat * factor
                elseif state.Kind == "Sound" then
                    object.Volume = state.Original * factor
                elseif state.Kind == "GuiObject" then
                    object.BackgroundTransparency = 1 - (1 - state.Background) * factor

                    if state.Image ~= nil then
                        object.ImageTransparency = 1 - (1 - state.Image) * factor
                    end

                    if state.Text ~= nil then
                        object.TextTransparency = 1 - (1 - state.Text) * factor
                    end
                end
            end
        end
    end

    local function fadeCrucifixVisuals(states, initialFactor, endFactor, duration)
        if duration <= 0 then
            setCrucifixVisualFactor(states, endFactor)
            return
        end

        local startTime = os.clock()

        while true do
            local alpha = math.clamp((os.clock() - startTime) / duration, 0, 1)
            local eased = easeCrucifix(alpha)
            setCrucifixVisualFactor(
                states,
                initialFactor + (endFactor - initialFactor) * eased
            )

            if alpha >= 1 then
                break
            end

            RunService.Heartbeat:Wait()
        end
    end

    local function findCrucifixBeams(rushNew)
        local preferred = {}
        local fallback = {}

        for _, descendant in ipairs(rushNew:GetDescendants()) do
            if descendant:IsA("Beam") then
                table.insert(fallback, descendant)

                local ancestor = descendant.Parent
                while ancestor and ancestor ~= rushNew do
                    if string.lower(ancestor.Name) == "particlesin" then
                        table.insert(preferred, descendant)
                        break
                    end
                    ancestor = ancestor.Parent
                end

                if string.lower(descendant.Name) == "particlesin" then
                    local exists = false
                    for _, selected in ipairs(preferred) do
                        if selected == descendant then
                            exists = true
                            break
                        end
                    end
                    if not exists then
                        table.insert(preferred, descendant)
                    end
                end
            end
        end

        local beams = #preferred > 0 and preferred or fallback
        table.sort(beams, function(a, b)
            return a:GetFullName() < b:GetFullName()
        end)

        return beams
    end

    local function prepareCrucifixBeams(beams, rushNew, movingAttachment)
        for index, beam in ipairs(beams) do
            if beam.Parent then
                if not beam.Attachment0 then
                    beam.Attachment0 = movingAttachment
                end

                if not beam.Attachment1 or beam.Attachment1 == beam.Attachment0 then
                    local endpoint = Instance.new("Attachment")
                    endpoint.Name = "CrucifixBeamEndpoint" .. tostring(index)
                    local angle = (index - 1) * (math.pi / 2)
                    local offset = Vector3.new(
                        math.cos(angle) * 3,
                        2,
                        math.sin(angle) * 3
                    )
                    endpoint.Position = movingAttachment.Position
                        + rushNew.CFrame:VectorToObjectSpace(offset)
                    endpoint.Parent = rushNew
                    beam.Attachment1 = endpoint
                end

                if beam.Width0 <= 0 and beam.Width1 <= 0 then
                    beam.Width0 = 0.3
                    beam.Width1 = 0.3
                end

                beam.Enabled = true
                beam.Transparency = NumberSequence.new(1)
            end
        end
    end

    local crucifixBeamSoundIds = {
        "124444290902740",
        "100133789671771",
        "133850299035625",
        "120232105146350"
    }

    local function createCrucifixBeamFeedback()
        local beamCameraShaker = nil
        local shakeCleanupScheduled = false

        local function trigger(index)
            local soundId = crucifixBeamSoundIds[index]
            if not soundId then
                return
            end

            local sound = Instance.new("Sound")
            sound.Name = "CrucifixBeamSound" .. tostring(index)
            sound.SoundId = "rbxassetid://" .. soundId
            sound.Volume = 7
            sound.Looped = false
            sound.Parent = game:GetService("SoundService")
            sound.Ended:Connect(function()
                if sound.Parent then
                    sound:Destroy()
                end
            end)
            task.delay(60, function()
                if sound.Parent then
                    sound:Destroy()
                end
            end)
            sound:Play()

            if not beamCameraShaker then
                local module = game.ReplicatedStorage:FindFirstChild("CameraShaker")
                if module then
                    local loaded, CameraShaker = pcall(require, module)
                    if loaded and CameraShaker then
                        local created, shaker = pcall(function()
                            local currentShaker = CameraShaker.new(
                                Enum.RenderPriority.Camera.Value,
                                function(shakeCf)
                                    local camera = workspace.CurrentCamera
                                    if camera then
                                        camera.CFrame = camera.CFrame * shakeCf
                                    end
                                end
                            )
                            currentShaker:Start()
                            return currentShaker
                        end)
                        if created then
                            beamCameraShaker = shaker
                        end
                    end
                end
            end

            if beamCameraShaker then
                local started, shakeInstance = pcall(function()
                    return beamCameraShaker:StartShake(10, 28, 0.1, 0.25, 0.35)
                end)
                if started and shakeInstance then
                    task.delay(0.3, function()
                        pcall(function()
                            shakeInstance:StartFadeOut(3)
                        end)
                    end)
                else
                    pcall(function()
                        beamCameraShaker:ShakeOnce(10, 28, 0.1, 3, 0.25, 0.35)
                    end)
                end

                if not shakeCleanupScheduled then
                    shakeCleanupScheduled = true
                    task.delay(4.5, function()
                        if beamCameraShaker then
                            pcall(function()
                                beamCameraShaker:Stop()
                            end)
                        end
                    end)
                end
            end
        end

        return trigger
    end

    local function revealCrucifixBeams(beams, onBeamBegin)
        local startTime = os.clock()
        local perBeamDuration = 0.5
        local staggerDelay = 0.25
        local totalDuration = perBeamDuration + math.max(0, #beams - 1) * staggerDelay
        local begun = {}

        while true do
            local elapsed = os.clock() - startTime

            for index, beam in ipairs(beams) do
                if beam and beam.Parent then
                    local beamStartTime = (index - 1) * staggerDelay
                    if elapsed >= beamStartTime and not begun[index] then
                        begun[index] = true
                        if onBeamBegin then
                            onBeamBegin(index)
                        end
                    end

                    local beamAlpha = math.clamp(
                        (elapsed - beamStartTime) / perBeamDuration,
                        0,
                        1
                    )
                    beam.Enabled = true
                    beam.Transparency = NumberSequence.new(1 - easeCrucifix(beamAlpha))
                end
            end

            if elapsed >= totalDuration then
                break
            end
            RunService.Heartbeat:Wait()
        end

        for _, beam in ipairs(beams) do
            if beam and beam.Parent then
                beam.Enabled = true
                beam.Transparency = NumberSequence.new(0)
            end
        end
    end

    local function fadeCrucifixBeamsOut(beams, duration)
        local startTime = os.clock()

        while true do
            local alpha = math.clamp((os.clock() - startTime) / duration, 0, 1)
            local transparency = easeCrucifix(alpha)

            for _, beam in ipairs(beams) do
                if beam and beam.Parent then
                    beam.Transparency = NumberSequence.new(transparency)
                end
            end

            if alpha >= 1 then
                break
            end
            RunService.Heartbeat:Wait()
        end

        for _, beam in ipairs(beams) do
            if beam and beam.Parent then
                beam.Transparency = NumberSequence.new(1)
                beam.Enabled = false
            end
        end
    end

    local function moveCrucifixAttachment(attachment, targetPosition, duration)
        local origin = attachment.Position
        local startTime = os.clock()

        while true do
            if not attachment.Parent then
                return false
            end

            local alpha = math.clamp((os.clock() - startTime) / duration, 0, 1)
            local progress = easeCrucifix(alpha)
            attachment.Position = origin:Lerp(targetPosition, progress)

            if alpha >= 1 then
                attachment.Position = targetPosition
                return true
            end
            RunService.Heartbeat:Wait()
        end
    end

    local function fadeCrucifixDescendantsRecursively(root, duration)
        local found = {}
        local allStates = {}
        local stateCount = 0

        local function findChildren(object)
            if not object or found[object] then
                return
            end
            found[object] = true

            local states = getCrucifixVisualStates(object, nil, true)
            for _, state in ipairs(states) do
                table.insert(allStates, state)
                stateCount = stateCount + 1
            end

            for _, child in ipairs(object:GetChildren()) do
                findChildren(child)
            end
        end

        local startTime = os.clock()
        while true do
            if not root.Parent then
                return
            end

            findChildren(root)
            local alpha = math.clamp((os.clock() - startTime) / duration, 0, 1)
            setCrucifixVisualFactor(allStates, 1 - easeCrucifix(alpha))

            if alpha >= 1 then
                break
            end

            for _, object in ipairs(root:GetDescendants()) do
                if not found[object] then
                    findChildren(object)
                end
            end
            RunService.Heartbeat:Wait()
        end
    end

    local function startCrucifixAmbientShake(replacement)
        local stepName = "ReboundCrucifixAmbient_"
            .. game:GetService("HttpService"):GenerateGUID(false)
        local startedAt = os.clock()
        local active = true
        local lastOffset = CFrame.new()
        local lastCamera = nil

        local function stop()
            if not active then
                return
            end
            active = false
            RunService:UnbindFromRenderStep(stepName)
        end

        RunService:BindToRenderStep(
            stepName,
            Enum.RenderPriority.Camera.Value + 3,
            function()
                if not replacement.Parent then
                    stop()
                    return
                end

                local camera = workspace.CurrentCamera
                if not camera then
                    return
                end

                if lastCamera ~= camera then
                    lastCamera = camera
                    lastOffset = CFrame.new()
                end

                local elapsed = os.clock() - startedAt
                local strength = easeCrucifix(math.clamp(elapsed / 0.5, 0, 1))
                local offset = CFrame.new(
                    math.sin(elapsed * 13) * 0.055 * strength,
                    math.sin(elapsed * 16 + 0.7) * 0.04 * strength,
                    0
                ) * CFrame.Angles(
                    math.sin(elapsed * 12) * math.rad(0.085) * strength,
                    math.sin(elapsed * 10 + 1.1) * math.rad(0.065) * strength,
                    0
                )

                camera.CFrame = camera.CFrame * lastOffset:Inverse() * offset
                lastOffset = offset
            end
        )

        return stop
    end

    local function runCrucifixReplacement(originalCFrame)

        local loadedSuccessfully, replacement = pcall(function()
            return game:GetObjects("rbxassetid://86848040233512")[1]
        end)

        if not loadedSuccessfully or not replacement then

            return
        end

        local targetCFrame = originalCFrame + Vector3.new(0, 0, 0)
        local bro = replacement.Name == "BRO" and replacement
            or replacement:FindFirstChild("BRO", true)

        local placed, placementError = pcall(function()
            if replacement:IsA("Model") then
                if bro and bro:IsA("Model") then
                    local pivotShift = targetCFrame * bro:GetPivot():Inverse()
                    replacement:PivotTo(pivotShift * replacement:GetPivot())
                else
                    replacement:PivotTo(targetCFrame)
                end
            elseif bro and bro:IsA("Model") then
                bro:PivotTo(targetCFrame)
            elseif replacement:IsA("BasePart") then
                replacement.CFrame = targetCFrame
            end

            for _, descendant in ipairs(replacement:GetDescendants()) do
                if descendant:IsA("BasePart") then
                    descendant.Anchored = true
                    descendant.CanCollide = false
                    descendant.CanTouch = false
                end
            end

            if replacement:IsA("BasePart") then
                replacement.Anchored = true
                replacement.CanCollide = false
                replacement.CanTouch = false
            end

            replacement.Parent = workspace
        end)

        if not placed then

            replacement:Destroy()
            return
        end

        local stopAmbientShake = startCrucifixAmbientShake(replacement)
        task.delay(30, function()
            stopAmbientShake()
            if replacement and replacement.Parent then
                replacement:Destroy()
            end
        end)

        local animationOK, animationError = xpcall(function()
            local rushNew = (bro and bro:FindFirstChild("RushNew", true))
                or replacement:FindFirstChild("RushNew", true)
            if replacement.Name == "RushNew" and replacement:IsA("BasePart") then
                rushNew = replacement
            end
            local attachment = rushNew and rushNew:FindFirstChild("Attachment", true)
            if attachment and not attachment:IsA("Attachment") then
                attachment = nil
            end
            if not rushNew then

            elseif not attachment then

            else

            end

            task.wait(2.3)
            if not replacement.Parent then
                return
            end

            if rushNew and rushNew:IsA("BasePart") and attachment then
                local beams = findCrucifixBeams(rushNew)
                local introStates = getCrucifixVisualStates(attachment, function(object)
                    if not object:IsA("Beam") then
                        return true
                    end
                    for _, beam in ipairs(beams) do
                        if object == beam then
                            return false
                        end
                    end
                    return true
                end)

                setCrucifixVisualFactor(introStates, 0)
                prepareCrucifixBeams(beams, rushNew, attachment)

                local originalPosition = attachment.Position
                local upOffset = rushNew.CFrame:VectorToObjectSpace(Vector3.new(0, 3, 0))
                local downOffset = rushNew.CFrame:VectorToObjectSpace(Vector3.new(0, -20, 0))
                local upPosition = originalPosition + upOffset
                local downPosition = upPosition + downOffset

                task.spawn(function()
                    if attachment.Parent then
                        fadeCrucifixVisuals(introStates, 0, 1, 0.6)
                    end
                end)

                local beamsRevealFinished = #beams == 0
                if not beamsRevealFinished then
                    local playBeamFeedback = createCrucifixBeamFeedback()
                    task.spawn(function()
                        task.wait(0.8)
                        if replacement.Parent and attachment.Parent then
                            pcall(revealCrucifixBeams, beams, playBeamFeedback)
                        end
                        beamsRevealFinished = true
                    end)
                end

                if not moveCrucifixAttachment(attachment, upPosition, 1.8) then
                    return
                end

                while not beamsRevealFinished and replacement.Parent and attachment.Parent do
                    RunService.Heartbeat:Wait()
                end

                if not moveCrucifixAttachment(attachment, downPosition, 1.2) then
                    return
                end
                task.wait(2)
                fadeCrucifixBeamsOut(beams, 0.5)
            end
        end, function(err)
            return tostring(err) .. "\n" .. debug.traceback()
        end)

        if not animationOK then

        end
        local fadeOK, fadeError = pcall(function()
            fadeCrucifixDescendantsRecursively(replacement, 1)
        end)
        if not fadeOK then

        end
        if replacement.Parent then
            for _, descendant in ipairs(replacement:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam")
                    or descendant:IsA("Trail") or descendant:IsA("Sparkles")
                    or descendant:IsA("Smoke") or descendant:IsA("Fire") then
                    pcall(function()
                        descendant.Enabled = false
                    end)
                end
            end
        end
        task.wait(3)
        stopAmbientShake()
        if replacement then

            replacement:Destroy()
        end
    end


    function SpawnReboundEntity(startRoomType)
        if isReboundProtectedArea() then
            cancelReboundForProtectedArea()
        end
        if isReboundProtectedArea() then
            cancelReboundForProtectedArea()
        end
        if reboundSealed then
            return false
        end
        if not reboundTemplate then
            for attempt = 1, 6 do
                if reboundSealed then
                    return false
                end
                local success, loaded = pcall(function()
                    return game:GetObjects("rbxassetid://" .. testModelId)[1]
                end)
                if success and loaded then
                    reboundTemplate = loaded
                    break
                end
                if attempt < 6 then
                    task.wait(0.4)
                end
            end
        end

        if isReboundProtectedArea() then
            cancelReboundForProtectedArea()
        end
        if reboundSealed then
            return false
        end
        if not reboundTemplate then

            return false
        end

        local testEntity = reboundTemplate:Clone()
        if reboundSealed then
            if testEntity then
                testEntity:Destroy()
            end
            return false
        end
        if not testEntity then
            return false
        end
        for _, obj in ipairs(workspace:GetChildren()) do
            if obj.Name == "Rebound" then
                pcall(function()
                    obj:Destroy()
                end)
            end
        end
        if isReboundProtectedArea() or reboundSealed then
            testEntity:Destroy()
            cancelReboundForProtectedArea()
            return false
        end
        testEntity.Name = "Rebound"
        testEntity.Parent = workspace

        local primaryPart
        if testEntity:IsA("Model") then
            primaryPart = testEntity.PrimaryPart or testEntity:FindFirstChildWhichIsA("BasePart", true)
        elseif testEntity:IsA("BasePart") then
            primaryPart = testEntity
        end
        if not primaryPart then
            testEntity:Destroy()
            return false
        end

        primaryPart.Anchored = true
        primaryPart.CanCollide = false

        task.spawn(function()
            if reboundSealed or not primaryPart.Parent then
                return
            end
            local targetRoom
            if startRoomType == "start" then
                targetRoom = workspace.CurrentRooms:FindFirstChild("0")
            else
                local maxRoom = GetMaxExistingRoom()
                targetRoom = workspace.CurrentRooms:FindFirstChild(tostring(maxRoom))
            end

            if targetRoom then
                local targetPart
                if targetRoom:FindFirstChild("Nodes") then
                    targetPart = targetRoom:FindFirstChild("RoomEntrance")
                        or targetRoom:FindFirstChild("RoomExit")
                else
                    targetPart = targetRoom:FindFirstChild("RoomExit")
                        or targetRoom:FindFirstChild("RoomEntrance")
                end
                if not reboundSealed and primaryPart.Parent
                    and targetPart and targetPart:IsA("BasePart") then
                    primaryPart.CFrame = targetPart.CFrame + Vector3.new(0, 1, 0)
                end
            end

            task.wait(2)
            if isReboundProtectedArea() then
                cancelReboundForProtectedArea()
            end
            if not reboundSealed and primaryPart.Parent then
                StartEntityLogic(primaryPart, startRoomType)
            end
        end)
        return true
    end

    function StartEntityLogic(primaryPart, startRoomType)
        if reboundSealed or not primaryPart or not primaryPart.Parent then
            return
        end

        local lastProximityShake = 0
        task.spawn(function()
            local RunService = game:GetService("RunService")
            local player = game.Players.LocalPlayer

            while not reboundSealed and primaryPart and primaryPart.Parent do
                RunService.RenderStepped:Wait()
                if reboundSealed or not primaryPart or not primaryPart.Parent then
                    break
                end

                local character = player and player.Character
                local humanoid = character and character:FindFirstChildWhichIsA("Humanoid")
                local rootPart = character and character:FindFirstChild("HumanoidRootPart")

                if humanoid and rootPart and humanoid.Health > 0 then
                    local distance = (primaryPart.Position - rootPart.Position).Magnitude

                    if distance <= 80 and os.clock() - lastProximityShake >= 0.12 then
                        local alpha = math.clamp(1 - distance / 80, 0, 1)
                        local amplitude = (0.3 + 8.2 * (alpha ^ 1.35)) * 3
                        local roughness = (45 + 35 * alpha) * 0.25
                        local positionInfluence = 0.35 + 0.4 * alpha
                        local rotationInfluence = 0.3 + 0.4 * alpha

                        reboundCameraShake:ShakeOnce(
                            amplitude,
                            roughness,
                            0.01,
                            0.16,
                            positionInfluence,
                            rotationInfluence
                        )

                        lastProximityShake = os.clock()
                    end
                end
            end

        end)

        local v305 = 1.4
        local v306 = 0.4
        local v307 = Vector3.new(0, 1, 0)
        local v310 = workspace.CurrentRooms

        local detectedPlayer = false
        local ceaseSpeedScale = 1
        local ceaseFreezeActive = false
        local ceaseFreezeToken = 0
        local ceaseStoredEffects = {}
        local ceaseDescendantConnection = nil
        local ceaseSoundConnection = nil
        local reboundMoving = false
        local activeMovementTween = nil
        local activeMovementTarget = nil
        local activeMovementOrigin = nil
        local ceaseStopMotionTween = nil
        local ceaseResumeMotionTween = nil
        local reboundMovementEnded = false
        local reboundModel = primaryPart:FindFirstAncestor("Rebound")
        if not reboundModel and primaryPart.Name == "Rebound" then
            reboundModel = primaryPart
        end

        local function easeCease(alpha)
            alpha = math.clamp(alpha, 0, 1)
            return alpha * alpha * (3 - 2 * alpha)
        end

        local function applyCeaseScale(scale)
            ceaseSpeedScale = math.clamp(scale, 0, 1)
            for obj, state in pairs(ceaseStoredEffects) do
                if obj.Parent then
                    if state.IsParticle then
                        pcall(function()
                            obj.TimeScale = state.TimeScale * ceaseSpeedScale
                        end)
                    else
                        pcall(function()
                            obj.PlaybackSpeed = state.PlaybackSpeed * ceaseSpeedScale
                        end)
                        pcall(function()
                            obj.Volume = state.Volume * ceaseSpeedScale
                        end)
                        if ceaseSpeedScale <= 0 then
                            if not state.PausedByCease and obj.IsPlaying then
                                pcall(function()
                                    obj:Pause()
                                    state.PausedByCease = true
                                end)
                            end
                        elseif state.PausedByCease then
                            pcall(function()
                                obj:Resume()
                                state.PausedByCease = false
                            end)
                        end
                    end
                end
            end
        end

        local function trackCeaseEffect(obj)
            if ceaseStoredEffects[obj] then
                return
            end
            if obj:IsA("ParticleEmitter") then
                ceaseStoredEffects[obj] = {
                    IsParticle = true,
                    TimeScale = obj.TimeScale
                }
            elseif obj:IsA("Sound") then
                ceaseStoredEffects[obj] = {
                    IsParticle = false,
                    PlaybackSpeed = obj.PlaybackSpeed,
                    Volume = obj.Volume,
                    PausedByCease = false
                }
            else
                return
            end

            if ceaseFreezeActive then
                local state = ceaseStoredEffects[obj]
                if state.IsParticle then
                    pcall(function()
                        obj.TimeScale = state.TimeScale * ceaseSpeedScale
                    end)
                else
                    pcall(function()
                        obj.PlaybackSpeed = state.PlaybackSpeed * ceaseSpeedScale
                    end)
                    pcall(function()
                        obj.Volume = state.Volume * ceaseSpeedScale
                    end)
                end
            end
        end

        local function restoreCeaseEffects(resumeMovement)
            ceaseFreezeToken = ceaseFreezeToken + 1
            if ceaseStopMotionTween then
                ceaseStopMotionTween:Cancel()
                ceaseStopMotionTween = nil
            end
            if ceaseResumeMotionTween then
                ceaseResumeMotionTween:Cancel()
                ceaseResumeMotionTween = nil
            end
            if ceaseDescendantConnection then
                ceaseDescendantConnection:Disconnect()
                ceaseDescendantConnection = nil
            end
            if ceaseSoundConnection then
                ceaseSoundConnection:Disconnect()
                ceaseSoundConnection = nil
            end
            for obj, state in pairs(ceaseStoredEffects) do
                if obj.Parent then
                    if state.IsParticle then
                        pcall(function()
                            obj.TimeScale = state.TimeScale
                        end)
                    else
                        pcall(function()
                            obj.PlaybackSpeed = state.PlaybackSpeed
                        end)
                        pcall(function()
                            obj.Volume = state.Volume
                        end)
                        if state.PausedByCease then
                            pcall(function()
                                obj:Resume()
                            end)
                        end
                    end
                end
            end
            ceaseStoredEffects = {}
            ceaseSpeedScale = 1
            ceaseFreezeActive = false
            if resumeMovement and not detectedPlayer and primaryPart.Parent and activeMovementTarget then
                local remainingDistance = (activeMovementTarget.Position - primaryPart.Position).Magnitude
                local originalDistance = activeMovementOrigin
                    and (activeMovementTarget.Position - activeMovementOrigin.Position).Magnitude or 0
                local originalSpeed = originalDistance > 0 and originalDistance / v305 or 0
                if remainingDistance > 0.01 then
                    local remainingDuration = originalSpeed > 0
                        and math.max(remainingDistance / originalSpeed, 0.01) or v305
                    activeMovementTween = game.TweenService:Create(
                        primaryPart,
                        TweenInfo.new(remainingDuration, Enum.EasingStyle.Linear),
                        { CFrame = activeMovementTarget }
                    )
                    activeMovementTween:Play()
                end
            end
        end

        local function trySealRebound(character)
            if reboundSealed or not primaryPart.Parent
                or not character or character:GetAttribute("Hiding") then

                return false
            end
            local tool = getCrucifixTool(character)
            if not tool then

                return false
            end


            local sealCFrame = primaryPart.CFrame
            reboundSealed = true
            detectedPlayer = true
            reboundMovementEnded = true
            reboundMoving = false
            stopReboundCameraShake()

            if activeMovementTween then
                activeMovementTween:Cancel()
                activeMovementTween = nil
            end
            if ceaseFreezeActive then
                restoreCeaseEffects(false)
            end
            if movingSoundForWave and movingSoundForWave.Parent then
                movingSoundForWave:Stop()
            end

            tool:Destroy()
            if reboundModel and reboundModel.Parent then
                reboundModel:Destroy()
            elseif primaryPart.Parent then
                primaryPart:Destroy()
            end

            if doorSignal then
                doorSignal:Fire()
            end
            task.spawn(runCrucifixReplacement, sealCFrame)
            return true
        end

        local function triggerCeaseFreeze(ceaseModel)
            if ceaseFreezeActive or not reboundMoving or reboundMovementEnded
                or not primaryPart.Parent or ceaseHandledModels[ceaseModel]
                or not activeMovementTween
                or activeMovementTween.PlaybackState ~= Enum.PlaybackState.Playing then
                return
            end

            ceaseHandledModels[ceaseModel] = true
            ceaseFreezeActive = true
            ceaseFreezeToken = ceaseFreezeToken + 1
            local token = ceaseFreezeToken

            activeMovementTween:Cancel()
            activeMovementTween = nil
            local startCFrame = primaryPart.CFrame
            local destination = activeMovementTarget
            local remainingDistance = (destination.Position - startCFrame.Position).Magnitude
            local originalDistance = activeMovementOrigin
                and (destination.Position - activeMovementOrigin.Position).Magnitude or remainingDistance
            local initialSpeed = originalDistance / v305
            local stopDistance = math.min(remainingDistance, initialSpeed * 2.25 / 5)
            local stopFraction = remainingDistance > 0.001 and stopDistance / remainingDistance or 0
            local stoppingCFrame = startCFrame:Lerp(destination, math.clamp(stopFraction, 0, 1))
            ceaseStopMotionTween = game.TweenService:Create(
                primaryPart,
                TweenInfo.new(2.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                { CFrame = stoppingCFrame }
            )
            ceaseStopMotionTween:Play()

            if reboundModel then
                trackCeaseEffect(reboundModel)
                for _, obj in ipairs(reboundModel:GetDescendants()) do
                    trackCeaseEffect(obj)
                end
                ceaseDescendantConnection = reboundModel.DescendantAdded:Connect(function(obj)
                    if ceaseFreezeToken == token and ceaseFreezeActive then
                        trackCeaseEffect(obj)
                    end
                end)
            end

            local soundFolder = workspace:FindFirstChild("HardCoreSound")
            if soundFolder then
                for _, obj in ipairs(soundFolder:GetDescendants()) do
                    if obj:IsA("Sound") and obj.Name:lower():find("rebound", 1, true) then
                        trackCeaseEffect(obj)
                    end
                end
                ceaseSoundConnection = soundFolder.DescendantAdded:Connect(function(obj)
                    if ceaseFreezeToken == token and ceaseFreezeActive
                        and obj:IsA("Sound") and obj.Name:lower():find("rebound", 1, true) then
                        trackCeaseEffect(obj)
                    end
                end)
            end

            task.spawn(function()
                local function isValid()
                    return ceaseFreezeToken == token
                        and primaryPart.Parent ~= nil
                        and not reboundMovementEnded
                end

                local function transition(fromScale, toScale, duration)
                    local startedAt = os.clock()
                    while true do
                        if not isValid() then
                            if ceaseFreezeToken == token then
                                restoreCeaseEffects()
                            end
                            return false
                        end
                        local alpha = math.clamp((os.clock() - startedAt) / duration, 0, 1)
                        applyCeaseScale(fromScale + (toScale - fromScale) * easeCease(alpha))
                        if alpha >= 1 then
                            return true
                        end
                        RunService.Heartbeat:Wait()
                    end
                end

                if not transition(1, 0, 2.25) then
                    return
                end
                if ceaseStopMotionTween then
                    ceaseStopMotionTween:Cancel()
                    ceaseStopMotionTween = nil
                end
                local holdStartedAt = os.clock()
                while os.clock() - holdStartedAt < 13 do
                    if not isValid() then
                        if ceaseFreezeToken == token then
                            restoreCeaseEffects()
                        end
                        return
                    end
                    task.wait(0.05)
                end
                local remainingDistance = (destination.Position - primaryPart.Position).Magnitude
                local recoverDistance = math.min(remainingDistance, initialSpeed * 2 / 5)
                local recoverFraction = remainingDistance > 0.001
                    and recoverDistance / remainingDistance or 0
                local recoveringCFrame = primaryPart.CFrame:Lerp(
                    destination, math.clamp(recoverFraction, 0, 1)
                )
                ceaseResumeMotionTween = game.TweenService:Create(
                    primaryPart,
                    TweenInfo.new(2, Enum.EasingStyle.Quint, Enum.EasingDirection.In),
                    { CFrame = recoveringCFrame }
                )
                ceaseResumeMotionTween:Play()
                if not transition(0, 1, 2) then
                    return
                end
                if ceaseFreezeToken == token then
                    restoreCeaseEffects(true)
                end
            end)
        end

        task.spawn(function()
            while primaryPart.Parent and not reboundMovementEnded and not reboundSealed do
                if reboundMoving and not ceaseFreezeActive then
                    local ceaseModel = workspace:FindFirstChild("Cease", true)
                    if ceaseModel and ceaseModel:IsA("Model")
                        and not ceaseHandledModels[ceaseModel] then
                        triggerCeaseFreeze(ceaseModel)
                    end
                end
                task.wait(0.1)
            end
            if ceaseFreezeActive then
                restoreCeaseEffects()
            end
        end)

        local function startReboundTween(targetCFrame)
            if reboundSealed or not primaryPart.Parent then
                return false
            end
            activeMovementOrigin = primaryPart.CFrame
            activeMovementTarget = targetCFrame
            activeMovementTween = game.TweenService:Create(
                primaryPart,
                TweenInfo.new(v305),
                { CFrame = targetCFrame }
            )
            reboundMoving = true
            activeMovementTween:Play()
            return true
        end

        local function waitReboundStep(duration)
            local elapsed = 0
            while not reboundSealed and elapsed < duration and primaryPart.Parent do
                local dt = RunService.Heartbeat:Wait()
                if not ceaseFreezeActive then
                    elapsed = elapsed + dt
                end
            end
            while not reboundSealed and ceaseFreezeActive and primaryPart.Parent do
                RunService.Heartbeat:Wait()
            end
            return not reboundSealed and primaryPart.Parent ~= nil
        end

        local function waitForReboundArrival()
            local destination = activeMovementTarget
            if not destination then
                return false
            end
            while not reboundSealed and primaryPart.Parent do
                if not ceaseFreezeActive then
                    local remaining = (destination.Position - primaryPart.Position).Magnitude
                    if remaining <= 0.05 then
                        return true
                    end
                    local state = activeMovementTween and activeMovementTween.PlaybackState
                    if not activeMovementTween
                        or state == Enum.PlaybackState.Cancelled
                        or state == Enum.PlaybackState.Completed then
                        local fullDistance = activeMovementOrigin
                            and (destination.Position - activeMovementOrigin.Position).Magnitude or remaining
                        local segmentSpeed = fullDistance > 0 and fullDistance / v305 or 0
                        local duration = segmentSpeed > 0
                            and math.max(remaining / segmentSpeed, 0.01) or v305
                        activeMovementTween = game.TweenService:Create(
                            primaryPart,
                            TweenInfo.new(duration, Enum.EasingStyle.Linear),
                            { CFrame = destination }
                        )
                        activeMovementTween:Play()
                    end
                end
                RunService.Heartbeat:Wait()
            end
            return false
        end

        local function CheckLineOfSight(entityPart, player, maxDistance)
            if not entityPart or not player or not player.Character then
                return false
            end
            if player.Character:GetAttribute("Hiding") then
                return false
            end
            
            local hum = player.Character:FindFirstChildWhichIsA("Humanoid")
            if not hum or hum.Health <= 0 then
                return false
            end
            
            local origin = entityPart.Position
            local hrp = player.Character:FindFirstChild("HumanoidRootPart")
            if not hrp then return false end
            
            local targetPos = hrp.Position
            local distance = (targetPos - origin).Magnitude
            
            if distance <= 0.001 or distance > maxDistance then
                return false
            end
            local direction = (targetPos - origin).Unit * maxDistance
            local ray = Ray.new(origin, direction)
            local hitPart, _ = workspace:FindPartOnRay(ray, entityPart)
            
            return hitPart and hitPart:IsDescendantOf(player.Character)
        end

        local function CheckCrucifixRaycast(entityPart, player, maxDistance)
            if reboundSealed or not entityPart or not entityPart.Parent or not player then
                return nil
            end
            local character = player.Character
            if not character then

                return nil
            end
            if not character:IsDescendantOf(workspace) then

                return nil
            end
            if character:GetAttribute("Hiding") then

                return nil
            end

            local humanoid = character:FindFirstChildWhichIsA("Humanoid")
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if not humanoid or humanoid.Health <= 0 then

                return nil
            end
            if not rootPart or not rootPart:IsA("BasePart") then

                return nil
            end

            local raycastParams = RaycastParams.new()
            raycastParams.FilterType = Enum.RaycastFilterType.Exclude
            raycastParams.FilterDescendantsInstances = { reboundModel or entityPart }

            local targets = { rootPart }
            for _, partName in ipairs({ "Head", "UpperTorso", "Torso", "LowerTorso" }) do
                local part = character:FindFirstChild(partName)
                if part and part:IsA("BasePart") then
                    table.insert(targets, part)
                end
            end

            for _, part in ipairs(targets) do
                if reboundSealed or not entityPart.Parent then
                    return nil
                end
                local direction = part.Position - entityPart.Position
                local distance = direction.Magnitude
                if distance > 0.001 and distance <= maxDistance then
                    local result = workspace:Raycast(entityPart.Position, direction, raycastParams)
                    local hitPart = result and result.Instance
                    local hitCharacter = hitPart and getCharacterFromRaycastHit(hitPart) or nil

                    if not hitCharacter then
                        local partEntry = rayEntryDistanceToPart(
                            entityPart.Position, direction.Unit, part)
                        if partEntry and partEntry <= distance + 0.01 then
                            if not result or result.Distance > partEntry + 0.02 then
                                hitCharacter = character
                            end
                        end
                    end

                    if hitCharacter and not hitCharacter:GetAttribute("Hiding") then
                        local hitHumanoid = hitCharacter:FindFirstChildWhichIsA("Humanoid")
                        if hitHumanoid and hitHumanoid.Health > 0 then
                            local tool = getCrucifixTool(hitCharacter)
                            if tool then
                                return hitCharacter
                            end
                        end
                    end
                end
            end

            return nil
        end

        local function ExecutePlayer()
            if reboundSealed or detectedPlayer then return end
            detectedPlayer = true
            if ceaseFreezeActive then
                restoreCeaseEffects()
            end

            local vu321 = Instance.new("ScreenGui")
            local vu322 = Instance.new("ImageLabel")
            local v323 = Instance.new("ImageLabel")
            local v324 = Instance.new("ImageLabel")
            
            vu321.Name = "TestEntityJs"
            vu321.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
            
            vu322.Name = "Static"
            vu322.Parent = vu321
            vu322.BackgroundColor3 = Color3.fromRGB(0, 63, 139)
            vu322.BackgroundTransparency = 1
            vu322.BorderSizePixel = 0
            vu322.Size = UDim2.new(1, 0, 1, 0)
            vu322.Image = "rbxassetid://236543215"
            vu322.ImageColor3 = Color3.fromRGB(0, 255, 255)
            vu322.ImageTransparency = 1
            
            v323.Name = "TestEntity"
            v323.Parent = vu321
            v323.BackgroundTransparency = 1
            v323.Position = UDim2.new(0.486631036, 0, 0.479363143, 0)
            v323.Size = UDim2.new(0.0267379656, 0, 0.0387096703, 0)
            v323.Image = "rbxassetid://97823818277141"
            
            v324.Name = "JSSIZE"
            v324.Parent = vu321
            v324.BackgroundTransparency = 1
            v324.Position = UDim2.new(-0.586452842, 0, -1.25140607, 0)
            v324.Size = UDim2.new(2.12834215, 0, 3.08128953, 0)
            v324.Visible = false
            v324.Image = "rbxassetid://10914800940"

            local function v326()
                local v325 = Instance.new("LocalScript", vu322)
                while v325.Parent and v325.Parent.Parent do
                    v325.Parent.Image = "rbxassetid://236543215"
                    task.wait(0.015)
                    v325.Parent.Rotation = 0
                    task.wait(0.015)
                    v325.Parent.Rotation = 180
                    task.wait(0.015)
                    v325.Parent.Image = "rbxassetid://236777652"
                    task.wait(0.015)
                    v325.Parent.Rotation = 0
                    task.wait(0.015)
                    v325.Parent.Rotation = 180
                    task.wait(0.015)
                end
            end
            coroutine.wrap(v326)()

            local v327 = Instance.new("LocalScript", vu321)
            local vu328 = game.ReplicatedStorage
            local vu329 = game.Players.LocalPlayer
            local vu330 = v327.Parent
            local vu331 = vu330.Static
            local vu332 = vu330.TestEntity
            
            local killSound = Instance.new("Sound")
            killSound.SoundId = "rbxassetid://94785993416953"
            killSound.Parent = workspace
            killSound.Volume = 2

            (function()
                game.TweenService:Create(vu331, TweenInfo.new(0.5), {
                    BackgroundTransparency = 0,
                    ImageTransparency = 0.8
                }):Play()
                
                game.TweenService:Create(vu332, TweenInfo.new(0.5), {
                    Size = v324.Size,
                    Position = v324.Position
                }):Play()
                
                killSound:Play()
                
                spawn(function()
                    wait(0.3)
                    if reboundSealed then
                        return
                    end
                    local char = vu329.Character
                    if char then
                        local hum = char:FindFirstChildWhichIsA("Humanoid")
                        if hum and hum.Health > 0 then
                            local damage = 100
                            local willDie = hum.Health <= damage
                            if willDie then
                                local playerStats = vu328.GameStats:FindFirstChild("Player_" .. vu329.Name)
                                local total = playerStats and playerStats:FindFirstChild("Total")
                                local deathCause = total and total:FindFirstChild("DeathCause")
                                if deathCause then
                                    deathCause.Value = "Rebound"
                                end
                            end
                            hum:TakeDamage(damage)
                        end
                    end
                end)
                
                wait(0.5)
                game.TweenService:Create(vu331, TweenInfo.new(1), {
                    BackgroundTransparency = 1,
                    ImageTransparency = 1
                }):Play()
                game.TweenService:Create(vu332, TweenInfo.new(0.3), {
                    ImageTransparency = 1
                }):Play()
                wait(1)
                killSound:Destroy()
                vu330:Destroy()
            end)()
        end

        spawn(function()
            local player = Players.LocalPlayer

            while not reboundSealed and primaryPart and primaryPart.Parent do
                task.wait(0.05)
                if reboundSealed or not primaryPart or not primaryPart.Parent then
                    break
                end
                if isReboundProtectedArea() then
                    cancelReboundForProtectedArea()
                    break
                end

                for _, candidate in ipairs(Players:GetPlayers()) do
                    local hitCharacter = CheckCrucifixRaycast(primaryPart, candidate, 100)
                    if hitCharacter and getCrucifixTool(hitCharacter) then
                        if trySealRebound(hitCharacter) then
                            break
                        end
                    end
                end

                if reboundSealed then
                    break
                end
                if CheckLineOfSight(primaryPart, player, 100) then
                    ExecutePlayer()
                end
            end
        end)

        if startRoomType == "start" then
            local currentRoom = 0
            local maxRoom = game.ReplicatedStorage.GameData.LatestRoom.Value

            while currentRoom <= maxRoom and not reboundSealed and primaryPart.Parent do
                if isReboundProtectedArea() then
                    cancelReboundForProtectedArea()
                    break
                end

                local targetRoom = v310:FindFirstChild(tostring(currentRoom))
                if targetRoom and targetRoom.Name == "50" then
                    cancelReboundForProtectedArea()
                    break
                end
                if targetRoom then
                    local targetCFrame
                    if targetRoom:FindFirstChild("Nodes") then
                        targetCFrame = (targetRoom:FindFirstChild("RoomEntrance") or targetRoom:FindFirstChild("RoomExit")).CFrame
                    else
                        targetCFrame = targetRoom.RoomExit.CFrame
                    end

                    if not startReboundTween(targetCFrame + v307) then
                        break
                    end

                    if not waitReboundStep(v306) then
                        break
                    end
                    if not waitForReboundArrival() then
                        break
                    end
                end

                maxRoom = game.ReplicatedStorage.GameData.LatestRoom.Value
                currentRoom = currentRoom + 1
            end
        else
            local currentRoom = GetMaxExistingRoom()
            local minRoom = math.max(0, currentRoom - 7)

            while currentRoom >= minRoom and not reboundSealed and primaryPart.Parent do
                if isReboundProtectedArea() then
                    cancelReboundForProtectedArea()
                    break
                end

                local targetRoom = v310:FindFirstChild(tostring(currentRoom))
                if targetRoom and targetRoom.Name == "50" then
                    cancelReboundForProtectedArea()
                    break
                end
                if targetRoom then
                    local targetCFrame
                    if targetRoom:FindFirstChild("Nodes") then
                        targetCFrame = (targetRoom:FindFirstChild("RoomEntrance") or targetRoom:FindFirstChild("RoomExit")).CFrame
                    else
                        targetCFrame = targetRoom.RoomExit.CFrame
                    end

                    if not startReboundTween(targetCFrame + v307) then
                        break
                    end

                    if not waitReboundStep(v306) then
                        break
                    end
                    if not waitForReboundArrival() then
                        break
                    end
                end

                currentRoom = currentRoom - 1
            end
        end

        while not reboundSealed and ceaseFreezeActive and primaryPart.Parent do
            RunService.Heartbeat:Wait()
        end
        reboundMovementEnded = true
        if ceaseFreezeActive then
            restoreCeaseEffects()
        end
        if primaryPart.Parent then
            primaryPart.Anchored = false
            primaryPart.CanCollide = false
        end
    end

    for _, obj in pairs(workspace:GetChildren()) do
        if obj.Name == "Rebound" or obj.Name == "Bound" or 
           (obj.Name:find("ReboundMovings") and not obj.Name:find("_Preloaded")) or 
           (obj.Name:find("ReboundSweep") and not obj.Name:find("_Preloaded")) then
            pcall(function() obj:Destroy() end)
        end
    end

    sweepSoundForEvent = PlayPreloadedSound("ReboundSweep", 2)
    
    local part = Instance.new("Part")
    reboundMarkerPart = part
    part.Name = "Bound_" .. tick()
    part.Parent = workspace
    game.Lighting.MainColorCorrection.TintColor = Color3.fromRGB(61, 171, 98)
    game.Lighting.MainColorCorrection.Contrast = 0.2
    game.Lighting.MainColorCorrection.Saturation = -0.7

    local tween = game:GetService("TweenService")
    tween:Create(game.Lighting.MainColorCorrection, TweenInfo.new(5), {Contrast = 0}):Play()
    tween:Create(game.Lighting.MainColorCorrection, TweenInfo.new(5), {Saturation = 0}):Play()
    local TW = tween:Create(game.Lighting.MainColorCorrection, TweenInfo.new(5), {TintColor = Color3.fromRGB(255, 255, 255)})
    TW:Play()

    reboundCameraShake:ShakeOnce(10, 3, 0.1, 6, 2, 0.5)

    task.wait(3)

    if isReboundProtectedArea() then
        cancelReboundForProtectedArea()
    end
    if not reboundSealed then
    local latestRoom = game.ReplicatedStorage.GameData.LatestRoom
    local doorGateOpen = false
    local acceptedDoorCount = 0
    doorSignal = Instance.new("BindableEvent")
    local doorConnection = latestRoom:GetPropertyChangedSignal("Value"):Connect(function()
        if doorGateOpen and not reboundSealed then
            acceptedDoorCount = acceptedDoorCount + 1
            doorSignal:Fire()
        end
    end)

    local function waitForSoundToFinish(sound)
        if not sound or not sound.Parent then
            return
        end
        local finished = false
        local connection = sound.Ended:Connect(function()
            finished = true
        end)
        local startedAt = os.clock()
        while not reboundSealed and sound.Parent and not finished do
            if os.clock() - startedAt >= 120 then
                break
            end
            if not sound.IsLoaded and os.clock() - startedAt >= 15 then
                break
            end
            task.wait(0.05)
        end
        connection:Disconnect()
    end

    local function waitForNextQualifiedDoor()
        if reboundSealed then
            return false
        end
        local previousAcceptedCount = acceptedDoorCount
        doorGateOpen = true
        while not reboundSealed and acceptedDoorCount == previousAcceptedCount do
            -- Polling prevents a missed Fire from hanging a protected-area cancellation.
            task.wait(0.05)
        end
        doorGateOpen = false
        return not reboundSealed
    end

    local directions = { "latest", "start", "latest", "start" }
    for waveIndex, startRoomType in ipairs(directions) do
        if reboundSealed then
            break
        end
        if isReboundProtectedArea() then
            cancelReboundForProtectedArea()
            break
        end
        if not SpawnReboundEntity(startRoomType) then
            break
        end
        if reboundSealed then
            break
        end
        movingSoundForWave = PlayPreloadedSound("ReboundMovings", 3)
        waitForSoundToFinish(movingSoundForWave)
        movingSoundForWave = nil
        if reboundSealed then
            break
        end
        if waveIndex < #directions then
            if not waitForNextQualifiedDoor() then
                break
            end
        end
    end
    doorGateOpen = false
    doorConnection:Disconnect()
    if doorSignal then
        doorSignal:Destroy()
        doorSignal = nil
    end
    stopReboundCameraShake()
    doorSignal = nil
    end -- not reboundSealed (post-intro)
    reboundPhaseRunning = false
    if reboundMarkerPart and reboundMarkerPart.Parent then
        reboundMarkerPart:Destroy()
    end
    stopReboundCameraShake()
            end
        end)

        -- Frostbite variant 2: 650-second cadence, 2 damage / second.
        -- Suppress spawning in Seek and room 50, and instantly exit to F3 if
        -- one appears during a live encounter.
        local function isFrostbite650ProtectedArea()
            local rooms = workspace:FindFirstChild("CurrentRooms")
            if rooms and rooms:FindFirstChild("50") then
                return true
            end
            if workspace:FindFirstChild("50") then
                return true
            end
            for _, seekName in ipairs({
                "SeekMovingNewClone", "SeekMovingNew", "SeekMoving", "SeekMov"
            }) do
                if workspace:FindFirstChild(seekName) then
                    return true
                end
            end
            if vu31 and vu31.MainGame and vu31.MainGame.chase then
                return true
            end
            return false
        end

        task.spawn(function()
            while task.wait(650) do
                local gameData = game.ReplicatedStorage:FindFirstChild("GameData")
                local latestRoom = gameData and gameData:FindFirstChild("LatestRoom")
                if not latestRoom then
                    continue
                end
                -- Keep the original post-timer door-change trigger.
                latestRoom:GetPropertyChangedSignal("Value"):Wait()
                if isFrostbite650ProtectedArea() then
                    continue
                end
                local ok, err = xpcall(function()
                    local function runFrostbite650Encounter()
                        local function GetFrostbite650Room()
                        	local rooms = workspace:FindFirstChild("CurrentRooms")
                        	local gameData = game.ReplicatedStorage:FindFirstChild("GameData")
                        	local latestRoom = gameData and gameData:FindFirstChild("LatestRoom")

                        	if not rooms or not latestRoom then
                        		return nil
                        	end

                        	return rooms:FindFirstChild(tostring(latestRoom.Value))
                        end

                        local function LoadFrostbite650Instance(source, parent)
                        	local model

                        	for _ = 1, 30 do
                        		if isFrostbite650ProtectedArea() then
                        			return nil
                        		end
                        		local success, result = pcall(function()
                        			return game:GetObjects("rbxassetid://" .. tostring(source))[1]
                        		end)

                        		if success and result then
                        			model = result
                        			for _, v in ipairs(model:GetDescendants()) do
                        				if v:IsA("Script") or v:IsA("LocalScript") then
                        					v:Destroy()
                        				end
                        			end
                        			if isFrostbite650ProtectedArea() then
                        				model:Destroy()
                        				return nil
                        			end
                        			model.Parent = parent
                        			return model
                        		end
                        		task.wait(0.2)
                        	end

                        	return nil
                        end

                        local plr = game.Players.LocalPlayer
                        local chr = plr.Character or plr.CharacterAdded:Wait()
                        local camera = workspace.CurrentCamera
                        local TweenService = game:GetService("TweenService")
                        local Debris = game:GetService("Debris")
                        local ReplicatedStorage = game:GetService("ReplicatedStorage")

                        if isFrostbite650ProtectedArea() then
                        	return
                        end

                        local s = LoadFrostbite650Instance("83840759413024", nil)
                        if not s then
                        	return
                        end

                        if isFrostbite650ProtectedArea() then
                        	s:Destroy()
                        	return
                        end

                        local entity = s:FindFirstChildWhichIsA("BasePart")
                        if not entity then
                        	s:Destroy()
                        	return
                        end

                        local firstRoom = GetFrostbite650Room()
                        if not firstRoom or not firstRoom:FindFirstChild("RoomEntrance") then
                        	s:Destroy()
                        	return
                        end

                        if isFrostbite650ProtectedArea() then
                        	s:Destroy()
                        	return
                        end

                        entity.CFrame = firstRoom.RoomEntrance.CFrame * CFrame.new(0, 5, -15)
                        s.Parent = workspace

                        local effectNames = {
                        	"face",
                        	"Heylois",
                        	"BlackTrai2l",
                        	"BlackTrai3l"
                        }

                        local function SetEntityEffectsEnabled(state)
                        	local attachment = entity:FindFirstChild("Attachment")
                        	if not attachment then
                        		return
                        	end

                        	for _, name in ipairs(effectNames) do
                        		local effect = attachment:FindFirstChild(name)
                        		if effect and (effect:IsA("ParticleEmitter") or effect:IsA("Trail") or effect:IsA("Beam")) then
                        			effect.Enabled = state
                        		elseif effect and effect:IsA("Light") then
                        			effect.Enabled = state
                        		end
                        	end
                        end

                        SetEntityEffectsEnabled(false)

                        local staticSounds = {}

                        for _, v in ipairs(s:GetDescendants()) do
                        	if v:IsA("Sound") and v.Name == "Static Effect" then
                        		v.Looped = true
                        		v:Play()
                        		table.insert(staticSounds, v)
                        	end
                        end

                        local hardcore = workspace:FindFirstChild("HardCoreSound")
                        local music

                        local function PlayMusic(name, looped, waitForLoad)
                        	if music then
                        		music:Stop()
                        		music:Destroy()
                        		music = nil
                        	end

                        	if not hardcore then
                        		return nil
                        	end

                        	local source = hardcore:FindFirstChild(name)
                        	if not source or not source:IsA("Sound") then
                        		return nil
                        	end

                        	music = source:Clone()
                        	music.Parent = workspace
                        	music.Looped = looped

                        	if waitForLoad and not music.IsLoaded then
                        		local started = os.clock()

                        		while music.Parent and not music.IsLoaded and os.clock() - started < 3 do
                        			task.wait()
                        		end
                        	end

                        	music:Play()
                        	return music
                        end

                        PlayMusic("F1", true)

                        local frost = Instance.new("ColorCorrectionEffect")
                        frost.Parent = game.Lighting

                        TweenService:Create(
                        	frost,
                        	TweenInfo.new(10),
                        	{
                        		TintColor = Color3.fromRGB(217, 250, 255),
                        		Saturation = -0.7,
                        		Contrast = 0.2
                        	}
                        ):Play()

                        local light = Instance.new("PointLight")
                        light.Range = 60
                        light.Brightness = 99999
                        light.Parent = entity

                        TweenService:Create(
                        	light,
                        	TweenInfo.new(3),
                        	{
                        		Brightness = 0
                        	}
                        ):Play()

                        local finished = false
                        local camShake
                        local cameraShakerModule = ReplicatedStorage:FindFirstChild("CameraShaker")

                        if cameraShakerModule then
                        	local success, shaker = pcall(require, cameraShakerModule)

                        	if success and shaker then
                        		camShake = shaker.new(
                        			Enum.RenderPriority.Camera.Value,
                        			function(cf)
                        				camera = workspace.CurrentCamera

                        				if camera then
                        					camera.CFrame = camera.CFrame * cf
                        				end
                        			end
                        		)

                        		camShake:Start()

                        		task.spawn(function()
                        			while entity.Parent and not finished do
                        				camera = workspace.CurrentCamera

                        				if camera then
                        					local distance = (camera.CFrame.Position - entity.Position).Magnitude
                        					local power = math.clamp(1 - distance / 120, 0, 1)

                        					if power > 0 then
                        						camShake:ShakeOnce(
                        							power * 8,
                        							40,
                        							0.05,
                        							0.35,
                        							Vector3.new(0.15, 0.15, 0.15),
                        							Vector3.new(1, 1, 1)
                        						)
                        					end
                        				end

                        				task.wait(0.15)
                        			end
                        		end)
                        	end
                        end

                        -- If Seek or room 50 appears at ANY point, go directly to F3 and remove the
                        -- model, damage loop, camera shake and color filter immediately.
                        local protectedOutro = false
                        local cleanupDone = false
                        local protectedPhaseConnection = nil

                        local function cleanupFrostbite650(keepF3Playing)
                        	if cleanupDone then
                        		return
                        	end
                        	cleanupDone = true
                        	finished = true
                        	dmg = false
                        	roomChanged = true

                        	if protectedPhaseConnection then
                        		protectedPhaseConnection:Disconnect()
                        		protectedPhaseConnection = nil
                        	end
                        	if camShake then
                        		pcall(function() camShake:Stop() end)
                        	end
                        	for _, sound in ipairs(staticSounds) do
                        		if sound.Parent then sound:Stop() end
                        	end
                        	pcall(function()
                        		entity.Ambience:Stop()
                        		entity.AmbienceFar:Stop()
                        	end)
                        	SetEntityEffectsEnabled(false)

                        	if music then
                        		local currentMusic = music
                        		music = nil
                        		if keepF3Playing and currentMusic.Name == "F3" then
                        			-- Play the last phase to completion even though Frostbite vanishes now.
                        			currentMusic.Ended:Once(function()
                        				if currentMusic.Parent then currentMusic:Destroy() end
                        			end)
                        			local soundLength = currentMusic.TimeLength
                        			Debris:AddItem(currentMusic, math.clamp(soundLength > 0 and soundLength + 10 or 90, 30, 180))
                        		else
                        			currentMusic:Stop()
                        			currentMusic:Destroy()
                        		end
                        	end
                        	if s and s.Parent then s:Destroy() end
                        	if frost and frost.Parent then frost:Destroy() end
                        end

                        local function beginFrostbite650ProtectedOutro()
                        	if finished or protectedOutro then
                        		return
                        	end
                        	protectedOutro = true
                        	-- Do not wait for the F3 sound to load: protected-phase removal is immediate.
                        	if not music or music.Name ~= "F3" then
                        		PlayMusic("F3", false, false)
                        	end
                        	cleanupFrostbite650(true)
                        end

                        protectedPhaseConnection = game:GetService("RunService").Heartbeat:Connect(function()
                        	if not finished and isFrostbite650ProtectedArea() then
                        		beginFrostbite650ProtectedOutro()
                        	end
                        end)
                        if isFrostbite650ProtectedArea() then
                        	beginFrostbite650ProtectedOutro()
                        end

                        if finished then
                        	return
                        end

                        task.wait(5)
                        if finished then
                        	return
                        end

                        for _, v in ipairs(staticSounds) do
                        	v:Stop()
                        end

                        SetEntityEffectsEnabled(true)

                        pcall(function()
                        	entity.Ambience:Play()
                        	entity.AmbienceFar:Play()
                        end)

                        local function LerpNumberSequenceToOne(sequence, alpha)
                        	local keypoints = {}

                        	for _, keypoint in ipairs(sequence.Keypoints) do
                        		local value = keypoint.Value + (1 - keypoint.Value) * alpha
                        		local envelope = keypoint.Envelope * (1 - alpha)

                        		table.insert(
                        			keypoints,
                        			NumberSequenceKeypoint.new(
                        				keypoint.Time,
                        				value,
                        				envelope
                        			)
                        		)
                        	end

                        	return NumberSequence.new(keypoints)
                        end

                        local finalFadeStarted = false

                        local function StartFinalFade(duration)
                        	if finalFadeStarted then
                        		return
                        	end

                        	finalFadeStarted = true
                        	duration = math.max(tonumber(duration) or 5, 0.1)

                        	pcall(function()
                        		entity.Ambience:Stop()
                        		entity.AmbienceFar:Stop()
                        	end)

                        	SetEntityEffectsEnabled(false)

                        	local des = Instance.new("Sound")
                        	des.SoundId = "rbxassetid://111715441853991"
                        	des.Volume = 0.5
                        	des.Parent = workspace
                        	des:Play()
                        	Debris:AddItem(des, math.max(duration + 2, 10))

                        	local particleData = {}

                        	for _, v in ipairs(s:GetDescendants()) do
                        		if v:IsA("BasePart") then
                        			TweenService:Create(
                        				v,
                        				TweenInfo.new(duration, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
                        				{
                        					Transparency = 1
                        				}
                        			):Play()
                        		elseif v:IsA("Decal") or v:IsA("Texture") then
                        			TweenService:Create(
                        				v,
                        				TweenInfo.new(duration, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
                        				{
                        					Transparency = 1
                        				}
                        			):Play()
                        		elseif v:IsA("Light") then
                        			TweenService:Create(
                        				v,
                        				TweenInfo.new(duration, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
                        				{
                        					Brightness = 0
                        				}
                        			):Play()
                        		elseif v:IsA("ParticleEmitter") then
                        			table.insert(
                        				particleData,
                        				{
                        					Object = v,
                        					Transparency = v.Transparency
                        				}
                        			)
                        		end
                        	end

                        	local fadeValue = Instance.new("NumberValue")
                        	fadeValue.Value = 0

                        	local changedConnection
                        	changedConnection = fadeValue:GetPropertyChangedSignal("Value"):Connect(function()
                        		for _, data in ipairs(particleData) do
                        			if data.Object and data.Object.Parent then
                        				data.Object.Transparency = LerpNumberSequenceToOne(
                        					data.Transparency,
                        					fadeValue.Value
                        				)
                        			end
                        		end
                        	end)

                        	local particleTween = TweenService:Create(
                        		fadeValue,
                        		TweenInfo.new(duration, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
                        		{
                        			Value = 1
                        		}
                        	)

                        	particleTween:Play()

                        	particleTween.Completed:Connect(function()
                        		if changedConnection then
                        			changedConnection:Disconnect()
                        		end

                        		for _, data in ipairs(particleData) do
                        			if data.Object and data.Object.Parent then
                        				data.Object.Transparency = NumberSequence.new(1)
                        				data.Object.Enabled = false
                        			end
                        		end

                        		fadeValue:Destroy()
                        	end)

                        	if frost and frost.Parent then
                        		TweenService:Create(
                        			frost,
                        			TweenInfo.new(duration, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
                        			{
                        				TintColor = Color3.fromRGB(255, 255, 255),
                        				Saturation = 0,
                        				Contrast = 0
                        			}
                        		):Play()
                        	end
                        end

                        local roomCount = 0
                        local gameData = ReplicatedStorage:FindFirstChild("GameData")
                        local latestRoom = gameData and gameData:FindFirstChild("LatestRoom")

                        if not latestRoom then
                        	finished = true
                        end

                        task.spawn(function()
                        	if not latestRoom then
                        		return
                        	end

                        	while roomCount < 5 and not finished do
                        		local roomChangedNow = false
                        		local roomConnection = latestRoom.Changed:Connect(function()
                        			roomChangedNow = true
                        		end)
                        		while not roomChangedNow and not finished do
                        			task.wait(0.05)
                        		end
                        		roomConnection:Disconnect()

                        		if finished then
                        			break
                        		end

                        		roomCount += 1

                        		local room = GetFrostbite650Room()

                        		if room and room:FindFirstChild("RoomEntrance") and entity.Parent then
                        			local value = Instance.new("CFrameValue")
                        			value.Value = entity.CFrame

                        			local connection
                        			connection = value:GetPropertyChangedSignal("Value"):Connect(function()
                        				if entity.Parent then
                        					entity.CFrame = value.Value
                        				end
                        			end)

                        			local tween = TweenService:Create(
                        				value,
                        				TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
                        				{
                        					Value = room.RoomEntrance.CFrame * CFrame.new(0, 5, -15)
                        				}
                        			)

                        			tween:Play()
                        			while not finished and tween.PlaybackState == Enum.PlaybackState.Playing do
                        				task.wait(0.05)
                        			end
                        			if finished then tween:Cancel() end

                        			if connection then
                        				connection:Disconnect()
                        			end

                        			value:Destroy()
                        		end

                        		if finished then
                        			break
                        		end
                        		if roomCount == 3 then
                        			PlayMusic("F2", true)
                        		elseif roomCount == 5 then
                        			local f3 = PlayMusic("F3", false, true)
                        			if finished then
                        				break
                        			end
                        			local fadeDuration = 5

                        			if f3 and f3.TimeLength > 0 then
                        				fadeDuration = f3.TimeLength
                        			end

                        			StartFinalFade(fadeDuration)

                        			if f3 then
                        				local ended = false
                        				local endedConnection

                        				endedConnection = f3.Ended:Connect(function()
                        					ended = true
                        				end)

                        				local started = os.clock()

                        				while not finished and f3.Parent and not ended and os.clock() - started < fadeDuration + 2 do
                        					task.wait()
                        				end

                        				if endedConnection then
                        					endedConnection:Disconnect()
                        				end
                        			else
                        				local fadeStarted = os.clock()
                        				while not finished and os.clock() - fadeStarted < fadeDuration do
                        					task.wait(0.05)
                        				end
                        			end

                        			finished = true
                        			break
                        		end
                        	end
                        end)

                        task.spawn(function()
                        	while not finished do
                        		task.wait(1)

                        		if finished then
                        			break
                        		end

                        		local safe = false
                        		local activeCharacter = plr.Character
                        		local lighter = activeCharacter and activeCharacter:FindFirstChild("Lighter")

                        		if lighter and lighter:FindFirstChild("Handle") then
                        			local holder = lighter.Handle:FindFirstChild("EffectsHolder")

                        			if holder and holder:FindFirstChild("AttachOn") then
                        				local main = holder.AttachOn:FindFirstChild("MainLight")

                        				if main and main:IsA("PointLight") then
                        					safe = main.Enabled
                        				end
                        			end
                        		end

                        		if not safe and not finished and not isFrostbite650ProtectedArea() then
                        			pcall(function()
                        				local humanoid = activeCharacter and activeCharacter:FindFirstChildOfClass("Humanoid")

                        				if humanoid and humanoid.Health > 0 then
                        					humanoid:TakeDamage(2)
                        				end
                        			end)
                        		end
                        	end
                        end)

                        repeat
                        	task.wait()
                        until finished

                        cleanupFrostbite650(protectedOutro)
                    end
                    runFrostbite650Encounter()
                end, function(message)
                    return tostring(message) .. "\n" .. debug.traceback()
                end)
                if not ok then
                    warn("Hardcore second Frostbite failed: " .. tostring(err))
                end
            end
        end)

        -- Prevent Ripper events during the Figure library and either Seek chase.
        -- Use the live room number rather than blocking forever after room 50 loads.
        local function isRipperProtectedArea()
            local workspaceService = game:GetService("Workspace")
            local storage = game:GetService("ReplicatedStorage")
            local rooms = workspaceService:FindFirstChild("CurrentRooms")
            local gameData = storage:FindFirstChild("GameData")
            local latestRoom = gameData and gameData:FindFirstChild("LatestRoom")
            local roomNumber = latestRoom and tonumber(latestRoom.Value)

            if roomNumber == 50 then
                return true
            end

            -- Room 50 may be preloaded while the player is opening door 49.
            if rooms and rooms:FindFirstChild("50")
                and roomNumber and roomNumber >= 49 and roomNumber <= 50 then
                return true
            end

            if workspaceService:FindFirstChild("SeekMovingNewClone") then
                return true
            end

            if vu31 and vu31.MainGame and vu31.MainGame.chase then
                return true
            end

            return false
        end

        task.spawn(function()
            while task.wait(179) do
                game.ReplicatedStorage.GameData.LatestRoom:GetPropertyChangedSignal("Value"):Wait()
                -- Skip this spawn without terminating the Ripper timer loop.
                if isRipperProtectedArea() then
                    continue
                end

                task.wait(1)
                if isRipperProtectedArea() then
                    continue
                end
 local hardCoreSound = workspace:FindFirstChild("HardCoreSound")
    local backgroundSound = hardCoreSound and hardCoreSound:FindFirstChild("RipperBackgroundSound")
    if backgroundSound and backgroundSound:IsA("Sound") then
        backgroundSound:Stop()
        backgroundSound.TimePosition = 0
        backgroundSound:Play()
    end

     local TweenService = game:GetService("TweenService")
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")

    local targetColor = Color3.fromRGB(255, 93, 93)
    local fadeDuration = 1

    local fadeInfo = TweenInfo.new(
        fadeDuration,
        Enum.EasingStyle.Linear,
        Enum.EasingDirection.Out
    )

    local function createFadeTween(object)
        if object:IsA("BasePart") or object:IsA("Light") then
            local tween = TweenService:Create(
                object,
                fadeInfo,
                {
                    Color = targetColor
                }
            )

            tween:Play()
            return tween
        end

        return nil
    end
    local function createBeamFadeTween(beam)
    if not beam or not beam:IsA("Beam") then
        return
    end

    local colorValue = Instance.new("Color3Value")
    colorValue.Value = beam.Color.Keypoints[1].Value

    local connection
    connection = colorValue.Changed:Connect(function(value)
        if beam and beam.Parent then
            beam.Color = ColorSequence.new(value)
        elseif connection then
            connection:Disconnect()
        end
    end)

    local tween = TweenService:Create(
        colorValue,
        fadeInfo,
        {
            Value = targetColor
        }
    )

    tween.Completed:Connect(function()
        if connection then
            connection:Disconnect()
        end

        if beam and beam.Parent then
            beam.Color = ColorSequence.new(targetColor)
        end

        colorValue:Destroy()
    end)

    tween:Play()
end

    local function modifyObjectsWithTween()
        if isRipperProtectedArea() then
            return
        end
        local currentRooms = workspace:FindFirstChild("CurrentRooms")

        if not currentRooms then
            return
        end

        for _, room in ipairs(currentRooms:GetChildren()) do
            if room:IsA("Model") then
                local assets = room:FindFirstChild("Assets")

                if assets then
                    for _, chandelier in ipairs(assets:GetChildren()) do
                        if chandelier:IsA("Model")
                            and chandelier.Name == "Chandelier"
                        then
                            local lightFixture =
                                chandelier:FindFirstChild("LightFixture")

                            if lightFixture then
                                local pointLight =
                                    lightFixture:FindFirstChild("PointLight")

                                local spotLight =
                                    lightFixture:FindFirstChild("SpotLight")

                                local neon =
                                    lightFixture:FindFirstChild("Neon")

                                if pointLight
                                    and pointLight:IsA("PointLight")
                                then
                                    createFadeTween(pointLight)
                                end

                                if spotLight
                                    and spotLight:IsA("SpotLight")
                                then
                                    createFadeTween(spotLight)
                                end

                                if neon and neon:IsA("BasePart") then
                                    createFadeTween(neon)
                                end
                            end
                        end
                    end
                    local lightFixturesNew = assets:FindFirstChild("Light_Fixtures")

if lightFixturesNew then
    for _, lightStand in ipairs(lightFixturesNew:GetChildren()) do
        if lightStand:IsA("Model") and lightStand.Name == "LightStand" then
            for _, lightFixture in ipairs(lightStand:GetChildren()) do
                if lightFixture.Name == "LightFixture" then
                    for _, loadedLight in ipairs(lightFixture:GetChildren()) do
                        if loadedLight.Name == "LoadedLight_New" then
                            for _, atachm in ipairs(loadedLight:GetDescendants()) do
                                if atachm.Name == "atachm" then
                                    for _, newLight in ipairs(atachm:GetChildren()) do
                                        if newLight.Name == "Ok you cannot tell me this isnt good" then
                                            if newLight:IsA("BasePart") or newLight:IsA("Light") then
                                                createFadeTween(newLight)
                                            elseif newLight:IsA("Beam") then
                                                createBeamFadeTween(newLight)
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

for _, loadedChandelier in ipairs(assets:GetChildren()) do
    if loadedChandelier.Name == "LoadedChandelier_New" then
        for _, lightFixture in ipairs(loadedChandelier:GetChildren()) do
            if lightFixture.Name == "LightFixture" then
                for _, neon in ipairs(lightFixture:GetChildren()) do
                    if neon.Name == "Neon" then
                        for _, attachment in ipairs(neon:GetChildren()) do
                            if attachment.Name == "Attachment" then
                                for _, beam in ipairs(attachment:GetChildren()) do
                                    if beam.Name == "Beam" and beam:IsA("Beam") then
                                        createBeamFadeTween(beam)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

                    local lightFixtures =
                        assets:FindFirstChild("Light_Fixtures")

                    if lightFixtures then
                        for _, lightStand in ipairs(
                            lightFixtures:GetChildren()
                        ) do
                            if lightStand:IsA("Model")
                                and lightStand.Name == "LightStand"
                            then
                                local lightFixture =
                                    lightStand:FindFirstChild(
                                        "LightFixture"
                                    )

                                if lightFixture then
                                    local pointLight =
                                        lightFixture:FindFirstChild(
                                            "PointLight"
                                        )

                                    local neon =
                                        lightFixture:FindFirstChild("Neon")

                                    if pointLight
                                        and pointLight:IsA("PointLight")
                                    then
                                        createFadeTween(pointLight)
                                    end

                                    if neon and neon:IsA("BasePart") then
                                        createFadeTween(neon)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    task.spawn(modifyObjectsWithTween)

    local isJumpScaring = false
    local ripper = nil
    local ripperAsset = nil
    local isRipperDespawning = false
    local crucifixActivated = false
    local ripperIsMoving = false
    local ripperMoveCancelled = false
    local ceaseFreezeActive = false
    local ceaseSpeedScale = 1
    local ceaseFreezeSerial = 0
    local ceaseSavedEffects = {}
    local ceaseDescendantConnection = nil
    local ceaseHandledModels = setmetatable({}, { __mode = "k" })

    local function easeCease(alpha)
        alpha = math.clamp(alpha, 0, 1)
        return alpha * alpha * (3 - 2 * alpha)
    end

    local function applyCeaseSpeed(scale)
        ceaseSpeedScale = math.clamp(scale, 0, 1)

        for object, saved in pairs(ceaseSavedEffects) do
            if object.Parent then
                if saved.Type == "Particle" then
                    pcall(function()
                        object.TimeScale = saved.TimeScale * ceaseSpeedScale
                    end)
                else
                    pcall(function()
                        object.PlaybackSpeed = saved.PlaybackSpeed * ceaseSpeedScale
                        object.Volume = saved.Volume * ceaseSpeedScale
                    end)
                end
            end
        end
    end

    local function trackCeaseEffect(object)
        if ceaseSavedEffects[object] then
            return
        end

        if object:IsA("ParticleEmitter") then
            ceaseSavedEffects[object] = {
                Type = "Particle",
                TimeScale = object.TimeScale
            }
        elseif object:IsA("Sound") then
            ceaseSavedEffects[object] = {
                Type = "Sound",
                PlaybackSpeed = object.PlaybackSpeed,
                Volume = object.Volume
            }
        else
            return
        end

        if ceaseFreezeActive then
            local saved = ceaseSavedEffects[object]
            if saved.Type == "Particle" then
                pcall(function()
                    object.TimeScale = saved.TimeScale * ceaseSpeedScale
                end)
            else
                pcall(function()
                    object.PlaybackSpeed = saved.PlaybackSpeed * ceaseSpeedScale
                    object.Volume = saved.Volume * ceaseSpeedScale
                end)
            end
        end
    end

    local function cancelCeaseFreeze()
        ceaseFreezeSerial = ceaseFreezeSerial + 1

        if ceaseDescendantConnection then
            ceaseDescendantConnection:Disconnect()
            ceaseDescendantConnection = nil
        end

        for object, saved in pairs(ceaseSavedEffects) do
            if object.Parent then
                if saved.Type == "Particle" then
                    pcall(function()
                        object.TimeScale = saved.TimeScale
                    end)
                else
                    pcall(function()
                        object.PlaybackSpeed = saved.PlaybackSpeed
                        object.Volume = saved.Volume
                    end)
                end
            end
        end

        ceaseSavedEffects = {}
        ceaseSpeedScale = 1
        ceaseFreezeActive = false
    end

    local function startCeaseFreeze(ceaseModel)
        if ceaseFreezeActive or not ripperIsMoving or isJumpScaring
            or isRipperDespawning or not ripper or not ripper.Parent
            or ceaseHandledModels[ceaseModel] then
            return
        end

        ceaseHandledModels[ceaseModel] = true
        ceaseFreezeActive = true
        ceaseFreezeSerial = ceaseFreezeSerial + 1
        local freezeSerial = ceaseFreezeSerial

        for _, descendant in ipairs(ripper:GetDescendants()) do
            trackCeaseEffect(descendant)
        end

        if backgroundSound and backgroundSound.Parent then
            trackCeaseEffect(backgroundSound)
        end

        ceaseDescendantConnection = ripper.DescendantAdded:Connect(function(descendant)
            if ceaseFreezeSerial == freezeSerial and ceaseFreezeActive then
                trackCeaseEffect(descendant)
            end
        end)

        task.spawn(function()
            local function stillValid()
                return ceaseFreezeSerial == freezeSerial
                    and not isJumpScaring
                    and not isRipperDespawning
                    and ripper and ripper.Parent ~= nil
            end

            local function transition(fromScale, toScale, duration)
                local startedAt = os.clock()
                while true do
                    if not stillValid() then
                        if ceaseFreezeSerial == freezeSerial then
                            cancelCeaseFreeze()
                        end
                        return false
                    end

                    local alpha = math.clamp((os.clock() - startedAt) / duration, 0, 1)
                    local eased = easeCease(alpha)
                    applyCeaseSpeed(fromScale + (toScale - fromScale) * eased)

                    if alpha >= 1 then
                        return true
                    end

                    RunService.Heartbeat:Wait()
                end
            end

            if not transition(1, 0, 2.25) then
                return
            end

            local holdStartedAt = os.clock()
            while os.clock() - holdStartedAt < 13 do
                if not stillValid() then
                    if ceaseFreezeSerial == freezeSerial then
                        cancelCeaseFreeze()
                    end
                    return
                end
                task.wait(0.05)
            end

            if not transition(0, 1, 2) then
                return
            end

            if ceaseFreezeSerial == freezeSerial then
                cancelCeaseFreeze()
            end
        end)
    end

    local function StopRipperMovement()
        ripperMoveCancelled = true
        ripperIsMoving = false
        cancelCeaseFreeze()
    end

    local function getCrucifixTool(character)
        if not character or not character:IsA("Model") then
            return nil
        end

        local directTool = character:FindFirstChild("Crucifix")
        if directTool and directTool:IsA("Tool") then
            return directTool
        end

        for _, descendant in ipairs(character:GetDescendants()) do
            if descendant.Name == "Crucifix" and descendant:IsA("Tool") then
                return descendant
            end
        end

        return nil
    end

    local function getCharacterFromRaycastHit(hitInstance)
        local current = hitInstance

        while current and current ~= workspace do
            if current:IsA("Model") and Players:GetPlayerFromCharacter(current) then
                return current
            end

            current = current.Parent
        end

        return nil
    end

    local function rayEntryDistanceToPart(origin, directionUnit, part)
        if not part or not part.Parent or not part:IsA("BasePart") then
            return nil
        end

        local localOrigin = part.CFrame:PointToObjectSpace(origin)
        local localDirection = part.CFrame:VectorToObjectSpace(directionUnit)
        local half = part.Size * 0.5
        local entry, exit = 0, math.huge

        for _, axis in ipairs({ "X", "Y", "Z" }) do
            local position = localOrigin[axis]
            local velocity = localDirection[axis]
            local extent = half[axis]
            if math.abs(velocity) < 0.00001 then
                if position < -extent or position > extent then
                    return nil
                end
            else
                local near = (-extent - position) / velocity
                local far = (extent - position) / velocity
                if near > far then
                    near, far = far, near
                end
                entry = math.max(entry, near)
                exit = math.min(exit, far)
                if exit < entry then
                    return nil
                end
            end
        end

        return entry
    end


    local function getCrucifixVisualStates(root, shouldInclude, onlyRoot)
        local states = {}

        local function capture(object)
            if shouldInclude and not shouldInclude(object) then
                return
            end

            if object:IsA("BasePart") or object:IsA("Decal")
                or object:IsA("Texture") then
                table.insert(states, {
                    Object = object,
                    Kind = "Transparency",
                    Original = object.Transparency
                })
            elseif object:IsA("ParticleEmitter") or object:IsA("Beam")
                or object:IsA("Trail") then
                table.insert(states, {
                    Object = object,
                    Kind = "Sequence",
                    Original = object.Transparency
                })
            elseif object:IsA("Light") then
                table.insert(states, {
                    Object = object,
                    Kind = "Brightness",
                    Original = object.Brightness
                })
            elseif object:IsA("Highlight") then
                table.insert(states, {
                    Object = object,
                    Kind = "Highlight",
                    Fill = object.FillTransparency,
                    Outline = object.OutlineTransparency
                })
            elseif object:IsA("Smoke") then
                table.insert(states, {
                    Object = object,
                    Kind = "Smoke",
                    Original = object.Opacity
                })
            elseif object:IsA("Fire") then
                table.insert(states, {
                    Object = object,
                    Kind = "Fire",
                    Size = object.Size,
                    Heat = object.Heat
                })
            elseif object:IsA("Sound") then
                table.insert(states, {
                    Object = object,
                    Kind = "Sound",
                    Original = object.Volume
                })
            elseif object:IsA("GuiObject") then
                local state = {
                    Object = object,
                    Kind = "GuiObject",
                    Background = object.BackgroundTransparency
                }

                if object:IsA("ImageLabel") or object:IsA("ImageButton") then
                    state.Image = object.ImageTransparency
                end

                if object:IsA("TextLabel") or object:IsA("TextButton")
                    or object:IsA("TextBox") then
                    state.Text = object.TextTransparency
                end

                table.insert(states, state)
            end
        end

        capture(root)
        if not onlyRoot then
            for _, descendant in ipairs(root:GetDescendants()) do
                capture(descendant)
            end
        end

        return states
    end

    local function crucifixFadedSequence(original, factor)
        local keypoints = {}

        for _, keypoint in ipairs(original.Keypoints) do
            local nextTransparency = 1 - (1 - keypoint.Value) * factor
            table.insert(keypoints, NumberSequenceKeypoint.new(
                keypoint.Time,
                math.clamp(nextTransparency, 0, 1),
                keypoint.Envelope * factor
            ))
        end

        return NumberSequence.new(keypoints)
    end

    local function setCrucifixVisualFactor(states, factor)
        factor = math.clamp(factor, 0, 1)

        for _, state in ipairs(states) do
            local object = state.Object

            if object and object.Parent then
                if state.Kind == "Transparency" then
                    object.Transparency = 1 - (1 - state.Original) * factor
                elseif state.Kind == "Sequence" then
                    object.Transparency = crucifixFadedSequence(state.Original, factor)
                elseif state.Kind == "Brightness" then
                    object.Brightness = state.Original * factor
                elseif state.Kind == "Highlight" then
                    object.FillTransparency = 1 - (1 - state.Fill) * factor
                    object.OutlineTransparency = 1 - (1 - state.Outline) * factor
                elseif state.Kind == "Smoke" then
                    object.Opacity = state.Original * factor
                elseif state.Kind == "Fire" then
                    object.Size = state.Size * factor
                    object.Heat = state.Heat * factor
                elseif state.Kind == "Sound" then
                    object.Volume = state.Original * factor
                elseif state.Kind == "GuiObject" then
                    object.BackgroundTransparency = 1 - (1 - state.Background) * factor

                    if state.Image ~= nil then
                        object.ImageTransparency = 1 - (1 - state.Image) * factor
                    end

                    if state.Text ~= nil then
                        object.TextTransparency = 1 - (1 - state.Text) * factor
                    end
                end
            end
        end
    end

    local function fadeCrucifixVisuals(states, initialFactor, endFactor, duration)
        if duration <= 0 then
            setCrucifixVisualFactor(states, endFactor)
            return
        end

        local startTime = os.clock()

        while true do
            local alpha = math.clamp((os.clock() - startTime) / duration, 0, 1)
            local eased = easeCease(alpha)
            setCrucifixVisualFactor(
                states,
                initialFactor + (endFactor - initialFactor) * eased
            )

            if alpha >= 1 then
                break
            end

            RunService.Heartbeat:Wait()
        end
    end

    local function findCrucifixBeams(rushNew)
        local preferred = {}
        local fallback = {}

        for _, descendant in ipairs(rushNew:GetDescendants()) do
            if descendant:IsA("Beam") then
                table.insert(fallback, descendant)

                local ancestor = descendant.Parent
                while ancestor and ancestor ~= rushNew do
                    if string.lower(ancestor.Name) == "particlesin" then
                        table.insert(preferred, descendant)
                        break
                    end
                    ancestor = ancestor.Parent
                end

                if string.lower(descendant.Name) == "particlesin" then
                    local exists = false
                    for _, selected in ipairs(preferred) do
                        if selected == descendant then
                            exists = true
                            break
                        end
                    end
                    if not exists then
                        table.insert(preferred, descendant)
                    end
                end
            end
        end

        local beams = #preferred > 0 and preferred or fallback
        table.sort(beams, function(a, b)
            return a:GetFullName() < b:GetFullName()
        end)

        return beams
    end

    local function prepareCrucifixBeams(beams, rushNew, movingAttachment)
        for index, beam in ipairs(beams) do
            if beam.Parent then
                if not beam.Attachment0 then
                    beam.Attachment0 = movingAttachment
                end

                if not beam.Attachment1 or beam.Attachment1 == beam.Attachment0 then
                    local endpoint = Instance.new("Attachment")
                    endpoint.Name = "CrucifixBeamEndpoint" .. tostring(index)
                    local angle = (index - 1) * (math.pi / 2)
                    local offset = Vector3.new(
                        math.cos(angle) * 3,
                        2,
                        math.sin(angle) * 3
                    )
                    endpoint.Position = movingAttachment.Position
                        + rushNew.CFrame:VectorToObjectSpace(offset)
                    endpoint.Parent = rushNew
                    beam.Attachment1 = endpoint
                end

                if beam.Width0 <= 0 and beam.Width1 <= 0 then
                    beam.Width0 = 0.3
                    beam.Width1 = 0.3
                end

                beam.Enabled = true
                beam.Transparency = NumberSequence.new(1)
            end
        end
    end

    local crucifixBeamSoundIds = {
        "124444290902740",
        "100133789671771",
        "133850299035625",
        "120232105146350"
    }

    local function createCrucifixBeamFeedback()
        local beamCameraShaker = nil
        local shakeCleanupScheduled = false

        local function trigger(index)
            local soundId = crucifixBeamSoundIds[index]
            if not soundId then
                return
            end

            local sound = Instance.new("Sound")
            sound.Name = "CrucifixBeamSound" .. tostring(index)
            sound.SoundId = "rbxassetid://" .. soundId
            sound.Volume = 7
            sound.Looped = false
            sound.Parent = game:GetService("SoundService")
            sound.Ended:Connect(function()
                if sound.Parent then
                    sound:Destroy()
                end
            end)
            task.delay(60, function()
                if sound.Parent then
                    sound:Destroy()
                end
            end)
            sound:Play()

            if not beamCameraShaker then
                local module = game.ReplicatedStorage:FindFirstChild("CameraShaker")
                if module then
                    local loaded, CameraShaker = pcall(require, module)
                    if loaded and CameraShaker then
                        local created, shaker = pcall(function()
                            local currentShaker = CameraShaker.new(
                                Enum.RenderPriority.Camera.Value,
                                function(shakeCf)
                                    local camera = workspace.CurrentCamera
                                    if camera then
                                        camera.CFrame = camera.CFrame * shakeCf
                                    end
                                end
                            )
                            currentShaker:Start()
                            return currentShaker
                        end)
                        if created then
                            beamCameraShaker = shaker
                        end
                    end
                end
            end

            if beamCameraShaker then
                local started, shakeInstance = pcall(function()
                    return beamCameraShaker:StartShake(10, 28, 0.1, 0.25, 0.35)
                end)
                if started and shakeInstance then
                    task.delay(0.3, function()
                        pcall(function()
                            shakeInstance:StartFadeOut(3)
                        end)
                    end)
                else
                    pcall(function()
                        beamCameraShaker:ShakeOnce(10, 28, 0.1, 3, 0.25, 0.35)
                    end)
                end

                if not shakeCleanupScheduled then
                    shakeCleanupScheduled = true
                    task.delay(4.5, function()
                        if beamCameraShaker then
                            pcall(function()
                                beamCameraShaker:Stop()
                            end)
                        end
                    end)
                end
            end
        end

        return trigger
    end

    local function revealCrucifixBeams(beams, onBeamBegin)
        local startTime = os.clock()
        local perBeamDuration = 0.5
        local staggerDelay = 0.25
        local totalDuration = perBeamDuration + math.max(0, #beams - 1) * staggerDelay
        local begun = {}

        while true do
            local elapsed = os.clock() - startTime

            for index, beam in ipairs(beams) do
                if beam and beam.Parent then
                    local beamStartTime = (index - 1) * staggerDelay
                    if elapsed >= beamStartTime and not begun[index] then
                        begun[index] = true
                        if onBeamBegin then
                            onBeamBegin(index)
                        end
                    end

                    local beamAlpha = math.clamp(
                        (elapsed - beamStartTime) / perBeamDuration,
                        0,
                        1
                    )
                    beam.Enabled = true
                    beam.Transparency = NumberSequence.new(1 - easeCease(beamAlpha))
                end
            end

            if elapsed >= totalDuration then
                break
            end
            RunService.Heartbeat:Wait()
        end

        for _, beam in ipairs(beams) do
            if beam and beam.Parent then
                beam.Enabled = true
                beam.Transparency = NumberSequence.new(0)
            end
        end
    end

    local function fadeCrucifixBeamsOut(beams, duration)
        local startTime = os.clock()

        while true do
            local alpha = math.clamp((os.clock() - startTime) / duration, 0, 1)
            local transparency = easeCease(alpha)

            for _, beam in ipairs(beams) do
                if beam and beam.Parent then
                    beam.Transparency = NumberSequence.new(transparency)
                end
            end

            if alpha >= 1 then
                break
            end
            RunService.Heartbeat:Wait()
        end

        for _, beam in ipairs(beams) do
            if beam and beam.Parent then
                beam.Transparency = NumberSequence.new(1)
                beam.Enabled = false
            end
        end
    end

    local function moveCrucifixAttachment(attachment, targetPosition, duration)
        local origin = attachment.Position
        local startTime = os.clock()

        while true do
            if not attachment.Parent then
                return false
            end

            local alpha = math.clamp((os.clock() - startTime) / duration, 0, 1)
            local progress = easeCease(alpha)
            attachment.Position = origin:Lerp(targetPosition, progress)

            if alpha >= 1 then
                attachment.Position = targetPosition
                return true
            end
            RunService.Heartbeat:Wait()
        end
    end

    local function fadeCrucifixDescendantsRecursively(root, duration)
        local found = {}
        local allStates = {}
        local stateCount = 0

        local function findChildren(object)
            if not object or found[object] then
                return
            end
            found[object] = true

            local states = getCrucifixVisualStates(object, nil, true)
            for _, state in ipairs(states) do
                table.insert(allStates, state)
                stateCount = stateCount + 1
            end

            for _, child in ipairs(object:GetChildren()) do
                findChildren(child)
            end
        end

        local startTime = os.clock()
        while true do
            if not root.Parent then
                return
            end

            findChildren(root)
            local alpha = math.clamp((os.clock() - startTime) / duration, 0, 1)
            setCrucifixVisualFactor(allStates, 1 - easeCease(alpha))

            if alpha >= 1 then
                break
            end

            for _, object in ipairs(root:GetDescendants()) do
                if not found[object] then
                    findChildren(object)
                end
            end
            RunService.Heartbeat:Wait()
        end
    end

    local function startCrucifixAmbientShake(replacement)
        local stepName = "RipperCrucifixAmbient_"
            .. game:GetService("HttpService"):GenerateGUID(false)
        local startedAt = os.clock()
        local active = true
        local lastOffset = CFrame.new()
        local lastCamera = nil

        local function stop()
            if not active then
                return
            end
            active = false
            RunService:UnbindFromRenderStep(stepName)
        end

        RunService:BindToRenderStep(
            stepName,
            Enum.RenderPriority.Camera.Value + 3,
            function()
                if not replacement.Parent then
                    stop()
                    return
                end

                local camera = workspace.CurrentCamera
                if not camera then
                    return
                end

                if lastCamera ~= camera then
                    lastCamera = camera
                    lastOffset = CFrame.new()
                end

                local elapsed = os.clock() - startedAt
                local strength = easeCease(math.clamp(elapsed / 0.5, 0, 1))
                local offset = CFrame.new(
                    math.sin(elapsed * 13) * 0.055 * strength,
                    math.sin(elapsed * 16 + 0.7) * 0.04 * strength,
                    0
                ) * CFrame.Angles(
                    math.sin(elapsed * 12) * math.rad(0.085) * strength,
                    math.sin(elapsed * 10 + 1.1) * math.rad(0.065) * strength,
                    0
                )

                camera.CFrame = camera.CFrame * lastOffset:Inverse() * offset
                lastOffset = offset
            end
        )

        return stop
    end

    local function runCrucifixReplacement(originalCFrame)

        local loadedSuccessfully, replacement = pcall(function()
            return game:GetObjects("rbxassetid://110448913076205")[1]
        end)

        if not loadedSuccessfully or not replacement then

            return
        end

        local targetCFrame = originalCFrame + Vector3.new(0, 0, 0)
        local bro = replacement.Name == "BRO" and replacement
            or replacement:FindFirstChild("BRO", true)

        local placed, placementError = pcall(function()
            if replacement:IsA("Model") then
                if bro and bro:IsA("Model") then
                    local pivotShift = targetCFrame * bro:GetPivot():Inverse()
                    replacement:PivotTo(pivotShift * replacement:GetPivot())
                else
                    replacement:PivotTo(targetCFrame)
                end
            elseif bro and bro:IsA("Model") then
                bro:PivotTo(targetCFrame)
            elseif replacement:IsA("BasePart") then
                replacement.CFrame = targetCFrame
            end

            for _, descendant in ipairs(replacement:GetDescendants()) do
                if descendant:IsA("BasePart") then
                    descendant.Anchored = true
                    descendant.CanCollide = false
                    descendant.CanTouch = false
                end
            end

            if replacement:IsA("BasePart") then
                replacement.Anchored = true
                replacement.CanCollide = false
                replacement.CanTouch = false
            end

            replacement.Parent = workspace
        end)

        if not placed then

            replacement:Destroy()
            return
        end

        local stopAmbientShake = startCrucifixAmbientShake(replacement)
        task.delay(30, function()
            stopAmbientShake()
            if replacement and replacement.Parent then
                replacement:Destroy()
            end
        end)

        local animationOK, animationError = xpcall(function()
            local rushNew = bro and bro:FindFirstChild("RushNew", true)
            local attachment = rushNew and rushNew:FindFirstChild("Attachment", true)
            if attachment and not attachment:IsA("Attachment") then
                attachment = nil
            end
            if not rushNew then

            elseif not attachment then

            else

            end

            task.wait(2.3)
            if not replacement.Parent then
                return
            end

            if rushNew and rushNew:IsA("BasePart") and attachment then
                local beams = findCrucifixBeams(rushNew)
                local introStates = getCrucifixVisualStates(attachment, function(object)
                    if not object:IsA("Beam") then
                        return true
                    end
                    for _, beam in ipairs(beams) do
                        if object == beam then
                            return false
                        end
                    end
                    return true
                end)

                setCrucifixVisualFactor(introStates, 0)
                prepareCrucifixBeams(beams, rushNew, attachment)

                local originalPosition = attachment.Position
                local upOffset = rushNew.CFrame:VectorToObjectSpace(Vector3.new(0, 3, 0))
                local downOffset = rushNew.CFrame:VectorToObjectSpace(Vector3.new(0, -20, 0))
                local upPosition = originalPosition + upOffset
                local downPosition = upPosition + downOffset

                task.spawn(function()
                    if attachment.Parent then
                        fadeCrucifixVisuals(introStates, 0, 1, 0.6)
                    end
                end)

                local beamsRevealFinished = #beams == 0
                if not beamsRevealFinished then
                    local playBeamFeedback = createCrucifixBeamFeedback()
                    task.spawn(function()
                        task.wait(0.8)
                        if replacement.Parent and attachment.Parent then
                            pcall(revealCrucifixBeams, beams, playBeamFeedback)
                        end
                        beamsRevealFinished = true
                    end)
                end

                if not moveCrucifixAttachment(attachment, upPosition, 1.8) then
                end

                while not beamsRevealFinished and replacement.Parent and attachment.Parent do
                    RunService.Heartbeat:Wait()
                end

                if not moveCrucifixAttachment(attachment, downPosition, 1.2) then
                end
                task.wait(2)
                fadeCrucifixBeamsOut(beams, 0.5)
            end
        end, function(err)
            return tostring(err) .. "\n" .. debug.traceback()
        end)

        if not animationOK then

        end
        local fadeOK, fadeError = pcall(function()
            fadeCrucifixDescendantsRecursively(replacement, 1)
        end)
        if not fadeOK then

        end
        if replacement.Parent then
            for _, descendant in ipairs(replacement:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam")
                    or descendant:IsA("Trail") or descendant:IsA("Sparkles")
                    or descendant:IsA("Smoke") or descendant:IsA("Fire") then
                    pcall(function()
                        descendant.Enabled = false
                    end)
                end
            end
        end
        task.wait(3)
        stopAmbientShake()
        if replacement then

            replacement:Destroy()
        end
    end

    local function tryUseCrucifix(character, source)
        if crucifixActivated or isJumpScaring or not ripper or not ripper.Parent
            or not character or character:GetAttribute("Hiding") then
            return false
        end

        local characterHumanoid = character:FindFirstChildWhichIsA("Humanoid")
        if not characterHumanoid or characterHumanoid.Health <= 0 then
            return false
        end

        local crucifixTool = getCrucifixTool(character)
        if not crucifixTool then
            return false
        end


        crucifixActivated = true
        local lastRipperCFrame = ripper.CFrame
        local player = Players:GetPlayerFromCharacter(character)

        StopRipperMovement()
        isRipperDespawning = true

        crucifixTool:Destroy()

        if backgroundSound and backgroundSound.Parent then
            backgroundSound:Stop()
        end

        if ripper and ripper.Parent then
            ripper:Destroy()
        end

        if ripperAsset then
            ripperAsset:Destroy()
        end

        ripper = nil
        ripperAsset = nil
        task.spawn(runCrucifixReplacement, lastRipperCFrame)
        return true
    end

    local function scanPlayerCrucifixRaycasts()
        if crucifixActivated or isJumpScaring or isRipperDespawning
            or not ripper or not ripper.Parent then
            return false
        end

        local currentRipper = ripper
        local raycastParams = RaycastParams.new()
        raycastParams.FilterType = Enum.RaycastFilterType.Exclude
        raycastParams.FilterDescendantsInstances = { currentRipper }

        local function getCharacterRayTargets(character)
            local targets = {}
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if rootPart and rootPart:IsA("BasePart") then
                table.insert(targets, rootPart)
            end
            for _, partName in ipairs({ "Head", "UpperTorso", "Torso", "LowerTorso" }) do
                local bodyPart = character:FindFirstChild(partName)
                if bodyPart and bodyPart:IsA("BasePart") then
                    table.insert(targets, bodyPart)
                end
            end
            return targets
        end

        local allPlayers = Players:GetPlayers()


        for _, candidatePlayer in ipairs(allPlayers) do
            if crucifixActivated or not currentRipper.Parent then
                return crucifixActivated
            end

            local character = candidatePlayer.Character
            if not character then

            elseif not character:IsDescendantOf(workspace) then

            elseif character:GetAttribute("Hiding") then

            else
                local humanoid = character:FindFirstChildWhichIsA("Humanoid")
                local rootPart = character:FindFirstChild("HumanoidRootPart")
                if not humanoid or humanoid.Health <= 0 then

                elseif not rootPart or not rootPart:IsA("BasePart") then

                else
                    for _, targetPart in ipairs(getCharacterRayTargets(character)) do
                        if crucifixActivated or not currentRipper.Parent then
                            return crucifixActivated
                        end

                        local direction = targetPart.Position - currentRipper.Position
                        local distance = direction.Magnitude
                        if distance > 0.001 and distance <= 50 then
                            local result = workspace:Raycast(currentRipper.Position, direction, raycastParams)
                            local hitPart = result and result.Instance
                            local hitCharacter = hitPart and getCharacterFromRaycastHit(hitPart) or nil

                            if not hitCharacter then
                                local partEntry = rayEntryDistanceToPart(
                                    currentRipper.Position, direction.Unit, targetPart)
                                if partEntry and partEntry <= distance + 0.01 then
                                    if not result or result.Distance > partEntry + 0.02 then
                                        hitCharacter = character
                                    end
                                end
                            end

                            if hitCharacter then
                                if not hitCharacter:GetAttribute("Hiding") then
                                    local hitHumanoid = hitCharacter:FindFirstChildWhichIsA("Humanoid")
                                    if hitHumanoid and hitHumanoid.Health > 0 then
                                        local tool = getCrucifixTool(hitCharacter)
                                        if tool then

                                            if tryUseCrucifix(hitCharacter,
                                                "PLAYER") then
                                                return true
                                            end

                                        end
                                    end
                                end
                            end
                        end
                    end

                end
            end
        end
        return false
    end

    local function TriggerRipperJumpScare(
        currentRipper,
        playerChar,
        snapshottedRipperPosition
    )
        if isJumpScaring or crucifixActivated then
            return
        end

        if tryUseCrucifix(playerChar, "JIMP") then
            return
        end

        StopRipperMovement()
        isJumpScaring = true
        local currentRipperAsset = ripperAsset

        local player = Players:GetPlayerFromCharacter(playerChar)

        if not player then
            isJumpScaring = false
            return
        end

        local playerGui = player:FindFirstChild("PlayerGui")

        if not playerGui then
            playerGui = player:WaitForChild("PlayerGui", 5)
        end

        local camera = workspace.CurrentCamera
        local rootPart = playerChar:FindFirstChild("HumanoidRootPart")
        local humanoid = playerChar:FindFirstChildWhichIsA("Humanoid")

        if not playerGui or not camera or not rootPart or not humanoid then
            isJumpScaring = false
            return
        end

        local function prepareRipperObject(object)
            if not object then
                return
            end

            local ripe = object:FindFirstChild("ripe", true)

            if ripe then
                local face1 = ripe:FindFirstChild("Face1", true)

                if face1 then
                    if face1:IsA("Decal") or face1:IsA("Texture") then
                        face1.Texture = "rbxassetid://11816152645"
                    elseif face1:IsA("ImageLabel") or face1:IsA("ImageButton") then
                        face1.Image = "rbxassetid://11816152645"
                    end
                end
            end

            for _, desc in ipairs(object:GetDescendants()) do
                if desc:IsA("ParticleEmitter") then
                    desc.Rate = 9999
                    task.delay(0.25, function()
                        if desc and desc.Parent then
                            desc.TimeScale = 0
                        end
                    end)
                elseif desc:IsA("Sound") and string.lower(desc.Name) ~= "jumpscare" then
                    desc.Volume = 0
                end
            end
        end

        local function findJumpscareSound(object)
            if not object then
                return nil
            end

            for _, desc in ipairs(object:GetDescendants()) do
                if desc:IsA("Sound") and string.lower(desc.Name) == "jumpscare" then
                    return desc
                end
            end

            return nil
        end

        local jumpscareSource = findJumpscareSound(currentRipper)
            or findJumpscareSound(currentRipperAsset)
        local modelJumpscareSound = jumpscareSource and jumpscareSource:Clone() or nil

        if modelJumpscareSound then
            for _, desc in ipairs(modelJumpscareSound:GetDescendants()) do
                if desc:IsA("Sound") and string.lower(desc.Name) == "static" then
                    desc:Destroy()
                end
            end
        end

        prepareRipperObject(currentRipper)
        prepareRipperObject(currentRipperAsset)

        if modelJumpscareSound then
            modelJumpscareSound.Looped = false
            modelJumpscareSound.PlayOnRemove = false
            modelJumpscareSound.Parent = workspace
        end

        local noiseGui = Instance.new("ScreenGui")
        noiseGui.Name = "Noise"
        noiseGui.IgnoreGuiInset = true
        noiseGui.ResetOnSpawn = false
        noiseGui.Parent = playerGui

        local staticImg = Instance.new("ImageLabel")
        staticImg.Name = "ImageLabel"
        staticImg.BackgroundTransparency = 1
        staticImg.Size = UDim2.new(1, 0, 1, 0)
        staticImg.Image = "rbxassetid://236542974"
        staticImg.ImageTransparency = 1
        staticImg.Parent = noiseGui

        local images = {
            8482795900,
            236542974,
            184251462,
            236777652
        }

        local noiseConnection = RunService.RenderStepped:Connect(function()
            if staticImg and staticImg.Parent then
                staticImg.Image = "rbxassetid://" .. tostring(images[math.random(1, #images)])
            end
        end)

        local screamSound = Instance.new("Sound")
        screamSound.SoundId = "rbxassetid://372770465"
        screamSound.Volume = 0
        screamSound.PlaybackSpeed = 0.7
        screamSound.Parent = workspace

        local cameraShakerModule = game.ReplicatedStorage:FindFirstChild("CameraShaker")
        local jumpScareCamShake = nil

        if cameraShakerModule then
            local success, CameraShaker = pcall(require, cameraShakerModule)

            if success and CameraShaker then
                jumpScareCamShake = CameraShaker.new(
                    Enum.RenderPriority.Camera.Value,
                    function(shakeCf)
                        if camera then
                            camera.CFrame = camera.CFrame * shakeCf
                        end
                    end
                )

                jumpScareCamShake:Start()
                jumpScareCamShake:ShakeOnce(8, 26, 0.03, 0.28, 0.3, 0.35)
            end
        end

        rootPart.Anchored = true

        local originalCameraType = camera.CameraType
        camera.CameraType = Enum.CameraType.Scriptable

        local targetPart = Instance.new("Part")
        targetPart.Transparency = 1
        targetPart.CanCollide = false
        targetPart.CanTouch = false
        targetPart.CanQuery = false
        targetPart.Anchored = true
        targetPart.Position = snapshottedRipperPosition
        targetPart.Parent = workspace

        local camFocus = Instance.new("Part")
        camFocus.Transparency = 1
        camFocus.CanCollide = false
        camFocus.CanTouch = false
        camFocus.CanQuery = false
        camFocus.Anchored = true
        camFocus.CFrame = camera.CFrame
        camFocus.Parent = workspace

        local turnTween = TweenService:Create(
            camFocus,
            TweenInfo.new(
                0.69,
                Enum.EasingStyle.Circular,
                Enum.EasingDirection.InOut
            ),
            {
                CFrame = CFrame.lookAt(
                    camFocus.Position,
                    targetPart.Position
                )
            }
        )

        local renderConnection

        renderConnection = RunService.RenderStepped:Connect(function()
            if camFocus and camFocus.Parent and camera then
                camera.CFrame = camFocus.CFrame
            elseif renderConnection then
                renderConnection:Disconnect()
            end
        end)

        turnTween:Play()
        turnTween.Completed:Wait()
        task.wait(0.3)

        if modelJumpscareSound and modelJumpscareSound.Parent then
            modelJumpscareSound:Play()
        end

        if modelJumpscareSound and modelJumpscareSound.Parent then
            local soundStartedAt = os.clock()

            repeat
                RunService.Heartbeat:Wait()
            until (os.clock() - soundStartedAt >= 0.25 and not modelJumpscareSound.IsPlaying)
                or os.clock() - soundStartedAt >= 6
        end

        screamSound:Play()

        TweenService:Create(
            screamSound,
            TweenInfo.new(3),
            {
                Volume = 10
            }
        ):Play()

        task.wait(1)

        TweenService:Create(
            staticImg,
            TweenInfo.new(2),
            {
                ImageTransparency = 0
            }
        ):Play()

        task.wait(3)

        if rootPart and rootPart.Parent then
            rootPart.Anchored = false
        end

        if humanoid and humanoid.Parent then
            local damage = 125

            if humanoid.Health <= damage then
                local gameStats = game.ReplicatedStorage:FindFirstChild("GameStats")

                if gameStats then
                    local playerStat = gameStats:FindFirstChild("Player_" .. player.Name)

                    if playerStat then
                        local total = playerStat:FindFirstChild("Total")

                        if total then
                            local deathCause = total:FindFirstChild("DeathCause")

                            if deathCause then
                                deathCause.Value = "Ripper"
                            end
                        end
                    end
                end
            end

            humanoid:TakeDamage(damage)
        end

        TweenService:Create(
            staticImg,
            TweenInfo.new(1),
            {
                ImageTransparency = 1
            }
        ):Play()

        TweenService:Create(
            screamSound,
            TweenInfo.new(1),
            {
                Volume = 0
            }
        ):Play()

        if renderConnection then
            renderConnection:Disconnect()
        end

        if noiseConnection then
            noiseConnection:Disconnect()
        end

        if jumpScareCamShake then
            pcall(function()
                jumpScareCamShake:Stop()
            end)
        end

        if camera then
            camera.CameraType = originalCameraType
        end

        if noiseGui then
            noiseGui:Destroy()
        end

        if targetPart then
            targetPart:Destroy()
        end

        if camFocus then
            camFocus:Destroy()
        end

        if screamSound then
            screamSound:Destroy()
        end

        if modelJumpscareSound then
            modelJumpscareSound:Destroy()
        end

        if currentRipper and currentRipper.Parent then
            currentRipper:Destroy()
        end

        if currentRipperAsset then
            currentRipperAsset:Destroy()
        end

        ripper = nil
        ripperAsset = nil
        isRipperDespawning = true

    end

    local function getOrderedRooms()
        local currentRooms =
            workspace:FindFirstChild("CurrentRooms")

        local orderedRooms = {}

        if not currentRooms then
            return orderedRooms
        end

        for _, room in ipairs(currentRooms:GetChildren()) do
            if room:IsA("Model") then
                local roomNumber = tonumber(room.Name)

                if roomNumber then
                    table.insert(
                        orderedRooms,
                        {
                            Number = roomNumber,
                            Room = room
                        }
                    )
                end
            end
        end

        table.sort(
            orderedRooms,
            function(a, b)
                return a.Number < b.Number
            end
        )

        return orderedRooms
    end

    local function getOrderedNodes(pathfindNodes)
        local orderedNodes = {}

        for _, node in ipairs(
            pathfindNodes:GetChildren()
        ) do
            if node:IsA("BasePart") then
                table.insert(orderedNodes, node)
            end
        end

        table.sort(
            orderedNodes,
            function(a, b)
                local numberA = tonumber(a.Name)
                local numberB = tonumber(b.Name)

                if numberA and numberB then
                    return numberA < numberB
                elseif numberA then
                    return true
                elseif numberB then
                    return false
                end

                return a.Name < b.Name
            end
        )

        return orderedNodes
    end

    local function moveRipperTo(targetCFrame, speedFactor)
        if isJumpScaring or crucifixActivated or isRipperDespawning
            or not ripper or not ripper.Parent then
            return false
        end

        local movingRipper = ripper
        ripperMoveCancelled = false
        ripperIsMoving = true

        local startCFrame = movingRipper.CFrame
        local totalDistance = (startCFrame.Position - targetCFrame.Position).Magnitude
        local travelled = 0

        while not ripperMoveCancelled and not isJumpScaring
            and not crucifixActivated and not isRipperDespawning
            and ripper == movingRipper and movingRipper.Parent do
            local deltaTime = RunService.Heartbeat:Wait()

            if ripperMoveCancelled or isJumpScaring or crucifixActivated
                or isRipperDespawning or ripper ~= movingRipper
                or not movingRipper.Parent then
                break
            end

            if totalDistance > 0.001 and travelled < totalDistance then
                travelled = math.min(
                    travelled + math.max(speedFactor, 0) * ceaseSpeedScale * math.min(deltaTime, 0.1),
                    totalDistance
                )
                movingRipper.CFrame = startCFrame:Lerp(targetCFrame, travelled / totalDistance)
            else
                movingRipper.CFrame = targetCFrame
                travelled = totalDistance
            end

            if travelled >= totalDistance and not ceaseFreezeActive then
                ripperIsMoving = false
                return true
            end
        end

        ripperIsMoving = false
        return false
    end

    local function ExecuteRipperPathfinding()
        if isRipperProtectedArea() then
            return
        end
        isRipperDespawning = false
        local RIPPER_MODEL_ID = "107119131634727"

        local success, loadedAsset = pcall(function()
            return game:GetObjects(
                "rbxassetid://" .. RIPPER_MODEL_ID
            )[1]
        end)

        if not success or not loadedAsset then
            ripperAsset = nil
            return
        end

        if isRipperProtectedArea() then
            loadedAsset:Destroy()
            return
        end

        ripperAsset = loadedAsset

        local basePart =
            ripperAsset:FindFirstChildWhichIsA(
                "BasePart",
                true
            )

        if not basePart then
            ripperAsset:Destroy()
            ripperAsset = nil
            return
        end

        ripper = basePart:Clone()
        ripper.Anchored = true
        ripper.CanQuery = true
        ripper.Parent = workspace

        local protectedWatcherRipper = ripper
        task.spawn(function()
            while protectedWatcherRipper.Parent
                and ripper == protectedWatcherRipper
                and not isJumpScaring
                and not crucifixActivated
                and not isRipperDespawning do
                if isRipperProtectedArea() then
                    StopRipperMovement()
                    isRipperDespawning = true
                    if backgroundSound and backgroundSound.Parent then
                        backgroundSound:Stop()
                    end
                    protectedWatcherRipper:Destroy()
                    if ripperAsset then
                        ripperAsset:Destroy()
                    end
                    if ripper == protectedWatcherRipper then
                        ripper = nil
                        ripperAsset = nil
                    end
                    return
                end
                task.wait(0.1)
            end
        end)

        local orderedRooms = getOrderedRooms()

        if #orderedRooms == 0 then
            ripper:Destroy()
            ripper = nil
            ripperAsset:Destroy()
            ripperAsset = nil
            return
        end

        local MAX_RIPPER_ROOMS = 10
        local startRoomIndex = 1

        if #orderedRooms > MAX_RIPPER_ROOMS then
            startRoomIndex = #orderedRooms - 8
        end

        local startRoom = orderedRooms[startRoomIndex].Room
        if startRoom.Name == "50" or isRipperProtectedArea() then
            ripper:Destroy()
            ripper = nil
            ripperAsset:Destroy()
            ripperAsset = nil
            return
        end
        local startNode = nil
        local startPathfindNodes =
            startRoom:FindFirstChild("PathfindNodes")

        if startPathfindNodes then
            local startNodes =
                getOrderedNodes(startPathfindNodes)

            startNode = startNodes[1]
        end

        if not startNode then
            startNode =
                startRoom:FindFirstChild("RoomExit")
        end

        if not startNode
            or not startNode:IsA("BasePart")
        then
            ripper:Destroy()
            ripper = nil
            ripperAsset:Destroy()
            ripperAsset = nil
            return
        end

        local heightOffset = Vector3.new(0, 1.3, 0)
        local speedFactor = 100

        ripper.CFrame =
            startNode.CFrame + heightOffset

        local cameraShaker = nil
        local cameraShakerModule =
            game.ReplicatedStorage:FindFirstChild(
                "CameraShaker"
            )

        if cameraShakerModule then
            local loaded, CameraShakerModule = pcall(require, cameraShakerModule)

            if loaded and CameraShakerModule then
                cameraShaker = CameraShakerModule.new(
                    Enum.RenderPriority.Camera.Value + 1,
                    function(shakerTransform)
                        local camera = workspace.CurrentCamera

                        if camera then
                            camera.CFrame = camera.CFrame * shakerTransform
                        end
                    end
                )

                cameraShaker:Start()

                local shakerRipper = ripper
                task.spawn(function()
                    while shakerRipper and shakerRipper.Parent do
                        task.wait(0.25)
                    end

                    if cameraShaker then
                        pcall(function()
                            cameraShaker:Stop()
                        end)
                    end
                end)
            end
        end

        task.spawn(function()
            while ripper and ripper.Parent and not isJumpScaring
                and not isRipperDespawning do
                if ripperIsMoving and not ceaseFreezeActive then
                    local ceaseModel = workspace:FindFirstChild("Cease", true)
                    if ceaseModel and ceaseModel:IsA("Model")
                        and not ceaseHandledModels[ceaseModel] then
                        startCeaseFreeze(ceaseModel)
                    end
                end
                task.wait(0.1)
            end

            if ceaseFreezeActive then
                cancelCeaseFreeze()
            end
        end)

        task.spawn(function()
            while ripper and ripper.Parent and not crucifixActivated
                and not isJumpScaring and not isRipperDespawning do
                if scanPlayerCrucifixRaycasts() then
                    return
                end
                task.wait(0.05)
            end
        end)

        local lastProximityShake = 0

        task.spawn(function()
            while ripper
                and ripper.Parent
                and not crucifixActivated
                and not isJumpScaring
                and not isRipperDespawning
            do
                RunService.RenderStepped:Wait()

                if crucifixActivated or isJumpScaring or isRipperDespawning
                    or not ripper or not ripper.Parent then
                    return
                end

                local visibleRipper = ripper
                local player = Players.LocalPlayer

                if player and player.Character then
                    local character = player.Character
                    local humanoid = character:FindFirstChildWhichIsA("Humanoid")
                    local rootPart = character:FindFirstChild("HumanoidRootPart")

                    if humanoid and rootPart and humanoid.Health > 0 then
                        local distance = (visibleRipper.Position - rootPart.Position).Magnitude

                        if distance <= 80
                            and cameraShaker
                            and os.clock() - lastProximityShake >= 0.12
                        then
                            local alpha = math.clamp(1 - distance / 80, 0, 1)
                            local amplitude = (0.3 + 8.2 * (alpha ^ 1.35)) * 3
                            local roughness = 45 + 35 * alpha
                            local positionInfluence = 0.35 + 0.4 * alpha
                            local rotationInfluence = 0.3 + 0.4 * alpha

                            cameraShaker:ShakeOnce(
                                amplitude,
                                roughness,
                                0.01,
                                0.16,
                                positionInfluence,
                                rotationInfluence
                            )

                            lastProximityShake = os.clock()
                        end

                        if distance <= 50 and not character:GetAttribute("Hiding") then
                            local raycastParams = RaycastParams.new()
                            raycastParams.FilterType = Enum.RaycastFilterType.Exclude
                            raycastParams.FilterDescendantsInstances = { visibleRipper }

                            local targets = { rootPart }
                            for _, name in ipairs({ "Head", "UpperTorso", "Torso", "LowerTorso" }) do
                                local bodyPart = character:FindFirstChild(name)
                                if bodyPart and bodyPart:IsA("BasePart") then
                                    table.insert(targets, bodyPart)
                                end
                            end

                            for _, targetPart in ipairs(targets) do
                                local direction = targetPart.Position - visibleRipper.Position
                                local rayDistance = direction.Magnitude

                                if rayDistance > 0.001 and rayDistance <= 50 then
                                    local raycastResult = workspace:Raycast(
                                        visibleRipper.Position,
                                        direction,
                                        raycastParams
                                    )
                                    local hitCharacter = raycastResult
                                        and getCharacterFromRaycastHit(raycastResult.Instance)

                                    if hitCharacter and hitCharacter ~= character then
                                        if tryUseCrucifix(hitCharacter, "NOSD") then
                                            return
                                        end
                                    end

                                    local hitsPlayer = hitCharacter == character

                                    if not hitsPlayer then
                                        local entryDistance = rayEntryDistanceToPart(
                                            visibleRipper.Position,
                                            direction.Unit,
                                            targetPart
                                        )
                                        if entryDistance
                                            and entryDistance <= rayDistance + 0.01
                                            and (not raycastResult
                                                or raycastResult.Distance > entryDistance + 0.02)
                                        then
                                            hitsPlayer = true
                                        end
                                    end

                                    if hitsPlayer then
                                        if tryUseCrucifix(character, "怪物射线命中玩家") then
                                            return
                                        end

                                        TriggerRipperJumpScare(
                                            visibleRipper,
                                            character,
                                            visibleRipper.Position
                                        )
                                        return
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end)

        local targetRoomIndex =
            math.max(1, #orderedRooms - 1)

        local reachedFinalRoom = false
        local completedRoomIndex = 0

        for roomIndex = startRoomIndex, targetRoomIndex do
            if isJumpScaring
                or crucifixActivated
                or isRipperDespawning
                or not ripper
                or not ripper.Parent
            then
                break
            end

            local roomData =
                orderedRooms[roomIndex]

            local room =
                roomData and roomData.Room

            if (room and room.Name == "50") or isRipperProtectedArea() then
                break
            end

            if not room or not room.Parent then
                local refreshDeadline =
                    os.clock() + 5

                repeat
                    task.wait(0.1)

                    orderedRooms =
                        getOrderedRooms()

                    roomData =
                        orderedRooms[roomIndex]

                    room =
                        roomData and roomData.Room
                until room
                    or os.clock()
                        >= refreshDeadline
                    or isJumpScaring
                    or crucifixActivated
                    or isRipperDespawning
                    or not ripper
                    or not ripper.Parent
            end

            if not room or not room.Parent then
                break
            end

            local roomCompleted = false
            local pathfindNodes =
                room:FindFirstChild(
                    "PathfindNodes"
                )

            if pathfindNodes then
                local orderedNodes =
                    getOrderedNodes(
                        pathfindNodes
                    )

                if #orderedNodes > 0 then
                    roomCompleted = true

                    for _, node in ipairs(
                        orderedNodes
                    ) do
                        if isJumpScaring
                            or crucifixActivated
                            or isRipperDespawning
                            or not ripper
                            or not ripper.Parent
                        then
                            roomCompleted = false
                            break
                        end

                        local moved =
                            moveRipperTo(
                                node.CFrame
                                    + heightOffset,
                                speedFactor
                            )

                        if not moved then
                            roomCompleted = false
                            break
                        end
                    end
                end
            end

            if not roomCompleted then
                local roomExit =
                    room:FindFirstChild(
                        "RoomExit"
                    )

                if roomExit
                    and roomExit:IsA(
                        "BasePart"
                    )
                then
                    roomCompleted =
                        moveRipperTo(
                            roomExit.CFrame
                                + heightOffset,
                            speedFactor
                        )
                end
            end

            if not roomCompleted then
                break
            end

            completedRoomIndex = roomIndex

            if roomIndex
                == targetRoomIndex
            then
                reachedFinalRoom = true
            end
        end


        if isJumpScaring
            or crucifixActivated
            or not ripper
            or not ripper.Parent
        then
            ripper = nil
            ripperAsset = nil
            return
        end

        if isJumpScaring then
            return
        end

        if not reachedFinalRoom
            or completedRoomIndex
                < targetRoomIndex
        then
            if ripper and ripper.Parent then
                ripper:Destroy()
            end

            if ripperAsset then
                ripperAsset:Destroy()
            end

            ripper = nil
            ripperAsset = nil
            return
        end

        isRipperDespawning = true
        local NEAR_EXPLOSION_DISTANCE = 80
        local FAR_EXPLOSION_DISTANCE = 220
        local SHAKE_MAX_DISTANCE = 350
        local MAX_EXPLOSION_SHAKE = 24

        local localPlayer = Players.LocalPlayer
        local playerRoot = nil

        if localPlayer and localPlayer.Character then
            playerRoot =
                localPlayer.Character:FindFirstChild(
                    "HumanoidRootPart"
                )
        end

        local ripperDistance = math.huge

        if playerRoot and ripper and ripper.Parent then
            ripperDistance =
                (
                    playerRoot.Position
                    - ripper.Position
                ).Magnitude
        end

        local rushNew = nil

        if ripper and ripper.Parent then
            if ripper.Name == "RushNew" then
                rushNew = ripper
            else
                rushNew =
                    ripper:FindFirstChild(
                        "RushNew",
                        true
                    )
            end
        end

        if not rushNew
            and ripperAsset
        then
            rushNew =
                ripperAsset:FindFirstChild(
                    "RushNew",
                    true
                )
        end

        local explodeSound = nil

        if ripperDistance
            <= NEAR_EXPLOSION_DISTANCE
        then
            local explosionSound =
                hardCoreSound and hardCoreSound:FindFirstChild("RipperExplosionSound")

            if explosionSound
                and explosionSound:IsA("Sound")
            then
                explodeSound = Instance.new("Sound")
                explodeSound.SoundId =
                    explosionSound.SoundId
                explodeSound.Volume = 5
                explodeSound.PlaybackSpeed =
                    explosionSound.PlaybackSpeed
                explodeSound.Parent = ripper
            end
        elseif ripperDistance
            <= FAR_EXPLOSION_DISTANCE
        then
            local despawn2 =
                rushNew
                and rushNew:FindFirstChild(
                    "Despawn2"
                )

            if despawn2
                and despawn2:IsA("Sound")
            then
                explodeSound = despawn2:Clone()
                explodeSound.Volume = 10
                explodeSound.Parent = ripper
            end
        else
            local despawn3 =
                rushNew
                and rushNew:FindFirstChild(
                    "Despawn3"
                )

            if despawn3
                and despawn3:IsA("Sound")
            then
                explodeSound = despawn3:Clone()
                explodeSound.Volume = 10
                explodeSound.Parent = ripper
            end
        end

        if not explodeSound then
            local explosionSound =
                hardCoreSound and hardCoreSound:FindFirstChild("RipperExplosionSound")

            if explosionSound
                and explosionSound:IsA("Sound")
            then
                explodeSound = Instance.new("Sound")
                explodeSound.SoundId =
                    explosionSound.SoundId
                explodeSound.Volume = 5
                explodeSound.PlaybackSpeed =
                    explosionSound.PlaybackSpeed
                explodeSound.Parent = ripper
            end
        end

        if explodeSound then
            explodeSound:Play()
        end

        local shakeAmplitude = 0

        if ripperDistance
            <= NEAR_EXPLOSION_DISTANCE
        then
            shakeAmplitude = MAX_EXPLOSION_SHAKE
        elseif ripperDistance
            < SHAKE_MAX_DISTANCE
        then
            local alpha =
                1
                - (
                    ripperDistance
                    - NEAR_EXPLOSION_DISTANCE
                )
                / (
                    SHAKE_MAX_DISTANCE
                    - NEAR_EXPLOSION_DISTANCE
                )

            shakeAmplitude =
                MAX_EXPLOSION_SHAKE
                * math.clamp(alpha, 0, 1)
        end

        if cameraShakerModule
            and shakeAmplitude > 0
        then
            local endExplosionCameraShaker =
                require(cameraShakerModule)

            local endExplosionCam =
                workspace.CurrentCamera

            local endExplosionCamShake =
                endExplosionCameraShaker.new(
                    Enum.RenderPriority.Camera.Value,
                    function(shakeCf)
                        if endExplosionCam then
                            endExplosionCam.CFrame =
                                endExplosionCam.CFrame
                                * shakeCf
                        end
                    end
                )

            endExplosionCamShake:Start()

            endExplosionCamShake:ShakeOnce(
                shakeAmplitude,
                28,
                0.03,
                0.4,
                0.25,
                0.35
            )

            task.delay(1, function()
                pcall(function()
                    endExplosionCamShake:Stop()
                end)
            end)
        end

        task.wait(1)


        for _, playerToCheck in ipairs(Players:GetPlayers()) do
            local candidateCharacter = playerToCheck.Character
            if candidateCharacter and getCrucifixTool(candidateCharacter) then

                if tryUseCrucifix(candidateCharacter, "boom Hiding ") then
                    return
                end
            end
        end

        local finalRipperPosition = nil

        if ripper and ripper.Parent then
            finalRipperPosition = ripper.Position
            ripper.Anchored = false
            ripper.CanCollide = false
            ripper.CanTouch = false
            ripper.CanQuery = false
        end

        if isJumpScaring or not ripper or not ripper.Parent then
            return
        end

        local player = Players.LocalPlayer

        if player and player.Character then
            local character = player.Character
            local humanoid = character:FindFirstChildWhichIsA("Humanoid")

            if humanoid
                and humanoid.Health > 0
                and not character:GetAttribute("Hiding")
                and finalRipperPosition
            then
                TriggerRipperJumpScare(
                    ripper,
                    character,
                    finalRipperPosition
                )
                return
            end
        end

        local fallingRipper = ripper
        local fallingAsset = ripperAsset
        ripperAsset = nil

        task.delay(10, function()
            if fallingRipper and fallingRipper.Parent then
                fallingRipper:Destroy()
            end

            if fallingAsset then
                fallingAsset:Destroy()
            end

            if ripper == fallingRipper then
                ripper = nil
            end

            if ripperAsset == fallingAsset then
                ripperAsset = nil
            end
        end)
    end

    task.spawn(function()
        task.wait(7)
        if isRipperProtectedArea() then
            if backgroundSound and backgroundSound.Parent then
                backgroundSound:Stop()
            end
            return
        end
        ExecuteRipperPathfinding()
    end)

    local function runFinalCameraShake()
        local cameraShakerModule =
            game.ReplicatedStorage:FindFirstChild(
                "CameraShaker"
            )

        if not cameraShakerModule then
            return
        end

        local CameraShaker =
            require(cameraShakerModule)

        local camera =
            workspace.CurrentCamera

        local camShake =
            CameraShaker.new(
                Enum.RenderPriority.Camera.Value,
                function(shakeCf)
                    if camera then
                        camera.CFrame =
                            camera.CFrame
                            * shakeCf
                    end
                end
            )

        camShake:Start()

        camShake:ShakeOnce(
            10,
            200,
            0.1,
            6,
            2,
            0.5
        )

        task.delay(7, function()
            pcall(function()
                camShake:Stop()
            end)
        end)
    end
    if not isRipperProtectedArea() then
        runFinalCameraShake()
    end
            end
        end)

        task.spawn(function()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer

local function spawnShocker()
    local character = player.Character or player.CharacterAdded:Wait()
    local camera = Workspace.CurrentCamera

    while not camera do
        task.wait()
        camera = Workspace.CurrentCamera
    end

    local success, objects = pcall(function()
        return game:GetObjects("rbxassetid://140037062004703")
    end)

    if not success or not objects or not objects[1] then
        return
    end

    local shockerModel = objects[1]

    local rootPart = shockerModel:FindFirstChild("HumanoidRootPart", true)

    if not rootPart or not rootPart:IsA("BasePart") then
        rootPart = shockerModel:FindFirstChildWhichIsA("BasePart", true)
    end

    if not rootPart then
        shockerModel:Destroy()
        return
    end

    shockerModel.PrimaryPart = rootPart

    for _, object in ipairs(shockerModel:GetDescendants()) do
        if object:IsA("BasePart") then
            object.Anchored = true
            object.CanCollide = false
        end
    end

    shockerModel.Parent = Workspace

    local followOffset = CFrame.new(0, -0.7, -18)

    shockerModel:PivotTo(camera.CFrame * followOffset)

    local base = shockerModel:FindFirstChild("Base", true) or rootPart
    local playSound = base:FindFirstChild("PlaySound", true)

    local oogaBoogaaPart = shockerModel:FindFirstChild("OOGA BOOGAAAA", true) or base

    local horrorScream = oogaBoogaaPart:FindFirstChild("HORROR SCREAM 15", true)

    if not horrorScream then
        horrorScream = shockerModel:FindFirstChild("HORROR SCREAM 15", true)
    end

    local ceaseFreezeActive = false
    local ceaseSpeedScale = 1
    local ceaseFreezeSerial = 0
    local ceaseSavedEffects = {}
    local ceaseDescendantConnection = nil
    local ceaseHandledModels = setmetatable({}, { __mode = "k" })
    local shockerMoving = false
    local shockerFinished = false

    local function ceaseEase(alpha)
        alpha = math.clamp(alpha, 0, 1)
        return alpha * alpha * (3 - 2 * alpha)
    end

    local function applyCeaseSpeed(scale)
        ceaseSpeedScale = math.clamp(scale, 0, 1)

        for object, saved in pairs(ceaseSavedEffects) do
            if object.Parent then
                if saved.Type == "Particle" then
                    pcall(function()
                        object.TimeScale = saved.TimeScale * ceaseSpeedScale
                    end)
                else
                    pcall(function()
                        object.PlaybackSpeed = saved.PlaybackSpeed * ceaseSpeedScale
                        object.Volume = saved.Volume * ceaseSpeedScale
                    end)
                end
            end
        end
    end

    local function trackCeaseEffect(object)
        if ceaseSavedEffects[object] then
            return
        end

        if object:IsA("ParticleEmitter") then
            ceaseSavedEffects[object] = {
                Type = "Particle",
                TimeScale = object.TimeScale
            }
        elseif object:IsA("Sound") then
            ceaseSavedEffects[object] = {
                Type = "Sound",
                PlaybackSpeed = object.PlaybackSpeed,
                Volume = object.Volume
            }
        else
            return
        end

        if ceaseFreezeActive then
            local saved = ceaseSavedEffects[object]
            if saved.Type == "Particle" then
                pcall(function()
                    object.TimeScale = saved.TimeScale * ceaseSpeedScale
                end)
            else
                pcall(function()
                    object.PlaybackSpeed = saved.PlaybackSpeed * ceaseSpeedScale
                    object.Volume = saved.Volume * ceaseSpeedScale
                end)
            end
        end
    end

    local function setShockerSoundSpeed(sound, speed)
        if not sound or not sound.Parent then
            return
        end

        local saved = ceaseSavedEffects[sound]
        if saved and saved.Type == "Sound" then
            saved.PlaybackSpeed = speed
            sound.PlaybackSpeed = speed * ceaseSpeedScale
        else
            sound.PlaybackSpeed = speed
        end
    end

    local function cancelCeaseFreeze()
        ceaseFreezeSerial = ceaseFreezeSerial + 1

        if ceaseDescendantConnection then
            ceaseDescendantConnection:Disconnect()
            ceaseDescendantConnection = nil
        end

        for object, saved in pairs(ceaseSavedEffects) do
            if object.Parent then
                if saved.Type == "Particle" then
                    pcall(function()
                        object.TimeScale = saved.TimeScale
                    end)
                else
                    pcall(function()
                        object.PlaybackSpeed = saved.PlaybackSpeed
                        object.Volume = saved.Volume
                    end)
                end
            end
        end

        ceaseSavedEffects = {}
        ceaseSpeedScale = 1
        ceaseFreezeActive = false
    end

    local function startCeaseFreeze(ceaseModel)
        if ceaseFreezeActive or not shockerMoving or shockerFinished
            or not shockerModel.Parent or ceaseHandledModels[ceaseModel] then
            return
        end

        ceaseHandledModels[ceaseModel] = true
        ceaseFreezeActive = true
        ceaseFreezeSerial = ceaseFreezeSerial + 1
        local freezeSerial = ceaseFreezeSerial

        for _, descendant in ipairs(shockerModel:GetDescendants()) do
            trackCeaseEffect(descendant)
        end

        ceaseDescendantConnection = shockerModel.DescendantAdded:Connect(function(descendant)
            if ceaseFreezeSerial == freezeSerial and ceaseFreezeActive then
                trackCeaseEffect(descendant)
            end
        end)

        task.spawn(function()
            local function stillValid()
                return ceaseFreezeSerial == freezeSerial
                    and not shockerFinished
                    and shockerModel.Parent ~= nil
            end

            local function transition(fromScale, toScale, duration)
                local startedAt = os.clock()
                while true do
                    if not stillValid() then
                        if ceaseFreezeSerial == freezeSerial then
                            cancelCeaseFreeze()
                        end
                        return false
                    end

                    local alpha = math.clamp((os.clock() - startedAt) / duration, 0, 1)
                    local eased = ceaseEase(alpha)
                    applyCeaseSpeed(fromScale + (toScale - fromScale) * eased)

                    if alpha >= 1 then
                        return true
                    end

                    RunService.Heartbeat:Wait()
                end
            end

            if not transition(1, 0, 2.25) then
                return
            end

            local holdStartedAt = os.clock()
            while os.clock() - holdStartedAt < 13 do
                if not stillValid() then
                    if ceaseFreezeSerial == freezeSerial then
                        cancelCeaseFreeze()
                    end
                    return
                end
                task.wait(0.05)
            end

            if not transition(0, 1, 2) then
                return
            end

            if ceaseFreezeSerial == freezeSerial then
                cancelCeaseFreeze()
            end
        end)
    end

    task.spawn(function()
        while shockerModel.Parent and not shockerFinished do
            if shockerMoving and not ceaseFreezeActive then
                local ceaseModel = Workspace:FindFirstChild("Cease", true)
                if ceaseModel and ceaseModel:IsA("Model")
                    and not ceaseHandledModels[ceaseModel] then
                    startCeaseFreeze(ceaseModel)
                end
            end
            task.wait(0.1)
        end

        if ceaseFreezeActive then
            cancelCeaseFreeze()
        end
    end)

    local function waitShockerTime(duration)
        local elapsed = 0
        while elapsed < duration do
            if not shockerModel.Parent then
                return false
            end
            local dt = RunService.Heartbeat:Wait()
            elapsed = elapsed + math.min(dt, 0.1) * ceaseSpeedScale
        end
        return shockerModel.Parent ~= nil
    end

    local face2Emitters = {}
    local originalFaceRates = {}

    for _, object in ipairs(shockerModel:GetDescendants()) do
        if object.Name == "FACE2" and object:IsA("ParticleEmitter") then
            table.insert(face2Emitters, object)
            originalFaceRates[object] = object.Rate
            object.Enabled = false
            object:Clear()
        end
    end

    local function setFaceVisible(enabled)
        for _, emitter in ipairs(face2Emitters) do
            if emitter.Parent and emitter:IsDescendantOf(shockerModel) then
                if enabled then
                    if emitter.Rate <= 0 then
                        emitter.Rate = 18
                    end

                    emitter.Enabled = true
                    emitter:Emit(20)
                else
                    emitter.Enabled = false
                    emitter.Rate = originalFaceRates[emitter] or 0
                    emitter:Clear()
                end
            end
        end
    end

    setFaceVisible(false)

    if playSound and playSound:IsA("Sound") then
        setShockerSoundSpeed(playSound, 0.9)
        playSound:Play()
    end

    local function tweenModelTo(targetCFrame, duration, easingStyle, easingDirection)
        if not shockerModel.Parent then
            return false
        end

        local startingCFrame = shockerModel:GetPivot()
        local elapsed = 0
        shockerMoving = true

        while elapsed < duration do
            if not shockerModel.Parent then
                shockerMoving = false
                return false
            end

            local deltaTime = RunService.RenderStepped:Wait()
            elapsed = math.min(duration, elapsed + math.min(deltaTime, 0.1) * ceaseSpeedScale)
            local alpha = math.clamp(elapsed / duration, 0, 1)
            local eased = TweenService:GetValue(
                alpha,
                easingStyle or Enum.EasingStyle.Exponential,
                easingDirection or Enum.EasingDirection.Out
            )
            shockerModel:PivotTo(startingCFrame:Lerp(targetCFrame, eased))
        end

        shockerMoving = false
        return shockerModel.Parent ~= nil
    end

    local lookElapsed = 0
    shockerMoving = true

    while lookElapsed < 3 do
        local deltaTime = RunService.RenderStepped:Wait()

        if not shockerModel.Parent then
            return
        end

        camera = Workspace.CurrentCamera or camera
        lookElapsed = math.min(3, lookElapsed + math.min(deltaTime, 0.1) * ceaseSpeedScale)
        local elapsed = lookElapsed

        if playSound and playSound.Parent then
            local alpha = math.clamp(elapsed / 3, 0, 1)
            local smoothAlpha = alpha * alpha * (3 - 2 * alpha)
            setShockerSoundSpeed(playSound, 0.9 + smoothAlpha)
        end

        local sway = CFrame.new(
            math.sin(elapsed * 2.7) * 0.18,
            math.sin(elapsed * 2.1) * 0.12,
            0
        ) * CFrame.Angles(
            math.rad(math.sin(elapsed * 1.8) * 2),
            math.rad(math.sin(elapsed * 2.4) * 3),
            math.rad(math.sin(elapsed * 2.1) * 1.5)
        )

        local targetCFrame = camera.CFrame * followOffset * sway

        local currentCFrame = shockerModel:GetPivot()

        local alpha = 1 - math.exp(-deltaTime * 3.8 * ceaseSpeedScale)

        shockerModel:PivotTo(
            currentCFrame:Lerp(targetCFrame, alpha)
        )
    end

    shockerMoving = false

    if playSound and playSound.Parent then
        setShockerSoundSpeed(playSound, 1.9)
    end

    local attackCount = math.random(2, 5)

    local retreatDistance = 2.8
    local retreatDuration = 0.35
    local dashDuration = 0.7
    local hitRadius = 4.2
    local damageAmount = 30

    local hintSent = false

    local function damagePlayer()
        local currentCharacter = player.Character

        if not currentCharacter then
            return false
        end

        local currentHumanoid = currentCharacter:FindFirstChildOfClass("Humanoid")

        if not currentHumanoid or currentHumanoid.Health <= 0 then
            return false
        end

        local willDie = currentHumanoid.Health <= damageAmount

        if willDie then
            local gameStats = ReplicatedStorage:FindFirstChild("GameStats")
            local playerStats = gameStats and gameStats:FindFirstChild("Player_" .. player.Name)
            local totalStats = playerStats and playerStats:FindFirstChild("Total")
            local deathCause = totalStats and totalStats:FindFirstChild("DeathCause")

            if deathCause then
                deathCause.Value = "Shocker"
            end
        end

        currentHumanoid:TakeDamage(damageAmount)

        return true
    end

    local function getSegmentDistance(point, startPosition, endPosition)
        local segment = endPosition - startPosition
        local lengthSquared = segment:Dot(segment)

        if lengthSquared <= 0.0001 then
            return (point - startPosition).Magnitude
        end

        local alpha = math.clamp(
            (point - startPosition):Dot(segment) / lengthSquared,
            0,
            1
        )

        local closestPoint = startPosition + segment * alpha

        return (point - closestPoint).Magnitude
    end

    local function dashTo(targetCFrame, duration)
        if not shockerModel.Parent then
            return false, false
        end

        local startCFrame = shockerModel:GetPivot()
        local previousPosition = startCFrame.Position
        local hasHit = false
        local elapsed = 0
        shockerMoving = true

        while elapsed < duration do
            if not shockerModel.Parent then
                shockerMoving = false
                return false, hasHit
            end

            local deltaTime = RunService.RenderStepped:Wait()
            local step = math.min(deltaTime, 0.1) * ceaseSpeedScale
            elapsed = math.min(duration, elapsed + step)
            local alpha = math.clamp(elapsed / duration, 0, 1)
            local eased = TweenService:GetValue(alpha, Enum.EasingStyle.Cubic, Enum.EasingDirection.In)
            shockerModel:PivotTo(startCFrame:Lerp(targetCFrame, eased))
            local currentPosition = shockerModel:GetPivot().Position

            if step > 0 and not hasHit then
                local currentCharacter = player.Character
                local currentRoot = currentCharacter and currentCharacter:FindFirstChild("HumanoidRootPart")
                local currentHumanoid = currentCharacter and currentCharacter:FindFirstChildOfClass("Humanoid")

                if currentRoot and currentHumanoid and currentHumanoid.Health > 0 then
                    local distance = getSegmentDistance(
                        currentRoot.Position,
                        previousPosition,
                        currentPosition
                    )

                    if distance <= hitRadius then
                        hasHit = damagePlayer()
                    end
                end
            end

            previousPosition = currentPosition
        end

        shockerMoving = false
        return shockerModel.Parent ~= nil, hasHit
    end

    for attackIndex = 1, attackCount do
        if not shockerModel.Parent then
            return
        end

        setFaceVisible(false)

        local currentCharacter = player.Character or character
        local currentRoot = currentCharacter:FindFirstChild("HumanoidRootPart")

        if not currentRoot then
            break
        end

        local currentPivot = shockerModel:GetPivot()

        local awayVector = currentPivot.Position - currentRoot.Position

        if awayVector.Magnitude < 0.001 then
            awayVector = camera.CFrame.LookVector
        end

        local awayDirection = awayVector.Unit

        local retreatPosition =
            currentPivot.Position + awayDirection * retreatDistance

        local retreatCFrame =
            CFrame.new(retreatPosition) * currentPivot.Rotation

        local retreatSuccess = tweenModelTo(
            retreatCFrame,
            retreatDuration,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out
        )

        if not retreatSuccess then
            return
        end

        currentCharacter = player.Character or character
        currentRoot = currentCharacter:FindFirstChild("HumanoidRootPart")

        if not currentRoot then
            break
        end

        local dashStartPosition = shockerModel:GetPivot().Position
        local targetPlayerPosition = currentRoot.Position

        local dashVector = targetPlayerPosition - dashStartPosition

        if dashVector.Magnitude < 0.001 then
            dashVector = -camera.CFrame.LookVector
        end

        local dashDirection = dashVector.Unit

        local dashEndPosition =
            targetPlayerPosition + dashDirection * 5.5

        local dashCFrame =
            CFrame.new(dashEndPosition) * shockerModel:GetPivot().Rotation

        setFaceVisible(true)

        if horrorScream and horrorScream.Parent then
            pcall(function()
                horrorScream:Stop()
                horrorScream.TimePosition = 0
                horrorScream:Play()
            end)
        end

        local dashSuccess = dashTo(
            dashCFrame,
            dashDuration
        )

        setFaceVisible(false)

        if not dashSuccess then
            return
        end

        if attackIndex < attackCount then
            local randomInterval = math.random(10, 18) / 10
            if not waitShockerTime(randomInterval) then
                return
            end
        end
    end

    if not shockerModel.Parent then
        return
    end

    while ceaseFreezeActive and shockerModel.Parent do
        RunService.Heartbeat:Wait()
    end

    if not shockerModel.Parent then
        return
    end

    shockerMoving = false
    setFaceVisible(false)

    local fadeItems = {}

    local function addFade(instance, property, target, kind)
        local success, startValue = pcall(function()
            return instance[property]
        end)

        if success then
            table.insert(fadeItems, {
                instance = instance,
                property = property,
                startValue = startValue,
                target = target,
                kind = kind or "number"
            })
        end
    end

    local function fadeNumberSequence(sequence, alpha)
        local keypoints = {}

        for _, keypoint in ipairs(sequence.Keypoints) do
            local newValue =
                keypoint.Value + (1 - keypoint.Value) * alpha

            local newEnvelope =
                keypoint.Envelope * (1 - alpha)

            table.insert(
                keypoints,
                NumberSequenceKeypoint.new(
                    keypoint.Time,
                    newValue,
                    newEnvelope
                )
            )
        end

        return NumberSequence.new(keypoints)
    end

    for _, object in ipairs(shockerModel:GetDescendants()) do
        if object:IsA("BasePart") then
            addFade(object, "Transparency", 1)

        elseif object:IsA("Decal") or object:IsA("Texture") then
            addFade(object, "Transparency", 1)

        elseif object:IsA("ParticleEmitter") or object:IsA("Beam") or object:IsA("Trail") then
            addFade(object, "Transparency", 1, "sequence")

        elseif object:IsA("Highlight") then
            addFade(object, "FillTransparency", 1)
            addFade(object, "OutlineTransparency", 1)

        elseif object:IsA("Sound") then
            addFade(object, "Volume", 0)

        elseif object:IsA("PointLight") or object:IsA("SpotLight") or object:IsA("SurfaceLight") then
            addFade(object, "Brightness", 0)

        elseif object:IsA("Fire") then
            addFade(object, "Size", 0)
            addFade(object, "Heat", 0)

        elseif object:IsA("Smoke") then
            addFade(object, "Opacity", 0)
            addFade(object, "Size", 0)

        elseif object:IsA("ImageLabel") or object:IsA("ImageButton") then
            addFade(object, "ImageTransparency", 1)
            addFade(object, "BackgroundTransparency", 1)

        elseif object:IsA("TextLabel") or object:IsA("TextButton") or object:IsA("TextBox") then
            addFade(object, "TextTransparency", 1)
            addFade(object, "TextStrokeTransparency", 1)
            addFade(object, "BackgroundTransparency", 1)

        elseif object:IsA("UIStroke") then
            addFade(object, "Transparency", 1)
        end
    end

    local fadeDuration = 0.85
    local fadeStart = os.clock()

    while shockerModel.Parent do
        local alpha = math.clamp(
            (os.clock() - fadeStart) / fadeDuration,
            0,
            1
        )

        for _, item in ipairs(fadeItems) do
            if item.instance.Parent then
                local value

                if item.kind == "sequence" then
                    value = fadeNumberSequence(item.startValue, alpha)
                else
                    value =
                        item.startValue
                        + (item.target - item.startValue) * alpha
                end

                pcall(function()
                    item.instance[item.property] = value
                end)
            end
        end

        if alpha >= 1 then
            break
        end

        RunService.RenderStepped:Wait()
    end

    if not shockerModel.Parent then
        return
    end

    for _, object in ipairs(shockerModel:GetDescendants()) do
        if object:IsA("Sound") then
            object:Stop()

        elseif object:IsA("ParticleEmitter")
            or object:IsA("Beam")
            or object:IsA("Trail")
            or object:IsA("Fire")
            or object:IsA("Smoke")
            or object:IsA("Sparkles")
            or object:IsA("Highlight")
            or object:IsA("PointLight")
            or object:IsA("SpotLight")
            or object:IsA("SurfaceLight")
            or object:IsA("BillboardGui")
            or object:IsA("SurfaceGui")
            or object:IsA("ScreenGui") then

            object.Enabled = false
        end
    end

    shockerFinished = true
    cancelCeaseFreeze()
    shockerModel:Destroy()
end

-- Shocker: random 40-150 seconds, then 60 seconds of cooldown
-- after each spawn before starting the next random countdown.
while true do
    task.wait(math.random(40, 150))

    -- Keep the event synchronous so a second Shocker never overlaps the first.
    local spawnedAt = os.clock()
    local success, err = pcall(spawnShocker)
    if not success then
        warn("Hardcore Shocker failed: " .. tostring(err))
    end

    -- Cooldown starts when Shocker appears. If the event is still running
    -- after 60 seconds, the next countdown starts when that event finishes.
    local cooldownRemaining = 60 - (os.clock() - spawnedAt)
    if cooldownRemaining > 0 then
        task.wait(cooldownRemaining)
    end
end
        end)

        local vu439 = {
            false,
            true,
            false,
            true,
            false,
            false,
            true,
            false,
            false,
            true
        }
        local vu440 = 0
        local function vu482()
            local entity = spawner.Create({Entity = {Name = "Cease",Asset = "74118615017772",HeightOffset = 1},Lights = {Flicker = {Enabled = false,Duration = 10},Shatter = false,Repair = false},Earthquake = {Enabled = false},CameraShake = {Enabled = true,Range = 200,Values = {1.5, 20, 0.1, 1}},Movement = {Speed = 100,Delay = 5,Reversed = false},Rebounding = {Enabled = false,Type = "ambush",Min = 4,Max = 4,Delay = math.random(10, 30) / 10},Damage = {Enabled = false,Range = 100,Amount = 125},Crucifixion = {Enabled = true,Range = 100,Resist = false,Break = true},Death = {Type = "Guiding",Hints = {"CEASE", "...", "...", "..."},Cause = "Cease"}}) 
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

entity:SetCallback("OnSpawned", function()
    task.spawn(function()
        local TweenService = game:GetService("TweenService")
        local RunService = game:GetService("RunService")
        local Players = game:GetService("Players")
        local SoundService = game:GetService("SoundService")
        local Debris = game:GetService("Debris")
        local blue = Color3.fromRGB(91, 113, 255)
        local fadeInfo = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
        local originals = {}

        local function fadeSequence(object, originalSequence, restoring)
            local progress = Instance.new("NumberValue")
            local connection = progress:GetPropertyChangedSignal("Value"):Connect(function()
                if not object.Parent then
                    return
                end
                local keypoints = {}
                for _, keypoint in ipairs(originalSequence.Keypoints) do
                    local color = restoring
                        and blue:Lerp(keypoint.Value, progress.Value)
                        or keypoint.Value:Lerp(blue, progress.Value)
                    table.insert(keypoints, ColorSequenceKeypoint.new(keypoint.Time, color))
                end
                object.Color = ColorSequence.new(keypoints)
            end)
            local tween = TweenService:Create(progress, fadeInfo, {Value = 1})
            tween.Completed:Connect(function()
                connection:Disconnect()
                if object.Parent then
                    object.Color = restoring and originalSequence or ColorSequence.new(blue)
                end
                progress:Destroy()
            end)
            tween:Play()
        end

        local function tint(object)
            if not object or originals[object] ~= nil then
                return
            end
            if object:IsA("BasePart") or object:IsA("Light") then
                originals[object] = object.Color
                TweenService:Create(object, fadeInfo, {Color = blue}):Play()
            elseif object:IsA("ParticleEmitter") or object:IsA("Beam") then
                originals[object] = object.Color
                fadeSequence(object, object.Color, false)
            end
        end

        local function tintFixture(fixture)
            if not fixture then
                return
            end
            tint(fixture:FindFirstChild("PointLight", true))
            tint(fixture:FindFirstChild("SpotLight", true))
            local neon = fixture:FindFirstChild("Neon", true)
            tint(neon)
            if not neon then
                return
            end
            local bright = neon:FindFirstChild("Bright sh idfk")
            local atachm = neon:FindFirstChild("atachm")
            local glow = neon:FindFirstChild("Glow")
            tint(bright and bright:FindFirstChild("ParticleEmitter"))
            tint(atachm and atachm:FindFirstChild("Ok you cannot tell me this isnt good"))
            tint(glow and glow:FindFirstChild("Beam"))
        end

        local rooms = workspace:FindFirstChild("CurrentRooms")
        if rooms then
            for _, room in ipairs(rooms:GetChildren()) do
                if room:IsA("Model") then
                    local assets = room:FindFirstChild("Assets")
                    if assets then
                        for _, item in ipairs(assets:GetChildren()) do
                            if item:IsA("Model") and item.Name == "Chandelier" then
                                tintFixture(item:FindFirstChild("LightFixture", true))
                            end
                        end
                        local lightFixtures = assets:FindFirstChild("Light_Fixtures")
                        if lightFixtures then
                            for _, item in ipairs(lightFixtures:GetChildren()) do
                                if item:IsA("Model") and item.Name == "LightStand" then
                                    tintFixture(item:FindFirstChild("LightFixture", true))
                                end
                            end
                        end
                    end
                end
            end
        end

        task.wait(5)

        for object, originalColor in pairs(originals) do
            if object.Parent then
                if typeof(originalColor) == "Color3" then
                    TweenService:Create(object, fadeInfo, {Color = originalColor}):Play()
                else
                    fadeSequence(object, originalColor, true)
                end
            end
        end

        local deadline = os.clock() + 9
        local damaged = false
        while os.clock() < deadline and not damaged do
            RunService.Heartbeat:Wait()
            local player = Players.LocalPlayer
            local character = player and player.Character
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.Health > 0 and humanoid.MoveDirection.Magnitude > 0.05 then
                damaged = true
                local sound = Instance.new("Sound")
                sound.SoundId = "rbxassetid://115478216144558"
                sound.Volume = 1
                sound.Looped = false
                sound.Parent = SoundService
                sound.Ended:Connect(function()
                    sound:Destroy()
                end)
                Debris:AddItem(sound, 20)
                sound:Play()
                humanoid:TakeDamage(100)
            end
        end
    end)
end)

entity:Run()

        end
        workspace.DescendantRemoving:Connect(function(p483)
            if p483.Name == "RushMoving" then
                vu440 = vu440 + 1
                if vu440 == # vu439 then
                    vu440 = 1
                end
                if vu439[vu440] and vu439[vu440] == true then
                    wait(10)
                    pcall(vu482)
                end
            end
        end)

        

        -- Independent room-rush Silence: not the 320-second sound-based Silence.
        -- Avoid spawning in the Figure library or while Seek's chase is active.
        local function isRushSilenceProtectedArea()
            local data = game:GetService("ReplicatedStorage"):FindFirstChild("GameData")
            local latest = data and data:FindFirstChild("LatestRoom")
            local roomNumber = latest and tonumber(latest.Value)
            if roomNumber == 50 then
                return true
            end
            local rooms = workspace:FindFirstChild("CurrentRooms")
            if roomNumber == 49 and rooms and rooms:FindFirstChild("50") then
                -- Room 50 may already be streaming while entering it.
                return true
            end
            if workspace:FindFirstChild("SeekMovingNewClone")
                or workspace:FindFirstChild("SeekMovingNew")
                or workspace:FindFirstChild("SeekMoving")
                or workspace:FindFirstChild("SeekMov") then
                return true
            end
            if vu31 and vu31.MainGame and vu31.MainGame.chase then
                return true
            end
            return false
        end

        task.spawn(function()
            while task.wait(500) do
                -- Skipping a protected cycle does not stop future respawns.
                if isRushSilenceProtectedArea() or workspace:FindFirstChild("SilenceRush") then
                    continue
                end
                -- Start the independent room-rush encounter. The path mover runs asynchronously.
                local ok, err = xpcall(function()
                    local Players = game:GetService("Players")
                    local RunService = game:GetService("RunService")
                    local TweenService = game:GetService("TweenService")
                    local ReplicatedStorage = game:GetService("ReplicatedStorage")
                    local SoundService = game:GetService("SoundService")
                    local InsertService = game:GetService("InsertService")

                    local SILENCE_ASSET_ID = 131179838362680
                    local CRUCIFIX_ASSET_ID = 128235155752478
                    local JUMPSCARE_SOUND_ID = "rbxassetid://1592934514"
                    local JUMPSCARE_IMAGE_ID = "rbxassetid://139425974297545"
                    local JUMPSCARE_IMAGE_ALT_ID = "rbxassetid://71258076152603"
                    local SILENCE_SPEED = 20
                    local DETECTION_DISTANCE = 200
                    local HEIGHT_OFFSET = Vector3.new(0, 0, 0)
                    local JUMPSCARE_DAMAGE = 180

                    local silence = nil
                    local isJumpScaring = false
                    local hasJumpScared = false
                    local isSilenceDespawning = false
                    local crucifixActivated = false
                    local silenceIsMoving = false
                    local silenceMoveCancelled = false
                    local ceaseFreezeActive = false
                    local ceaseSpeedScale = 1
                    local ceaseFreezeSerial = 0
                    local ceaseSavedEffects = {}
                    local ceaseDescendantConnection = nil
                    local ceaseHandledModels = setmetatable({}, { __mode = "k" })

                    local function ease(alpha)
                        alpha = math.clamp(alpha, 0, 1)
                        return alpha * alpha * (3 - 2 * alpha)
                    end

                    local function loadModel(assetId, fallbackName)
                        local success, objects = pcall(function()
                            return game:GetObjects("rbxassetid://" .. tostring(assetId))
                        end)

                        if success and type(objects) == "table" then
                            for _, object in ipairs(objects) do
                                if object:IsA("Model") then
                                    return object
                                end
                            end
                        end

                        local template = ReplicatedStorage:FindFirstChild(fallbackName, true)
                        if template and template:IsA("Model") then
                            return template:Clone()
                        end

                        local loaded, asset = pcall(function()
                            return InsertService:LoadAsset(assetId)
                        end)

                        if loaded and asset and asset:IsA("Model") then
                            return asset
                        end

                        return nil
                    end

                    local function prepareModel(model, queryable)
                        for _, descendant in ipairs(model:GetDescendants()) do
                            if descendant:IsA("BasePart") then
                                descendant.Anchored = true
                                descendant.CanCollide = false
                                descendant.CanTouch = false
                                descendant.CanQuery = queryable
                            end
                        end
                    end

                    local function getSilencePosition()
                        if silence and silence.Parent then
                            return silence:GetPivot().Position
                        end
                        return nil
                    end

                    local function isActive()
                        return silence ~= nil
                            and silence.Parent ~= nil
                            and not crucifixActivated
                            and not isSilenceDespawning
                            and not silenceMoveCancelled
                            and not isRushSilenceProtectedArea()
                    end

                    local function applyCeaseSpeed(scale)
                        ceaseSpeedScale = math.clamp(scale, 0, 1)

                        for object, saved in pairs(ceaseSavedEffects) do
                            if object.Parent then
                                if saved.Type == "Particle" then
                                    pcall(function()
                                        object.TimeScale = saved.TimeScale * ceaseSpeedScale
                                    end)
                                else
                                    pcall(function()
                                        object.PlaybackSpeed = saved.PlaybackSpeed * ceaseSpeedScale
                                        object.Volume = saved.Volume * ceaseSpeedScale
                                    end)
                                end
                            end
                        end
                    end

                    local function trackCeaseEffect(object)
                        if ceaseSavedEffects[object] then
                            return
                        end

                        if object:IsA("ParticleEmitter") then
                            ceaseSavedEffects[object] = {
                                Type = "Particle",
                                TimeScale = object.TimeScale
                            }
                        elseif object:IsA("Sound") then
                            ceaseSavedEffects[object] = {
                                Type = "Sound",
                                PlaybackSpeed = object.PlaybackSpeed,
                                Volume = object.Volume
                            }
                        else
                            return
                        end

                        if ceaseFreezeActive then
                            local saved = ceaseSavedEffects[object]
                            if saved.Type == "Particle" then
                                pcall(function()
                                    object.TimeScale = saved.TimeScale * ceaseSpeedScale
                                end)
                            else
                                pcall(function()
                                    object.PlaybackSpeed = saved.PlaybackSpeed * ceaseSpeedScale
                                    object.Volume = saved.Volume * ceaseSpeedScale
                                end)
                            end
                        end
                    end

                    local function cancelCeaseFreeze()
                        ceaseFreezeSerial = ceaseFreezeSerial + 1

                        if ceaseDescendantConnection then
                            ceaseDescendantConnection:Disconnect()
                            ceaseDescendantConnection = nil
                        end

                        for object, saved in pairs(ceaseSavedEffects) do
                            if object.Parent then
                                if saved.Type == "Particle" then
                                    pcall(function()
                                        object.TimeScale = saved.TimeScale
                                    end)
                                else
                                    pcall(function()
                                        object.PlaybackSpeed = saved.PlaybackSpeed
                                        object.Volume = saved.Volume
                                    end)
                                end
                            end
                        end

                        ceaseSavedEffects = {}
                        ceaseSpeedScale = 1
                        ceaseFreezeActive = false
                    end

                    local function startCeaseFreeze(ceaseModel)
                        if ceaseFreezeActive or not silenceIsMoving or not isActive()
                            or isJumpScaring or ceaseHandledModels[ceaseModel] then
                            return
                        end

                        ceaseHandledModels[ceaseModel] = true
                        ceaseFreezeActive = true
                        ceaseFreezeSerial = ceaseFreezeSerial + 1
                        local freezeSerial = ceaseFreezeSerial
                        local currentSilence = silence

                        for _, descendant in ipairs(currentSilence:GetDescendants()) do
                            trackCeaseEffect(descendant)
                        end

                        ceaseDescendantConnection = currentSilence.DescendantAdded:Connect(function(descendant)
                            if ceaseFreezeActive and ceaseFreezeSerial == freezeSerial then
                                trackCeaseEffect(descendant)
                            end
                        end)

                        task.spawn(function()
                            local function stillValid()
                                return ceaseFreezeSerial == freezeSerial
                                    and silence == currentSilence
                                    and currentSilence.Parent ~= nil
                                    and not isJumpScaring
                                    and not crucifixActivated
                                    and not isSilenceDespawning
                            end

                            local function transition(fromScale, toScale, duration)
                                local startedAt = os.clock()
                                while true do
                                    if not stillValid() then
                                        if ceaseFreezeSerial == freezeSerial then
                                            cancelCeaseFreeze()
                                        end
                                        return false
                                    end

                                    local alpha = math.clamp((os.clock() - startedAt) / duration, 0, 1)
                                    applyCeaseSpeed(fromScale + (toScale - fromScale) * ease(alpha))
                                    if alpha >= 1 then
                                        return true
                                    end
                                    RunService.Heartbeat:Wait()
                                end
                            end

                            if not transition(1, 0, 2.25) then
                                return
                            end

                            local holdStartedAt = os.clock()
                            while os.clock() - holdStartedAt < 13 do
                                if not stillValid() then
                                    if ceaseFreezeSerial == freezeSerial then
                                        cancelCeaseFreeze()
                                    end
                                    return
                                end
                                task.wait(0.05)
                            end

                            if not transition(0, 1, 2) then
                                return
                            end

                            if ceaseFreezeSerial == freezeSerial then
                                cancelCeaseFreeze()
                            end
                        end)
                    end

                    local function stopSilenceMovement()
                        silenceMoveCancelled = true
                        silenceIsMoving = false
                        cancelCeaseFreeze()
                    end

                    local function destroySilence()
                        stopSilenceMovement()
                        isSilenceDespawning = true
                        local previousSilence = silence
                        silence = nil
                        if previousSilence then
                            previousSilence:Destroy()
                        end
                    end

                    local function getCrucifixTool(character)
                        if not character or not character:IsA("Model") then
                            return nil
                        end

                        local direct = character:FindFirstChild("Crucifix")
                        if direct and direct:IsA("Tool") then
                            return direct
                        end

                        for _, descendant in ipairs(character:GetDescendants()) do
                            if descendant.Name == "Crucifix" and descendant:IsA("Tool") then
                                return descendant
                            end
                        end

                        return nil
                    end

                    local function getCharacterFromHit(hitInstance)
                        local current = hitInstance
                        while current and current ~= workspace do
                            if current:IsA("Model") and Players:GetPlayerFromCharacter(current) then
                                return current
                            end
                            current = current.Parent
                        end
                        return nil
                    end

                    local function rayEntryDistanceToPart(origin, directionUnit, part)
                        if not part or not part.Parent or not part:IsA("BasePart") then
                            return nil
                        end

                        local localOrigin = part.CFrame:PointToObjectSpace(origin)
                        local localDirection = part.CFrame:VectorToObjectSpace(directionUnit)
                        local half = part.Size * 0.5
                        local entry, exitDistance = 0, math.huge

                        for _, axis in ipairs({ "X", "Y", "Z" }) do
                            local position = localOrigin[axis]
                            local velocity = localDirection[axis]
                            local extent = half[axis]

                            if math.abs(velocity) < 0.00001 then
                                if position < -extent or position > extent then
                                    return nil
                                end
                            else
                                local near = (-extent - position) / velocity
                                local far = (extent - position) / velocity
                                if near > far then
                                    near, far = far, near
                                end
                                entry = math.max(entry, near)
                                exitDistance = math.min(exitDistance, far)
                                if exitDistance < entry then
                                    return nil
                                end
                            end
                        end

                        return entry
                    end

                    local easeCease = ease

                    local function getCrucifixVisualStates(root, shouldInclude, onlyRoot)
                        local states = {}

                        local function capture(object)
                            if shouldInclude and not shouldInclude(object) then
                                return
                            end

                            if object:IsA("BasePart") or object:IsA("Decal")
                                or object:IsA("Texture") then
                                table.insert(states, {
                                    Object = object,
                                    Kind = "Transparency",
                                    Original = object.Transparency
                                })
                            elseif object:IsA("ParticleEmitter") or object:IsA("Beam")
                                or object:IsA("Trail") then
                                table.insert(states, {
                                    Object = object,
                                    Kind = "Sequence",
                                    Original = object.Transparency
                                })
                            elseif object:IsA("Light") then
                                table.insert(states, {
                                    Object = object,
                                    Kind = "Brightness",
                                    Original = object.Brightness
                                })
                            elseif object:IsA("Highlight") then
                                table.insert(states, {
                                    Object = object,
                                    Kind = "Highlight",
                                    Fill = object.FillTransparency,
                                    Outline = object.OutlineTransparency
                                })
                            elseif object:IsA("Smoke") then
                                table.insert(states, {
                                    Object = object,
                                    Kind = "Smoke",
                                    Original = object.Opacity
                                })
                            elseif object:IsA("Fire") then
                                table.insert(states, {
                                    Object = object,
                                    Kind = "Fire",
                                    Size = object.Size,
                                    Heat = object.Heat
                                })
                            elseif object:IsA("Sound") then
                                table.insert(states, {
                                    Object = object,
                                    Kind = "Sound",
                                    Original = object.Volume
                                })
                            elseif object:IsA("GuiObject") then
                                local state = {
                                    Object = object,
                                    Kind = "GuiObject",
                                    Background = object.BackgroundTransparency
                                }

                                if object:IsA("ImageLabel") or object:IsA("ImageButton") then
                                    state.Image = object.ImageTransparency
                                end

                                if object:IsA("TextLabel") or object:IsA("TextButton")
                                    or object:IsA("TextBox") then
                                    state.Text = object.TextTransparency
                                end

                                table.insert(states, state)
                            end
                        end

                        capture(root)
                        if not onlyRoot then
                            for _, descendant in ipairs(root:GetDescendants()) do
                                capture(descendant)
                            end
                        end

                        return states
                    end

                    local function crucifixFadedSequence(original, factor)
                        local keypoints = {}

                        for _, keypoint in ipairs(original.Keypoints) do
                            local nextTransparency = 1 - (1 - keypoint.Value) * factor
                            table.insert(keypoints, NumberSequenceKeypoint.new(
                                keypoint.Time,
                                math.clamp(nextTransparency, 0, 1),
                                keypoint.Envelope * factor
                            ))
                        end

                        return NumberSequence.new(keypoints)
                    end

                    local function setCrucifixVisualFactor(states, factor)
                        factor = math.clamp(factor, 0, 1)

                        for _, state in ipairs(states) do
                            local object = state.Object

                            if object and object.Parent then
                                if state.Kind == "Transparency" then
                                    object.Transparency = 1 - (1 - state.Original) * factor
                                elseif state.Kind == "Sequence" then
                                    object.Transparency = crucifixFadedSequence(state.Original, factor)
                                elseif state.Kind == "Brightness" then
                                    object.Brightness = state.Original * factor
                                elseif state.Kind == "Highlight" then
                                    object.FillTransparency = 1 - (1 - state.Fill) * factor
                                    object.OutlineTransparency = 1 - (1 - state.Outline) * factor
                                elseif state.Kind == "Smoke" then
                                    object.Opacity = state.Original * factor
                                elseif state.Kind == "Fire" then
                                    object.Size = state.Size * factor
                                    object.Heat = state.Heat * factor
                                elseif state.Kind == "Sound" then
                                    object.Volume = state.Original * factor
                                elseif state.Kind == "GuiObject" then
                                    object.BackgroundTransparency = 1 - (1 - state.Background) * factor

                                    if state.Image ~= nil then
                                        object.ImageTransparency = 1 - (1 - state.Image) * factor
                                    end

                                    if state.Text ~= nil then
                                        object.TextTransparency = 1 - (1 - state.Text) * factor
                                    end
                                end
                            end
                        end
                    end

                    local function fadeCrucifixVisuals(states, initialFactor, endFactor, duration)
                        if duration <= 0 then
                            setCrucifixVisualFactor(states, endFactor)
                            return
                        end

                        local startTime = os.clock()

                        while true do
                            local alpha = math.clamp((os.clock() - startTime) / duration, 0, 1)
                            local eased = easeCease(alpha)
                            setCrucifixVisualFactor(
                                states,
                                initialFactor + (endFactor - initialFactor) * eased
                            )

                            if alpha >= 1 then
                                break
                            end

                            RunService.Heartbeat:Wait()
                        end
                    end

                    local function findCrucifixBeams(rushNew)
                        local preferred = {}
                        local fallback = {}

                        for _, descendant in ipairs(rushNew:GetDescendants()) do
                            if descendant:IsA("Beam") then
                                table.insert(fallback, descendant)

                                local ancestor = descendant.Parent
                                while ancestor and ancestor ~= rushNew do
                                    if string.lower(ancestor.Name) == "particlesin" then
                                        table.insert(preferred, descendant)
                                        break
                                    end
                                    ancestor = ancestor.Parent
                                end

                                if string.lower(descendant.Name) == "particlesin" then
                                    local exists = false
                                    for _, selected in ipairs(preferred) do
                                        if selected == descendant then
                                            exists = true
                                            break
                                        end
                                    end
                                    if not exists then
                                        table.insert(preferred, descendant)
                                    end
                                end
                            end
                        end

                        local beams = #preferred > 0 and preferred or fallback
                        table.sort(beams, function(a, b)
                            return a:GetFullName() < b:GetFullName()
                        end)

                        return beams
                    end

                    local function prepareCrucifixBeams(beams, rushNew, movingAttachment)
                        for index, beam in ipairs(beams) do
                            if beam.Parent then
                                if not beam.Attachment0 then
                                    beam.Attachment0 = movingAttachment
                                end

                                if not beam.Attachment1 or beam.Attachment1 == beam.Attachment0 then
                                    local endpoint = Instance.new("Attachment")
                                    endpoint.Name = "CrucifixBeamEndpoint" .. tostring(index)
                                    local angle = (index - 1) * (math.pi / 2)
                                    local offset = Vector3.new(
                                        math.cos(angle) * 3,
                                        2,
                                        math.sin(angle) * 3
                                    )
                                    endpoint.Position = movingAttachment.Position
                                        + rushNew.CFrame:VectorToObjectSpace(offset)
                                    endpoint.Parent = rushNew
                                    beam.Attachment1 = endpoint
                                end

                                if beam.Width0 <= 0 and beam.Width1 <= 0 then
                                    beam.Width0 = 0.3
                                    beam.Width1 = 0.3
                                end

                                beam.Enabled = true
                                beam.Transparency = NumberSequence.new(1)
                            end
                        end
                    end

                    local crucifixBeamSoundIds = {
                        "124444290902740",
                        "100133789671771",
                        "133850299035625",
                        "120232105146350"
                    }

                    local function createCrucifixBeamFeedback()
                        local beamCameraShaker = nil
                        local shakeCleanupScheduled = false

                        local function trigger(index)
                            local soundId = crucifixBeamSoundIds[index]
                            if not soundId then
                                return
                            end

                            local sound = Instance.new("Sound")
                            sound.Name = "CrucifixBeamSound" .. tostring(index)
                            sound.SoundId = "rbxassetid://" .. soundId
                            sound.Volume = 7
                            sound.Looped = false
                            sound.Parent = game:GetService("SoundService")
                            sound.Ended:Connect(function()
                                if sound.Parent then
                                    sound:Destroy()
                                end
                            end)
                            task.delay(60, function()
                                if sound.Parent then
                                    sound:Destroy()
                                end
                            end)
                            sound:Play()

                            if not beamCameraShaker then
                                local module = game.ReplicatedStorage:FindFirstChild("CameraShaker")
                                if module then
                                    local loaded, CameraShaker = pcall(require, module)
                                    if loaded and CameraShaker then
                                        local created, shaker = pcall(function()
                                            local currentShaker = CameraShaker.new(
                                                Enum.RenderPriority.Camera.Value,
                                                function(shakeCf)
                                                    local camera = workspace.CurrentCamera
                                                    if camera then
                                                        camera.CFrame = camera.CFrame * shakeCf
                                                    end
                                                end
                                            )
                                            currentShaker:Start()
                                            return currentShaker
                                        end)
                                        if created then
                                            beamCameraShaker = shaker
                                        end
                                    end
                                end
                            end

                            if beamCameraShaker then
                                local started, shakeInstance = pcall(function()
                                    return beamCameraShaker:StartShake(10, 28, 0.1, 0.25, 0.35)
                                end)
                                if started and shakeInstance then
                                    task.delay(0.3, function()
                                        pcall(function()
                                            shakeInstance:StartFadeOut(3)
                                        end)
                                    end)
                                else
                                    pcall(function()
                                        beamCameraShaker:ShakeOnce(10, 28, 0.1, 3, 0.25, 0.35)
                                    end)
                                end

                                if not shakeCleanupScheduled then
                                    shakeCleanupScheduled = true
                                    task.delay(4.5, function()
                                        if beamCameraShaker then
                                            pcall(function()
                                                beamCameraShaker:Stop()
                                            end)
                                        end
                                    end)
                                end
                            end
                        end

                        return trigger
                    end

                    local function revealCrucifixBeams(beams, onBeamBegin)
                        local startTime = os.clock()
                        local perBeamDuration = 0.5
                        local staggerDelay = 0.25
                        local totalDuration = perBeamDuration + math.max(0, #beams - 1) * staggerDelay
                        local begun = {}

                        while true do
                            local elapsed = os.clock() - startTime

                            for index, beam in ipairs(beams) do
                                if beam and beam.Parent then
                                    local beamStartTime = (index - 1) * staggerDelay
                                    if elapsed >= beamStartTime and not begun[index] then
                                        begun[index] = true
                                        if onBeamBegin then
                                            onBeamBegin(index)
                                        end
                                    end

                                    local beamAlpha = math.clamp(
                                        (elapsed - beamStartTime) / perBeamDuration,
                                        0,
                                        1
                                    )
                                    beam.Enabled = true
                                    beam.Transparency = NumberSequence.new(1 - easeCease(beamAlpha))
                                end
                            end

                            if elapsed >= totalDuration then
                                break
                            end
                            RunService.Heartbeat:Wait()
                        end

                        for _, beam in ipairs(beams) do
                            if beam and beam.Parent then
                                beam.Enabled = true
                                beam.Transparency = NumberSequence.new(0)
                            end
                        end
                    end

                    local function fadeCrucifixBeamsOut(beams, duration)
                        local startTime = os.clock()

                        while true do
                            local alpha = math.clamp((os.clock() - startTime) / duration, 0, 1)
                            local transparency = easeCease(alpha)

                            for _, beam in ipairs(beams) do
                                if beam and beam.Parent then
                                    beam.Transparency = NumberSequence.new(transparency)
                                end
                            end

                            if alpha >= 1 then
                                break
                            end
                            RunService.Heartbeat:Wait()
                        end

                        for _, beam in ipairs(beams) do
                            if beam and beam.Parent then
                                beam.Transparency = NumberSequence.new(1)
                                beam.Enabled = false
                            end
                        end
                    end

                    local function moveCrucifixAttachment(attachment, targetPosition, duration)
                        local origin = attachment.Position
                        local startTime = os.clock()

                        while true do
                            if not attachment.Parent then
                                return false
                            end

                            local alpha = math.clamp((os.clock() - startTime) / duration, 0, 1)
                            local progress = easeCease(alpha)
                            attachment.Position = origin:Lerp(targetPosition, progress)

                            if alpha >= 1 then
                                attachment.Position = targetPosition
                                return true
                            end
                            RunService.Heartbeat:Wait()
                        end
                    end

                    local function fadeCrucifixDescendantsRecursively(root, duration)
                        local found = {}
                        local allStates = {}
                        local stateCount = 0

                        local function findChildren(object)
                            if not object or found[object] then
                                return
                            end
                            found[object] = true

                            local states = getCrucifixVisualStates(object, nil, true)
                            for _, state in ipairs(states) do
                                table.insert(allStates, state)
                                stateCount = stateCount + 1
                            end

                            for _, child in ipairs(object:GetChildren()) do
                                findChildren(child)
                            end
                        end

                        local startTime = os.clock()
                        while true do
                            if not root.Parent then
                                return
                            end

                            findChildren(root)
                            local alpha = math.clamp((os.clock() - startTime) / duration, 0, 1)
                            setCrucifixVisualFactor(allStates, 1 - easeCease(alpha))

                            if alpha >= 1 then
                                break
                            end

                            for _, object in ipairs(root:GetDescendants()) do
                                if not found[object] then
                                    findChildren(object)
                                end
                            end
                            RunService.Heartbeat:Wait()
                        end
                    end

                    local function startCrucifixAmbientShake(replacement)
                        local stepName = "SilenceCrucifixAmbient_"
                            .. game:GetService("HttpService"):GenerateGUID(false)
                        local startedAt = os.clock()
                        local active = true
                        local lastOffset = CFrame.new()
                        local lastCamera = nil

                        local function stop()
                            if not active then
                                return
                            end
                            active = false
                            RunService:UnbindFromRenderStep(stepName)
                        end

                        RunService:BindToRenderStep(
                            stepName,
                            Enum.RenderPriority.Camera.Value + 3,
                            function()
                                if not replacement.Parent then
                                    stop()
                                    return
                                end

                                local camera = workspace.CurrentCamera
                                if not camera then
                                    return
                                end

                                if lastCamera ~= camera then
                                    lastCamera = camera
                                    lastOffset = CFrame.new()
                                end

                                local elapsed = os.clock() - startedAt
                                local strength = easeCease(math.clamp(elapsed / 0.5, 0, 1))
                                local offset = CFrame.new(
                                    math.sin(elapsed * 13) * 0.055 * strength,
                                    math.sin(elapsed * 16 + 0.7) * 0.04 * strength,
                                    0
                                ) * CFrame.Angles(
                                    math.sin(elapsed * 12) * math.rad(0.085) * strength,
                                    math.sin(elapsed * 10 + 1.1) * math.rad(0.065) * strength,
                                    0
                                )

                                camera.CFrame = camera.CFrame * lastOffset:Inverse() * offset
                                lastOffset = offset
                            end
                        )

                        return stop
                    end

                    local function runCrucifixReplacement(originalCFrame)

                        local loadedSuccessfully, replacement = pcall(function()
                            return game:GetObjects("rbxassetid://128235155752478")[1]
                        end)

                        if not loadedSuccessfully or not replacement then

                            return
                        end

                        local targetCFrame = originalCFrame + Vector3.new(0, 1, 0)
                        local bro = replacement.Name == "BRO" and replacement
                            or replacement:FindFirstChild("BRO", true)

                        local placed, placementError = pcall(function()
                            if replacement:IsA("Model") then
                                if bro and bro:IsA("Model") then
                                    local pivotShift = targetCFrame * bro:GetPivot():Inverse()
                                    replacement:PivotTo(pivotShift * replacement:GetPivot())
                                else
                                    replacement:PivotTo(targetCFrame)
                                end
                            elseif bro and bro:IsA("Model") then
                                bro:PivotTo(targetCFrame)
                            elseif replacement:IsA("BasePart") then
                                replacement.CFrame = targetCFrame
                            end

                            for _, descendant in ipairs(replacement:GetDescendants()) do
                                if descendant:IsA("BasePart") then
                                    descendant.Anchored = true
                                    descendant.CanCollide = false
                                    descendant.CanTouch = false
                                end
                            end

                            if replacement:IsA("BasePart") then
                                replacement.Anchored = true
                                replacement.CanCollide = false
                                replacement.CanTouch = false
                            end

                            replacement.Parent = workspace
                        end)

                        if not placed then

                            replacement:Destroy()
                            return
                        end

                        local stopAmbientShake = startCrucifixAmbientShake(replacement)
                        task.delay(30, function()
                            stopAmbientShake()
                            if replacement and replacement.Parent then
                                replacement:Destroy()
                            end
                        end)

                        local animationOK, animationError = xpcall(function()
                            local rushNew = bro and bro:FindFirstChild("RushNew", true)
                            local attachment = rushNew and rushNew:FindFirstChild("Attachment", true)
                            if attachment and not attachment:IsA("Attachment") then
                                attachment = nil
                            end
                            if not rushNew then

                            elseif not attachment then

                            else

                            end

                            task.wait(2.3)
                            if not replacement.Parent then
                                return
                            end

                            if rushNew and rushNew:IsA("BasePart") and attachment then
                                local beams = findCrucifixBeams(rushNew)
                                local introStates = getCrucifixVisualStates(attachment, function(object)
                                    if not object:IsA("Beam") then
                                        return true
                                    end
                                    for _, beam in ipairs(beams) do
                                        if object == beam then
                                            return false
                                        end
                                    end
                                    return true
                                end)

                                setCrucifixVisualFactor(introStates, 0)
                                prepareCrucifixBeams(beams, rushNew, attachment)

                                local originalPosition = attachment.Position
                                local upOffset = rushNew.CFrame:VectorToObjectSpace(Vector3.new(0, 3, 0))
                                local downOffset = rushNew.CFrame:VectorToObjectSpace(Vector3.new(0, -20, 0))
                                local upPosition = originalPosition + upOffset
                                local downPosition = upPosition + downOffset

                                task.spawn(function()
                                    if attachment.Parent then
                                        fadeCrucifixVisuals(introStates, 0, 1, 0.6)
                                    end
                                end)

                                local beamsRevealFinished = #beams == 0
                                if not beamsRevealFinished then
                                    local playBeamFeedback = createCrucifixBeamFeedback()
                                    task.spawn(function()
                                        task.wait(0.8)
                                        if replacement.Parent and attachment.Parent then
                                            pcall(revealCrucifixBeams, beams, playBeamFeedback)
                                        end
                                        beamsRevealFinished = true
                                    end)
                                end

                                if not moveCrucifixAttachment(attachment, upPosition, 1.8) then
                                end

                                while not beamsRevealFinished and replacement.Parent and attachment.Parent do
                                    RunService.Heartbeat:Wait()
                                end

                                if not moveCrucifixAttachment(attachment, downPosition, 1.2) then
                                end
                                task.wait(2)
                                fadeCrucifixBeamsOut(beams, 0.5)
                            end
                        end, function(err)
                            return tostring(err) .. "\n" .. debug.traceback()
                        end)

                        if not animationOK then

                        end
                        local fadeOK, fadeError = pcall(function()
                            fadeCrucifixDescendantsRecursively(replacement, 1)
                        end)
                        if not fadeOK then

                        end
                        if replacement.Parent then
                            for _, descendant in ipairs(replacement:GetDescendants()) do
                                if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam")
                                    or descendant:IsA("Trail") or descendant:IsA("Sparkles")
                                    or descendant:IsA("Smoke") or descendant:IsA("Fire") then
                                    pcall(function()
                                        descendant.Enabled = false
                                    end)
                                end
                            end
                        end
                        task.wait(3)
                        stopAmbientShake()
                        if replacement then

                            replacement:Destroy()
                        end
                    end

                    local function tryUseCrucifix(character)
                        if crucifixActivated or isJumpScaring or not isActive()
                            or not character or character:GetAttribute("Hiding") then
                            return false
                        end

                        local humanoid = character:FindFirstChildWhichIsA("Humanoid")
                        if not humanoid or humanoid.Health <= 0 then
                            return false
                        end

                        local tool = getCrucifixTool(character)
                        if not tool then
                            return false
                        end

                        crucifixActivated = true
                        local lastCFrame = silence:GetPivot()
                        tool:Destroy()
                        destroySilence()
                        task.spawn(runCrucifixReplacement, lastCFrame)
                        return true
                    end

                    local function scanPlayerCrucifixRaycasts()
                        if not isActive() or isJumpScaring then
                            return false
                        end

                        local currentSilence = silence
                        local origin = getSilencePosition()
                        local raycastParams = RaycastParams.new()
                        raycastParams.FilterType = Enum.RaycastFilterType.Exclude
                        raycastParams.FilterDescendantsInstances = { currentSilence }

                        for _, candidatePlayer in ipairs(Players:GetPlayers()) do
                            if not isActive() or currentSilence ~= silence then
                                return crucifixActivated
                            end

                            local character = candidatePlayer.Character
                            if character and character:IsDescendantOf(workspace)
                                and not character:GetAttribute("Hiding") then
                                local humanoid = character:FindFirstChildWhichIsA("Humanoid")
                                local rootPart = character:FindFirstChild("HumanoidRootPart")
                                if humanoid and humanoid.Health > 0
                                    and rootPart and rootPart:IsA("BasePart")
                                    and getCrucifixTool(character) then
                                    local targets = { rootPart }
                                    for _, name in ipairs({ "Head", "UpperTorso", "Torso", "LowerTorso" }) do
                                        local part = character:FindFirstChild(name)
                                        if part and part:IsA("BasePart") then
                                            table.insert(targets, part)
                                        end
                                    end

                                    for _, targetPart in ipairs(targets) do
                                        local direction = targetPart.Position - origin
                                        local distance = direction.Magnitude
                                        if distance > 0.001 and distance <= DETECTION_DISTANCE then
                                            local result = workspace:Raycast(origin, direction, raycastParams)
                                            local hitCharacter = result and getCharacterFromHit(result.Instance)

                                            if not hitCharacter then
                                                local entryDistance = rayEntryDistanceToPart(origin, direction.Unit, targetPart)
                                                if entryDistance and entryDistance <= distance + 0.01
                                                    and (not result or result.Distance > entryDistance + 0.02) then
                                                    hitCharacter = character
                                                end
                                            end

                                            if hitCharacter and not hitCharacter:GetAttribute("Hiding") then
                                                if tryUseCrucifix(hitCharacter) then
                                                    return true
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        return false
                    end

                    local function setDeathCause(player)
                        local gameStats = ReplicatedStorage:FindFirstChild("GameStats")
                        if not gameStats then
                            return
                        end

                        local playerStat = gameStats:FindFirstChild("Player_" .. player.Name)
                        if not playerStat then
                            return
                        end

                        local total = playerStat:FindFirstChild("Total")
                        if not total then
                            return
                        end

                        local deathCause = total:FindFirstChild("DeathCause")
                        if deathCause then
                            deathCause.Value = "Silence"
                        end
                    end

                    local function playJumpscareSound()
                        local sound = Instance.new("Sound")
                        sound.Name = "SilenceRushJumpscareSound"
                        sound.SoundId = JUMPSCARE_SOUND_ID
                        sound.Volume = 3
                        sound.Looped = false
                        sound.Parent = SoundService

                        local cleaned = false
                        local function cleanup()
                            if cleaned then
                                return
                            end
                            cleaned = true
                            if sound.Parent then
                                sound:Destroy()
                            end
                        end

                        sound.Ended:Once(cleanup)
                        task.delay(30, cleanup)
                        sound:Play()
                    end

                    local function triggerSilenceJumpScare(character)
                        if not isActive() or isJumpScaring or hasJumpScared or crucifixActivated then
                            return
                        end

                        if tryUseCrucifix(character) then
                            return
                        end

                        local player = Players:GetPlayerFromCharacter(character)
                        if not player or player ~= Players.LocalPlayer then
                            return
                        end

                        local humanoid = character:FindFirstChildWhichIsA("Humanoid")
                        if not humanoid or humanoid.Health <= 0 or character:GetAttribute("Hiding") then
                            return
                        end

                        isJumpScaring = true
                        playJumpscareSound()
                        cancelCeaseFreeze()

                        local playerGui = player:FindFirstChildOfClass("PlayerGui") or player:WaitForChild("PlayerGui", 5)
                        if not playerGui then
                            isJumpScaring = false
                            return
                        end
                        hasJumpScared = true

                        local existing = playerGui:FindFirstChild("SilenceRushJumpscare")
                        if existing then
                            existing:Destroy()
                        end

                        local screenGui = Instance.new("ScreenGui")
                        screenGui.Name = "SilenceRushJumpscare"
                        screenGui.ResetOnSpawn = false
                        screenGui.IgnoreGuiInset = true
                        screenGui.DisplayOrder = 10000
                        screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                        screenGui.Parent = playerGui

                        local background = Instance.new("Frame")
                        background.Name = "Background"
                        background.Size = UDim2.fromScale(1, 1)
                        background.BorderSizePixel = 0
                        background.BackgroundColor3 = Color3.new(0, 0, 0)
                        background.ZIndex = 1
                        background.Parent = screenGui

                        task.wait(0.8)
                        if isRushSilenceProtectedArea() or not screenGui.Parent or not isActive() then
                            if screenGui.Parent then
                                screenGui:Destroy()
                            end
                            isJumpScaring = false
                            return
                        end

                        local image = Instance.new("ImageLabel")
                        image.Name = "SilenceImage"
                        image.AnchorPoint = Vector2.new(0.5, 0.5)
                        image.Position = UDim2.fromScale(0.5, 0.5)
                        image.Size = UDim2.fromScale(0.08, 0.08)
                        image.BackgroundTransparency = 1
                        image.Image = JUMPSCARE_IMAGE_ID
                        image.ScaleType = Enum.ScaleType.Fit
                        image.ZIndex = 2
                        image.Parent = screenGui

                        local flashActive = true
                        task.spawn(function()
                            local isWhite = false
                            while flashActive and background.Parent do
                                task.wait(0.065)
                                if not flashActive or not background.Parent then
                                    break
                                end
                                isWhite = not isWhite
                                background.BackgroundColor3 = isWhite and Color3.new(1, 1, 1) or Color3.new(0, 0, 0)
                            end
                        end)

                        task.spawn(function()
                            local useAlternate = false
                            while flashActive and image.Parent do
                                task.wait(0.043)
                                if not flashActive or not image.Parent then
                                    break
                                end
                                useAlternate = not useAlternate
                                image.Image = useAlternate and JUMPSCARE_IMAGE_ALT_ID or JUMPSCARE_IMAGE_ID
                            end
                        end)

                        local growTween = TweenService:Create(image, TweenInfo.new(
                            0.2,
                            Enum.EasingStyle.Exponential,
                            Enum.EasingDirection.Out
                        ), {
                            Size = UDim2.fromScale(1.65, 1.65)
                        })
                        growTween:Play()
                        growTween.Completed:Wait()
                        flashActive = false

                        if not isRushSilenceProtectedArea() and humanoid.Parent and humanoid.Health > 0 then
                            if humanoid.Health <= JUMPSCARE_DAMAGE then
                                setDeathCause(player)
                            end
                            humanoid:TakeDamage(JUMPSCARE_DAMAGE)
                        end

                        task.wait(0.12)
                        if screenGui.Parent then
                            screenGui:Destroy()
                        end
                        isJumpScaring = false
                    end

                    local function getOrderedRooms()
                        local currentRooms = workspace:FindFirstChild("CurrentRooms")
                        local orderedRooms = {}
                        if not currentRooms then
                            return orderedRooms
                        end

                        for _, room in ipairs(currentRooms:GetChildren()) do
                            if room:IsA("Model") then
                                local number = tonumber(room.Name)
                                local latestData = ReplicatedStorage:FindFirstChild("GameData")
                                local latest = latestData and latestData:FindFirstChild("LatestRoom")
                                local currentNumber = latest and tonumber(latest.Value)
                                if number and number ~= 50
                                    and (not currentNumber
                                        or (currentNumber < 50 and number < 50)
                                        or (currentNumber > 50 and number > 50)) then
                                    table.insert(orderedRooms, { Number = number, Room = room })
                                end
                            end
                        end

                        table.sort(orderedRooms, function(a, b)
                            return a.Number < b.Number
                        end)
                        return orderedRooms
                    end

                    local function getOrderedNodes(pathfindNodes)
                        local orderedNodes = {}
                        for _, node in ipairs(pathfindNodes:GetChildren()) do
                            if node:IsA("BasePart") then
                                table.insert(orderedNodes, node)
                            end
                        end

                        table.sort(orderedNodes, function(a, b)
                            local aNumber = tonumber(a.Name)
                            local bNumber = tonumber(b.Name)
                            if aNumber and bNumber then
                                return aNumber < bNumber
                            elseif aNumber then
                                return true
                            elseif bNumber then
                                return false
                            end
                            return a.Name < b.Name
                        end)
                        return orderedNodes
                    end

                    local function moveSilenceTo(targetGetter)
                        if not isActive() then
                            return false
                        end

                        local movingSilence = silence
                        silenceIsMoving = true

                        while isActive() and silence == movingSilence do
                            local deltaTime = RunService.Heartbeat:Wait()
                            if not isActive() or silence ~= movingSilence then
                                break
                            end

                            if not isJumpScaring then
                                local targetCFrame = targetGetter()
                                if not targetCFrame then
                                    silenceIsMoving = false
                                    return "refresh"
                                end

                                local currentCFrame = movingSilence:GetPivot()
                                local distance = (targetCFrame.Position - currentCFrame.Position).Magnitude

                                if distance <= 0.05 then
                                    if not ceaseFreezeActive then
                                        movingSilence:PivotTo(targetCFrame)
                                        silenceIsMoving = false
                                        return true
                                    end
                                else
                                    local step = SILENCE_SPEED * ceaseSpeedScale * math.min(deltaTime, 0.1)
                                    if step > 0 then
                                        movingSilence:PivotTo(currentCFrame:Lerp(targetCFrame, math.min(step / distance, 1)))
                                    end
                                end
                            end
                        end

                        silenceIsMoving = false
                        return false
                    end

                    local function startPlayerDetection()
                        task.spawn(function()
                            while isActive() do
                                if scanPlayerCrucifixRaycasts() then
                                    return
                                end
                                task.wait(0.05)
                            end
                        end)

                        task.spawn(function()
                            while isActive() do
                                if silenceIsMoving and not ceaseFreezeActive and not isJumpScaring then
                                    local ceaseModel = workspace:FindFirstChild("Cease", true)
                                    if ceaseModel and ceaseModel:IsA("Model")
                                        and not ceaseHandledModels[ceaseModel] then
                                        startCeaseFreeze(ceaseModel)
                                    end
                                end
                                task.wait(0.1)
                            end
                        end)

                        task.spawn(function()
                            local localPlayer = Players.LocalPlayer
                            while isActive() and not hasJumpScared do
                                RunService.Heartbeat:Wait()
                                if not isActive() then
                                    return
                                end

                                local character = localPlayer and localPlayer.Character
                                if character and character:IsDescendantOf(workspace)
                                    and not character:GetAttribute("Hiding") then
                                    local humanoid = character:FindFirstChildWhichIsA("Humanoid")
                                    local currentSilence = silence

                                    if humanoid and humanoid.Health > 0
                                        and currentSilence and currentSilence.Parent then
                                        local entityPosition = currentSilence:GetPivot().Position
                                        local raycastParams = RaycastParams.new()
                                        raycastParams.FilterType = Enum.RaycastFilterType.Exclude
                                        raycastParams.FilterDescendantsInstances = { currentSilence }

                                        local targetParts = {}
                                        local rootPart = character:FindFirstChild("HumanoidRootPart")
                                        if rootPart and rootPart:IsA("BasePart") then
                                            table.insert(targetParts, rootPart)
                                        end

                                        for _, partName in ipairs({ "Head", "UpperTorso", "Torso", "LowerTorso" }) do
                                            local targetPart = character:FindFirstChild(partName)
                                            if targetPart and targetPart:IsA("BasePart") then
                                                table.insert(targetParts, targetPart)
                                            end
                                        end

                                        for _, targetPart in ipairs(targetParts) do
                                            if not isActive() or currentSilence ~= silence then
                                                return
                                            end

                                            local direction = targetPart.Position - entityPosition
                                            local distance = direction.Magnitude

                                            if distance > 0.001 and distance <= DETECTION_DISTANCE then
                                                local result = workspace:Raycast(
                                                    entityPosition,
                                                    direction,
                                                    raycastParams
                                                )
                                                local hitCharacter = result and getCharacterFromHit(result.Instance)
                                                local reachedCharacter = hitCharacter == character

                                                if not reachedCharacter then
                                                    local entryDistance = rayEntryDistanceToPart(
                                                        entityPosition,
                                                        direction.Unit,
                                                        targetPart
                                                    )

                                                    if entryDistance and entryDistance <= distance + 0.01
                                                        and (not result or result.Distance > entryDistance + 0.02) then
                                                        reachedCharacter = true
                                                    end
                                                end

                                                if reachedCharacter then
                                                    if tryUseCrucifix(character) then
                                                        return
                                                    end
                                                    triggerSilenceJumpScare(character)
                                                    return
                                                elseif hitCharacter and hitCharacter ~= character then
                                                    if tryUseCrucifix(hitCharacter) then
                                                        return
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end)
                    end

                    local function executeSilencePathfinding()
                        if isRushSilenceProtectedArea() then
                            return
                        end
                        local loadedSilence = loadModel(SILENCE_ASSET_ID, "SilenceModel")
                        if not loadedSilence then
                            return
                        end

                        if isRushSilenceProtectedArea() then
                            loadedSilence:Destroy()
                            return
                        end
                        local initialRooms = getOrderedRooms()
                        if #initialRooms == 0 then
                            loadedSilence:Destroy()
                            return
                        end

                        local startRoomIndex = 1
                        if #initialRooms > 10 then
                            startRoomIndex = #initialRooms - 8
                        end

                        local startRoom = initialRooms[startRoomIndex].Room
                        local pathfindNodes = startRoom:FindFirstChild("PathfindNodes")
                        local startNode = nil
                        if pathfindNodes then
                            local orderedNodes = getOrderedNodes(pathfindNodes)
                            startNode = orderedNodes[1]
                        end
                        if not startNode then
                            startNode = startRoom:FindFirstChild("RoomExit")
                        end
                        if not startNode or not startNode:IsA("BasePart") then
                            loadedSilence:Destroy()
                            return
                        end

                        if isRushSilenceProtectedArea() or not startNode.Parent then
                            loadedSilence:Destroy()
                            return
                        end
                        silence = loadedSilence
                        silence.Name = "SilenceRush"
                        prepareModel(silence, true)
                        silence:PivotTo(startNode.CFrame + HEIGHT_OFFSET)
                        silence.Parent = workspace
                        -- An ongoing encounter must also end when Seek or the library activates.
                        task.spawn(function()
                            while silence and silence.Parent do
                                if isRushSilenceProtectedArea() then
                                    destroySilence()
                                    local gui = Players.LocalPlayer and Players.LocalPlayer:FindFirstChild("PlayerGui")
                                    local currentJumpscare = gui and gui:FindFirstChild("SilenceRushJumpscare")
                                    if currentJumpscare then
                                        currentJumpscare:Destroy()
                                    end
                                    local sound = SoundService:FindFirstChild("SilenceRushJumpscareSound")
                                    if sound then
                                        sound:Stop()
                                        sound:Destroy()
                                    end
                                    break
                                end
                                task.wait(0.1)
                            end
                        end)
                        isSilenceDespawning = false
                        silenceMoveCancelled = false
                        hasJumpScared = false
                        startPlayerDetection()

                        local startRoomNumber = initialRooms[startRoomIndex].Number
                        local completedRoomNumber = -math.huge
                        local states = {}
                        local missingSince = nil

                        while isActive() do
                            if isJumpScaring then
                                task.wait(0.05)
                            else
                                local rooms = getOrderedRooms()
                                if #rooms == 0 then
                                    if not missingSince then
                                        missingSince = os.clock()
                                    elseif os.clock() - missingSince >= 2 then
                                        break
                                    end
                                    task.wait(0.1)
                                else
                                    local targetRoomNumber = rooms[math.max(1, #rooms - 1)].Number
                                    local currentRoom = nil

                                    for _, data in ipairs(rooms) do
                                        if data.Number >= startRoomNumber
                                            and data.Number > completedRoomNumber
                                            and data.Number <= targetRoomNumber then
                                            currentRoom = data
                                            break
                                        end
                                    end

                                    if not currentRoom then
                                        local latest = getOrderedRooms()
                                        local latestTarget = latest[math.max(1, #latest - 1)]
                                        if latestTarget and completedRoomNumber >= latestTarget.Number then
                                            break
                                        end
                                        if not missingSince then
                                            missingSince = os.clock()
                                        elseif os.clock() - missingSince >= 2 then
                                            break
                                        end
                                        task.wait(0.1)
                                    else
                                        missingSince = nil
                                        local number = currentRoom.Number
                                        local room = currentRoom.Room
                                        local state = states[number]
                                        if not state or state.Model ~= room then
                                            state = { Model = room, Visited = {}, UsedExit = false, EmptySince = nil }
                                            states[number] = state
                                        end

                                        local nodesFolder = room:FindFirstChild("PathfindNodes")
                                        local nextNode = nil
                                        if nodesFolder then
                                            for _, node in ipairs(getOrderedNodes(nodesFolder)) do
                                                if not state.Visited[node.Name] then
                                                    nextNode = node
                                                    break
                                                end
                                            end
                                        end

                                        if nextNode then
                                            local moved = moveSilenceTo(function()
                                                if not room.Parent or not nextNode:IsDescendantOf(room) then
                                                    return nil
                                                end
                                                return nextNode.CFrame + HEIGHT_OFFSET
                                            end)

                                            if moved == true then
                                                state.Visited[nextNode.Name] = true
                                            elseif moved == false then
                                                break
                                            else
                                                task.wait(0.05)
                                            end
                                        else
                                            local orderedNodes = nodesFolder and getOrderedNodes(nodesFolder) or {}
                                            local exit = room:FindFirstChild("RoomExit")
                                            if #orderedNodes == 0 and not state.UsedExit
                                                and exit and exit:IsA("BasePart") then
                                                local moved = moveSilenceTo(function()
                                                    if not room.Parent or not exit:IsDescendantOf(room) then
                                                        return nil
                                                    end
                                                    return exit.CFrame + HEIGHT_OFFSET
                                                end)
                                                if moved == true then
                                                    state.UsedExit = true
                                                elseif moved == false then
                                                    break
                                                end
                                            elseif #orderedNodes > 0 or state.UsedExit then
                                                completedRoomNumber = number
                                            else
                                                if not state.EmptySince then
                                                    state.EmptySince = os.clock()
                                                elseif os.clock() - state.EmptySince >= 2 then
                                                    break
                                                end
                                                task.wait(0.1)
                                            end
                                        end
                                    end
                                end
                            end
                        end

                        if silence and silence.Parent
                            and (isRushSilenceProtectedArea() or (not isJumpScaring and not crucifixActivated)) then
                            destroySilence()
                        end
                    end

                    task.spawn(function()
                        local ok, err = xpcall(executeSilencePathfinding, function(message)
                            return tostring(message)
                        end)
                        if not ok then
                            warn("Hardcore SilenceRush movement failed: " .. tostring(err))
                            if silence and silence.Parent then
                                destroySilence()
                            end
                        end
                    end)
                end, function(message)
                    return tostring(message)
                end)
                if not ok then
                    warn("Hardcore Silence (room rush) failed: " .. tostring(err))
                    -- In the event of an error, do not leave an old rushing entity.
                    local leaked = workspace:FindFirstChild("SilenceRush")
                    if leaked then
                        leaked:Destroy()
                    end
                end
            end
        end)

        -- Frostbite (365s variant) must not spawn during the library or Seek.
        local function isFrostbiteProtectedArea()
            local rooms = workspace:FindFirstChild("CurrentRooms")
            local gameData = game.ReplicatedStorage:FindFirstChild("GameData")
            local latest = gameData and gameData:FindFirstChild("LatestRoom")
            local number = latest and tonumber(latest.Value)
            if number == 50 then
                return true
            end
            if rooms and rooms:FindFirstChild("50") and number
                and number >= 49 and number <= 50 then
                return true
            end
            if workspace:FindFirstChild("SeekMovingNewClone")
                or workspace:FindFirstChild("SeekMov") then
                return true
            end
            if vu31 and vu31.MainGame and vu31.MainGame.chase then
                return true
            end
            return false
        end

        spawn(function()
            getgenv().death = false
            local function vu529()
                while true do
                    task.wait(365)
                    -- Original Frostbite fires after a door/room transition.
                    game.ReplicatedStorage.GameData.LatestRoom:GetPropertyChangedSignal("Value"):Wait()
                    -- This event is skipped, but the timer remains active, when protected.
                    if isFrostbiteProtectedArea() then
                        continue
                    end
                    function DEATHMESSAGE(pu506, pu507)
                        local replicatedStorage = game:GetService("ReplicatedStorage")
                        local player = game.Players.LocalPlayer
                        local gameStats = replicatedStorage:FindFirstChild("GameStats")
                        local playerStats = gameStats and gameStats:FindFirstChild("Player_" .. player.Name)
                        local total = playerStats and playerStats:FindFirstChild("Total")
                        local deathCause = total and total:FindFirstChild("DeathCause")
                        if deathCause then
                            deathCause.Value = pu507
                        end
                    end
                    if isFrostbiteProtectedArea() then
                        continue
                    end
                    task.wait(0.01)
                    if isFrostbiteProtectedArea() then
                        continue
                    end
                    local v508 = game.Players.LocalPlayer
                    local vu509 = workspace.CurrentCamera
                    local vu510 = v508.Character
                    game:GetService("ReplicatedStorage")
                    local frostbiteFreezeActive = false
                    local v512 = require(game.ReplicatedStorage:WaitForChild("CameraShaker")).new(Enum.RenderPriority.Camera.Value, function(p511)
                        if not frostbiteFreezeActive then
                            vu509.CFrame = vu509.CFrame * p511
                        end
                    end)
                    v512:Start()
                    if isFrostbiteProtectedArea() then
                        pcall(function() v512:Stop() end)
                        continue
                    end
                    local v513 = Instance.new("Model", game:GetService("Lighting"))
                    local v514 = vu5:Clone()
                    local v515 = v514.FrostyNew
                    local v516 = v515.Attachment
                    if isFrostbiteProtectedArea() then
                        pcall(function() v512:Stop() end)
                        v514:Destroy()
                        v513:Destroy()
                        continue
                    end
                    v513:Destroy()
                    local currentRoomId = tostring(game:GetService("ReplicatedStorage").GameData.LatestRoom.Value)
                    local v517 = workspace.CurrentRooms:FindFirstChild(currentRoomId)
                    if not v517 then
                        pcall(function() v512:Stop() end)
                        v514:Destroy()
                        continue
                    end
                    local nodeFolder = v517:FindFirstChild("Nodes") or v517:FindFirstChild("PathfindNodes")
                    local spawnPart
                    if nodeFolder then
                        local nodes = {}
                        for _, node in ipairs(nodeFolder:GetChildren()) do
                            if node:IsA("BasePart") then
                                table.insert(nodes, node)
                            end
                        end
                        table.sort(nodes, function(a, b)
                            local na, nb = tonumber(a.Name), tonumber(b.Name)
                            if na and nb then
                                return na < nb
                            elseif na then
                                return true
                            elseif nb then
                                return false
                            end
                            return a.Name < b.Name
                        end)
                        local v518 = math.max(1, math.floor(#nodes / 2))
                        spawnPart = nodes[v518]
                    end
                    if not spawnPart then
                        for _, candidateName in ipairs({v517.Name, "RoomEntrance", "RoomExit"}) do
                            local candidate = v517:FindFirstChild(candidateName)
                            if candidate and candidate:IsA("BasePart") then
                                spawnPart = candidate
                                break
                            end
                        end
                        if not spawnPart then
                            spawnPart = v517.PrimaryPart
                        end
                    end
                    if not spawnPart then
                        pcall(function()
                            v512:Stop()
                        end)
                        v514:Destroy()
                        continue
                    end
                    if isFrostbiteProtectedArea() then
                        pcall(function() v512:Stop() end)
                        v514:Destroy()
                        continue
                    end
                    v515.CFrame = spawnPart.CFrame + Vector3.new(0, 11, 0)
                    v514.Parent = workspace
                    local v519 = Instance.new("ColorCorrectionEffect")
                    v519.Parent = game:GetService("Lighting")
                    v519.TintColor = Color3.new(1, 1, 1)
                    v519.Enabled = false
                    local v520 = v512:StartShake(3.6, 55, 5)
                    local frostbiteLighterStates = setmetatable({}, {__mode = "k"})
                    local frostbiteLighterConnections = {}
                    local frostbiteLighterDebug = false
                    local frostbiteEventActive = true
                    local frostbiteFreezeBusy = false
                    local frostbiteFreezeFactor = 1
                    local frostbiteEffects = {}
                    local frostbiteSeenCease = setmetatable({}, {__mode = "k"})
                    local frostbiteStaticTween = nil
                    local frostbiteShakerStopped = false

                    local function registerFrostbiteEffect(object)
                        if frostbiteEffects[object] then
                            return
                        end
                        if object:IsA("ParticleEmitter") then
                            frostbiteEffects[object] = {"particle", object.TimeScale}
                        elseif object:IsA("Sound") then
                            frostbiteEffects[object] = {"sound", object.PlaybackSpeed, object.Volume}
                        else
                            return
                        end
                        local state = frostbiteEffects[object]
                        if frostbiteFreezeBusy then
                            pcall(function()
                                if state[1] == "particle" then
                                    object.TimeScale = state[2] * frostbiteFreezeFactor
                                else
                                    object.PlaybackSpeed = state[2] * frostbiteFreezeFactor
                                    object.Volume = state[3] * frostbiteFreezeFactor
                                end
                            end)
                        end
                    end

                    local function applyFrostbiteFreeze(factor)
                        frostbiteFreezeFactor = factor
                        for object, state in pairs(frostbiteEffects) do
                            if object.Parent then
                                pcall(function()
                                    if state[1] == "particle" then
                                        object.TimeScale = state[2] * factor
                                    else
                                        object.PlaybackSpeed = state[2] * factor
                                        object.Volume = state[3] * factor
                                    end
                                end)
                            else
                                frostbiteEffects[object] = nil
                            end
                        end
                    end

                    local function restoreFrostbiteEffects()
                        for object, state in pairs(frostbiteEffects) do
                            if object.Parent then
                                pcall(function()
                                    if state[1] == "particle" then
                                        object.TimeScale = state[2]
                                    else
                                        object.PlaybackSpeed = state[2]
                                        object.Volume = state[3]
                                    end
                                end)
                            end
                            frostbiteEffects[object] = nil
                        end
                        frostbiteFreezeFactor = 1
                    end

                    local function restoreFrostbiteShake()
                        if frostbiteShakerStopped then
                            frostbiteShakerStopped = false
                            pcall(function()
                                v512:Start()
                            end)
                        end
                    end

                    local function applyFrostbiteFreezeTween(startFactor, endFactor, duration)
                        local started = os.clock()
                        while frostbiteEventActive do
                            local alpha = math.clamp((os.clock() - started) / duration, 0, 1)
                            local eased = alpha * alpha * (3 - 2 * alpha)
                            applyFrostbiteFreeze(startFactor + (endFactor - startFactor) * eased)
                            if alpha >= 1 then
                                return true
                            end
                            game:GetService("RunService").Heartbeat:Wait()
                        end
                        return false
                    end

                    local function startFrostbiteCease(cease)
                        if not frostbiteEventActive or frostbiteFreezeBusy or frostbiteSeenCease[cease] then
                            return
                        end
                        frostbiteSeenCease[cease] = true
                        frostbiteFreezeBusy = true
                        frostbiteFreezeActive = true
                        frostbiteShakerStopped = true
                        pcall(function()
                            v512:Stop()
                        end)
                        if frostbiteStaticTween and frostbiteStaticTween.PlaybackState == Enum.PlaybackState.Playing then
                            frostbiteStaticTween:Pause()
                        end
                        for _, object in ipairs(v514:GetDescendants()) do
                            registerFrostbiteEffect(object)
                        end
                        task.spawn(function()
                            if not applyFrostbiteFreezeTween(frostbiteFreezeFactor, 0, 2.25) then
                                return
                            end
                            local holdStarted = os.clock()
                            while frostbiteEventActive and os.clock() - holdStarted < 13 do
                                applyFrostbiteFreeze(0)
                                game:GetService("RunService").Heartbeat:Wait()
                            end
                            if not frostbiteEventActive then
                                return
                            end
                            if not applyFrostbiteFreezeTween(0, 1, 2) then
                                return
                            end
                            restoreFrostbiteEffects()
                            if frostbiteStaticTween and frostbiteStaticTween.PlaybackState == Enum.PlaybackState.Paused then
                                frostbiteStaticTween:Play()
                            end
                            frostbiteFreezeBusy = false
                            frostbiteFreezeActive = false
                            restoreFrostbiteShake()
                        end)
                    end

                    local frostbiteDescendantConnection = v514.DescendantAdded:Connect(function(object)
                        if frostbiteFreezeBusy then
                            registerFrostbiteEffect(object)
                        end
                    end)

                    task.spawn(function()
                        while frostbiteEventActive and v514.Parent do
                            local cease = workspace:FindFirstChild("Cease")
                            if cease and cease:IsA("Model") then
                                startFrostbiteCease(cease)
                            end
                            task.wait(0.1)
                        end
                    end)

                    local function endFrostbiteCease()
                        for _, connection in ipairs(frostbiteLighterConnections) do
                            connection:Disconnect()
                        end
                        table.clear(frostbiteLighterConnections)
                        frostbiteEventActive = false
                        frostbiteFreezeActive = false
                        frostbiteFreezeBusy = false
                        if frostbiteDescendantConnection then
                            frostbiteDescendantConnection:Disconnect()
                        end
                        restoreFrostbiteEffects()
                        if frostbiteStaticTween and frostbiteStaticTween.PlaybackState == Enum.PlaybackState.Paused then
                            frostbiteStaticTween:Play()
                        end
                        restoreFrostbiteShake()
                    end
                    v516.face.Enabled = false
                    v516.BlackTrail.Enabled = false
                    v516.Heylois.Enabled = false
                    v516.smoke.Enabled = true
                    v516.BlackTrai3l.Enabled = true
                    v516.BlackTrai2l.Enabled = true
                    v515.Part.ParticleEmitter.Enabled = false
                    v515["Static Effect"]:Play()
                    wait(5)
                    v515["Static Effect"]:Play()
                    frostbiteStaticTween = game.TweenService:Create(v515["Static Effect"], TweenInfo.new(2), {
                        Pitch = 0
                    })
                    frostbiteStaticTween:Play()
                    if frostbiteFreezeActive then
                        frostbiteStaticTween:Pause()
                    end
                    v520:StartFadeOut(2.5)
                    wait(2)
                    local v521 = v512:StartShake(2, 55, 25, nil, Vector3.new(5, 5, 5))
                    local frostbiteBlueTween = game.TweenService:Create(v519, TweenInfo.new(7), {
                        TintColor = Color3.new(0.00784314, 0.188235, 1)
                    })
                    frostbiteBlueTween:Play()
                    local vu522 = true

                    local function findFrostbiteLighter(character)
                        if not character then
                            return nil
                        end
                        local exact = character:FindFirstChild("Lighter")
                        if exact then
                            return exact
                        end
                        for _, child in ipairs(character:GetChildren()) do
                            local name = string.lower(child.Name)
                            if string.find(name, "lighter", 1, true) then
                                return child
                            end
                        end
                        return nil
                    end

                    local function getFrostbiteEnabledEffect(instance)
                        if instance:IsA("ParticleEmitter") or instance:IsA("Fire")
                            or instance:IsA("PointLight") or instance:IsA("SpotLight")
                            or instance:IsA("SurfaceLight") or instance:IsA("Beam")
                            or instance:IsA("Trail") or instance:IsA("Smoke")
                            or instance:IsA("Sparkles") then
                            return instance.Enabled
                        end
                        return nil
                    end

                    local function getFrostbiteVisualState(attachOn)
                        if not attachOn then
                            return nil
                        end
                        local hasEffect = false
                        local anyEnabled = false
                        local function checkEffect(object)
                            local enabled = getFrostbiteEnabledEffect(object)
                            if enabled ~= nil then
                                hasEffect = true
                                if enabled then
                                    anyEnabled = true
                                end
                            end
                        end
                        checkEffect(attachOn)
                        for _, object in ipairs(attachOn:GetDescendants()) do
                            checkEffect(object)
                        end
                        if hasEffect then
                            return anyEnabled
                        end
                        return nil
                    end

                    local function getFrostbiteBooleanState(lighter, effectsHolder, attachOn)
                        local stateNames = {
                            "IsLit", "Lit", "IsOn", "On", "Ignited",
                            "IsIgnited", "LightOn", "IsActivated", "Using", "IsUsing"
                        }
                        for _, container in ipairs({lighter, effectsHolder or lighter, attachOn or lighter}) do
                            for _, name in ipairs(stateNames) do
                                local attribute = container:GetAttribute(name)
                                if typeof(attribute) == "boolean" then
                                    return attribute
                                end
                                local value = container:FindFirstChild(name)
                                if value and value:IsA("BoolValue") then
                                    return value.Value
                                end
                            end
                        end
                        return nil
                    end

                    local function watchFrostbiteLighter(lighter)
                        if not lighter:IsA("Tool") or frostbiteLighterStates[lighter] then
                            return
                        end
                        local state = {active = false, activated = false}
                        frostbiteLighterStates[lighter] = state
                        table.insert(frostbiteLighterConnections, lighter.Activated:Connect(function()
                            state.active = not state.active
                            state.activated = true
                        end))
                        table.insert(frostbiteLighterConnections, lighter.Unequipped:Connect(function()
                            state.active = false
                            state.activated = false
                        end))
                    end

                    local function isFrostbiteLighterLit(character)
                        local lighter = findFrostbiteLighter(character)
                        if not lighter then
                            return false
                        end
                        watchFrostbiteLighter(lighter)
                        local effectsHolder = lighter:FindFirstChild("EffectsHolder", true)
                        local attachOn = effectsHolder and effectsHolder:FindFirstChild("AttachOn", true)
                        if not attachOn then
                            attachOn = lighter:FindFirstChild("AttachOn", true)
                        end
                        if not attachOn then
                            local characterHolder = character:FindFirstChild("EffectsHolder", true)
                            if characterHolder then
                                effectsHolder = characterHolder
                                attachOn = characterHolder:FindFirstChild("AttachOn", true)
                            end
                        end
                        local visualState = getFrostbiteVisualState(attachOn)
                        if visualState == true then
                            return true
                        end
                        local booleanState = getFrostbiteBooleanState(lighter, effectsHolder, attachOn)
                        if booleanState == true then
                            return true
                        end
                        local state = frostbiteLighterStates[lighter]
                        if state and state.activated then
                            return state.active
                        end
                        if booleanState ~= nil then
                            return booleanState
                        end
                        if visualState ~= nil then
                            return visualState
                        end
                        if frostbiteLighterDebug then
                            warn("Frostbite lighter: no usable on/off effect", lighter:GetFullName(),
                                "holder:", effectsHolder and effectsHolder:GetFullName() or "none",
                                "AttachOn:", attachOn and attachOn:GetFullName() or "none")
                        end
                        return state ~= nil and state.activated and state.active or false
                    end

                    spawn(function()
                        while wait(1) and vu522 do
                            if not frostbiteFreezeActive then
                                local activeCharacter = v508.Character
                                local v523 = activeCharacter and activeCharacter:FindFirstChildOfClass("Humanoid")
                                if v523 and v523.Health > 0 then
                                    local lighterLit = isFrostbiteLighterLit(activeCharacter)
                                    if not lighterLit then
                                        if frostbiteLighterDebug then
                                            warn("Frostbite damage: Lighter not detected as active")
                                        end
                                        if v523.Health <= 5 then
                                            DEATHMESSAGE({
                                                "You died to who you call Frostbite...",
                                                "He will spawn in the middle and start freezing the room.",
                                                "Find something that has heat to keep you warm!"
                                            }, "FrostBite")
                                        end
                                        v523:TakeDamage(5)
                                    elseif frostbiteLighterDebug then
                                        print("Frostbite damage blocked: Lighter active")
                                    end
                                end
                            end
                        end
                    end)
                    v519.Enabled = true
                    v516.face.Enabled = true
                    v516.BlackTrail.Enabled = true
                    v516.Heylois.Enabled = true
                    v516.smoke.Enabled = true
                    v516.BlackTrai3l.Enabled = true
                    v516.BlackTrai2l.Enabled = true
                    v515.Part.ParticleEmitter.Enabled = true
                    v515.Ambience:Play()
                    v515.AmbienceFar:Play()
                    game:GetService("ReplicatedStorage").GameData.LatestRoom:GetPropertyChangedSignal("Value"):Wait()
                    local endingInProtectedArea = isFrostbiteProtectedArea()
                    frostbiteBlueTween:Cancel()
                    local frostbiteReturnTween = game.TweenService:Create(v519, TweenInfo.new(7), {
                        TintColor = Color3.new(1, 1, 1)
                    })
                    frostbiteReturnTween.Completed:Once(function(playbackState)
                        if playbackState == Enum.PlaybackState.Completed and v519.Parent then
                            v519:Destroy()
                        end
                    end)
                    frostbiteReturnTween:Play()
                    endFrostbiteCease()
                    vu522 = false
                    v521:StartFadeOut(15)
                    v520:StartFadeOut(1)
                    v515["Static Effect"]:Stop()
                    v515.Ambience:Stop()
                    v515.AmbienceFar:Stop()
                    if endingInProtectedArea then
                        -- Clean up without playing Frostbite's extended outro in room 50 / Seek.
                        pcall(function() v512:Stop() end)
                        v514:Destroy()
                        continue
                    end
                    local v526 = Instance.new("Sound", v515)
                    local v527 = Instance.new("FlangeSoundEffect")
                    local v528 = Instance.new("DistortionSoundEffect")
                    FlangeSoundEffect3 = Instance.new("FlangeSoundEffect")
                    v526.Name = "ahhhhhh"
                    v526.MaxDistance = 500
                    v526.Pitch = 0.23999999463558197
                    v526.PlaybackSpeed = 0.23999999463558197
                    v526.RollOffMode = Enum.RollOffMode.InverseTapered
                    v526.SoundId = "rbxassetid://6305809364"
                    v527.Parent = v526
                    v527.Rate = 0.75
                    v527.Depth = 1
                    v527.Mix = 0.7300000190734863
                    v528.Parent = v526
                    v528.Level = 0.9800000190734863
                    FlangeSoundEffect3.Parent = v526
                    FlangeSoundEffect3.Rate = 0.25
                    FlangeSoundEffect3.Depth = 1
                    FlangeSoundEffect3.Mix = 1
                    v526:Play()
                    v516.face.Enabled = false
                    v516.BlackTrail.Enabled = false
                    v516.Heylois.Enabled = false
                    v516.smoke.Enabled = true
                    v516.BlackTrai3l.Enabled = true
                    v516.BlackTrai2l.Enabled = true
                    v515.Part.ParticleEmitter.Enabled = false
                    v526.Ended:Wait()
                    v516.BlackTrai3l.Enabled = false
                    v516.BlackTrai2l.Enabled = false
                    v516.smoke.Enabled = false
                    wait(2)
                    pcall(function()
                        v512:Stop()
                    end)
                    v514:Destroy()
                    -- Schedule another Frostbite event after the next 365-second cycle.
                end
            end
            vu529()
        end)
        function dread()
            local Players = game:GetService("Players")
            local ReplicatedStorage = game:GetService("ReplicatedStorage")
            local Lighting = game:GetService("Lighting")
            local TweenService = game:GetService("TweenService")
            local SoundService = game:GetService("SoundService")
            local Debris = game:GetService("Debris")
            local RunService = game:GetService("RunService")

            local LocalPlayer = Players.LocalPlayer

            local function GetRoom()
                local gruh = workspace:WaitForChild("CurrentRooms")
                return gruh:FindFirstChild(tostring(ReplicatedStorage.GameData.LatestRoom.Value))
            end

            local function LoadCustomInstance(source, parent)
                local model

                for attempt = 1, 3 do
                    local success, result = pcall(function()
                        return game:GetObjects("rbxassetid://" .. tostring(source))[1]
                    end)
                    if success and result then
                        model = result
                        break
                    end
                    task.wait(0.2)
                end

                if not model then
                    warn("Dread model failed to load: " .. tostring(source))
                    return nil
                end

                for _, obj in ipairs(model:GetDescendants()) do
                    if obj:IsA("Script") or obj:IsA("LocalScript") then
                        obj:Destroy()
                    end
                end

                pcall(function()
                    model:SetAttribute("LoadedByExecutor", true)
                end)
                model.Parent = parent or workspace
                return model
            end

            if not Lighting:FindFirstChild("Ambience_Dread") then
                Instance.new("ColorCorrectionEffect", Lighting).Name = "Ambience_Dread"
            end

            local dreadLighting = Lighting
            local dreadMainCorrection = dreadLighting:FindFirstChild("MainColorCorrection")
            local dreadOriginalCorrection = dreadMainCorrection and {
                Brightness = dreadMainCorrection.Brightness,
                Contrast = dreadMainCorrection.Contrast,
                Saturation = dreadMainCorrection.Saturation,
                TintColor = dreadMainCorrection.TintColor,
                Enabled = dreadMainCorrection.Enabled
            }
            local dreadOriginalCameraType = workspace.CurrentCamera and workspace.CurrentCamera.CameraType
            local dreadShake = nil
            local dreadDeadConnection = nil
            local dreadCharacterConnection = nil
            local dreadVisualsRestored = false
            local dreadHeadFollowName = "DreadHeadFollow_" .. tostring(LocalPlayer.UserId)
                .. "_" .. tostring(math.random(100000, 999999))
            local dreadHeadFollowActive = false
            local dreadLockedRoot = nil
            local dreadRootWasAnchored = nil
            local dreadAnimationTrack = nil
            local dreadAnimationObject = nil

            local function stopDreadHeadFollow()
                if dreadHeadFollowActive then
                    dreadHeadFollowActive = false
                    RunService:UnbindFromRenderStep(dreadHeadFollowName)
                end

                if dreadLockedRoot and dreadLockedRoot.Parent and dreadRootWasAnchored ~= nil then
                    dreadLockedRoot.Anchored = dreadRootWasAnchored
                end
                dreadLockedRoot = nil
                dreadRootWasAnchored = nil

                if dreadAnimationTrack then
                    pcall(function()
                        dreadAnimationTrack:Stop(0)
                    end)
                    dreadAnimationTrack = nil
                end
                if dreadAnimationObject then
                    dreadAnimationObject:Destroy()
                    dreadAnimationObject = nil
                end
            end

            local function restoreDreadVisuals()
                if dreadVisualsRestored then
                    return
                end
                dreadVisualsRestored = true
                stopDreadHeadFollow()

                if dreadMainCorrection and dreadMainCorrection.Parent and dreadOriginalCorrection then
                    for property, value in pairs(dreadOriginalCorrection) do
                        dreadMainCorrection[property] = value
                    end
                end

                local dreadAmbience = dreadLighting:FindFirstChild("Ambience_Dread")
                if dreadAmbience then
                    dreadAmbience.Enabled = false
                end

                if dreadShake then
                    pcall(function()
                        dreadShake:Stop()
                    end)
                end

                local dreadCamera = workspace.CurrentCamera
                if dreadCamera then
                    dreadCamera.CameraType = dreadOriginalCameraType or Enum.CameraType.Custom
                    local aliveCharacter = LocalPlayer.Character
                    local aliveHumanoid = aliveCharacter and aliveCharacter:FindFirstChildOfClass("Humanoid")
                    if aliveHumanoid then
                        dreadCamera.CameraSubject = aliveHumanoid
                    end
                end

                pcall(function()
                    local mainGame = require(LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game)
                    mainGame.stopcam = false
                    mainGame.freemouse = false
                end)

                if dreadDeadConnection then
                    dreadDeadConnection:Disconnect()
                    dreadDeadConnection = nil
                end
                if dreadCharacterConnection then
                    dreadCharacterConnection:Disconnect()
                    dreadCharacterConnection = nil
                end
            end

            local dreadCharacter = LocalPlayer.Character
            local dreadHumanoid = dreadCharacter and dreadCharacter:FindFirstChildOfClass("Humanoid")
            if dreadHumanoid then
                dreadDeadConnection = dreadHumanoid.Died:Connect(restoreDreadVisuals)
            end
            dreadCharacterConnection = LocalPlayer.CharacterAdded:Connect(restoreDreadVisuals)

            local function vu535(p530)
                local v531, v532 = workspace.CurrentCamera:WorldToViewportPoint(p530.Position)
                if v532 then
                    v532 = v531.Z > 0
                end

                local v533 = RaycastParams.new()
                v533.FilterType = Enum.RaycastFilterType.Blacklist
                v533.FilterDescendantsInstances = {p530}

                local v534 = workspace:Raycast(
                    p530.Position,
                    LocalPlayer.Character.UpperTorso.Position - p530.Position,
                    v533
                )

                if v532 then
                    if v534 then
                        v534 = v534.Instance
                    end

                    v532 = v534 ~= nil and v534.Parent == LocalPlayer.Character
                end
                return v532
            end

            local v536 = require(ReplicatedStorage.CameraShaker)
            local vu537 = workspace.CurrentCamera
            local vu539 = v536.new(Enum.RenderPriority.Camera.Value, function(p538)
                vu537.CFrame = vu537.CFrame * p538
            end)
            vu539:Start()
            dreadShake = vu539
            vu539:ShakeOnce(2, 10, 1, 1)

            local vu540 = LoadCustomInstance(140017686556165, workspace)
            if not vu540 then
                restoreDreadVisuals()
                return
            end

            local v541 = GetRoom()
            local roomEntrance = v541 and v541:FindFirstChild("RoomEntrance")
            local vu542 = vu540:IsA("BasePart") and vu540
                or vu540:FindFirstChildWhichIsA("BasePart", true)

            if not roomEntrance or not roomEntrance:IsA("BasePart") or not vu542 then
                warn("Dread spawn failed: current room, RoomEntrance or entity BasePart is missing")
                vu540:Destroy()
                restoreDreadVisuals()
                return
            end

            local spawnCFrame = roomEntrance.CFrame * CFrame.new(0, 1, -15)

            if vu540:IsA("Model") then

                local offset = spawnCFrame * vu542.CFrame:Inverse()
                vu540:PivotTo(offset * vu540:GetPivot())
            else
                vu542.CFrame = spawnCFrame
            end

            local entityPart = vu542:FindFirstChild("Part")
            if entityPart and entityPart:IsA("BasePart") then
                entityPart.CFrame = vu542.CFrame
            end

            Lighting.Ambience_Dread.Enabled = true
            Lighting.Ambience_Dread.Brightness = 0
            Lighting.Ambience_Dread.Contrast = 0
            Lighting.Ambience_Dread.Saturation = 0
            TweenService:Create(Lighting.Ambience_Dread, TweenInfo.new(2), {
                Brightness = 0.1,
                Contrast = 0.2,
                Saturation = -0.7
            }):Play()

            coroutine.wrap(function()
                while not dreadVisualsRestored and vu540.Parent and not vu535(vu542) do
                    task.wait(0.5)
                end
                if dreadVisualsRestored or not vu540.Parent then
                    return
                end
                task.wait(1.5)
                if dreadVisualsRestored or not vu540.Parent then
                    return
                end

                Lighting.Ambience_Dread.Enabled = false
                require(LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).stopcam = true

                local v544 = workspace.CurrentCamera
                local v545 = v544.CFrame
                v544.CameraType = Enum.CameraType.Scriptable

                local v546 = TweenService:Create(
                    v544,
                    TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.In),
                    {CFrame = CFrame.lookAt(v545.p, vu542.Position)}
                )
                v546:Play()
                wait(0.15)

                local dreadSoundsFolder = workspace:FindFirstChild("HardCoreSound")
                local dreadJumpSource = dreadSoundsFolder and dreadSoundsFolder:FindFirstChild("DreadJump")
                if dreadJumpSource and dreadJumpSource:IsA("Sound") then
                    local dreadJumpSound = dreadJumpSource:Clone()
                    dreadJumpSound.Looped = false
                    dreadJumpSound.TimePosition = 0
                    dreadJumpSound.Parent = SoundService
                    dreadJumpSound.Ended:Once(function()
                        dreadJumpSound:Destroy()
                    end)
                    dreadJumpSound:Play()
                    Debris:AddItem(dreadJumpSound, 30)
                else

                end

                v546:Pause()

                local v547, v548, v549 = pairs(workspace:GetDescendants())
                while true do
                    local v550
                    v549, v550 = v547(v548, v549)
                    if v549 == nil then
                        break
                    end
                    if v550.ClassName == "ParticleEmitter" then
                        v550.TimeScale = 0
                    end
                end

                task.wait(2)
                if dreadVisualsRestored then return end
                if dreadMainCorrection and dreadMainCorrection.Parent then
                    dreadMainCorrection.Brightness = -1
                    dreadMainCorrection.Contrast = -4
                    dreadMainCorrection.Saturation = -1
                end

                local v551 = vu542
                local v552, v553, v554 = pairs(v551:GetDescendants())
                while true do
                    local v555
                    v554, v555 = v552(v553, v554)
                    if v554 == nil then
                        break
                    end
                    if v555.Name == "PointLight" then
                        v555:Destroy()
                    end
                end

                vu539:ShakeOnce(10, 100, 0.1, 2)
                task.wait(1)
                if dreadVisualsRestored then return end

                local v556 = require(LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game)
                v556.stopcam = false
                v556.freemouse = false
                task.wait(0.4)
                if dreadVisualsRestored then return end

                local character = LocalPlayer.Character
                local humanoid = character and character:FindFirstChildOfClass("Humanoid")
                local humrootpart = character and character:FindFirstChild("HumanoidRootPart")
                local head = character and character:FindFirstChild("Head")
                if not (humanoid and humrootpart and head) or humanoid.Health <= 0 then
                    warn("Dread death animation skipped: character parts are missing")
                    return
                end

                local HotSex = Instance.new("Animation")
                HotSex.AnimationId = "rbxassetid://10096088747"
                dreadAnimationObject = HotSex

                local ok, animationError = pcall(function()
                    local animator = humanoid:FindFirstChildOfClass("Animator")
                    if not animator then
                        animator = Instance.new("Animator")
                        animator.Parent = humanoid
                    end
                    local HotSexOnHumanoid = animator:LoadAnimation(HotSex)
                    dreadAnimationTrack = HotSexOnHumanoid
                    HotSexOnHumanoid:Play()

                    dreadLockedRoot = humrootpart
                    dreadRootWasAnchored = humrootpart.Anchored
                    humrootpart.Anchored = true

                    v556.stopcam = true
                    local camera = workspace.CurrentCamera
                    camera.CameraType = Enum.CameraType.Scriptable

                    dreadHeadFollowActive = true
                    RunService:BindToRenderStep(
                        dreadHeadFollowName,
                        Enum.RenderPriority.Camera.Value - 1,
                        function()
                            if not dreadHeadFollowActive or dreadVisualsRestored or not head.Parent then
                                return
                            end
                            local currentCamera = workspace.CurrentCamera
                            if currentCamera then
                                currentCamera.CFrame = currentCamera.CFrame:Lerp(head.CFrame, 0.3)
                            end
                        end
                    )

                    vu539:ShakeOnce(10, 100, 0.1, 2)

                    vu539:ShakeOnce(2, 12, 0.2, 10)

                    humrootpart.CFrame = humrootpart.CFrame + Vector3.new(0, 1, 0)

                    local function nextAnimationStep(seconds)
                        task.wait(seconds)
                        return not dreadVisualsRestored and humanoid.Health > 0
                            and character == LocalPlayer.Character
                    end

                    HotSexOnHumanoid:AdjustSpeed(0.8)
                    if not nextAnimationStep(0.5) then return end
                    HotSexOnHumanoid:AdjustSpeed(0.25)
                    if not nextAnimationStep(3.5) then return end
                    HotSexOnHumanoid:AdjustSpeed(-0.2)
                    if not nextAnimationStep(0.1) then return end
                    HotSexOnHumanoid:AdjustSpeed(-0.4)
                    if not nextAnimationStep(0.2) then return end
                    HotSexOnHumanoid:AdjustSpeed(0.1)
                    if not nextAnimationStep(0.2) then return end
                    HotSexOnHumanoid:AdjustSpeed(-0.25)
                    if not nextAnimationStep(1.5) then return end
                    HotSexOnHumanoid:AdjustSpeed(-0.15)
                    if not nextAnimationStep(2) then return end
                    HotSexOnHumanoid:AdjustSpeed(0)
                    nextAnimationStep(2)
                end)

                if not ok then
                    warn("Dread death animation failed: " .. tostring(animationError))
                end

                stopDreadHeadFollow()
                if dreadVisualsRestored then return end

                v556.stopcam = false
                v556.freemouse = false

                local damage = 999
                if humanoid.Health <= damage then
                    local gameStats = ReplicatedStorage:FindFirstChild("GameStats")
                    local playerStats = gameStats and gameStats:FindFirstChild("Player_" .. LocalPlayer.Name)
                    local total = playerStats and playerStats:FindFirstChild("Total")
                    local deathCause = total and total:FindFirstChild("DeathCause")
                    if deathCause then
                        deathCause.Value = "Dread"
                    end
                end

                humanoid:TakeDamage(damage)
            end)()

            coroutine.wrap(function()
                ReplicatedStorage.GameData.LatestRoom.Changed:Wait()
                task.wait()
                ReplicatedStorage.GameData.LatestRoom.Changed:Wait()
                task.wait()
                ReplicatedStorage.GameData.LatestRoom.Changed:Wait()

                vu540:Destroy()
                Lighting.Ambience_Dread.Enabled = false
                if not dreadVisualsRestored then
                    restoreDreadVisuals()
                end
            end)()
        end
        -- Scribblet event (user-supplied behavior; separate from A-90).
        local function runScribblet()
            local Players = game:GetService("Players")
            local RunService = game:GetService("RunService")
            local TweenService = game:GetService("TweenService")
            local Lighting = game:GetService("Lighting")
            local ReplicatedStorage = game:GetService("ReplicatedStorage")
            local HttpService = game:GetService("HttpService")
            local SoundService = game:GetService("SoundService")

            local player = Players.LocalPlayer
            if not player then
                return
            end

            local playerGui = player:WaitForChild("PlayerGui")
            local currentRooms = workspace:WaitForChild("CurrentRooms")
            local hardCoreSound = workspace:WaitForChild("HardCoreSound")
            local endSound = hardCoreSound:WaitForChild("EndS")
            local startSound = hardCoreSound:WaitForChild("StartS")

            local INTRO_DURATION = 8
            local BLACKOUT_DURATION = 2
            local HIDE_DURATION = 15
            local ROUND_COUNT = 4
            local FLYBY_MODEL_ID = 119948154036388
            local FLYBY_DISTANCE = 50
            local FLYBY_SPEED = 5
            local FLYBY_DEPTH = 20
            local COUNTDOWN_SOUND_ID = 137727855471828
            local ROUND_BLACKOUT_RELEASE = 9
            local BAR_HEIGHT = 1 / 3
            local BAR_TWEEN_DURATION = 1.35
            local BAR_IMAGE_ID = "rbxassetid://14827943434"
            local FLYBY_DELAY_MIN = 6
            local FLYBY_DELAY_MAX = 18

            local random = Random.new()
            local active = true
            local filterStrength = 0
            local savedObjects = setmetatable({}, { __mode = "k" })
            local trackedSounds = setmetatable({}, { __mode = "k" })
            local flyingModels = {}
            local currentFlybyToken = nil
            local soundAddedConnection = nil
            local stepName = "ScribbletSway_" .. HttpService:GenerateGUID(false)
            local lastCamera = nil
            local lastCameraOffset = CFrame.new()
            local startedAt = os.clock()

            local colorCorrection = Instance.new("ColorCorrectionEffect")
            colorCorrection.Name = "ScribbletColorCorrection"
            colorCorrection.Saturation = 0
            colorCorrection.Contrast = 0
            colorCorrection.Brightness = 0
            colorCorrection.Parent = Lighting

            local gui = Instance.new("ScreenGui")
            gui.Name = "ScribbletExperience"
            gui.IgnoreGuiInset = true
            gui.ResetOnSpawn = false
            gui.DisplayOrder = 900
            gui.Parent = playerGui

            local barGui = Instance.new("ScreenGui")
            barGui.Name = "ScribbletCinematicBars"
            barGui.IgnoreGuiInset = true
            barGui.ResetOnSpawn = false
            barGui.DisplayOrder = -999
            barGui.Parent = playerGui

            local topBar = Instance.new("ImageLabel")
            topBar.Name = "TopBar"
            topBar.BackgroundTransparency = 1
            topBar.Image = BAR_IMAGE_ID
            topBar.ImageTransparency = 1
            topBar.ScaleType = Enum.ScaleType.Stretch
            topBar.Rotation = 180
            topBar.Size = UDim2.fromScale(1, BAR_HEIGHT)
            topBar.Position = UDim2.fromScale(0, -BAR_HEIGHT)
            topBar.ZIndex = 20
            topBar.Parent = barGui

            local bottomBar = Instance.new("ImageLabel")
            bottomBar.Name = "BottomBar"
            bottomBar.BackgroundTransparency = 1
            bottomBar.Image = BAR_IMAGE_ID
            bottomBar.ImageTransparency = 1
            bottomBar.ScaleType = Enum.ScaleType.Stretch
            bottomBar.Size = UDim2.fromScale(1, BAR_HEIGHT)
            bottomBar.AnchorPoint = Vector2.new(0, 1)
            bottomBar.Position = UDim2.fromScale(0, 1 + BAR_HEIGHT)
            bottomBar.ZIndex = 20
            bottomBar.Parent = barGui

            local hideLabel = Instance.new("TextLabel")
            hideLabel.Name = "HideCountdown"
            hideLabel.AnchorPoint = Vector2.new(0.5, 1)
            hideLabel.Position = UDim2.fromScale(0.5, 0.94)
            hideLabel.Size = UDim2.fromScale(0.8, 0.065)
            hideLabel.BackgroundTransparency = 1
            hideLabel.Text = ""
            hideLabel.TextScaled = true
            hideLabel.TextStrokeTransparency = 0.5
            hideLabel.TextStrokeColor3 = Color3.fromRGB(18, 18, 18)
            hideLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
            hideLabel.Visible = false
            hideLabel.ZIndex = 22
            hideLabel.Parent = gui

            local fontLoaded, customFont = pcall(function()
                return Font.fromId(8764312106, Enum.FontWeight.Bold)
            end)

            if fontLoaded and customFont then
                hideLabel.FontFace = customFont
            else
                hideLabel.Font = Enum.Font.GothamBold
            end

            local gradient = Instance.new("UIGradient")
            gradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(105, 105, 105)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(125, 125, 125))
            })
            gradient.Offset = Vector2.new(-0.4, 0)
            gradient.Parent = hideLabel

            local gradientTween = TweenService:Create(
                gradient,
                TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
                { Offset = Vector2.new(0.4, 0) }
            )
            gradientTween:Play()

            local blackoutGui = Instance.new("ScreenGui")
            blackoutGui.Name = "ScribbletBlackoutLayer"
            blackoutGui.IgnoreGuiInset = true
            blackoutGui.ResetOnSpawn = false
            blackoutGui.DisplayOrder = -1000
            blackoutGui.Parent = playerGui

            local blackScreen = Instance.new("Frame")
            blackScreen.Name = "BlackScreen"
            blackScreen.Size = UDim2.fromScale(1, 1)
            blackScreen.BackgroundColor3 = Color3.new(0, 0, 0)
            blackScreen.BackgroundTransparency = 1
            blackScreen.BorderSizePixel = 0
            blackScreen.Active = false
            blackScreen.Parent = blackoutGui

            local function playTween(object, duration, properties)
                local tween = TweenService:Create(
                    object,
                    TweenInfo.new(duration, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
                    properties
                )
                tween:Play()
                return tween
            end

            playTween(topBar, BAR_TWEEN_DURATION, {
                Position = UDim2.fromScale(0, 0),
                ImageTransparency = 0
            })
            playTween(bottomBar, BAR_TWEEN_DURATION, {
                Position = UDim2.fromScale(0, 1),
                ImageTransparency = 0
            })

            local function registerSound(sound)
                if not sound:IsA("Sound") or trackedSounds[sound]
                    or sound == endSound or sound == startSound then
                    return
                end

                local echo = Instance.new("EchoSoundEffect")
                echo.Name = "ScribbletEarlyEcho"
                echo.Delay = 0.25
                echo.Feedback = 0.38
                echo.DryLevel = -2
                echo.WetLevel = -80

                local reverb = Instance.new("ReverbSoundEffect")
                reverb.Name = "ScribbletCathedralReverb"
                reverb.DecayTime = 8.5
                reverb.Density = 0.96
                reverb.Diffusion = 0.92
                reverb.DryLevel = -2
                reverb.WetLevel = -80

                local success = pcall(function()
                    echo.Parent = sound
                    reverb.Parent = sound
                end)

                if not success then
                    echo:Destroy()
                    reverb:Destroy()
                    return
                end

                trackedSounds[sound] = { Echo = echo, Reverb = reverb }
                echo.WetLevel = -80 + 72 * filterStrength
                reverb.WetLevel = -80 + 82 * filterStrength
            end

            local function setFilterStrength(strength)
                filterStrength = math.clamp(strength, 0, 1)
                colorCorrection.Saturation = -filterStrength
                colorCorrection.Contrast = 0.14 * filterStrength
                colorCorrection.Brightness = 0.035 * filterStrength

                for sound, effects in pairs(trackedSounds) do
                    if sound.Parent then
                        if effects.Echo.Parent then
                            effects.Echo.WetLevel = -80 + 72 * filterStrength
                        end
                        if effects.Reverb.Parent then
                            effects.Reverb.WetLevel = -80 + 82 * filterStrength
                        end
                    end
                end
            end

            for _, descendant in ipairs(game:GetDescendants()) do
                if descendant:IsA("Sound") then
                    registerSound(descendant)
                end
            end

            soundAddedConnection = game.DescendantAdded:Connect(function(descendant)
                if active and descendant:IsA("Sound") then
                    registerSound(descendant)
                end
            end)

            RunService:BindToRenderStep(stepName, Enum.RenderPriority.Camera.Value + 2, function()
                if not active then
                    return
                end

                local camera = workspace.CurrentCamera
                if not camera then
                    return
                end

                if lastCamera ~= camera then
                    lastCamera = camera
                    lastCameraOffset = CFrame.new()
                end

                local elapsed = os.clock() - startedAt
                local strength = 0.3 + 0.7 * filterStrength
                local nextOffset = CFrame.new(
                    math.sin(elapsed * 1.65) * 0.045 * strength,
                    math.sin(elapsed * 1.13 + 0.8) * 0.012 * strength,
                    0
                ) * CFrame.Angles(
                    0,
                    0,
                    math.sin(elapsed * 1.4) * math.rad(0.24) * strength
                )

                camera.CFrame = camera.CFrame * lastCameraOffset:Inverse() * nextOffset
                lastCameraOffset = nextOffset
            end)

            local function playSound(sound, waitForEnd)
                if not sound or not sound:IsA("Sound") then
                    return
                end

                sound.Looped = false
                sound.TimePosition = 0

                if not waitForEnd then
                    sound.Playing = true
                    return
                end

                local finished = false
                local connection = sound.Ended:Connect(function()
                    finished = true
                end)
                sound.Playing = true

                local loadDeadline = os.clock() + 5
                while active and sound.Parent and not sound.IsLoaded
                    and not finished and os.clock() < loadDeadline do
                    task.wait(0.05)
                end

                local deadline = os.clock() + math.max(sound.TimeLength + 3, 20)

                while active and sound.Parent and not finished and os.clock() < deadline do
                    task.wait(0.05)
                end

                connection:Disconnect()
            end

            local function saveModelState(model)
                for _, descendant in ipairs(model:GetDescendants()) do
                    if not savedObjects[descendant] then
                        if descendant:IsA("BasePart") then
                            savedObjects[descendant] = {
                                Kind = "Part",
                                Transparency = descendant.Transparency,
                                Color = descendant.Color,
                                CanCollide = descendant.CanCollide,
                                CanTouch = descendant.CanTouch
                            }
                        elseif descendant:IsA("Decal") or descendant:IsA("Texture") then
                            savedObjects[descendant] = {
                                Kind = "Surface",
                                Transparency = descendant.Transparency
                            }
                        elseif descendant:IsA("ProximityPrompt") then
                            savedObjects[descendant] = {
                                Kind = "Prompt",
                                Enabled = descendant.Enabled
                            }
                        elseif descendant:IsA("ClickDetector") then
                            savedObjects[descendant] = {
                                Kind = "Click",
                                Distance = descendant.MaxActivationDistance
                            }
                        end
                    end
                end
            end

            local function restoreObjects()
                for object, state in pairs(savedObjects) do
                    if object.Parent then
                        if state.Kind == "Part" then
                            object.Transparency = state.Transparency
                            object.Color = state.Color
                            object.CanCollide = state.CanCollide
                            object.CanTouch = state.CanTouch
                        elseif state.Kind == "Surface" then
                            object.Transparency = state.Transparency
                        elseif state.Kind == "Prompt" then
                            object.Enabled = state.Enabled
                        elseif state.Kind == "Click" then
                            object.MaxActivationDistance = state.Distance
                        end
                    end
                end
            end

            local function getHidingModels()
                local wardrobes = {}
                local beds = {}

                for _, descendant in ipairs(currentRooms:GetDescendants()) do
                    if descendant:IsA("Model") then
                        if descendant.Name == "Wardrobe" then
                            table.insert(wardrobes, descendant)
                        elseif descendant.Name == "Bed" then
                            table.insert(beds, descendant)
                        end
                    end
                end

                return wardrobes, beds
            end

            local function chooseHidingModel(wardrobes, beds)
                local candidates

                if #wardrobes > 0 and #beds > 0 then
                    candidates = random:NextInteger(1, 2) == 1 and wardrobes or beds
                elseif #wardrobes > 0 then
                    candidates = wardrobes
                else
                    candidates = beds
                end

                if #candidates == 0 then
                    return nil
                end

                return candidates[random:NextInteger(1, #candidates)]
            end

            local function setHidingModelEnabled(model, enabled)
                for _, descendant in ipairs(model:GetDescendants()) do
                    local state = savedObjects[descendant]

                    if state then
                        if state.Kind == "Part" then
                            descendant.Transparency = enabled and state.Transparency or 1
                            descendant.Color = state.Color
                            descendant.CanCollide = enabled and state.CanCollide or false
                            descendant.CanTouch = enabled and state.CanTouch or false
                        elseif state.Kind == "Surface" then
                            descendant.Transparency = enabled and state.Transparency or 1
                        elseif state.Kind == "Prompt" then
                            descendant.Enabled = enabled and state.Enabled or false
                        elseif state.Kind == "Click" then
                            descendant.MaxActivationDistance = enabled and state.Distance or 0
                        end
                    end
                end
            end

            local function disableAllHidingPrompts(models)
                for _, model in ipairs(models) do
                    for _, descendant in ipairs(model:GetDescendants()) do
                        if descendant:IsA("ProximityPrompt") then
                            descendant.Enabled = false
                        elseif descendant:IsA("ClickDetector") then
                            descendant.MaxActivationDistance = 0
                        end
                    end
                end
            end

            local function flickerModels(models, state)
                local parts = {}

                for _, model in ipairs(models) do
                    for _, descendant in ipairs(model:GetDescendants()) do
                        if descendant:IsA("BasePart") then
                            table.insert(parts, descendant)
                        end
                    end
                end

                task.spawn(function()
                    while active and state.Flickering do
                        for _, part in ipairs(parts) do
                            if part.Parent then
                                local white = random:NextNumber() > 0.45
                                part.Color = white
                                    and Color3.fromRGB(245, 245, 245)
                                    or Color3.fromRGB(12, 12, 12)
                            end
                        end
                        task.wait(0.12)
                    end
                end)
            end

            local function loadFlybyModel()
                local success, objects = pcall(function()
                    return game:GetObjects("rbxassetid://" .. tostring(FLYBY_MODEL_ID))
                end)

                local asset = success and objects and objects[1] or nil

                if not asset then
                    local source = ReplicatedStorage:FindFirstChild("ScribbletModel", true)
                    if source then
                        asset = source:Clone()
                    end
                end

                if not asset then
                    return nil
                end

                if not asset:IsA("Model") then
                    local wrapper = Instance.new("Model")
                    asset.Parent = wrapper
                    asset = wrapper
                end

                for _, descendant in ipairs(asset:GetDescendants()) do
                    if descendant:IsA("BasePart") then
                        descendant.Anchored = true
                        descendant.CanCollide = false
                        descendant.CanTouch = false
                        descendant.CanQuery = false
                    elseif descendant:IsA("Script") or descendant:IsA("LocalScript") then
                        descendant.Enabled = false
                    end
                end

                asset.Name = "A120_Scribblet"
                asset.Parent = workspace
                return asset
            end

            local function runFlyby(token)
                local model = loadFlybyModel()
                if not model then
                    return
                end

                flyingModels[model] = true
                local height = random:NextNumber(-1.5, 1.5)
                local startTime = os.clock()
                local duration = FLYBY_DISTANCE / FLYBY_SPEED
                local camera = workspace.CurrentCamera

                if not camera then
                    model:Destroy()
                    flyingModels[model] = nil
                    return
                end

                local fixedCameraCFrame = camera.CFrame

                while active and token.Active and model.Parent do
                    local elapsed = os.clock() - startTime
                    local distanceTravelled = math.min(elapsed * FLYBY_SPEED, FLYBY_DISTANCE)
                    local x = FLYBY_DISTANCE / 2 - distanceTravelled
                    model:PivotTo(
                        fixedCameraCFrame
                        * CFrame.new(x, height, -FLYBY_DEPTH)
                        * CFrame.Angles(0, math.pi, 0)
                    )

                    if elapsed >= duration then
                        break
                    end

                    RunService.RenderStepped:Wait()
                end

                if model.Parent then
                    model:Destroy()
                end
                flyingModels[model] = nil
            end

            local function isHiding()
                local character = player.Character
                return (character and character:GetAttribute("Hiding") == true)
                    or player:GetAttribute("Hiding") == true
            end

            local function isPlayerDead()
                local character = player.Character
                local humanoid = character and character:FindFirstChildWhichIsA("Humanoid")
                return not humanoid or humanoid.Health <= 0
            end

            local function runRoundBlackout(transition)
                local startTime = os.clock()

                while active and transition.Active do
                    local elapsed = os.clock() - startTime
                    local opacity

                    if elapsed < 1.4 then
                        local progress = math.clamp(elapsed / 1.4, 0, 1)
                        local flicker = math.abs(math.sin(elapsed * 29)) * 0.22
                        opacity = math.clamp(progress + flicker * (1 - progress), 0, 1)
                    elseif elapsed < ROUND_BLACKOUT_RELEASE then
                        opacity = 1
                    elseif elapsed < ROUND_BLACKOUT_RELEASE + 1.4 then
                        local progress = math.clamp(
                            (elapsed - ROUND_BLACKOUT_RELEASE) / 1.4, 0, 1
                        )
                        local flicker = math.abs(math.sin(elapsed * 32)) * 0.2
                        opacity = math.clamp(1 - progress - flicker * progress, 0, 1)
                    else
                        break
                    end

                    blackScreen.BackgroundTransparency = 1 - opacity
                    RunService.RenderStepped:Wait()
                end

                blackScreen.BackgroundTransparency = 1
                transition.Done = true
            end

            local function playCountdownSound()
                local sound = Instance.new("Sound")
                sound.Name = "ScribbletHideCountdown"
                sound.SoundId = "rbxassetid://" .. tostring(COUNTDOWN_SOUND_ID)
                sound.Volume = 1.5
                sound.Looped = false
                sound.Parent = SoundService
                registerSound(sound)

                sound.Ended:Connect(function()
                    if sound.Parent then
                        sound:Destroy()
                    end
                end)

                task.delay(60, function()
                    if sound.Parent then
                        sound:Destroy()
                    end
                end)

                playSound(sound, false)
            end

            local function runCountdown()
                hideLabel.Visible = true
                local startTime = os.clock()
                local demonstrationOnly = isPlayerDead()
                local hasBeenOutside = demonstrationOnly or not isHiding()
                local passed = false
                local lastDisplayedSecond = nil

                while active do
                    local elapsed = os.clock() - startTime
                    local remaining = math.max(0, HIDE_DURATION - elapsed)
                    local displayedSecond = math.ceil(remaining)

                    if displayedSecond ~= lastDisplayedSecond then
                        lastDisplayedSecond = displayedSecond
                        hideLabel.Text = "HIDE : " .. tostring(displayedSecond) .. "s"
                        if displayedSecond > 0 then
                            playCountdownSound()
                        end
                    end

                    if not demonstrationOnly then
                        if isPlayerDead() then
                            demonstrationOnly = true
                        elseif not isHiding() then
                            hasBeenOutside = true
                        elseif hasBeenOutside then
                            passed = true
                            break
                        end
                    end

                    if remaining <= 0 then
                        break
                    end

                    RunService.Heartbeat:Wait()
                end

                hideLabel.Visible = false
                return passed or demonstrationOnly
            end

            local function runRound()
                local wardrobes, beds = getHidingModels()
                local allModels = {}

                for _, model in ipairs(wardrobes) do
                    table.insert(allModels, model)
                end

                for _, model in ipairs(beds) do
                    table.insert(allModels, model)
                end

                local chosen = chooseHidingModel(wardrobes, beds)
                if not chosen then
                    return nil
                end

                for _, model in ipairs(allModels) do
                    saveModelState(model)
                end

                restoreObjects()
                disableAllHidingPrompts(allModels)

                local state = { Flickering = true }
                local flybyToken = { Active = true }
                local transition = { Active = true, Done = false }
                currentFlybyToken = flybyToken
                flickerModels(allModels, state)
                task.spawn(function()
                    task.wait(random:NextNumber(FLYBY_DELAY_MIN, FLYBY_DELAY_MAX))
                    if active and flybyToken.Active then
                        runFlyby(flybyToken)
                    end
                end)
                task.spawn(runRoundBlackout, transition)
                playSound(startSound, true)
                while active and not transition.Done do
                    task.wait(0.05)
                end
                transition.Active = false
                state.Flickering = false
                restoreObjects()

                for _, model in ipairs(allModels) do
                    if model.Parent then
                        setHidingModelEnabled(model, model == chosen)
                    end
                end

                local passed = runCountdown()
                return passed
            end

            local function fadeOutAndCleanUp()
                hideLabel.Visible = false
                local start = os.clock()
                local fromStrength = filterStrength
                local fromBlack = blackScreen.BackgroundTransparency

                while os.clock() - start < 2.5 do
                    local progress = math.clamp((os.clock() - start) / 2.5, 0, 1)
                    local eased = progress * progress * (3 - 2 * progress)
                    setFilterStrength(fromStrength * (1 - eased))
                    blackScreen.BackgroundTransparency = fromBlack + (1 - fromBlack) * eased
                    RunService.Heartbeat:Wait()
                end

                setFilterStrength(0)
                restoreObjects()
                active = false

                if currentFlybyToken then
                    currentFlybyToken.Active = false
                end

                if soundAddedConnection then
                    soundAddedConnection:Disconnect()
                end

                for model in pairs(flyingModels) do
                    if model.Parent then
                        model:Destroy()
                    end
                end

                RunService:UnbindFromRenderStep(stepName)

                if lastCamera and lastCamera.Parent then
                    lastCamera.CFrame = lastCamera.CFrame * lastCameraOffset:Inverse()
                end

                for _, effects in pairs(trackedSounds) do
                    if effects.Echo.Parent then
                        effects.Echo:Destroy()
                    end
                    if effects.Reverb.Parent then
                        effects.Reverb:Destroy()
                    end
                end

                colorCorrection:Destroy()
                gradientTween:Cancel()
                playTween(topBar, BAR_TWEEN_DURATION, {
                    Position = UDim2.fromScale(0, -BAR_HEIGHT),
                    ImageTransparency = 1
                })
                playTween(bottomBar, BAR_TWEEN_DURATION, {
                    Position = UDim2.fromScale(0, 1 + BAR_HEIGHT),
                    ImageTransparency = 1
                }).Completed:Wait()
                blackoutGui:Destroy()
                barGui:Destroy()
                gui:Destroy()
            end

            local introStarted = os.clock()

            while active do
                local elapsed = os.clock() - introStarted
                local alpha = math.clamp(elapsed / INTRO_DURATION, 0, 1)
                setFilterStrength(alpha * alpha * (3 - 2 * alpha))

                if alpha >= 1 then
                    break
                end

                RunService.Heartbeat:Wait()
            end

            setFilterStrength(1)
            blackScreen.BackgroundTransparency = 0
            task.wait(BLACKOUT_DURATION)
            playTween(blackScreen, 0.4, { BackgroundTransparency = 1 }).Completed:Wait()
            playSound(endSound, true)

            local won = true
            local startedRounds = 0

            for round = 1, ROUND_COUNT do
                startedRounds = round
                local result = runRound()

                if result == nil then
                    won = false
                    break
                end

                if not result then
                    won = false
                    local character = player.Character
                    local humanoid = character and character:FindFirstChildWhichIsA("Humanoid")
                    if humanoid and humanoid.Health > 0 then
                        humanoid:TakeDamage(400)
                    end
                    break
                end
            end

            if won and startedRounds == ROUND_COUNT then
                blackScreen.BackgroundTransparency = 0
                task.wait(0.18)
                blackScreen.BackgroundTransparency = 1
            end

            playSound(endSound, false)
            fadeOutAndCleanUp()
        end

        function a90()
            local Players = game:GetService("Players")
            local ReplicatedStorage = game:GetService("ReplicatedStorage")
            local TweenService = game:GetService("TweenService")
            local SoundService = game:GetService("SoundService")
            local Player = Players.LocalPlayer
            local Camera = workspace.CurrentCamera
            local PlayerGui = Player:WaitForChild("PlayerGui")
            local MainUI = PlayerGui:WaitForChild("MainUI")
            local Jumpscare = MainUI:WaitForChild("Jumpscare")
            local A90Gui = Jumpscare:WaitForChild("Jumpscare_A90")
            local MainGameFolder = MainUI.Initiator.Main_Game
            local A90Module = MainGameFolder.RemoteListener.Modules.A90
            local MainGame = require(MainGameFolder)
            local CameraShaker = require(ReplicatedStorage:WaitForChild("CameraShaker"))
            local RNG = Random.new()
            if A90Gui:GetAttribute("CustomA90Running") then
                return
            end
            A90Gui:SetAttribute("CustomA90Running", true)
            local Running = true
            local StaticRunning = false
            local Cleaned = false
            local Moved = false
            local Intensity = 0
            local StartLookVector = MainGame.cam.CFrame.LookVector
            local CameraShake = CameraShaker.new(
                Enum.RenderPriority.Camera.Value,
                function(shakeCFrame)
                    if Camera then
                        Camera.CFrame = Camera.CFrame * shakeCFrame
                    end
                end
            )
            CameraShake:Start()
            local function setDeathCause(cause)
                local gameStats = ReplicatedStorage:FindFirstChild("GameStats")

                if not gameStats then
                    return
                end

                local playerStats = gameStats:FindFirstChild("Player_" .. Player.Name)

                if not playerStats then
                    return
                end

                local total = playerStats:FindFirstChild("Total")

                if not total then
                    return
                end

                local deathCause = total:FindFirstChild("DeathCause")

                if deathCause then
                    deathCause.Value = cause
                end
            end

            local function cleanup()
                if Cleaned then
                    return
                end

                Cleaned = true
                Running = false
                StaticRunning = false

                pcall(function()
                    A90Module.Spawn:Stop()
                end)

                pcall(function()
                    CameraShake:Stop()
                end)

                A90Gui:SetAttribute("CustomA90Running", false)
            end

            SoundService.Main.Volume = 0

            A90Gui.Face.Image = "http://www.roblox.com/asset/?id=12635832722"
            A90Gui.FaceAngry.Image = "http://www.roblox.com/asset/?id=12635955412"

            pcall(function()
                A90Module.Spawn.SoundGroup = nil
                A90Module.Hit.SoundGroup = nil
            end)

            A90Module.Spawn:Play()

            A90Gui.BackgroundTransparency = 1
            A90Gui.Face.Visible = true
            A90Gui.FaceAngry.Visible = false
            A90Gui.Static.Visible = true
            A90Gui.Static2.Visible = true
            A90Gui.Static.ImageTransparency = 1
            A90Gui.Static2.ImageTransparency = 1
            A90Gui.Face.ImageColor3 = Color3.new(0, 0, 0)
            A90Gui.Face.Rotation = RNG:NextNumber(-5, 5)

            A90Gui.Face.Position = UDim2.new(
                RNG:NextNumber(10, 90) / 100,
                0,
                RNG:NextNumber(10, 90) / 100,
                0
            )

            A90Gui.Visible = true

            task.wait(0.03)

            A90Gui.Face.ImageColor3 = Color3.new(1, 1, 1)

            task.wait(0.28)

            A90Gui.BackgroundTransparency = 0
            A90Gui.Face.Rotation = 0
            A90Gui.Face.Position = UDim2.new(0.5, 0, 0.49, 0)

            task.wait(0.03)

            A90Gui.StopIcon.Visible = true
            A90Gui.BackgroundColor3 = Color3.new(0, 0, 0)
            A90Gui.BackgroundTransparency = 1
            A90Gui.Static.ImageTransparency = 0.8
            A90Gui.Static2.ImageTransparency = 0.8

            task.delay(0.2, function()
                A90Gui.StopIcon.Visible = false

                while Running do
                    task.wait(0.03)

                    if not Running then
                        break
                    end

                    Intensity += 15

                    local effectIntensity = 100 + Intensity * 0.5
                    local randomColor = math.random(0, 1)

                    A90Gui.Static.Position = UDim2.new(
                        math.random(0, 100) / 100,
                        0,
                        math.random(0, 100) / 100,
                        0
                    )

                    A90Gui.Static.Rotation = math.random(0, 1) * 180

                    A90Gui.Static2.Position = UDim2.new(
                        math.random(0, 100) / 100,
                        0,
                        math.random(0, 100) / 100,
                        0
                    )

                    A90Gui.Static2.Rotation = math.random(0, 1) * 180

                    A90Gui.Face.Position = UDim2.new(
                        0.5,
                        0,
                        0.49,
                        math.random(-1, 1)
                    )

                    A90Gui.FaceAngry.Position = UDim2.new(
                        0.5 + RNG:NextNumber(-effectIntensity, effectIntensity) / 50000,
                        0,
                        0.49 + RNG:NextNumber(-effectIntensity, effectIntensity) / 30000,
                        math.random(-1, 1)
                    )

                    A90Gui.FaceAngry.Rotation =
                        RNG:NextNumber(-1, 1) * (Intensity * 0.0015)

                    A90Gui.FaceAngry.ImageColor3 =
                        Color3.new(1, randomColor, randomColor)

                    if not Moved then
                        local currentCamera = MainGame.cam
                        local humanoid = MainGame.hum

                        if currentCamera and humanoid then
                            local currentLookVector = currentCamera.CFrame.LookVector

                            local cameraMoved =
                                (StartLookVector - currentLookVector).Magnitude > 0.4

                            local playerMoved =
                                humanoid.MoveDirection.Magnitude > 0.4

                            if cameraMoved or playerMoved then
                                Moved = true
                            end
                        end
                    end
                end
            end)

            task.wait(0.3)

            A90Gui.BackgroundColor3 = Color3.new(0, 0, 0)
            A90Gui.BackgroundTransparency = 0
            A90Gui.Static.ImageTransparency = 0
            A90Gui.Static2.ImageTransparency = 0.5

            task.wait(0.03)

            A90Gui.Face.ImageColor3 = Color3.new(1, 0, 0)

            task.wait(0.03)

            A90Gui.Visible = false

            task.wait(0.08)

            if Moved then
                A90Gui.Visible = true
                A90Module.Hit:Play()

                task.wait(0.03)

                A90Gui.Face.ImageColor3 = Color3.new(1, 1, 1)

                task.wait(0.03)

                A90Gui.BackgroundTransparency = 0
                A90Gui.Static.ImageTransparency = 0
                A90Gui.Static2.ImageTransparency = 0.5

                task.wait(0.067)

                A90Gui.FaceAngry.Size = UDim2.new(0.8, 0, 0.8, 0)
                A90Gui.FaceAngry.Rotation = 0
                A90Gui.FaceAngry.ImageTransparency = 0
                A90Gui.FaceAngry.ImageColor3 = Color3.new(1, 0, 0)
                A90Gui.FaceAngry.Visible = true

                task.wait(0.067)

                A90Gui.FaceAngry.ImageColor3 = Color3.new(1, 1, 1)
                A90Gui.Face.Visible = false

                task.wait(0.75)

                Running = false

                task.wait()

                local Character = Player.Character
                local Humanoid =
                    Character
                    and Character:FindFirstChildOfClass("Humanoid")

                if Humanoid and Humanoid.Health > 0 then
                    local Damage = 70
                    local WillDie = Humanoid.Health <= Damage

                    if WillDie then
                        setDeathCause("A-90")
                    end

                    Humanoid:TakeDamage(Damage)
                end

                task.wait(0.1)

                A90Gui.FaceAngry.Visible = false
                A90Gui.BackgroundColor3 = Color3.new(1, 1, 1)
                A90Gui.Static.ImageTransparency = 1
                A90Gui.Static2.ImageTransparency = 1

                task.wait(0.067)

                A90Gui.BackgroundColor3 = Color3.new(1, 0, 0)

                task.wait(0.067)

                A90Gui.BackgroundColor3 = Color3.new(0, 0, 0)

                task.wait(0.067)

                CameraShake:ShakeOnce(25, 8, 0, 4)

                task.wait(0.03)

                A90Module.Spawn:Stop()

                A90Gui.BackgroundTransparency = 1
                A90Gui.Static.ImageTransparency = 0.5
                A90Gui.Static2.ImageTransparency = 0.5

                TweenService:Create(
                    A90Gui.Static,
                    TweenInfo.new(
                        20,
                        Enum.EasingStyle.Quad,
                        Enum.EasingDirection.Out
                    ),
                    {
                        ImageTransparency = 1
                    }
                ):Play()

                TweenService:Create(
                    A90Gui.Static2,
                    TweenInfo.new(
                        5,
                        Enum.EasingStyle.Quad,
                        Enum.EasingDirection.Out
                    ),
                    {
                        ImageTransparency = 1
                    }
                ):Play()

                local FaceSize = RNG:NextNumber(2, 3)

                A90Gui.FaceAngry.Rotation = RNG:NextNumber(-3, 3)
                A90Gui.FaceAngry.Visible = true
                A90Gui.FaceAngry.ImageColor3 = Color3.new(1, 0, 0)
                A90Gui.FaceAngry.Size = UDim2.new(FaceSize, 0, FaceSize, 0)

                TweenService:Create(
                    A90Gui.FaceAngry,
                    TweenInfo.new(
                        5,
                        Enum.EasingStyle.Quad,
                        Enum.EasingDirection.Out
                    ),
                    {
                        ImageTransparency = 1
                    }
                ):Play()

                SoundService.Main.Volume = 0

                local Equalizer =
                    SoundService.Main:FindFirstChild("EqualizerSoundEffect")

                if Equalizer then
                    Equalizer.Enabled = true
                    Equalizer.HighGain = -50
                    Equalizer.LowGain = 10
                    Equalizer.MidGain = -50

                    TweenService:Create(
                        Equalizer,
                        TweenInfo.new(
                            15,
                            Enum.EasingStyle.Quint,
                            Enum.EasingDirection.InOut
                        ),
                        {
                            LowGain = 0,
                            HighGain = 0,
                            MidGain = 0
                        }
                    ):Play()
                end

                TweenService:Create(
                    SoundService.Main,
                    TweenInfo.new(
                        5,
                        Enum.EasingStyle.Quint,
                        Enum.EasingDirection.Out
                    ),
                    {
                        Volume = 1
                    }
                ):Play()

                StaticRunning = true

                task.spawn(function()
                    while StaticRunning do
                        task.wait()

                        if not StaticRunning then
                            break
                        end

                        local MaxPosition = 100.1

                        A90Gui.Static.Position = UDim2.new(
                            RNG:NextNumber(0, MaxPosition) / 100,
                            0,
                            RNG:NextNumber(0, MaxPosition) / 100,
                            0
                        )

                        A90Gui.Static.Rotation = math.random(0, 1) * 180

                        A90Gui.Static2.Position = UDim2.new(
                            RNG:NextNumber(0, MaxPosition) / 100,
                            0,
                            RNG:NextNumber(0, MaxPosition) / 100,
                            0
                        )

                        A90Gui.Static2.Rotation = math.random(0, 1) * 180
                    end
                end)

                task.wait(20)

                StaticRunning = false
                A90Gui.Visible = false
                A90Gui.BackgroundTransparency = 0
                A90Gui.Static.ImageTransparency = 1
                A90Gui.Static2.ImageTransparency = 1

                cleanup()
            else
                Running = false
                A90Module.Spawn:Stop()
                A90Gui.BackgroundTransparency = 1
                A90Gui.Visible = false
                CameraShake:ShakeOnce(5, 10, 0.1, 1)
                SoundService.Main.Volume = 1
                task.wait(1.2)
                cleanup()
            end
        end
        coroutine.wrap(function()
            local v576 = game:GetService("TextChatService")
            local vu577 = game:GetService("Players")
            local vu578 = 0
            function v576.OnIncomingMessage(p579, _)
                local v580 = Instance.new("TextChatMessageProperties")
                if p579.TextSource then
                    msg = string.lower(p579.Text)
                    v580.PrefixText = "<font color=\'#FFFFFF\'>[Player]</font> " .. p579.PrefixText
                    if p579.TextSource.UserId == 530829101 or p579.TextSource.UserId == 7175833073 then
                        v580.PrefixText = "<font color=\'#F53930\'>[Owner\'s Alt]</font> <font color=\'#F53930\'>[OOoSkibidi]</font> " .. p579.PrefixText
                    end
                    if p579.TextSource.UserId == 2763394267 then
                        v580.PrefixText = "<font color=\'#a85232\'>[Noonie]</font> <font color=\'#a85232\'>[:pleading:]</font> " .. p579.PrefixText
                    end
                    if p579.TextSource.UserId == 2300945089 then
                        if msg == "/subscribe" or msg == "/sub" then
                            v580.PrefixText = "<font color=\'#b71109\'>https://www.youtube.com/@kardinhong</font>; " .. p579.PrefixText
                        else
                            v580.PrefixText = "<font color=\'#b71109\'>[Kardin]</font> <font color=\'#b71109\'>[ lolcat is goat ]</font>  <font color=\'#b71109\'>Jiggle Jiggle My Balls</font> " .. p579.PrefixText
                        end
                    end
                    if p579.TextSource.UserId == 4322541912 then
                        v580.PrefixText = "<font color=\'#6865FF\'>[The Nostalgic Idiot]</font> <font color=\'#393B45\'>[nostalgia]</font> " .. p579.PrefixText
                    end
                    if p579.TextSource.UserId == 1520423590 then
                        v580.PrefixText = "<font color=\'#09B711\'>[Ping]</font> <font color=\'#6E3F05\'>[Founder Of Beans]</font> " .. p579.PrefixText
                    end
                    if p579.TextSource.UserId == 3962633044 then
                        v580.PrefixText = "<font color=\'#e2bb6e\'>[Gordon Freeman]</font> <font color=\'#e29b40\'>Master of the Crowbar</font> " .. p579.PrefixText
                    end
                    if p579.TextSource.UserId == 36592998 then
                        v580.PrefixText = "<font color=\'#09B711\'>[Skid Exterminator]</font> <font color=\'#09B711\'>[Very Cool Exterminator]</font> <font color=\'#09B711\'>[La Skid Exterminator Cat V2]</font> " .. p579.PrefixText
                    end
                    local vu581 = vu577:GetPlayerByUserId(p579.TextSource.UserId)
                    if vu581 == game.Players.LocalPlayer then
                        vu578 = vu578 + 1
                        if vu578 == 2 then
                            vu578 = 0
                            return v580
                        end
                    end
                end
                return v580
            end
        end)()
        coroutine.wrap(function()
            while true do
                repeat
                    wait(math.random(90, 125))
                until not workspace:FindFirstChild("SeekMovingNewClone") and (not workspace.CurrentRooms:FindFirstChild("50") and vu32 == true)
                coroutine.wrap(a90)()
            end
        end)()
        -- One Scribblet at a time, using the same post-room-53/Seek/room-50 gate as A-90.
        task.spawn(function()
            local scribbletRunning = false
            while true do
                repeat
                    task.wait(400)
                until not workspace:FindFirstChild("SeekMovingNewClone")
                    and not workspace.CurrentRooms:FindFirstChild("50")
                    and vu32 == true
                if not scribbletRunning then
                    scribbletRunning = true
                    task.spawn(function()
                        local ok, err = pcall(runScribblet)
                        if not ok then
                            warn("Hardcore Scribblet failed: " .. tostring(err))
                        end
                        scribbletRunning = false
                    end)
                end
            end
        end)
        coroutine.wrap(function()
            while true do
                repeat
                    wait(185)
                until not workspace:FindFirstChild("SeekMovingNewClone") and (not workspace.CurrentRooms:FindFirstChild("50") and vu32 == true)
                coroutine.wrap(dread)()
            end
        end)()
    else
        game.ReplicatedStorage.GameStats["Player_" .. game.Players.LocalPlayer.Name].Total.DeathCause.Value = "Error"
        firesignal(game.ReplicatedStorage.RemotesFolder.DeathHint.OnClientEvent, {
            "You need to execute the script at door 0!",
            "Remember this!"
        }, "Blue")
        game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid"):TakeDamage(100)
    end
end
