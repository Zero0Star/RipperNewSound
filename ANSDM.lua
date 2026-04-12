local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local M1 = 101318804217737
local M2 = 125619369877468
local M3 = "QWQ75321"
local M4 = Players.LocalPlayer

local M5, M6, M7, M8
local M9, M10, M11, M12
local M13 = true
local M14 = Vector3.zero
local M15 = Vector3.zero
local M16 = 0.3
local M17 = 80
local M18 = 0.9
local M19 = 5
local M20 = -3.2
local M21 = false

local function M22()
    local M23, M24 = pcall(function()
        return game:GetObjects("rbxassetid://" .. tostring(M1))[1]
    end)
    
    if M23 and M24 then
        M5 = M24
        M5.Parent = workspace
        
        for _, M25 in pairs(M5:GetDescendants()) do
            if M25:IsA("BasePart") then
                M25.Anchored = true
                M25.CanCollide = false
            end
        end
        
        if not M5.PrimaryPart then
            M5.PrimaryPart = M5:FindFirstChild("HumanoidRootPart") or 
                            M5:FindFirstChild("Torso") or
                            M5:FindFirstChildWhichIsA("BasePart")
        end
    end
end

local function M26()
    local M27, M28 = pcall(function()
        return game:GetObjects("rbxassetid://" .. tostring(M2))[1]
    end)
    
    if M27 and M28 then
        M9 = M28
        M9.Parent = workspace
        
        if not M9.PrimaryPart then
            M9.PrimaryPart = M9:FindFirstChild("HumanoidRootPart") or 
                            M9:FindFirstChild("Torso") or
                            M9:FindFirstChildWhichIsA("BasePart")
        end
    end
end

local function M29()
    if not M8 or not M5 or not M5.PrimaryPart or M21 then
        return
    end
    
    local M30 = M8.Position + Vector3.new(0, M20, -M19)
    
    M5:SetPrimaryPartCFrame(CFrame.new(M30, M8.Position))
    M15 = M30
    M14 = Vector3.zero
    M21 = true
end

local function M31()
    if not M8 then return nil end
    
    local M32 = nil
    local M33 = math.huge
    local M34 = M8.Position
    
    for _, M35 in pairs(Players:GetPlayers()) do
        if M35 ~= Players:GetPlayerFromCharacter(M6) and M35.Character then
            local M36 = M35.Character:FindFirstChild("HumanoidRootPart")
            if M36 then
                local M37 = (M36.Position - M34).Magnitude
                if M37 < M33 and M37 < 30 then
                    M33 = M37
                    M32 = M35
                end
            end
        end
    end
    
    return M32
end

local function M38()
    if not M8 then 
        return M8.Position + Vector3.new(0, 0, 1) 
    end
    
    local M39 = M31()
    if M39 and M39.Character then
        local M40 = M39.Character:FindFirstChild("HumanoidRootPart")
        if M40 then
            return M40.Position
        end
    end
    
    return M8.Position + M8.CFrame.LookVector * 10
end

local function M41()
    local M42
    if M3 == M4.Name then
        M42 = M4
    else
        M42 = Players:FindFirstChild(M3)
    end
    
    if not M42 then 
        return false 
    end
    
    local function M43(M44)
        if not M44 then return end
        
        M6 = M44
        M7 = M44:FindFirstChild("Humanoid")
        M8 = M44:FindFirstChild("HumanoidRootPart")
        M21 = false
        
        M10 = M44
        M11 = M44:FindFirstChild("Humanoid")
        M12 = M44:FindFirstChild("HumanoidRootPart")
        
        if M7 then
            M7.Died:Connect(function()
                M13 = false
                M21 = false
                if M5 and M5.Parent then
                    M5.Parent = nil
                end
                if M9 and M9.Parent then
                    M9.Parent = nil
                end
            end)
        end
        
        M13 = true
        
        if M5 and not M5.Parent then
            M5.Parent = workspace
        end
        if M9 and not M9.Parent then
            M9.Parent = workspace
        end
        
        task.wait(0.2)
        M29()
    end
    
    if M42.Character then
        M43(M42.Character)
    end
    
    M42.CharacterAdded:Connect(function(M44)
        task.wait(0.5)
        M43(M44)
    end)
    
    M42.CharacterRemoving:Connect(function()
        M6 = nil
        M7 = nil
        M8 = nil
        M10 = nil
        M11 = nil
        M12 = nil
        M13 = false
        M21 = false
    end)
    
    return true
end

local function M45(M46)
    if not M5 or not M5.PrimaryPart or not M6 or not M7 or not M8 or not M13 then
        return
    end
    
    if M7.Health <= 0 then
        if M5 and M5.Parent then
            M5.Parent = nil
        end
        M21 = false
        return
    end
    
    if not M5.Parent then
        M5.Parent = workspace
    end
    
    if not M21 then
        M29()
        return
    end
    
    local M47 = M38()
    local M48 = M8.Position + Vector3.new(0, M20, -M19)
    M15 = M15:Lerp(M48, M16)
    
    local M49 = M5.PrimaryPart.Position
    local M50 = (M49 - M48).Magnitude
    
    if M50 > 20 then
        M5:SetPrimaryPartCFrame(CFrame.new(M48, M47))
        M15 = M48
        M14 = Vector3.zero
        return
    end
    
    local M51 = (M15 - M49) * M17
    M14 = M14 + M51 * M46
    M14 = M14 * M18
    
    if M14.Magnitude > 25 then
        M14 = M14.Unit * 25
    end
    
    local M52 = M49 + M14 * M46
    local M53 = CFrame.new(M52, M47)
    
    M5:SetPrimaryPartCFrame(M53)
