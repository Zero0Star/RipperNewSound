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

function entityBehaviors.Cease()
local Event = game:GetService("ReplicatedStorage").RemotesFolder.AdminPanelRunCommand
Event:FireServer(
    "LightRoom",
    {
        ["Light Color"] = Color3.new(0, 0.098297834396362, 1)
    }
)
local entity = spawner.Create({Entity = {Name = "Cease",Asset = "74118615017772",HeightOffset = 1},Lights = {Flicker = {Enabled = false,Duration = 10},Shatter = false,Repair = false},Earthquake = {Enabled = false},CameraShake = {Enabled = true,Range = 200,Values = {1.5, 20, 0.1, 1}},Movement = {Speed = 100,Delay = 0,Reversed = false},Rebounding = {Enabled = false,Type = "ambush",Min = 4,Max = 4,Delay = math.random(10, 30) / 10},Damage = {Enabled = false,Range = 100,Amount = 125},Crucifixion = {Enabled = true,Range = 100,Resist = false,Break = true},Death = {Type = "Guiding",Hints = {"CEASE", "你该学会辨别", "听取周围的声音", "反复进柜子躲避它"},Cause = ""}})
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
wait(40)
local Event = game:GetService("ReplicatedStorage").RemotesFolder.AdminPanelRunCommand
Event:FireServer(
    "LightRoom",
    {
        ["Light Color"] = Color3.new(0, 0, 0)
    }
)
end
function entityBehaviors.Shok()
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local function spawnShocker()
    local shockerModel = game:GetObjects("rbxassetid://129658537539698")[1]
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
function entityBehaviors.LightOSs()
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

local s = LoadCustomInstance(106818719931200, workspace)
if not s then
    return
end

local entity = s:FindFirstChildWhichIsA("BasePart")
entity.CFrame = GetRoom():WaitForChild("RoomEntrance").CFrame * CFrame.new(0, 7, -15)
entity.Part.CFrame = entity.CFrame
end

function entityBehaviors.LOOKSW()
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

local s = LoadCustomInstance(124094609630783, workspace)
if not s then
    return
end

local entity = s:FindFirstChildWhichIsA("BasePart")
entity.CFrame = GetRoom():WaitForChild("RoomEntrance").CFrame * CFrame.new(30, 1.2, -10)
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
end)

function entityBehaviors.SuperDread()
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

local s = LoadCustomInstance(140017686556165, workspace) 
if not s then
    return
end

local entity = s:FindFirstChildWhichIsA("BasePart")
entity.CFrame = GetRoom():WaitForChild("RoomEntrance").CFrame * CFrame.new(0, 1, -15)
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
end)
end
function entityBehaviors.DreadJump()
local BLACK = Color3.new(0, 0, 0)
local WHITE = Color3.new(1, 1, 1)

local part = Instance.new("Part")

part.Name = "Bound_" .. tick()
part.Parent = workspace
part.Size = Vector3.new(5, 5, 5)
part.Position = Vector3.new(0, 5, 0)
part.Anchored = true
part.Color = Color3.new(1, 0, 0)
local dreadJumpSound = workspace:FindFirstChild("DreadJump")
if dreadJumpSound and dreadJumpSound:IsA("Sound") then
    dreadJumpSound:Play()
end

task.wait(3)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local SHAKE_INTENSITY = 1
local SHAKE_DURATION = 15
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

local function getAllParts()
    local parts = {}
    local function collectParts(object)
        for _, child in ipairs(object:GetChildren()) do
            if child:IsA("BasePart") then
                table.insert(parts, child)
            end
            collectParts(child)
        end
    end
    collectParts(workspace)
    return parts
end

local allParts = getAllParts()
local isPlaying = true  
local colorSwitchCoroutine = coroutine.create(function()
    local isBlack = true
    while isPlaying do
        local targetColor = isBlack and BLACK or WHITE
        isBlack = not isBlack
        for _, part in ipairs(allParts) do
            part.Color = targetColor
        end
        task.wait(0.01)
    end
end)

coroutine.resume(colorSwitchCoroutine)

startSound.Ended:Connect(function()
    isPlaying = false
    startSound:Destroy()
end)

startSound.Stopped:Connect(function()
    isPlaying = false
    startSound:Destroy()
end)
end
local ContentProvider = game:GetService("ContentProvider")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local MULTI_MONSTER_VOLUME = 2

local MULTI_MONSTER_MUSIC = {
    {
        Name = "M1",
        FileName = "MultiMonster1",
        URL = "https://github.com/Zero0Star/RipperNewSound/blob/master/MultiMonster1.mp3?raw=true"
    },
    {
        Name = "M2",
        FileName = "MultiMonster2",
        URL = "https://github.com/Zero0Star/RipperNewSound/blob/master/MultiMonster2.mp3?raw=true"
    },
    {
        Name = "M3",
        FileName = "MultiMonster3",
        URL = "https://github.com/Zero0Star/RipperNewSound/blob/master/MultiMonster3.mp3?raw=true"
    },
    {
        Name = "M4",
        FileName = "MultiMonster4",
        URL = "https://github.com/Zero0Star/RipperNewSound/blob/master/MultiMonster4.mp3?raw=true"
    }
}

local function preloadMultiMonsterMusic(info)
    local sound = workspace:FindFirstChild(info.Name)

    if sound and not sound:IsA("Sound") then
        sound:Destroy()
        sound = nil
    end

    if not sound then
        sound = Instance.new("Sound")
        sound.Name = info.Name
        sound.Parent = workspace
    end

    sound.Volume = MULTI_MONSTER_VOLUME
    sound.Looped = false

    pcall(function()
        sound:Stop()
        sound.TimePosition = 0
    end)

    local ok, err = pcall(function()
        if type(writefile) ~= "function" or type(game.HttpGet) ~= "function" then
            error("executor file/http functions unavailable")
        end

        local path = info.FileName .. ".mp3"
        writefile(path, game:HttpGet(info.URL))

        local getter = getcustomasset or getsynasset

        if not getter then
            error("getcustomasset/getsynasset unavailable")
        end

        sound.SoundId = getter(path)

        pcall(function()
            ContentProvider:PreloadAsync({sound})
        end)
    end)

    if not ok then
        warn("[MultiMonster] Failed to preload " .. info.Name .. ":", err)
    end

    return sound
end

local MULTI_MONSTER_SOUNDS = {}

for _, info in ipairs(MULTI_MONSTER_MUSIC) do
    MULTI_MONSTER_SOUNDS[info.Name] = preloadMultiMonsterMusic(info)
end

local GLITCH_CHARACTERS = {
    "#", "$", "%", "&",
    "0", "1", "3", "7",
    "/", "\\", "<", ">",
    "_", "-", "!", "?",
    "[", "]", "{", "}",
    "@", "*"
}

