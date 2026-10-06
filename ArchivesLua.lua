if workspace:FindFirstChild("Hardcore1") then
    return
end
local marker = Instance.new("BoolValue")
marker.Name = "HardcoreOne"
marker.Value = true
marker.Parent = workspace
local function GitAud(soundgit, filename)
    local url = soundgit
    local FileName = filename
    writefile(FileName .. ".mp3", game:HttpGet(url))
    return (getcustomasset or getsynasset)(FileName .. ".mp3")
end
local function CustomGitSound(soundlink, vol, filename)
    local sound = Instance.new("Sound")
    sound.SoundId = GitAud(soundlink, filename)
    sound.Parent = workspace
    sound.Name = filename or "Music"
    sound.Volume = vol
    sound:Play()
    return sound
end
local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()
local entityBehaviors = {}
function GitAud(soundgit, filename)
    local fileName = filename or "temp_audio"
    local fullFileName = fileName .. ".mp3"

    local success, audioData = pcall(function()
        return game:HttpGet(soundgit)
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

    if getsynasset then
        return getsynasset(fullFileName)
    elseif getcustomasset then
        return getcustomasset(fullFileName)
    end

    return nil
end

local githubAudioUrl = "https://github.com/Zero0Star/RipperMPSound/blob/master/RipperNewSound.mp3?raw=true"
local explosionSoundUrl = "https://github.com/Zero0Star/RipperNewSound/blob/master/RipperDoorend.mp3?raw=true"

local backgroundSoundPath = GitAud(
    githubAudioUrl,
    "RipperBackgroundSound"
)

local explosionSoundPath = GitAud(
    explosionSoundUrl,
    "RipperExplosionSound"
)

if backgroundSoundPath then
    local oldBackgroundSound = workspace:FindFirstChild(
        "RipperBackgroundSound"
    )

    if oldBackgroundSound then
        oldBackgroundSound:Destroy()
    end

    local backgroundSound = Instance.new("Sound")
    backgroundSound.Name = "RipperBackgroundSound"
    backgroundSound.SoundId = backgroundSoundPath
    backgroundSound.Volume = 2
    backgroundSound.Looped = false
    backgroundSound.Parent = workspace
end

if explosionSoundPath then
    local oldExplosionSound = workspace:FindFirstChild(
        "RipperExplosionSound"
    )

    if oldExplosionSound then
        oldExplosionSound:Destroy()
    end

    local explosionSound = Instance.new("Sound")
    explosionSound.Name = "RipperExplosionSound"
    explosionSound.SoundId = explosionSoundPath
    explosionSound.Volume = 5
    explosionSound.Looped = false
    explosionSound.Parent = workspace
end

function entityBehaviors.ATCHRipper()
    local backgroundSound = workspace:FindFirstChild(
        "RipperBackgroundSound"
    )

    if backgroundSound then
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

    local function modifyObjectsWithTween()
        local currentRooms = workspace:FindFirstChild("CurrentRooms")
        if not currentRooms then return end

        local lightsToModify = {}
        local originalColors = {}

        for _, room in ipairs(currentRooms:GetChildren()) do
            if room:IsA("Model") then
                local assets = room:FindFirstChild("Assets")
                if assets then
                    local lightFixtures = assets:FindFirstChild("Light_Fixtures")
                    if lightFixtures then
                        for _, ceilingLight in ipairs(lightFixtures:GetChildren()) do
                            if ceilingLight:IsA("Model") and ceilingLight.Name == "ArchivesCeilingLight" then
                                local neon = ceilingLight:FindFirstChild("Neon")
                                if neon then
                                    table.insert(lightsToModify, neon)
                                    originalColors[neon] = neon.Color

                                    local shadow = neon:FindFirstChild("SurfaceLightShadow")
                                    if shadow then
                                        table.insert(lightsToModify, shadow)
                                        originalColors[shadow] = shadow.Color
                                    end

                                    for _, attachment in ipairs(neon:GetChildren()) do
                                        if attachment:IsA("Attachment") then
                                            for _, child in ipairs(attachment:GetChildren()) do
                                                if child:IsA("PointLight") then
                                                    table.insert(lightsToModify, child)
                                                    originalColors[child] = child.Color
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end

                    for _, floorLamp in ipairs(assets:GetChildren()) do
                        if floorLamp:IsA("Model") and floorLamp.Name == "ArchivesFloorLamp" then
                            local neon = floorLamp:FindFirstChild("Neon")
                            if neon then
                                for _, attachment in ipairs(neon:GetChildren()) do
                                    if attachment:IsA("Attachment") then
                                        for _, child in ipairs(attachment:GetChildren()) do
                                            if child:IsA("SpotLight") or child:IsA("PointLight") then
                                                table.insert(lightsToModify, child)
                                                originalColors[child] = child.Color
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

        for _, light in ipairs(lightsToModify) do
            local tween = TweenService:Create(light, TweenInfo.new(fadeDuration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Color = targetColor})
            tween:Play()
        end

        task.spawn(function()
            task.wait(fadeDuration)

            local forceLoopRunning = true
            local connection = RunService.RenderStepped:Connect(function()
                if not forceLoopRunning then return end
                for _, light in ipairs(lightsToModify) do
                    if light and light.Parent then
                        light.Color = targetColor
                    end
                end
            end)

            task.wait(20)

            forceLoopRunning = false
            connection:Disconnect()

            for _, light in ipairs(lightsToModify) do
                if light and light.Parent then
                    local revertTween = TweenService:Create(light, TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Color = originalColors[light]})
                    revertTween:Play()
                end
            end
        end)
    end

    task.spawn(modifyObjectsWithTween)

    local activeRipperTween = nil
    local isJumpScaring = false
    local ripper = nil
    local ripperAsset = nil

    local function StopRipperMovement()
        if activeRipperTween then
            activeRipperTween:Cancel()
            activeRipperTween = nil
        end
    end

    local function LoadDeathModel()
        local DEATH_MODEL_ID = "104190508011063"

        local success, loadedModels = pcall(function()
            return game:GetObjects(
                "rbxassetid://" .. DEATH_MODEL_ID
            )
        end)

        if success and loadedModels and loadedModels[1] then
            local deathModel = loadedModels[1]
            deathModel.Name = "Death"
            deathModel.Parent = workspace
            return deathModel
        end

        return nil
    end

    local function TriggerRipperJumpScare(
        currentRipper,
        playerChar,
        snapshottedRipperPosition
    )
        if isJumpScaring then
            return
        end

        StopRipperMovement()
        isJumpScaring = true

        if ripperAsset and ripperAsset.Parent then
            ripperAsset:Destroy()
            ripperAsset = nil
        end

        local player = Players:GetPlayerFromCharacter(playerChar)

        if not player then
            isJumpScaring = false
            return
        end

        local playerGui = player:FindFirstChild("PlayerGui")

        if not playerGui then
            playerGui = player:WaitForChild("PlayerGui", 5)
        end

        if not playerGui then
            isJumpScaring = false
            return
        end

        local noiseGui = Instance.new("ScreenGui")
        noiseGui.Name = "Noise"
        noiseGui.IgnoreGuiInset = true
        noiseGui.ResetOnSpawn = false
        noiseGui.Parent = playerGui

        local staticImg = Instance.new("ImageLabel")
        staticImg.BackgroundTransparency = 1
        staticImg.Size = UDim2.new(1, 0, 1, 0)
        staticImg.Image = "rbxassetid://236542974"
        staticImg.ImageTransparency = 1
        staticImg.Parent = noiseGui

        local images = {
            "rbxassetid://236542974",
            "rbxassetid://12784032030"
        }

        local imgIndex = 1

        task.spawn(function()
            while staticImg and staticImg.Parent do
                staticImg.Image = images[imgIndex]
                imgIndex = imgIndex % #images + 1
                task.wait(0.03)
            end
        end)

        local deathModel = workspace:FindFirstChild("Death")

        if not deathModel then
            deathModel = LoadDeathModel()
        end

        if not deathModel
            or not deathModel:FindFirstChild("Ripe")
        then
            noiseGui:Destroy()
            isJumpScaring = false
            return
        end

        local originalRipe = deathModel:FindFirstChild("Ripe")
        local ripClone = originalRipe:Clone()
        ripClone.Parent = workspace

        if ripClone:IsA("BasePart") then
            ripClone.Position = originalRipe.Position
        elseif ripClone:IsA("Model") then
            ripClone:PivotTo(originalRipe:GetPivot())
        end

        local ripeObject = ripClone:FindFirstChild("ripe")

        if ripeObject then
            local particleEmitter =
                ripeObject:FindFirstChild("ParticleEmitter")

            if particleEmitter
                and particleEmitter:IsA("ParticleEmitter")
            then
                particleEmitter.Texture =
                    "rbxassetid://11816152645"
            end
        end

        for _, desc in ipairs(ripClone:GetDescendants()) do
            if desc:IsA("ParticleEmitter") then
                task.spawn(function()
                    desc.Rate = 9999
                    task.wait(0.25)

                    if desc and desc.Parent then
                        desc.TimeScale = 0
                    end
                end)
            elseif desc:IsA("Sound") then
                desc.Volume = 0
            end
        end

        originalRipe:Destroy()

        local screamSound = Instance.new("Sound")
        screamSound.SoundId = "rbxassetid://372770465"
        screamSound.Volume = 10
        screamSound.PlaybackSpeed = 0.7
        screamSound.Parent = workspace

        local explodeSound = Instance.new("Sound")
        local explosionSound = workspace:FindFirstChild(
            "RipperExplosionSound"
        )

        if explosionSound then
            explodeSound.SoundId = explosionSound.SoundId
        end

        explodeSound.Volume = 10
        explodeSound.PlaybackSpeed = 1
        explodeSound.Parent = workspace

        local camera = workspace.CurrentCamera
        local rootPart =
            playerChar:FindFirstChild("HumanoidRootPart")

        local humanoid =
            playerChar:FindFirstChildWhichIsA("Humanoid")

        if rootPart then
            rootPart.Anchored = true
        end

        explodeSound:Play()

        local cameraShakerModule =
            game.ReplicatedStorage:FindFirstChild(
                "CameraShaker"
            )

        if cameraShakerModule then
            local explosionCameraShaker =
                require(cameraShakerModule)

            local explosionCamShake =
                explosionCameraShaker.new(
                    Enum.RenderPriority.Camera.Value,
                    function(shakeCf)
                        if camera then
                            camera.CFrame =
                                camera.CFrame * shakeCf
                        end
                    end
                )

            explosionCamShake:Start()
            explosionCamShake:ShakeOnce(
                50,
                400,
                0.1,
                0.7,
                2,
                1
            )
        end

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

        local visualDeathModel = LoadDeathModel()

        if visualDeathModel then
            visualDeathModel:PivotTo(
                CFrame.lookAt(
                    targetPart.Position,
                    targetPart.Position
                        + Vector3.new(0, 180, 0)
                )
            )
        end

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

        renderConnection =
            RunService.RenderStepped:Connect(function()
                if camFocus
                    and camFocus.Parent
                    and camera
                then
                    camera.CFrame = camFocus.CFrame
                elseif renderConnection then
                    renderConnection:Disconnect()
                end
            end)

        turnTween:Play()
        turnTween.Completed:Wait()

        task.wait(1)

        screamSound.Volume = 0
        screamSound:Play()

        TweenService:Create(
            screamSound,
            TweenInfo.new(3),
            {
                Volume = 10
            }
        ):Play()

        task.wait(3)

        TweenService:Create(
            staticImg,
            TweenInfo.new(2),
            {
                ImageTransparency = 0
            }
        ):Play()

        task.wait(2)

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

        task.wait(1)

        if rootPart and rootPart.Parent then
            rootPart.Anchored = false
        end

        if humanoid and humanoid.Parent then
            humanoid:TakeDamage(100)
        end

        if renderConnection then
            renderConnection:Disconnect()
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

        if ripClone then
            ripClone:Destroy()
        end

        if screamSound then
            screamSound:Destroy()
        end

        if explodeSound then
            explodeSound:Destroy()
        end

        if deathModel then
            deathModel:Destroy()
        end

        if visualDeathModel then
            visualDeathModel:Destroy()
        end

        if currentRipper and currentRipper.Parent then
            currentRipper:Destroy()
        end

        ripper = nil

        local remotesFolder =
            game.ReplicatedStorage:FindFirstChild(
                "RemotesFolder"
            )

        if remotesFolder then
            local deathHint =
                remotesFolder:FindFirstChild("DeathHint")

            if deathHint then
                firesignal(
                    deathHint.OnClientEvent,
                    {
                        "你死于所谓的开膛手...",
                        "伴随极大的吼叫声后他就会出现.",
                        "它这么做时躲起来,他会检查所有的躲藏点!"
                    },
                    "Blue"
                )
            end
        end

        local gameStats =
            game.ReplicatedStorage:FindFirstChild(
                "GameStats"
            )

        if gameStats then
            local playerStat = gameStats:FindFirstChild(
                "Player_" .. player.Name
            )

            if playerStat then
                local total =
                    playerStat:FindFirstChild("Total")

                if total then
                    local deathCause =
                        total:FindFirstChild("DeathCause")

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

    local function moveRipperTo(
        targetCFrame,
        speedFactor
    )
        if isJumpScaring
            or not ripper
            or not ripper.Parent
        then
            return false
        end

        local distance = (
            ripper.Position - targetCFrame.Position
        ).Magnitude

        local duration =
            math.max(distance / speedFactor, 0.01)

        local tween = TweenService:Create(
            ripper,
            TweenInfo.new(
                duration,
                Enum.EasingStyle.Linear,
                Enum.EasingDirection.InOut
            ),
            {
                CFrame = targetCFrame
            }
        )

        activeRipperTween = tween
        tween:Play()

        local playbackState =
            tween.Completed:Wait()

        if activeRipperTween == tween then
            activeRipperTween = nil
        end

        return playbackState
                == Enum.PlaybackState.Completed
            and not isJumpScaring
            and ripper
            and ripper.Parent ~= nil
    end

    local function ExecuteRipperPathfinding()
        local RIPPER_MODEL_ID = "104570339911705"

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
        ripper.Parent = workspace

        local orderedRooms = getOrderedRooms()

        if #orderedRooms == 0 then
            ripper:Destroy()
            ripper = nil
            ripperAsset:Destroy()
            ripperAsset = nil
            return
        end

        -- 房间数>10时从倒数第9个房间开始
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

        local heightOffset = Vector3.new(0, 1, 0)
        local speedFactor = 89

        ripper.CFrame =
            startNode.CFrame + heightOffset

        local cameraShaker = nil
        local cameraShakerModule =
            game.ReplicatedStorage:FindFirstChild(
                "CameraShaker"
            )

        if cameraShakerModule then
            local CameraShakerModule =
                require(cameraShakerModule)

            local camera = workspace.CurrentCamera

            cameraShaker = CameraShakerModule.new(
                Enum.RenderPriority.Camera.Value,
                function(shakerTransform)
                    if camera then
                        camera.CFrame =
                            camera.CFrame
                            * shakerTransform
                    end
                end
            )

            cameraShaker:Start()
        end

        local hasShaken = false

        task.spawn(function()
            while ripper
                and ripper.Parent
                and not isJumpScaring
            do
                RunService.RenderStepped:Wait()

                local player = Players.LocalPlayer

                if player and player.Character then
                    local character = player.Character

                    local humanoid =
                        character:FindFirstChildWhichIsA(
                            "Humanoid"
                        )

                    local rootPart =
                        character:FindFirstChild(
                            "HumanoidRootPart"
                        )

                    if humanoid
                        and rootPart
                        and humanoid.Health > 0
                        and not character:GetAttribute(
                            "Hiding"
                        )
                    then
                        local origin = ripper.Position
                        local target = rootPart.Position

                        local distance = (
                            origin - target
                        ).Magnitude

                        if distance < 213
                            and cameraShaker
                        then
                            if not hasShaken then
                                local amplitude =
                                    math.max(
                                        0,
                                        21
                                            * (
                                                1
                                                - distance
                                                    / 152
                                            )
                                    )

                                cameraShaker:ShakeOnce(
                                    amplitude,
                                    14,
                                    5,
                                    1,
                                    1,
                                    6
                                )

                                hasShaken = true
                            end
                        else
                            hasShaken = false
                        end

                        local difference =
                            target - origin

                        if difference.Magnitude > 0 then
                            local raycastParams =
                                RaycastParams.new()

                            raycastParams.FilterType =
                                Enum.RaycastFilterType.Exclude

                            raycastParams.FilterDescendantsInstances =
                                {
                                    ripper
                                }

                            local raycastResult =
                                workspace:Raycast(
                                    origin,
                                    difference.Unit * 66,
                                    raycastParams
                                )

                            if raycastResult
                                and raycastResult.Instance
                                and raycastResult.Instance:IsDescendantOf(
                                    character
                                )
                            then
                                TriggerRipperJumpScare(
                                    ripper,
                                    character,
                                    ripper.Position
                                )
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

        activeRipperTween = nil

        if isJumpScaring
            or not ripper
            or not ripper.Parent
        then
            ripper = nil
            ripperAsset = nil
            return
        end

        if not reachedFinalRoom
            or completedRoomIndex
                < targetRoomIndex
        then
            if ripper and ripper.Parent then
                ripper:Destroy()
            end

            if ripperAsset
                and ripperAsset.Parent
            then
                ripperAsset:Destroy()
            end

            ripper = nil
            ripperAsset = nil
            return
        end

        -- 根据玩家距离动态选择终点音效与震动
        local NEAR_EXPLOSION_DISTANCE = 80
        local FAR_EXPLOSION_DISTANCE = 220
        local SHAKE_MAX_DISTANCE = 350
        local MAX_EXPLOSION_SHAKE = 300

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

        -- 查找 RushNew 部件（可能存在于模型中）
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
            and ripperAsset.Parent
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
            -- 很近：使用原爆炸音效
            local explosionSound =
                workspace:FindFirstChild(
                    "RipperExplosionSound"
                )

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
            -- 中等距离：使用 RushNew.Despawn2
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
            -- 很远：使用 RushNew.Despawn3
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

        -- 安全回退：若找不到 Despawn2/Despawn3，使用原爆炸音效
        if not explodeSound then
            local explosionSound =
                workspace:FindFirstChild(
                    "RipperExplosionSound"
                )

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

        -- 震动幅度计算
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
                400,
                0.1,
                0.7,
                2,
                1
            )
        end

        task.wait(1)

        local finalRipperPosition = nil

        if ripper and ripper.Parent then
            finalRipperPosition =
                ripper.Position

            ripper.Anchored = false
            ripper.CanCollide = false
            ripper.CanTouch = false
            ripper.CanQuery = false
        end

        if ripperAsset
            and ripperAsset.Parent
        then
            ripperAsset:Destroy()
            ripperAsset = nil
        end

        if isJumpScaring
            or not ripper
            or not ripper.Parent
        then
            ripper = nil
            return
        end

        local player = Players.LocalPlayer

        if player and player.Character then
            local character = player.Character

            local humanoid =
                character:FindFirstChildWhichIsA(
                    "Humanoid"
                )

            if humanoid
                and humanoid.Health > 0
                and not character:GetAttribute(
                    "Hiding"
                )
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

        ripper = nil
        ripperAsset = nil

        task.delay(10, function()
            if fallingRipper
                and fallingRipper.Parent
            then
                fallingRipper:Destroy()
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

function entityBehaviors.A200()
local entity = spawner.Create({Entity = {Name = "A-200",Asset = "125138842800011",HeightOffset = 1},Lights = {Flicker = {Enabled = false,Duration = 10},Shatter = false,Repair = false},Earthquake = {Enabled = false},CameraShake = {Enabled = true,Range = 200,
Values = {1.5, 1, 0.1, 1}},Movement = {Speed = 60,Delay = 5,Reversed = true},Rebounding = {Enabled = false,Type = "ambush",Min = 4,Max = 4,Delay = math.random(10, 30) / 10},Damage = {Enabled = true,Range = 100,Amount = 1},Crucifixion = {Enabled = true,Range = 100,Resist = false,Break = true},Death = {Type = "Guiding",Hints = {"你死于A-200", "竖起耳朵仔细辨别是一个麻烦", "但你不得不这么做", "你或许会在寂静那学到点什么"},Cause = ""}})
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


function entityBehaviors.AMIN60()
local entity = spawner.Create({Entity = {Name = "Amin-60",Asset = "134290844453819",HeightOffset = 0.8},Lights = {Flicker = {Enabled = false,Duration = 10},Shatter = true,Repair = false},Earthquake = {Enabled = false},CameraShake = {Enabled = true,Range = 200,Values = {1.5, 20, 0.1, 1}},Movement = {Speed = 400,Delay = 6.5,Reversed = false},Rebounding = {Enabled = true,Type = "ambush",Min = 10,Max = 10,Delay = math.random(10, 30) / 10},Damage = {Enabled = true,Range = 100,Amount = 125},Crucifixion = {Enabled = true,Range = 100,Resist = false,Break = true},Death = {Type = "Guiding",Hints = {"你死于Amin-60", "极大的嘈杂声会掩盖其他声音", "他比A60更加迅速敏捷", "仔细听取木板碎裂的声音"},Cause = ""}})
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
function entityBehaviors.Black60()
local entity = spawner.Create({Entity = {Name = "Black-A60",Asset = "96102326082560",HeightOffset = 0},Lights = {Flicker = {Enabled = false,Duration = 10},Shatter = true,Repair = false},Earthquake = {Enabled = false},CameraShake = {Enabled = true,Range = 200,Values = {1.5, 20, 0.1, 1}},Movement = {Speed = 350,Delay = 6.5,Reversed = false},Rebounding = {Enabled = true,Type = "ambush",Min = 10,Max = 10,Delay = math.random(10, 30) / 10},Damage = {Enabled = true,Range = 100,Amount = 125},Crucifixion = {Enabled = true,Range = 100,Resist = false,Break = true},Death = {Type = "Guiding",Hints = {"你死于BlackA60", "极大的嘈杂声会掩盖其他声音", "在不妥时使用十字架会更方便", "反复进柜子躲避它"},Cause = ""}})
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
function entityBehaviors.INGODONE()
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

local MODEL_ID = 107995387840479
local LOOP_SOUND_ID = 139459003161851
local END_SOUND_ID = 101395573137763
local SPECTATOR_SOUND_ID = 9041745062

local FOLLOW_TIME = 5
local TOTAL_TIME = 54
local FADE_OUT_TIME = 3

local START_SAN = 100
local SAN_LOSS_PER_SECOND = 3

local ROOM_SAN_GAIN = 8

local MONSTER_DISTANCE = 13
local MONSTER_HEIGHT_OFFSET = -1.5

local LOOP_VOLUME = 5
local END_VOLUME = 1
local SPECTATOR_VOLUME = 1

local active = false
local ending = false
local currentSan = START_SAN
local sanityDeathTriggered = false

local RENDER_NAME = "UNNAMEABLE_CAMERA_" .. tostring(player.UserId)

local function isDeadOrSpectating()
	if player:GetAttribute("Spectating") == true then
		return true
	end

	if player:GetAttribute("Alive") == false then
		return true
	end

	local character = player.Character

	if character then
		local humanoid = character:FindFirstChildOfClass("Humanoid")

		if humanoid and humanoid.Health <= 0 then
			return true
		end
	end

	return false
end

local function playSpectatorSound()
	local sound = Instance.new("Sound")
	sound.Name = "IndescribableSpectator"
	sound.SoundId = "rbxassetid://" .. SPECTATOR_SOUND_ID
	sound.Volume = SPECTATOR_VOLUME
	sound.Looped = false
	sound.Parent = SoundService

	sound.Ended:Connect(function()
		if sound.Parent then
			sound:Destroy()
		end
	end)

	sound:Play()
end

local function createLoopSound()
	local sound = Instance.new("Sound")
	sound.Name = "UnnameableLoop"
	sound.SoundId = "rbxassetid://" .. LOOP_SOUND_ID
	sound.Volume = LOOP_VOLUME
	sound.Looped = true
	sound.Parent = SoundService
	sound:Play()

	return sound
end

local function playEndingSound()
	local sound = Instance.new("Sound")
	sound.Name = "UnnameableEnding"
	sound.SoundId = "rbxassetid://" .. END_SOUND_ID
	sound.Volume = END_VOLUME
	sound.Looped = false
	sound.Parent = SoundService

	sound.Ended:Connect(function()
		if sound.Parent then
			sound:Destroy()
		end
	end)

	sound:Play()
end

local function createSanUI()
	local gui = Instance.new("ScreenGui")
	gui.Name = "UnnameableSAN"
	gui.ResetOnSpawn = false
	gui.IgnoreGuiInset = true
	gui.DisplayOrder = 1000
	gui.Parent = player:WaitForChild("PlayerGui")

	local veil = Instance.new("Frame")
	veil.Size = UDim2.fromScale(1, 1)
	veil.BackgroundColor3 = Color3.fromRGB(175, 190, 225)
	veil.BackgroundTransparency = 0.99
	veil.BorderSizePixel = 0
	veil.ZIndex = 0
	veil.Parent = gui

	local ghostA = Instance.new("Frame")
	ghostA.Size = UDim2.new(1.1, 0, 1.1, 0)
	ghostA.AnchorPoint = Vector2.new(0.5, 0.5)
	ghostA.Position = UDim2.fromScale(0.5, 0.5)
	ghostA.BackgroundColor3 = Color3.fromRGB(125, 160, 235)
	ghostA.BackgroundTransparency = 0.997
	ghostA.BorderSizePixel = 0
	ghostA.ZIndex = 1
	ghostA.Parent = gui

	local ghostB = Instance.new("Frame")
	ghostB.Size = UDim2.new(1.1, 0, 1.1, 0)
	ghostB.AnchorPoint = Vector2.new(0.5, 0.5)
	ghostB.Position = UDim2.fromScale(0.5, 0.5)
	ghostB.BackgroundColor3 = Color3.fromRGB(235, 135, 175)
	ghostB.BackgroundTransparency = 0.998
	ghostB.BorderSizePixel = 0
	ghostB.ZIndex = 2
	ghostB.Parent = gui

	local holder = Instance.new("Frame")
	holder.AnchorPoint = Vector2.new(1, 0.5)
	holder.Position = UDim2.new(1, 220, 0.5, 0)
	holder.Size = UDim2.fromOffset(190, 65)
	holder.BackgroundColor3 = Color3.fromRGB(4, 4, 7)
	holder.BackgroundTransparency = 0.15
	holder.BorderSizePixel = 0
	holder.ZIndex = 10
	holder.Parent = gui

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 4)
	corner.Parent = holder

	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.fromRGB(110, 115, 130)
	stroke.Transparency = 0.35
	stroke.Thickness = 1
	stroke.Parent = holder

	local title = Instance.new("TextLabel")
	title.BackgroundTransparency = 1
	title.Position = UDim2.fromOffset(12, 5)
	title.Size = UDim2.new(1, -24, 0, 22)
	title.Font = Enum.Font.GothamMedium
	title.Text = "SAN"
	title.TextColor3 = Color3.fromRGB(190, 190, 200)
	title.TextSize = 14
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.ZIndex = 11
	title.Parent = holder

	local value = Instance.new("TextLabel")
	value.BackgroundTransparency = 1
	value.Position = UDim2.fromOffset(12, 25)
	value.Size = UDim2.new(1, -24, 0, 29)
	value.Font = Enum.Font.GothamBold
	value.Text = "100%"
	value.TextColor3 = Color3.fromRGB(235, 235, 240)
	value.TextSize = 23
	value.TextXAlignment = Enum.TextXAlignment.Left
	value.ZIndex = 11
	value.Parent = holder

	local barBG = Instance.new("Frame")
	barBG.Position = UDim2.new(0, 12, 1, -7)
	barBG.Size = UDim2.new(1, -24, 0, 2)
	barBG.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
	barBG.BorderSizePixel = 0
	barBG.ZIndex = 11
	barBG.Parent = holder

	local bar = Instance.new("Frame")
	bar.Size = UDim2.fromScale(1, 1)
	bar.BackgroundColor3 = Color3.fromRGB(205, 210, 220)
	bar.BorderSizePixel = 0
	bar.ZIndex = 12
	bar.Parent = barBG

	TweenService:Create(
		holder,
		TweenInfo.new(0.7, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
		{
			Position = UDim2.new(1, -35, 0.5, 0)
		}
	):Play()

	return {
		gui = gui,
		holder = holder,
		label = value,
		bar = bar,
		veil = veil,
		ghostA = ghostA,
		ghostB = ghostB
	}
end

local function createEffects()
	local blur = Instance.new("BlurEffect")
	blur.Name = "UnnameableBlur"
	blur.Size = 4
	blur.Parent = Lighting

	local color = Instance.new("ColorCorrectionEffect")
	color.Name = "UnnameableColor"
	color.Brightness = 0
	color.Contrast = 0
	color.Saturation = 0
	color.TintColor = Color3.new(1, 1, 1)
	color.Parent = Lighting

	local monochrome = Instance.new("ColorCorrectionEffect")
	monochrome.Name = "UnnameableMonochrome"
	monochrome.Brightness = 0
	monochrome.Contrast = 0
	monochrome.Saturation = 0
	monochrome.TintColor = Color3.new(1, 1, 1)
	monochrome.Parent = Lighting

	local bloom = Instance.new("BloomEffect")
	bloom.Name = "UnnameableBloom"
	bloom.Intensity = 0
	bloom.Size = 36
	bloom.Threshold = 0.65
	bloom.Parent = Lighting

	local depth = Instance.new("DepthOfFieldEffect")
	depth.Name = "UnnameableDepth"
	depth.FarIntensity = 0
	depth.NearIntensity = 0
	depth.FocusDistance = 12
	depth.InFocusRadius = 8
	depth.Parent = Lighting

	local rays = Instance.new("SunRaysEffect")
	rays.Name = "UnnameableRays"
	rays.Intensity = 0
	rays.Spread = 1
	rays.Parent = Lighting

	return {
		blur = blur,
		color = color,
		monochrome = monochrome,
		bloom = bloom,
		depth = depth,
		rays = rays
	}
end

local function loadMonster()
	local success, objects = pcall(function()
		return game:GetObjects("rbxassetid://" .. MODEL_ID)
	end)

	if not success or not objects or not objects[1] then
		return nil
	end

	local monster = objects[1]
	monster.Name = "不可名状"
	monster.Parent = workspace

	if monster:IsA("BasePart") then
		monster.Anchored = true
		monster.CanCollide = false
		monster.CanTouch = false
		monster.CanQuery = false
	end

	for _, object in ipairs(monster:GetDescendants()) do
		if object:IsA("BasePart") then
			object.Anchored = true
			object.CanCollide = false
			object.CanTouch = false
			object.CanQuery = false
		end
	end

	return monster
end

local function setMonsterCFrame(monster, cf)
	if not monster then
		return
	end

	if monster:IsA("Model") then
		monster:PivotTo(cf)
	elseif monster:IsA("BasePart") then
		monster.CFrame = cf
	end
end

local function fadeMonster(monster, duration)
	if not monster then
		return
	end

	if monster:IsA("BasePart") then
		TweenService:Create(
			monster,
			TweenInfo.new(duration),
			{
				Transparency = 1
			}
		):Play()
	end

	for _, object in ipairs(monster:GetDescendants()) do
		if object:IsA("BasePart") then
			TweenService:Create(
				object,
				TweenInfo.new(duration),
				{
					Transparency = 1
				}
			):Play()
		elseif object:IsA("Decal") or object:IsA("Texture") then
			TweenService:Create(
				object,
				TweenInfo.new(duration),
				{
					Transparency = 1
				}
			):Play()
		end
	end
end

local function updateSanDisplay(san, ui)
	san = math.clamp(san, 0, 100)

	if ui.label then
		ui.label.Text = math.floor(san) .. "%"
	end

	if ui.bar then
		TweenService:Create(
			ui.bar,
			TweenInfo.new(0.22, Enum.EasingStyle.Sine),
			{
				Size = UDim2.fromScale(san / 100, 1)
			}
		):Play()
	end
end

local function giveAchievement()
	task.spawn(function()
		pcall(function()
			local DoorsNotify = loadstring(
				game:HttpGet(
					"https://raw.githubusercontent.com/Guestly-Alt/Scripts/refs/heads/main/AchievementHolder.lua"
				)
			)()

			DoorsNotify({
				Style = "Completed!",
				Title = "Indescribable",
				Description = "A strange dream...",
				Reason = "Survive In Indescribable",
				Image = "rbxassetid://8178415737",
				Time = 5
			})
		end)
	end)
end

local function startUnnameable()
	if isDeadOrSpectating() then
		playSpectatorSound()
		return
	end

	if active or ending then
		return
	end

	active = true
	ending = false
	sanityDeathTriggered = false
	currentSan = START_SAN

	camera = workspace.CurrentCamera

	local eventStartTime = os.clock()
	local originalFOV = camera and camera.FieldOfView or 70

	local loopSound = createLoopSound()
	local monster = loadMonster()

	if not monster then
		active = false

		if loopSound then
			loopSound:Stop()
			loopSound:Destroy()
		end

		return
	end

	local ui = createSanUI()
	local effects = createEffects()

	local fadeValue = Instance.new("NumberValue")
	fadeValue.Value = 1

	local latestRoom = ReplicatedStorage
		:WaitForChild("GameData")
		:WaitForChild("LatestRoom")

	local roomConnection
	local deathConnection
	local characterConnection
	local aliveConnection
	local spectatingConnection

	local flipActive = false
	local flipStart = 0
	local flipDuration = 2
	local flipDirection = 1
	local nextFlip = os.clock() + math.random(4, 7)

	local finished = false

	local function disconnectAll()
		if roomConnection then
			roomConnection:Disconnect()
			roomConnection = nil
		end

		if deathConnection then
			deathConnection:Disconnect()
			deathConnection = nil
		end

		if characterConnection then
			characterConnection:Disconnect()
			characterConnection = nil
		end

		if aliveConnection then
			aliveConnection:Disconnect()
			aliveConnection = nil
		end

		if spectatingConnection then
			spectatingConnection:Disconnect()
			spectatingConnection = nil
		end
	end

	local function destroyImmediately()
		RunService:UnbindFromRenderStep(RENDER_NAME)

		disconnectAll()

		if loopSound then
			loopSound:Stop()
			loopSound:Destroy()
			loopSound = nil
		end

		if monster and monster.Parent then
			monster:Destroy()
		end

		for _, effect in pairs(effects) do
			if effect and effect.Parent then
				effect:Destroy()
			end
		end

		if ui.gui and ui.gui.Parent then
			ui.gui:Destroy()
		end

		if fadeValue then
			pcall(function()
				fadeValue:Destroy()
			end)
		end

		camera = workspace.CurrentCamera

		if camera then
			camera.FieldOfView = originalFOV
		end
	end

	local function failEvent()
		if finished then
			return
		end

		finished = true
		ending = true
		active = false

		destroyImmediately()

		ending = false
	end

	local function finishEvent(survived)
		if finished then
			return
		end

		finished = true
		ending = true
		active = false

		disconnectAll()

		if loopSound then
			loopSound:Stop()
			loopSound:Destroy()
			loopSound = nil
		end

		fadeMonster(monster, FADE_OUT_TIME)

		if ui.holder then
			TweenService:Create(
				ui.holder,
				TweenInfo.new(
					FADE_OUT_TIME,
					Enum.EasingStyle.Sine,
					Enum.EasingDirection.InOut
				),
				{
					Position = UDim2.new(1, 230, 0.5, 0),
					BackgroundTransparency = 1
				}
			):Play()
		end

		if ui.label then
			TweenService:Create(
				ui.label,
				TweenInfo.new(FADE_OUT_TIME),
				{
					TextTransparency = 1
				}
			):Play()
		end

		local fadeTween = TweenService:Create(
			fadeValue,
			TweenInfo.new(
				FADE_OUT_TIME,
				Enum.EasingStyle.Sine,
				Enum.EasingDirection.InOut
			),
			{
				Value = 0
			}
		)

		fadeTween:Play()
		fadeTween.Completed:Wait()

		RunService:UnbindFromRenderStep(RENDER_NAME)

		camera = workspace.CurrentCamera

		if camera then
			camera.FieldOfView = originalFOV
		end

		if monster and monster.Parent then
			monster:Destroy()
		end

		for _, effect in pairs(effects) do
			if effect and effect.Parent then
				effect:Destroy()
			end
		end

		if ui.gui and ui.gui.Parent then
			ui.gui:Destroy()
		end

		pcall(function()
			fadeValue:Destroy()
		end)

		playEndingSound()

		if survived and not sanityDeathTriggered then
			giveAchievement()
		end

		ending = false
	end

	local function bindHumanoid(character)
		if deathConnection then
			deathConnection:Disconnect()
			deathConnection = nil
		end

		if not character then
			return
		end

		local humanoid = character:FindFirstChildOfClass("Humanoid")

		if not humanoid then
			humanoid = character:WaitForChild("Humanoid", 5)
		end

		if humanoid then
			deathConnection = humanoid.Died:Connect(function()
				if not active then
					return
				end

				if sanityDeathTriggered then
					return
				end

				failEvent()
			end)
		end
	end

	bindHumanoid(player.Character)

	characterConnection = player.CharacterAdded:Connect(function()
		if not active then
			return
		end

		if not sanityDeathTriggered then
			failEvent()
		end
	end)

	aliveConnection = player:GetAttributeChangedSignal("Alive"):Connect(function()
		if not active or sanityDeathTriggered then
			return
		end

		if player:GetAttribute("Alive") == false then
			failEvent()
		end
	end)

	spectatingConnection = player:GetAttributeChangedSignal("Spectating"):Connect(function()
		if not active or sanityDeathTriggered then
			return
		end

		if player:GetAttribute("Spectating") == true then
			failEvent()
		end
	end)

	roomConnection = latestRoom.Changed:Connect(function()
		if not active or sanityDeathTriggered then
			return
		end

		currentSan = math.clamp(
			currentSan + ROOM_SAN_GAIN,
			0,
			100
		)

		updateSanDisplay(currentSan, ui)

		if ui.holder then
			ui.holder.Size = UDim2.fromOffset(204, 69)

			TweenService:Create(
				ui.holder,
				TweenInfo.new(
					0.35,
					Enum.EasingStyle.Back,
					Enum.EasingDirection.Out
				),
				{
					Size = UDim2.fromOffset(190, 65)
				}
			):Play()
		end
	end)

	RunService:BindToRenderStep(
		RENDER_NAME,
		Enum.RenderPriority.Camera.Value + 1,
		function()
			camera = workspace.CurrentCamera

			if not camera then
				return
			end

			local now = os.clock()
			local elapsed = now - eventStartTime
			local fade = fadeValue.Value

			local eventProgress = math.clamp(
				elapsed / TOTAL_TIME,
				0,
				1
			)

			local insanity = math.clamp(
				1 - currentSan / 100,
				0,
				1
			)

			local lateGame = math.clamp(
				(eventProgress - 0.3) / 0.7,
				0,
				1
			)

			lateGame = lateGame ^ 1.25

			local extremeLate = math.clamp(
				(eventProgress - 0.68) / 0.32,
				0,
				1
			)

			extremeLate = extremeLate ^ 1.35

			local finalPhase = math.clamp(
				(eventProgress - 0.86) / 0.14,
				0,
				1
			)

			if effects.monochrome then
				local monochromeProgress = math.clamp(
					(elapsed - 12) / 8,
					0,
					1
				)

				monochromeProgress =
					monochromeProgress
					* monochromeProgress
					* (3 - 2 * monochromeProgress)

				effects.monochrome.Saturation =
					-1
					* monochromeProgress
					* fade

				effects.monochrome.Contrast =
					0.14
					* monochromeProgress
					* fade

				effects.monochrome.Brightness =
					-0.03
					* monochromeProgress
					* fade
			end

			local flipAngle = 0

			if active
				and eventProgress >= 0.2
				and not flipActive
				and now >= nextFlip
			then
				flipActive = true
				flipStart = now

				flipDuration =
					2.5
					+ eventProgress * 3
					+ extremeLate * 1.8

				flipDirection =
					math.random(0, 1) == 0
					and -1
					or 1
			end

			if flipActive then
				local progress =
					(now - flipStart) / flipDuration

				if progress >= 1 then
					flipActive = false

					local minDelay =
						math.max(
							1.8,
							6.5
							- lateGame * 2.5
							- extremeLate * 1.5
						)

					local maxDelay =
						math.max(
							3,
							9
							- lateGame * 3
							- extremeLate * 2
						)

					nextFlip =
						now
						+ minDelay
						+ math.random()
						* (maxDelay - minDelay)
				else
					local curve =
						math.sin(progress * math.pi) ^ 0.4

					flipAngle =
						math.rad(180)
						* curve
						* flipDirection
						* fade
				end
			end

			local curveRoll =
				math.sin(now * 0.82)
				* math.rad(
					1.8
					+ eventProgress * 2.5
					+ lateGame * 2
				)

			local curveRoll2 =
				math.sin(now * 0.39 + 1.6)
				* math.rad(
					1
					+ eventProgress * 1.7
					+ lateGame * 1.3
				)

			local violentRoll =
				math.sin(now * 1.8)
				* math.rad(
					lateGame * 4
					+ extremeLate * 8
					+ finalPhase * 7
				)

			local noiseRoll =
				math.noise(now * 8, 0, 0)
				* math.rad(
					lateGame * 2.5
					+ extremeLate * 5
					+ finalPhase * 6
				)

			local microRoll =
				math.sin(now * 28)
				* math.rad(
					extremeLate * 1.3
					+ finalPhase * 3
				)

			local pitch =
				(
					math.sin(now * 0.68)
					* math.rad(
						0.5
						+ eventProgress * 1.6
						+ lateGame * 1.5
						+ extremeLate * 2.8
						+ finalPhase * 3
					)
					+
					math.noise(0, now * 8, 0)
					* math.rad(
						lateGame * 1.5
						+ extremeLate * 3.5
						+ finalPhase * 3
					)
				)
				* fade

			local yaw =
				(
					math.sin(now * 0.49)
					* math.rad(
						0.45
						+ eventProgress
						+ lateGame
						+ extremeLate * 2.5
					)
					+
					math.noise(now * 7, 20, 0)
					* math.rad(
						extremeLate * 2
						+ finalPhase * 2.5
					)
				)
				* fade

			local shake =
				(
					0.004
					+ eventProgress * 0.006
					+ lateGame * 0.018
					+ extremeLate * 0.06
					+ finalPhase * 0.08
				)
				* fade

			local shiftX =
				(
					math.sin(now * 1.45) * 0.012
					+
					math.noise(now * 18, 10, 0) * shake
					+
					math.sin(now * 25)
					* 0.025
					* extremeLate
					+
					math.sin(now * 39)
					* 0.025
					* finalPhase
				)
				* fade

			local shiftY =
				(
					math.cos(now * 1.12) * 0.01
					+
					math.noise(10, now * 19, 0) * shake
					+
					math.cos(now * 23)
					* 0.022
					* extremeLate
					+
					math.cos(now * 35)
					* 0.025
					* finalPhase
				)
				* fade

			camera.CFrame =
				camera.CFrame
				* CFrame.new(
					shiftX,
					shiftY,
					0
				)
				* CFrame.Angles(
					pitch,
					yaw,
					(
						curveRoll
						+ curveRoll2
						+ violentRoll
						+ noiseRoll
						+ microRoll
						+ flipAngle
					)
					* fade
				)

			local fovPulse =
				math.sin(now * 1.05)
				*
				(
					1.8
					+ eventProgress * 2
					+ lateGame * 4
					+ extremeLate * 5
					+ finalPhase * 3
				)
				* fade

			local fovNoise =
				math.noise(now * 2.5, 0, 0)
				*
				(
					extremeLate * 4
					+ finalPhase * 3
				)
				* fade

			camera.FieldOfView =
				originalFOV
				+ fovPulse
				+ fovNoise

			if effects.blur then
				local blurValue =
					6
					+ eventProgress ^ 1.3 * 19
					+ lateGame ^ 1.2 * 15
					+ extremeLate * 15
					+ finalPhase * 11
					+ insanity * 8
					+
					math.sin(now * 1.7)
					*
					(
						1.4
						+ lateGame * 2
						+ extremeLate * 2.5
					)

				effects.blur.Size =
					math.clamp(
						blurValue * fade,
						0,
						52
					)
			end

			if effects.color then
				effects.color.Contrast =
					(
						0.09
						+ eventProgress * 0.14
						+ lateGame * 0.2
						+ extremeLate * 0.17
						+ finalPhase * 0.1
						+
						math.sin(now * 0.8) * 0.04
					)
					* fade

				effects.color.Saturation =
					(
						-0.1
						- eventProgress * 0.08
						- lateGame * 0.12
						- extremeLate * 0.1
					)
					* fade

				effects.color.Brightness =
					(
						math.sin(now * 0.55) * 0.025
						+
						math.sin(now * 2.6)
						* extremeLate
						* 0.02
						+
						math.sin(now * 8)
						* finalPhase
						* 0.012
					)
					* fade

				local tintStrength =
					math.clamp(
						(
							0.13
							+ eventProgress * 0.12
							+ lateGame * 0.2
							+ extremeLate * 0.2
						)
						* fade,
						0,
						0.75
					)

				effects.color.TintColor =
					Color3.new(1, 1, 1):Lerp(
						Color3.fromRGB(
							155,
							180,
							225
						),
						tintStrength
					)
			end

			if effects.bloom then
				effects.bloom.Intensity =
					(
						0.35
						+ eventProgress * 0.35
						+ lateGame * 0.75
						+ extremeLate * 0.85
						+ finalPhase * 0.4
						+
						math.sin(now * 0.75) * 0.13
					)
					* fade

				effects.bloom.Size =
					34
					+ lateGame * 12
					+ extremeLate * 16
					+ finalPhase * 8
			end

			if effects.depth then
				effects.depth.FarIntensity =
					math.clamp(
						(
							0.08
							+ eventProgress * 0.13
							+ lateGame * 0.23
							+ extremeLate * 0.2
							+ finalPhase * 0.1
						)
						* fade,
						0,
						0.72
					)

				effects.depth.NearIntensity =
					math.clamp(
						(
							0.04
							+ lateGame * 0.2
							+ extremeLate * 0.18
							+ finalPhase * 0.1
						)
						* fade,
						0,
						0.5
					)

				effects.depth.FocusDistance =
					10
					+
					math.sin(now * 0.65)
					*
					(
						3
						+ lateGame * 4
						+ extremeLate * 5
						+ finalPhase * 4
					)

				effects.depth.InFocusRadius =
					math.max(
						1.5,
						8
						- lateGame * 3
						- extremeLate * 2
						- finalPhase * 1.5
					)
			end

			if effects.rays then
				effects.rays.Intensity =
					(
						0.015
						+ lateGame * 0.05
						+ extremeLate * 0.06
						+ finalPhase * 0.03
					)
					* fade
			end

			if ui.holder then
				local uiShake =
					(
						eventProgress * 1.5
						+ lateGame * 4
						+ extremeLate * 9
						+ finalPhase * 10
					)
					* fade

				ui.holder.Position =
					UDim2.new(
						1,
						-35
						+
						math.sin(now * 14) * uiShake
						+
						math.noise(now * 18, 0, 0) * uiShake,
						0.5,
						math.cos(now * 12) * uiShake
						+
						math.noise(0, now * 17, 0) * uiShake
					)
			end

			if ui.veil then
				ui.veil.BackgroundTransparency =
					math.clamp(
						0.994
						-
						(
							eventProgress * 0.012
							+ lateGame * 0.025
							+ extremeLate * 0.028
							+ finalPhase * 0.015
						)
						* fade,
						0.9,
						1
					)
			end

			if ui.ghostA then
				ui.ghostA.Position =
					UDim2.new(
						0.5,
						math.sin(now * 1.8)
						*
						(
							6
							+ eventProgress * 7
							+ lateGame * 13
							+ extremeLate * 16
							+ finalPhase * 9
						)
						* fade,
						0.5,
						math.cos(now * 1.35)
						*
						(
							4
							+ eventProgress * 6
							+ lateGame * 10
							+ extremeLate * 12
						)
						* fade
					)

				ui.ghostA.BackgroundTransparency =
					math.clamp(
						0.997
						-
						(
							eventProgress * 0.008
							+ lateGame * 0.018
							+ extremeLate * 0.02
							+ finalPhase * 0.01
						)
						* fade,
						0.93,
						1
					)
			end

			if ui.ghostB then
				ui.ghostB.Position =
					UDim2.new(
						0.5,
						-math.sin(now * 1.55)
						*
						(
							5
							+ eventProgress * 7
							+ lateGame * 12
							+ extremeLate * 15
							+ finalPhase * 8
						)
						* fade,
						0.5,
						-math.cos(now * 1.9)
						*
						(
							4
							+ eventProgress * 5
							+ lateGame * 9
							+ extremeLate * 11
						)
						* fade
					)

				ui.ghostB.BackgroundTransparency =
					math.clamp(
						0.998
						-
						(
							eventProgress * 0.007
							+ lateGame * 0.015
							+ extremeLate * 0.018
							+ finalPhase * 0.01
						)
						* fade,
						0.94,
						1
					)
			end
		end
	)

	task.spawn(function()
		while active do
			task.wait(1)

			if not active or sanityDeathTriggered then
				break
			end

			currentSan =
				math.clamp(
					currentSan - SAN_LOSS_PER_SECOND,
					0,
					100
				)

			updateSanDisplay(currentSan, ui)

			if currentSan <= 35 and math.random() > 0.78 then
				ui.label.Text = "??%"
			end

			if currentSan <= 15 and math.random() > 0.58 then
				local fakeValues = {
					"0%",
					"???",
					"-",
					"∞",
					tostring(math.random(101, 999)) .. "%"
				}

				ui.label.Text =
					fakeValues[
						math.random(1, #fakeValues)
					]
			end

			if currentSan <= 0 then
				if not sanityDeathTriggered then
					sanityDeathTriggered = true

					ui.label.Text = "0%"

					if ui.bar then
						ui.bar.Size = UDim2.fromScale(0, 1)
					end

					replicatesignal(
						game.Players.LocalPlayer.Kill
					)

					finishEvent(false)
				end

				break
			end
		end
	end)

	local followStart = os.clock()

	while active and os.clock() - followStart < FOLLOW_TIME do
		camera = workspace.CurrentCamera

		if camera then
			local camCF = camera.CFrame

			local position =
				camCF.Position
				+ camCF.LookVector * MONSTER_DISTANCE
				+ Vector3.new(
					0,
					MONSTER_HEIGHT_OFFSET,
					0
				)

			setMonsterCFrame(
				monster,
				CFrame.lookAt(
					position,
					camCF.Position
				)
			)
		end

		RunService.RenderStepped:Wait()
	end

	while active do
		RunService.Heartbeat:Wait()

		if not sanityDeathTriggered then
			if player:GetAttribute("Alive") == false
				or player:GetAttribute("Spectating") == true
			then
				failEvent()
				return
			end

			local character = player.Character
			local humanoid =
				character
				and character:FindFirstChildOfClass("Humanoid")

			if not character
				or not humanoid
				or humanoid.Health <= 0
			then
				failEvent()
				return
			end
		end

		if os.clock() - eventStartTime >= TOTAL_TIME then
			break
		end
	end

	if active and not sanityDeathTriggered then
		finishEvent(true)
	end
end

startUnnameable()
end


function entityBehaviors.SEEKEYES()
local RunService = game:GetService("RunService")
local camera = workspace.CurrentCamera
local flipActive = true
local flipStart = os.clock()
local flipDuration = 2
local flipDirection = 1
RunService:BindToRenderStep("ScreenFlipOnce", Enum.RenderPriority.Camera.Value + 1, function()
local now = os.clock()
local progress = (now - flipStart) / flipDuration
if progress >= 1 then
RunService:UnbindFromRenderStep("ScreenFlipOnce")
return
end
local curve = math.sin(progress * math.pi) ^ 0.4
local flipAngle = math.rad(180) * curve * flipDirection
camera.CFrame = camera.CFrame * CFrame.Angles(0, 0, flipAngle)
end)
end

function entityBehaviors.Subspace()
local sound = Instance.new("Sound")
sound.Name = "Subspace"
sound.SoundId = "rbxassetid://108345344203629"
sound.Volume = 4
sound.Parent = workspace

sound.Ended:Connect(function()
    sound:Destroy()
end)

sound:Play()
wait(5)
    local sound = Instance.new("Sound")
sound.Name = "Subspace"
sound.SoundId = "rbxassetid://134461834055887"
sound.Volume = 4
sound.Parent = workspace

sound.Ended:Connect(function()
    sound:Destroy()
end)

sound:Play()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local SHAKE_INTENSITY = 20
local SHAKE_DURATION = 7
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
end
function entityBehaviors.DELALL()
local function deleteDirectChildModelsAndParts()
    local workspace = game:GetService("Workspace")
    local names = { "A-200", "A60", "Amin-60", "Black-A60", "Deer god","Black Hole Particle effect","DeerGod",
        "Frostbite", "@&%^#*$Indescribable God!@$*&^!Q(* ", "LightSpeed",
        "Rebound", "Ripper", "Following_ENEMY", "Silence","Dread","Muffler","Common Sence","Fluster","Kitty","Broken eyes","Angry Munci","Shadow","LEVEL0","Him","Hunger","WH1T3","Obsession","HimMoving","smiler", "Chainsmoker" } -- 保持不变
    for _, name in ipairs(names) do
        local child = workspace:FindFirstChild(name)
        if child and (child:IsA("Model") or child:IsA("Part")) then
            child:Destroy()
        end
    end
end
deleteDirectChildModelsAndParts()
end
function entityBehaviors.Smiler()
local entity = spawner.Create({Entity = {Name = "smiler",Asset = "108450814500304",HeightOffset = 0},Lights = {Flicker = {Enabled = true,Duration = 10},Shatter = false,Repair = false},Earthquake = {Enabled = false},CameraShake = {Enabled = true,Range = 200,Values = {1.5, 20, 0.1, 1}},Movement = {Speed = 450,Delay = 11,Reversed = false},Rebounding = {Enabled = true,Type = "ambush",Min = 2,Max = 2,Delay = math.random(10, 30) / 10},Damage = {Enabled = true,Range = 200,Amount = 125},Crucifixion = {Enabled = true,Range = 200,Resist = false,Break = true},Death = {Type = "Guiding",Hints = {"你死于Smiler", "或许你需要在Ambush那学会点东西", "在闪灯数秒后他会出现", "加油,我相信你可以做到"},Cause = ""}})
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

function entityBehaviors.ChainSmoker()
local entity = spawner.Create({Entity = {Name = "Chainsmoker",Asset = "97888632834501",HeightOffset = 1},Lights = {Flicker = {Enabled = true,Duration = 1},Shatter = true,Repair = false},Earthquake = {Enabled = false},CameraShake = {Enabled = true,Range = 10,Values = {1.5, 20, 0.1, 1}},Movement = {Speed = 30,Delay = 1,Reversed = true},Rebounding = {Enabled = false,Type = "ambush",Min = 4,Max = 4,Delay = math.random(10, 30) / 10},Damage = {Enabled = true,Range = 5,Amount = 125},Crucifixion = {Enabled = true,Range = 20,Resist = false,Break = true},Death = {Type = "Guiding",Hints = {"你死于Chainsmoker", "......", "或许我不能告诉你他的信息", "总而言之，当心闪灯"},Cause = ""}})
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
function entityBehaviors.LightSpeed()
local entity = spawner.Create({Entity = {Name = "LightSpeed",Asset = "87015961601567",HeightOffset = 1},Lights = {Flicker = {Enabled = false,Duration = 0.1},Shatter = false,Repair = false},Earthquake = {Enabled = false},CameraShake = {Enabled = true,Range = 20,Values = {90, 50, 20, 20}},Movement = {Speed = 1400,Delay = 20,Reversed = false},Rebounding = {Enabled = false,Type = "Blitz",Min = 1,Max = math.random(1, 2),Delay = math.random(10, 30) / 10},Damage = {Enabled = true,Range = 50,Amount = 40},Crucifixion = {Enabled = true,Range = 50,Resist = false,Break = true},Death = {Type = "Guiding",Hints = {"你死于光速", "在他来临时保证自己以最快的速度作出反应", "伴随着灯光变黄与巨大的雷电轰鸣声", "或许并不致命但总是一个威胁"},Cause = ""}})
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
function entityBehaviors.A200Jump()
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer

local images = {
	113886624548165,
	16907654704,
	91100683423814
}

local function PlayA200J()
	local sound = workspace:FindFirstChild("A200J", true)

	if sound and sound:IsA("Sound") then
		sound.Volume = 3
		sound.Looped = false

		if not sound.IsLoaded then
			sound.Loaded:Wait()
		end

		sound:Play()
	end
end


local function DamagePlayer()

	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:FindFirstChildOfClass("Humanoid")

	if humanoid then
		humanoid:TakeDamage(100)
	end

end


local function ScreenShake(power,time)

	local camera = workspace.CurrentCamera
	local start = tick()

	local connection

	connection = RunService.RenderStepped:Connect(function()

		if tick()-start >= time then
			connection:Disconnect()
			return
		end

		camera.CFrame =
			camera.CFrame *
			CFrame.new(
				math.random(-power,power)/100,
				math.random(-power,power)/100,
				0
			)
	end)
end


local function ExecuteJumpScare()

	DamagePlayer()

	local container = Instance.new("Folder")
	container.Name="A200J_Jumpscare"
	container.Parent=player.PlayerGui


	local gui = Instance.new("ScreenGui")
	gui.Parent=container
	gui.IgnoreGuiInset=true
	gui.ResetOnSpawn=false
	gui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling


	local red = Instance.new("Frame")
	red.Parent=gui
	red.Size=UDim2.fromScale(1,1)
	red.BackgroundColor3=Color3.fromRGB(120,0,0)
	red.BackgroundTransparency=1
	red.BorderSizePixel=0
	red.ZIndex=1


	local img = Instance.new("ImageLabel")
	img.Parent=gui
	img.AnchorPoint=Vector2.new(.5,.5)
	img.Position=UDim2.fromScale(.5,.5)
	img.Size=UDim2.fromOffset(120,120)
	img.BackgroundTransparency=1
	img.ImageTransparency=1
	img.ScaleType=Enum.ScaleType.Fit
	img.ZIndex=5


	PlayA200J()


	TweenService:Create(
		red,
		TweenInfo.new(.1),
		{BackgroundTransparency=.3}
	):Play()


	img.Image="rbxassetid://"..images[1]

	TweenService:Create(
		img,
		TweenInfo.new(.12,Enum.EasingStyle.Back),
		{
			ImageTransparency=0,
			Size=UDim2.fromOffset(450,450)
		}
	):Play()

	ScreenShake(8,.25)

	task.wait(.15)


	img.Image="rbxassetid://"..images[2]

	TweenService:Create(
		img,
		TweenInfo.new(.15,Enum.EasingStyle.Back),
		{
			Size=UDim2.fromOffset(900,900)
		}
	):Play()

	ScreenShake(12,.35)

	task.wait(.12)


	img.Image="rbxassetid://"..images[3]

	local glitch=true

	task.spawn(function()

		while glitch do

			img.Position=UDim2.new(
				0.5,
				math.random(-35,35),
				0.5,
				math.random(-35,35)
			)

			img.Rotation=math.random(-15,15)

			img.Size=UDim2.fromOffset(
				math.random(800,1200),
				math.random(800,1200)
			)

			img.ImageTransparency=math.random(0,4)/10

			task.wait(.035)
		end

	end)


	TweenService:Create(
		img,
		TweenInfo.new(.3,Enum.EasingStyle.Exponential),
		{
			Size=UDim2.fromOffset(2200,2200)
		}
	):Play()


	TweenService:Create(
		red,
		TweenInfo.new(.1),
		{BackgroundTransparency=.05}
	):Play()


	ScreenShake(25,.8)


	for i=1,8 do

		img.ImageTransparency=.4
		task.wait(.04)

		img.ImageTransparency=0
		task.wait(.04)

	end


	task.wait(.8)

	glitch=false

	img.Position=UDim2.fromScale(.5,.5)
	img.Rotation=0


	TweenService:Create(
		img,
		TweenInfo.new(.5),
		{ImageTransparency=1}
	):Play()


	TweenService:Create(
		red,
		TweenInfo.new(.6),
		{BackgroundTransparency=1}
	):Play()


	task.wait(.7)

	container:Destroy()

end


ExecuteJumpScare()
end

local entityConfig = {
    ["rbxassetid://1"] = entityBehaviors.ATCHRipper,
    ["rbxassetid://3"] = entityBehaviors.AMIN60,
    ["rbxassetid://4"] = entityBehaviors.Black60,
    ["rbxassetid://5"] = entityBehaviors.INGODONE,
    ["rbxassetid://6"] = entityBehaviors.Subspace,
    ["rbxassetid://7"] = entityBehaviors.DELALL,
    ["rbxassetid://8"] = entityBehaviors.ChainSmoker,
    ["rbxassetid://9"] = entityBehaviors.LightSpeed,
    ["rbxassetid://10"] = entityBehaviors.A200Jump,
    ["rbxassetid://2"] = entityBehaviors.A200
}
local checkedEntities = {}

local CONTAINER_NAMES = {"############", "Scary Entity"}

local function universalCheckSound(sound)
    if not sound:IsA("Sound") then return end

    local soundId = sound.SoundId
    local targetBehavior = entityConfig[soundId]

    if targetBehavior then
        local parent = sound.Parent

        if parent and table.find(CONTAINER_NAMES, parent.Name) then
            local grandParent = parent.Parent
            if grandParent and grandParent.Name == "CustomEntity" then
                if not checkedEntities[grandParent] then
                    checkedEntities[grandParent] = true
                    targetBehavior()
                end
            end
        end
    end
end

workspace.DescendantAdded:Connect(function(obj)
    wait(0.1)
    universalCheckSound(obj)
end)

for _, entity in pairs(workspace:GetChildren()) do
    if entity.Name == "CustomEntity" then

        for _, containerName in ipairs(CONTAINER_NAMES) do
            local container = entity:FindFirstChild(containerName)
            if container then
                for _, child in pairs(container:GetChildren()) do
                    universalCheckSound(child)
                end
            end
        end
    end
end
-------
local hint = Instance.new("Hint", Workspace)
hint.Text = "Loading... Doors HardCore V10.6 By Mr.key & HeavenNow :)"
game.Debris:AddItem(hint, 3)