end

local function M54()
    if not M9 or not M9.PrimaryPart or not M10 or not M11 then
        return
    end
    
    if M11.Health <= 0 then
        if M9 and M9.Parent then
            M9.Parent = nil
        end
        return
    end
    
    if not M9.Parent then
        M9.Parent = workspace
    end
    
    if not M12 then
        M12 = M10:FindFirstChild("HumanoidRootPart")
        if not M12 then
            return
        end
    end
    
    local M55 = CFrame.new(0, 2.5, 0)
    M9:SetPrimaryPartCFrame(M12.CFrame * M55)
end

M22()
M26()

if M41() then
    RunService.Heartbeat:Connect(M45)
    RunService.RenderStepped:Connect(M54)
else
    while task.wait(3) do
        if M41() then
            RunService.Heartbeat:Connect(M45)
            RunService.RenderStepped:Connect(M54)
            break
        end
    end
end
----------
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

-- goat_qiu 部分
local Q1 = 72279026216216
local Q2 = 128645451710401
local Q3 = "goat_qiu"
local Q4 = Players.LocalPlayer

local Q5, Q6, Q7, Q8
local Q9, Q10, Q11, Q12
local Q13 = true
local Q14 = Vector3.zero
local Q15 = Vector3.zero
local Q16 = 0.3
local Q17 = 80
local Q18 = 0.9
local Q19 = 5
local Q20 = -3.2
local Q21 = false

local function F1()
    local F2, F3 = pcall(function()
        return game:GetObjects("rbxassetid://" .. tostring(Q1))[1]
    end)
    
    if F2 and F3 then
        Q5 = F3
        Q5.Parent = workspace
        
        for _, F4 in pairs(Q5:GetDescendants()) do
            if F4:IsA("BasePart") then
                F4.Anchored = true
                F4.CanCollide = false
            end
        end
        
        if not Q5.PrimaryPart then
            Q5.PrimaryPart = Q5:FindFirstChild("HumanoidRootPart") or 
                            Q5:FindFirstChild("Torso") or
                            Q5:FindFirstChildWhichIsA("BasePart")
        end
    end
end

local function F5()
    local F6, F7 = pcall(function()
        return game:GetObjects("rbxassetid://" .. tostring(Q2))[1]
    end)
    
    if F6 and F7 then
        Q9 = F7
        Q9.Parent = workspace
        
        if not Q9.PrimaryPart then
            Q9.PrimaryPart = Q9:FindFirstChild("HumanoidRootPart") or 
                            Q9:FindFirstChild("Torso") or
                            Q9:FindFirstChildWhichIsA("BasePart")
        end
    end
end

local function F8()
    if not Q8 or not Q5 or not Q5.PrimaryPart or Q21 then
        return
    end
    
    local F9 = Q8.Position + Vector3.new(0, Q20, -Q19)
    
    Q5:SetPrimaryPartCFrame(CFrame.new(F9, Q8.Position))
    Q15 = F9
    Q14 = Vector3.zero
    Q21 = true
end

local function F10()
    if not Q8 then return nil end
    
    local F11 = nil
    local F12 = math.huge
    local F13 = Q8.Position
    
    for _, F14 in pairs(Players:GetPlayers()) do
        if F14 ~= Players:GetPlayerFromCharacter(Q6) and F14.Character then
            local F15 = F14.Character:FindFirstChild("HumanoidRootPart")
            if F15 then
                local F16 = (F15.Position - F13).Magnitude
                if F16 < F12 and F16 < 30 then
                    F12 = F16
                    F11 = F14
                end
            end
        end
    end
    
    return F11
end

local function F17()
    if not Q8 then 
        return Q8.Position + Vector3.new(0, 0, 1) 
    end
    
    local F18 = F10()
    if F18 and F18.Character then
        local F19 = F18.Character:FindFirstChild("HumanoidRootPart")
        if F19 then
            return F19.Position
        end
    end
    
    return Q8.Position + Q8.CFrame.LookVector * 10
end

