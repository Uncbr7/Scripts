-- [[ MatsuHub Oficial - Build A Boat ]] --
if game.PlaceId ~= 537413528 then return end

local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local MainFrame = Instance.new("Frame", ScreenGui)
local Header = Instance.new("TextLabel", MainFrame)
local ToggleBtn = Instance.new("TextButton", ScreenGui)
local ActionBtn = Instance.new("TextButton", MainFrame)

local NEON_RED = Color3.fromRGB(255, 0, 0)
local PRETO = Color3.fromRGB(0, 0, 0)
local BRANCO = Color3.fromRGB(255, 255, 255)

local function applyNeon(p)
    local s = Instance.new("UIStroke", p)
    s.Color = NEON_RED
    s.Thickness = 2.5
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
end

-- Botão "M"
ToggleBtn.Size, ToggleBtn.Position = UDim2.new(0, 45, 0, 45), UDim2.new(0, 15, 0, 15)
ToggleBtn.BackgroundColor3 = PRETO
ToggleBtn.Text, ToggleBtn.TextColor3 = "M", BRANCO
ToggleBtn.Font, ToggleBtn.TextSize = Enum.Font.GothamBold, 25
Instance.new("UICorner", ToggleBtn)
applyNeon(ToggleBtn)

-- Painel Principal
MainFrame.Size, MainFrame.Position = UDim2.new(0, 260, 0, 320), UDim2.new(0.5, -130, 0.5, -160)
MainFrame.BackgroundColor3, MainFrame.Visible = PRETO, true
MainFrame.Active, MainFrame.Draggable = true, true
Instance.new("UICorner", MainFrame)
applyNeon(MainFrame)

-- Cabeçalho
Header.Size, Header.BackgroundTransparency = UDim2.new(1, 0, 0, 50), 1
Header.Text, Header.TextColor3 = "MATSUHUB OFFICIAL", NEON_RED
Header.Font, Header.TextSize = Enum.Font.GothamBold, 18

local function createBtn(t, p, f)
    local b = Instance.new("TextButton", MainFrame)
    b.Size, b.Position = UDim2.new(0.9, 0, 0, 45), p
    b.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    b.Text, b.TextColor3 = t, BRANCO
    b.Font, b.TextSize = Enum.Font.GothamBold, 13
    Instance.new("UICorner", b)
    applyNeon(b)
    b.MouseButton1Click:Connect(f)
end

-- Botão PARAR (Aparece no Baú)
ActionBtn.Size, ActionBtn.Position = UDim2.new(0.9, 0, 0, 50), UDim2.new(0.05, 0, 0.8, 0)
ActionBtn.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
ActionBtn.Text, ActionBtn.TextColor3 = "PARAR DE VOAR", BRANCO
ActionBtn.Font, ActionBtn.TextSize = Enum.Font.GothamBold, 14
ActionBtn.Visible = false
Instance.new("UICorner", ActionBtn)
applyNeon(ActionBtn)

ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

local lp = game.Players.LocalPlayer
local flying, bv, bg = false, nil, nil

local function setNoclip(state)
    local char = lp.Character
    if char then
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = not state end
        end
    end
end

local function cleanup()
    flying = false
    if bv then bv:Destroy(); bv = nil end
    if bg then bg:Destroy(); bg = nil end
    ActionBtn.Visible = false
    setNoclip(false)
end

local function startFly(s)
    local char = lp.Character or lp.CharacterAdded:Wait()
    local h = char:WaitForChild("HumanoidRootPart")
    cleanup()
    
    bv, bg = Instance.new("BodyVelocity", h), Instance.new("BodyGyro", h)
    bv.MaxForce, bg.MaxTorque = Vector3.one * 1e7, Vector3.one * 1e7
    flying = true
    
    task.spawn(function()
        while flying and h.Parent do
            setNoclip(true) -- Noclip sempre ligado!
            local posZ = h.Position.Z
            if posZ >= 9480 then
                bv.Velocity = Vector3.zero
                ActionBtn.Visible = true
            else
                bv.Velocity = (Vector3.new(-106, 35, posZ + 100) - h.Position).Unit * s
                ActionBtn.Visible = false
            end
            bg.CFrame = CFrame.new(h.Position, Vector3.new(-106, h.Position.Y, h.Position.Z + 100))
            task.wait()
        end
    end)
end

ActionBtn.MouseButton1Click:Connect(cleanup)

createBtn("AUTO FARM DE BARCO", UDim2.new(0.05, 0, 0.2, 0), function() startFly(200) end)
createBtn("AUTO FARM (NORMAL)", UDim2.new(0.05, 0, 0.4, 0), function() startFly(250) end)
createBtn("AUTO FARM (TURBO)", UDim2.new(0.05, 0, 0.6, 0), function() startFly(400) end)
