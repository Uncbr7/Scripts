-- [[ MATSUHUB TSUNAMI - SUBTERRÂNEO ]] --
local player = game.Players.LocalPlayer
local sgui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local MainFrame = Instance.new("Frame", sgui)
local Header = Instance.new("TextLabel", MainFrame)
local ToggleBtn = Instance.new("TextButton", sgui)

local RED, BLACK, WHITE = Color3.fromRGB(255, 0, 0), Color3.fromRGB(0, 0, 0), Color3.fromRGB(255, 255, 255)
local holeIndex = 1

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
Header.BackgroundTransparency, Header.Text = 1, "MatsuHub Tsunami"
Header.TextColor3, Header.Font, Header.TextSize = WHITE, Enum.Font.GothamBold, 18

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

-- Botão SOBE MAIS UM (Voo por baixo da terra)
createBtn("Sobe mais um", UDim2.new(0.05, 0, 0.65, 0), function(b)
    b.Text, b.TextColor3 = "ATIVO!", RED
    
    task.spawn(function()
        local char = player.Character
        local hrp = char:FindFirstChild("HumanoidRootPart")
        
        if hrp then
            -- 1. Encontra os buracos/segredos
            local targets = {}
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("BasePart") and (v.Name:lower():find("secret") or v.Name:lower():find("win") or v.Name:lower():find("goal")) then
                    table.insert(targets, v)
                end
            end

            if #targets > 0 then
                if holeIndex > #targets then holeIndex = 1 end
                local target = targets[holeIndex]

                -- 2. DESCE para baixo da terra primeiro
                hrp.CFrame = hrp.CFrame * CFrame.new(0, -30, 0)
                task.wait(0.2)

                -- 3. VOA por baixo até a posição do buraco
                local targetUnder = target.Position - Vector3.new(0, 30, 0)
                hrp.CFrame = CFrame.new(targetUnder)
                task.wait(0.3)

                -- 4. SOBE para dentro do buraco
                hrp.CFrame = target.CFrame + Vector3.new(0, 3, 0)
                
                holeIndex = holeIndex + 1
            else
                b.Text = "Não achado!"
            end
        end
        
        task.wait(1)
        b.Text, b.TextColor3 = "Sobe mais um", WHITE
    end)
end)
