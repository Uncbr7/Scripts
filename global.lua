local player = game.Players.LocalPlayer
local sgui = Instance.new("ScreenGui", game:GetService("CoreGui"))
sgui.Name = "MatsuHub_Global_v2"

-- BOTÃO M (ABRIR/FECHAR)
local ToggleBtn = Instance.new("TextButton", sgui)
ToggleBtn.Size = UDim2.new(0, 45, 0, 45)
ToggleBtn.Position = UDim2.new(0, 15, 0, 150)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 85, 255)
ToggleBtn.Text = "M"
ToggleBtn.TextColor3 = Color3.new(1, 1, 1)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 25
Instance.new("UICorner", ToggleBtn)

-- MENU PRINCIPAL
local MainFrame = Instance.new("Frame", sgui)
MainFrame.Size = UDim2.new(0, 260, 0, 180)
MainFrame.Position = UDim2.new(0.5, -130, 0.5, -90)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
local stroke = Instance.new("UIStroke", MainFrame)
stroke.Color = Color3.fromRGB(0, 85, 255)
stroke.Thickness = 3
Instance.new("UICorner", MainFrame)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Text = "MatsuHub Global"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.BackgroundTransparency = 1

-- FUNÇÃO INVISIBILIDADE (Método que remove o Character do servidor)
local InvBtn = Instance.new("TextButton", MainFrame)
InvBtn.Size = UDim2.new(0.9, 0, 0, 60)
InvBtn.Position = UDim2.new(0.05, 0, 0.4, 0)
InvBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
InvBtn.Text = "Ficar Invisível (Real)"
InvBtn.TextColor3 = Color3.new(1, 1, 1)
InvBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", InvBtn)

InvBtn.MouseButton1Click:Connect(function()
    local char = player.Character
    if char then
        -- Salva sua posição atual
        local oldPos = char.HumanoidRootPart.CFrame
        
        -- Deleta o torso para "quebrar" a visão dos outros jogadores
        if char:FindFirstChild("UpperTorso") then -- R15
            char.UpperTorso:Destroy()
            InvBtn.Text = "INVISÍVEL ATIVADO"
            InvBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        elseif char:FindFirstChild("Torso") then -- R6
            char.Torso:Destroy()
            InvBtn.Text = "INVISÍVEL ATIVADO"
            InvBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        else
            InvBtn.Text = "Erro: Já Invisível?"
        end
    end
end)

-- LÓGICA DO BOTÃO M
ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)
