local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local SectorTexts = {
	"愤怒 区域情况:实体横行",
	"电力异常 区域情况:少量实体",
	"空气中有毒气,请联系管理员",
	"教室",
	"此层及已作废",
	"未知",
	"未知",
	"未知"
}

local stopped = false
local connection

local function getTargetRoom()
	local currentRooms = Workspace:FindFirstChild("CurrentRooms")
	if not currentRooms then
		return nil
	end

	local maxNumber = -math.huge
	local maxModel

	for _, model in ipairs(currentRooms:GetChildren()) do
		local number = tonumber(model.Name)
		if number and number > maxNumber then
			maxNumber = number
			maxModel = model
		end
	end

	if not maxModel then
		return nil
	end

	return currentRooms:FindFirstChild(tostring(maxNumber - 1))
end

local function replaceSectors(frame)
	local elevators = frame:FindFirstChild("Elevators")
	if not elevators then
		return
	end

	local scrollingFrame = elevators:FindFirstChild("ScrollingFrame")
	if not scrollingFrame then
		return
	end

	local canvas = scrollingFrame:FindFirstChild("Canvas")
	if not canvas then
		return
	end

	for i = 1, 8 do
		local sector = canvas:FindFirstChild("Sector" .. i)
		if sector then
			local sectorInfo = sector:FindFirstChild("SectorInfo")
			if sectorInfo and (sectorInfo:IsA("TextLabel") or sectorInfo:IsA("TextButton")) then
				sectorInfo.Text = SectorTexts[i]
			end
		end
	end
end

local targetRoom = getTargetRoom()

if not targetRoom then
	return
end

local function check()
	if stopped then
		return
	end

	local assets = targetRoom:FindFirstChild("Assets")
	if not assets then
		return
	end

	local archivesTerminal = assets:FindFirstChild("ArchivesTerminal")
	if not archivesTerminal then
		return
	end

	local screenUI = archivesTerminal:FindFirstChild("ScreenUI")
	if not screenUI then
		return
	end

	local frame = screenUI:FindFirstChild("Frame")
	if frame then
		replaceSectors(frame)
	end
end

connection = RunService.Heartbeat:Connect(check)

local gameData = ReplicatedStorage:FindFirstChild("GameData")
local latestRoom = gameData and gameData:FindFirstChild("LatestRoom")

if latestRoom then
	latestRoom.Changed:Wait()
end

stopped = true

if connection then
	connection:Disconnect()
	connection = nil
end