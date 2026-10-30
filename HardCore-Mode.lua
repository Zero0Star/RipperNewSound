
if workspace:FindFirstChild("hardcoreInit") then
    return
else
    local vu1 = 7
    local vu2 = 0
    local v3 = tick()
    local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()
    local vu4 = Instance.new("Hint")
    vu4.Text = "Started Loading Hardcore"
    function updt()
        game:GetService("RunService").RenderStepped:Wait()
        vu2 = vu2 + 1
        vu4.Text = string.format("Loading Hardcore... %s / %s", tostring(vu2), tostring(vu1))
    end
    local vu5 = game:GetObjects("rbxassetid://85104600103168")[1]
    updt()
    local vu9 = game:GetObjects("rbxassetid://114535306233525")[1]
    updt()
    local vu11 = game:GetObjects("rbxassetid://112131546068049")[1] or nil
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

    function ChangeStyle(p44, p45)
        if (p45 or "Idk") ~= "Chandelier" and seekLightReplacementDelay > 0 then
            return
        end
        wait(0)
        if (p45 or "Idk") == "Chandelier" then
            local v46, v47, v48 = pairs(p44.Assets:GetDescendants())
            while true do
                local v49
                v48, v49 = v46(v47, v48)
                if v48 == nil then
                    break
                end
                if v49.Name == "Chandelier" then
                    v49:Destroy()
                end
            end
        else
            local v50, v51, v52 = pairs(p44.Assets.Light_Fixtures:GetDescendants())
            while true do
                local v53
                v52, v53 = v50(v51, v52)
                if v52 == nil then
                    break
                end
                if v53.Name == "LightStand" then
                    local vu54 = vu11:Clone()
                    vu54.Parent = p44.Assets.Light_Fixtures
                    vu54.LightFixture.PointLight.Changed:Connect(function()
                        vu54.LightFixture.Neon.atachm["Ok you cannot tell me this isnt good"].Enabled = vu54.LightFixture.PointLight.Enabled
                        vu54.LightFixture.Neon["Bright sh idfk"].ParticleEmitter.Enabled = vu54.LightFixture.PointLight.Enabled
                        vu54.LightFixture:WaitForChild("Dust").ParticleEmitter.Enabled = vu54.LightFixture.PointLight.Enabled
                    end)
                    local v55 = vu54
                    vu54.PivotTo(v55, v53:GetPivot())
                    v53:Destroy()
                end
            end
        end
    end
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
    ChangeStyle(v38)
    spawn(function()
        game.ReplicatedStorage.GameData.LatestRoom.Changed:Wait()
    end)
    local vu61 = false
    game.ReplicatedStorage.GameData.LatestRoom.Changed:Connect(function(p62)
        if seekLightReplacementDelay > 0 then
            seekLightReplacementDelay = math.max(seekLightReplacementDelay - 1, 0)
        end

        if vu61 then
            if p62 > 5 or vu33 then
                ChangeStyle(workspace.CurrentRooms[game.ReplicatedStorage.GameData.LatestRoom.Value], "Chandelier")
            end
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
            ChangeStyle(v64)
        else
            if p62 > 52 or vu33 then
                ChangeStyle(workspace.CurrentRooms[game.ReplicatedStorage.GameData.LatestRoom.Value], "Chandelier")
            end
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
            ChangeStyle(v66)
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
    v78.Parent = v67
    v78.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    vu79.Parent = v78
    vu79.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    vu79.BackgroundTransparency = 1
    vu79.Size = UDim2.new(1, 0, 0.998717964, 0)
    vu79.Image = "rbxassetid://190596490"
    vu79.ImageColor3 = Color3.fromRGB(0, 0, 0)
    vu79.ImageTransparency = 1
    local v80 = game:GetService("Players")
    local vu81 = game:GetService("UserInputService")
    local v82 = v80.LocalPlayer
    local vu83 = v82.Character or v82.CharacterAdded:Wait()
    local vu84 = vu83:WaitForChild("Humanoid")
    local vu85 = 100
    local vu86 = 100
    local vu87 = false
    local vu88 = false
    local vu89 = nil
    vu89 = hookmetamethod(game, "__newindex", newcclosure(function(p90, p91, p92)
        if p91 == "WalkSpeed" then
            local v93
            if vu59.MainGame.chase then
                v93 = vu59.MainGame.crouching and 15 or 27
            elseif vu59.MainGame.crouching then
                v93 = isSprinting and 12 or 10
            else
                v93 = isSprinting and 20 or 13
            end
            p92 = vu81.TouchEnabled and vu88 and (vu59.MainGame.chase and 27 or 21) or v93
        end
        return vu89(p90, p91, p92)
    end))
    local vu94 = math.max(7 - 1, 1)
    local vu95 = game.TweenService:Create(vu79, TweenInfo.new(12), {
        ImageTransparency = 0
    })
    if vu81.TouchEnabled then
        local v96 = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
        v96.Name = "StaminaGui"
        v96.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
        v96.Enabled = true
        v96.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        local v97 = Instance.new("TextButton", v96)
        v97.Name = "SprintButton"
        v97.BackgroundTransparency = 0.5
        v97.BackgroundColor3 = Color3.new(0, 0, 0)
        v97.Position = UDim2.new(1, - 300, 1, - 350)
        v97.Size = UDim2.new(0, 65, 0, 65)
        v97.Text = "Sprint"
        v97.TextColor3 = Color3.new(1, 1, 1)
        v97.FontFace = Font.new("rbxasset://fonts/families/Oswald.json", Enum.FontWeight.Light)
        v97.TextScaled = true
        Instance.new("UICorner", v97).CornerRadius = UDim.new(0, 50)
        local v98 = Instance.new("UIStroke", v97)
        v98.ApplyStrokeMode = 0
        v98.Thickness = 2
        v97.MouseButton1Click:Connect(function()
            if not (vu87 or vu59.MainGame.crouching or vu83:GetAttribute("Hiding")) then
                if isSprinting ~= true then
                    isSprinting = true
                    vu84:SetAttribute("SpeedBoost", 4)
                    vu95:Play()
                    while vu81.TouchEnabled and (vu85 > 0 and isSprinting) do
                        vu85 = math.max(vu85 - 1, 0)
                        vu84.WalkSpeed = 21
                        vu75.Size = UDim2.new(1 / vu86 * vu85, 1, 1, 0)
                        task.wait(vu94 / 100)
                    end
                    if vu85 ~= 0 then
                        vu87 = false
                        Spawn(function()
                            vu87 = false
                        end)
                        vu84:SetAttribute("SpeedBoost", 0)
                        game.TweenService:Create(vu79, TweenInfo.new(1), {
                            ImageTransparency = 1
                        }):Play()
                        while not isSprinting do
                            isSprinting = false
                            vu84.WalkSpeed = 12
                            vu85 = math.min(vu85 + 1, vu86)
                            vu75.Size = UDim2.new(1 / vu86 * vu85, 1, 1, 0)
                            task.wait(vu94 / 100)
                        end
                    else
                        isSprinting = false
                        vu84:SetAttribute("SpeedBoost", 0)
                        vu43("You\'re exhausted.")
                        local v99 = Instance.new("Sound", workspace)
                        v99.SoundId = "rbxassetid://8258601891"
                        v99.Volume = 0.8
                        v99.PlayOnRemove = true
                        v99:Destroy()
                        vu87 = true
                        game.TweenService:Create(vu79, TweenInfo.new(0.3), {
                            ImageTransparency = 0
                        }):Play()
                        wait(0.3)
                        game.TweenService:Create(vu79, TweenInfo.new(10), {
                            ImageTransparency = 1
                        }):Play()
                        for v100 = 1, vu86 do
                            vu85 = v100
                            vu75.Size = UDim2.new(1 / vu86 * v100, 1, 1, 0)
                            vu84.WalkSpeed = 12
                            task.wait(vu94 / 80)
                        end
                        vu87 = false
                    end
                else
                    isSprinting = false
                    vu95:Pause()
                    isSprinting = false
                    vu84:SetAttribute("SpeedBoost", 0)
                    game.TweenService:Create(vu79, TweenInfo.new(1), {
                        ImageTransparency = 1
                    }):Play()
                end
            end
        end)
    end
    vu81.InputBegan:Connect(function(p101, p102)
        if not p102 and (p101.KeyCode == Enum.KeyCode.Q and not (vu87 or vu59.MainGame.crouching)) then
            isSprinting = true
            vu84:SetAttribute("SpeedBoost", 4)
            vu95:Play()
            while vu81:IsKeyDown(Enum.KeyCode.Q) and vu85 > 0 do
                vu85 = math.max(vu85 - 1, 0)
                vu84.WalkSpeed = 21
                vu75.Size = UDim2.new(1 / vu86 * vu85, 1, 1, 0)
                task.wait(vu94 / 100)
            end
            vu95:Pause()
            isSprinting = false
            vu84:SetAttribute("SpeedBoost", 0)
            game.TweenService:Create(vu79, TweenInfo.new(1), {
                ImageTransparency = 1
            }):Play()
            vu84.WalkSpeed = 12
            if vu85 ~= 0 then
                vu87 = false
                Spawn(function()
                    vu87 = false
                end)
                game.TweenService:Create(vu79, TweenInfo.new(1), {
                    ImageTransparency = 1
                }):Play()
                while not vu81:IsKeyDown(Enum.KeyCode.Q) do
                    vu85 = math.min(vu85 + 1, vu86)
                    vu75.Size = UDim2.new(1 / vu86 * vu85, 1, 1, 0)
                    vu84.WalkSpeed = 12
                    task.wait(vu94 / 50)
                end
            else
                vu84:SetAttribute("SpeedBoost", 0)
                vu43("You\'re exhausted.")
                local v103 = Instance.new("Sound", workspace)
                v103.SoundId = "rbxassetid://8258601891"
                v103.Volume = 0.8
                v103.PlayOnRemove = true
                v103:Destroy()
                vu87 = true
                game.TweenService:Create(vu79, TweenInfo.new(0.3), {
                    ImageTransparency = 0
                }):Play()
                wait(0.3)
                game.TweenService:Create(vu79, TweenInfo.new(10), {
                    ImageTransparency = 1
                }):Play()
                for v104 = 1, vu86 do
                    vu85 = v104
                    vu75.Size = UDim2.new(1 / vu86 * v104, 1, 1, 0)
                    vu84.WalkSpeed = 12
                    task.wait(vu94 / 50)
                end
                vu87 = false
            end
        end
    end)
    vu84:SetAttribute("SpeedBoost", 0)
    vu84.WalkSpeed = 12
    local vu105 = nil
    local vu106 = false
    vu83.ChildAdded:Connect(function(p107)
        if p107.Name == "Vitamins" then
            local v108 = vu83:FindFirstChild("Vitamins")
            vu105 = v108.Activated:Connect(function()
                if vu106 then
                    return false
                end
                vu106 = true
                vu83.Humanoid.Health = vu83.Humanoid.Health + 30
                vu85 = 100
                task.delay(10, function()
                    vu106 = false
                end)
            end)
            v108.Unequipped:Connect(function()
                vu105:Disconnect()
                print("test")
            end)
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

    local startPosition, waypointPositions = getRoom50Data()
    if not startPosition or #waypointPositions == 0 then
        return
    end

    cachedStartPosition = startPosition
    cachedWaypointPositions = waypointPositions

    local model = loadAssetModel("112572076699068")
    if not model then
        return
    end

    commonSenceModel = model
    commonSenceModel.Name = "Common Sence"
    commonSenceModel.Parent = Workspace

    if not ensurePrimaryPart(commonSenceModel) then
        commonSenceModel:Destroy()
        commonSenceModel = nil
        return
    end

    setObjectCFrame(commonSenceModel, CFrame.new(startPosition + Vector3.new(0, 3, 0)))
    commonSenceActive = true

    local deathMessages = {
        "You were defeated by common sense...",
        "It moves along a fixed path, but it can sense your presence.",
        "When it gets close, it burns the nearby paths.",
        "Keep your distance and find a safe spot"
    }

    local function isCommonSenceActive()
        return commonSenceActive and commonSenceModel == model and model.Parent ~= nil
    end

    setupAttackDetection(model, 10, 90, deathMessages, "Common Sence", isCommonSenceActive)

    task.spawn(function()
        moveThroughWaypointsOnce(model, cachedWaypointPositions, 14, isCommonSenceActive)
    end)

    local stopIconMonitor = startIconGlitchMonitor()

    task.spawn(function()
        latestRoom.Changed:Wait()

        if stopIconMonitor then
            stopIconMonitor()
        end

        commonSenceActive = false

        if commonSenceModel == model then
            if model and model.Parent then
                model:Destroy()
            end
            commonSenceModel = nil
        end
    end)

    task.delay(120, function()
        spawnA60()
    end)
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
        local vu139 = 1
        local vu140 = {
            {
                "rbxassetid://11881132074",
                "Despair"
            },
            {
                "rbxassetid://11881132745",
                "Odd feline Specimen"
            },
            {
                "rbxassetid://11881654771",
                "A tryhard..."
            },
            {
                "rbxassetid://7084794697",
                "him."
            }
        }
        game:GetService("ReplicatedStorage").GameData.LatestRoom.Changed:Connect(function()
            local v141 = workspace.CurrentRooms[game:GetService("ReplicatedStorage").GameData.LatestRoom.Value]
            if v141:FindFirstChild("Assets") then
                local v142 = next
                local v143, v144 = v141:FindFirstChild("Assets"):GetChildren()
                local v145 = {}
                while true do
                    local v146
                    v144, v146 = v142(v143, v144)
                    if v144 == nil then
                        break
                    end
                    if v146.Name:find("Painting") then
                        table.insert(v145, v146)
                    end
                end
                if # v145 > 0 then
                    local v147
                    if v145[# v145] then
                        vu139 = vu139 + 1
                        v147 = v145[# v145]
                    else
                        v147 = v145[1]
                    end
                    if v147 and v147:FindFirstChild("Canvas") then
                        local vu148 = vu140[math.random(1, # vu140)]
                        if v147:FindFirstChild("InteractPrompt") then
                            local v149 = v147:FindFirstChild("InteractPrompt"):Clone()
                            v149.Name = "fakeInteract"
                            v149.Parent = v147
                            v147:FindFirstChild("InteractPrompt"):Destroy()
                            v149.Triggered:Connect(function()
                            end)
                        end
                        vu43(string.gsub("This painting is titled \"NAMEOFTHING\"", "NAMEOFTHING", vu148[2]))v147:FindFirstChild("Canvas"):FindFirstChildOfClass("SurfaceGui"):FindFirstChildOfClass("ImageLabel").Image = vu148[1]
                    end
                end
            end
        end)
  
        task.spawn(function()
            while task.wait(450) do
                if workspace:FindFirstChild("SeekMovingNewClone") or workspace.CurrentRooms:FindFirstChild("50") then
                    break
                end
                local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local entityModel
local chaseConnection = nil
local customSpeed = 20
local activationRange = 75
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local Debris = game:GetService("Debris")

local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "DeerGodGlitch"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false

local noise = Instance.new("ImageLabel")
noise.Parent = gui
noise.Size = UDim2.new(1, 0, 1, 0)
noise.BackgroundTransparency = 1
noise.Image = "rbxassetid://8116159092"
noise.ScaleType = Enum.ScaleType.Tile
noise.TileSize = UDim2.new(0, 180, 0, 180)
noise.ImageTransparency = 0.92

local start = tick()
local conn
conn = RunService.RenderStepped:Connect(function()
    local elapsed = tick() - start
    if elapsed >= 60 then
        conn:Disconnect()
        gui:Destroy()
        return
    end

    if not gui or not gui.Parent then
        return
    end

    noise.ImageTransparency = 0.86 + math.random() * 0.1

    noise.Position = UDim2.new(
        0,
        math.random(-6, 6),
        0,
        math.random(-6, 6)
    )

    if math.random() < 0.08 then
        local bar = Instance.new("Frame")
        bar.Parent = gui
        bar.Size = UDim2.new(
            math.random(20, 80) / 100,
            0,
            0,
            math.random(2, 8)
        )

        bar.Position = UDim2.new(
            math.random(),
            0,
            math.random(),
            0
        )

        bar.BackgroundColor3 = Color3.new(
            math.random(),
            math.random(),
            math.random()
        )

        bar.BackgroundTransparency = 0.8
        bar.BorderSizePixel = 0

        Debris:AddItem(bar, 0.08)
    end
end)

local entity = spawner.Create({
    Entity = {
        Name = "Deer god",
        Asset = "92755817727288",
        HeightOffset = -0.8
    },
    Lights = {
        Flicker = { Enabled = true, Duration = 50 },
        Shatter = true,
        Repair = false
    },
    Earthquake = { Enabled = false },
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
            "Looks like you're really unlucky...",
            "You were killed by the so-called Deer God",
            "That powerful force will pull you into the abyss",
            "A rack can't guarantee your safety",
            "See you next time"
        },
        Cause = "Deer God"
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
        then
            return
        end

        local nearestPlayer = nil
        local nearestDist = math.huge
        local entityPos = entityModel.PrimaryPart.Position

        for _, player in ipairs(Players:GetPlayers()) do
            local char = player.Character
            if char and char:FindFirstChild("Humanoid") and char:FindFirstChild("HumanoidRootPart") then
                local humanoid = char.Humanoid
                if humanoid.Health > 0 then
                    local targetRoot = char.HumanoidRootPart
                    local dist = (targetRoot.Position - entityPos).Magnitude
                    if dist < nearestDist then
                        nearestDist = dist
                        nearestPlayer = player
                    end
                end
            end
        end

        if not nearestPlayer then return end

        local targetChar = nearestPlayer.Character
        if not targetChar then return end

        local targetRoot = targetChar:FindFirstChild("HumanoidRootPart")
        if not targetRoot then return end

        local pos = entityModel.PrimaryPart.Position
        local target = targetRoot.Position
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

local musicInstance = workspace:WaitForChild("HardCoreSound"):WaitForChild("DeerGodMusic")
musicInstance.Volume = 4
musicInstance:Play()
            end
        end)

        task.spawn(function()
            while task.wait(380) do
                if workspace:FindFirstChild("SeekMovingNewClone") then
                    continue
                end
                local Players = game:GetService("Players")
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

        task.spawn(function()
            while task.wait(335) do
                if workspace:FindFirstChild("SeekMovingNewClone") or workspace.CurrentRooms:FindFirstChild("50") then
                    continue
                end
                game.ReplicatedStorage.GameData.LatestRoom:GetPropertyChangedSignal("Value"):Wait()
                     local RunService = game:GetService("RunService")
    local ceaseHandledModels = setmetatable({}, { __mode = "k" })

    local testModelId = 126219950276870
    local reboundTemplate = nil
    local CameraShaker = require(game.ReplicatedStorage.CameraShaker)
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

        local function findChildren(object)
            if not object or found[object] then
                return
            end
            found[object] = true

            local states = getCrucifixVisualStates(object, nil, true)
            for _, state in ipairs(states) do
                table.insert(allStates, state)
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

        local placed = pcall(function()
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

        xpcall(function()
            local rushNew = (bro and bro:FindFirstChild("RushNew", true))
                or replacement:FindFirstChild("RushNew", true)
            if replacement.Name == "RushNew" and replacement:IsA("BasePart") then
                rushNew = replacement
            end
            local attachment = rushNew and rushNew:FindFirstChild("Attachment", true)
            if attachment and not attachment:IsA("Attachment") then
                attachment = nil
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
                    error("Attachment removed during ascent")
                end

                while not beamsRevealFinished and replacement.Parent and attachment.Parent do
                    RunService.Heartbeat:Wait()
                end

                if not moveCrucifixAttachment(attachment, downPosition, 1.2) then
                    error("Attachment removed during descent")
                end
                task.wait(2)
                fadeCrucifixBeamsOut(beams, 0.5)
            end
        end, function(err)
            return tostring(err) .. "\n" .. debug.traceback()
        end)

        pcall(function()
            fadeCrucifixDescendantsRecursively(replacement, 1)
        end)
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

                    if hitCharacter then
                        if not hitCharacter:GetAttribute("Hiding") then
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
                    wait(0.002)
                    v325.Parent.Rotation = 0
                    wait(0.002)
                    v325.Parent.Rotation = 180
                    wait(0.002)
                    v325.Parent.Image = "rbxassetid://236777652"
                    wait(0.002)
                    v325.Parent.Rotation = 0
                    wait(0.002)
                    v325.Parent.Rotation = 180
                    wait(0.002)
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
                        if hum then
                            hum:TakeDamage(100)
                            if vu328.GameStats["Player_" .. vu329.Name] then
                                vu328.GameStats["Player_" .. vu329.Name].Total.DeathCause.Value = "Rebound"
                            end

firesignal(game.ReplicatedStorage.RemotesFolder.DeathHint.OnClientEvent, {
      "You died from a rebound...",
    "The huge noise is deafening...",
    "Pay attention to the thunder every time you open the door..."
}, "Blue")
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
                if workspace:FindFirstChild("SeekMovingNewClone") or workspace.CurrentRooms:FindFirstChild("50") then
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
                if workspace:FindFirstChild("SeekMovingNewClone") or workspace.CurrentRooms:FindFirstChild("50") then
                    break
                end

                local targetRoom = v310:FindFirstChild(tostring(currentRoom))
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
                if workspace:FindFirstChild("SeekMovingNewClone") or workspace.CurrentRooms:FindFirstChild("50") then
                    break
                end

                local targetRoom = v310:FindFirstChild(tostring(currentRoom))
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

    local sweepSound = PlayPreloadedSound("ReboundSweep", 2)

    local part = Instance.new("Part")
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
            doorSignal.Event:Wait()
        end
        doorGateOpen = false
        return not reboundSealed
    end

    local directions = { "latest", "start", "latest", "start" }
    for waveIndex, startRoomType in ipairs(directions) do
        if reboundSealed then
            break
        end
        SpawnReboundEntity(startRoomType)
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
    doorSignal:Destroy()
    doorSignal = nil
            end
        end)

        task.spawn(function()
            while task.wait(700) do
                game.ReplicatedStorage.GameData.LatestRoom:GetPropertyChangedSignal("Value"):Wait()
                if workspace:FindFirstChild("SeekMovingNewClone") or workspace.CurrentRooms:FindFirstChild("50") then
                    break
                end
                function GetRoom()
	local rooms = workspace:FindFirstChild("CurrentRooms")
	local gameData = game.ReplicatedStorage:FindFirstChild("GameData")
	local latestRoom = gameData and gameData:FindFirstChild("LatestRoom")

	if not rooms or not latestRoom then
		return nil
	end

	return rooms:FindFirstChild(tostring(latestRoom.Value))
end

function LoadCustomInstance(source, parent)
	local model

	while task.wait() and not model do
		local success, result = pcall(function()
			return game:GetObjects("rbxassetid://" .. tostring(source))[1]
		end)

		if success and result then
			model = result
		end

		if model then
			model.Parent = parent or workspace

			for _, v in ipairs(model:GetDescendants()) do
				if v:IsA("Script") or v:IsA("LocalScript") then
					v:Destroy()
				end
			end
		end
	end

	return model
end

local plr = game.Players.LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()
local camera = workspace.CurrentCamera
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local s = LoadCustomInstance("83840759413024", workspace)
if not s then
	return
end

local entity = s:FindFirstChildWhichIsA("BasePart")
if not entity then
	s:Destroy()
	return
end

local firstRoom = GetRoom()
if not firstRoom or not firstRoom:FindFirstChild("RoomEntrance") then
	s:Destroy()
	return
end

entity.CFrame = firstRoom.RoomEntrance.CFrame * CFrame.new(0, 5, -15)

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
		if effect and effect:IsA("ParticleEmitter") or effect and effect:IsA("Trail") or effect and effect:IsA("Beam") then
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

task.wait(5)

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
		latestRoom.Changed:Wait()

		if finished then
			break
		end

		roomCount += 1

		local room = GetRoom()

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
			tween.Completed:Wait()

			if connection then
				connection:Disconnect()
			end

			value:Destroy()
		end

		if roomCount == 3 then
			PlayMusic("F2", true)
		elseif roomCount == 5 then
			local f3 = PlayMusic("F3", false, true)
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

				while f3.Parent and not ended and os.clock() - started < fadeDuration + 2 do
					task.wait()
				end

				if endedConnection then
					endedConnection:Disconnect()
				end
			else
				task.wait(fadeDuration)
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
		local lighter = chr:FindFirstChild("Lighter")

		if lighter and lighter:FindFirstChild("Handle") then
			local holder = lighter.Handle:FindFirstChild("EffectsHolder")

			if holder and holder:FindFirstChild("AttachOn") then
				local main = holder.AttachOn:FindFirstChild("MainLight")

				if main and main:IsA("PointLight") then
					safe = main.Enabled
				end
			end
		end

		if not safe then
			pcall(function()
				local humanoid = chr:FindFirstChildOfClass("Humanoid")

				if humanoid and humanoid.Health > 0 then
					humanoid.Health -= 3
				end
			end)
		end
	end
end)

repeat
	task.wait()
until finished

dmg = false
roomChanged = true

if camShake then
	pcall(function()
		camShake:Stop()
	end)
end

pcall(function()
	entity.Ambience:Stop()
	entity.AmbienceFar:Stop()
end)

SetEntityEffectsEnabled(false)

if music then
	music:Stop()
	music:Destroy()
	music = nil
end

if s and s.Parent then
	s:Destroy()
end

if frost and frost.Parent then
	frost:Destroy()
end
            end
        end)

        task.spawn(function()
            while task.wait(179) do
                game.ReplicatedStorage.GameData.LatestRoom:GetPropertyChangedSignal("Value"):Wait()
                if workspace:FindFirstChild("SeekMovingNewClone") or workspace.CurrentRooms:FindFirstChild("50") then
                    break
                end
                
                wait(1)
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

    local function createColorSequenceFade(object)
        if not object or not (
            object:IsA("ParticleEmitter")
            or object:IsA("Beam")
        ) then
            return
        end

        local originalKeypoints = object.Color.Keypoints
        local progress = Instance.new("NumberValue")
        progress.Value = 0

        local connection = progress:GetPropertyChangedSignal("Value"):Connect(function()
            if not object.Parent then
                return
            end

            local newKeypoints = {}

            for _, keypoint in ipairs(originalKeypoints) do
                table.insert(
                    newKeypoints,
                    ColorSequenceKeypoint.new(
                        keypoint.Time,
                        keypoint.Value:Lerp(targetColor, progress.Value)
                    )
                )
            end

            object.Color = ColorSequence.new(newKeypoints)
        end)

        local tween = TweenService:Create(
            progress,
            fadeInfo,
            {Value = 1}
        )

        tween.Completed:Connect(function()
            connection:Disconnect()

            if object.Parent then
                object.Color = ColorSequence.new(targetColor)
            end

            progress:Destroy()
        end)

        tween:Play()
    end

    local function modifyObjectsWithTween()
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

                                    if neon then
                                        if neon:IsA("BasePart") then
                                            createFadeTween(neon)
                                        end

                                        local bright = neon:FindFirstChild("Bright sh idfk")

                                        if bright and bright:IsA("Attachment") then
                                            local emitter = bright:FindFirstChild("ParticleEmitter")

                                            if emitter and emitter:IsA("ParticleEmitter") then
                                                createColorSequenceFade(emitter)
                                            end
                                        end

                                        local atachm = neon:FindFirstChild("atachm")

                                        if atachm and atachm:IsA("Attachment") then
                                            local beam = atachm:FindFirstChild("Ok you cannot tell me this isnt good")

                                            if beam and beam:IsA("Beam") then
                                                createColorSequenceFade(beam)
                                            end
                                        end

                                        local glow = neon:FindFirstChild("Glow")

                                        if glow and glow:IsA("Attachment") then
                                            local glowEmitter = glow:FindFirstChild("Beam")

                                            if glowEmitter and glowEmitter:IsA("ParticleEmitter") then
                                                createColorSequenceFade(glowEmitter)
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

        local placed = pcall(function()
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

        xpcall(function()
            local rushNew = bro and bro:FindFirstChild("RushNew", true)
            local attachment = rushNew and rushNew:FindFirstChild("Attachment", true)
            if attachment and not attachment:IsA("Attachment") then
                attachment = nil
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
                    error("Attachment removed during ascent")
                end

                while not beamsRevealFinished and replacement.Parent and attachment.Parent do
                    RunService.Heartbeat:Wait()
                end

                if not moveCrucifixAttachment(attachment, downPosition, 1.2) then
                    error("Attachment removed during descent")
                end
                task.wait(2)
                fadeCrucifixBeamsOut(beams, 0.5)
            end
        end, function(err)
            return tostring(err) .. "\n" .. debug.traceback()
        end)

        pcall(function()
            fadeCrucifixDescendantsRecursively(replacement, 1)
        end)
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

                                            if tryUseCrucifix(hitCharacter) then
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

        if tryUseCrucifix(playerChar) then
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

        if cameraShakerModule then
            local success, CameraShaker = pcall(require, cameraShakerModule)

            if success and CameraShaker then
                local jumpScareCamShake = CameraShaker.new(
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
            humanoid:TakeDamage(125)
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

        local remotesFolder = game.ReplicatedStorage:FindFirstChild("RemotesFolder")

        if remotesFolder then
            local deathHint = remotesFolder:FindFirstChild("DeathHint")

            if deathHint then
                firesignal(
                    deathHint.OnClientEvent,
                    {
                       "You died at the hands of the so-called Ripper...",
                        "It will appear after a huge roar.",
                        "When it hides like this, he checks all the hiding spots!"
                    },
                    "Blue"
                )
            end
        end

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

                        if not character:GetAttribute("Hiding") then
                            local camera = workspace.CurrentCamera

                            if camera then
                                local toRipper = visibleRipper.Position - camera.CFrame.Position
                                local cameraDistance = toRipper.Magnitude

                                if cameraDistance > 0 then
                                    local lookDot = camera.CFrame.LookVector:Dot(toRipper.Unit)
                                    local raycastParams = RaycastParams.new()
                                    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
                                    raycastParams.FilterDescendantsInstances = { character }

                                    local raycastResult = workspace:Raycast(
                                        camera.CFrame.Position,
                                        toRipper,
                                        raycastParams
                                    )

                                    local hitRipper = raycastResult
                                        and raycastResult.Instance
                                        and (
                                            raycastResult.Instance == visibleRipper
                                            or raycastResult.Instance:IsDescendantOf(visibleRipper)
                                        )

                                    local hitCharacter = raycastResult
                                        and getCharacterFromRaycastHit(raycastResult.Instance)

                                    if hitCharacter and hitCharacter ~= character
                                        and tryUseCrucifix(hitCharacter) then
                                        return
                                    end

                                    if distance <= 50
                                        and lookDot >= 0.86
                                        and hitRipper
                                    then
                                        if tryUseCrucifix(character) then
                                            return
                                        end

                                        TriggerRipperJumpScare(
                                            visibleRipper,
                                            character,
                                            visibleRipper.Position
                                        )
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
        end

        task.wait(1)


        for _, playerToCheck in ipairs(Players:GetPlayers()) do
            local candidateCharacter = playerToCheck.Character
            if candidateCharacter and getCrucifixTool(candidateCharacter) then

                if tryUseCrucifix(candidateCharacter) then
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
    end
    runFinalCameraShake()
                            end
        end)

        task.spawn(function()
            while task.wait(math.random(6, 100)) do
                local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local function spawnShocker()
    local shockerModel = game:GetObjects("rbxassetid://112917442174793")[1]
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
            if not lookStart then
                lookStart = tick()
            elseif tick() - lookStart >= lookDuration then
                hasTriggered = true
                connection:Disconnect()

                horrorScream:Play()
                if boneSound then boneSound:Play() end
                humanoid:TakeDamage(30)
                local targetPos = character.HumanoidRootPart.Position + Vector3.new(0, 2, 0)
                local tweenInfo = TweenInfo.new(1.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
                local tween = TweenService:Create(oogaBoogaaPart, tweenInfo, {Position = targetPos})
                tween:Play()

                tween.Completed:Connect(function()
                    fallToGround()
                end)

                ReplicatedStorage.GameStats["Player_".. player.Name].Total.DeathCause.Value = "Shocker"
                firesignal(ReplicatedStorage.RemotesFolder.DeathHint.OnClientEvent, {
                    "You died to who you call Shocker...",
                    "Don't look at it or it stuns you!"
                }, "Blue")
            end
        else
            connection:Disconnect()
            fallToGround()
        end
    end)

    task.delay(5, function()
        if not hasTriggered and not hasFallen then
            fallToGround()
        end
    end)
end
spawnShocker()

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
            local entity = spawner.Create({Entity = {Name = "Cease",Asset = "74118615017772",HeightOffset = 1},Lights = {Flicker = {Enabled = false,Duration = 10},Shatter = false,Repair = false},Earthquake = {Enabled = false},CameraShake = {Enabled = true,Range = 200,Values = {1.5, 20, 0.1, 1}},Movement = {Speed = 100,Delay = 5,Reversed = false},Rebounding = {Enabled = false,Type = "ambush",Min = 4,Max = 4,Delay = math.random(10, 30) / 10},Damage = {Enabled = false,Range = 100,Amount = 125},Crucifixion = {Enabled = false,Range = 100,Resist = false,Break = true},Death = {Type = "Guiding",Hints = {"CEASE", "...", "...", "..."},Cause = "Cease"}}) 
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

        
        task.spawn(function()
            while task.wait(500) do
                if workspace:FindFirstChild("SeekMovingNewClone") or workspace.CurrentRooms:FindFirstChild("50") then
                    break
                end
                local entity = spawner.Create({Entity = {Name = "Silence",Asset = "129734585273388",HeightOffset = 1},Lights = {Flicker = {Enabled = false,Duration = 0.1},Shatter = true,Repair = false},Earthquake = {Enabled = false},CameraShake = {Enabled = true,Range = 20,Values = {1.5, 20, 0.1, 1}},Movement = {Speed = 35,Delay = 2,Reversed = false},Rebounding = {Enabled = false,Type = "Blitz",Min = 1,Max = math.random(1, 2),Delay = math.random(10, 30) / 10},Damage = {Enabled = true,Range = 200,Amount = 125},Crucifixion = {Enabled = false,Range = 200,Resist = false,Break = true},Death = {Type = "Guiding",Hints = {"You've been swallowed by Silence...", "You should learn not to disappear in the silence", "Please carefully discern the sounds in the environment", "It could show up at any time"},Cause = ""}})
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
        end)

        spawn(function()
            getgenv().death = false
            local function vu529()
                while true do
                    wait(365)
                    game.ReplicatedStorage.GameData.LatestRoom:GetPropertyChangedSignal("Value"):Wait()
                    function DEATHMESSAGE(pu506, pu507)
                        spawn(function()
                            for _ = 1, 50 do
                                wait()
                                game:GetService("ReplicatedStorage").GameStats["Player_" .. game.Players.LocalPlayer.Name].Total.DeathCause.Value = pu507
                                firesignal(game.ReplicatedStorage.RemotesFolder.DeathHint.OnClientEvent, pu506, "Blue")
                            end
                        end)
                    end
                    if workspace:FindFirstChild("SeekMovingNewClone") or workspace.CurrentRooms:FindFirstChild("50") then
                        break
                    end
                    wait(0.01)
                    local v508 = game.Players.LocalPlayer
                    local vu509 = workspace.CurrentCamera
                    local vu510 = v508.Character or v508.CharacterAdded:Wait()
                    game:GetService("ReplicatedStorage")
                    local v512 = require(game.ReplicatedStorage:WaitForChild("CameraShaker")).new(Enum.RenderPriority.Camera.Value, function(p511)
                        vu509.CFrame = vu509.CFrame * p511
                    end)
                    v512:Start()
                    local v513 = Instance.new("Model", game:GetService("Lighting"))
                    local v514 = vu5:Clone()
                    local v515 = v514.FrostyNew
                    local v516 = v515.Attachment
                    v514.Parent = workspace
                    v513:Destroy()
                    local v517 = workspace.CurrentRooms[game:GetService("ReplicatedStorage").GameData.LatestRoom.Value]
                    local v518 = math.floor(# v517.Nodes:GetChildren() / 2)
                    v515.CFrame = (v518 == 0 and v517[v517.Name] or v517.Nodes[v518]).CFrame + Vector3.new(0, 11, 0)
                    local v519 = Instance.new("ColorCorrectionEffect")
                    v519.Parent = game:GetService("Lighting")
                    v519.TintColor = Color3.new(1, 1, 1)
                    v519.Enabled = false
                    local v520 = v512:StartShake(3.6, 55, 5)
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
                    game.TweenService:Create(v515["Static Effect"], TweenInfo.new(2), {
                        Pitch = 0
                    }):Play()
                    v520:StartFadeOut(2.5)
                    wait(2)
                    local v521 = v512:StartShake(2, 55, 25, nil, Vector3.new(5, 5, 5))
                    game.TweenService:Create(v519, TweenInfo.new(7), {
                        TintColor = Color3.new(0.00784314, 0.188235, 1)
                    }):Play()
                    local vu522 = true
                    spawn(function()
                        while wait(1) and vu522 do
                            local v523 = vu510:FindFirstChildOfClass("Humanoid")
                            if v523 then
                                local v524 = vu510:FindFirstChild("Lighter")
                                if v524 then
                                    local v525 = v524:FindFirstChild("EffectsHolder")
                                    if v525 and v525.AttachOn:FindFirstChildWhichIsA("ParticleEmitter").Enabled == false then
                                        v523:TakeDamage(5)
                                    end
                                else
                                    v523:TakeDamage(5)
                                end
                            else
                                v523:TakeDamage(5)
                            end
                            if v523.Health < 10 then
                                DEATHMESSAGE({
                                    "You died to who you call Frostbite...",
                                    "He will spawn in the middle and start freezing the room.",
                                    "Find something that has heat to keep you warm!"
                                }, "FrostBite")
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
                    vu522 = false
                    v521:StartFadeOut(15)
                    v520:StartFadeOut(1)
                    v515["Static Effect"]:Stop()
                    v515.Ambience:Stop()
                    v515.AmbienceFar:Stop()
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
                    v514:Destroy()
                    game.TweenService:Create(v519, TweenInfo.new(7), {
                        TintColor = Color3.new(1, 1, 1)
                    }):Play()
                end
                vu529()
            end
            vu529()
        end)
        function dread()
            if not game.Lighting:FindFirstChild("Ambience_Dread") then
                Instance.new("ColorCorrectionEffect", game.Lighting).Name = "Ambience_Dread"
            end
            local dreadLighting = game:GetService("Lighting")
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
            local function restoreDreadVisuals()
                if dreadVisualsRestored then
                    return
                end
                dreadVisualsRestored = true
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
                    local aliveCharacter = game.Players.LocalPlayer.Character
                    local aliveHumanoid = aliveCharacter and aliveCharacter:FindFirstChildOfClass("Humanoid")
                    if aliveHumanoid then
                        dreadCamera.CameraSubject = aliveHumanoid
                    end
                end
                pcall(function()
                    local mainGame = require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game)
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
            local dreadCharacter = game.Players.LocalPlayer.Character
            local dreadHumanoid = dreadCharacter and dreadCharacter:FindFirstChildOfClass("Humanoid")
            if dreadHumanoid then
                dreadDeadConnection = dreadHumanoid.Died:Connect(restoreDreadVisuals)
            end
            dreadCharacterConnection = game.Players.LocalPlayer.CharacterAdded:Connect(restoreDreadVisuals)
            local function vu535(p530)
                local v531, v532 = workspace.CurrentCamera:WorldToViewportPoint(p530.Position)
                if v532 then
                    v532 = v531.Z > 0
                end
                local v533 = RaycastParams.new()
                v533.FilterType = Enum.RaycastFilterType.Blacklist
                v533.FilterDescendantsInstances = {
                    p530
                }
                local v534 = workspace:Raycast(p530.Position, game.Players.LocalPlayer.Character.UpperTorso.Position - p530.Position, v533)
                if v532 then
                    if v534 then
                        v534 = v534.Instance
                    end
                    v532 = v534.Parent == game.Players.LocalPlayer.Character
                end
                return v532
            end
            local v536 = require(game.ReplicatedStorage.CameraShaker)
            local vu537 = workspace.CurrentCamera
            local vu539 = v536.new(Enum.RenderPriority.Camera.Value, function(p538)
                vu537.CFrame = vu537.CFrame * p538
            end)
            vu539:Start()
            dreadShake = vu539
            vu539:ShakeOnce(2, 10, 1, 1)
            local vu540 = vu9:Clone()
            vu540.Parent = workspace
            local v541 = workspace.CurrentRooms[game:GetService("ReplicatedStorage").GameData.LatestRoom.Value]
            local vu542 = vu540.RushNew
            local v543 = not v541:FindFirstChild("Nodes") and 0 or math.floor(# v541.Nodes:GetChildren() / 2)
            vu542.CFrame = (v543 == 0 and v541[v541.Name] or v541.Nodes[v543]).CFrame + Vector3.new(0, 6, 0)
            game.Lighting.Ambience_Dread.Enabled = true
            game.Lighting.Ambience_Dread.Brightness = 0
            game.Lighting.Ambience_Dread.Contrast = 0
            game.Lighting.Ambience_Dread.Saturation = 0
            game:GetService("TweenService"):Create(game.Lighting.Ambience_Dread, TweenInfo.new(2), {
                Brightness = 0.1,
                Contrast = 0.2,
                Saturation = - 0.7
            }):Play()
            coroutine.wrap(function()
                while not vu535(vu542) do
                    task.wait(0.5)
                end
                wait(1.5)
                game.Lighting.Ambience_Dread.Enabled = false
                require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).stopcam = true
                local v544 = workspace.CurrentCamera
                local v545 = v544.CFrame
                v544.CameraType = Enum.CameraType.Scriptable
                local v546 = game:GetService("TweenService"):Create(v544, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                    CFrame = CFrame.lookAt(v545.p, vu542.Position)
                })
                v546:Play()
                wait(0.15)

                local dreadSoundsFolder = workspace:FindFirstChild("HardCoreSound")
                local dreadJumpSource = dreadSoundsFolder and dreadSoundsFolder:FindFirstChild("DreadJump")
                if dreadJumpSource and dreadJumpSource:IsA("Sound") then
                    local dreadJumpSound = dreadJumpSource:Clone()
                    dreadJumpSound.Looped = false
                    dreadJumpSound.TimePosition = 0
                    dreadJumpSound.Parent = game:GetService("SoundService")
                    dreadJumpSound.Ended:Once(function()
                        dreadJumpSound:Destroy()
                    end)
                    dreadJumpSound:Play()
                    game:GetService("Debris"):AddItem(dreadJumpSound, 30)
                else
                    warn("Dread jumpscare audio missing: Workspace.HardCoreSound.DreadJump")
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
                wait(2)
                game.Lighting.MainColorCorrection.Brightness = - 1
                game.Lighting.MainColorCorrection.Contrast = - 4
                game.Lighting.MainColorCorrection.Saturation = - 1
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
                wait(1)
                local v556 = require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game)
                v556.stopcam = false
                v556.freemouse = false
                wait(0.4)
                loadstring(game:HttpGet("https://raw.githubusercontent.com/XAtomMaster339871/dkrsoilcfrkjghfhgrthngnrtuyghrtuhngur/main/erfz", true))()
                firesignal(game.ReplicatedStorage.RemotesFolder.DeathHint.OnClientEvent, {
                    "You died to Dread...",
                    "Its presence is summoned when the clock hits 12...",
                    "Do not observe it! You may lose your sanity!"
                }, "Blue")
            end)()
            coroutine.wrap(function()
                game:GetService("ReplicatedStorage").GameData.LatestRoom.Changed:Wait()
                task.wait()
                game:GetService("ReplicatedStorage").GameData.LatestRoom.Changed:Wait()
                task.wait()
                game:GetService("ReplicatedStorage").GameData.LatestRoom.Changed:Wait()
                vu540:Destroy()
                game.Lighting.Ambience_Dread.Enabled = false
                if not dreadVisualsRestored then
                    restoreDreadVisuals()
                end
            end)()
        end
        function a90()
            local v557 = require(game.ReplicatedStorage.CameraShaker)
            local vu558 = workspace.CurrentCamera
            local v560 = v557.new(Enum.RenderPriority.Camera.Value, function(p559)
                vu558.CFrame = vu558.CFrame * p559
            end)
            v560:Start()
            local v561 = game:GetService("TweenService")
            local v562 = game.Players.LocalPlayer
            local v563 = game.Players.LocalPlayer.PlayerGui.MainUI
            local vu564 = v563.Jumpscare.Jumpscare_A90
            local v565 = v563.Initiator.Main_Game.RemoteListener.Modules.A90
            local vu566 = require(v563.Initiator.Main_Game)
            local vu567 = true
            local vu568 = false
            local vu569 = vu566.cam.CFrame.LookVector
            local vu570 = 0
            game.SoundService.Main.Volume = 0
            vu564.Face.Image = "http://www.roblox.com/asset/?id=12635832722"
            vu564.FaceAngry.Image = "http://www.roblox.com/asset/?id=12635955412"
            v565.Spawn.SoundGroup = nil
            v565.Hit.SoundGroup = nil
            v565.Spawn:Play()
            vu564.BackgroundTransparency = 1
            vu564.Face.Visible = true
            vu564.FaceAngry.Visible = false
            vu564.Static.Visible = true
            vu564.Static2.Visible = true
            vu564.Static.ImageTransparency = 1
            vu564.Static2.ImageTransparency = 1
            vu564.Face.ImageColor3 = Color3.new(0, 0, 0)
            vu564.Face.Rotation = Random.new():NextNumber(- 5, 5)
            vu564.Face.Position = UDim2.new(Random.new():NextNumber(10, 90) / 100, 0, Random.new():NextNumber(10, 90) / 100, 0)
            vu564.Visible = true
            task.wait(0.03)
            vu564.Face.ImageColor3 = Color3.new(1, 1, 1)
            task.wait(0.28)
            vu564.BackgroundTransparency = 0
            vu564.Face.Rotation = 0
            vu564.Face.Position = UDim2.new(0.5, 0, 0.49, 0)
            task.wait(0.03)
            vu564.StopIcon.Visible = true
            vu564.BackgroundColor3 = Color3.new(0, 0, 0)
            vu564.BackgroundTransparency = 1
            vu564.Static.ImageTransparency = 0.8
            vu564.Static2.ImageTransparency = 0.8
            task.delay(0.2, function()
                vu564.StopIcon.Visible = false
                while vu567 do
                    local v571 = math.random(0, 1)
                    local v572 = 100 + vu570 * 0.5
                    vu570 = vu570 + 15
                    task.wait(0.03)
                    vu564.Static.Position = UDim2.new(math.random(0, 100) / 100, 0, math.random(0, 100) / 100, 0)
                    vu564.Static.Rotation = math.random(0, 1) * 180
                    vu564.Static2.Position = UDim2.new(math.random(0, 100) / 100, 0, math.random(0, 100) / 100, 0)
                    vu564.Static2.Rotation = math.random(0, 1) * 180
                    vu564.Face.Position = UDim2.new(0.5, 0, 0.49, math.random(- 1, 1))
                    vu564.FaceAngry.Position = UDim2.new(0.5 + Random.new():NextNumber(- v572, v572) / 50000, 0, 0.49 + Random.new():NextNumber(- v572, v572) / 30000, math.random(- 1, 1))
                    vu564.FaceAngry.Rotation = Random.new():NextNumber(- 1, 1) * (vu570 * 0.0015)
                    vu564.FaceAngry.ImageColor3 = Color3.new(1, v571, v571)
                    if not vu568 then
                        if (vu569 - vu566.cam.CFrame.LookVector).Magnitude <= 0.4 then
                            if vu566.hum.MoveDirection.Magnitude > 0.4 then
                                vu568 = true
                            end
                        else
                            vu568 = true
                        end
                    end
                end
            end)
            task.wait(0.3)
            vu564.BackgroundColor3 = Color3.new(0, 0, 0)
            vu564.BackgroundTransparency = 0
            vu564.Static.ImageTransparency = 0
            vu564.Static2.ImageTransparency = 0.5
            task.wait(0.03)
            vu564.Face.ImageColor3 = Color3.new(1, 0, 0)
            task.wait(0.03)
            vu564.Visible = false
            task.wait(0.08)
            if vu568 then
                local vu573 = true
                vu564.Visible = true
                v565.Hit:Play()
                task.wait(0.03)
                vu564.Face.ImageColor3 = Color3.new(1, 1, 1)
                task.wait(0.03)
                vu564.BackgroundTransparency = 0
                vu564.Static.ImageTransparency = 0
                vu564.Static2.ImageTransparency = 0.5
                task.wait(0.067)
                vu564.FaceAngry.Size = UDim2.new(0.8, 0, 0.8, 0)
                vu564.FaceAngry.Rotation = 0
                vu564.FaceAngry.ImageTransparency = 0
                vu564.FaceAngry.ImageColor3 = Color3.new(1, 0, 0)
                vu564.FaceAngry.Visible = true
                task.wait(0.067)
                vu564.FaceAngry.ImageColor3 = Color3.new(1, 1, 1)
                vu564.Face.Visible = false
                task.wait(0.75)
                v562.Character.Humanoid.Health = v562.Character.Humanoid.Health - 70
                firesignal(game.ReplicatedStorage.RemotesFolder.DeathHint.OnClientEvent, {
                    "You died to an entity called A-90...",
                    "React Fast and Dont Move a Muscle!"
                }, "Blue")
                task.wait(0.1)
                vu564.FaceAngry.Visible = false
                vu564.BackgroundColor3 = Color3.new(1, 1, 1)
                vu564.Static.ImageTransparency = 1
                vu564.Static2.ImageTransparency = 1
                task.wait(0.067)
                vu564.BackgroundColor3 = Color3.new(1, 0, 0)
                task.wait(0.067)
                vu564.BackgroundColor3 = Color3.new(0, 0, 0)
                task.wait(0.067)
                v560:ShakeOnce(25, 8, 0, 4)
                vu567 = false
                task.wait(0.03)
                v565.Spawn:Stop()
                vu564.BackgroundTransparency = 1
                vu564.Static.ImageTransparency = 0.5
                vu564.Static2.ImageTransparency = 0.5
                v561:Create(vu564.Static, TweenInfo.new(20, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    ImageTransparency = 1
                }):Play()
                v561:Create(vu564.Static2, TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    ImageTransparency = 1
                }):Play()
                local v574 = Random.new():NextNumber(2, 3)
                vu564.FaceAngry.Rotation = Random.new():NextNumber(- 3, 3)
                vu564.FaceAngry.Visible = true
                vu564.FaceAngry.ImageColor3 = Color3.new(1, 0, 0)
                vu564.FaceAngry.Size = UDim2.new(v574, 0, v574, 0)
                v561:Create(vu564.FaceAngry, TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    ImageTransparency = 1
                }):Play()
                game.SoundService.Main.Volume = 0
                game.SoundService.Main.EqualizerSoundEffect.Enabled = true
                game.SoundService.Main.EqualizerSoundEffect.HighGain = - 50
                game.SoundService.Main.EqualizerSoundEffect.LowGain = 10
                game.SoundService.Main.EqualizerSoundEffect.MidGain = - 50
                v561:Create(game.SoundService.Main.EqualizerSoundEffect, TweenInfo.new(15, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut), {
                    LowGain = 0,
                    HighGain = 0,
                    MidGain = 0
                }):Play()
                v561:Create(game.SoundService.Main, TweenInfo.new(5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    Volume = 1
                }):Play()
                task.spawn(function()
                    while vu573 do
                        local v575 = 100 + 0.1
                        task.wait()
                        vu564.Static.Position = UDim2.new(Random.new():NextNumber(0, v575) / 100, 0, Random.new():NextNumber(0, v575) / 100, 0)
                        vu564.Static.Rotation = math.random(0, 1) * 180
                        vu564.Static2.Position = UDim2.new(Random.new():NextNumber(0, v575) / 100, 0, Random.new():NextNumber(0, v575) / 100, 0)
                        vu564.Static2.Rotation = math.random(0, 1) * 180
                    end
                end)
                task.delay(20, function()
                    vu573 = false
                    vu564.Visible = false
                    vu564.BackgroundTransparency = 0
                    vu564.Static.ImageTransparency = 1
                    vu564.Static2.ImageTransparency = 1
                end)
            else
                v565.Spawn:Stop()
                vu564.BackgroundTransparency = 1
                vu564.Visible = false
                v560:ShakeOnce(5, 10, 0.1, 1)
                vu567 = false
                game.SoundService.Main.Volume = 1
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
