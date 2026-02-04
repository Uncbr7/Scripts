-- [[ MATSUHUB - FUJA DO TSUNAMI V3 (ANTI-CHEAT BYPASS) ]] --
local player = game.Players.LocalPlayer
local sgui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local MainFrame = Instance.new("Frame", sgui)
local Header = Instance.new("TextLabel", MainFrame)
local ToggleBtn = Instance.new("TextButton", sgui)

local RED, BLACK, WHITE = Color3.fromRGB(255, 0, 0), Color3.fromRGB(0, 0, 0), Color3.fromRGB(255, 255, 255)
_G.SpeedValue = 16 -- Valor global para o loop não se perder

local function applyNeon(p)
    local s = Instance.new("UIStroke", p)
    s.Color, s.Thickness, s.ApplyStrokeMode = RED, 2.5, Enum.ApplyStrokeMode.Border
end

-- Botão M (Estilo MatsuHub)
ToggleBtn.Size, ToggleBtn.Position = UDim2.new(0, 45, 0, 45), UDim2.new(0, 15, 0, 15)
ToggleBtn.BackgroundColor3, ToggleBtn.Text = BLACK, "M"
ToggleBtn.TextColor3, ToggleBtn.Font, ToggleBtn.TextSize = WHITE, Enum.Font.GothamBold, 25
ToggleBtn.ZIndex = 10; Instance.new("UICorner", ToggleBtn); applyNeon(ToggleBtn)

-- Painel Principal
MainFrame.Size, MainFrame.Position = UDim2.new(0, 260, 0, 220), UDim2.new(0.5, -130, 0.5, -110)
MainFrame.BackgroundColor3, MainFrame.Visible = BLACK, true
Instance.new("UICorner", MainFrame); applyNeon(MainFrame)

-- Cabeçalho
Header.Parent, Header.Size = MainFrame, UDim2.new(1, 0, 0, 50)
Header.BackgroundTransparency, Header.Text = 1, "MATSUHUB TSUNAMI"
Header.TextColor3, Header.Font, Header.TextSize = WHITE, Enum.Font.GothamBold, 17

-- Interface do Sapato (👟)
local SpeedLabel = Instance.new("TextLabel", MainFrame)
SpeedLabel.Size, SpeedLabel.Position = UDim2.new(1, 0, 0, 40), UDim2.new(0, 0, 0.3, 0)
SpeedLabel.BackgroundTransparency, SpeedLabel.Text = 1, "👟 VELOCIDADE: " .. _G.SpeedValue
SpeedLabel.TextColor3, SpeedLabel.Font, SpeedLabel.TextSize = WHITE, Enum.Font.GothamBold, 18

-- Botões + e -
local function createSpeedBtn(t, pos, val)
    local b = Instance.new("TextButton", MainFrame)
    b.Size, b.Position = UDim2.new(0.4, 0, 0, 50), pos
    b.BackgroundColor3, b.Text = Color3.fromRGB(20, 20, 20), t
    b.TextColor3, b.Font, b.TextSize = WHITE, Enum.Font.GothamBold, 30
    Instance.new("UICorner", b); applyNeon(b)
    b.MouseButton1Click:Connect(function()
        _G.SpeedValue = math.clamp(_G.SpeedValue + val, 16, 500)
        SpeedLabel.Text = "👟 VELOCIDADE: " .. _G.SpeedValue
    end)
end

createSpeedBtn("-", UDim2.new(0.05, 0, 0.6, 0), -20)
createSpeedBtn("+", UDim2.new(0.55, 0, 0.6, 0), 20)

-- 🔥 O SEGREDO: LOOP DE BYPASS (RODA NO RENDERSTEPPED)
game:GetService("RunService").RenderStepped:Connect(function()
    pcall(function()
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = _G.SpeedValue
        end
    end)
end)

ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)
