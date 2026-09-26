if workspace:FindFirstChild("HardcoreM") then
    return
end
local marker = Instance.new("BoolValue")
marker.Name = "HardcoreM"
marker.Value = true
marker.Parent = workspace
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer

local BORDER_COLOR =
Color3.fromRGB(255,222,189)


local CLICK_SOUND =
"rbxassetid://139719503904449"

local FONT =
Font.new(
	"rbxassetid://12187360881"
)

local Skills = {

	{
		Name="未选择",
		Icon="rbxassetid://262619583",
		Description="不选择任何魅力\n以普通状态开始。(你是位勇士)",
		Function=function()

			local TextChatService =
			game:GetService("TextChatService")

			TextChatService.TextChannels.RBXGeneral:SendAsync(
				"Do not choose"
			)

		end
	},


	{
		Name="肾上腺素",
		Icon="rbxassetid://484395794",
		Description="当你受伤时,你将会得到大幅度的速度加成,(该技能获取加速不稳定)",
		Function=function()

			local TextChatService =
			game:GetService("TextChatService")

			TextChatService.TextChannels.RBXGeneral:SendAsync(
				"选择 肾上腺素"
			)

		end
	},

	{
		Name="宝藏猎手",
		Icon="rbxassetid://2246496691",
		Description="你的物品爆率将会提高,同时你更吸引怪物仇恨。",
		Function=function()

			local TextChatService =
			game:GetService("TextChatService")

			TextChatService.TextChannels.RBXGeneral:SendAsync(
				"选择 宝藏猎手"
			)

		end
	},


	{
		Name="急救包",
		Icon="rbxassetid://107890189177071",
		Description="每局游戏开始时你将会有更多医疗物品,但是你将不再会在遭遇战复活,获得随时随地复活一次的能力。",
		Function=function()

			local TextChatService =
			game:GetService("TextChatService")

			TextChatService.TextChannels.RBXGeneral:SendAsync(
				"选择 医疗包"
			)

		end
	},

	{
		Name="跳跃",
		Icon="rbxassetid://12510788215",
		Description="你将会解锁跳跃,滑铲等能力,没有任何负面效果。",
		Function=function()

			local TextChatService =
			game:GetService("TextChatService")

			TextChatService.TextChannels.RBXGeneral:SendAsync(
				"选择 跳跃"
			)

		end
	},

	{
		Name="最后一口气",
		Icon="rbxassetid://3733610821",
		Description="当你濒临死亡时,你将会获得短暂的复活,并且获取30秒的无敌状态,速度,力量将会增加100%,同时你的血量将会更低。",
		Function=function()

			local TextChatService =
			game:GetService("TextChatService")

			TextChatService.TextChannels.RBXGeneral:SendAsync(
				"选择 最后一口气"
			)

		end
	},

	{
		Name="生化",
		Icon="rbxassetid://136334141519402",
		Description="你将会免疫所有辐射,爆炸,冻霜伤害,同时在你身边的所有生物将会收到持续性生化伤害。",
		Function=function()

			local TextChatService =
			game:GetService("TextChatService")

			TextChatService.TextChannels.RBXGeneral:SendAsync(
				"选择 生化"
			)

		end
	},

	{
		Name="力量",
		Icon="rbxassetid://2245735821",
		Description="你所有的武器将会得到40%的伤害加成,同时你受到的伤害也会增加5%。",
		Function=function()

			local TextChatService =
			game:GetService("TextChatService")

			TextChatService.TextChannels.RBXGeneral:SendAsync(
				"选择 力量"
			)

		end
	},

	{
		Name="信徒",
		Icon="rbxassetid://13050415802",
		Description="你将更受到星光与月光的庇护,但同时你不能选择红光。",
		Function=function()

			local TextChatService =
			game:GetService("TextChatService")

			TextChatService.TextChannels.RBXGeneral:SendAsync(
				"选择 信徒"
			)

		end
	},

	{
		Name="幸运",
		Icon="rbxassetid://14513064598",
		Description="每隔一段时间,你将获得一份随机物品或随机效果。",
		Function=function()

			local TextChatService =
			game:GetService("TextChatService")

			TextChatService.TextChannels.RBXGeneral:SendAsync(
				"选择 幸运"
			)

		end
	},

	{
		Name="夜视",
		Icon="rbxassetid://524302408",
		Description="你将会拥有夜视与透视效果,但同时你将看不见所有的队友。",
		Function=function()
                local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local function hideModel(model)
	for _,v in pairs(model:GetDescendants()) do
		if v:IsA("BasePart") then
			v.Transparency = 1
		elseif v:IsA("Decal") or v:IsA("Texture") then
			v.Transparency = 1
		elseif v:IsA("Accessory") then
			local h = v:FindFirstChild("Handle")
			if h then
				h.Transparency = 1
			end
		elseif v:IsA("Shirt") or v:IsA("Pants") or v:IsA("ShirtGraphic") then
			v:Destroy()
		end
	end
end
local function scan()
	for _,v in pairs(workspace:GetChildren()) do
		if v:IsA("Model") then
			local hum = v:FindFirstChildOfClass("Humanoid")
			if hum and v ~= LocalPlayer.Character then
				hideModel(v)
			end
		end
	end
end
scan()
workspace.ChildAdded:Connect(function(v)
	task.wait(0.2)
	if v:IsA("Model") then
		local hum = v:FindFirstChildOfClass("Humanoid")
		if hum and v ~= LocalPlayer.Character then
			hideModel(v)
		end
	end
end)
local Lighting = game:GetService("Lighting")
Lighting.GlobalShadows = false
Lighting.Brightness = 5
Lighting.ExposureCompensation = 0.3
Lighting.Ambient = Color3.fromRGB(180,180,180)
Lighting.OutdoorAmbient = Color3.fromRGB(200,200,200)
Lighting.FogEnd = 100000
for _,v in pairs(Lighting:GetChildren()) do
	if v:IsA("ColorCorrectionEffect") then
		v:Destroy()
	elseif v:IsA("BloomEffect") then
		v:Destroy()
	elseif v:IsA("Atmosphere") then
		v.Density = 0.1
		v.Haze = 0
	end
end
local cc = Instance.new("ColorCorrectionEffect")
cc.Brightness = 0.1
cc.Contrast = 0.05
cc.Saturation = 0.1
cc.TintColor = Color3.fromRGB(255,255,255)
cc.Parent = Lighting
local bloom = Instance.new("BloomEffect")
bloom.Intensity = 0.15
bloom.Size = 24
bloom.Threshold = 2
bloom.Parent = Lighting
			local TextChatService =
			game:GetService("TextChatService")
			TextChatService.TextChannels.RBXGeneral:SendAsync(
				"选择 夜视"
                        
			)

		end
	},

	{
		Name="爆破",
		Icon="rbxassetid://15889469852",
		Description="你将对爆破伤害减免40%,同时开出爆炸类型武器的概率将会提高,但你有概率炸死队友。",
		Function=function()

			local TextChatService =
			game:GetService("TextChatService")

			TextChatService.TextChannels.RBXGeneral:SendAsync(
				"选择 爆破"
			)

		end
	},

	{
		Name="恶搞",
		Icon="rbxassetid://76564632589409",
		Description="高的风险,高回报。(需要成就 Eternity of Land)",
		Function=function()

			local TextChatService =
			game:GetService("TextChatService")

			TextChatService.TextChannels.RBXGeneral:SendAsync(
				"选择 恶搞"
			)

		end
	},

	{
		Name="邪教徒",
		Icon="rbxassetid://137068949699451",
		Description="真正的教徒,在游戏内你不再获得建筑师们的帮助,但大幅度提升身体属性。(需要成就 Why are you running?)",
		Function=function()

			local TextChatService =
			game:GetService("TextChatService")

			TextChatService.TextChannels.RBXGeneral:SendAsync(
				"选择 邪教徒"
			)

		end
	},

	{
		Name="先驱",
		Icon="rbxassetid://12711425013",
		Description="当你随着游戏越后期,你将获得更强大的力量,但力量有隐藏着的负面效果。(需要成就 Why are you running?)",
		Function=function()

			local TextChatService =
			game:GetService("TextChatService")

			TextChatService.TextChannels.RBXGeneral:SendAsync(
				"选择 先驱"
			)

		end
	},

	{
		Name="憎恨",
		Icon="rbxassetid://4675906142",
		Description="所有生物将会对你仇恨拉满,同时你将会被HatRed所庇护。(需要成就 Hate Tracker)",
		Function=function()

			local TextChatService =
			game:GetService("TextChatService")

			TextChatService.TextChannels.RBXGeneral:SendAsync(
				"选择 憎恨"
			)

		end
	},

	{
		Name="护盾",
		Icon="rbxassetid://11322093465",
		Description="你的耐力值将会消失,增加护盾血量。(这下我什么都不怕了。)",
		Function=function()

			local TextChatService =
			game:GetService("TextChatService")

			TextChatService.TextChannels.RBXGeneral:SendAsync(
				"选择 护盾"
			)
			local Stamina =
			game.Players.LocalPlayer.PlayerGui:FindFirstChild(
				"StaminaGui"
			)

			if Stamina then
				Stamina:Destroy()
			end

		end
	}

}

