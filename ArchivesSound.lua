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
function GitAud(soundgit, filename)
    local url = soundgit
    local FileName = filename
    writefile(FileName .. ".mp3", game:HttpGet(url))
    return (getcustomasset or getsynasset)(FileName .. ".mp3")
end

function CustomGitSound(soundlink, vol, filename)
    local sound = Instance.new("Sound")
    sound.SoundId = GitAud(soundlink, filename)
    sound.Parent = workspace
    sound.Name = filename or ""
    sound.Volume = vol or 1
    return sound
end

local folder = Instance.new("Folder")
folder.Name = "HardCoreSound"
folder.Parent = workspace

local soundsData = {
    {url = "https://github.com/Zero0Star/RipperNewSound/blob/master/DreadJumpFace.mp3?raw=true", name = "DreadJump", vol = 5},
    {url = "https://raw.githubusercontent.com/Zero0Star/RipperMPSound/master/A120Jump.mp3", name = "A200J", vol = 4},
    {url = "https://github.com/Zero0Star/RipperNewSound/blob/master/Astary.mp3?raw=true", name = "A1", vol = 6},
    {url = "https://github.com/Zero0Star/RipperNewSound/blob/master/A2.mp3?raw=true", name = "A2", vol = 6},
    {url = "https://github.com/Zero0Star/RipperNewSound/blob/master/A3.mp3?raw=true", name = "A3", vol = 6},
    {url = "https://github.com/Zero0Star/RipperNewSound/blob/master/A4.mp3?raw=true", name = "A4", vol = 6},
    {url = "https://github.com/Zero0Star/RipperNewSound/blob/master/A5.mp3?raw=true", name = "A5", vol = 6},
    {url = "https://github.com/Zero0Star/RipperNewSound/blob/master/A6.mp3?raw=true", name = "A6", vol = 6},
    {url = "https://github.com/Zero0Star/RipperNewSound/blob/master/A7.mp3?raw=true", name = "A7", vol = 6},
    {url = "https://github.com/Zero0Star/RipperNewSound/blob/master/AbominationLoop_Custom.mp3?raw=true", name = "A500Two", vol = 1.5},
    {url = "https://github.com/Zero0Star/RipperNewSound/blob/master/AbominationStart_Custom.mp3?raw=true", name = "A500One", vol = 1.5},
    {url = "https://github.com/Zero0Star/RipperNewSound/blob/master/AbominationLoop_END.mp3?raw=true", name = "A500Three", vol = 1.5},
    {url = "https://github.com/Zero0Star/RipperNewSound/blob/master/Silence.mp3?raw=true", name = "Silence", vol = 1},
    {url = "https://github.com/Zero0Star/RipperNewSound/blob/master/SilenceFar.mp3?raw=true", name = "SilenceFar", vol = 1},
    {url = "https://github.com/Zero0Star/RipperNewSound/blob/master/NoRunning.mp3?raw=true", name = "DeerGodMusic", vol = 1},
    {url = "https://github.com/Zero0Star/RipperNewSound/blob/master/ATCHST.mp3?raw=true", name = "ATCHSTARYT", vol = 0.3}
}

for _, data in ipairs(soundsData) do
    local sound = CustomGitSound(data.url, data.vol, data.name)
    sound.Parent = folder
end