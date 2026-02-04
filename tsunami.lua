-- [[ MATSUHUB TSUNAMI - VERSÃO PROGRESSIVA ]] --
local player = game.Players.LocalPlayer
local sgui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local MainFrame = Instance.new("Frame", sgui)
local Header = Instance.new("TextLabel", MainFrame)
local ToggleBtn = Instance.new("TextButton", sgui)

local RED, BLACK, WHITE = Color3.fromRGB(255, 0, 0), Color3.fromRGB(0, 0, 0), Color3.fromRGB(255, 255, 255)
local currentHole = 1 -- Contador para saber em qual buraco você está

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

-- Título (Atualizado)
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

-- Botão SOBE MAIS UM
createBtn("Sobe mais um", UDim2.new(0.05, 0, 0.65, 0), function(b)
    task.spawn(function()
        local holes = {}
        -- Detecta buracos de vitória/checkpoints
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") and (v.Name:find("Win") or v.Name:find("End") or v.Name:find("Checkpoint")) then
                table.insert(holes, v)
            end
        end

        -- Se houver buracos, vai para o próximo da lista
        if #holes > 0 then
            if currentHole > #holes then currentHole = 1 end -- Reseta se chegar no último
            
            local target = holes[currentHole]
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                -- Teleporta com uma pequena altura para não bugar no chão
                player.Character.HumanoidRootPart.CFrame = target.CFrame + Vector3.new(0, 4, 0)
                b.Text = "Indo p/ Buraco " .. currentHole
                currentHole = currentHole + 1
            end
        else
            b.Text = "Buracos não achados"
        end
        
        task.wait(1)
        b.Text = "Sobe mais um"
    end)
end)
