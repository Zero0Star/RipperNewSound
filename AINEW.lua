
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local TargetName = "Staryyy011"
local ModelId = "rbxassetid://114870919830460"
local AnimationId = "rbxassetid://124872988646325"

local IsTargetPlayer = LocalPlayer.Name == TargetName

local ModelAnimationDelay = 3
local RiseDistance = 3
local FallDistance = 10
local RiseDuration = 0.7
local StayDuration = 0.7
local FallDuration = 1.2
local AfterFallDelay = 2
local FadeDuration = 2

local TargetPlayer = Players:FindFirstChild(TargetName)

if not TargetPlayer then
    TargetPlayer = Players:WaitForChild(TargetName, 30)
end

if not TargetPlayer then
    return
end

local TargetCharacter = TargetPlayer.Character or TargetPlayer.CharacterAdded:Wait()
local TargetRoot = TargetCharacter:WaitForChild("HumanoidRootPart", 15)
local TargetHumanoid = TargetCharacter:WaitForChild("Humanoid", 15)

if not TargetRoot or not TargetHumanoid then
    return
end

local function LoadEffectModel()
    local success, objects = pcall(function()
        return game:GetObjects(ModelId)
    end)

    if not success or not objects or #objects == 0 then
        return nil
    end

    local model = Instance.new("Model")
    model.Name = "CUR"

    for _, object in ipairs(objects) do
        object.Parent = model
    end

    if not model:FindFirstChildWhichIsA("BasePart", true) then
        model:Destroy()
        return nil
    end

    for _, object in ipairs(model:GetDescendants()) do
        if object:IsA("BasePart") then
            object.Anchored = true
            object.CanCollide = false
            object.CanTouch = false
            object.CanQuery = false
        end
    end

    local originalPivot = model:GetPivot()
    local boundsCFrame, boundsSize = model:GetBoundingBox()
    local boundsOffset = originalPivot:ToObjectSpace(boundsCFrame)

    local footY = TargetRoot.Position.Y
        - TargetHumanoid.HipHeight
        - TargetRoot.Size.Y / 2

    local targetBounds = CFrame.new(
        TargetRoot.Position.X,
        footY + boundsSize.Y / 2,
        TargetRoot.Position.Z
    ) * TargetRoot.CFrame.Rotation

    model:PivotTo(targetBounds * boundsOffset:Inverse())
    model.Parent = workspace

    return model
end

local function FadeNumberSequence(sequence, alpha)
    local keypoints = {}

    for _, keypoint in ipairs(sequence.Keypoints) do
        local value = keypoint.Value
        local newValue = value + (1 - value) * alpha
        local newEnvelope = keypoint.Envelope * (1 - alpha)

        table.insert(
            keypoints,
            NumberSequenceKeypoint.new(
                keypoint.Time,
                math.clamp(newValue, 0, 1),
                newEnvelope
            )
        )
    end

    return NumberSequence.new(keypoints)
end