for i=1,15 do

	table.insert(
		Skills,
		{
			Name="未解锁",
			Icon="rbxassetid://15117261700",
			Description="需要解锁成就",
			Function=function()

			end
		}
	)

end

local Selected =
Skills[1]

local function PlayClick()

	local Sound =
	Instance.new("Sound")

	Sound.SoundId =
	CLICK_SOUND


	Sound.Volume =
	10

	Sound.Parent =
	workspace

	Sound:Play()

	Debris:AddItem(
		Sound,
		2
	)

end
local OriginalMouseBehavior =
UserInputService.MouseBehavior

local OriginalMouseIcon =
UserInputService.MouseIconEnabled

local function unlockMouseForDoors()

	UserInputService.MouseBehavior =
	Enum.MouseBehavior.Default


	UserInputService.MouseIconEnabled =
	true
	pcall(function()

		StarterGui:SetCore(
			"ShiftLockEnabled",
			false
		)

	end)
	local StarterPlayer =
	game:GetService("StarterPlayer")


	StarterPlayer.EnableMouseLockOption =
	false


end

local function restoreMouseForDoors()

	UserInputService.MouseBehavior =
	OriginalMouseBehavior

	UserInputService.MouseIconEnabled =
	OriginalMouseIcon

	local StarterPlayer =
	game:GetService("StarterPlayer")


	StarterPlayer.EnableMouseLockOption =
	true

