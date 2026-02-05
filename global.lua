local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local sgui = Instance.new("ScreenGui", game:GetService("CoreGui"))
sgui.Name = "MatsuHub_Global_Fixed"

-- BOTÃO M (ABRIR/FECHAR)
local ToggleBtn = Instance.new("TextButton", sgui)
ToggleBtn.Size = UDim2.new(0, 45, 0, 45)
ToggleBtn.Position = UDim2.new(0, 15, 0, 150)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
ToggleBtn.Text = "M"
ToggleBtn.TextColor3 = Color3.new(1, 1, 1)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 25
local corner = Instance.new("UICorner", ToggleBtn)

-- MENU PRINCIPAL
local MainFrame = Instance.new("Frame", sgui)
MainFrame.Size = UDim2.new(0, 260, 0, 220)
MainFrame.Position = UDim2.new(0.5, -130, 0.5, -110)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Visible = true
local stroke = Instance.new("UIStroke", MainFrame)
stroke.Color = Color3.fromRGB(200, 0, 0)
stroke.Thickness = 3
Instance.new("UICorner", MainFrame)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Text = "MatsuHub Superman"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.BackgroundTransparency = 1
Title.TextSize = 18

-- VARIÁVEIS DE VOO
local flying = false
local speed = 70

-- BOTÃO VOAR
local FlyBtn = Instance.new("TextButton", MainFrame)
FlyBtn.Size = UDim2.new(0.9, 0, 0, 50)
FlyBtn.Position = UDim2.new(0.05, 0, 0.25, 0)
FlyBtn.Text = "Superman Fly (E)"
FlyBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
FlyBtn.TextColor3 = Color3.new(1, 1, 1)
FlyBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", FlyBtn)

-- CONTROLE DE VELOCIDADE (MAIS/MENOS)
local SpeedLabel = Instance.new("TextLabel", MainFrame)
SpeedLabel.Size = UDim2.new(1, 0, 0, 30)
SpeedLabel.Position = UDim2.new(0, 0, 0.55, 0)
SpeedLabel.Text = "Velocidade: " .. speed
SpeedLabel.TextColor3 = Color3.new(1, 1, 1)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Font = Enum.Font.Gotham

local PlusBtn = Instance.new("TextButton", MainFrame)
PlusBtn.Size = UDim2.new(0.4, 0, 0, 40)
PlusBtn.Position = UDim2.new(0.55, 0, 0.75, 0)
PlusBtn.Text = "+"
PlusBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
PlusBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", PlusBtn)

local MinusBtn = Instance.new("TextButton", MainFrame)
MinusBtn.Size = UDim2.new(0.4, 0, 0, 40)
MinusBtn.Position = UDim2.new(0.05, 0, 0.75, 0)
MinusBtn.Text = "-"
MinusBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MinusBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", MinusBtn)

-- LÓGICA DO VOO
FlyBtn.MouseButton1Click:Connect(function()
    flying = not flying
    FlyBtn.Text = flying and "VOANDO..." or "Superman Fly (E)"
    
    local char = player.Character or player.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")
    
    if flying then
        local bv = Instance.new("BodyVelocity", root)
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bv.Name = "MatsuFly"
        
        local bg = Instance.new("BodyGyro", root)
        bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        bg.P = 9e4
        bg.Name = "MatsuGyro"
        
        task.spawn(function()
            while flying do
                root.MatsuGyro.CFrame = workspace.CurrentCamera.CFrame
                root.MatsuFly.Velocity = workspace.CurrentCamera.CFrame.LookVector * speed
                task.wait()
            end
            if root:FindFirstChild("MatsuFly") then root.MatsuFly:Destroy() end
            if root:FindFirstChild("MatsuGyro") then root.MatsuGyro:Destroy() end
        end)
    end
end)

-- AJUSTE DE VELOCIDADE
PlusBtn.MouseButton1Click:Connect(function()
    speed = speed + 20
    SpeedLabel.Text = "Velocidade: " .. speed
end)

MinusBtn.MouseButton1Click:Connect(function()
    speed = math.max(10, speed - 20)
    SpeedLabel.Text = "Velocidade: " .. speed
end)

-- TECLA E
game:GetService("UserInputService").InputBegan:Connect(function(i, g)
    if not g and i.KeyCode == Enum.KeyCode.E then FlyBtn:Activate() end
end)

ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)