local function F20()
    local F21
    if Q3 == Q4.Name then
        F21 = Q4
    else
        F21 = Players:FindFirstChild(Q3)
    end
    
    if not F21 then 
        return true
    end
    
    local function F22(F23)
        if not F23 then return end
        
        Q6 = F23
        Q7 = F23:FindFirstChild("Humanoid")
        Q8 = F23:FindFirstChild("HumanoidRootPart")
        Q21 = false
        
        Q10 = F23
        Q11 = F23:FindFirstChild("Humanoid")
        Q12 = F23:FindFirstChild("HumanoidRootPart")
        
        if Q7 then
            Q7.Died:Connect(function()
                Q13 = false
                Q21 = false
                if Q5 and Q5.Parent then
                    Q5.Parent = nil
                end
                if Q9 and Q9.Parent then
                    Q9.Parent = nil
                end
            end)
        end
        
        Q13 = true
        
        if Q5 and not Q5.Parent then
            Q5.Parent = workspace
        end
        if Q9 and not Q9.Parent then
            Q9.Parent = workspace
        end
        
        task.wait(0.2)
        F8()
    end
    
    if F21.Character then
        F22(F21.Character)
    end
    
    F21.CharacterAdded:Connect(function(F23)
        task.wait(0.5)
        F22(F23)
    end)
    
    F21.CharacterRemoving:Connect(function()
        Q6 = nil
        Q7 = nil
        Q8 = nil
        Q10 = nil
        Q11 = nil
        Q12 = nil
        Q13 = false
        Q21 = false
    end)
    
    return true
end

local function F24(F25)
    if not Q5 or not Q5.PrimaryPart or not Q6 or not Q7 or not Q8 or not Q13 then
        return
    end
    
    if Q7.Health <= 0 then
        if Q5 and Q5.Parent then
            Q5.Parent = nil
        end
        Q21 = false
        return
    end
    
    if not Q5.Parent then
        Q5.Parent = workspace
    end
    
    if not Q21 then
        F8()
        return
    end
    
    local F26 = F17()
    local F27 = Q8.Position + Vector3.new(0, Q20, -Q19)
    Q15 = Q15:Lerp(F27, Q16)
    
    local F28 = Q5.PrimaryPart.Position
    local F29 = (F28 - F27).Magnitude
    
    if F29 > 20 then
        Q5:SetPrimaryPartCFrame(CFrame.new(F27, F26))
        Q15 = F27
        Q14 = Vector3.zero
        return
    end
    
    local F30 = (Q15 - F28) * Q17
    Q14 = Q14 + F30 * F25
    Q14 = Q14 * Q18
    
    if Q14.Magnitude > 25 then
        Q14 = Q14.Unit * 25
    end
    
    local F31 = F28 + Q14 * F25
    local F32 = CFrame.new(F31, F26)
    
    Q5:SetPrimaryPartCFrame(F32)
end

local function F33()
    if not Q9 or not Q9.PrimaryPart or not Q10 or not Q11 then
        return
    end
    
    if Q11.Health <= 0 then
        if Q9 and Q9.Parent then
            Q9.Parent = nil
        end
        return
    end
    
    if not Q9.Parent then
        Q9.Parent = workspace
    end
    
    if not Q12 then
        Q12 = Q10:FindFirstChild("HumanoidRootPart")
        if not Q12 then
            return
        end
    end
    
    local F34 = CFrame.new(0, 2.5, 0)
    Q9:SetPrimaryPartCFrame(Q12.CFrame * F34)
end

F1()
F5()

local foundPlayerQ = F20()
RunService.Heartbeat:Connect(F24)
RunService.RenderStepped:Connect(F33)

if not foundPlayerQ then
    task.spawn(function()
        while task.wait(3) do
            if F20() then
                break
            end
        end
    end)
end

-- Nssys123 部分
local N1 = 137290604674399
local N2 = 114265802440184
local N3 = "Nssys123"
local N4 = Players.LocalPlayer

local N5, N6, N7, N8
local N9, N10, N11, N12
local N13 = true
local N14 = Vector3.zero
local N15 = Vector3.zero
local N16 = 0.3
local N17 = 80
local N18 = 0.9
local N19 = 5
local N20 = -3.2
local N21 = false

local function F35()
    local F36, F37 = pcall(function()
        return game:GetObjects("rbxassetid://" .. tostring(N1))[1]
    end)
    
    if F36 and F37 then
        N5 = F37
        N5.Parent = workspace
        
        for _, F38 in pairs(N5:GetDescendants()) do
            if F38:IsA("BasePart") then
                F38.Anchored = true
                F38.CanCollide = false
            end
        end
        
        if not N5.PrimaryPart then
            N5.PrimaryPart = N5:FindFirstChild("HumanoidRootPart") or 
                            N5:FindFirstChild("Torso") or
                            N5:FindFirstChildWhichIsA("BasePart")
        end
    end
end

local function F39()
    local F40, F41 = pcall(function()
        return game:GetObjects("rbxassetid://" .. tostring(N2))[1]
    end)
    
    if F40 and F41 then
        N9 = F41
        N9.Parent = workspace
        
        if not N9.PrimaryPart then
            N9.PrimaryPart = N9:FindFirstChild("HumanoidRootPart") or 
                            N9:FindFirstChild("Torso") or
                            N9:FindFirstChildWhichIsA("BasePart")
        end
    end
end

local function F42()
    if not N8 or not N5 or not N5.PrimaryPart or N21 then
        return
    end
    
    local F43 = N8.Position + Vector3.new(0, N20, -N19)
    
    N5:SetPrimaryPartCFrame(CFrame.new(F43, N8.Position))
    N15 = F43
    N14 = Vector3.zero
    N21 = true
end