end
local Gui =
Instance.new("ScreenGui")

Gui.Name =
"SkillSelection"
Gui.IgnoreGuiInset =
true
Gui.ResetOnSpawn =
false

Gui.Parent =
Player.PlayerGui

local Background =
Instance.new("Frame")

Background.Size =
UDim2.fromScale(
	1,
	1
)

Background.BackgroundColor3 =
Color3.new(
	0,
	0,
	0
)

Background.BackgroundTransparency =
1

Background.Parent =
Gui
local Main =
Instance.new("Frame")

Main.Size =
UDim2.fromScale(
	0.85,
	0.85
)

Main.Position =
UDim2.fromScale(
	0.075,
	0.075
)

Main.BackgroundColor3 =
Color3.fromRGB(
	30,
	18,
	16
)

Main.BackgroundTransparency =
0

Main.Parent =
Background
local MainCorner =
Instance.new("UICorner")

MainCorner.CornerRadius =
UDim.new(
	0.04,
	0
)

MainCorner.Parent =
Main
local MainStroke =
Instance.new("UIStroke")


MainStroke.Thickness =
3


MainStroke.Color =
BORDER_COLOR


MainStroke.Parent =
Main
local Title =
Instance.new("TextLabel")

Title.Size =
UDim2.fromScale(
	0.35,
	0.08
)

Title.Position =
UDim2.fromScale(
	0.04,
	0.04
)

Title.BackgroundTransparency =
1

Title.Text =
"SKILLS"

Title.TextScaled =
true

Title.TextColor3 =
BORDER_COLOR

Title.FontFace =
FONT

Title.Parent =
Main




local Select =
Instance.new("TextLabel")


Select.Size =
UDim2.fromScale(
	0.42,
	0.07
)


