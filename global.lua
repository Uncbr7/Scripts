local player = game.Players.LocalPlayer
local sgui = Instance.new("ScreenGui", game:GetService("CoreGui"))
sgui.Name = "MatsuHub_Global"

-- BOTÃO M
local ToggleBtn = Instance.new("TextButton", sgui)
ToggleBtn.Size = UDim2.new(0, 45, 0, 45)
ToggleBtn.Position = UDim2.new(0, 15, 0, 150)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 85, 255)
ToggleBtn.Text = "M"
ToggleBtn.TextColor3 = Color3.new(1, 1, 1)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 25
Instance.new("UICorner", ToggleBtn)

-- MENU
local MainFrame = Instance.new("Frame", sgui)
MainFrame.Size = UDim2.new(0, 260, 0, 200)
MainFrame.Position = UDim2.new(0.5, -130, 0.5, -100)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
local stroke = Instance.new("UIStroke", MainFrame)
stroke.Color = Color3.fromRGB(0, 85, 255)
stroke.Thickness = 3
Instance.new("UICorner", MainFrame)

-- FUNÇÃO INVISÍVEL (Ninguém te vê)
local InvBtn = Instance.new("TextButton", MainFrame)
InvBtn.Size = UDim2.new(0.9, 0, 0, 50)
InvBtn.Position = UDim2.new(0.05, 0, 0.2, 0)
InvBtn.Text = "Ficar Invisível"
InvBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
InvBtn.TextColor3 = Color3.new(1, 1, 1)
InvBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", InvBtn)

InvBtn.MouseButton1Click:Connect(function()
    local char = player.Character
    if char:FindFirstChild("UpperTorso") then char.UpperTorso:Destroy() end
    if char:FindFirstChild("Torso") then char.Torso:Destroy() end
    InvBtn.Text = "VOCÊ ESTÁ INVISÍVEL"
    InvBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
end)

-- FUNÇÃO NOCLIP (Atravessar Paredes)
local NcBtn = Instance.new("TextButton", MainFrame)
NcBtn.Size = UDim2.new(0.9, 0, 0, 50)
NcBtn.Position = UDim2.new(0.05, 0, 0.55, 0)
NcBtn.Text = "Atravessar Paredes"
NcBtn.BackgroundColor3 = Color3.fromRGB(0, 85, 255)
NcBtn.TextColor3 = Color3.new(1, 1, 1)
NcBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", NcBtn)

local noclip = false
NcBtn.MouseButton1Click:Connect(function()
    noclip = not noclip
    NcBtn.Text = noclip and "Noclip: ON" or "Atravessar Paredes"
    game:GetService("RunService").Stepped:Connect(function()
        if noclip then
            for _, v in pairs(player.Character:GetDescendants()) do
                if v:IsA("BasePart") then v.CanCollide = false end
            end
        end
    end)
end)

ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)
