local player = game.Players.LocalPlayer
local sgui = Instance.new("ScreenGui", game:GetService("CoreGui"))
sgui.Name = "MatsuHub_Prison_Final"

-- BOTÃO M
local ToggleBtn = Instance.new("TextButton", sgui)
ToggleBtn.Size = UDim2.new(0, 45, 0, 45)
ToggleBtn.Position = UDim2.new(0, 15, 0, 150)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 85, 255)
ToggleBtn.Text = "M"
ToggleBtn.TextColor3 = Color3.new(1, 1, 1)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 25
Instance.new("UICorner", ToggleBtn)

-- MENU
local MainFrame = Instance.new("Frame", sgui)
MainFrame.Size = UDim2.new(0, 260, 0, 240)
MainFrame.Position = UDim2.new(0.5, -130, 0.5, -120)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
local stroke = Instance.new("UIStroke", MainFrame)
stroke.Color = Color3.fromRGB(0, 85, 255)
stroke.Thickness = 3
Instance.new("UICorner", MainFrame)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Text = "MatsuHub: Prison Life"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.BackgroundTransparency = 1

-- BOTÃO ESCAPAR
local EscapeBtn = Instance.new("TextButton", MainFrame)
EscapeBtn.Size = UDim2.new(0.9, 0, 0, 45)
EscapeBtn.Position = UDim2.new(0.05, 0, 0.25, 0)
EscapeBtn.Text = "Escapar da Prisão"
EscapeBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
EscapeBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", EscapeBtn)
EscapeBtn.MouseButton1Click:Connect(function()
    player.Character.HumanoidRootPart.CFrame = CFrame.new(445, 98, 2250)
end)

-- BOTÃO DELEGACIA
local PoliceBtn = Instance.new("TextButton", MainFrame)
PoliceBtn.Size = UDim2.new(0.9, 0, 0, 45)
PoliceBtn.Position = UDim2.new(0.05, 0, 0.5, 0)
PoliceBtn.Text = "Ir para Delegacia"
PoliceBtn.BackgroundColor3 = Color3.fromRGB(0, 85, 255)
PoliceBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", PoliceBtn)
PoliceBtn.MouseButton1Click:Connect(function()
    player.Character.HumanoidRootPart.CFrame = CFrame.new(825, 100, 2260)
end)

-- BOTÃO MUNIÇÃO INFINITA
local AmmoBtn = Instance.new("TextButton", MainFrame)
AmmoBtn.Size = UDim2.new(0.9, 0, 0, 45)
AmmoBtn.Position = UDim2.new(0.05, 0, 0.75, 0)
AmmoBtn.Text = "Munição Infinita"
AmmoBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
AmmoBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", AmmoBtn)
AmmoBtn.MouseButton1Click:Connect(function()
    AmmoBtn.Text = "ATIVADO"
    task.spawn(function()
        while task.wait(0.1) do
            local tool = player.Backpack:FindFirstChildOfClass("Tool") or player.Character:FindFirstChildOfClass("Tool")
            if tool and tool:FindFirstChild("GunConfig") then
                local s = require(tool.GunConfig)
                s.MaxAmmo = math.huge
                s.CurrentAmmo = math.huge
                s.StoredAmmo = math.huge
            end
        end
    end)
end)

ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)