local function FadeModel(model, duration)
    local numberProperties = {}
    local sequenceProperties = {}
    local colorProperties = {}
    local disableObjects = {}

    local function AddNumber(object, property, target)
        local success, original = pcall(function()
            return object[property]
        end)

        if success and type(original) == "number" then
            local canWrite = pcall(function()
                object[property] = original
            end)

            if canWrite then
                table.insert(numberProperties, {
                    Object = object,
                    Property = property,
                    Original = original,
                    Target = target
                })
            end
        end
    end

    for _, object in ipairs(model:GetDescendants()) do
        if object:IsA("BasePart") then
            AddNumber(object, "Transparency", 1)

        elseif object:IsA("Decal") or object:IsA("Texture") then
            AddNumber(object, "Transparency", 1)

        elseif object:IsA("Beam")
            or object:IsA("Trail")
            or object:IsA("ParticleEmitter") then

            table.insert(sequenceProperties, {
                Object = object,
                Original = object.Transparency
            })

            table.insert(disableObjects, object)

        elseif object:IsA("Light") then
            AddNumber(object, "Brightness", 0)
            table.insert(disableObjects, object)

        elseif object:IsA("Smoke") then
            AddNumber(object, "Opacity", 0)
            table.insert(disableObjects, object)

        elseif object:IsA("Fire") then
            AddNumber(object, "Size", 0)
            AddNumber(object, "Heat", 0)
            table.insert(disableObjects, object)

        elseif object:IsA("Sparkles") then
            table.insert(colorProperties, {
                Object = object,
                Original = object.SparkleColor
            })

            table.insert(disableObjects, object)

        elseif object:IsA("Highlight") then
            AddNumber(object, "FillTransparency", 1)
            AddNumber(object, "OutlineTransparency", 1)
            table.insert(disableObjects, object)

        elseif object:IsA("ForceField") then
            table.insert(disableObjects, object)
        end
    end

    local startTime = os.clock()

    while model.Parent do
        local elapsed = os.clock() - startTime
        local progress = math.clamp(elapsed / duration, 0, 1)

        local alpha = TweenService:GetValue(
            progress,
            Enum.EasingStyle.Sine,
            Enum.EasingDirection.InOut
        )

        for _, data in ipairs(numberProperties) do
            if data.Object.Parent then
                local value = data.Original
                    + (data.Target - data.Original) * alpha

                data.Object[data.Property] = value
            end
        end

        for _, data in ipairs(sequenceProperties) do
            if data.Object.Parent then
                data.Object.Transparency = FadeNumberSequence(
                    data.Original,
                    alpha
                )
            end
        end

        for _, data in ipairs(colorProperties) do
            if data.Object.Parent then
                data.Object.SparkleColor = data.Original:Lerp(
                    Color3.new(0, 0, 0),
                    alpha
                )
            end
        end

        if progress >= 1 then
            break
        end

        RunService.Heartbeat:Wait()
    end

    for _, object in ipairs(disableObjects) do
        if object.Parent then
            if object:IsA("ForceField") then
                object.Visible = false
            else
                object.Enabled = false
            end
        end
    end
end

local function PlayModelEffect(model)
    task.wait(ModelAnimationDelay)

    if not model.Parent then
        return
    end

    local entity = model:FindFirstChild("Entity", true)

    if entity and entity:IsA("BasePart") then
        entity.Anchored = true

        local riseTween = TweenService:Create(
            entity,
            TweenInfo.new(
                RiseDuration,
                Enum.EasingStyle.Sine,
                Enum.EasingDirection.Out
            ),
            {
                CFrame = entity.CFrame + Vector3.new(0, RiseDistance, 0)
            }
        )

        riseTween:Play()
        riseTween.Completed:Wait()

        if not model.Parent then
            return
        end

        task.wait(StayDuration)

        if not entity.Parent then
            return
        end

        local fallTween = TweenService:Create(
            entity,
            TweenInfo.new(
                FallDuration,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.InOut
            ),
            {
                CFrame = entity.CFrame + Vector3.new(0, -FallDistance, 0)
            }
        )

        fallTween:Play()
        fallTween.Completed:Wait()
    else
    end

    if not model.Parent then
        return
    end

    task.wait(AfterFallDelay)

    if not model.Parent then
        return
    end

    local pentagram = model:FindFirstChild("Pentagram", true)
    local base = pentagram and pentagram:FindFirstChild("Base")
    local lightAttach = base and base:FindFirstChild("LightAttach")
    local lightBright = lightAttach and lightAttach:FindFirstChild("LightBright")

    if lightBright and lightBright:IsA("Light") then
        lightBright.Enabled = true
        lightBright.Brightness = 40
    else
    end

    FadeModel(model, FadeDuration)

    if model.Parent then
        model:Destroy()
    end
end

