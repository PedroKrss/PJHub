-- PJ HUB - Jumps for Brainrots (Hub Moderno Premium + Bolinha PJ Nova e Acesa)
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- 1. Interface Principal
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PJ_BrainrotsHub"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- 2. Botão Flutuante PJ (O Design de Bolinha Acesa que Você Gostou)
local toggleBtn = Instance.new("TextButton")
toggleBtn.Name = "PJButton"
toggleBtn.Size = UDim2.new(0, 55, 0, 55)
toggleBtn.Position = UDim2.new(0.05, 0, 0.4, 0)
toggleBtn.BackgroundColor3 = Color3.fromRGB(150, 30, 240)
toggleBtn.BorderSizePixel = 0
toggleBtn.Text = "PJ"
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.TextSize = 20
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.Parent = screenGui

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 16)
btnCorner.Parent = toggleBtn

local btnGradient = Instance.new("UIGradient")
btnGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(220, 80, 255)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(160, 20, 240)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 120, 255))
})
btnGradient.Rotation = 45
btnGradient.Parent = toggleBtn

local btnStroke = Instance.new("UIStroke")
btnStroke.Color = Color3.fromRGB(255, 200, 255)
btnStroke.Thickness = 2.5
btnStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
btnStroke.Parent = toggleBtn

-- Animação Neon de Pulso Luminoso no Botão PJ
task.spawn(function()
	local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
	local tweenStroke = TweenService:Create(btnStroke, tweenInfo, {Color = Color3.fromRGB(255, 255, 255)})
	local tweenGradient = TweenService:Create(btnGradient, tweenInfo, {Rotation = 225})
	tweenStroke:Play()
	tweenGradient:Play()
end)

-- 3. Painel Principal (Hub Moderno)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 330, 0, 320)
mainFrame.Position = UDim2.new(0.5, -165, 0.5, -160)
mainFrame.BackgroundColor3 = Color3.fromRGB(13, 11, 20)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = true
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 16)
frameCorner.Parent = mainFrame

-- Borda Neon do Painel
local frameStroke = Instance.new("UIStroke")
frameStroke.Color = Color3.fromRGB(140, 40, 220)
frameStroke.Thickness = 2
frameStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
frameStroke.Parent = mainFrame

task.spawn(function()
	local tweenInfo = TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
	local tween = TweenService:Create(frameStroke, tweenInfo, {Color = Color3.fromRGB(210, 90, 255)})
	tween:Play()
end)

-- 4. Cabeçalho Moderno com Linha Neon e Gradiente no Título
local headerFrame = Instance.new("Frame")
headerFrame.Name = "HeaderFrame"
headerFrame.Size = UDim2.new(1, 0, 0, 48)
headerFrame.BackgroundColor3 = Color3.fromRGB(22, 17, 34)
headerFrame.BorderSizePixel = 0
headerFrame.Parent = mainFrame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 16)
headerCorner.Parent = headerFrame

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, 0, 1, 0)
title.BackgroundTransparency = 1
title.Text = "PJHub"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 22
title.Font = Enum.Font.GothamBold
title.Parent = headerFrame

local titleGradient = Instance.new("UIGradient")
titleGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 130, 255))
})
titleGradient.Parent = title

-- Linha Neon Decorativa sob o Título
local titleLine = Instance.new("Frame")
titleLine.Size = UDim2.new(0.8, 0, 0, 2)
titleLine.Position = UDim2.new(0.1, 0, 1, -2)
titleLine.BackgroundColor3 = Color3.fromRGB(180, 60, 255)
titleLine.BorderSizePixel = 0
titleLine.Parent = headerFrame

local lineCorner = Instance.new("UICorner")
lineCorner.CornerRadius = UDim.new(1, 0)
lineCorner.Parent = titleLine

task.spawn(function()
	local tweenInfo = TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
	local tweenLine = TweenService:Create(titleLine, tweenInfo, {BackgroundColor3 = Color3.fromRGB(255, 140, 255)})
	tweenLine:Play()
end)

