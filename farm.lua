-- [[ MatsuHub Oficial - Build A Boat ]] --
if game.PlaceId ~= 537413528 then return end

local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local MainFrame = Instance.new("Frame", ScreenGui)
local Header = Instance.new("TextLabel", MainFrame)
local ToggleBtn = Instance.new("TextButton", ScreenGui)
local ActionBtn = Instance.new("TextButton", MainFrame)

local NEON_RED, PRETO, BRANCO = Color3.fromRGB(255, 0, 0), Color3.fromRGB(0, 0, 0), Color3.fromRGB(255, 255, 255)

local function applyNeon(p)
    local s = Instance.new("UIStroke", p)
    s.Color, s.Thickness, s.ApplyStrokeMode = NEON_RED, 3, Enum.ApplyStrokeMode.Border
end

ToggleBtn.Size, ToggleBtn.Position, ToggleBtn.BackgroundColor3 = UDim2.new(0, 45, 0, 45), UDim2.new(0, 15, 0, 15), PRETO
ToggleBtn.Text, ToggleBtn.TextColor3, ToggleBtn.Font, ToggleBtn.TextSize = "M", BRANCO, Enum.Font.GothamBold, 20
Instance.new("UICorner", ToggleBtn)
applyNeon(ToggleBtn)

MainFrame.Size, MainFrame.Position, MainFrame.BackgroundColor3 = UDim2.new(0, 250, 0, 310), UDim2.new(0.5, -125, 0.5, -155), PRETO
MainFrame.Active, MainFrame.Draggable = true, true
Instance.new("UICorner", MainFrame)
applyNeon(MainFrame)

Header.Size, Header.BackgroundColor3, Header.Text = UDim2.new(1, 0, 0, 50), PRETO, "MATSUHUB BUILD BOAT"
Header.TextColor3, Header.Font, Header.TextSize = BRANCO, Enum.Font.GothamBold, 15
Instance.new("UICorner", Header)

local function createBtn(t, p, f)
    local b = Instance.new("TextButton", MainFrame)
    b.Size, b.Position, b.BackgroundColor3 = UDim2.new(0.85, 0, 0, 40), p, Color3.fromRGB(15, 15, 15)
    b.Text, b.TextColor3, b.Font, b.TextSize = t, BRANCO, Enum.Font.GothamBold, 11
    Instance.new("UICorner", b)
    applyNeon(b)
    b.MouseButton1Click:Connect(f)
end

ActionBtn.Size, ActionBtn.Position, ActionBtn.BackgroundColor3 = UDim2.new(0.85, 0, 0, 45), UDim2.new(0.075, 0, 0.78, 0), PRETO
ActionBtn.Text, ActionBtn.TextColor3, ActionBtn.Font, ActionBtn.TextSize = "", BRANCO, Enum.Font.GothamBold, 12
ActionBtn.Visible = false
Instance.new("UICorner", ActionBtn)
applyNeon(ActionBtn)

ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

local lp = game.Players.LocalPlayer
local flying, bv, bg = false, nil, nil
local pausedForDescend = false

local function cleanup()
    flying = false
    pausedForDescend = false
    if bv then bv:Destroy(); bv = nil end
    if bg then bg:Destroy(); bg = nil end
    ActionBtn.Visible = false
end

local function startFly(s)
    local h = lp.Character:FindFirstChild("HumanoidRootPart")
    if not h then return end
    cleanup()
    
    bv, bg = Instance.new("BodyVelocity", h), Instance.new("BodyGyro", h)
    bv.MaxForce, bg.MaxTorque = Vector3.one * 1e6, Vector3.one * 1e6
    flying = true
    
    task.spawn(function()
        local speed = s
        while flying and h.Parent do
            local posZ = h.Position.Z
            
            -- Lógica de Travar na Cachoeira
            if posZ > 9410 and posZ < 9480 and not pausedForDescend then
                bv.Velocity = Vector3.new(0,0,0) -- TRAVA O BONECO
                ActionBtn.Visible = true
                ActionBtn.Text = "DESCER"
                ActionBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
            -- Lógica de Travar na Areia
            elseif posZ >= 9485 then
                bv.Velocity = Vector3.new(0,0,0) -- TRAVA NA AREIA
                ActionBtn.Visible = true
                ActionBtn.Text = "PARAR DE VOAR"
                ActionBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
            elseif not pausedForDescend then
                ActionBtn.Visible = false
                bv.Velocity = (Vector3.new(-106, 35, posZ + 100) - h.Position).Unit * speed
            end
            
            bg.CFrame = CFrame.new(h.Position, Vector3.new(-106, h.Position.Y, h.Position.Z + 100))
            task.wait()
        end
    end)
end

ActionBtn.MouseButton1Click:Connect(function()
    local h = lp.Character:FindFirstChild("HumanoidRootPart")
    if ActionBtn.Text == "DESCER" and h then
        h.CFrame = CFrame.new(-106, -17, h.Position.Z) -- Desce pros espinhos
        task.wait(0.5)
        pausedForDescend = true -- Libera para continuar voando após descer
        ActionBtn.Visible = false
    elseif ActionBtn.Text == "PARAR DE VOAR" then
        cleanup()
    end
end)

createBtn("AUTO FARM DE BARCO", UDim2.new(0.075, 0, 0.20, 0), function() startFly(200) end)
createBtn("AUTO FARM (NORMAL)", UDim2.new(0.075, 0, 0.38, 0), function() startFly(250) end)
createBtn("AUTO FARM (TURBO)", UDim2.new(0.075, 0, 0.56, 0), function() startFly(400) end)
