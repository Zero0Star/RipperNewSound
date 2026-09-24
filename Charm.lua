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
		Description="不选择任何魅力。\n以普通状态开始游戏。",
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
		Icon="rbxassetid://134424884048913",
		Description="当你受伤时，你将会得到大幅度的速度加成。",
		Function=function()

			local TextChatService =
			game:GetService("TextChatService")

			TextChatService.TextChannels.RBXGeneral:SendAsync(
				"Selected Adrenaline"
			)

		end
	},


	{
		Name="护盾",
		Icon="rbxassetid://11322093465",
		Description="你的耐力值将会消失，增加护盾血量。",
		Function=function()

			local TextChatService =
			game:GetService("TextChatService")

			TextChatService.TextChannels.RBXGeneral:SendAsync(
				"Selected Shield"
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

for i=1,7 do

	table.insert(
		Skills,
		{
			Name="未解锁",
			Icon="rbxassetid://15117261700",
			Description="???",
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
	1

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
Instance.new("Frame")


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

	Gui:Destroy()

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