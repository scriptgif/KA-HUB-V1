-- [[ KA HUB | LOADER COM INTERFACE ]]
local KeyOficial = "KA-"..os.date("%d%m").."-HUB"

-- Função para carregar o seu script principal
local function LoadMain()
    -- Link do seu source (já apontei para o seu usuário scriptgif)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptgif/KA-HUB-V1/main/source.lua"))()
end

-- CRIANDO A INTERFACE DE KEY (Telinha que aparece no Roblox)
local CoreGui = game:GetService("CoreGui")
local KeyGui = Instance.new("ScreenGui", CoreGui)

local Main = Instance.new("Frame", KeyGui)
Main.Size = UDim2.new(0, 300, 0, 160)
Main.Position = UDim2.new(0.5, -150, 0.5, -80)
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Instance.new("UICorner", Main)

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "KA HUB | SISTEMA DE KEY"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.Font = "GothamBold"

local KBInput = Instance.new("TextBox", Main)
KBInput.Size = UDim2.new(0.8, 0, 0, 35)
KBInput.Position = UDim2.new(0.1, 0, 0.35, 0)
KBInput.PlaceholderText = "Cole a Key aqui..."
KBInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
KBInput.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", KBInput)

local KBtn = Instance.new("TextButton", Main)
KBtn.Size = UDim2.new(0.8, 0, 0, 35)
KBtn.Position = UDim2.new(0.1, 0, 0.65, 0)
KBtn.Text = "LOGAR"
KBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
KBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", KBtn)

-- LÓGICA DO BOTÃO
KBtn.MouseButton1Click:Connect(function()
    if KBInput.Text == KeyOficial then
        Title.Text = "Key Correta! Carregando..."
        Title.TextColor3 = Color3.new(0, 1, 0)
        task.wait(1)
        KeyGui:Destroy()
        LoadMain() -- Chama o seu source.lua
    else
        Title.Text = "Key Errada!"
        Title.TextColor3 = Color3.new(1, 0, 0)
        task.wait(1)
        Title.Text = "KA HUB | SISTEMA DE KEY"
        Title.TextColor3 = Color3.new(1, 1, 1)
    end
end)
