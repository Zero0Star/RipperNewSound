local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local stamina = 100
local maxStamina = 100
local isSprinting = false
local isExhausted = false
local canSprint = true
local sprintKeyDown = false
local isMobile = UserInputService.TouchEnabled

local staminaGUI
local staminaBar
local staminaFill
local vignette
local sprintButton
local mobileSprinting = false

local config = {
    sprintSpeed = 21,
    walkSpeed = 12,
    exhaustedSpeed = 8,
    drainSpeed = 10.0,
    regenSpeed = 1.9,
    exhaustedRegenSpeed = 2,
    sprintKey = Enum.KeyCode.Q
}

local function createUI()
    if staminaGUI and staminaGUI.Parent then
        staminaGUI:Destroy()
    end
    
    staminaGUI = Instance.new("ScreenGui")
    staminaGUI.Name = "StaminaGUI"
    staminaGUI.Parent = playerGui
    staminaGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    staminaGUI.ResetOnSpawn = false
    staminaGUI.IgnoreGuiInset = true
    
    local container = Instance.new("Frame")
    container.Name = "Container"
    container.Parent = staminaGUI
    container.AnchorPoint = Vector2.new(0, 1)
    container.BackgroundTransparency = 1
    container.Position = UDim2.new(0.85, 0, 0.95, 0)
    container.Size = UDim2.new(0.1, 0, 0.02, 0)
    container.ZIndex = 1000
    
    staminaBar = Instance.new("Frame")
    staminaBar.Name = "StaminaBar"
    staminaBar.Parent = container
    staminaBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    staminaBar.BackgroundTransparency = 0.3
    staminaBar.BorderSizePixel = 0
    staminaBar.Size = UDim2.new(1, 0, 1, 0)
    
    local barCorner = Instance.new("UICorner")
    barCorner.CornerRadius = UDim.new(0, 4)
    barCorner.Parent = staminaBar
    
    staminaFill = Instance.new("Frame")
    staminaFill.Name = "StaminaFill"
    staminaFill.Parent = staminaBar
    staminaFill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    staminaFill.BorderSizePixel = 0
    staminaFill.Size = UDim2.new(1, 0, 1, 0)
    staminaFill.ZIndex = 2
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(0, 4)
    fillCorner.Parent = staminaFill
    
    local vignetteGUI = Instance.new("ScreenGui")
    vignetteGUI.Name = "VignetteGUI"
    vignetteGUI.Parent = playerGui
    vignetteGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    vignetteGUI.IgnoreGuiInset = true
    vignetteGUI.ResetOnSpawn = false
    
    vignette = Instance.new("Frame")
    vignette.Name = "Vignette"
    vignette.Parent = vignetteGUI
    vignette.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    vignette.BackgroundTransparency = 1
    vignette.Size = UDim2.new(1, 0, 1, 0)
    vignette.ZIndex = 999
    
    if isMobile then
        if playerGui:FindFirstChild("MobileGUI") then
            playerGui.MobileGUI:Destroy()
        end
        
        local mobileGUI = Instance.new("ScreenGui")
        mobileGUI.Name = "MobileGUI"
        mobileGUI.Parent = playerGui
        mobileGUI.ResetOnSpawn = false

        sprintButton = Instance.new("ImageLabel")
        sprintButton.Name = "SprintButton"
        sprintButton.Parent = mobileGUI
        sprintButton.Size = UDim2.new(0.25, 0, 0.2, 0)
        sprintButton.Position = UDim2.new(0.8, 0, 0.25, 0)
        sprintButton.Image = "rbxassetid://111292680671790"
        sprintButton.BackgroundTransparency = 1 
        sprintButton.BorderSizePixel = 0
        sprintButton.ImageTransparency = 0
        sprintButton.ScaleType = Enum.ScaleType.Fit

        local clickArea = Instance.new("TextButton")
        clickArea.Name = "ClickArea"
        clickArea.Parent = sprintButton
        clickArea.BackgroundTransparency = 1
        clickArea.BorderSizePixel = 0
        clickArea.Size = UDim2.new(1, 0, 1, 0)
        clickArea.Text = ""
        clickArea.ZIndex = 2
    end
end

local function updateStaminaBar()
    if not staminaFill then return end
    
    local percentage = stamina / maxStamina
    staminaFill.Size = UDim2.new(percentage, 0, 1, 0)
end

local function updateVignette()
    if not vignette then return end
    
    if isSprinting and stamina > 0 then
        local transparency = 0.95 + 0.05 * (1 - stamina / maxStamina)
        TweenService:Create(vignette, TweenInfo.new(0.3), {
            BackgroundTransparency = transparency
        }):Play()
    else
        TweenService:Create(vignette, TweenInfo.new(0.5), {
            BackgroundTransparency = 1
        }):Play()
    end
end

local function startSprint(character)
    if not canSprint or isExhausted or not character then return false end
    
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then return false end
    
    isSprinting = true
    canSprint = true
    sprintKeyDown = true
    if isMobile then
        mobileSprinting = true
    end

    if isSprinting and stamina > 0 then
        humanoid.WalkSpeed = config.sprintSpeed
    end
    
    return true
end

local function stopSprint(character)
    isSprinting = false
    sprintKeyDown = false
    mobileSprinting = false
    
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            if isExhausted then
                humanoid.WalkSpeed = config.exhaustedSpeed
            else
                humanoid.WalkSpeed = config.walkSpeed
            end
        end
    end
end

