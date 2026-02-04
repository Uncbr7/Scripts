-- [[ MATSUHUB - VIP BYPASS FINAL ]] --
local player = game.Players.LocalPlayer
local sgui = Instance.new("ScreenGui", game:GetService("CoreGui"))
sgui.Name = "MatsuHubV5"

-- Interface Super Limpa
local MainFrame = Instance.new("Frame", sgui)
MainFrame.Size = UDim2.new(0, 200, 0, 100)
MainFrame.Position = UDim2.new(0.5, -100, 0.5, -50)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Instance.new("UICorner", MainFrame)

local btn = Instance.new("TextButton", MainFrame)
btn.Size = UDim2.new(0.9, 0, 0, 50)
btn.Position = UDim2.new(0.05, 0, 0.25, 0)
btn.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
btn.Text = "LIBERAR TUDO VIP"
btn.Font = Enum.Font.GothamBold
btn.TextSize = 14
Instance.new("UICorner", btn)

-- Função que realmente tenta "quebrar" o bloqueio do jogo
btn.MouseButton1Click:Connect(function()
    btn.Text = "PROCESSANDO..."
    pcall(function()
        -- 1. Tenta enganar o servidor sobre o Gamepass
        local old; old = hookmetamethod(game, "__namecall", function(self, ...)
            local method = getnamecallmethod()
            local args = {...}
            if method == "UserOwnsGamePassAsync" or method == "PlayerOwnsAsset" then
                return true
            end
            return old(self, ...)
        end)
        
        -- 2. Abre fisicamente as portas VIP do mapa
        for _, v in pairs(workspace:GetDescendants()) do
            if v.Name:lower():find("vip") then
                if v:IsA("BasePart") then
                    v.CanCollide = false
                    v.Transparency = 0.5
                elseif v:IsA("Model") then
                    v:Destroy() -- Remove a barreira se for modelo
                end
            end
        end
    end)
    btn.Text = "VIP LIBERADO! 👑"
end)
