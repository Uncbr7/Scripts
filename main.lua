local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local sgui = Instance.new("ScreenGui", game:GetService("CoreGui"))
sgui.Name = "MatsuHub_Prison_Pro"

-- 1. BOTÃO M
local ToggleBtn = Instance.new("TextButton", sgui)
ToggleBtn.Size = UDim2.new(0, 45, 0, 45)
ToggleBtn.Position = UDim2.new(0, 15, 0, 150)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 85, 255)
ToggleBtn.Text = "M"
ToggleBtn.TextColor3 = Color3.new(1, 1, 1)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 25
Instance.new("UICorner", ToggleBtn)

-- 2. MENU PRINCIPAL
local MainFrame = Instance.new("Frame", sgui)
MainFrame.Size = UDim2.new(0, 280, 0, 280)
MainFrame.Position = UDim2.new(0.5, -140, 0.5, -140)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
local stroke = Instance.new("UIStroke", MainFrame)
stroke.Color = Color3.fromRGB(0, 85, 255)
stroke.Thickness = 3
Instance.new("UICorner", MainFrame)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "MatsuHub: Prison Life"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.BackgroundTransparency = 1

-- 3. FUNÇÃO ESCAPAR (TP PARA FORA)
local EscapeBtn = Instance.new("TextButton", MainFrame)
EscapeBtn.Size = UDim2.new(0.9, 0, 0, 45)
EscapeBtn.Position = UDim2.new(0.05, 0, 0.2, 0)
EscapeBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
EscapeBtn.Text = "Escapar da Prisão"
EscapeBtn.TextColor3 = Color3.new(1, 1, 1)
EscapeBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", EscapeBtn)

EscapeBtn.MouseButton1Click:Connect(function()
    player.Character.HumanoidRootPart.CFrame = CFrame.new(445, 98, 2250)
end)

-- 4. FUNÇÃO TELEPORTAR DELEGACIA (POLICE)
local PoliceBtn = Instance.new("TextButton", MainFrame)
PoliceBtn.Size = UDim2.new(0.9, 0, 0, 45)
PoliceBtn.Position = UDim2.new(0.05, 0, 0.4, 0)
PoliceBtn.BackgroundColor3 = Color3.fromRGB(0, 85, 255)
PoliceBtn.Text = "Teleportar Delegacia"
PoliceBtn.TextColor3 = Color3.new(1, 1, 1)
PoliceBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", PoliceBtn)

PoliceBtn.MouseButton1Click:Connect(function()
    player.Character.HumanoidRootPart.CFrame = CFrame.new(825, 100, 2260)
end)

-- 5. FUNÇÃO MUNIÇÃO INFINITA
local AmmoBtn = Instance.new("TextButton", MainFrame)
AmmoBtn.Size = UDim2.new(0.9, 0, 0, 45)
AmmoBtn.Position = UDim2.new(0.05, 0, 0.6, 0)
AmmoBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
AmmoBtn.Text = "Munição Infinita"
AmmoBtn.TextColor3 = Color3.new(1, 1, 1)
AmmoBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", AmmoBtn)

AmmoBtn.MouseButton1Click:Connect(function()
    AmmoBtn.Text = "MUNIÇÃO ATIVA!"
    AmmoBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    task.spawn(function()
        while task.wait(0.5) do
            pcall(function()
                for _, v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
                    if v:IsA("Tool") and v:FindFirstChild("GunConfig") then
                        local gun = require(v.GunConfig)
                        gun.MaxAmmo = math.huge
                        gun.CurrentAmmo = math.huge
                        gun.StoredAmmo = math.huge
                    end
                end
            end)
        end
    end)
end)

-- FUNÇÃO DO BOTÃO M
ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)