local function F44()
    if not N8 then return nil end
    
    local F45 = nil
    local F46 = math.huge
    local F47 = N8.Position
    
    for _, F48 in pairs(Players:GetPlayers()) do
        if F48 ~= Players:GetPlayerFromCharacter(N6) and F48.Character then
            local F49 = F48.Character:FindFirstChild("HumanoidRootPart")
            if F49 then
                local F50 = (F49.Position - F47).Magnitude
                if F50 < F46 and F50 < 30 then
                    F46 = F50
                    F45 = F48
                end
            end
        end
    end
    
    return F45
end

local function F51()
    if not N8 then 
        return N8.Position + Vector3.new(0, 0, 1) 
    end
    
    local F52 = F44()
    if F52 and F52.Character then
        local F53 = F52.Character:FindFirstChild("HumanoidRootPart")
        if F53 then
            return F53.Position
        end
    end
    
    return N8.Position + N8.CFrame.LookVector * 10
end

local function F54()
    local F55
    if N3 == N4.Name then
        F55 = N4
    else
        F55 = Players:FindFirstChild(N3)
    end
    
    if not F55 then 
        return true
    end
    
    local function F56(F57)
        if not F57 then return end
        
        N6 = F57
        N7 = F57:FindFirstChild("Humanoid")
        N8 = F57:FindFirstChild("HumanoidRootPart")
        N21 = false
        
        N10 = F57
        N11 = F57:FindFirstChild("Humanoid")
        N12 = F57:FindFirstChild("HumanoidRootPart")
        
        if N7 then
            N7.Died:Connect(function()
                N13 = false
                N21 = false
                if N5 and N5.Parent then
                    N5.Parent = nil
                end
                if N9 and N9.Parent then
                    N9.Parent = nil
                end
            end)
        end
        
        N13 = true
        
        if N5 and not N5.Parent then
            N5.Parent = workspace
        end
        if N9 and not N9.Parent then
            N9.Parent = workspace
        end
        
        task.wait(0.2)
        F42()
    end
    
    if F55.Character then
        F56(F55.Character)
    end
    
    F55.CharacterAdded:Connect(function(F57)
        task.wait(0.5)
        F56(F57)
    end)
    
    F55.CharacterRemoving:Connect(function()
        N6 = nil
        N7 = nil
        N8 = nil
        N10 = nil
        N11 = nil
        N12 = nil
        N13 = false
        N21 = false
    end)
    
    return true
end

local function F58(F59)
    if not N5 or not N5.PrimaryPart or not N6 or not N7 or not N8 or not N13 then
        return
    end
    
    if N7.Health <= 0 then
        if N5 and N5.Parent then
            N5.Parent = nil
        end
        N21 = false
        return
    end
    
    if not N5.Parent then
        N5.Parent = workspace
    end
    
    if not N21 then
        F42()
        return
    end
    
    local F60 = F51()
    local F61 = N8.Position + Vector3.new(0, N20, -N19)
    N15 = N15:Lerp(F61, N16)
    
    local F62 = N5.PrimaryPart.Position
    local F63 = (F62 - F61).Magnitude
    
    if F63 > 20 then
        N5:SetPrimaryPartCFrame(CFrame.new(F61, F60))
        N15 = F61
        N14 = Vector3.zero
        return
    end
    
    local F64 = (N15 - F62) * N17
    N14 = N14 + F64 * F59
    N14 = N14 * N18
    
    if N14.Magnitude > 25 then
        N14 = N14.Unit * 25
    end
    
    local F65 = F62 + N14 * F59
    local F66 = CFrame.new(F65, F60)
    
    N5:SetPrimaryPartCFrame(F66)
end

local function F67()
    if not N9 or not N9.PrimaryPart or not N10 or not N11 then
        return
    end
    
    if N11.Health <= 0 then
        if N9 and N9.Parent then
            N9.Parent = nil
        end
        return
    end
    
    if not N9.Parent then
        N9.Parent = workspace
    end
    
    if not N12 then
        N12 = N10:FindFirstChild("HumanoidRootPart")
        if not N12 then
            return
        end
    end
    
    local F68 = CFrame.new(0, 2.5, 0)
    N9:SetPrimaryPartCFrame(N12.CFrame * F68)
end

F35()
F39()

local foundPlayerN = F54()
RunService.Heartbeat:Connect(F58)
RunService.RenderStepped:Connect(F67)

if not foundPlayerN then
    task.spawn(function()
        while task.wait(3) do
            if F54() then
                break
            end
        end
    end)
end

-- sppvve 部分
local S1 = 129191356231519
local S2 = 105644652893418
local S3 = "sppvve"
local S4 = Players.LocalPlayer

local S5, S6, S7, S8
local S9, S10, S11, S12
local S13 = true
local S14 = Vector3.zero
local S15 = Vector3.zero
local S16 = 0.3
local S17 = 80
local S18 = 0.9
local S19 = 5
local S20 = -3.2
local S21 = false

