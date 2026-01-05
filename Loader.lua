-- [[ KA HUB | LOADER ATUALIZADO ]]
local KeyOficial = "KA-"..os.date("%d%m").."-HUB"

local function LoadMain()
    -- Link corrigido para o seu GitHub
    loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptgif/KA-HUB-V1/main/Source.lua"))()
end

-- INTERFACE DE LOGIN
local CoreGui = game:GetService("CoreGui")
local KeyGui = Instance.new("ScreenGui", CoreGui)
local Main = Instance.new("Frame", KeyGui)
Main.Size = UDim2.new(0, 300, 0, 160); Main.Position = UDim2.new(0.5, -150, 0.5, -80); Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20); Instance.new("UICorner", Main)

local T = Instance.new("TextBox", Main)
T.Size = UDim2.new(0.8, 0, 0, 40); T.Position = UDim2.new(0.1, 0, 0.3, 0); T.PlaceholderText = "Insira a Key..."; T.BackgroundColor3 = Color3.fromRGB(40, 40, 40); T.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", T)

local B = Instance.new("TextButton", Main)
B.Size = UDim2.new(0.8, 0, 0, 40); B.Position = UDim2.new(0.1, 0, 0.65, 0); B.Text = "LOGAR"; B.BackgroundColor3 = Color3.fromRGB(255, 0, 0); B.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", B)

B.MouseButton1Click:Connect(function()
    if T.Text == KeyOficial then
        KeyGui:Destroy()
        LoadMain()
    else
        B.Text = "KEY INCORRETA"
        task.wait(1)
        B.Text = "LOGAR"
    end
end)
