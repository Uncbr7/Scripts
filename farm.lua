-- MatsuHub - Build A Boat
if game.PlaceId ~= 537413528 then return end

local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local MainFrame = Instance.new("Frame", ScreenGui)
local Header = Instance.new("TextLabel", MainFrame)
local ToggleBtn = Instance.new("TextButton", ScreenGui)

local NEON_RED, PRETO, BRANCO = Color3.fromRGB(255, 0, 0), Color3.fromRGB(0, 0, 0), Color3.fromRGB(255, 255, 255)

local function applyNeon(p)
    local s = Instance.new("UIStroke", p)
    s.Color, s.Thickness, s.ApplyStrokeMode = NEON_RED, 3, Enum.ApplyStrokeMode.Border
end

ToggleBtn.Size, ToggleBtn.Position, ToggleBtn.BackgroundColor3 = UDim2.new(0, 45, 0, 45), UDim2.new(0, 15, 0, 15), PRETO
ToggleBtn.Text, ToggleBtn.TextColor3, ToggleBtn.Font, ToggleBtn.TextSize = "M", BRANCO, Enum.Font.GothamBold, 20
Instance.new("UICorner", ToggleBtn)
applyNeon(ToggleBtn)

MainFrame.Size, MainFrame.Position, MainFrame.BackgroundColor3 = UDim2.new(0, 250, 0, 270), UDim2.new(0.5, -125, 0.5, -135), PRETO
MainFrame.Active, MainFrame.Draggable = true, true
Instance.new("UICorner", MainFrame)
applyNeon(MainFrame)

-- NOME TROCADO AQUI ABAIXO:
Header.Size, Header.BackgroundColor3, Header.Text = UDim2.new(1, 0, 0, 50), PRETO, "MATSUHUB BUILD BOAT"
Header.TextColor3, Header.Font, Header.TextSize = BRANCO, Enum.Font.GothamBold, 15
Instance.new("UICorner", Header)

local function createBtn(t, p, f)
    local b = Instance.new("TextButton", MainFrame)
    b.Size, b.Position, b.BackgroundColor3 = UDim2.new(0.85, 0, 0, 45), p, Color3.fromRGB(15, 15, 15)
    b.Text, b.TextColor3, b.Font, b.TextSize = t, BRANCO, Enum.Font.GothamBold, 12
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

createBtn("AUTO FARM DE BARCO", UDim2.new(0.075, 0, 0.25, 0), function() startFly(200) end)
createBtn("AUTO FARM (NORMAL)", UDim2.new(0.075, 0, 0.48, 0), function() startFly(250) end)
createBtn("AUTO FARM (TURBO)", UDim2.new(0.075, 0, 0.71, 0), function() startFly(400) end)
