local player = game.Players.LocalPlayer
local sgui = Instance.new("ScreenGui", game:GetService("CoreGui"))
sgui.Name = "MatsuHub_Tsunami_Final"

-- 1. BOTÃO M (ABRIR/FECHAR)
local ToggleBtn = Instance.new("TextButton", sgui)
ToggleBtn.Size = UDim2.new(0, 45, 0, 45)
ToggleBtn.Position = UDim2.new(0, 15, 0, 150)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 85, 255)
ToggleBtn.Text = "M"
ToggleBtn.TextColor3 = Color3.new(1, 1, 1)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 25
Instance.new("UICorner", ToggleBtn)

-- 2. MENU PRINCIPAL (PRETO COM BORDA AZUL)
local MainFrame = Instance.new("Frame", sgui)
MainFrame.Size = UDim2.new(0, 280, 0, 180)
MainFrame.Position = UDim2.new(0.5, -140, 0.5, -90)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Visible = true 

local stroke = Instance.new("UIStroke", MainFrame)
stroke.Color = Color3.fromRGB(0, 85, 255)
stroke.Thickness = 3
Instance.new("UICorner", MainFrame)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Text = "MatsuHub Tsunami"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.BackgroundTransparency = 1

-- 3. BOTÃO VIP (ALTERADO PARA "Vip Grátis")
local VipBtn = Instance.new("TextButton", MainFrame)
VipBtn.Size = UDim2.new(0.9, 0, 0, 60)
VipBtn.Position = UDim2.new(0.05, 0, 0.45, 0)
VipBtn.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
VipBtn.Text = "Vip Grátis"
VipBtn.TextColor3 = Color3.new(0, 0, 0)
VipBtn.Font = Enum.Font.GothamBold
VipBtn.TextSize = 18
Instance.new("UICorner", VipBtn)

VipBtn.MouseButton1Click:Connect(function()
    VipBtn.Text = "Vip Liberado!" -- Texto alterado conforme pedido
    pcall(function()
        -- Atravessa as paredes sem sumir com elas
        for _, v in pairs(workspace:GetDescendants()) do
            if v.Name:lower():find("vip") and v:IsA("BasePart") then
                v.CanCollide = false
                v.Transparency = 0.5
            end
        end
    end)
end)

-- 4. FUNÇÃO DE FECHAR/ABRIR COM O "M"
ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)