local function drainStamina(dt, character)
    local shouldSprint = isSprinting and (sprintKeyDown or mobileSprinting)
    
    if not shouldSprint or isExhausted or stamina <= 0 then
        if isSprinting then
            stopSprint(character)
        end
        return
    end
    
    stamina = math.max(stamina - config.drainSpeed * dt, 0)
    updateStaminaBar()
    updateVignette()
    
    if stamina <= 0 then
        stamina = 0
        isExhausted = true
        isSprinting = false
        canSprint = false
        sprintKeyDown = false
        mobileSprinting = false

        local success, captionFunc = pcall(function()
            return require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption
        end)
        
        if success and captionFunc then
            captionFunc("我需要短暂休息...", true)
        end
        
        if character then
            local humanoid = character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = config.exhaustedSpeed
            end
        end
        
        if vignette then
            TweenService:Create(vignette, TweenInfo.new(0.3), {
                BackgroundTransparency = 0.7
            }):Play()
        end
    end
end

local function regenStamina(dt)
    if stamina >= maxStamina then return end
    
    if isExhausted then
        stamina = math.min(stamina + config.exhaustedRegenSpeed * dt, maxStamina)
        
        if stamina >= maxStamina then
            stamina = maxStamina
            isExhausted = false
            canSprint = true
            
            if vignette then
                TweenService:Create(vignette, TweenInfo.new(1), {
                    BackgroundTransparency = 1
                }):Play()
            end
        end
    elseif not isSprinting then
        stamina = math.min(stamina + config.regenSpeed * dt, maxStamina)
    end
    
    updateStaminaBar()
    updateVignette()
end

local function setupInput(character)
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        if input.KeyCode == config.sprintKey and not isExhausted then
            sprintKeyDown = true
            if not isSprinting then
                startSprint(character)
            end
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        if input.KeyCode == config.sprintKey then
            sprintKeyDown = false
            if isSprinting then
                stopSprint(character)
            end
        end
    end)

    if isMobile and sprintButton then
        local clickArea = sprintButton:FindFirstChild("ClickArea")
        if clickArea then
            clickArea.MouseButton1Down:Connect(function()
                if not isExhausted then
                    mobileSprinting = true
                    startSprint(character)
                end
            end)
            
            clickArea.MouseButton1Up:Connect(function()
                mobileSprinting = false
                stopSprint(character)
            end)
            
            clickArea.MouseLeave:Connect(function()
                if mobileSprinting then
                    mobileSprinting = false
                    stopSprint(character)
                end
            end)
        end
    end
end

local function mainLoop()
    local character = player.Character
    local lastUpdate = tick()
    
    while true do
        local currentTime = tick()
        local deltaTime = currentTime - lastUpdate
        lastUpdate = currentTime
        
        if character and character:FindFirstChild("Humanoid") then
            local shouldSprint = isSprinting and (sprintKeyDown or mobileSprinting)
            
            if shouldSprint and stamina > 0 then
                drainStamina(deltaTime, character)
            end
            
            if not isSprinting or stamina <= 0 then
                regenStamina(deltaTime)
            end

            if shouldSprint then
            else
                if isSprinting then
                    stopSprint(character)
                end
            end
        else
            character = player.Character
            if character then
                setupInput(character)
            end
        end
        
        RunService.RenderStepped:Wait()
    end
end

local function setupVitaminInteraction()
    player.CharacterAdded:Connect(function(character)
        character.ChildAdded:Connect(function(child)
            if child.Name == "Vitamins" then
                local vitaminTool = child
                
                if vitaminTool:FindFirstChild("Handle") then
                    local handle = vitaminTool.Handle
                    
                    local function onActivated()
                        if isExhausted then return end
                        
                        stamina = maxStamina
                        isExhausted = false
                        canSprint = true
                        
                        updateStaminaBar()
                        updateVignette()
                        
                        local sound = Instance.new("Sound")
                        sound.SoundId = "rbxassetid://9117820422"
                        sound.Volume = 0.5
                        sound.Parent = handle
                        sound:Play()
                        game:GetService("Debris"):AddItem(sound, 2)
                    end
                    
                    local activated = vitaminTool.Activated:Connect(onActivated)
                    
                    vitaminTool.Unequipped:Connect(function()
                        if activated then
                            activated:Disconnect()
                        end
                    end)
                end
            end
        end)
    end)
end

local function initialize()
    createUI()
    updateStaminaBar()
    
    local character = player.Character
    if character then
        setupInput(character)
    end
    
    player.CharacterAdded:Connect(function(newCharacter)
        stamina = maxStamina
        isExhausted = false
        isSprinting = false
        canSprint = true
        sprintKeyDown = false
        mobileSprinting = false
        
        updateStaminaBar()
        updateVignette()
        
        if vignette then
            TweenService:Create(vignette, TweenInfo.new(0.5), {
                BackgroundTransparency = 1
            }):Play()
        end
        
        character = newCharacter
        setupInput(character)
    end)
    
    setupVitaminInteraction()
    
    task.spawn(mainLoop)
end

task.wait(1)
initialize()

return {
    GetStamina = function() return stamina end,
    GetMaxStamina = function() return maxStamina end,
    IsSprinting = function() return isSprinting end,
    IsExhausted = function() return isExhausted end,
    SetMaxStamina = function(value) 
        maxStamina = math.max(1, value)
        stamina = math.min(stamina, maxStamina)
        updateStaminaBar()
    end,
    AddStamina = function(amount)
        stamina = math.min(stamina + amount, maxStamina)
        if stamina > 0 then
            isExhausted = false
            canSprint = true
        end
        updateStaminaBar()
    end
}