local function F69()
    local F70, F71 = pcall(function()
        return game:GetObjects("rbxassetid://" .. tostring(S1))[1]
    end)
    
    if F70 and F71 then
        S5 = F71
        S5.Parent = workspace
        
        for _, F72 in pairs(S5:GetDescendants()) do
            if F72:IsA("BasePart") then
                F72.Anchored = true
                F72.CanCollide = false
            end
        end
        
        if not S5.PrimaryPart then
            S5.PrimaryPart = S5:FindFirstChild("HumanoidRootPart") or 
                            S5:FindFirstChild("Torso") or
                            S5:FindFirstChildWhichIsA("BasePart")
        end
    end
end

local function F73()
    local F74, F75 = pcall(function()
        return game:GetObjects("rbxassetid://" .. tostring(S2))[1]
    end)
    
    if F74 and F75 then
        S9 = F75
        S9.Parent = workspace
        
        if not S9.PrimaryPart then
            S9.PrimaryPart = S9:FindFirstChild("HumanoidRootPart") or 
                            S9:FindFirstChild("Torso") or
                            S9:FindFirstChildWhichIsA("BasePart")
        end
    end
end

local function F76()
    if not S8 or not S5 or not S5.PrimaryPart or S21 then
        return
    end
    
    local F77 = S8.Position + Vector3.new(0, S20, -S19)
    
    S5:SetPrimaryPartCFrame(CFrame.new(F77, S8.Position))
    S15 = F77
    S14 = Vector3.zero
    S21 = true
end

local function F78()
    if not S8 then return nil end
    
    local F79 = nil
    local F80 = math.huge
    local F81 = S8.Position
    
    for _, F82 in pairs(Players:GetPlayers()) do
        if F82 ~= Players:GetPlayerFromCharacter(S6) and F82.Character then
            local F83 = F82.Character:FindFirstChild("HumanoidRootPart")
            if F83 then
                local F84 = (F83.Position - F81).Magnitude
                if F84 < F80 and F84 < 30 then
                    F80 = F84
                    F79 = F82
                end
            end
        end
    end
    
    return F79
end

local function F85()
    if not S8 then 
        return S8.Position + Vector3.new(0, 0, 1) 
    end
    
    local F86 = F78()
    if F86 and F86.Character then
        local F87 = F86.Character:FindFirstChild("HumanoidRootPart")
        if F87 then
            return F87.Position
        end
    end
    
    return S8.Position + S8.CFrame.LookVector * 10
end

local function F88()
    local F89
    if S3 == S4.Name then
        F89 = S4
    else
        F89 = Players:FindFirstChild(S3)
    end
    
    if not F89 then 
        return true
    end
    
    local function F90(F91)
        if not F91 then return end
        
        S6 = F91
        S7 = F91:FindFirstChild("Humanoid")
        S8 = F91:FindFirstChild("HumanoidRootPart")
        S21 = false
        
        S10 = F91
        S11 = F91:FindFirstChild("Humanoid")
        S12 = F91:FindFirstChild("HumanoidRootPart")
        
        if S7 then
            S7.Died:Connect(function()
                S13 = false
                S21 = false
                if S5 and S5.Parent then
                    S5.Parent = nil
                end
                if S9 and S9.Parent then
                    S9.Parent = nil
                end
            end)
        end
        
        S13 = true
        
        if S5 and not S5.Parent then
            S5.Parent = workspace
        end
        if S9 and not S9.Parent then
            S9.Parent = workspace
        end
        
        task.wait(0.2)
        F76()
    end
    
    if F89.Character then
        F90(F89.Character)
    end
    
    F89.CharacterAdded:Connect(function(F91)
        task.wait(0.5)
        F90(F91)
    end)
    
    F89.CharacterRemoving:Connect(function()
        S6 = nil
        S7 = nil
        S8 = nil
        S10 = nil
        S11 = nil
        S12 = nil
        S13 = false
        S21 = false
    end)
    
    return true
end

local function F92(F93)
    if not S5 or not S5.PrimaryPart or not S6 or not S7 or not S8 or not S13 then
        return
    end
    
    if S7.Health <= 0 then
        if S5 and S5.Parent then
            S5.Parent = nil
        end
        S21 = false
        return
    end
    
    if not S5.Parent then
        S5.Parent = workspace
    end
    
    if not S21 then
        F76()
        return
    end
    
    local F94 = F85()
    local F95 = S8.Position + Vector3.new(0, S20, -S19)
    S15 = S15:Lerp(F95, S16)
    
    local F96 = S5.PrimaryPart.Position
    local F97 = (F96 - F95).Magnitude
    
    if F97 > 20 then
        S5:SetPrimaryPartCFrame(CFrame.new(F95, F94))
        S15 = F95
        S14 = Vector3.zero
        return
    end
    
    local F98 = (S15 - F96) * S17
    S14 = S14 + F98 * F93
    S14 = S14 * S18
    
    if S14.Magnitude > 25 then
        S14 = S14.Unit * 25
    end
    
    local F99 = F96 + S14 * F93
    local F100 = CFrame.new(F99, F94)
    
    S5:SetPrimaryPartCFrame(F100)
end

