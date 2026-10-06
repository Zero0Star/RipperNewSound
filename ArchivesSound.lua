local rooms = workspace:WaitForChild("CurrentRooms")
local soundId = "rbxassetid://140444636093892"
local processed = {}

local function replace(room)
	if processed[room] or not room:IsA("Model") or not tonumber(room.Name) then return end

	local function apply()
		local door = room:FindFirstChild("Door")
		if door then
			local mesh = door:FindFirstChild("Door")
			if mesh and mesh:IsA("MeshPart") then
				local open = mesh:FindFirstChild("Open")
				if open and open:IsA("Sound") then
					open.SoundId = soundId
					processed[room] = true
					return true
				end
			end
		end
	end

	if apply() then return end

	local conn
	conn = room.DescendantAdded:Connect(function()
		if apply() and conn then
			conn:Disconnect()
		end
	end)
end

for _, v in ipairs(rooms:GetChildren()) do
	replace(v)
end

rooms.ChildAdded:Connect(function(v)
	replace(v)
end)