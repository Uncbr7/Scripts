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
Instance.new("UICorner", ToggleBtn); applyNeon(ToggleBtn)

MainFrame.Size, MainFrame.Position, MainFrame.BackgroundColor3 = UDim2.new(0, 250, 0, 310), UDim2.new(0.5, -125, 0.5, -155), PRETO
MainFrame.Active, MainFrame.Draggable = true, true
Instance.new("UICorner", MainFrame); applyNeon(MainFrame)

Header.Size, Header.BackgroundColor3, Header.Text = UDim2.new(1, 0, 0, 50), PRETO, "MATSUHUB BUILD BOAT"
Header.TextColor3, Header.Font, Header.TextSize = BRANCO, Enum.Font.GothamBold, 15
Instance.new("UICorner", Header)

local function createBtn(t, p, f)
    local b = Instance.new("TextButton", MainFrame)
    b.Size, b.Position, b.BackgroundColor3 = UDim2.new(0.85, 0, 0, 40), p, Color3.fromRGB(15, 15, 15)
    b.Text, b.TextColor3, b.Font, b.TextSize = t, BRANCO, Enum.Font.GothamBold, 11
    Instance.new("UICorner", b); applyNeon(b)
    b.MouseButton1Click:Connect(f)
end

ActionBtn.Size, ActionBtn.Position, ActionBtn.BackgroundColor3 = UDim2.new(0.85, 0, 0, 45), UDim2.new(0.075, 0, 0.78, 0), Color3.fromRGB(150, 0, 0)
ActionBtn.Text, ActionBtn.TextColor3, ActionBtn.Font, ActionBtn.TextSize = "PARAR DE VOAR", BRANCO, Enum.Font.GothamBold, 12
ActionBtn.Visible = false
Instance.new("UICorner", ActionBtn); applyNeon(ActionBtn)

ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

local lp = game.Players.LocalPlayer
local flying, bv, bg = false, nil, nil

local function cleanup()
    flying = false
    if bv then bv:Destroy(); bv = nil end
    if bg then bg:Destroy(); bg = nil end
    ActionBtn.Visible = false
    if lp.Character then
        for _, v in pairs(lp.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = true end
        end
    end
end

local function startFly(s)
    local char = lp.Character or lp.CharacterAdded:Wait()
    local h = char:WaitForChild("HumanoidRootPart")
    cleanup()
    
    bv, bg = Instance.new("BodyVelocity", h), Instance.new("BodyGyro", h)
    bv.MaxForce, bg.MaxTorque = Vector3.one * 1e6, Vector3.one * 1e6
    flying = true
    
    task.spawn(function()
        while flying and h.Parent do
            local posZ = h.Position.Z
            
            -- ATRAVESSA A PAREDE DA FOTO (Noclip Ativo)
            if posZ > 9400 and posZ < 9485 then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end

            -- CONGELA EM CIMA DO BAÚ
            if posZ >= 9485 then
                bv.Velocity = Vector3.new(0,0,0)
                ActionBtn.Visible = true
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = true end
                end
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

createBtn("AUTO FARM DE BARCO", UDim2.new(0.075, 0, 0.20, 0), function() startFly(200) end)
createBtn("AUTO FARM (NORMAL)", UDim2.new(0.075, 0, 0.38, 0), function() startFly(250) end)
createBtn("AUTO FARM (TURBO)", UDim2.new(0.075, 0, 0.56, 0), function() startFly(400) end)
