local rooms = workspace:WaitForChild("CurrentRooms")

local colors = {
    Color3.fromRGB(255,0,0),
    Color3.fromRGB(255,127,0),
    Color3.fromRGB(255,255,0),
    Color3.fromRGB(0,255,0),
    Color3.fromRGB(0,255,255),
    Color3.fromRGB(0,0,255),
    Color3.fromRGB(170,0,255)
}

local i = 1

while true do
    for _, room in pairs(rooms:GetChildren()) do
        for _, obj in pairs(room:GetDescendants()) do
            if obj:IsA("BasePart") then
                obj.Color = colors[i]
            end
        end
    end

    i += 1
    if i > #colors then
        i = 1
    end

    task.wait(1)
end