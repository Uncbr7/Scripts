local player = game.Players.LocalPlayer
local sgui = Instance.new("ScreenGui", game:GetService("CoreGui"))
sgui.Name = "MatsuHub_99_Noites"

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

-- MENU PRETO
local MainFrame = Instance.new("Frame", sgui)
MainFrame.Size = UDim2.new(0, 260, 0, 140)
MainFrame.Position = UDim2.new(0.5, -130, 0.5, -70)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
local stroke = Instance.new("UIStroke", MainFrame)
stroke.Color = Color3.fromRGB(0, 85, 255)
stroke.Thickness = 2
Instance.new("UICorner", MainFrame)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "MatsuHub: 99 Noites"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.BackgroundTransparency = 1

-- BOTÃO GOD MODE
local GodBtn = Instance.new("TextButton", MainFrame)
GodBtn.Size = UDim2.new(0.9, 0, 0, 50)
GodBtn.Position = UDim2.new(0.05, 0, 0.45, 0)
GodBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
GodBtn.Text = "Ativar God Mode"
GodBtn.TextColor3 = Color3.new(1, 1, 1)
GodBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", GodBtn)

GodBtn.MouseButton1Click:Connect(function()
    GodBtn.Text = "GOD MODE ATIVO!"
    GodBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
    task.spawn(function()
        while task.wait() do
            pcall(function()
                player.Character.Humanoid.Health = player.Character.Humanoid.MaxHealth
            end)
        end
    end)
end)

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)
