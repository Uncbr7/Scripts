-- [[ MATSUHUB PRISON LIFE - AIMBOT FIX ]] --
local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera
local runService = game:GetService("RunService")

local sgui = Instance.new("ScreenGui", game:GetService("CoreGui"))
sgui.Name = "MatsuHubPrisonFix"

local BLUE = Color3.fromRGB(0, 85, 255)
local DARK_BLUE = Color3.fromRGB(0, 40, 120)
local WHITE = Color3.fromRGB(255, 255, 255)

_G.AimbotMode = "None"

-- Função para achar o alvo mais próximo
local function getClosestPlayer()
    local target = nil
    local shortestDistance = math.huge

    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= player and v.Character and v.Character:FindFirstChild("Head") and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
            
            local isTarget = false
            if _G.AimbotMode == "Police" and v.TeamColor.Name == "Bright blue" then isTarget = true end
            if _G.AimbotMode == "Criminals" and (v.TeamColor.Name == "Really red" or v.TeamColor.Name == "Deep orange") then isTarget = true end
            
            if isTarget then
                local pos = camera:WorldToViewportPoint(v.Character.Head.Position)
                local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)).Magnitude
                
                if magnitude < shortestDistance then
                    target = v
                    shortestDistance = magnitude
                end
            end
        end
    end
    return target
end

-- LOOP DE MIRA E TIRO (CONECTADO AO RENDER)
runService.RenderStepped:Connect(function()
    if _G.AimbotMode ~= "None" then
        local targetPlayer = getClosestPlayer()
        if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("Head") then
            -- FORÇA A MIRA NA CABEÇA
            camera.CFrame = CFrame.new(camera.CFrame.Position, targetPlayer.Character.Head.Position)
            
            -- ATIRA AUTOMATICAMENTE (Se tiver arma na mão)
            local gun = player.Character:FindFirstChildOfClass("Tool")
            if gun and gun:FindFirstChild("GunCursor") then
                game:GetService("ReplicatedStorage").ShootEvent:FireServer({
                    [1] = {
                        ["RayObject"] = Ray.new(Vector3.new(), Vector3.new()),
                        ["Distance"] = 0,
                        ["Cframe"] = CFrame.new(),
                        ["Hit"] = targetPlayer.Character.Head
                    }
                }, gun)
            end
        end
    end
end)

-- INTERFACE (IGUAL À ANTERIOR)
local MainFrame = Instance.new("Frame", sgui)
MainFrame.Size, MainFrame.Position = UDim2.new(0, 260, 0, 260), UDim2.new(0.5, -130, 0.5, -130)
MainFrame.BackgroundColor3 = BLUE
Instance.new("UICorner", MainFrame)

local function createBtn(t, pos, f)
    local b = Instance.new("TextButton", MainFrame)
    b.Size, b.Position = UDim2.new(0.9, 0, 0, 45), pos
    b.BackgroundColor3, b.Text = DARK_BLUE, t
    b.TextColor3, b.Font, b.TextSize = WHITE, Enum.Font.GothamBold, 14
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function() f(b) end)
end

createBtn("Aimbot Police", UDim2.new(0.05, 0, 0.22, 0), function(b)
    _G.AimbotMode = (_G.AimbotMode == "Police") and "None" or "Police"
    b.Text = (_G.AimbotMode == "Police") and "POLICE ON" or "Aimbot Police"
end)

createBtn("Aimbot Criminal", UDim2.new(0.05, 0, 0.45, 0), function(b)
    _G.AimbotMode = (_G.AimbotMode == "Criminals") and "None" or "Criminals"
    b.Text = (_G.AimbotMode == "Criminals") and "CRIMINAL ON" or "Aimbot Criminal"
end)

createBtn("Teleporte Guns", UDim2.new(0.05, 0, 0.68, 0), function(b)
    player.Character.HumanoidRootPart.CFrame = CFrame.new(837, 99, 2267)
end)