local function randomGlitchCharacter()
    return GLITCH_CHARACTERS[math.random(1, #GLITCH_CHARACTERS)]
end

local function corruptText(original, chance)
    local result = {}

    for i = 1, #original do
        local char = original:sub(i, i)

        if char ~= " " and math.random() < chance then
            result[#result + 1] = randomGlitchCharacter()
        else
            result[#result + 1] = char
        end
    end

    return table.concat(result)
end

local function createMultiMonsterUI()
    local player = Players.LocalPlayer

    if not player then
        return nil
    end

    local playerGui = player:WaitForChild("PlayerGui")
    local old = playerGui:FindFirstChild("MultiMonsterGlitchUI")

    if old then
        old:Destroy()
    end

    local gui = Instance.new("ScreenGui")
    gui.Name = "MultiMonsterGlitchUI"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.DisplayOrder = 999999
    gui.Parent = playerGui

    local text = Instance.new("TextLabel")
    text.Name = "GlitchText"
    text.AnchorPoint = Vector2.new(0.5, 1)
    text.Position = UDim2.new(0.5, 0, 0.88, 0)
    text.Size = UDim2.new(0.85, 0, 0, 85)
    text.BackgroundTransparency = 1
    text.Text = ""
    text.TextColor3 = Color3.fromRGB(255, 20, 20)
    text.TextStrokeColor3 = Color3.fromRGB(35, 0, 0)
    text.TextStrokeTransparency = 0.1
    text.TextSize = 32
    text.TextWrapped = true

    pcall(function()
        text.FontFace = Font.new("rbxassetid://11702779517")
    end)

    text.Parent = gui

    local timerText = Instance.new("TextLabel")
    timerText.Name = "TimerText"
    timerText.AnchorPoint = Vector2.new(0.5, 0.5)
    timerText.Position = UDim2.new(0.5, 0, -0.15, 0)
    timerText.Size = UDim2.new(0, 420, 0, 60)
    timerText.BackgroundTransparency = 1
    timerText.Text = "Time : 304"
    timerText.TextColor3 = Color3.fromRGB(255, 20, 20)
    timerText.TextStrokeColor3 = Color3.fromRGB(35, 0, 0)
    timerText.TextStrokeTransparency = 0.05
    timerText.TextSize = 30
    timerText.Visible = false

    pcall(function()
        timerText.FontFace = Font.new("rbxassetid://11702779517")
    end)

    timerText.Parent = gui

    local glitchLines = {}

    for i = 1, 7 do
        local line = Instance.new("Frame")
        line.Name = "GlitchLine_" .. i
        line.BorderSizePixel = 0
        line.BackgroundColor3 = Color3.fromRGB(math.random(180, 255), 0, 0)
        line.BackgroundTransparency = 0.55
        line.Size = UDim2.new(
            math.random(8, 35) / 100,
            0,
            0,
            math.random(1, 3)
        )
        line.Position = UDim2.new(
            math.random(5, 80) / 100,
            0,
            math.random(65, 92) / 100,
            0
        )
        line.Visible = false
        line.Parent = gui

        table.insert(glitchLines, line)
    end

    local timerLines = {}

    for i = 1, 4 do
        local line = Instance.new("Frame")
        line.Name = "TimerGlitchLine_" .. i
        line.BorderSizePixel = 0
        line.BackgroundColor3 = Color3.fromRGB(math.random(190, 255), 0, 0)
        line.BackgroundTransparency = 0.45
        line.Size = UDim2.new(0, math.random(50, 160), 0, math.random(1, 2))
        line.Position = UDim2.new(0.5, math.random(-170, 170), 0.08, math.random(-10, 10))
        line.Visible = false
        line.Parent = gui

        table.insert(timerLines, line)
    end

    return gui, text, glitchLines, timerText, timerLines
end

local function showGlitchSentence(label, lines, sentence, duration)
    if not label then
        return
    end

    local running = true
    local originalPosition = UDim2.new(0.5, 0, 0.88, 0)

    label.Text = sentence
    label.Visible = true
    label.TextTransparency = 0

    task.spawn(function()
        while running and label.Parent do
            label.Position = UDim2.new(
                0.5,
                math.random(-2, 2),
                0.88,
                math.random(-1, 1)
            )

            if math.random() < 0.26 then
                label.Text = corruptText(sentence, 0.08)
            else
                label.Text = sentence
            end

            if math.random() < 0.11 then
                label.TextTransparency = math.random(15, 50) / 100
            else
                label.TextTransparency = 0
            end

            for _, line in ipairs(lines) do
                line.Visible = math.random() < 0.11

                if line.Visible then
                    line.Position = UDim2.new(
                        math.random(8, 82) / 100,
                        0,
                        math.random(68, 92) / 100,
                        0
                    )

                    line.Size = UDim2.new(
                        math.random(8, 30) / 100,
                        0,
                        0,
                        math.random(1, 3)
                    )
                end
            end

            task.wait(math.random(4, 10) / 100)
        end
    end)

    task.wait(duration)

    running = false
    label.Text = sentence
    label.TextTransparency = 0
    label.Position = originalPosition

    for _, line in ipairs(lines) do
        line.Visible = false
    end
end

local function dropTimer(timerText)
    if not timerText then
        return
    end

    timerText.Visible = true
    timerText.Position = UDim2.new(0.38, 0, -0.18, 0)

    local points = {
        UDim2.new(0.42, 0, -0.05, 0),
        UDim2.new(0.57, 0, 0.015, 0),
        UDim2.new(0.46, 0, 0.055, 0),
        UDim2.new(0.52, 0, 0.075, 0),
        UDim2.new(0.5, 0, 0.08, 0)
    }

    local times = {
        0.12,
        0.14,
        0.12,
        0.1,
        0.1
    }

    for i, point in ipairs(points) do
        local tween = TweenService:Create(
            timerText,
            TweenInfo.new(
                times[i],
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out
            ),
            {
                Position = point
            }
        )

        tween:Play()
        tween.Completed:Wait()
    end

    timerText.Position = UDim2.new(0.5, 0, 0.08, 0)
end

local function startMultiMonsterTimer(timerText, timerLines)
    if not timerText then
        return
    end

    dropTimer(timerText)

    task.spawn(function()
        for timeLeft = 315, 0, -1 do
            if not timerText or not timerText.Parent then
                return
            end

            local normalText = "Time : " .. timeLeft
            local secondStart = os.clock()

            while os.clock() - secondStart < 1 do
                if not timerText.Parent then
                    return
                end

                timerText.Position = UDim2.new(
                    0.5,
                    math.random(-2, 2),
                    0.08,
                    math.random(-1, 1)
                )

                if math.random() < 0.3 then
                    timerText.Text = corruptText(normalText, 0.1)
                else
                    timerText.Text = normalText
                end

                if math.random() < 0.1 then
                    timerText.TextTransparency = math.random(10, 40) / 100
                else
                    timerText.TextTransparency = 0
                end

                if math.random() < 0.07 then
                    timerText.TextColor3 = Color3.fromRGB(255, 90, 90)
                else
                    timerText.TextColor3 = Color3.fromRGB(255, 20, 20)
                end

                for _, line in ipairs(timerLines or {}) do
                    line.Visible = math.random() < 0.12

                    if line.Visible then
                        line.Position = UDim2.new(
                            0.5,
                            math.random(-180, 180),
                            0.08,
                            math.random(-18, 18)
                        )

                        line.Size = UDim2.new(
                            0,
                            math.random(40, 170),
                            0,
                            math.random(1, 2)
                        )
                    end
                end

                task.wait(math.random(4, 9) / 100)
            end
        end

        if timerText and timerText.Parent then
            timerText.Text = "Time : 0"
            timerText.Position = UDim2.new(0.5, 0, 0.08, 0)
            timerText.TextTransparency = 0
            timerText.TextColor3 = Color3.fromRGB(255, 20, 20)
        end

        for _, line in ipairs(timerLines or {}) do
            line.Visible = false
        end
    end)
end

local function playSoundAndWait(sound)
    if not sound then
        return
    end

    sound:Stop()
    sound.TimePosition = 0
    sound:Play()
    sound.Ended:Wait()
end

function entityBehaviors.MultiMonster()
    local M1 = MULTI_MONSTER_SOUNDS.M1
    local M2 = MULTI_MONSTER_SOUNDS.M2
    local M3 = MULTI_MONSTER_SOUNDS.M3
    local M4 = MULTI_MONSTER_SOUNDS.M4

    if not M1 or not M2 or not M3 or not M4 then
        warn("[MultiMonster] Sounds are missing.")
        return
    end

    for _, sound in ipairs({M1, M2, M3, M4}) do
        pcall(function()
            sound:Stop()
            sound.TimePosition = 0
        end)
    end

    local gui, glitchText, glitchLines, timerText, timerLines = createMultiMonsterUI()

    M1:Play()

    task.spawn(function()
        local sentences = {
            "...",
            "这个地方真有趣.",
            "我喜欢这里?",
            "我会伤害到你吗?",
            "我讨厌这些。",
            "玩笑话总是让你开心。"
        }

        local timeout = 0

        while M1.TimeLength <= 0 and timeout < 5 do
            timeout += 0.05
            task.wait(0.05)
        end

        local totalTime = M1.TimeLength

        if totalTime <= 0 then
            totalTime = 18
        end

        local sentenceDuration = math.max(2, totalTime / #sentences)

        for _, sentence in ipairs(sentences) do
            if not M1.IsPlaying then
                break
            end

            showGlitchSentence(
                glitchText,
                glitchLines,
                sentence,
                sentenceDuration
            )
        end
    end)

    M1.Ended:Wait()

    if glitchText then
        glitchText.Text = ""
        glitchText.Visible = false
    end

    for _, line in ipairs(glitchLines or {}) do
        line.Visible = false
    end

    M2:Stop()
    M2.TimePosition = 0
    M2:Play()

    task.spawn(function()
        startMultiMonsterTimer(timerText, timerLines)
    end)

    M2.Ended:Wait()

    playSoundAndWait(M2)

    playSoundAndWait(M3)
    playSoundAndWait(M3)

    playSoundAndWait(M4)

    if gui then
        gui:Destroy()
    end
end
function entityBehaviors.CreakHard()
local RunService = game:GetService("RunService")

local MODEL_ID = "rbxassetid://122236943587712"
local GRAPH_ID = "rbxassetid://94509516923082"

local creak = workspace
	:WaitForChild("LiveEntities")
	:WaitForChild("Creak")

local objects = game:GetObjects(MODEL_ID)
local clone = objects[1]

if not clone then
	return
end

clone.Name = "CreakMimic"
clone.Parent = workspace

local destroyed = false

local function cleanup()
	if destroyed then
		return
	end

	destroyed = true

	if clone and clone.Parent then
		clone:Destroy()
	end
end

creak.Destroying:Connect(cleanup)

creak.AncestryChanged:Connect(function(_, parent)
	if parent == nil then
		cleanup()
	end
end)

local function hide(obj)
	if obj:IsA("MeshPart") then
		obj.Transparency = 1
	end
end

for _, obj in ipairs(creak:GetDescendants()) do
	hide(obj)
end

creak.DescendantAdded:Connect(hide)

for _, obj in ipairs(clone:GetDescendants()) do
	if obj:IsA("BasePart") then
		obj.CanCollide = false
		obj.CanTouch = false
		obj.CanQuery = false
		obj.Massless = true
	end
end

local cloneRoot =
	clone:FindFirstChild("HumanoidRootPart", true)
	or clone.PrimaryPart
	or clone:FindFirstChildWhichIsA("BasePart", true)

if not cloneRoot then
	cleanup()
	return
end

cloneRoot.Anchored = true
cloneRoot.Massless = false

if clone:IsA("Model") then
	clone.PrimaryPart = cloneRoot
end

local function findAnimator(model)
	local controller =
		model:FindFirstChild("AnimationController", true)

	if controller then
		local animator =
			controller:FindFirstChildWhichIsA(
				"Animator",
				true
			)

		if animator then
			return animator
		end
	end

	return model:FindFirstChildWhichIsA(
		"Animator",
		true
	)
end

local sourceAnimator = findAnimator(creak)
local targetAnimator = findAnimator(clone)

if not sourceAnimator or not targetAnimator then
	cleanup()
	return
end

local function isGraph(track)
	local animation = track.Animation

	if not animation then
		return false
	end

	return
		animation.AnimationId == GRAPH_ID
		or animation.Name == "CreakGraph"
end

local sourceTrack

for _, track in ipairs(
	sourceAnimator:GetPlayingAnimationTracks()
) do
	if isGraph(track) then
		sourceTrack = track
		break
	end
end

sourceAnimator.AnimationPlayed:Connect(function(track)
	if destroyed then
		return
	end

	if isGraph(track) then
		sourceTrack = track
	end
end)

while not sourceTrack and not destroyed do
	task.wait(0.05)

	if destroyed or not creak.Parent then
		cleanup()
		return
	end

	for _, track in ipairs(
		sourceAnimator:GetPlayingAnimationTracks()
	) do
		if isGraph(track) then
			sourceTrack = track
			break
		end
	end
end

if destroyed then
	return
end

for _, track in ipairs(
	targetAnimator:GetPlayingAnimationTracks()
) do
	track:Stop(0)
end

local graphAnimation = Instance.new("Animation")
graphAnimation.Name = "CreakGraph"
graphAnimation.AnimationId = GRAPH_ID

local targetTrack =
	targetAnimator:LoadAnimation(graphAnimation)

local parameterNames = {}

local function updateParameterList()
	table.clear(parameterNames)

	if not sourceTrack then
		return
	end

	local success, defaults = pcall(function()
		return sourceTrack:GetParameterDefaults()
	end)

	if not success or type(defaults) ~= "table" then
		return
	end

	for name in pairs(defaults) do
		table.insert(parameterNames, name)
	end
end

updateParameterList()

local function syncParameters()
	if destroyed then
		return
	end

	local src = sourceTrack
	local dst = targetTrack

	if not src or not dst then
		return
	end

	for i = 1, #parameterNames do
		local name = parameterNames[i]

		local success, value = pcall(
			src.GetParameter,
			src,
			name
		)

		if success and value ~= nil then
			pcall(
				dst.SetParameter,
				dst,
				name,
				value
			)
		end
	end
end

syncParameters()

targetTrack:Play(0, 1, 1)

local lastSourceTrack = sourceTrack

local preAnimationConnection
local renderConnection

preAnimationConnection = RunService.PreAnimation:Connect(function()
	if destroyed then
		preAnimationConnection:Disconnect()
		return
	end

	if sourceTrack ~= lastSourceTrack then
		lastSourceTrack = sourceTrack
		updateParameterList()
	end

	syncParameters()
end)

renderConnection = RunService.RenderStepped:Connect(function()
	if destroyed then
		renderConnection:Disconnect()
		return
	end

	if not creak.Parent then
		cleanup()
		renderConnection:Disconnect()
		return
	end

	if not clone.Parent then
		renderConnection:Disconnect()
		return
	end

	clone:PivotTo(
		creak:GetPivot()
	)
end)
end
function entityBehaviors.CreakWhite()
local RunService = game:GetService("RunService")
local MODEL_ID = "rbxassetid://107076625314099"
local GRAPH_ID = "rbxassetid://94509516923082"
local creak = workspace
	:WaitForChild("LiveEntities")
	:WaitForChild("Creak")

local objects = game:GetObjects(MODEL_ID)
local clone = objects[1]

if not clone then
	return
end

clone.Name = "CreakMimic"
clone.Parent = workspace

local destroyed = false

local function cleanup()
	if destroyed then
		return
	end

	destroyed = true

	if clone and clone.Parent then
		clone:Destroy()
	end
end

creak.Destroying:Connect(cleanup)

creak.AncestryChanged:Connect(function(_, parent)
	if parent == nil then
		cleanup()
	end
end)

local function hide(obj)
	if obj:IsA("MeshPart") then
		obj.Transparency = 1
	end
end

for _, obj in ipairs(creak:GetDescendants()) do
	hide(obj)
end

creak.DescendantAdded:Connect(hide)

for _, obj in ipairs(clone:GetDescendants()) do
	if obj:IsA("BasePart") then
		obj.CanCollide = false
		obj.CanTouch = false
		obj.CanQuery = false
		obj.Massless = true
	end
end

local cloneRoot =
	clone:FindFirstChild("HumanoidRootPart", true)
	or clone.PrimaryPart
	or clone:FindFirstChildWhichIsA("BasePart", true)

if not cloneRoot then
	cleanup()
	return
end

cloneRoot.Anchored = true
cloneRoot.Massless = false

if clone:IsA("Model") then
	clone.PrimaryPart = cloneRoot
end

local function findAnimator(model)
	local controller =
		model:FindFirstChild("AnimationController", true)

	if controller then
		local animator =
			controller:FindFirstChildWhichIsA(
				"Animator",
				true
			)

		if animator then
			return animator
		end
	end

	return model:FindFirstChildWhichIsA(
		"Animator",
		true
	)
end

local sourceAnimator = findAnimator(creak)
local targetAnimator = findAnimator(clone)

if not sourceAnimator or not targetAnimator then
	cleanup()
	return
end

local function isGraph(track)
	local animation = track.Animation

	if not animation then
		return false
	end

	return
		animation.AnimationId == GRAPH_ID
		or animation.Name == "CreakGraph"
end

local sourceTrack

for _, track in ipairs(
	sourceAnimator:GetPlayingAnimationTracks()
) do
	if isGraph(track) then
		sourceTrack = track
		break
	end
end

sourceAnimator.AnimationPlayed:Connect(function(track)
	if destroyed then
		return
	end

	if isGraph(track) then
		sourceTrack = track
	end
end)

while not sourceTrack and not destroyed do
	task.wait(0.05)

	if destroyed or not creak.Parent then
		cleanup()
		return
	end

	for _, track in ipairs(
		sourceAnimator:GetPlayingAnimationTracks()
	) do
		if isGraph(track) then
			sourceTrack = track
			break
		end
	end
end

if destroyed then
	return
end

for _, track in ipairs(
	targetAnimator:GetPlayingAnimationTracks()
) do
	track:Stop(0)
end

local graphAnimation = Instance.new("Animation")
graphAnimation.Name = "CreakGraph"
graphAnimation.AnimationId = GRAPH_ID

local targetTrack =
	targetAnimator:LoadAnimation(graphAnimation)

local parameterNames = {}

local function updateParameterList()
	table.clear(parameterNames)

	if not sourceTrack then
		return
	end

	local success, defaults = pcall(function()
		return sourceTrack:GetParameterDefaults()
	end)

	if not success or type(defaults) ~= "table" then
		return
	end

	for name in pairs(defaults) do
		table.insert(parameterNames, name)
	end
end

updateParameterList()

local function syncParameters()
	if destroyed then
		return
	end

	local src = sourceTrack
	local dst = targetTrack

	if not src or not dst then
		return
	end

	for i = 1, #parameterNames do
		local name = parameterNames[i]

		local success, value = pcall(
			src.GetParameter,
			src,
			name
		)

		if success and value ~= nil then
			pcall(
				dst.SetParameter,
				dst,
				name,
				value
			)
		end
	end
end

syncParameters()

targetTrack:Play(0, 1, 1)

local lastSourceTrack = sourceTrack

local preAnimationConnection
local renderConnection

preAnimationConnection = RunService.PreAnimation:Connect(function()
	if destroyed then
		preAnimationConnection:Disconnect()
		return
	end

	if sourceTrack ~= lastSourceTrack then
		lastSourceTrack = sourceTrack
		updateParameterList()
	end

	syncParameters()
end)

renderConnection = RunService.RenderStepped:Connect(function()
	if destroyed then
		renderConnection:Disconnect()
		return
	end

	if not creak.Parent then
		cleanup()
		renderConnection:Disconnect()
		return
	end

	if not clone.Parent then
		renderConnection:Disconnect()
		return
	end

	clone:PivotTo(
		creak:GetPivot() * CFrame.new(0, 2.8, 0)
	)
end)
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

local function TriggerJumpscare1()
    if jumpscareActive or jumpscareFinished then
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

    if humanoid and humanoid.Parent then
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

    if jumpscareActive or jumpscareFinished then
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

            if jumpscareActive or jumpscareFinished then
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
            os.clock()

        local currentMode =
            nil

        while
            audioToken == token
            and not jumpscareFinished
            and os.clock() - started < totalDuration
        do
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

        if nearSilence then
            StopSoundWatcher1()
        end
    end)
end

function entityBehaviors.Silence()
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
            os.clock()

        while true do
            if jumpscareFinished then
                return false
            end

            local alpha =
                math.clamp(
                    (os.clock() - started)
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
            os.clock()

        while
            os.clock()
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

    audioToken += 1

    StopSoundWatcher1()

    ResetSound1(
        SilenceFarSound
    )

    if Silence and Silence.Parent then
        Silence:Destroy()
    end
end

function entityBehaviors.DeerGod()
local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local Debris = game:GetService("Debris")

    local entityModel = nil
    local chaseConnection = nil
    local lockedPlayer = nil

    local customSpeed = 20
    local lockRange = 250

    local teleportDistance = 80
    local teleportForwardOffset = 50
    local teleportStartDelay = 20

    local canTeleport = false

    local player = Players.LocalPlayer

    local glitchGui = nil
    local glitchConnection = nil


    local function CreateDeerGodGlitch()

        glitchGui = Instance.new("ScreenGui")
        glitchGui.Name = "DeerGodGlitch"
        glitchGui.IgnoreGuiInset = true
        glitchGui.ResetOnSpawn = false
        glitchGui.Parent = player:WaitForChild("PlayerGui")

        local noise = Instance.new("ImageLabel")
        noise.Parent = glitchGui
        noise.Size = UDim2.new(1,0,1,0)
        noise.BackgroundTransparency = 1
        noise.Image = "rbxassetid://8116159092"
        noise.ScaleType = Enum.ScaleType.Tile
        noise.TileSize = UDim2.new(0,180,0,180)
        noise.ImageTransparency = 0.92


        glitchConnection = RunService.RenderStepped:Connect(function()

            if not glitchGui or not glitchGui.Parent then
                return
            end

            noise.ImageTransparency = 0.86 + math.random()*0.1

            noise.Position = UDim2.new(
                0,
                math.random(-6,6),
                0,
                math.random(-6,6)
            )

            if math.random() < 0.08 then

                local bar = Instance.new("Frame")
                bar.Parent = glitchGui
                bar.Size = UDim2.new(
                    math.random(20,80)/100,
                    0,
                    0,
                    math.random(2,8)
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

                Debris:AddItem(bar,0.08)

            end

        end)

    end


    local entity = spawner.Create({

        Entity = {
            Name = "Deer god",
            Asset = "101210986101880",
            HeightOffset = -4
        },

        Lights = {
            Flicker = {
                Enabled = true,
                Duration = 50
            },
            Shatter = true,
            Repair = false
        },

        CameraShake = {
            Enabled = true,
            Range = 1500,
            Values = {0.5,5,0.1,1}
        },

        Movement = {
            Speed = 20,
            Delay = 2,
            Reversed = true
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
                "看起来你真倒霉...",
                "你被所谓的鹿神击杀了",
                "不要理它过于遥远",
                "十字架不能保证你的安全"
            },
            Cause = "Deer God"
        }
    })

    local function FindTarget()

        local nearest = nil
        local shortest = math.huge

        local pos = entityModel.PrimaryPart.Position

        for _,p in ipairs(Players:GetPlayers()) do

            local char = p.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            local hum = char and char:FindFirstChild("Humanoid")

            if root and hum and hum.Health > 0 then

                local dist = (root.Position-pos).Magnitude

                if dist < shortest and dist <= lockRange then
                    shortest = dist
                    nearest = p
                end

            end
        end

        return nearest
    end


    entity:SetCallback("OnSpawned",function()

        entityModel = entity.Model

        if entityModel and not entityModel.PrimaryPart then
            entityModel.PrimaryPart =
                entityModel:FindFirstChild("Main")
                or entityModel:FindFirstChildWhichIsA("BasePart")
        end


        if not entityModel or not entityModel.PrimaryPart then
            return
        end


        CreateDeerGodGlitch()

        lockedPlayer = FindTarget()


        task.delay(teleportStartDelay,function()

            if entityModel and lockedPlayer then
                canTeleport = true
            end

        end)


        chaseConnection = RunService.Heartbeat:Connect(function(dt)

            if not entityModel or not entityModel.PrimaryPart then
                return
            end

            if not lockedPlayer then
                return
            end


            local char = lockedPlayer.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            local hum = char and char:FindFirstChild("Humanoid")


            if not root or not hum then
                return
            end


            if hum.Health <= 0 then

                if chaseConnection then
                    chaseConnection:Disconnect()
                end

                entityModel:Destroy()
                entityModel=nil
                lockedPlayer=nil

                return

            end


            local pos = entityModel.PrimaryPart.Position
            local target = root.Position

            local distance = (target-pos).Magnitude


            if canTeleport and distance >= teleportDistance then

                local forwardPosition =
                    root.Position +
                    root.CFrame.LookVector * teleportForwardOffset


                entityModel:SetPrimaryPartCFrame(
                    CFrame.lookAt(
                        forwardPosition,
                        forwardPosition-root.CFrame.LookVector
                    )
                )


                local sound = Instance.new("Sound")
                sound.SoundId = "rbxassetid://131811476310735"
                sound.Volume = 8
                sound.Parent = entityModel.PrimaryPart

                sound:Play()

                sound.Ended:Connect(function()
                    sound:Destroy()
                end)

                return
            end


            local direction = (target-pos).Unit
            local newPos = pos + direction*customSpeed*dt


            entityModel:SetPrimaryPartCFrame(
                CFrame.lookAt(
                    newPos,
                    newPos-direction
                )
            )

        end)


        task.delay(85,function()

            if chaseConnection then
                chaseConnection:Disconnect()
            end

            if entityModel then
                entityModel:Destroy()
            end

            local folder = workspace:FindFirstChild("HardCoreSound")

            if folder then
                local sound = folder:FindFirstChild("DeerGodMusic")
                if sound then
                    sound:Stop()
                end
            end

            if glitchConnection then
                glitchConnection:Disconnect()
            end

            if glitchGui then
                glitchGui:Destroy()
            end

        end)

    end)


    entity:Run()


    local folder = workspace:FindFirstChild("HardCoreSound")

    if folder then
        local music = folder:FindFirstChild("DeerGodMusic")
        if music then
            music:Play()
        end
    end
end
function entityBehaviors.FrostBite()
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
					humanoid.Health -= 5
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
function entityBehaviors.HATRED()
local HATRED_PREPARED_SOUND = nil

local function getHatredSound()
    local folder = game:GetService("Workspace"):FindFirstChild("HardCoreSound")
    if not folder then
        return nil
    end

    local sound = folder:FindFirstChild("HATRED")
    if sound and sound:IsA("Sound") then
        HATRED_PREPARED_SOUND = sound
        return sound
    end

    return nil
end

local function createPreparedHatredSound()
    return getHatredSound()
end

do
    createPreparedHatredSound()
end

_G.entityBehaviors = entityBehaviors
if type(getgenv) == "function" then
    getgenv().entityBehaviors = entityBehaviors
end
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")

local player = Players.LocalPlayer
if not player then
    return
end

if type(_G.HatredBossController) == "table"
    and type(_G.HatredBossController.Stop) == "function" then
    pcall(_G.HatredBossController.Stop)
end

local CONFIG = {
    ModelId = 94520721608869,
    MusicVolume = 0.8,

    StartDistance = 120,
    StopDistance = 15,
    ApproachDuration = 20,
    HoverHeight = 3,
    HoverDuration = 260,

    FlickerDuration = 260,
    FlickerAmount = 30,
    ShakeDuration = 260,
    ShakeIntensity = 0.7,

    PhaseGoals = {10, 15, 20},
    PhaseTimes = {20, 30, 30},
    BluePenalty = 3,
    PhaseTransitionSoundId = 102844356541414,
    PhaseTransitionDelay = 2.2,

    FailureFadeDuration = 5,
    FailureStormDuration = 13,
    FailureVoidDuration = 2.5,
    FaceSwapDuration = 0.1,
    FaceSwapMinDelay = 1.4,
    FaceSwapMaxDelay = 3.2,
    FailureSoundId = 139866863795650,
    FailureSoundVolume = 4,
}

local COLORS = {
    Background = Color3.fromRGB(7, 8, 14),
    Panel = Color3.fromRGB(17, 19, 29),
    Panel2 = Color3.fromRGB(27, 29, 43),
    Text = Color3.fromRGB(242, 244, 255),
    Muted = Color3.fromRGB(151, 157, 183),
    Red = Color3.fromRGB(255, 54, 72),
    RedDark = Color3.fromRGB(138, 22, 42),
    Blue = Color3.fromRGB(48, 128, 255),
    Gold = Color3.fromRGB(255, 195, 77),
    Green = Color3.fromRGB(87, 232, 151),
}

local State = {
    running = false,
    ending = false,
    cleaned = false,
    token = 0,
    phase = 0,
    clicks = 0,
    deadline = 0,

    connections = {},
    tweens = {},
    targetTweens = {},
    instances = {},

    music = nil,
    phaseSound = nil,
    failureSound = nil,
    boss = nil,
    blur = nil,
    gui = nil,
    ui = nil,
    inventory = nil,
    bossConnection = nil,
    mouseConnection = nil,

    originalMouseBehavior = nil,
    originalMouseIconEnabled = nil,
    originalInventoryVisible = nil,
}

local Controller = {}
_G.HatredBossController = Controller

local function alive(token)
    return State.running and not State.cleaned and State.token == token
end

local function addConnection(connection)
    if connection then
        table.insert(State.connections, connection)
    end
    return connection
end

local function disconnect(connection)
    if connection then
        pcall(function()
            connection:Disconnect()
        end)
    end
end

local function destroy(instance)
    if instance and instance.Parent then
        pcall(function()
            instance:Destroy()
        end)
    end
end

local function playTween(instance, info, goal)
    if not instance or not instance.Parent then
        return nil
    end
    local tween = TweenService:Create(instance, info, goal)
    table.insert(State.tweens, tween)
    tween:Play()
    return tween
end

local function waitCancelable(seconds, token)
    local finishAt = os.clock() + seconds
    while os.clock() < finishAt do
        if not alive(token) then
            return false
        end
        task.wait(math.max(0, math.min(0.1, finishAt - os.clock())))
    end
    return alive(token)
end

local function safeCaption(text)
    pcall(function()
        local mainUI = player:WaitForChild("PlayerGui", 3):FindFirstChild("MainUI")
        local initiator = mainUI and mainUI:FindFirstChild("Initiator")
        local mainGame = initiator and initiator:FindFirstChild("Main_Game")
        if mainGame then
            require(mainGame).caption(text, true)
        end
    end)
end

local function getCharacterParts(timeout)
    local character = player.Character or player.CharacterAdded:Wait()
    local root = character:WaitForChild("HumanoidRootPart", timeout or 5)
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    return character, root, humanoid
end

local function startRoomFlicker()
    task.spawn(function()
        pcall(function()
            local gameData = ReplicatedStorage:FindFirstChild("GameData")
            local latestRoomValue = gameData and gameData:FindFirstChild("LatestRoom")
            local rooms = Workspace:FindFirstChild("CurrentRooms")
            local room = latestRoomValue and rooms and rooms:FindFirstChild(tostring(latestRoomValue.Value))
            local modules = ReplicatedStorage:FindFirstChild("ModulesClient")
            local eventModule = modules and modules:FindFirstChild("Module_Events")
            if room and eventModule then
                require(eventModule).flicker(room, CONFIG.FlickerDuration, CONFIG.FlickerAmount)
            end
        end)
    end)
end

local SHAKE_BIND_NAME = "HatredBossCameraShake"

local function startCameraShake(token)
    pcall(function()
        RunService:UnbindFromRenderStep(SHAKE_BIND_NAME)
    end)

    local startedAt = os.clock()
    RunService:BindToRenderStep(SHAKE_BIND_NAME, Enum.RenderPriority.Camera.Value + 1, function()
        if not alive(token) then
            pcall(function()
                RunService:UnbindFromRenderStep(SHAKE_BIND_NAME)
            end)
            return
        end

        local elapsed = os.clock() - startedAt
        if elapsed >= CONFIG.ShakeDuration then
            pcall(function()
                RunService:UnbindFromRenderStep(SHAKE_BIND_NAME)
            end)
            return
        end

        local camera = Workspace.CurrentCamera
        if camera then
            local decay = math.max(0.12, 1 - elapsed / CONFIG.ShakeDuration)
            local power = CONFIG.ShakeIntensity * decay
            local x = math.noise(elapsed * 5.1, 0, 0) * power
            local y = math.noise(0, elapsed * 5.7, 0) * power
            local roll = math.noise(0, 0, elapsed * 4.6) * math.rad(power)
            camera.CFrame = camera.CFrame * CFrame.new(x, y, 0) * CFrame.Angles(0, 0, roll)
        end
    end)
end

local function loadBossMusic()
    local sound = HATRED_PREPARED_SOUND or getHatredSound()
    if not sound then
        return nil
    end

    sound:Stop()
    sound.Volume = 0
    sound.Looped = true
    State.music = sound
    sound.TimePosition = 0
    sound:Play()
    playTween(sound, TweenInfo.new(1.5, Enum.EasingStyle.Quad), {Volume = CONFIG.MusicVolume})
    return sound
end

local function fadeMusic(seconds)
    local sound = State.music
    State.music = nil
    if not sound then
        return
    end

    if sound.Parent then
        local tween = TweenService:Create(sound, TweenInfo.new(seconds or 1.2, Enum.EasingStyle.Quad), {Volume = 0})
        tween:Play()
        task.delay(seconds or 1.2, function()
            if sound and sound.Parent then
                pcall(function()
                    sound:Stop()
                end)
            end
        end)
    end
end

local function createGlowingModel()
    local model = Instance.new("Model")
    model.Name = "MovingModel"

    local mainPart = Instance.new("Part")
    mainPart.Name = "Core"
    mainPart.Size = Vector3.new(5, 5, 5)
    mainPart.Shape = Enum.PartType.Ball
    mainPart.Color = Color3.fromRGB(0, 200, 255)
    mainPart.Material = Enum.Material.Neon
    mainPart.Transparency = 0.2
    mainPart.CanCollide = false
    mainPart.Anchored = true
    mainPart.Parent = model

    local pointLight = Instance.new("PointLight")
    pointLight.Color = Color3.fromRGB(100, 200, 255)
    pointLight.Range = 30
    pointLight.Brightness = 5
    pointLight.Parent = mainPart

    model.PrimaryPart = mainPart
    return model
end

local function loadBossModel()
    local success, result = pcall(function()
        local objects = game:GetObjects("rbxassetid://" .. tostring(CONFIG.ModelId))
        if objects and #objects > 0 then
            return objects[1]:Clone()
        end
        return nil
    end)

    if success and result then
        return result
    end

    return createGlowingModel()
end

local function startBossMovement(root, token)
    local model = loadBossModel()
    if not model then
        return false
    end

    model.Name = "HatRed"
    model.Parent = Workspace
    State.boss = model

    local primaryPart = model.PrimaryPart
    if not primaryPart then
        for _, part in ipairs(model:GetDescendants()) do
            if part:IsA("BasePart") then
                model.PrimaryPart = part
                primaryPart = part
                break
            end
        end
    end

    if not primaryPart then
        model:Destroy()
        State.boss = nil
        return false
    end

    for _, part in ipairs(model:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
            part.Anchored = true
        end
    end

    local playerPos = root.Position
    local playerLook = root.CFrame.LookVector
    local startPos = playerPos + (playerLook * CONFIG.StartDistance)
    startPos = startPos + Vector3.new(0, 10, 0)
    model:SetPrimaryPartCFrame(CFrame.new(startPos))

    local startTime = tick()
    local isMoving = true
    local isHovering = false
    local hoverStartTime = 0
    local connection

    connection = RunService.Heartbeat:Connect(function()
        if not alive(token) or not model or not model.Parent or not model:IsDescendantOf(Workspace) then
            if connection then
                connection:Disconnect()
            end
            return
        end

        if not root or not root.Parent then
            if connection then
                connection:Disconnect()
            end
            if model and model.Parent then
                model:Destroy()
            end
            return
        end

        local currentTime = tick()
        local currentPlayerPos = root.Position
        local playerLookDirection = root.CFrame.LookVector

        if isMoving then
            local elapsed = currentTime - startTime
            local progress = math.min(elapsed / CONFIG.ApproachDuration, 1)

            if progress >= 1 then
                isMoving = false
                isHovering = true
                hoverStartTime = currentTime
                return
            end

            local easedProgress = progress * progress
            local targetPos = currentPlayerPos + (playerLookDirection * CONFIG.StopDistance)
                + Vector3.new(0, CONFIG.HoverHeight, 0)
            local currentPos = startPos:Lerp(targetPos, easedProgress)
            model:SetPrimaryPartCFrame(CFrame.new(currentPos))

            local lookDirection = currentPlayerPos - currentPos
            if lookDirection.Magnitude > 0.1 then
                lookDirection = lookDirection.Unit
                model:SetPrimaryPartCFrame(CFrame.new(currentPos, currentPos + lookDirection))
            end
        elseif isHovering then
            local hoverTime = currentTime - hoverStartTime
            if hoverTime >= CONFIG.HoverDuration then
                if model and model.Parent then
                    model:Destroy()
                end
                if connection then
                    connection:Disconnect()
                end
                return
            end

            local targetPos = currentPlayerPos + (playerLookDirection * CONFIG.StopDistance)
                + Vector3.new(0, CONFIG.HoverHeight, 0)
            local currentPos = primaryPart.Position
            local smoothedPos = currentPos:Lerp(targetPos, 0.1)
            model:SetPrimaryPartCFrame(CFrame.new(smoothedPos))

            local lookDirection = currentPlayerPos - smoothedPos
            if lookDirection.Magnitude > 0.1 then
                lookDirection = lookDirection.Unit
                model:SetPrimaryPartCFrame(CFrame.new(smoothedPos, smoothedPos + lookDirection))
            end
        end
    end)

    State.bossConnection = connection
    addConnection(connection)
    return true
end

local FACE_NORMAL_ID = 92470122721520
local FACE_GLITCH_IDS = {
    130581413102559,
    94635282583639,
    16804066476,
    16595430194,
}

local function findReboundFace()
    local hatRed = State.boss
    if not hatRed or not hatRed.Parent then
        hatRed = Workspace:FindFirstChild("HatRed")
    end
    if not hatRed then
        return nil
    end

    local face = hatRed:FindFirstChild("FACE", true)
    local attachment = face and face:FindFirstChild("Attachment", true)
    return attachment and attachment:FindFirstChild("Rebound Face", true) or nil
end

local function setFaceTexture(faceObject, assetId)
    if not faceObject or not faceObject.Parent then
        return false
    end

    local asset = "rbxassetid://" .. tostring(assetId)
    local property
    if faceObject:IsA("ImageLabel") or faceObject:IsA("ImageButton") then
        property = "Image"
    elseif faceObject:IsA("MeshPart") then
        property = "TextureID"
    else
        property = "Texture"
    end

    return pcall(function()
        faceObject[property] = asset
    end)
end

local function startFaceChanging(token)
    task.spawn(function()
        while alive(token) and State.boss and State.boss.Parent do
            local delaySeconds = CONFIG.FaceSwapMinDelay
                + math.random() * (CONFIG.FaceSwapMaxDelay - CONFIG.FaceSwapMinDelay)
            if not waitCancelable(delaySeconds, token) then
                return
            end

            local faceObject = findReboundFace()
            if faceObject then
                local randomId = FACE_GLITCH_IDS[math.random(1, #FACE_GLITCH_IDS)]
                setFaceTexture(faceObject, randomId)
                if not waitCancelable(CONFIG.FaceSwapDuration, token) then
                    return
                end
                setFaceTexture(faceObject, FACE_NORMAL_ID)
            else
                task.wait(0.2)
            end
        end
    end)
end

local function hideInventory()
    local playerGui = player:FindFirstChild("PlayerGui")
    if not playerGui then
        return
    end

    local mainUI = playerGui:FindFirstChild("MainUI")
    local settings = mainUI and mainUI:FindFirstChild("Settings")
    local inventory = settings and settings:FindFirstChild("Inventory")
    if not inventory then
        for _, item in ipairs(playerGui:GetDescendants()) do
            if item:IsA("GuiObject") and item.Name:lower():find("inventory", 1, true) then
                inventory = item
                break
            end
        end
    end

    if inventory and inventory:IsA("GuiObject") then
        State.inventory = inventory
        State.originalInventoryVisible = inventory.Visible
        inventory.Visible = false
    end
end

local function startMouseOverride(token)
    State.originalMouseBehavior = UserInputService.MouseBehavior
    State.originalMouseIconEnabled = UserInputService.MouseIconEnabled

    State.mouseConnection = addConnection(RunService.RenderStepped:Connect(function()
        if alive(token) and State.phase > 0 then
            UserInputService.MouseBehavior = Enum.MouseBehavior.Default
            UserInputService.MouseIconEnabled = true
        end
    end))
    UserInputService.MouseBehavior = Enum.MouseBehavior.Default
    UserInputService.MouseIconEnabled = true
end

local function corner(parent, radius)
    local item = Instance.new("UICorner")
    item.CornerRadius = UDim.new(0, radius)
    item.Parent = parent
    return item
end

local function stroke(parent, color, thickness, transparency)
    local item = Instance.new("UIStroke")
    item.Color = color
    item.Thickness = thickness
    item.Transparency = transparency or 0
    item.Parent = parent
    return item
end

local function makeLabel(parent, name, text, size, position, font, color, textSize, alignment)
    local label = Instance.new("TextLabel")
    label.Name = name
    label.BackgroundTransparency = 1
    label.Size = size
    label.Position = position
    label.Font = font or Enum.Font.Gotham
    label.Text = text
    label.TextColor3 = color or COLORS.Text
    label.TextSize = textSize or 18
    label.TextWrapped = true
    label.TextXAlignment = alignment or Enum.TextXAlignment.Center
    label.ZIndex = 15
    label.Parent = parent
    return label
end

local function makeTarget(parent, name, color, diameter)
    local button = Instance.new("TextButton")
    button.Name = name
    button.AnchorPoint = Vector2.new(0.5, 0.5)
    button.Size = UDim2.fromOffset(diameter + 12, diameter + 12)
    button.Position = UDim2.fromScale(0.5, 0.5)
    button.BackgroundTransparency = 1
    button.BorderSizePixel = 0
    button.AutoButtonColor = false
    button.Text = ""
    button.Active = true
    button.Selectable = true
    button.ZIndex = 20
    button.Parent = parent

    local orb = Instance.new("Frame")
    orb.Name = "Orb"
    orb.AnchorPoint = Vector2.new(0.5, 0.5)
    orb.Position = UDim2.fromScale(0.5, 0.5)
    orb.Size = UDim2.fromOffset(diameter, diameter)
    orb.BackgroundColor3 = color
    orb.BorderSizePixel = 0
    orb.ZIndex = 20
    orb.Parent = button
    corner(orb, 999)

    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new(Color3.new(1, 1, 1), color)
    gradient.Rotation = 45
    gradient.Parent = orb
    stroke(orb, Color3.new(1, 1, 1), 2, 0.45)

    local scale = Instance.new("UIScale")
    scale.Name = "PopScale"
    scale.Scale = 1
    scale.Parent = button

    local shine = Instance.new("Frame")
    shine.Name = "Shine"
    shine.AnchorPoint = Vector2.new(0.5, 0.5)
    shine.Position = UDim2.fromScale(0.36, 0.34)
    shine.Size = UDim2.fromScale(0.26, 0.26)
    shine.BackgroundColor3 = Color3.new(1, 1, 1)
    shine.BackgroundTransparency = 0.25
    shine.BorderSizePixel = 0
    shine.ZIndex = 21
    shine.Parent = orb
    corner(shine, 999)

    return button
end

local function setTargetDiameter(target, diameter)
    if not target then
        return
    end
    target.Size = UDim2.fromOffset(diameter + 12, diameter + 12)
    local orb = target:FindFirstChild("Orb")
    if orb then
        orb.Size = UDim2.fromOffset(diameter, diameter)
    end
end

local function createUI()
    local playerGui = player:WaitForChild("PlayerGui")
    local old = playerGui:FindFirstChild("HatredBossUI")
    destroy(old)

    local gui = Instance.new("ScreenGui")
    gui.Name = "HatredBossUI"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Global
    gui.DisplayOrder = 10000
    gui.Parent = playerGui
    State.gui = gui

    local dim = Instance.new("Frame")
    dim.Name = "Dim"
    dim.Size = UDim2.fromScale(1, 1)
    dim.BackgroundColor3 = Color3.new(0, 0, 0)
    dim.BackgroundTransparency = 1
    dim.BorderSizePixel = 0
    dim.ZIndex = 10
    dim.Parent = gui

    local panel = Instance.new("Frame")
    panel.Name = "Panel"
    panel.AnchorPoint = Vector2.new(0.5, 0.5)
    panel.Position = UDim2.fromScale(0.5, 0.5)
    panel.Size = UDim2.fromScale(0.72, 0.72)
    panel.BackgroundColor3 = COLORS.Panel
    panel.BackgroundTransparency = 0.05
    panel.BorderSizePixel = 0
    panel.ClipsDescendants = true
    panel.ZIndex = 11
    panel.Parent = gui
    corner(panel, 18)
    stroke(panel, Color3.fromRGB(107, 48, 68), 2, 0.25)

    local sizeConstraint = Instance.new("UISizeConstraint")
    sizeConstraint.MinSize = Vector2.new(310, 340)
    sizeConstraint.MaxSize = Vector2.new(980, 700)
    sizeConstraint.Parent = panel

    local panelScale = Instance.new("UIScale")
    panelScale.Name = "EntranceScale"
    panelScale.Scale = 0.84
    panelScale.Parent = panel

    local accent = Instance.new("Frame")
    accent.Size = UDim2.new(1, 0, 0, 5)
    accent.BackgroundColor3 = COLORS.Red
    accent.BorderSizePixel = 0
    accent.ZIndex = 12
    accent.Parent = panel
    local accentGradient = Instance.new("UIGradient")
    accentGradient.Color = ColorSequence.new(COLORS.RedDark, COLORS.Red, COLORS.RedDark)
    accentGradient.Parent = accent

    local title = makeLabel(panel, "Title", "H A T R E D", UDim2.new(0.55, 0, 0, 44), UDim2.new(0.04, 0, 0, 18), Enum.Font.GothamBlack, COLORS.Text, 23, Enum.TextXAlignment.Left)
    local phaseLabel = makeLabel(panel, "Phase", "PHASE 1 / 3", UDim2.new(0.35, 0, 0, 44), UDim2.new(0.61, 0, 0, 18), Enum.Font.GothamBold, COLORS.Gold, 16, Enum.TextXAlignment.Right)

    local instruction = makeLabel(panel, "Instruction", "点击红色目标", UDim2.new(0.92, 0, 0, 34), UDim2.new(0.04, 0, 0, 65), Enum.Font.GothamMedium, COLORS.Muted, 16)

    local statBar = Instance.new("Frame")
    statBar.Name = "StatBar"
    statBar.Size = UDim2.new(0.92, 0, 0, 46)
    statBar.Position = UDim2.new(0.04, 0, 0, 104)
    statBar.BackgroundColor3 = COLORS.Panel2
    statBar.BorderSizePixel = 0
    statBar.ZIndex = 12
    statBar.Parent = panel
    corner(statBar, 10)

    local counter = makeLabel(statBar, "Counter", "0 / 10", UDim2.new(0.28, 0, 1, 0), UDim2.new(0.03, 0, 0, 0), Enum.Font.GothamBold, COLORS.Text, 17, Enum.TextXAlignment.Left)
    local timer = makeLabel(statBar, "Timer", "20.0", UDim2.new(0.25, 0, 1, 0), UDim2.new(0.72, 0, 0, 0), Enum.Font.GothamBlack, COLORS.Text, 19, Enum.TextXAlignment.Right)

    local progressBack = Instance.new("Frame")
    progressBack.Name = "ProgressBack"
    progressBack.AnchorPoint = Vector2.new(0.5, 0.5)
    progressBack.Position = UDim2.fromScale(0.5, 0.5)
    progressBack.Size = UDim2.new(0.36, 0, 0, 7)
    progressBack.BackgroundColor3 = Color3.fromRGB(49, 52, 70)
    progressBack.BorderSizePixel = 0
    progressBack.ZIndex = 13
    progressBack.Parent = statBar
    corner(progressBack, 999)

    local progress = Instance.new("Frame")
    progress.Name = "Progress"
    progress.Size = UDim2.fromScale(0, 1)
    progress.BackgroundColor3 = COLORS.Red
    progress.BorderSizePixel = 0
    progress.ZIndex = 14
    progress.Parent = progressBack
    corner(progress, 999)

    local arena = Instance.new("Frame")
    arena.Name = "Arena"
    arena.Size = UDim2.new(0.92, 0, 1, -205)
    arena.Position = UDim2.new(0.04, 0, 0, 164)
    arena.BackgroundColor3 = COLORS.Background
    arena.BackgroundTransparency = 0.12
    arena.BorderSizePixel = 0
    arena.ClipsDescendants = true
    arena.ZIndex = 12
    arena.Parent = panel
    corner(arena, 14)
    stroke(arena, Color3.fromRGB(69, 72, 94), 1, 0.35)

    local arenaGradient = Instance.new("UIGradient")
    arenaGradient.Color = ColorSequence.new(Color3.fromRGB(13, 14, 23), Color3.fromRGB(25, 13, 21))
    arenaGradient.Rotation = 35
    arenaGradient.Parent = arena

    local redTarget = makeTarget(arena, "RedTarget", COLORS.Red, 66)
    local blueTarget1 = makeTarget(arena, "BlueTarget1", COLORS.Blue, 58)
    local blueTarget2 = makeTarget(arena, "BlueTarget2", COLORS.Blue, 58)
    blueTarget1.Visible = false
    blueTarget2.Visible = false

    local footer = makeLabel(panel, "Footer", "Blue -3s", UDim2.new(0.92, 0, 0, 26), UDim2.new(0.04, 0, 1, -34), Enum.Font.Gotham, COLORS.Muted, 12)

    local phaseSound = Instance.new("Sound")
    phaseSound.Name = "HatredPhaseTransition"
    phaseSound.SoundId = "rbxassetid://" .. tostring(CONFIG.PhaseTransitionSoundId)
    phaseSound.Volume = 0.9
    phaseSound.Parent = SoundService
    State.phaseSound = phaseSound

    State.blur = Instance.new("BlurEffect")
    State.blur.Name = "HatredBossBlur"
    State.blur.Size = 0
    State.blur.Parent = Lighting

    playTween(dim, TweenInfo.new(0.55, Enum.EasingStyle.Quad), {BackgroundTransparency = 0.36})
    playTween(State.blur, TweenInfo.new(0.55, Enum.EasingStyle.Quad), {Size = 14})
    playTween(panelScale, TweenInfo.new(0.55, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1})

    State.ui = {
        Dim = dim,
        Panel = panel,
        PanelScale = panelScale,
        Phase = phaseLabel,
        Instruction = instruction,
        Counter = counter,
        Timer = timer,
        Progress = progress,
        Arena = arena,
        Red = redTarget,
        Blue1 = blueTarget1,
        Blue2 = blueTarget2,
        Footer = footer,
    }
    return State.ui
end

local function moveTarget(target, speed)
    local ui = State.ui
    if not ui or not target or not target.Visible or not target.Parent then
        return
    end

    local arenaSize = ui.Arena.AbsoluteSize
    local targetSize = target.AbsoluteSize
    if arenaSize.X < 10 or arenaSize.Y < 10 then
        return
    end

    local halfX = targetSize.X * 0.5 + 8
    local halfY = targetSize.Y * 0.5 + 8
    local x = math.random(math.floor(halfX), math.max(math.floor(halfX), math.floor(arenaSize.X - halfX)))
    local y = math.random(math.floor(halfY), math.max(math.floor(halfY), math.floor(arenaSize.Y - halfY)))

    local oldTween = State.targetTweens[target]
    if oldTween then
        pcall(function()
            oldTween:Cancel()
        end)
    end
    local tween = TweenService:Create(target, TweenInfo.new(speed, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = UDim2.fromOffset(x, y),
    })
    State.targetTweens[target] = tween
    tween:Play()
end

local function targetPulse(target, color)
    if not target or not target.Parent then
        return
    end
    local scale = target:FindFirstChild("PopScale")
    local orb = target:FindFirstChild("Orb")
    local outline = orb and orb:FindFirstChildOfClass("UIStroke")
    if scale then
        scale.Scale = 0.78
        playTween(scale, TweenInfo.new(0.24, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1})
    end
    if outline then
        outline.Color = color
        outline.Transparency = 0
        playTween(outline, TweenInfo.new(0.35), {Transparency = 0.45})
    end
end

local function updateHUD()
    local ui = State.ui
    if not ui or not ui.Panel.Parent or State.phase < 1 then
        return
    end

    local goal = CONFIG.PhaseGoals[State.phase]
    ui.Phase.Text = string.format("PHASE %d / 3", State.phase)
    ui.Counter.Text = string.format("%d / %d", State.clicks, goal)
    local ratio = math.clamp(State.clicks / goal, 0, 1)
    playTween(ui.Progress, TweenInfo.new(0.18, Enum.EasingStyle.Quad), {Size = UDim2.fromScale(ratio, 1)})

    if State.phase == 1 then
        ui.Phase.TextColor3 = COLORS.Gold
        ui.Instruction.Text = "Click the red one!"
    elseif State.phase == 2 then
        ui.Phase.TextColor3 = Color3.fromRGB(217, 112, 255)
        ui.Instruction.Text = "Click the red one, Dodge the blue"
    else
        ui.Phase.TextColor3 = COLORS.Red
        ui.Instruction.Text = "END：Dodge the blue."
    end
end

local function flashMessage(text, color, seconds, token)
    local ui = State.ui
    if not ui or not ui.Instruction.Parent then
        return
    end
    local expectedPhase = State.phase
    ui.Instruction.Text = text
    ui.Instruction.TextColor3 = color
    task.delay(seconds or 0.8, function()
        if alive(token) and State.phase == expectedPhase then
            ui.Instruction.TextColor3 = COLORS.Muted
            updateHUD()
        end
    end)
end

local function beginPhase(phase, token)
    if not alive(token) then
        return
    end
    State.phase = phase
    State.clicks = 0
    State.deadline = os.clock() + CONFIG.PhaseTimes[phase]

    local ui = State.ui
    ui.Progress.Size = UDim2.fromScale(0, 1)
    ui.Red.Visible = true
    ui.Blue1.Visible = phase >= 2
    ui.Blue2.Visible = phase >= 3
    setTargetDiameter(ui.Red, phase == 1 and 66 or (phase == 2 and 58 or 52))
    setTargetDiameter(ui.Blue1, phase == 3 and 50 or 56)
    setTargetDiameter(ui.Blue2, 50)
    updateHUD()

    task.defer(function()
        RunService.Heartbeat:Wait()
        if alive(token) then
            moveTarget(ui.Red, 0)
            moveTarget(ui.Blue1, 0)
            moveTarget(ui.Blue2, 0)
        end
    end)
end

local function removeBoss()
    local model = State.boss
    State.boss = nil
    disconnect(State.bossConnection)
    State.bossConnection = nil
    destroy(model)
end

local function restoreLocalState()
    if State.inventory and State.inventory.Parent and State.originalInventoryVisible ~= nil then
        State.inventory.Visible = State.originalInventoryVisible
    end
    State.inventory = nil

    if State.originalMouseBehavior ~= nil then
        UserInputService.MouseBehavior = State.originalMouseBehavior
    end
    if State.originalMouseIconEnabled ~= nil then
        UserInputService.MouseIconEnabled = State.originalMouseIconEnabled
    end
end

local function cleanup(immediate)
    if State.cleaned then
        return
    end
    State.cleaned = true
    State.running = false
    State.phase = 0
    State.token = State.token + 1

    pcall(function()
        RunService:UnbindFromRenderStep(SHAKE_BIND_NAME)
    end)

    for _, connection in ipairs(State.connections) do
        disconnect(connection)
    end
    State.connections = {}

    for _, tween in ipairs(State.tweens) do
        pcall(function()
            tween:Cancel()
        end)
    end
    State.tweens = {}
    State.targetTweens = {}

    fadeMusic(immediate and 0.05 or 0.9)
    destroy(State.phaseSound)
    State.phaseSound = nil
    destroy(State.failureSound)
    State.failureSound = nil
    destroy(State.boss)
    State.boss = nil
    destroy(State.blur)
    State.blur = nil
    destroy(State.gui)
    State.gui = nil
    State.ui = nil
    restoreLocalState()
end

Controller.Stop = function()
    cleanup(false)
end

local function defeatPlayer()
    local character, _, humanoid = getCharacterParts(2)
    local signaled = false
    if type(replicatesignal) == "function" then
        signaled = pcall(function()
            replicatesignal(player.Kill)
        end)
    end
    if not signaled and humanoid and humanoid.Parent then
        humanoid.Health = 0
    elseif not signaled and character then
        character:BreakJoints()
    end
end

local FAILURE_TEXTURE_IDS = {
    88894221959954,
    12293713542,
    6214195404,
}

local function createFailureOverlay()
    local gui = State.gui
    if not gui or not gui.Parent then
        return nil
    end

    local old = gui:FindFirstChild("FailureOverlay")
    destroy(old)

    local overlay = Instance.new("Frame")
    overlay.Name = "FailureOverlay"
    overlay.Size = UDim2.fromScale(1, 1)
    overlay.BackgroundColor3 = Color3.new(0, 0, 0)
    overlay.BackgroundTransparency = 1
    overlay.BorderSizePixel = 0
    overlay.ClipsDescendants = true
    overlay.ZIndex = 500
    overlay.Parent = gui

    local textLayer = Instance.new("Frame")
    textLayer.Name = "LoserTextLayer"
    textLayer.Size = UDim2.fromScale(1, 1)
    textLayer.BackgroundTransparency = 1
    textLayer.BorderSizePixel = 0
    textLayer.ZIndex = 510
    textLayer.Parent = overlay

    local glitchBars = {}
    for index = 1, 18 do
        local bar = Instance.new("Frame")
        bar.Name = "EdgeError" .. index
        bar.BackgroundColor3 = COLORS.Red
        bar.BackgroundTransparency = 1
        bar.BorderSizePixel = 0
        bar.ZIndex = 505
        bar.Parent = overlay
        table.insert(glitchBars, bar)
    end

    local glitchImages = {}
    for index = 1, 12 do
        local image = Instance.new("ImageLabel")
        image.Name = "ErrorTexture" .. index
        image.AnchorPoint = Vector2.new(0.5, 0.5)
        image.BackgroundTransparency = 1
        image.BorderSizePixel = 0
        image.Image = "rbxassetid://" .. tostring(FAILURE_TEXTURE_IDS[((index - 1) % #FAILURE_TEXTURE_IDS) + 1])
        image.ImageTransparency = 1
        image.ScaleType = Enum.ScaleType.Stretch
        image.Visible = false
        image.ZIndex = 508 + (index % 3)
        image.Parent = overlay
        table.insert(glitchImages, image)
    end

    destroy(State.failureSound)
    local failureSound = Instance.new("Sound")
    failureSound.Name = "HatredLoserGlitch"
    failureSound.SoundId = "rbxassetid://" .. tostring(CONFIG.FailureSoundId)
    failureSound.Volume = CONFIG.FailureSoundVolume
    failureSound.Parent = SoundService
    State.failureSound = failureSound

    return overlay, textLayer, glitchBars, glitchImages
end

local function updateFailureGlitch(textLayer, glitchBars, glitchImages, intensity)
    if textLayer and textLayer.Parent then
        local jitter = math.floor(2 + intensity * 12)
        textLayer.Position = UDim2.fromOffset(math.random(-jitter, jitter), math.random(-jitter, jitter))
    end

    for index, bar in ipairs(glitchBars) do
        if not bar.Parent then
            continue
        end

        local side = ((index - 1) % 4) + 1
        local thickness = math.random(2, math.floor(5 + intensity * 25))
        local length = math.random(8, math.floor(20 + intensity * 70)) / 100
        if side == 1 then
            bar.Size = UDim2.new(length, 0, 0, thickness)
            bar.Position = UDim2.new(math.random(), 0, 0, math.random(0, 22))
        elseif side == 2 then
            bar.AnchorPoint = Vector2.new(0, 1)
            bar.Size = UDim2.new(length, 0, 0, thickness)
            bar.Position = UDim2.new(math.random(), 0, 1, -math.random(0, 22))
        elseif side == 3 then
            bar.Size = UDim2.new(0, thickness, length, 0)
            bar.Position = UDim2.new(0, math.random(0, 22), math.random(), 0)
        else
            bar.AnchorPoint = Vector2.new(1, 0)
            bar.Size = UDim2.new(0, thickness, length, 0)
            bar.Position = UDim2.new(1, -math.random(0, 22), math.random(), 0)
        end

        local colorRoll = math.random(1, 5)
        bar.BackgroundColor3 = colorRoll == 1 and Color3.new(1, 1, 1)
            or (colorRoll == 2 and Color3.fromRGB(30, 0, 0) or COLORS.Red)
        bar.BackgroundTransparency = math.random(5, math.floor(35 + (1 - intensity) * 50)) / 100
        bar.Visible = math.random() < (0.35 + intensity * 0.65)
    end

    for _, image in ipairs(glitchImages) do
        if image.Parent then
            local width = math.random(18, math.floor(35 + intensity * 55)) / 100
            local height = math.random(12, math.floor(25 + intensity * 50)) / 100
            image.Size = UDim2.fromScale(width, height)
            image.Position = UDim2.fromScale(math.random(), math.random())
            image.Rotation = math.random(-12, 12)
            image.Image = "rbxassetid://" .. tostring(FAILURE_TEXTURE_IDS[math.random(1, #FAILURE_TEXTURE_IDS)])
            image.ImageColor3 = math.random() < 0.25 and Color3.new(1, 1, 1)
                or Color3.fromRGB(255, math.random(15, 75), math.random(15, 75))
            image.ImageTransparency = math.random(8, math.floor(35 + (1 - intensity) * 45)) / 100
            image.Visible = math.random() < (0.2 + intensity * 0.72)
        end
    end
end

local function spawnLoserText(textLayer, intensity, isFirst)
    if not textLayer or not textLayer.Parent then
        return
    end

    local failureSound = State.failureSound
    if failureSound and failureSound.Parent then
        pcall(function()
            failureSound.TimePosition = 0
            failureSound:Play()
        end)
    end

    local label = Instance.new("TextLabel")
    label.Name = "YOUR_LOSER"
    label.AnchorPoint = Vector2.new(0.5, 0.5)
    label.Size = isFirst and UDim2.fromOffset(420, 100)
        or UDim2.fromOffset(math.random(150, 430), math.random(45, 115))
    label.Position = isFirst and UDim2.fromScale(0.5, 0.5)
        or UDim2.fromScale(math.random(), math.random())
    label.BackgroundTransparency = 1
    label.BorderSizePixel = 0
    label.Font = math.random() < 0.35 and Enum.Font.Code or Enum.Font.GothamBlack
    label.Text = "YOUR LOSER"
    label.TextColor3 = math.random() < 0.18 and Color3.new(1, 1, 1) or COLORS.Red
    label.TextStrokeColor3 = Color3.new(0, 0, 0)
    label.TextStrokeTransparency = math.max(0, 0.5 - intensity * 0.45)
    label.TextTransparency = isFirst and 0 or math.random(0, 25) / 100
    label.TextScaled = true
    label.Rotation = isFirst and 0 or math.random(-18, 18)
    label.ZIndex = 520 + math.random(0, 5)
    label.Parent = textLayer

    local scale = Instance.new("UIScale")
    scale.Scale = isFirst and 0.15 or math.random(35, 85) / 100
    scale.Parent = label
    playTween(
        scale,
        TweenInfo.new(isFirst and 0.55 or math.max(0.04, 0.18 - intensity * 0.12), Enum.EasingStyle.Back),
        {Scale = isFirst and 1 or math.random(90, 150) / 100}
    )
end

local function playFailureSequence(token)
    local overlay, textLayer, glitchBars, glitchImages = createFailureOverlay()
    if not overlay then
        return false
    end

    playTween(
        overlay,
        TweenInfo.new(CONFIG.FailureFadeDuration, Enum.EasingStyle.Sine, Enum.EasingDirection.In),
        {BackgroundTransparency = 0}
    )

    if not waitCancelable(1.4, token) then
        return false
    end

    spawnLoserText(textLayer, 0, true)
    if not waitCancelable(1.1, token) then
        return false
    end
    local stormStart = os.clock()
    local spawned = 1

    while alive(token) do
        local elapsed = os.clock() - stormStart
        local progress = math.clamp(elapsed / CONFIG.FailureStormDuration, 0, 1)
        if progress >= 1 then
            break
        end

        updateFailureGlitch(textLayer, glitchBars, glitchImages, progress)
        local burst = 1 + math.floor(progress * 4)
        for _ = 1, burst do
            if spawned >= 240 then
                break
            end
            spawnLoserText(textLayer, progress, false)
            spawned = spawned + 1
        end

        local interval = 0.92 * ((1 - progress) ^ 2) + 0.045
        if not waitCancelable(interval, token) then
            return false
        end
    end

    if textLayer and textLayer.Parent then
        textLayer:Destroy()
    end
    for _, bar in ipairs(glitchBars) do
        destroy(bar)
    end
    for _, image in ipairs(glitchImages) do
        destroy(image)
    end
    destroy(State.failureSound)
    State.failureSound = nil
    overlay.BackgroundTransparency = 0

    return waitCancelable(CONFIG.FailureVoidDuration, token)
end

local function finish(result, token)
    if State.ending or not alive(token) then
        return
    end
    State.ending = true

    local ui = State.ui
    if ui then
        ui.Red.Visible = false
        ui.Blue1.Visible = false
        ui.Blue2.Visible = false
        ui.Timer.Text = result == "victory" and "CLEAR" or "FAILED"
        ui.Timer.TextColor3 = result == "victory" and COLORS.Green or COLORS.Red
        ui.Instruction.Text = result == "victory" and "存活于憎恨" or "YOUR LOSER"
        ui.Instruction.TextColor3 = result == "victory" and COLORS.Green or COLORS.Red
    end

    if result == "victory" then
        removeBoss()
        fadeMusic(1.8)
        waitCancelable(1.1, token)
        safeCaption("It looks like you've made progress. Congratulations.")
        waitCancelable(1.3, token)
        cleanup(false)
    else
        fadeMusic(4)
        if playFailureSequence(token) and alive(token) then
            defeatPlayer()
        end
        cleanup(true)
    end
end

local function startMiniGame(token)
    local ui = createUI()
    hideInventory()
    beginPhase(1, token)
    startMouseOverride(token)

    local transitioning = false
    local nextRedMove = 0
    local nextBlue1Move = 0
    local nextBlue2Move = 0

    addConnection(ui.Red.Activated:Connect(function()
        if not alive(token) or State.ending or transitioning then
            return
        end
        State.clicks = State.clicks + 1
        targetPulse(ui.Red, Color3.new(1, 1, 1))
        updateHUD()

        if State.clicks >= CONFIG.PhaseGoals[State.phase] then
            if State.phase >= 3 then
                task.spawn(finish, "victory", token)
                return
            end

            transitioning = true
            local nextPhase = State.phase + 1
            State.deadline = math.huge
            ui.Red.Visible = false
            ui.Blue1.Visible = false
            ui.Blue2.Visible = false
            ui.Timer.Text = "READY"
            ui.Timer.TextColor3 = COLORS.Gold
            ui.Instruction.Text = nextPhase == 3
                and "存活第二阶段"
                or "存活第一阶段"
            ui.Instruction.TextColor3 = COLORS.Gold
            if State.phaseSound then
                State.phaseSound.TimePosition = 0
                State.phaseSound:Play()
            end
            task.delay(CONFIG.PhaseTransitionDelay, function()
                if alive(token) then
                    beginPhase(nextPhase, token)
                    transitioning = false
                end
            end)
        else
            moveTarget(ui.Red, State.phase == 3 and 0.12 or 0.18)
        end
    end))

    local function blueClicked(target)
        if not alive(token) or State.ending or transitioning or State.phase < 2 then
            return
        end
        State.deadline = State.deadline - CONFIG.BluePenalty
        targetPulse(target, COLORS.Red)
        flashMessage("-3s 躲避蓝色", COLORS.Red, 0.75, token)
        moveTarget(target, 0.16)
    end

    addConnection(ui.Blue1.Activated:Connect(function()
        blueClicked(ui.Blue1)
    end))
    addConnection(ui.Blue2.Activated:Connect(function()
        if State.phase >= 3 then
            blueClicked(ui.Blue2)
        end
    end))

    addConnection(RunService.Heartbeat:Connect(function()
        if not alive(token) or State.ending or State.phase < 1 then
            return
        end

        if transitioning then
            ui.Timer.Text = "READY"
            ui.Timer.TextColor3 = COLORS.Gold
            return
        end

        local now = os.clock()
        local remaining = math.max(0, State.deadline - now)
        ui.Timer.Text = string.format("%.1f", remaining)
        ui.Timer.TextColor3 = remaining <= 5 and COLORS.Red or COLORS.Text

        if not transitioning then
            local redInterval = State.phase == 1 and 0.82 or (State.phase == 2 and 0.66 or 0.5)
            if now >= nextRedMove then
                moveTarget(ui.Red, State.phase == 3 and 0.16 or 0.22)
                nextRedMove = now + redInterval
            end
            if State.phase >= 2 and now >= nextBlue1Move then
                moveTarget(ui.Blue1, 0.3)
                nextBlue1Move = now + (State.phase == 3 and 0.8 or 1.05)
            end
            if State.phase >= 3 and now >= nextBlue2Move then
                moveTarget(ui.Blue2, 0.3)
                nextBlue2Move = now + 0.9
            end
        end

        if remaining <= 0 then
            task.spawn(finish, "defeat", token)
        end
    end))
end

local function runEvent()
    if State.running then
        return
    end

    State.cleaned = false
    State.running = true
    State.ending = false
    State.phase = 0
    State.clicks = 0
    State.token = State.token + 1
    local token = State.token

    local ok, errorMessage = xpcall(function()
        local _, root = getCharacterParts(6)
        if not root then
            error("HumanoidRootPart was not found")
        end

        startRoomFlicker()
        startCameraShake(token)
        loadBossMusic()
        safeCaption("What is this?")
        if not waitCancelable(0.5, token) then
            return
        end
        if not startBossMovement(root, token) then
            error("Original boss model could not be loaded")
        end
        startFaceChanging(token)

        if not waitCancelable(CONFIG.ApproachDuration, token) then
            return
        end
        safeCaption("We meet again, little bug.")
        if not waitCancelable(3.2, token) then return end
        safeCaption("I hope you can learn a lesson this time.")
        if not waitCancelable(3.2, token) then return end
        safeCaption("Let's get started.")
        if not waitCancelable(1, token) then return end

        startMiniGame(token)
    end, debug.traceback)

    if not ok then
        cleanup(true)
    end
end

addConnection(player.CharacterRemoving:Connect(function()
    cleanup(true)
end))

Controller.Start = runEvent
task.spawn(runEvent)
end
function entityBehaviors.A500()
local Players=game:GetService("Players")
local RunService=game:GetService("RunService")
local ReplicatedStorage=game:GetService("ReplicatedStorage")
local Lighting=game:GetService("Lighting")
local Workspace=game:GetService("Workspace")

local player=Players.LocalPlayer
local camera=Workspace.CurrentCamera

local CurrentRooms=Workspace:WaitForChild("CurrentRooms")
local LatestRoom=ReplicatedStorage.GameData.LatestRoom
local SoundFolder=Workspace:WaitForChild("HardCoreSound")

local A500One=SoundFolder.A500One
local A500Two=SoundFolder.A500Two
local A500Three=SoundFolder.A500Three
local A500Four=SoundFolder.A500Four

local roomChanges=0
local phase87=false
local gameEnded=false

local flameModel=nil
local flameRunning=false
local flameDamageCooldown=false


local function ReplaceTV()
	for _,v in ipairs(CurrentRooms:GetDescendants()) do
		if v:IsA("TextLabel") then
			if v.Name=="Number" then
				v.Text="??"
				v.TextColor3=Color3.fromRGB(151,60,255)
			elseif v.Name=="TextLabel" then
				v.Text="Y!o#u$ n%e&e%d t#o r!u$n f%a#s$t!e%r!"
				v.TextColor3=Color3.fromRGB(151,60,255)
			end
		end

		if v:IsA("SurfaceGui") or v:IsA("BillboardGui") then
			if v.Name=="TellerGui" then
				v.Enabled=true
			end
		end
	end
end


local function HideRoom(room)
	if not room then return end

	for _,v in ipairs(room:GetDescendants()) do
		if v:IsA("BasePart") then
			if v.Name=="Floor" or v.Name=="Ceiling" or v.Name=="Carpet" then
				v.Transparency=1
				v.LocalTransparencyModifier=1
			end
		end
	end
end


local hideConnection=CurrentRooms.ChildAdded:Connect(function(room)
	if gameEnded then return end

	if phase87 then
		task.wait(.1)
		HideRoom(room)
	else
		task.wait(.2)
		ReplaceTV()
	end
end)


LatestRoom.Changed:Connect(function()
	roomChanges+=1
end)


local function ErrorFlash()
	local gui=Instance.new("ScreenGui")
	gui.IgnoreGuiInset=true
	gui.ResetOnSpawn=false
	gui.Parent=player.PlayerGui

	local f=Instance.new("Frame")
	f.Size=UDim2.fromScale(1,1)
	f.BackgroundColor3=Color3.new(0,0,0)
	f.BackgroundTransparency=1
	f.Parent=gui

	for i=1,8 do
		f.BackgroundTransparency=0
		task.wait(.035)
		f.BackgroundTransparency=1
		task.wait(.035)
	end

	gui:Destroy()
end


local function Impact()
	local old=camera.FieldOfView
	local t=0

	while t<10 and not gameEnded do
		t+=RunService.RenderStepped:Wait()
		local p=(10-t)/10

		camera.FieldOfView=old+70*p

		camera.CFrame*=CFrame.new(
			math.sin(t*20)*.2*p,
			math.sin(t*12)*.05*p,
			0
		)
	end
end


local function ChangeSky()
	local sky=Lighting:FindFirstChildOfClass("Sky") or Instance.new("Sky",Lighting)

	sky.SkyboxBk="rbxassetid://15983968922"
	sky.SkyboxDn="rbxassetid://15983966825"
	sky.SkyboxFt="rbxassetid://15983965025"
	sky.SkyboxLf="rbxassetid://15983967420"
	sky.SkyboxRt="rbxassetid://15983966246"
	sky.SkyboxUp="rbxassetid://15983964246"
end


local function SpawnFlame()
	local objects=game:GetObjects("rbxassetid://88313881550159")
	local model=objects[1]

	if not model then return end

	flameModel=model
	flameModel.Name="Flame of Fury"
	flameModel.Parent=Workspace

	local root=flameModel.PrimaryPart or flameModel:FindFirstChildWhichIsA("BasePart")
	if not root then
		flameModel:Destroy()
		return
	end

	local char=player.Character or player.CharacterAdded:Wait()
	local hrp=char:WaitForChild("HumanoidRootPart")

	flameModel:PivotTo(hrp.CFrame*CFrame.new(0,0,100))
	flameRunning=true

	RunService:BindToRenderStep("FlameChase",301,function(dt)
		if not flameRunning or gameEnded or not flameModel.Parent then
			RunService:UnbindFromRenderStep("FlameChase")
			return
		end

		local target=player.Character and player.Character:FindFirstChild("HumanoidRootPart")
		if not target then return end

		local dir=target.Position-root.Position

		if dir.Magnitude>3 then
			root.CFrame=CFrame.lookAt(root.Position+dir.Unit*35*dt,target.Position)
		end

		local params=RaycastParams.new()
		params.FilterType=Enum.RaycastFilterType.Exclude
		params.FilterDescendantsInstances={flameModel}

		local hit=Workspace:Raycast(root.Position,dir.Unit*8,params)

		if hit and hit.Instance:IsDescendantOf(target.Parent) and not flameDamageCooldown then
			flameDamageCooldown=true

			local hum=target.Parent:FindFirstChildOfClass("Humanoid")
			if hum then hum:TakeDamage(90) end

			task.delay(5,function()
				flameDamageCooldown=false
			end)
		end
	end)
end


local function RemoveFlame()
	flameRunning=false

	pcall(function()
		RunService:UnbindFromRenderStep("FlameChase")
	end)

	if flameModel then
		flameModel:Destroy()
		flameModel=nil
	end
end


A500One.Looped=true
A500One:Play()
task.wait(.5)
ReplaceTV()


while roomChanges<3 do
	LatestRoom.Changed:Wait()
end


A500One:Stop()
A500Two:Play()


task.delay(5.2,function()
	ErrorFlash()
	task.wait(.15)
	Impact()
	SpawnFlame()
end)


task.delay(87,function()
	phase87=true

	ErrorFlash()
	task.wait(.15)

	Impact()
	ChangeSky()

	for _,r in ipairs(CurrentRooms:GetChildren()) do
		HideRoom(r)
	end
end)


A500Two.Ended:Wait()


if roomChanges<50 then
	A500Three.Looped=true
	A500Three:Play()

	while roomChanges<50 do
		task.wait(.1)
	end

	A500Three:Stop()
end


A500Four:Play()

gameEnded=true
phase87=false

RemoveFlame()

if hideConnection then
	hideConnection:Disconnect()
	hideConnection=nil
end

camera.FieldOfView=70
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
    ["rbxassetid://11"] = entityBehaviors.Cease, 
    ["rbxassetid://12"] = entityBehaviors.Shok,
    ["rbxassetid://13"] = entityBehaviors.LightOSs,
    ["rbxassetid://14"] = entityBehaviors.SuperDread,
    ["rbxassetid://15"] = entityBehaviors.DreadJump,
    ["rbxassetid://16"] = entityBehaviors.MultiMonster,
    ["rbxassetid://17"] = entityBehaviors.CreakHard,
    ["rbxassetid://18"] = entityBehaviors.CreakWhite,
    ["rbxassetid://19"] = entityBehaviors.Silence,
    ["rbxassetid://20"] = entityBehaviors.DeerGod,
    ["rbxassetid://21"] = entityBehaviors.FrostBite,
    ["rbxassetid://22"] = entityBehaviors.HATRED,
    ["rbxassetid://23"] = entityBehaviors.A500,
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
end