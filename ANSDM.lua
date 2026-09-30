if workspace:FindFirstChild("HardcoreC") then
    return
end
local marker = Instance.new("BoolValue")
marker.Name = "HardcoreC"
marker.Value = true
marker.Parent = workspace
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local function CreateFollowerSystem(modelId1, modelId2, targetPlayerName)

	local mainModel, accessoryModel, char, humanoid, rootPart
	local targetChar, targetHum, targetRoot
	local isActive, isInitialized = true, false
	local velocity, targetPosition = Vector3.zero, Vector3.zero
	local lerpFactor, springForce, damping, followDist, heightOffset = 0.3, 80, 0.9, 5, -2.7


	local function loadModel(assetId, isMain)

		local success, model = pcall(function()
			return game:GetObjects("rbxassetid://" .. tostring(assetId))[1]
		end)

		if success and model then

			model.Parent = workspace

			for _, part in pairs(model:GetDescendants()) do
				if part:IsA("BasePart") then
					part.Anchored = true
					part.CanCollide = false
				end
			end

			if not model.PrimaryPart then
				model.PrimaryPart =
					model:FindFirstChild("HumanoidRootPart")
					or model:FindFirstChild("Torso")
					or model:FindFirstChildWhichIsA("BasePart")
			end

			if isMain then
				mainModel = model
			else
				accessoryModel = model
			end

		end
	end


	local function findNearestPlayer()

		if not rootPart then
			return nil
		end

		local nearestPlayer
		local minDist = math.huge
		local myPos = rootPart.Position

		for _, player in pairs(Players:GetPlayers()) do

			if player ~= Players:GetPlayerFromCharacter(char)
			and player.Character then

				local hrp =
					player.Character:FindFirstChild("HumanoidRootPart")

				if hrp then

					local dist =
						(hrp.Position - myPos).Magnitude

					if dist < minDist and dist < 30 then
						minDist = dist
						nearestPlayer = player
					end

				end
			end
		end

		return nearestPlayer
	end


	local function getLookTarget()

		if not rootPart then
			return Vector3.zero
		end

		local nearest = findNearestPlayer()

		if nearest and nearest.Character then

			local hrp =
				nearest.Character:FindFirstChild("HumanoidRootPart")

			if hrp then
				return hrp.Position
			end

		end

		return rootPart.Position + rootPart.CFrame.LookVector * 10
	end


	local function initializePosition()

		if not rootPart
		or not mainModel
		or not mainModel.PrimaryPart
		or isInitialized then
			return
		end

		local spawnPos =
			rootPart.Position +
			Vector3.new(0,heightOffset,-followDist)

		mainModel:SetPrimaryPartCFrame(
			CFrame.new(
				spawnPos,
				rootPart.Position
			)
		)

		targetPosition = spawnPos
		velocity = Vector3.zero
		isInitialized = true
	end


	local function attachToCharacter(playerChar)

		if not playerChar then
			return
		end

		char = playerChar
		targetChar = playerChar

		humanoid =
			playerChar:FindFirstChild("Humanoid")

		rootPart =
			playerChar:FindFirstChild("HumanoidRootPart")

		targetHum = humanoid
		targetRoot = rootPart

		isInitialized = false


		if humanoid then

			humanoid.Died:Connect(function()

				isActive = false
				isInitialized = false

				if mainModel and mainModel.Parent then
					mainModel.Parent = nil
				end

				if accessoryModel and accessoryModel.Parent then
					accessoryModel.Parent = nil
				end

			end)

		end


		isActive = true

		if mainModel and not mainModel.Parent then
			mainModel.Parent = workspace
		end

		if accessoryModel and not accessoryModel.Parent then
			accessoryModel.Parent = workspace
		end

		task.wait(0.2)

		initializePosition()

	end


	local function setupPlayerTracking()

		local targetPlayer

		if targetPlayerName == Players.LocalPlayer.Name then
			targetPlayer = Players.LocalPlayer
		else
			targetPlayer = Players:FindFirstChild(targetPlayerName)
		end


		if not targetPlayer then

			isActive = false

			if mainModel then
				mainModel.Parent = nil
			end

			if accessoryModel then
				accessoryModel.Parent = nil
			end

			return
		end


		if targetPlayer.Character then
			attachToCharacter(targetPlayer.Character)
		end


		targetPlayer.CharacterAdded:Connect(function(newChar)

			task.wait(0.5)

			attachToCharacter(newChar)

		end)


		targetPlayer.CharacterRemoving:Connect(function()

			char = nil
			humanoid = nil
			rootPart = nil

			targetChar = nil
			targetHum = nil
			targetRoot = nil

			isActive = false
			isInitialized = false

		end)
        end
	local function updateMain(dt)

		if not mainModel
		or not mainModel.PrimaryPart
		or not char
		or not humanoid
		or not rootPart
		or not isActive then
			return
		end


		if humanoid.Health <= 0 then

			if mainModel.Parent then
				mainModel.Parent = nil
			end

			isInitialized = false

			return
		end


		if not mainModel.Parent then
			mainModel.Parent = workspace
		end


		if not isInitialized then

			initializePosition()

			return
		end


		local lookTarget = getLookTarget()


		local desiredPos =
			rootPart.Position +
			Vector3.new(
				0,
				heightOffset,
				-followDist
			)


		targetPosition =
			targetPosition:Lerp(
				desiredPos,
				lerpFactor
			)


		local currentPos =
			mainModel.PrimaryPart.Position


		local distToDesired =
			(currentPos - desiredPos).Magnitude


		if distToDesired > 20 then

			mainModel:SetPrimaryPartCFrame(
				CFrame.new(
					desiredPos,
					lookTarget
				)
			)

			targetPosition = desiredPos
			velocity = Vector3.zero

			return
		end


		local springForceVec =
			(targetPosition-currentPos)
			*
			springForce


		velocity =
			velocity +
			springForceVec *
			dt


		velocity =
			velocity *
			damping


		if velocity.Magnitude > 25 then
			velocity =
				velocity.Unit *
				25
		end


		local newPos =
			currentPos +
			velocity *
			dt


		mainModel:SetPrimaryPartCFrame(
			CFrame.new(
				newPos,
				lookTarget
			)
		)

	end


	local function updateAccessory()

		if not accessoryModel
		or not accessoryModel.PrimaryPart
		or not targetChar
		or not targetHum then
			return
		end


		if targetHum.Health <= 0 then

			if accessoryModel.Parent then
				accessoryModel.Parent = nil
			end

			return
		end


		if not accessoryModel.Parent then
			accessoryModel.Parent = workspace
		end


		if not targetRoot then

			targetRoot =
				targetChar:FindFirstChild(
					"HumanoidRootPart"
				)

			if not targetRoot then
				return
			end

		end


		accessoryModel:SetPrimaryPartCFrame(
			targetRoot.CFrame *
			CFrame.new(
				0,
				2.5,
				0
			)
		)

	end


	loadModel(modelId1,true)
	loadModel(modelId2,false)

	setupPlayerTracking()


	RunService.Heartbeat:Connect(updateMain)

	RunService.RenderStepped:Connect(updateAccessory)

