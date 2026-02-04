-- [[ MATSUHUB TSUNAMI - FIXED VERSION ]] --
local player = game.Players.LocalPlayer
local sgui = Instance.new("ScreenGui", game:GetService("CoreGui"))
sgui.Name = "MatsuHubUI"

local MainFrame = Instance.new("Frame", sgui)
local Header = Instance.new("TextLabel", MainFrame)
local ToggleBtn = Instance.new("TextButton", sgui)

local RED, BLACK, WHITE = Color3.fromRGB(255, 0, 0), Color3.fromRGB(0, 0, 0), Color3.fromRGB(255, 255, 255)

local function applyNeon(p)
    local s = Instance.new("UIStroke", p)
    s.Color, s.Thickness, s.ApplyStrokeMode = RED, 2.5, Enum.ApplyStrokeMode.Border
end

-- Botão M (Consertado para ficar visível)
ToggleBtn.Size, ToggleBtn.Position = UDim2.new(0, 45, 0, 45), UDim2.new(0, 15, 0, 60)
ToggleBtn.BackgroundColor3, ToggleBtn.Text = BLACK, "M"
ToggleBtn.TextColor3, ToggleBtn.Font, ToggleBtn.TextSize = WHITE, Enum.Font.GothamBold, 25
ToggleBtn.ZIndex = 100
Instance.new("UICorner", ToggleBtn); applyNeon(ToggleBtn)

-- Painel Principal (Ajustado para não ficar cinza)
MainFrame.Size, MainFrame.Position = UDim2.new(0, 260, 0, 200), UDim2.new(0.5, -130, 0.5, -100)
MainFrame.BackgroundColor3 = BLACK
MainFrame.BorderSizePixel = 0
MainFrame.Visible = true
MainFrame.ZIndex = 5
Instance.new("UICorner", MainFrame); applyNeon(MainFrame)

-- Título
Header.Parent, Header.Size = MainFrame, UDim2.new(1, 0, 0, 50)
Header.BackgroundTransparency, Header.Text = 1, "MatsuHub Tsunami"
Header.TextColor3, Header.Font, Header.TextSize = WHITE, Enum.Font.GothamBold, 18
Header.ZIndex = 6

local function createBtn(t, pos, f)
    local b = Instance.new("TextButton", MainFrame)
    b.Size, b.Position = UDim2.new(0.9, 0, 0, 45), pos
    b.BackgroundColor3, b.Text = Color3.fromRGB(20, 20, 20), t
    b.TextColor3, b.Font, b.TextSize = WHITE, Enum.Font.GothamBold, 14
    b.ZIndex = 7
    Instance.new("UICorner", b); applyNeon(b)
    b.MouseButton1Click:Connect(function() f(b) end)
end

-- Funcionalidades
createBtn("Liberar Vips", UDim2.new(0.05, 0, 0.3, 0), function(b)
    b.Text = "VIP ATIVO!"
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

createBtn("Farmar Sorte", UDim2.new(0.05, 0, 0.6, 0), function(b)
    b.Text = "SORTE ATIVA!"
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
