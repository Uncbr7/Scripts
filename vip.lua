local player = game.Players.LocalPlayer
local sgui = Instance.new("ScreenGui", game:GetService("CoreGui"))
sgui.Name = "MatsuHub_V3"

-- BOTÃO M (ABRIR/FECHAR)
local ToggleBtn = Instance.new("TextButton", sgui)
ToggleBtn.Size = UDim2.new(0, 45, 0, 45)
ToggleBtn.Position = UDim2.new(0, 15, 0, 150)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
ToggleBtn.Text = "M"
ToggleBtn.TextColor3 = Color3.new(0, 0, 0)
ToggleBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", ToggleBtn)

-- MENU PRINCIPAL
local MainFrame = Instance.new("Frame", sgui)
MainFrame.Size = UDim2.new(0, 260, 0, 220)
MainFrame.Position = UDim2.new(0.5, -130, 0.5, -110)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
local stroke = Instance.new("UIStroke", MainFrame)
stroke.Color = Color3.fromRGB(255, 215, 0)
stroke.Thickness = 3
Instance.new("UICorner", MainFrame)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Text = "MatsuHub V3: VIP"
Title.TextColor3 = Color3.fromRGB(255, 215, 0)
Title.Font = Enum.Font.GothamBold
Title.BackgroundTransparency = 1

-- BOTÃO FREE GAMEPASS (FORÇADO)
local GpBtn = Instance.new("TextButton", MainFrame)
GpBtn.Size = UDim2.new(0.9, 0, 0, 60)
GpBtn.Position = UDim2.new(0.05, 0, 0.3, 0)
GpBtn.Text = "LIBERAR TUDO (VIP)"
GpBtn.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
GpBtn.TextColor3 = Color3.new(0, 0, 0)
GpBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", GpBtn)

GpBtn.MouseButton1Click:Connect(function()
    -- Método 1: Workspace Giver
    pcall(function()
        local m4 = workspace.Prison_Items.giver:FindFirstChild("M4A1")
        if m4 then
            workspace.Remote.ItemHandler:InvokeServer(m4.ITEMPICKUP)
        end
    end)
    
    -- Método 2: Bypass de Team SWAT
    pcall(function()
        workspace.Remote.TeamEvent:FireServer("Bright blue")
    end)
    
    -- Método 3: Forçar ferramenta no Backpack
    pcall(function()
        if not player.Backpack:FindFirstChild("M4A1") then
            local gear = game:GetService("InsertService"):LoadAsset(1012170):GetChildren()[1]
            gear.Parent = player.Backpack
        end
    end)

    GpBtn.Text = "VIP ATIVADO!"
    GpBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 127)
end)

-- BOTÃO SUPER FLY (E)
local FlyBtn = Instance.new("TextButton", MainFrame)
FlyBtn.Size = UDim2.new(0.9, 0, 0, 45)
FlyBtn.Position = UDim2.new(0.05, 0, 0.7, 0)
FlyBtn.Text = "Voo Superman (E)"
FlyBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
FlyBtn.TextColor3 = Color3.white
Instance.new("UICorner", FlyBtn)

ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)
