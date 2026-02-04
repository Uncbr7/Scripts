-- [[ MATSUHUB - FUJA DO TSUNAMI VÁ MAIS UM ]] --
local player = game.Players.LocalPlayer
local sgui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local MainFrame = Instance.new("Frame", sgui)
local Header = Instance.new("TextLabel", MainFrame)
local ToggleBtn = Instance.new("TextButton", sgui)

local RED, BLACK, WHITE = Color3.fromRGB(255, 0, 0), Color3.fromRGB(0, 0, 0), Color3.fromRGB(255, 255, 255)

local function applyNeon(p)
    local s = Instance.new("UIStroke", p)
    s.Color, s.Thickness, s.ApplyStrokeMode = RED, 2.5, Enum.ApplyStrokeMode.Border
end

-- Botão M
ToggleBtn.Size, ToggleBtn.Position = UDim2.new(0, 45, 0, 45), UDim2.new(0, 15, 0, 15)
ToggleBtn.BackgroundColor3, ToggleBtn.Text = BLACK, "M"
ToggleBtn.TextColor3, ToggleBtn.Font, ToggleBtn.TextSize = WHITE, Enum.Font.GothamBold, 25
ToggleBtn.ZIndex = 10; Instance.new("UICorner", ToggleBtn); applyNeon(ToggleBtn)

-- Painel
MainFrame.Size, MainFrame.Position = UDim2.new(0, 260, 0, 190), UDim2.new(0.5, -130, 0.5, -95)
MainFrame.BackgroundColor3, MainFrame.Visible = BLACK, true
Instance.new("UICorner", MainFrame); applyNeon(MainFrame)

-- Título
Header.Parent, Header.Size = MainFrame, UDim2.new(1, 0, 0, 50)
Header.BackgroundTransparency, Header.Text = 1, "MATSUHUB TSUNAMI"
Header.TextColor3, Header.Font, Header.TextSize = WHITE, Enum.Font.GothamBold, 17

local function createBtn(t, pos, f)
    local b = Instance.new("TextButton", MainFrame)
    b.Size, b.Position = UDim2.new(0.9, 0, 0, 45), pos
    b.BackgroundColor3, b.Text = Color3.fromRGB(15, 15, 15), t
    b.TextColor3, b.Font, b.TextSize = WHITE, Enum.Font.GothamBold, 14
    Instance.new("UICorner", b); applyNeon(b)
    b.MouseButton1Click:Connect(function() f(b) end)
end

ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

-- Botão VIP
createBtn("Liberar Vips", UDim2.new(0.05, 0, 0.35, 0), function(b)
    b.Text, b.TextColor3 = "LIBERADO!", RED
    task.spawn(function()
        while true do
            for _, v in pairs(workspace:GetDescendants()) do
                if (v.Name:lower():find("vip") or v.Name:lower():find("pass")) and v:IsA("BasePart") then
                    v.CanCollide, v.Transparency = false, 0.6
                end
            end
            task.wait(2)
        end
    end)
end)

-- Botão VÁ MAIS UM (Teleporte por buracos)
createBtn("Vá mais um", UDim2.new(0.05, 0, 0.65, 0), function(b)
    b.Text, b.TextColor3 = "ATIVO!", RED
    
    task.spawn(function()
        -- Procura os pontos de vitória ou partes numeradas
        local targetParts = {}
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") and (v.Name:find("Win") or v.Name:find("End") or v.Name:find("Goal")) then
                table.insert(targetParts, v)
            end
        end

        -- Se achar partes, vai pra elas, senão tenta os checkpoints
        if #targetParts > 0 then
            for _, part in pairs(targetParts) do
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    player.Character.HumanoidRootPart.CFrame = part.CFrame + Vector3.new(0, 3, 0)
                    task.wait(0.3)
                end
            end
        end
        
        task.wait(1)
        b.Text, b.TextColor3 = "Vá mais um", WHITE
    end)
end)