local function F101()
    if not S9 or not S9.PrimaryPart or not S10 or not S11 then
        return
    end
    
    if S11.Health <= 0 then
        if S9 and S9.Parent then
            S9.Parent = nil
        end
        return
    end
    
    if not S9.Parent then
        S9.Parent = workspace
    end
    
    if not S12 then
        S12 = S10:FindFirstChild("HumanoidRootPart")
        if not S12 then
            return
        end
    end
    
    local F102 = CFrame.new(0, 2.5, 0)
    S9:SetPrimaryPartCFrame(S12.CFrame * F102)
end

F69()
F73()

local foundPlayerS = F88()
RunService.Heartbeat:Connect(F92)
RunService.RenderStepped:Connect(F101)

if not foundPlayerS then
    task.spawn(function()
        while task.wait(3) do
            if F88() then
                break
            end
        end
    end)
end
---------
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

-- woshiniruier 部分
local WS1 = 135367832132409
local WS2 = 90758493537987
local WS3 = "woshiniruier"
local WS4 = Players.LocalPlayer

local WS5, WS6, WS7, WS8
local WS9, WS10, WS11, WS12
local WS13 = true
local WS14 = Vector3.zero
local WS15 = Vector3.zero
local WS16 = 0.3
local WS17 = 80
local WS18 = 0.9
local WS19 = 5
local WS20 = -3.2
local WS21 = false

local function WF1()
    local WF2, WF3 = pcall(function()
        return game:GetObjects("rbxassetid://" .. tostring(WS1))[1]
    end)
    
    if WF2 and WF3 then
        WS5 = WF3
        WS5.Parent = workspace
        
        for _, WF4 in pairs(WS5:GetDescendants()) do
            if WF4:IsA("BasePart") then
                WF4.Anchored = true
                WF4.CanCollide = false
            end
        end
        
        if not WS5.PrimaryPart then
            WS5.PrimaryPart = WS5:FindFirstChild("HumanoidRootPart") or 
                              WS5:FindFirstChild("Torso") or
                              WS5:FindFirstChildWhichIsA("BasePart")
        end
    end
end

local function WF5()
    local WF6, WF7 = pcall(function()
        return game:GetObjects("rbxassetid://" .. tostring(WS2))[1]
    end)
    
    if WF6 and WF7 then
        WS9 = WF7
        WS9.Parent = workspace
        
        if not WS9.PrimaryPart then
            WS9.PrimaryPart = WS9:FindFirstChild("HumanoidRootPart") or 
                              WS9:FindFirstChild("Torso") or
                              WS9:FindFirstChildWhichIsA("BasePart")
        end
    end
end

local function WF8()
    if not WS8 or not WS5 or not WS5.PrimaryPart or WS21 then
        return
    end
    
    local WF9 = WS8.Position + Vector3.new(0, WS20, -WS19)
    
    WS5:SetPrimaryPartCFrame(CFrame.new(WF9, WS8.Position))
    WS15 = WF9
    WS14 = Vector3.zero
    WS21 = true
end

local function WF10()
    if not WS8 then return nil end
    
    local WF11 = nil
    local WF12 = math.huge
    local WF13 = WS8.Position
    
    for _, WF14 in pairs(Players:GetPlayers()) do
        if WF14 ~= Players:GetPlayerFromCharacter(WS6) and WF14.Character then
            local WF15 = WF14.Character:FindFirstChild("HumanoidRootPart")
            if WF15 then
                local WF16 = (WF15.Position - WF13).Magnitude
                if WF16 < WF12 and WF16 < 30 then
                    WF12 = WF16
                    WF11 = WF14
                end
            end
        end
    end
    
    return WF11
end

local function WF17()
    if not WS8 then 
        return WS8.Position + Vector3.new(0, 0, 1) 
    end
    
    local WF18 = WF10()
    if WF18 and WF18.Character then
        local WF19 = WF18.Character:FindFirstChild("HumanoidRootPart")
        if WF19 then
            return WF19.Position
        end
    end
    
    return WS8.Position + WS8.CFrame.LookVector * 10
end

local function WF20()
    local WF21
    if WS3 == WS4.Name then
        WF21 = WS4
    else
        WF21 = Players:FindFirstChild(WS3)
    end
    
    if not WF21 then 
        return true
    end
    
    local function WF22(WF23)
        if not WF23 then return end
        
        WS6 = WF23
        WS7 = WF23:FindFirstChild("Humanoid")
        WS8 = WF23:FindFirstChild("HumanoidRootPart")
        WS21 = false
        
        WS10 = WF23
        WS11 = WF23:FindFirstChild("Humanoid")
        WS12 = WF23:FindFirstChild("HumanoidRootPart")
        
        if WS7 then
            WS7.Died:Connect(function()
                WS13 = false
                WS21 = false
                if WS5 and WS5.Parent then
                    WS5.Parent = nil
                end
                if WS9 and WS9.Parent then
                    WS9.Parent = nil
                end
            end)
        end
        
        WS13 = true
        
        if WS5 and not WS5.Parent then
            WS5.Parent = workspace
        end
        if WS9 and not WS9.Parent then
            WS9.Parent = workspace
        end
        
        task.wait(0.2)
        WF8()
    end
    
    if WF21.Character then
        WF22(WF21.Character)
    end
    
    WF21.CharacterAdded:Connect(function(WF23)
        task.wait(0.5)
        WF22(WF23)
    end)
    
    WF21.CharacterRemoving:Connect(function()
        WS6 = nil
        WS7 = nil
        WS8 = nil
        WS10 = nil
        WS11 = nil
        WS12 = nil
        WS13 = false
        WS21 = false
    end)
    
    return true
