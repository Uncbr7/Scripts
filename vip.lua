-- MatsuHub VIP Ultra Bypass
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()

-- Criar Interface
local sgui = Instance.new("ScreenGui", game:GetService("CoreGui"))
sgui.Name = "MatsuHub_UltraVIP"

-- Botão Abrir/Fechar
local btn = Instance.new("TextButton", sgui)
btn.Size = UDim2.new(0, 50, 0, 50)
btn.Position = UDim2.new(0, 10, 0, 150)
btn.Text = "M"
btn.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
Instance.new("UICorner", btn)

-- Menu
local frame = Instance.new("Frame", sgui)
frame.Size = UDim2.new(0, 240, 0, 180)
frame.Position = UDim2.new(0.5, -120, 0.5, -90)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
frame.Visible = true
local stroke = Instance.new("UIStroke", frame)
stroke.Color = Color3.fromRGB(255, 215, 0)
stroke.Thickness = 2
Instance.new("UICorner", frame)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "MatsuHub VIP ULTRA"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold

-- FUNÇÃO MESTRE: FREE GAMEPASS
local gp = Instance.new("TextButton", frame)
gp.Size = UDim2.new(0.9, 0, 0, 50)
gp.Position = UDim2.new(0.05, 0, 0.35, 0)
gp.Text = "ATIVAR TUDO (VIP)"
gp.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
Instance.new("UICorner", gp)

gp.MouseButton1Click:Connect(function()
    -- MÉTODO 1: Forçar o time SWAT (Isso libera as armas na parede)
    local teamEvent = workspace:FindFirstChild("Remote") and workspace.Remote:FindFirstChild("TeamEvent")
    if teamEvent then
        teamEvent:FireServer("Bright blue")
    end
    
    -- MÉTODO 2: Tentar puxar as armas VIP direto pro inventário
    local items = {"M4A1", "Remington 870", "AK-47"}
    for _, itemName in pairs(items) do
        pcall(function()
            local giver = workspace.Prison_Items.giver:FindFirstChild(itemName)
            if giver then
                workspace.Remote.ItemHandler:InvokeServer(giver.ITEMPICKUP)
            end
        end)
    end
    
    gp.Text = "VIP LIBERADO!"
    gp.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
end)

-- Botão Fly Superman (Já que você gostou)
local fly = Instance.new("TextButton", frame)
fly.Size = UDim2.new(0.9, 0, 0, 40)
fly.Position = UDim2.new(0.05, 0, 0.7, 0)
fly.Text = "Fly Superman (Ativar)"
fly.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
fly.TextColor3 = Color3.white
Instance.new("UICorner", fly)

fly.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MatsuHub/Scripts/main/global.lua"))()
    fly.Text = "Fly Carregado!"
end)

btn.MouseButton1Click:Connect(function() frame.Visible = not frame.Visible end)
