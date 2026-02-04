-- [[ MATSUHUB TSUNAMI - APENAS VIP ]] --
local player = game.Players.LocalPlayer
local sgui = Instance.new("ScreenGui", game:GetService("CoreGui"))
sgui.Name = "MatsuHubVipOnly"

local MainFrame = Instance.new("Frame", sgui)
local Header = Instance.new("TextLabel", MainFrame)
local ToggleBtn = Instance.new("TextButton", sgui)

local BLUE = Color3.fromRGB(0, 85, 255)
local DARK_BLUE = Color3.fromRGB(0, 40, 120)
local WHITE = Color3.fromRGB(255, 255, 255)

local function applyNeon(p)
    local s = Instance.new("UIStroke", p)
    s.Color, s.Thickness, s.ApplyStrokeMode = WHITE, 2, Enum.ApplyStrokeMode.Border
end

-- Botão M
ToggleBtn.Size, ToggleBtn.Position = UDim2.new(0, 45, 0, 45), UDim2.new(0, 15, 0, 60)
ToggleBtn.BackgroundColor3, ToggleBtn.Text = BLUE, "M"
ToggleBtn.TextColor3, ToggleBtn.Font, ToggleBtn.TextSize = WHITE, Enum.Font.GothamBold, 25
ToggleBtn.ZIndex = 100
Instance.new("UICorner", ToggleBtn); applyNeon(ToggleBtn)

-- Painel Principal Azul
MainFrame.Size, MainFrame.Position = UDim2.new(0, 260, 0, 130), UDim2.new(0.5, -130, 0.5, -65)
MainFrame.BackgroundColor3 = BLUE
MainFrame.Visible = true
MainFrame.ZIndex = 5
Instance.new("UICorner", MainFrame); applyNeon(MainFrame)

-- Título
Header.Parent, Header.Size = MainFrame, UDim2.new(1, 0, 0, 50)
Header.BackgroundTransparency = 1
Header.Text = "MatsuHub Tsunami"
Header.TextColor3, Header.Font, Header.TextSize = WHITE, Enum.Font.GothamBold, 18
Header.ZIndex = 6

-- Botão Liberar Vips
local VipBtn = Instance.new("TextButton", MainFrame)
VipBtn.Size, VipBtn.Position = UDim2.new(0.9, 0, 0, 50), UDim2.new(0.05, 0, 0.45, 0)
VipBtn.BackgroundColor3, VipBtn.Text = DARK_BLUE, "Liberar Vips"
VipBtn.TextColor3, VipBtn.Font, VipBtn.TextSize = WHITE, Enum.Font.GothamBold, 15
VipBtn.ZIndex = 7
Instance.new("UICorner", VipBtn); applyNeon(VipBtn)

VipBtn.MouseButton1Click:Connect(function()
    VipBtn.Text = "VIP LIBERADO!"
    task.spawn(function()
        while true do
            for _, v in pairs(workspace:GetDescendants()) do
                if (v.Name:lower():find("vip") or v.Name:lower():find("pass")) and v:IsA("BasePart") then
                    v.CanCollide, v.Transparency = false, 0.6
                end
            end
            task.wait(3)
        end
    end)
end)

ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)
