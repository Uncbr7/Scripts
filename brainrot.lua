-- [[ MATSUHUB BRAINROT - VERSÃO BLINDADA & TURBO ]] --
local player = game.Players.LocalPlayer
local runService = game:GetService("RunService")
local ts = game:GetService("TweenService")

local sgui = Instance.new("ScreenGui", game:GetService("CoreGui"))
sgui.Name = "MatsuHubV3"

local BLUE = Color3.fromRGB(0, 85, 255)
local DARK_BLUE = Color3.fromRGB(0, 40, 120)
local WHITE = Color3.fromRGB(255, 255, 255)

-- Botão de Abrir/Fechar (M)
local ToggleBtn = Instance.new("TextButton", sgui)
ToggleBtn.Size = UDim2.new(0, 45, 0, 45)
ToggleBtn.Position = UDim2.new(0, 10, 0, 150) -- Posição ajustada para não atrapalhar
ToggleBtn.BackgroundColor3 = BLUE
ToggleBtn.Text = "M"
ToggleBtn.TextColor3 = WHITE
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 25
Instance.new("UICorner", ToggleBtn)

local MainFrame = Instance.new("Frame", sgui)
MainFrame.Size = UDim2.new(0, 260, 0, 280)
MainFrame.Position = UDim2.new(0.5, -130, 0.5, -140)
MainFrame.BackgroundColor3 = BLUE
MainFrame.Visible = true
Instance.new("UICorner", MainFrame)

local function createBtn(t, pos, f)
    local b = Instance.new("TextButton", MainFrame)
    b.Size, b.Position = UDim2.new(0.9, 0, 0, 45), pos
    b.BackgroundColor3, b.Text = DARK_BLUE, t
    b.TextColor3, b.Font, b.TextSize = WHITE, Enum.Font.GothamBold, 13
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function() f(b) end)
end

local SavedPos = nil

-- 1. SALVAR BASE
createBtn("Salvar Base (Local Seguro)", UDim2.new(0.05, 0, 0.2, 0), function(b)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        SavedPos = player.Character.HumanoidRootPart.Position
        b.Text = "BASE SALVA! ✅"
        task.wait(1)
        b.Text = "Salvar Base (Local Seguro)"
    end
end)

-- 2. VOO TURBO BLINDADO
createBtn("Voo Blindado para Base", UDim2.new(0.05, 0, 0.45, 0), function(b)
    if SavedPos and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = player.Character.HumanoidRootPart
        local hum = player.Character:FindFirstChildOfClass("Humanoid")
        
        b.Text = "BLINDAGEM ATIVA..."
        
        -- Anti-Queda/Stun durante o voo
        hum.PlatformStand = true 
        
        local distance = (hrp.Position - SavedPos).Magnitude
        local speed = 150 -- Aumente aqui para ser ainda mais rápido
        local duration = distance / speed
        
        local flyTween = ts:Create(hrp, TweenInfo.new(duration, Enum.EasingStyle.Linear), {CFrame = CFrame.new(SavedPos + Vector3.new(0, 10, 0))})
        
        flyTween:Play()
        flyTween.Completed:Wait()
        
        hum.PlatformStand = false
        b.Text = "ENTREGUE COM SUCESSO!"
        task.wait(1)
        b.Text = "Voo Blindado para Base"
    else
        b.Text = "ERRO: SALVE A BASE!"
        task.wait(1)
        b.Text = "Voo Blindado para Base"
    end
end)

-- 3. AUTO COLLECT TURBO
createBtn("Auto Collect (Fast)", UDim2.new(0.05, 0, 0.7, 0), function(b)
    _G.Collect = not _G.Collect
    b.Text = _G.Collect and "COLLECTOR: ON" or "Auto Collect (Fast)"
    task.spawn(function()
        while _G.Collect do
            pcall(function()
                for _, v in pairs(workspace:GetChildren()) do
                    if v:IsA("Tool") or v:FindFirstChild("Handle") then
                        firetouchinterest(player.Character.HumanoidRootPart, v:FindFirstChild("Handle") or v, 0)
                        firetouchinterest(player.Character.HumanoidRootPart, v:FindFirstChild("Handle") or v, 1)
                    end
                end
            end)
            task.wait(0.1) -- Muito mais rápido
        end
    end)
end)

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)