-- 5. Função Arrastável (Drag)
local function makeDraggable(guiObject)
	local dragging, dragInput, dragStart, startPos

	guiObject.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = guiObject.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	guiObject.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			guiObject.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
end

makeDraggable(toggleBtn)
makeDraggable(mainFrame)

toggleBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = not mainFrame.Visible
end)

-- 6. Exibição do Melhor Ovo
local eggInfoLabel = Instance.new("TextLabel")
eggInfoLabel.Size = UDim2.new(0.9, 0, 0.11, 0)
eggInfoLabel.Position = UDim2.new(0.05, 0, 0.20, 0)
eggInfoLabel.BackgroundColor3 = Color3.fromRGB(22, 18, 32)
eggInfoLabel.BorderSizePixel = 0
eggInfoLabel.TextColor3 = Color3.fromRGB(240, 240, 255)
eggInfoLabel.Text = "Melhor Ovo: Ovo Lendário do Topo (Nível 21)"
eggInfoLabel.TextSize = 11
eggInfoLabel.Font = Enum.Font.GothamMedium
eggInfoLabel.Parent = mainFrame

local eggCorner = Instance.new("UICorner")
eggCorner.CornerRadius = UDim.new(0, 8)
eggCorner.Parent = eggInfoLabel

local eggStroke = Instance.new("UIStroke")
eggStroke.Color = Color3.fromRGB(80, 40, 120)
eggStroke.Thickness = 1
eggStroke.Parent = eggInfoLabel

-- 7. Botão Auto Go (Subida Ilimitada)
local autoGoBtn = Instance.new("TextButton")
autoGoBtn.Size = UDim2.new(0.9, 0, 0.14, 0)
autoGoBtn.Position = UDim2.new(0.05, 0, 0.35, 0)
autoGoBtn.BackgroundColor3 = Color3.fromRGB(130, 20, 200)
autoGoBtn.BorderSizePixel = 0
autoGoBtn.Text = "Auto Go (Ligar Subida)"
autoGoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
autoGoBtn.TextSize = 13
autoGoBtn.Font = Enum.Font.GothamBold
autoGoBtn.Parent = mainFrame

local goCorner = Instance.new("UICorner")
goCorner.CornerRadius = UDim.new(0, 8)
goCorner.Parent = autoGoBtn

local goStroke = Instance.new("UIStroke")
goStroke.Color = Color3.fromRGB(180, 50, 255)
goStroke.Thickness = 1.5
goStroke.Parent = autoGoBtn

local isGoing = false

autoGoBtn.MouseButton1Click:Connect(function()
	local character = player.Character
	if not character then return end
	
	local hrp = character:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	if isGoing then
		isGoing = false
		autoGoBtn.Text = "Auto Go (Ligar Subida)"
		autoGoBtn.BackgroundColor3 = Color3.fromRGB(130, 20, 200)
		goStroke.Color = Color3.fromRGB(180, 50, 255)
		
		local oldBv = hrp:FindFirstChild("PJ_AutoGoVelocity")
		if oldBv then oldBv:Destroy() end
	else
		isGoing = true
		autoGoBtn.Text = "PARAR SUBIDA"
		autoGoBtn.BackgroundColor3 = Color3.fromRGB(210, 35, 60)
		goStroke.Color = Color3.fromRGB(255, 80, 100)

		local oldBv = hrp:FindFirstChild("PJ_AutoGoVelocity")
		if oldBv then oldBv:Destroy() end

		local bv = Instance.new("BodyVelocity")
		bv.Name = "PJ_AutoGoVelocity"
		bv.MaxForce = Vector3.new(1e6, 1e6, 1e6)
		bv.Velocity = Vector3.new(0, 350, 0)
		bv.Parent = hrp

		task.spawn(function()
			while isGoing and hrp do
				task.wait(0.1)
			end
			
			if bv then bv:Destroy() end
			isGoing = false
			autoGoBtn.Text = "Auto Go (Ligar Subida)"
			autoGoBtn.BackgroundColor3 = Color3.fromRGB(130, 20, 200)
			goStroke.Color = Color3.fromRGB(180, 50, 255)
		end)
	end
end)

