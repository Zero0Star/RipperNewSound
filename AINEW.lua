 local Event = game:GetService("ReplicatedStorage").RemotesFolder.AdminPanelRunCommand
Event:FireServer(
    "DELETE ALL",
    {}
)
    local function deleteDirectChildModels()
    local workspace = game:GetService("Workspace")
    local modelNames = {
        "A-200", "A60", "Amin-60", "Black-A60", "Deer god","Black Hole Particle effect","DeerGod",
        "Frostbite", "@&%^#*$Indescribable God!@$*&^!Q(* ", "LightSpeed",
        "Rebound", "Ripper", "Following_ENEMY", "Silence","Dread","Muffler","Common Sence","Fluster","Kitty","Broken eyes","Angry Munci","Shadow","LEVEL0","Him","Hunger","WH1T3","Obsession","HimMoving","smiler", "Chainsmoker"
    }
    for _, name in ipairs(modelNames) do
        local model = workspace:FindFirstChild(name)
        if model and model:IsA("Model") then
            model:Destroy()
        end
    end
end
deleteDirectChildModels()
