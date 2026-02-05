-- Esperar o jogo carregar para não dar erro de "Remote"
repeat task.wait() until game:IsLoaded()

local player = game.Players.LocalPlayer
local sgui = Instance.new("ScreenGui", game:GetService("CoreGui"))
sgui.Name = "MatsuHub_V3_Final"

-- BOTAO M
local btn = Instance.new("TextButton", sgui)
btn.Size = UDim2.new(0, 50, 0, 50)
btn.Position = UDim2.new(0, 10, 0, 150)
btn.Text = "M"
btn.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
btn.ZIndex = 10
Instance.new("UICorner", btn)

-- MENU
local frame = Instance.new("Frame", sgui)
frame.Size = UDim2.new(0, 220, 0, 150)
frame.Position = UDim2.new(0.5, -110, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.Visible = true
local stroke = Instance.new("UIStroke", frame)
stroke.Color = Color3.fromRGB(255, 215, 0)
stroke.Thickness = 2
Instance.new("UICorner", frame)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "MatsuHub VIP V3"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold

-- BOTAO FREE GAMEPASS
local gp = Instance.new("TextButton", frame)
gp.Size = UDim2.new(0.9, 0, 0, 45)
gp.Position = UDim2.new(0.05, 0, 0.4, 0)
gp.Text = "FREE GAMEPASS"
gp.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
Instance.new("UICorner", gp)

gp.MouseButton1Click:Connect(function()
    local remote = workspace:FindFirstChild("Remote")
    if remote and remote:FindFirstChild("ItemHandler") then
        remote.ItemHandler:InvokeServer(workspace.Prison_Items.giver.M4A1.ITEMPICKUP)
        gp.Text = "M4A1 PEGA!"
        gp.BackgroundColor3 = Color3.fromRGB(0, 255, 127)
    else
        gp.Text = "Erro: Tente de novo"
    end
end)

btn.MouseButton1Click:Connect(function() frame.Visible = not frame.Visible end)

print("MatsuHub V3 Carregado com Sucesso!")
