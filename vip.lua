local player = game.Players.LocalPlayer
local sgui = Instance.new("ScreenGui", game:GetService("CoreGui"))
sgui.Name = "MatsuHub_V3_Final"

-- BOTÃO M (ABRIR/FECHAR)
local btn = Instance.new("TextButton", sgui)
btn.Size = UDim2.new(0, 50, 0, 50)
btn.Position = UDim2.new(0, 10, 0, 150)
btn.Text = "M"
btn.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
Instance.new("UICorner", btn)

-- MENU
local frame = Instance.new("Frame", sgui)
frame.Size = UDim2.new(0, 220, 0, 160)
frame.Position = UDim2.new(0.5, -110, 0.5, -80)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.Visible = true
local stroke = Instance.new("UIStroke", frame)
stroke.Color = Color3.fromRGB(255, 215, 0)
stroke.Thickness = 2
Instance.new("UICorner", frame)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "MatsuHub V3 VIP"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold

-- BOTÃO GAMEPASS (M4A1)
local gp = Instance.new("TextButton", frame)
gp.Size = UDim2.new(0.9, 0, 0, 45)
gp.Position = UDim2.new(0.05, 0, 0.35, 0)
gp.Text = "Pegar M4A1 (VIP)"
gp.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
Instance.new("UICorner", gp)

gp.MouseButton1Click:Connect(function()
    local success, err = pcall(function()
        -- Tenta o caminho principal do Prison Life
        local remote = workspace:FindFirstChild("Remote") or game:GetService("ReplicatedStorage"):FindFirstChild("Remote")
        if remote then
            remote.ItemHandler:InvokeServer(workspace.Prison_Items.giver.M4A1.ITEMPICKUP)
            gp.Text = "M4A1 PEGA!"
        else
            -- Se falhar, tenta pegar direto do chão/parede
            workspace.Remote.ItemHandler:InvokeServer(workspace.Prison_Items.giver["M4A1"].ITEMPICKUP)
            gp.Text = "M4A1 PEGA! (v2)"
        end
    end)
    if not success then gp.Text = "Erro ao pegar!" end
end)

btn.MouseButton1Click:Connect(function() frame.Visible = not frame.Visible end)
