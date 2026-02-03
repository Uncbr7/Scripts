-- [[ MATSUHUB OFFICIAL - BUILD A BOAT ]] --
if game.PlaceId ~= 537413528 then return end

local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local MainFrame = Instance.new("Frame", ScreenGui)
local Header = Instance.new("TextLabel", MainFrame)
local ToggleBtn = Instance.new("TextButton", ScreenGui)
local ActionBtn = Instance.new("TextButton", MainFrame)

local RED = Color3.fromRGB(255, 0, 0)
local BLACK = Color3.fromRGB(0, 0, 0)
local WHITE = Color3.fromRGB(255, 255, 255)

local function applyNeon(p)
    local s = Instance.new("UIStroke", p)
    s.Color = RED
    s.Thickness = 2.5
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
end

-- Botão M
ToggleBtn.Parent = ScreenGui
ToggleBtn.Size, ToggleBtn.Position = UDim2.new(0, 45, 0, 45), UDim2.new(0, 15, 0, 15)
ToggleBtn.BackgroundColor3 = BLACK
ToggleBtn.Text, ToggleBtn.TextColor3 = "M", WHITE
ToggleBtn.Font, ToggleBtn.TextSize = Enum.Font.GothamBold, 25
Instance.new("UICorner", ToggleBtn)
applyNeon(ToggleBtn)

-- Painel Principal
MainFrame.Parent = ScreenGui
MainFrame.Size, MainFrame.Position = UDim2.new(0, 260, 0, 320), UDim2.new(0.5, -130, 0.5, -160)
MainFrame.BackgroundColor3, MainFrame.Visible = BLACK, true
MainFrame.Active, MainFrame.Draggable = true, true
Instance.new("UICorner", MainFrame)
applyNeon(MainFrame)

-- Título
Header.Parent = MainFrame
Header.Size, Header.BackgroundTransparency = UDim2.new(1, 0, 0, 50), 1
Header.Text, Header.TextColor3 = "MATSUHUB OFFICIAL", RED
Header.Font, Header.TextSize = Enum.Font.GothamBold, 18

local function createBtn(t, p, f)
    local b = Instance.new("TextButton", MainFrame)
    b.Size, b.Position = UDim2.new(0.9, 0, 0, 45), p
    b.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    b.Text, b.TextColor3 = t, WHITE
    b.Font, b.TextSize = Enum.Font.GothamBold, 13
    Instance.new("UICorner", b)
    applyNeon(b)
    b.MouseButton1Click:Connect(f)
end

-- Botão de Ação Dinâmico (DESCER / PARAR)
ActionBtn.Parent = MainFrame
ActionBtn.Size, ActionBtn.Position = UDim2.new(0.9, 0, 0, 50), UDim2.new(0.05, 0, 0.8, 0)
ActionBtn.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
ActionBtn.Text, ActionBtn.TextColor3 = "", WHITE
ActionBtn.Font, ActionBtn.TextSize = Enum.Font.GothamBold, 14
ActionBtn.Visible = false
Instance.new("UICorner", ActionBtn)
applyNeon(ActionBtn)

ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

local lp = game.Players.LocalPlayer
local flying, bv, bg = false, nil, nil
local faseDescer = false

local function toggleNoclip(state)
    local char = lp.Character
    if char then
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = not state end
        end
    end
end

local function stopAll()
    flying = false
    faseDescer = false
    if bv then bv:Destroy(); bv = nil end
    if bg then bg:Destroy(); bg = nil end
    ActionBtn.Visible = false
    toggleNoclip(false)
end

local function startFarm(speed)
    local char = lp.Character or lp.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")
    stopAll()
    
    bv, bg = Instance.new("BodyVelocity", root), Instance.new("BodyGyro", root)
    bv.MaxForce, bg.MaxTorque = Vector3.one * 1e7, Vector3.one * 1e7
    flying = true
    
    task.spawn(function()
        while flying and root.Parent do
            toggleNoclip(true) 
            local z = root.Position.Z
            
            -- PARADA 1: NA CACHOEIRA (PARA DESCER)
            if z > 9410 and z < 9475 and not faseDescer then
                bv.Velocity = Vector3.zero
                ActionBtn.Text = "DESCER"
                ActionBtn.Visible = true
            
            -- PARADA 2: NO BAÚ (PARA PARAR)
            elseif z >= 9480 then
                bv.Velocity = Vector3.zero
                ActionBtn.Text = "PARAR DE VOAR"
                ActionBtn.Visible = true
            
            -- VOO NORMAL
            else
                bv.Velocity = (Vector3.new(-106, 35, z + 100) - root.Position).Unit * speed
                ActionBtn.Visible = false
            end
            
            bg.CFrame = CFrame.new(root.Position, Vector3.new(-106, root.Position.Y, z + 100))
            task.wait()
        end
    end)
end

ActionBtn.MouseButton1Click:Connect(function()
    local root = lp.Character:FindFirstChild("HumanoidRootPart")
    if ActionBtn.Text == "DESCER" then
        if root then root.CFrame = root.CFrame * CFrame.new(0, -55, 0) end -- Te joga para baixo da parede
        faseDescer = true
        ActionBtn.Visible = false
    else
        stopAll()
    end
end)

createBtn("AUTO FARM DE BARCO", UDim2.new(0.05, 0, 0.2, 0), function() startFarm(200) end)
createBtn("AUTO FARM (NORMAL)", UDim2.new(0.05, 0, 0.4, 0), function() startFarm(250) end)
createBtn("AUTO FARM (TURBO)", UDim2.new(0.05, 0, 0.6, 0), function() startFarm(400) end)