Select.Position =
UDim2.fromScale(
	0.39,
	0.04
)


Select.BackgroundColor3 =
Color3.fromRGB(
	255,
	220,
	180
)


Select.Text =
"SELECT YOUR SKILL"


Select.TextScaled =
true


Select.TextColor3 =
Color3.fromRGB(
	50,
	30,
	20
)


Select.FontFace =
FONT


Select.Parent =
Main



local SelectCorner =
Instance.new("UICorner")


SelectCorner.CornerRadius =
UDim.new(
	0.25,
	0
)


SelectCorner.Parent =
Select





local SkillArea =
Instance.new("ScrollingFrame")

SkillArea.ScrollBarThickness =
8

SkillArea.ScrollBarImageColor3 =
BORDER_COLOR

SkillArea.AutomaticCanvasSize =
Enum.AutomaticSize.Y

SkillArea.CanvasSize =
UDim2.new(0,0,0,0)

SkillArea.ScrollingDirection =
Enum.ScrollingDirection.Y

SkillArea.ClipsDescendants =
true


SkillArea.Size =
UDim2.fromScale(
	0.55,
	0.65
)


SkillArea.Position =
UDim2.fromScale(
	0.04,
	0.2
)


SkillArea.BackgroundTransparency =
1


SkillArea.Parent =
Main





local Grid =
Instance.new("UIGridLayout")


Grid.CellSize =
UDim2.fromScale(
	0.18,
	0.18
)


Grid.CellPadding =
UDim2.fromScale(
	0.05,
	0.05
)


Grid.Parent =
SkillArea






local Divider =
Instance.new("Frame")


Divider.Size =
UDim2.fromScale(
	0.003,
	0.6
)


Divider.Position =
UDim2.fromScale(
	0.61,
	0.22
)


Divider.BackgroundColor3 =
BORDER_COLOR


Divider.Parent =
Main





local Info =
Instance.new("Frame")


Info.Size =
UDim2.fromScale(
	0.32,
	0.6
)


Info.Position =
UDim2.fromScale(
	0.66,
	0.2
)


Info.BackgroundTransparency =
1


Info.Parent =
Main






local Icon =
Instance.new("ImageLabel")


Icon.Size =
UDim2.fromScale(
	0.3,
	0.3
)


Icon.Position =
UDim2.fromScale(
	0.35,
	0
)


Icon.BackgroundTransparency =
1


Icon.ScaleType =
Enum.ScaleType.Fit


Icon.Parent =
Info





local IconCorner =
Instance.new("UICorner")


IconCorner.CornerRadius =
UDim.new(
	1,
	0
)


IconCorner.Parent =
Icon






local Name =
Instance.new("TextLabel")


Name.Size =
UDim2.fromScale(
	1,
	0.12
)


Name.Position =
UDim2.fromScale(
	0,
	0.38
)


Name.BackgroundTransparency =
1


Name.TextScaled =
true


Name.TextColor3 =
BORDER_COLOR


Name.FontFace =
FONT


Name.Parent =
Info






local Desc =
Instance.new("TextLabel")


Desc.Size =
UDim2.fromScale(
	1,
	0.25
)


Desc.Position =
UDim2.fromScale(
	0,
	0.55
)


Desc.BackgroundColor3 =
Color3.fromRGB(
	35,
	20,
	18
)


Desc.TextWrapped =
true


Desc.TextScaled =
true


Desc.TextColor3 =
Color3.new(
	1,
	1,
	1
)


Desc.Parent =
Info





local DescCorner =
Instance.new("UICorner")


DescCorner.CornerRadius =
UDim.new(
	0.08,
	0
)


DescCorner.Parent =
Desc





local Confirm =
Instance.new("TextButton")


Confirm.Size =
UDim2.fromScale(
	0.3,
	0.08
)


Confirm.Position =
UDim2.fromScale(
	0.35,
	0.85
)


Confirm.BackgroundColor3 =
Color3.fromRGB(
	255,
	220,
	180
)


Confirm.Text =
"CONFIRM SKILL"


Confirm.TextScaled =
true


Confirm.FontFace =
FONT


Confirm.Parent =
Main




local ConfirmCorner =
Instance.new("UICorner")


