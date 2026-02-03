-- [[ MATSUHUB OFFICIAL - BUILD A BOAT ]] --
if game.PlaceId ~= 537413528 then return end

local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local MainFrame = Instance.new("Frame", ScreenGui)
local Header = Instance.new("TextLabel", MainFrame)
local ToggleBtn = Instance.new("TextButton", ScreenGui)

-- BOTÃO DE TELA (APARECE QUANDO CONGELA)
local StopBtn = Instance.new("TextButton", ScreenGui)

local RED = Color3.fromRGB(255, 0, 0)
local BLACK = Color3.fromRGB(0, 0, 0)
local WHITE = Color3.fromRGB(255, 255, 255)

local function applyNeon(p)
    local s = Instance.new("UIStroke", p)
    s.Color = RED
    s.Thickness = 2.5
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
end

-- Configuração do Botão M
ToggleBtn.Size, ToggleBtn.Position = UDim2.new(0, 45, 0, 45), UDim2.new(0, 15, 0, 15)
ToggleBtn.BackgroundColor3 = BLACK
ToggleBtn.Text, ToggleBtn.TextColor3 = "M", WHITE
ToggleBtn.Font, ToggleBtn.TextSize = Enum.Font.GothamBold, 25
Instance.new("UICorner", ToggleBtn)
applyNeon(ToggleBtn)

-- Painel Principal MatsuHub
MainFrame.Size, MainFrame.Position = UDim2.new(0, 260, 0, 250), UDim2.new(0.5, -130, 0.5, -125)
MainFrame.BackgroundColor3, MainFrame.Visible = BLACK, true
MainFrame.Active, MainFrame.Draggable = true, true
Instance.new("UICorner", MainFrame)
applyNeon(MainFrame)

-- Título
Header.Parent = MainFrame
Header.Size, Header.BackgroundTransparency = UDim2.new(1, 0, 0, 50), 1
Header.Text, Header.TextColor3 = "MATSUHUB OFFICIAL", RED
Header.Font, Header.TextSize = Enum.Font.GothamBold, 18

-- Botão Parar Auto Farm ( GothamBold + Neon )
StopBtn.Size = UDim2.new(0, 180, 0, 50)
StopBtn.Position = UDim2.new(0.5, -90, 0.7, 0) -- Centralizado na parte inferior
StopBtn.BackgroundColor3 = BLACK
StopBtn.Text = "Parar Auto Farm"
StopBtn.TextColor3 = WHITE
StopBtn.Font = Enum.Font.GothamBold
StopBtn.TextSize = 16
StopBtn.Visible = false 
Instance.new("UICorner", StopBtn)
applyNeon(StopBtn)

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

ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

local lp = game.Players.LocalPlayer
local flying, bv, bg = false, nil, nil

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
    if bv then bv:Destroy(); bv = nil end
    if bg then bg:Destroy(); bg = nil end
    StopBtn.Visible = false
    toggleNoclip(false)
end

StopBtn.MouseButton1Click:Connect(stopAll)

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
            
            -- Lógica de Congelamento (Cachoeira ou Baú)
            if z >= 9410 then -- A partir daqui ele começa a monitorar o "trava"
                if z >= 9480 or (root.Velocity.Magnitude < 1) then
                    bv.Velocity = Vector3.zero
                    StopBtn.Visible = true -- SÓ APARECE QUANDO CONGELA
                else
                    bv.Velocity = (Vector3.new(-106, 35, z + 100) - root.Position).Unit * speed
                    StopBtn.Visible = false
                end
            else
                bv.Velocity = (Vector3.new(-106, 35, z + 100) - root.Position).Unit * speed
                StopBtn.Visible = false
            end
            
            bg.CFrame = CFrame.new(root.Position, Vector3.new(-106, root.Position.Y, z + 100))
            task.wait()
        end
    end)
end

createBtn("AUTO FARM DE BARCO", UDim2.new(0.05, 0, 0.25, 0), function() startFarm(200) end)
createBtn("AUTO FARM (NORMAL)", UDim2.new(0.05, 0, 0.45, 0), function() startFarm(250) end)
createBtn("AUTO FARM (TURBO)", UDim2.new(0.05, 0, 0.65, 0), function() startFarm(400) end)
