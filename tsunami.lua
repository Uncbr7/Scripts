-- [[ MATSUHUB TSUNAMI - BLUE EDITION ]] --
local player = game.Players.LocalPlayer
local sgui = Instance.new("ScreenGui", game:GetService("CoreGui"))
sgui.Name = "MatsuHubBlue"

local MainFrame = Instance.new("Frame", sgui)
local Header = Instance.new("TextLabel", MainFrame)
local ToggleBtn = Instance.new("TextButton", sgui)

-- Definição de Cores: TUDO AZUL
local BLUE = Color3.fromRGB(0, 85, 255)
local DARK_BLUE = Color3.fromRGB(0, 40, 120)
local WHITE = Color3.fromRGB(255, 255, 255)

local function applyNeon(p)
    local s = Instance.new("UIStroke", p)
    s.Color, s.Thickness, s.ApplyStrokeMode = WHITE, 2, Enum.ApplyStrokeMode.Border
end

-- Botão M (Azul com fonte Branca)
ToggleBtn.Size, ToggleBtn.Position = UDim2.new(0, 45, 0, 45), UDim2.new(0, 15, 0, 60)
ToggleBtn.BackgroundColor3, ToggleBtn.Text = BLUE, "M"
ToggleBtn.TextColor3, ToggleBtn.Font, ToggleBtn.TextSize = WHITE, Enum.Font.GothamBold, 25
ToggleBtn.ZIndex = 100
Instance.new("UICorner", ToggleBtn); applyNeon(ToggleBtn)

-- Painel Principal (Azul sólido para matar o cinza)
MainFrame.Size, MainFrame.Position = UDim2.new(0, 260, 0, 180), UDim2.new(0.5, -130, 0.5, -90)
MainFrame.BackgroundColor3 = BLUE
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true -- Agora você pode arrastar se quiser
MainFrame.Visible = true
MainFrame.ZIndex = 5
Instance.new("UICorner", MainFrame); applyNeon(MainFrame)

-- Título
Header.Parent, Header.Size = MainFrame, UDim2.new(1, 0, 0, 50)
Header.BackgroundTransparency = 1
Header.Text = "MatsuHub Tsunami"
Header.TextColor3, Header.Font, Header.TextSize = WHITE, Enum.Font.GothamBold, 18
Header.ZIndex = 6

local function createBtn(t, pos, f)
    local b = Instance.new("TextButton", MainFrame)
    b.Size, b.Position = UDim2.new(0.9, 0, 0, 45), pos
    b.BackgroundColor3, b.Text = DARK_BLUE, t
    b.TextColor3, b.Font, b.TextSize = WHITE, Enum.Font.GothamBold, 14
    b.ZIndex = 7
    Instance.new("UICorner", b); applyNeon(b)
    b.MouseButton1Click:Connect(function() f(b) end)
end

-- 1. LIBERAR VIPS
createBtn("Liberar Vips", UDim2.new(0.05, 0, 0.35, 0), function(b)
    b.Text = "VIP ATIVADO"
    task.spawn(function()
        while true do
            for _, v in pairs(workspace:GetDescendants()) do
                if (v.Name:lower():find("vip") or v.Name:lower():find("pass")) and v:IsA("BasePart") then
                    v.CanCollide, v.Transparency = false, 0.6
                end
            end
            task.wait(3)
        end
    end)
end)

-- 2. AUTO LUCKY
createBtn("Auto Lucky", UDim2.new(0.05, 0, 0.65, 0), function(b)
    b.Text = "LUCKY ATIVO"
    task.spawn(function()
        while true do
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("ClickDetector") or v:IsA("ProximityPrompt") then
                    local n = v.Parent.Name:lower()
                    if n:find("lucky") or n:find("sorte") or n:find("machine") then
                        if v:IsA("ClickDetector") then fireclickdetector(v)
                        else fireproximityprompt(v) end
                    end
                end
            end
            task.wait(0.1)
        end
    end)
end)

ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)