end


CreateFollowerSystem(1,89102835650735,"QWQ75321")
CreateFollowerSystem(115878511638478,102779962756282,"goat_qiu")
CreateFollowerSystem(137290604674399,114265802440184,"Nssys123")
CreateFollowerSystem(14806821870,93658420501516,"sppvve")
CreateFollowerSystem(135367832132409,90758493537987,"woshiniruier")
CreateFollowerSystem(101318804217737,91496399485501,"A_Yun66")
CreateFollowerSystem(115878511638478,72120706000846,"SOXIYU24")
CreateFollowerSystem(1,122378519155467,"Yxi_na")
CreateFollowerSystem(1,139348648036501,"SparkleAtom")
CreateFollowerSystem(1,111163771007681,"cgdwml")
CreateFollowerSystem(1,89519482926529,"Staryyy011")
local function MCRGlitch()

	local function StartGlitch(TextLabel)

		local Original = TextLabel.Text

		local GlitchChars = {
			"▓",
			"█",
			"▒",
			"#",
			"%",
			"@",
			"0",
			"1",
			"7",
			"X",
			"?",
			"∆",
			"†"
		}


		task.spawn(function()

			while TextLabel.Parent do

				local Result = ""


				for i = 1,#Original do

					local Char =
						Original:sub(i,i)


					if Char == " "
					or Char == "'" then

						Result =
							Result .. Char

					else

						if math.random() < 0.55 then

							Result =
								Result ..
								GlitchChars[
									math.random(
										1,
										#GlitchChars
									)
								]

						else

							Result =
								Result .. Char

						end

					end

				end


				TextLabel.Text = Result


				task.wait(
					math.random(3,8) / 100
				)

			end

		end)

	end



	local function FindMCR()

		for _,model in ipairs(workspace:GetDescendants()) do

			if model:IsA("Model")
			and model.Name == "MCR" then


				local NameUIV2 =
					model:FindFirstChild("NameUIV2")


				if NameUIV2 then

					local Stuff =
						NameUIV2:FindFirstChild("Stuff")


					if Stuff then

						local Frame =
							Stuff:FindFirstChild("Frame")


						if Frame then

							local MorphName =
								Frame:FindFirstChild("MorphName")


							if MorphName
							and MorphName:IsA("TextLabel") then

								StartGlitch(
									MorphName
								)

								return

							end

						end

					end

				end

			end

		end

	end


	FindMCR()


	workspace.DescendantAdded:Connect(function(obj)

		if obj:IsA("Model")
		and obj.Name == "MCR" then

			task.wait(0.5)

			FindMCR()

		end

	end)

end


MCRGlitch()