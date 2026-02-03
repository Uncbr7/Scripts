-- [[ MATSUHUB BUILD BOAT - ULTRA FORCE ]] --
if game.PlaceId ~= 537413528 then return end

local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local MainFrame = Instance.new("Frame", ScreenGui)
local Header = Instance.new("TextLabel", MainFrame)
local ToggleBtn = Instance.new("TextButton", ScreenGui)
local StopBtn = Instance.new("TextButton", ScreenGui)

local RED = Color3.fromRGB(255, 0, 0)
local BLACK = Color3.fromRGB(0, 0, 0)
local WHITE = Color3.fromRGB(255, 255, 255)

local function applyNeon(p)
    local s = Instance.new("UIStroke", p)
    s.Color, s.Thickness = RED, 2.5
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
end

-- Botão M
ToggleBtn.Size, ToggleBtn.Position = UDim2.new(0, 45, 0, 45), UDim2.new(0, 15, 0, 15)
ToggleBtn.BackgroundColor3, ToggleBtn.Text = BLACK, "M"
ToggleBtn.TextColor3, ToggleBtn.Font, ToggleBtn.TextSize = WHITE, Enum.Font.GothamBold, 25
Instance.new("UICorner", ToggleBtn); applyNeon(ToggleBtn)

-- Menu Principal
MainFrame.Size, MainFrame.Position = UDim2.new(0, 260, 0, 250), UDim2.new(0.5, -130, 0.5, -125)
MainFrame.BackgroundColor3, MainFrame.Visible = BLACK, true
MainFrame.Active, MainFrame.Draggable = true, true
Instance.new("UICorner", MainFrame); applyNeon(MainFrame)

-- Título
Header.Parent, Header.Size = MainFrame, UDim2.new(1, 0, 0, 50)
Header.BackgroundTransparency, Header.Text = 1, "MATSUHUB BUILD BOAT"
Header.TextColor3, Header.Font, Header.TextSize = WHITE, Enum.Font.GothamBold, 17

-- Botão Parar Auto Farm (Externo)
StopBtn.Size, StopBtn.Position = UDim2.new(0, 180, 0, 50), UDim2.new(0.5, -90, 0.7, 0)
StopBtn.BackgroundColor3, StopBtn.Text = BLACK, "Parar Auto Farm"
StopBtn.TextColor3, StopBtn.Font, StopBtn.TextSize = WHITE, Enum.Font.GothamBold, 16
StopBtn.Visible = false; Instance.new("UICorner", StopBtn); applyNeon(StopBtn)

local function createBtn(t, p, f)
    local b = Instance.new("TextButton", MainFrame)
    b.Size, b.Position = UDim2.new(0.9, 0, 0, 45), p
    b.BackgroundColor3, b.Text = Color3.fromRGB(15, 15, 15), t
    b.TextColor3, b.Font, b.TextSize = WHITE, Enum.Font.GothamBold, 13
    Instance.new("UICorner", b); applyNeon(b)
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

local function startFarm(speed, mode)
    local char = lp.Character or lp.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")
    stopAll()
    
    -- FORÇA BRUTA AUMENTADA PARA 100 MILHÕES
    bv, bg = Instance.new("BodyVelocity", root), Instance.new("BodyGyro", root)
    bv.MaxForce, bg.MaxTorque = Vector3.one * 1e8, Vector3.one * 1e8
    flying = true
    
    task.spawn(function()
        while flying and root.Parent do
            toggleNoclip(true) -- ATRAVESSA ATÉ PENSAMENTO
            local z = root.Position.Z
            local targetY = 35 -- Altura de voo normal
            
            -- FORÇANDO A DESCIDA NA CACHOEIRA (Z > 9410)
            if mode == "Boat" and z >= 9410 and z < 9485 then
                targetY = -35 -- Vai mais fundo ainda para garantir
                -- Se ele estiver muito alto, "puxa" ele pra baixo no CFrame
                if root.Position.Y > -20 then
                    root.CFrame = root.CFrame * CFrame.new(0, -5, 0)
                end
            end

            -- TRAVA NO TESOURO
            if z >= 9485 or (z >= 9410 and root.Velocity.Magnitude < 1) then
                bv.Velocity = Vector3.zero
                StopBtn.Visible = true
            else
                bv.Velocity = (Vector3.new(-106, targetY, z + 100) - root.Position).Unit * speed
                StopBtn.Visible = false
            end
            
            bg.CFrame = CFrame.new(root.Position, Vector3.new(-106, targetY, z + 100))
            task.wait()
        end
    end)
end

createBtn("AUTO FARM DE BARCO", UDim2.new(0.05, 0, 0.25, 0), function() startFarm(200, "Boat") end)
createBtn("AUTO FARM (NORMAL)", UDim2.new(0.05, 0, 0.45, 0), function() startFarm(250, "Normal") end)
createBtn("AUTO FARM (TURBO)", UDim2.new(0.05, 0, 0.65, 0), function() startFarm(400, "Normal") end)
