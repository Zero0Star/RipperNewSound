local Lighting = game:GetService("Lighting");
local Enabled = true
local TerrainPlusEnabled = true
local BetterLightingEnabled = true
function SetupLighting_()
	local ColorCorrection = Instance.new("ColorCorrectionEffect")
	local SunRays = Instance.new("SunRaysEffect")
	local Blur = Instance.new("BlurEffect")

	Lighting.Brightness = 2
	Lighting.EnvironmentDiffuseScale = .2
	Lighting.EnvironmentSpecularScale = .82
	SunRays.Parent = Lighting
	Blur.Size = 3.921
	Blur.Parent = Lighting
	ColorCorrection.Parent = Lighting
	ColorCorrection.Saturation = .092
end

function SetupTerrain()
	local Terrain = game.Workspace.Terrain;
	Terrain.WaterTransparency = 1
	Terrain.WaterReflectance = 1
end

if Enabled then
	if TerrainPlusEnabled then
		SetupTerrain()
		warn("Loaded Better Terrain")
	end
	if BetterLightingEnabled then
		SetupLighting_()
	end
elseif not Enabled then
	return false
end

script.Parent = game:GetService("ServerScriptService")