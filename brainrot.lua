-- [[ MATSUHUB TSUNAMI - STEAL A BRAINROT COM POSIÇÃO SALVA ]] --
local player = game.Players.LocalPlayer
local sgui = Instance.new("ScreenGui", game:GetService("CoreGui"))
sgui.Name = "MatsuHubBrainrot"

local BLUE = Color3.fromRGB(0, 85, 255)
local DARK_BLUE = Color3.fromRGB(0, 40, 120)
local WHITE = Color3.fromRGB(255, 255, 255)

local MainFrame = Instance.new("Frame", sgui)
MainFrame.Size = UDim2.new(0, 260, 0, 260)
MainFrame.Position = UDim2.new(0.5, -130, 0.5, -130)
MainFrame.BackgroundColor3 = BLUE
Instance.new("UICorner", MainFrame)

local Header = Instance.new("TextLabel", MainFrame)
Header.Size = UDim2.new(1, 0, 0, 50)
Header.BackgroundTransparency = 1
Header.Text = "MatsuHub Brainrot"
Header.TextColor3, Header.Font, Header.TextSize = WHITE, Enum.Font.GothamBold, 18

local function createBtn(t, pos, f)
    local b = Instance.new("TextButton", MainFrame)
    b.Size, b.Position = UDim2.new(0.9, 0, 0, 45), pos
    b.BackgroundColor3, b.Text = DARK_BLUE, t
    b.TextColor3, b.Font, b.TextSize = WHITE, Enum.Font.GothamBold, 13
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function() f(b) end)
end

-- VARIÁVEL PARA GUARDAR A POSIÇÃO
local SavedCFrame = nil

-- 1. SALVAR LOCALIZAÇÃO (Fique na base e clique aqui)
createBtn("Salvar Localização", UDim2.new(0.05, 0, 0.22, 0), function(b)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        SavedCFrame = player.Character.HumanoidRootPart.CFrame
        b.Text = "LOCAL SALVO! ✅"
        task.wait(1)
        b.Text = "Salvar Localização"
    end
end)

-- 2. TELEPORT (Volta para o local salvo)
createBtn("Teleport", UDim2.new(0.05, 0, 0.45, 0), function(b)
    if SavedCFrame then
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = SavedCFrame
            b.Text = "TELEPORTADO! 🚀"
            task.wait(0.5)
            b.Text = "Teleport"
        end
    else
        b.Text = "SALVE UM LOCAL PRIMEIRO!"
        task.wait(1)
        b.Text = "Teleport"
    end
end)

-- 3. AUTO COLLECT ITEMS
createBtn("Auto Collect Items", UDim2.new(0.05, 0, 0.68, 0), function(b)
    _G.CollectBrainrot = not _G.CollectBrainrot
    b.Text = _G.CollectBrainrot and "COLLECT: ON" or "Auto Collect Items"
    task.spawn(function()
        while _G.CollectBrainrot do
            pcall(function()
                for _, v in pairs(workspace:GetChildren()) do
                    if v:IsA("Tool") or v:FindFirstChild("Handle") then
                        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                            firetouchinterest(player.Character.HumanoidRootPart, v.Handle, 0)
                            firetouchinterest(player.Character.HumanoidRootPart, v.Handle, 1)
                        end
                    end
                end
            end)
            task.wait(0.5)
        end
    end)
end)

-- Botão para fechar/abrir o menu continua funcionando
