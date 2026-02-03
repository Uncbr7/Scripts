-- [[ MatsuHub Oficial - Build A Boat ]] --
if game.PlaceId ~= 537413528 then 
    return 
end

local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local MainFrame = Instance.new("Frame", ScreenGui)
local Header = Instance.new("TextLabel", MainFrame)
local ToggleBtn = Instance.new("TextButton", ScreenGui)

local NEON_RED = Color3.fromRGB(255, 0, 0)
local PRETO = Color3.fromRGB(0, 0, 0)
local BRANCO = Color3.fromRGB(255, 255, 255)

local function applyNeon(p)
    local s = Instance.new("UIStroke", p)
    s.Color = NEON_RED
    s.Thickness = 3
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
end

-- Botão de Abrir/Fechar (M)
ToggleBtn.Size = UDim2.new(0, 45, 0, 45)
ToggleBtn.Position = UDim2.new(0, 15, 0, 15)
ToggleBtn.BackgroundColor3 = PRETO
ToggleBtn.Text = "M"
ToggleBtn.TextColor3 = BRANCO
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 20
Instance.new("UICorner", ToggleBtn)
applyNeon(ToggleBtn)

-- Painel Principal
MainFrame.Size = UDim2.new(0, 250, 0, 270)
MainFrame.Position = UDim2.new(0.5, -125, 0.5, -135)
MainFrame.BackgroundColor3 = PRETO
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame)
applyNeon(MainFrame)

-- Título
Header.Size = UDim2.new(1, 0, 0, 50)
Header.BackgroundColor3 = PRETO
Header.Text = "MATSUHUB BUILD BOAT"
Header.TextColor3 = BRANCO
Header.Font = Enum.Font.GothamBold
Header.TextSize = 15
Instance.new("UICorner", Header)

local function createBtn(t, p, f)
    local b = Instance.new("TextButton", MainFrame)
    b.Size = UDim2.new(0.85, 0, 0, 45)
    b.Position = p
    b.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    b.Text = t
    b.TextColor3 = BRANCO
    b.Font = Enum.Font.GothamBold
    b.TextSize = 12
    Instance.new("UICorner", b)
    applyNeon(b)
    b.MouseButton1Click:Connect(f)
end

ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

local lp = game.Players.LocalPlayer
local flying, bv, bg, noclipConn = false, nil, nil, nil

local function cleanup()
    flying = false
    if noclipConn then noclipConn:Disconnect() end
    if bv then bv:Destroy() end
    if bg then bg:Destroy() end
end

local function startFly(s)
    local h = lp.Character:FindFirstChild("HumanoidRootPart")
    if not h then return end
    cleanup()
    noclipConn = game:GetService("RunService").Stepped:Connect(function()
        if lp.Character then
            for _, v in pairs(lp.Character:GetDescendants()) do
                if v:IsA("BasePart") then v.CanCollide = false end
            end
        end
    end)
    bv, bg = Instance.new("BodyVelocity", h), Instance.new("BodyGyro", h)
    bv.MaxForce, bg.MaxTorque = Vector3.one * 1e6, Vector3.one * 1e6
    flying = true
    task.spawn(function()
        local y = 35
        while flying and h.Parent do
            if h.Position.Z >= 9400 then 
                h.CFrame = CFrame.new(-106, -15, 9495)
                cleanup()
                break 
            end
            bv.Velocity = (Vector3.new(-106, y, h.Position.Z + 100) - h.Position).Unit * s
            bg.CFrame = CFrame.new(h.Position, Vector3.new(-106, y, h.Position.Z + 100))
            task.wait()
        end
    end)
end

-- NOMES DOS BOTÕES ATUALIZADOS AQUI:
createBtn("AUTOFARM DE BARCO", UDim2.new(0.075, 0, 0.25, 0), function() startFly(200) end)
createBtn("AUTOFARM(NORMAL)", UDim2.new(0.075, 0, 0.48, 0), function() startFly(250) end)
createBtn("AUTOFARM(TURBO)", UDim2.new(0.075, 0, 0.71, 0), function() startFly(400) end)