ConfirmCorner.CornerRadius =
UDim.new(
	0.2,
	0
)


ConfirmCorner.Parent =
Confirm





local function UpdateSkill(Data)

	Selected =
	Data


	Name.Text =
	Data.Name


	Desc.Text =
	Data.Description


	Icon.Image =
	Data.Icon

end





local SelectedStroke


for _,Data in ipairs(Skills) do


	local Button =
	Instance.new("ImageButton")


	Button.Size =
	UDim2.fromScale(
		1,
		1
	)


	Button.BackgroundColor3 =
	Color3.fromRGB(
		45,
		25,
		22
	)


	Button.Image =
	""


	Button.Parent =
	SkillArea





	local Corner =
	Instance.new("UICorner")


	Corner.CornerRadius =
	UDim.new(
		1,
		0
	)


	Corner.Parent =
	Button





	local Stroke =
	Instance.new("UIStroke")


	Stroke.Thickness =
	3


	Stroke.Color =
	BORDER_COLOR


	Stroke.Parent =
	Button





	local Image =
	Instance.new("ImageLabel")


	Image.Size =
	UDim2.fromScale(
		0.78,
		0.78
	)


	Image.Position =
	UDim2.fromScale(
		0.11,
		0.11
	)


	Image.BackgroundTransparency =
	1


	Image.Image =
	Data.Icon


	Image.ScaleType =
	Enum.ScaleType.Fit


	Image.Parent =
	Button





	local ImageCorner =
	Instance.new("UICorner")


	ImageCorner.CornerRadius =
	UDim.new(
		1,
		0
	)


	ImageCorner.Parent =
	Image
	Button.Activated:Connect(function()


		PlayClick()



		if SelectedStroke then

			SelectedStroke.Color =
			BORDER_COLOR

		end



		Stroke.Color =
		Color3.fromRGB(
			255,
			255,
			255
		)



		SelectedStroke =
		Stroke



		UpdateSkill(
			Data
		)


	end)

end






Confirm.Activated:Connect(function()

	SkillArea.ScrollingEnabled = false

	for _,obj in ipairs(Gui:GetDescendants()) do
		if obj:IsA("GuiObject") then
			obj.Active = false
			obj.Selectable = false
		end
	end

	Gui.Enabled = false


	PlayClick()



	if Selected then

		Selected.Function()

	end





	local Fade =
	TweenInfo.new(
		0.8,
		Enum.EasingStyle.Quint,
		Enum.EasingDirection.Out
	)




	for _,v in ipairs(
		Gui:GetDescendants()
	) do



		if v:IsA("Frame") then


			TweenService:Create(
				v,
				Fade,
				{
					BackgroundTransparency = 1
				}
			):Play()

		elseif v:IsA("ScrollingFrame") then

			TweenService:Create(
				v,
				Fade,
				{
					BackgroundTransparency = 1,
					ScrollBarImageTransparency = 1
				}
			):Play()


		elseif v:IsA("TextLabel")
		or v:IsA("TextButton") then



			TweenService:Create(
				v,
				Fade,
				{
					TextTransparency = 1,
					BackgroundTransparency = 1
				}
			):Play()
		elseif v:IsA("ImageLabel")
		or v:IsA("ImageButton") then



			TweenService:Create(
				v,
				Fade,
				{
					ImageTransparency = 1,
					BackgroundTransparency = 1
				}
			):Play()
		elseif v:IsA("UIStroke") then



			TweenService:Create(
				v,
				Fade,
				{
					Transparency = 1
				}
			):Play()


		end

	end

	task.wait(
		0.8
	)

	removeCustomCursor()

	if Gui then
		Gui:Destroy()
	end

	restoreMouseForDoors()

end)


local FadeIn =
TweenInfo.new(
	1,
	Enum.EasingStyle.Quint,
	Enum.EasingDirection.Out
)

Background.BackgroundTransparency =
1

TweenService:Create(
	Background,
	FadeIn,
	{
		BackgroundTransparency = 0.45
	}
):Play()

task.spawn(function()

	while Gui.Parent do

		unlockMouseForDoors()


		task.wait(
			0.05
		)


	end


end)

UpdateSkill(
	Skills[1]
)