local function PlayTargetAnimation()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

    local humanoid = character:WaitForChild("Humanoid")
    local root = character:WaitForChild("HumanoidRootPart")
    local head = character:WaitForChild("Head")

    local animator = humanoid:FindFirstChildOfClass("Animator")

    if not animator then
        animator = Instance.new("Animator")
        animator.Parent = humanoid
    end

    local animation = Instance.new("Animation")
    animation.AnimationId = AnimationId

    local loaded, track = pcall(function()
        return animator:LoadAnimation(animation)
    end)

    if not loaded then
        animation:Destroy()
        return
    end

    track.Priority = Enum.AnimationPriority.Action4

    local camera = workspace.CurrentCamera

    local oldCameraType = camera.CameraType
    local oldCameraSubject = camera.CameraSubject

    local oldAnchored = root.Anchored
    local oldWalkSpeed = humanoid.WalkSpeed
    local oldJumpPower = humanoid.JumpPower
    local oldJumpHeight = humanoid.JumpHeight
    local oldAutoRotate = humanoid.AutoRotate

    local mainGame = nil
    local oldStopCam = nil

    pcall(function()
        local playerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
        local mainUI = playerGui and playerGui:FindFirstChild("MainUI")
        local initiator = mainUI and mainUI:FindFirstChild("Initiator")
        local mainModule = initiator and initiator:FindFirstChild("Main_Game")

        if mainModule then
            mainGame = require(mainModule)
        end
    end)

    if type(mainGame) == "table" then
        oldStopCam = mainGame.stopcam
        mainGame.stopcam = true
    end

    humanoid.WalkSpeed = 0
    humanoid.JumpPower = 0
    humanoid.JumpHeight = 0
    humanoid.AutoRotate = false

    root.Anchored = true

    camera.CameraType = Enum.CameraType.Scriptable

    local followHead = true

    local cameraConnection = RunService.RenderStepped:Connect(function()
        if followHead and head.Parent and workspace.CurrentCamera == camera then
            camera.CFrame = camera.CFrame:Lerp(
                head.CFrame,
                0.3
            )
        end
    end)

    local success, errorMessage = pcall(function()
        root.CFrame = root.CFrame + Vector3.new(0, 1, 0)

        track:Play()
        track:AdjustSpeed(0.8)

        task.wait(0.5)
        track:AdjustSpeed(0.25)

        task.wait(3.5)
        track:AdjustSpeed(-0.2)

        task.wait(0.1)
        track:AdjustSpeed(-0.4)

        task.wait(0.2)
        track:AdjustSpeed(0.1)

        task.wait(0.2)
        track:AdjustSpeed(-0.25)

        task.wait(1.5)
        track:AdjustSpeed(-0.15)

        task.wait(2)
        track:AdjustSpeed(0)

        task.wait(2)
        track:Stop()
    end)

    followHead = false
    cameraConnection:Disconnect()

    if track.IsPlaying then
        track:Stop()
    end

    if root.Parent then
        root.Anchored = oldAnchored
    end

    if humanoid.Parent then
        humanoid.WalkSpeed = oldWalkSpeed
        humanoid.JumpPower = oldJumpPower
        humanoid.JumpHeight = oldJumpHeight
        humanoid.AutoRotate = oldAutoRotate
    end

    if workspace.CurrentCamera == camera then
        camera.CameraType = oldCameraType
        camera.CameraSubject = oldCameraSubject
    end

    if type(mainGame) == "table" then
        mainGame.stopcam = oldStopCam
    end

    animation:Destroy()

    if not success then
        return
    end

    if humanoid.Parent and humanoid.Health > 0 then
        humanoid:TakeDamage(100)
    end
end

local EffectModel = LoadEffectModel()

if not EffectModel then
    return
end

if IsTargetPlayer then
    task.spawn(function()
        PlayModelEffect(EffectModel)
    end)

    PlayTargetAnimation()
else
    PlayModelEffect(EffectModel)
end