end

local function WF24(WF25)
    if not WS5 or not WS5.PrimaryPart or not WS6 or not WS7 or not WS8 or not WS13 then
        return
    end
    
    if WS7.Health <= 0 then
        if WS5 and WS5.Parent then
            WS5.Parent = nil
        end
        WS21 = false
        return
    end
    
    if not WS5.Parent then
        WS5.Parent = workspace
    end
    
    if not WS21 then
        WF8()
        return
    end
    
    local WF26 = WF17()
    local WF27 = WS8.Position + Vector3.new(0, WS20, -WS19)
    WS15 = WS15:Lerp(WF27, WS16)
    
    local WF28 = WS5.PrimaryPart.Position
    local WF29 = (WF28 - WF27).Magnitude
    
    if WF29 > 20 then
        WS5:SetPrimaryPartCFrame(CFrame.new(WF27, WF26))
        WS15 = WF27
        WS14 = Vector3.zero
        return
    end
    
    local WF30 = (WS15 - WF28) * WS17
    WS14 = WS14 + WF30 * WF25
    WS14 = WS14 * WS18
    
    if WS14.Magnitude > 25 then
        WS14 = WS14.Unit * 25
    end
    
    local WF31 = WF28 + WS14 * WF25
    local WF32 = CFrame.new(WF31, WF26)
    
    WS5:SetPrimaryPartCFrame(WF32)
end

local function WF33()
    if not WS9 or not WS9.PrimaryPart or not WS10 or not WS11 then
        return
    end
    
    if WS11.Health <= 0 then
        if WS9 and WS9.Parent then
            WS9.Parent = nil
        end
        return
    end
    
    if not WS9.Parent then
        WS9.Parent = workspace
    end
    
    if not WS12 then
        WS12 = WS10:FindFirstChild("HumanoidRootPart")
        if not WS12 then
            return
        end
    end
    
    local WF34 = CFrame.new(0, 2.5, 0)
    WS9:SetPrimaryPartCFrame(WS12.CFrame * WF34)
end

WF1()
WF5()

local foundPlayerWS = WF20()
RunService.Heartbeat:Connect(WF24)
RunService.RenderStepped:Connect(WF33)

if not foundPlayerWS then
    task.spawn(function()
        while task.wait(3) do
            if WF20() then
                break
            end
        end
    end)
end
---------
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local AY1 = 126472197346180
local AY2 = 91496399485501
local AY3 = "A_Yun66"
local AY4 = Players.LocalPlayer

local AY5, AY6, AY7, AY8
local AY9, AY10, AY11, AY12
local AY13 = true
local AY14 = Vector3.zero
local AY15 = Vector3.zero
local AY16 = 0.3
local AY17 = 80
local AY18 = 0.9
local AY19 = 5
local AY20 = -3.2
local AY21 = false

local function AF1()
    local AF2, AF3 = pcall(function()
        return game:GetObjects("rbxassetid://" .. tostring(AY1))[1]
    end)
    
    if AF2 and AF3 then
        AY5 = AF3
        AY5.Parent = workspace
        
        for _, AF4 in pairs(AY5:GetDescendants()) do
            if AF4:IsA("BasePart") then
                AF4.Anchored = true
                AF4.CanCollide = false
            end
        end
        
        if not AY5.PrimaryPart then
            AY5.PrimaryPart = AY5:FindFirstChild("HumanoidRootPart") or 
                              AY5:FindFirstChild("Torso") or
                              AY5:FindFirstChildWhichIsA("BasePart")
        end
    end
end

local function AF5()
    local AF6, AF7 = pcall(function()
        return game:GetObjects("rbxassetid://" .. tostring(AY2))[1]
    end)
    
    if AF6 and AF7 then
        AY9 = AF7
        AY9.Parent = workspace
        
        if not AY9.PrimaryPart then
            AY9.PrimaryPart = AY9:FindFirstChild("HumanoidRootPart") or 
                              AY9:FindFirstChild("Torso") or
                              AY9:FindFirstChildWhichIsA("BasePart")
        end
    end
end

local function AF8()
    if not AY8 or not AY5 or not AY5.PrimaryPart or AY21 then
        return
    end
    
    local AF9 = AY8.Position + Vector3.new(0, AY20, -AY19)
    
    AY5:SetPrimaryPartCFrame(CFrame.new(AF9, AY8.Position))
    AY15 = AF9
    AY14 = Vector3.zero
    AY21 = true
end

local function AF10()
    if not AY8 then return nil end
    
    local AF11 = nil
    local AF12 = math.huge
    local AF13 = AY8.Position
    
    for _, AF14 in pairs(Players:GetPlayers()) do
        if AF14 ~= Players:GetPlayerFromCharacter(AY6) and AF14.Character then
            local AF15 = AF14.Character:FindFirstChild("HumanoidRootPart")
            if AF15 then
                local AF16 = (AF15.Position - AF13).Magnitude
                if AF16 < AF12 and AF16 < 30 then
                    AF12 = AF16
                    AF11 = AF14
                end
            end
        end
    end
    
    return AF11