-- 8. Fast Jump Estável (Trava X/Z + Gravidade Aumentada)
local fastLandBtn = Instance.new("TextButton")
fastLandBtn.Size = UDim2.new(0.9, 0, 0.14, 0)
fastLandBtn.Position = UDim2.new(0.05, 0, 0.53, 0)
fastLandBtn.BackgroundColor3 = Color3.fromRGB(60, 20, 150)
fastLandBtn.BorderSizePixel = 0
fastLandBtn.Text = "Fast Jump (Sem Deslizar)"
fastLandBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
fastLandBtn.TextSize = 13
fastLandBtn.Font = Enum.Font.GothamBold
fastLandBtn.Parent = mainFrame

local fastLandCorner = Instance.new("UICorner")
fastLandCorner.CornerRadius = UDim.new(0, 8)
fastLandCorner.Parent = fastLandBtn

local fastLandStroke = Instance.new("UIStroke")
fastLandStroke.Color = Color3.fromRGB(140, 40, 220)
fastLandStroke.Thickness = 1.5
fastLandStroke.Parent = fastLandBtn

local isFastLanding = false

fastLandBtn.MouseButton1Click:Connect(function()
	if isFastLanding then
		isFastLanding = false
		fastLandBtn.Text = "Fast Jump (Sem Deslizar)"
		fastLandBtn.BackgroundColor3 = Color3.fromRGB(60, 20, 150)
		fastLandStroke.Color = Color3.fromRGB(140, 40, 220)
		Workspace.Gravity = 196.2
	else
		isFastLanding = true
		fastLandBtn.Text = "FAST JUMP ATIVO"
		fastLandBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 90)
		fastLandStroke.Color = Color3.fromRGB(80, 255, 160)
		
		Workspace.Gravity = 600

		task.spawn(function()
			while isFastLanding do
				local character = player.Character
				local hrp = character and character:FindFirstChild("HumanoidRootPart")
				
				if hrp then
					hrp.AssemblyLinearVelocity = Vector3.new(0, hrp.AssemblyLinearVelocity.Y, 0)
				end
				task.wait(0.02)
			end
			Workspace.Gravity = 196.2
		end)
	end
end)

-- 9. Setinha de Redimensionar no Canto Inferior Direito
local resizeHandle = Instance.new("TextButton")
resizeHandle.Name = "ResizeHandle"
resizeHandle.Size = UDim2.new(0, 26, 0, 26)
resizeHandle.Position = UDim2.new(1, -26, 1, -26)
resizeHandle.BackgroundTransparency = 1
resizeHandle.Text = "↘"
resizeHandle.TextColor3 = Color3.fromRGB(220, 100, 255)
resizeHandle.TextSize = 18
resizeHandle.Font = Enum.Font.GothamBold
resizeHandle.Parent = mainFrame

local isResizing = false
local resizeStartPos, startFrameSize

resizeHandle.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		isResizing = true
		resizeStartPos = input.Position
		startFrameSize = mainFrame.AbsoluteSize
		
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				isResizing = false
			end
		end)
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if isResizing and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - resizeStartPos
		
		local newWidth = math.clamp(startFrameSize.X + delta.X, 220, 450)
		local newHeight = math.clamp(startFrameSize.Y + delta.Y, 200, 420)
		
		mainFrame.Size = UDim2.new(0, newWidth, 0, newHeight)
	end
end)

-- 10. Sistema Anti-AFK
task.spawn(function()
	while true do
		task.wait(60)
		VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
		task.wait(0.1)
		VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
	end
end)
