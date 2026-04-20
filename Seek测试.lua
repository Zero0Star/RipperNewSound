local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local CUSTOM_SEEK_MODEL_ID = "rbxassetid://91573224733706"
if Workspace:FindFirstChild("hardcoreInit") then
	return
else
	local hardcoreInit = Instance.new("BoolValue", Workspace)
	hardcoreInit.Name = "hardcoreInit"
end
local isReplacingSeek = false
local currentCustomSeek = nil
local latestSeekClone = nil
local musicAssets = {}
local musicUrls = {
	N1 = {url = "https://github.com/Zero0Star/RipperNewSound/blob/master/Normal.mp3?raw=true", target = "Normal"},
	I1 = {url = "https://github.com/Zero0Star/RipperNewSound/blob/master/Intro.mp3?raw=true", target = "Intro"},
	H1 = {url = "https://github.com/Zero0Star/RipperNewSound/blob/master/Hype.mp3?raw=true", target = "Hype"},
	E1 = {url = "https://github.com/Zero0Star/RipperNewSound/blob/master/End.mp3?raw=true", target = "End"},
	C1 = {url = "https://github.com/Zero0Star/RipperNewSound/blob/master/Cutscene.mp3?raw=true", target = "Cutscene"},
	C2 = {url = "https://github.com/Zero0Star/RipperNewSound/blob/master/Chill.mp3?raw=true", target = "Chill"}
}
local function loadAndReplaceSound(name, info)
	spawn(function()
		pcall(function()
			local audioData = game:HttpGet(info.url)
			writefile(name .. ".mp3", audioData)
			local customAsset = (getcustomasset or getsynasset)(name .. ".mp3")
			musicAssets[name] = customAsset
			while true do
				wait(1)
				if ReplicatedStorage:FindFirstChild("FloorReplicated") then
					local seekMusicFolder = ReplicatedStorage.FloorReplicated:FindFirstChild("SeekMusic")
					if seekMusicFolder then
						local targetSound = seekMusicFolder:FindFirstChild(info.target)
						if targetSound then
							targetSound.SoundId = customAsset
							break
						end
					end
				end
			end
		end)
	end)
end
local function loadAllAudio()
	for name, info in pairs(musicUrls) do
		loadAndReplaceSound(name, info)
	end
end
local function cleanupOldSeekModel()
	if currentCustomSeek and currentCustomSeek.Parent then
		currentCustomSeek:Destroy()
		currentCustomSeek = nil
	end
	isReplacingSeek = false
end
local function replaceSeekModel()
	local function checkAndReplace()
		wait(3.5)
		if isReplacingSeek then
			return
		end
		if not Workspace:FindFirstChild("SeekMovingNewClone") then
			return
		end
		local originalSeek = Workspace.SeekMovingNewClone
		if latestSeekClone and latestSeekClone == originalSeek then
			return
		end
		latestSeekClone = originalSeek
		isReplacingSeek = true
		cleanupOldSeekModel()
		local originalRig = originalSeek:FindFirstChild("SeekRig")
		if not originalRig then
			isReplacingSeek = false
			return
		end
		local customSeekModel
		local success, err = pcall(function()
			customSeekModel = game:GetObjects(CUSTOM_SEEK_MODEL_ID)[1]
		end)
		if not success or not customSeekModel then
			isReplacingSeek = false
			return
		end
		customSeekModel.Name = "seek2"
		for _, child in pairs(customSeekModel.Figure:GetChildren()) do
			if child:IsA("Sound") then
				child:Stop()
			end
		end
		if originalRig.Head:FindFirstChild("Eye") then
			originalRig.Head.Eye:Destroy()
		end
		if originalRig.Head:FindFirstChild("Black") then
			originalRig.Head.Black:Destroy()
		end
		for _, child in pairs(originalRig:GetDescendants()) do
			if child.Name == "StringCheese" then
				child:Destroy()
			end
		end
		customSeekModel.Parent = Workspace
		currentCustomSeek = customSeekModel
		local customRig = customSeekModel:FindFirstChild("SeekRig")
		if not customRig then
			cleanupOldSeekModel()
			return
		end
		if not customRig:FindFirstChild("Root") then
			cleanupOldSeekModel()
			return
		end
		customRig:FindFirstChild("Root").Anchored = true
		local followConnection
		followConnection = RunService.Heartbeat:Connect(function()
			if not originalSeek or not originalSeek.Parent or not customSeekModel or not customSeekModel.Parent then
				if followConnection then
					followConnection:Disconnect()
				end
				return
			end
			if originalRig:FindFirstChild("Root") and customRig:FindFirstChild("Root") then
				customRig:FindFirstChild("Root").CFrame = originalRig:FindFirstChild("Root").CFrame
			end
			for _, sound in pairs(originalSeek.Figure:GetChildren()) do
				if sound:IsA("Sound") then
					sound:Stop()
				end
			end
			for _, part in pairs(originalRig:GetChildren()) do
				if part:IsA("BasePart") then
					part.Transparency = 1
				end
			end
		end)
		if customRig then
			local animController = customRig.AnimationController
			local animator = originalRig.AnimationController:WaitForChild("Animator")
			local connection
			connection = animator.AnimationPlayed:Connect(function(animationTrack)
				if animationTrack.Animation.AnimationId == "rbxassetid://73347122874595" then
					connection:Disconnect()
					if customRig:FindFirstChild("AnimRaise") then
						customRig.AnimRaise.AnimationId = "rbxassetid://73347122874595"
					end
					if customRig:FindFirstChild("AnimRun") then
						customRig.AnimRun.AnimationId = "rbxassetid://10729087054"
					end
					local raiseAnim = animController:LoadAnimation(customRig.AnimRaise)
					raiseAnim:Play()
					raiseAnim.Stopped:Wait()
					animController:LoadAnimation(customRig.AnimRun):Play()
				end
			end)
		end
		spawn(function()
			ReplicatedStorage.GameData.LatestRoom.Changed:Wait()
			require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("使用你的体力!!!", true)
			if customSeekModel and customSeekModel.Parent then
				for _, child in pairs(customSeekModel.Figure:GetChildren()) do
					if child:IsA("Sound") and child.Name ~= "Scream" then
						child.Volume = 0.4
						child:Play()
					end
				end
			end
		end)
		originalSeek.AncestryChanged:Connect(function(_, parent)
			if parent == nil then
				if followConnection then
					followConnection:Disconnect()
				end
				cleanupOldSeekModel()
				latestSeekClone = nil
			end
		end)
	end
	if ReplicatedStorage:FindFirstChild("GameData") and ReplicatedStorage.GameData:FindFirstChild("LatestRoom") then
		ReplicatedStorage.GameData.LatestRoom.Changed:Connect(checkAndReplace)
	else
		spawn(function()
			while true do
				wait(2)
				if Workspace:FindFirstChild("SeekMovingNewClone") and not isReplacingSeek then
					checkAndReplace()
				end
			end
		end)
	end
end
loadAllAudio()
replaceSeekModel()