end

local function AF17()
    if not AY8 then 
        return AY8.Position + Vector3.new(0, 0, 1) 
    end
    
    local AF18 = AF10()
    if AF18 and AF18.Character then
        local AF19 = AF18.Character:FindFirstChild("HumanoidRootPart")
        if AF19 then
            return AF19.Position
        end
    end
    
    return AY8.Position + AY8.CFrame.LookVector * 10
end

local function AF20()
    local AF21
    if AY3 == AY4.Name then
        AF21 = AY4
    else
        AF21 = Players:FindFirstChild(AY3)
    end
    
    if not AF21 then 
        AY13 = false
        if AY5 and AY5.Parent then
            AY5.Parent = nil
        end
        if AY9 and AY9.Parent then
            AY9.Parent = nil
        end
        return true
    end
    
    local function AF22(AF23)
        if not AF23 then return end
        
        AY6 = AF23
        AY7 = AF23:FindFirstChild("Humanoid")
        AY8 = AF23:FindFirstChild("HumanoidRootPart")
        AY21 = false
        
        AY10 = AF23
        AY11 = AF23:FindFirstChild("Humanoid")
        AY12 = AF23:FindFirstChild("HumanoidRootPart")
        
        if AY7 then
            AY7.Died:Connect(function()
                AY13 = false
                AY21 = false
                if AY5 and AY5.Parent then
                    AY5.Parent = nil
                end
                if AY9 and AY9.Parent then
                    AY9.Parent = nil
                end
            end)
            
            AY7:GetPropertyChangedSignal("Health"):Connect(function()
                if AY7.Health > 0 and not AY13 then
                    AY13 = true
                    AY21 = false
                    if AY5 and not AY5.Parent then
                        AY5.Parent = workspace
                    end
                    if AY9 and not AY9.Parent then
                        AY9.Parent = workspace
                    end
                end
            end)
        end
        
        AY13 = true
        
        if AY5 and not AY5.Parent then
            AY5.Parent = workspace
        end
        if AY9 and not AY9.Parent then
            AY9.Parent = workspace
        end
        
        task.wait(0.2)
        AF8()
    end
    
    if AF21.Character then
        AF22(AF21.Character)
    end
    
    AF21.CharacterAdded:Connect(function(AF23)
        task.wait(0.5)
        AF22(AF23)
    end)
    
    AF21.CharacterRemoving:Connect(function()
        AY6 = nil
        AY7 = nil
        AY8 = nil
        AY10 = nil
        AY11 = nil
        AY12 = nil
        AY13 = false
        AY21 = false
    end)
    
    return true
end

local function AF24(AF25)
    if not AY5 or not AY5.PrimaryPart or not AY6 or not AY7 or not AY8 or not AY13 then
        return
    end
    
    if AY7.Health <= 0 then
        if AY5 and AY5.Parent then
            AY5.Parent = nil
        end
        AY21 = false
        return
    end
    
    if not AY5.Parent then
        AY5.Parent = workspace
    end
    
    if not AY21 then
        AF8()
        return
    end
    
    local AF26 = AF17()
    local AF27 = AY8.Position + Vector3.new(0, AY20, -AY19)
    AY15 = AY15:Lerp(AF27, AY16)
    
    local AF28 = AY5.PrimaryPart.Position
    local AF29 = (AF28 - AF27).Magnitude
    
    if AF29 > 20 then
        AY5:SetPrimaryPartCFrame(CFrame.new(AF27, AF26))
        AY15 = AF27
        AY14 = Vector3.zero
        return
    end
    
    local AF30 = (AY15 - AF28) * AY17
    AY14 = AY14 + AF30 * AF25
    AY14 = AY14 * AY18
    
    if AY14.Magnitude > 25 then
        AY14 = AY14.Unit * 25
    end
    
    local AF31 = AF28 + AY14 * AF25
    local AF32 = CFrame.new(AF31, AF26)
    
    AY5:SetPrimaryPartCFrame(AF32)
end

local function AF33()
    if not AY9 or not AY9.PrimaryPart or not AY10 or not AY11 then
        return
    end
    
    if AY11.Health <= 0 then
        if AY9 and AY9.Parent then
            AY9.Parent = nil
        end
        return
    end
    
    if not AY9.Parent then
        AY9.Parent = workspace
    end
    
    if not AY12 then
        AY12 = AY10:FindFirstChild("HumanoidRootPart")
        if not AY12 then
            return
        end
    end
    
    local AF34 = CFrame.new(0, 2.5, 0)
    AY9:SetPrimaryPartCFrame(AY12.CFrame * AF34)
end

AF1()
AF5()

local foundPlayerAY = AF20()
RunService.Heartbeat:Connect(AF24)
RunService.RenderStepped:Connect(AF33)

if not foundPlayerAY then
    task.spawn(function()
        while task.wait(3) do
            if AF20() then
                break
            end
        end
    end)
end
