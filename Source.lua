-- [[ KA HUB | CORE ENGINE - SEA 1 ]]
local LP = game:GetService("Players").LocalPlayer
local RS = game:GetService("ReplicatedStorage")

_G.Config = {
    AutoFarm = false,
    FastAttack = true,
    Distance = 10,
    Weapon = "Melee"
}

-- Função de Ataque de Alta Velocidade (Sem Lag)
local function FastAttack()
    task.spawn(function()
        pcall(function()
            local CombatMod = require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework)
            local CurrentMod = require(game:GetService("ReplicatedStorage").CombatFramework.RigLib)
            
            if _G.Config.FastAttack then
                CombatMod.activeController.hitboxMagnitude = 55
                CombatMod.activeController.attackInterval = 0.1 -- Velocidade de elite
            end
        end)
    end)
end

-- Gerenciador de Armas (Equipa sozinho o que for melhor)
local function AutoEquip()
    if LP.Character:FindFirstChildOfClass("Tool") then return end
    for _, v in pairs(LP.Backpack:GetChildren()) do
        if v.ToolTip == _G.Config.Weapon or v:IsA("Tool") then
            LP.Character.Humanoid:EquipTool(v)
        end
    end
end

-- Sistema de Movimentação Anti-Queda
local function ToPos(pos)
    pcall(function()
        if (LP.Character.HumanoidRootPart.Position - pos.p).Magnitude > 500 then
            -- Teleporte instantâneo para distâncias longas
            LP.Character.HumanoidRootPart.CFrame = pos
        else
            -- Voo suave para evitar detecção
            local tween = game:GetService("TweenService"):Create(LP.Character.HumanoidRootPart, TweenInfo.new(1), {CFrame = pos})
            tween:Play()
        end
    end)
end
-- [[ KA HUB | PARTE 3: LOOP DE FARM PRINCIPAL ]]

task.spawn(function()
    while true do task.wait(0.1)
        if _G.Config.AutoFarm then
            pcall(function()
                -- 1. Verifica se há um Boss vivo primeiro (Prioridade de Script Premium)
                local Boss = CheckBoss()
                if Boss then
                    AutoEquip()
                    LP.Character.HumanoidRootPart.CFrame = Boss.HumanoidRootPart.CFrame * CFrame.new(0, _G.Config.Distance, 0)
                    FastAttack()
                    -- Se o Boss for o Saber Expert (Shanks), ele ataca com cuidado
                    game:GetService("VirtualUser"):Button1Down(Vector2.new(851, 158), workspace.CurrentCamera.CFrame)
                else
                    -- 2. Se não tem Boss, faz o Farm de Level comum
                    local MyQuest = GetMyQuest()
                    
                    -- Verifica se já tem a missão na tela
                    if not LP.PlayerGui.Main.Quest.Visible then
                        -- Teleporta para o NPC e pega a missão
                        ToPos(MyQuest.Pos)
                        if (LP.Character.HumanoidRootPart.Position - MyQuest.Pos.p).Magnitude < 10 then
                            RS.Remotes.CommF_:InvokeServer("StartQuest", MyQuest.QuestName, MyQuest.QuestID)
                        end
                    else
                        -- Se tem a missão, vai matar o inimigo alvo
                        local Enemy = workspace.Enemies:FindFirstChild(MyQuest.EnemyName) or workspace:FindFirstChild(MyQuest.EnemyName)
                        
                        if Enemy and Enemy:FindFirstChild("Humanoid") and Enemy.Humanoid.Health > 0 then
                            AutoEquip()
                            LP.Character.HumanoidRootPart.CFrame = Enemy.HumanoidRootPart.CFrame * CFrame.new(0, _G.Config.Distance, 0)
                            FastAttack()
                            game:GetService("VirtualUser"):Button1Down(Vector2.new(851, 158), workspace.CurrentCamera.CFrame)
                        else
                            -- Se o inimigo alvo não tá perto, procura pelo nome na pasta de inimigos
                            for _, v in pairs(workspace.Enemies:GetChildren()) do
                                if v.Name == MyQuest.EnemyName and v.Humanoid.Health > 0 then
                                    ToPos(v.HumanoidRootPart.CFrame * CFrame.new(0, _G.Config.Distance, 0))
                                    break
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
end)

print("Parte 3 (Farm Loop) carregada com sucesso!")
-- [[ KA HUB | PARTE 3: LOOP DE FARM PRINCIPAL ]]

task.spawn(function()
    while true do task.wait(0.1)
        if _G.Config.AutoFarm then
            pcall(function()
                -- 1. Verifica se há um Boss vivo primeiro (Prioridade de Script Premium)
                local Boss = CheckBoss()
                if Boss then
                    AutoEquip()
                    LP.Character.HumanoidRootPart.CFrame = Boss.HumanoidRootPart.CFrame * CFrame.new(0, _G.Config.Distance, 0)
                    FastAttack()
                    -- Se o Boss for o Saber Expert (Shanks), ele ataca com cuidado
                    game:GetService("VirtualUser"):Button1Down(Vector2.new(851, 158), workspace.CurrentCamera.CFrame)
                else
                    -- 2. Se não tem Boss, faz o Farm de Level comum
                    local MyQuest = GetMyQuest()
                    
                    -- Verifica se já tem a missão na tela
                    if not LP.PlayerGui.Main.Quest.Visible then
                        -- Teleporta para o NPC e pega a missão
                        ToPos(MyQuest.Pos)
                        if (LP.Character.HumanoidRootPart.Position - MyQuest.Pos.p).Magnitude < 10 then
                            RS.Remotes.CommF_:InvokeServer("StartQuest", MyQuest.QuestName, MyQuest.QuestID)
                        end
                    else
                        -- Se tem a missão, vai matar o inimigo alvo
                        local Enemy = workspace.Enemies:FindFirstChild(MyQuest.EnemyName) or workspace:FindFirstChild(MyQuest.EnemyName)
                        
                        if Enemy and Enemy:FindFirstChild("Humanoid") and Enemy.Humanoid.Health > 0 then
                            AutoEquip()
                            LP.Character.HumanoidRootPart.CFrame = Enemy.HumanoidRootPart.CFrame * CFrame.new(0, _G.Config.Distance, 0)
                            FastAttack()
                            game:GetService("VirtualUser"):Button1Down(Vector2.new(851, 158), workspace.CurrentCamera.CFrame)
                        else
                            -- Se o inimigo alvo não tá perto, procura pelo nome na pasta de inimigos
                            for _, v in pairs(workspace.Enemies:GetChildren()) do
                                if v.Name == MyQuest.EnemyName and v.Humanoid.Health > 0 then
                                    ToPos(v.HumanoidRootPart.CFrame * CFrame.new(0, _G.Config.Distance, 0))
                                    break
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
end)

print("Parte 3 (Farm Loop) carregada com sucesso!")
-- [[ KA HUB | PARTE 4: AUTO-BUY HAKIS & SKILLS ]]

_G.Config.AutoBuyHaki = true
_G.Config.AutoBuso = true

task.spawn(function()
    while true do task.wait(5) -- Verifica a cada 5 segundos para não dar lag
        if _G.Config.AutoBuyHaki then
            pcall(function()
                local cash = LP.Data.Beli.Value
                
                -- Compra Skyjump (Geppo) - 10,000 Beli
                if not LP.Character:FindFirstChild("DoubleJump") and cash >= 10000 then
                    RS.Remotes.CommF_:InvokeServer("BuyHaki", "Skyjump")
                end
                
                -- Compra Enhancement (Buso Haki) - 25,000 Beli
                if not LP.Character:FindFirstChild("HasBuso") and cash >= 25000 then
                    RS.Remotes.CommF_:InvokeServer("BuyHaki", "Enhancement")
                end
                
                -- Compra Flash Step (Soru) - 100,000 Beli
                if not LP.Character:FindFirstChild("HasSoru") and cash >= 100000 then
                    RS.Remotes.CommF_:InvokeServer("BuyHaki", "FlashStep")
                end
            end)
        end
        
        -- Ativa o Haki automaticamente se estiver desligado
        if _G.Config.AutoBuso then
            pcall(function()
                if not LP.Character:FindFirstChild("HasBuso") then return end -- Se não comprou ainda, ignora
                if not LP.Character:FindFirstChild("Appearance") or not LP.Character.Appearance:FindFirstChild("BodyColor") then
                    RS.Remotes.CommF_:InvokeServer("Buso")
                end
            end)
        end
    end
end)
-- [[ KA HUB | PARTE 5: AUTO-STATS INTELIGENTE ]]

_G.Config.AutoStats = true
_G.Config.StatsPrioridade = {
    ["Melee"] = 50,  -- Porcentagem de pontos em soco/energia
    ["Defense"] = 50 -- Porcentagem de pontos em vida
}

task.spawn(function()
    while true do task.wait(1)
        if _G.Config.AutoStats then
            pcall(function()
                local Points = LP.Data.StatsPoints.Value -- Verifica quantos pontos você tem para gastar
                if Points > 0 then
                    -- Distribui metade em Melee e metade em Defense para um boneco equilibrado
                    -- Você pode mudar para "Blox Fruit" ou "Sword" se preferir no futuro
                    RS.Remotes.CommF_:InvokeServer("AddPoint", "Melee", math.floor(Points * (_G.Config.StatsPrioridade["Melee"] / 100)))
                    RS.Remotes.CommF_:InvokeServer("AddPoint", "Defense", math.floor(Points * (_G.Config.StatsPrioridade["Defense"] / 100)))
                end
            end)
        end
    end
end)
-- [[ KA HUB | PARTE 6: INTERFACE FINAL PREMIUM ]]

local CoreGui = game:GetService("CoreGui")
local TS = game:GetService("TweenService")

-- Criando a ScreenGui principal
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "KAHUB_UI"

-- Botão Flutuante para Abrir/Fechar (Estilo Mobile)
local OpenBtn = Instance.new("TextButton", ScreenGui)
OpenBtn.Size = UDim2.new(0, 50, 0, 50)
OpenBtn.Position = UDim2.new(0, 10, 0.4, 0)
OpenBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
OpenBtn.Text = "KA"
OpenBtn.TextColor3 = Color3.new(1,1,1)
OpenBtn.Font = "GothamBold"
OpenBtn.TextSize = 18
local UICornerBtn = Instance.new("UICorner", OpenBtn)
UICornerBtn.CornerRadius = UDim.new(1, 0)

-- Janela Principal
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 450, 0, 300)
Main.Position = UDim2.new(0.5, -225, 0.5, -150)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.BorderSizePixel = 0
Main.Visible = false
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main)

-- Barra Lateral (Menu)
local SideBar = Instance.new("Frame", Main)
SideBar.Size = UDim2.new(0, 120, 1, 0)
SideBar.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Instance.new("UICorner", SideBar)

local UIList = Instance.new("UIListLayout", SideBar)
UIList.Padding = UDim.new(0, 5)
UIList.HorizontalAlignment = "Center"

-- Container de Conteúdo
local Content = Instance.new("Frame", Main)
Content.Size = UDim2.new(1, -130, 1, -10)
Content.Position = UDim2.new(0, 125, 0, 5)
Content.BackgroundTransparency = 1

-- Funções da Interface
OpenBtn.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
end)

local function CreateTab(name)
    local Page = Instance.new("ScrollingFrame", Content)
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.Visible = false
    Page.ScrollBarThickness = 2
    Instance.new("UIListLayout", Page).Padding = UDim.new(0, 5)

    local TabBtn = Instance.new("TextButton", SideBar)
    TabBtn.Size = UDim2.new(0.9, 0, 0, 35)
    TabBtn.Text = name
    TabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    TabBtn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", TabBtn)

    TabBtn.MouseButton1Click:Connect(function()
        for _, v in pairs(Content:GetChildren()) do v.Visible = false end
        Page.Visible = true
    end)
    return Page
end

local function CreateToggle(parent, text, config_key)
    local Tgl = Instance.new("TextButton", parent)
    Tgl.Size = UDim2.new(0.95, 0, 0, 40)
    Tgl.Text = text .. ": OFF"
    Tgl.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Tgl.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", Tgl)

    Tgl.MouseButton1Click:Connect(function()
        _G.Config[config_key] = not _G.Config[config_key]
        Tgl.Text = text .. ": " .. (_G.Config[config_key] and "ON" or "OFF")
        Tgl.BackgroundColor3 = _G.Config[config_key] and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(35, 35, 35)
    end)
end

-- Criando as Abas e Botões
local FarmTab = CreateTab("Main Farm")
local StatsTab = CreateTab("Status")

CreateToggle(FarmTab, "Auto Farm Level", "AutoFarm")
CreateToggle(FarmTab, "Ataque Rápido", "FastAttack")
CreateToggle(StatsTab, "Auto Distribuir Status", "AutoStats")
CreateToggle(StatsTab, "Comprar Hakis", "AutoBuyHaki")

FarmTab.Visible = true -- Começa na aba de Farm
-- [[ KA HUB | PARTE 7: AUTO SABER PUZZLE (SHANKS) ]]

_G.Config.AutoSaber = false

local function SolveSaberPuzzle()
    pcall(function()
        -- 1. Apertar os 5 Botões da Selva
        local Buttons = {
            CFrame.new(-1583, 37, 77), -- Botão 1
            CFrame.new(-1523, 40, -11), -- Botão 2
            CFrame.new(-1514, 30, 197), -- Botão 3
            CFrame.new(-1298, 41, -233), -- Botão 4
            CFrame.new(-1352, 33, 20)  -- Botão 5
        }
        
        for _, pos in pairs(Buttons) do
            LP.Character.HumanoidRootPart.CFrame = pos
            task.wait(0.5)
        end
        
        -- 2. Pegar a Tocha (Torch)
        -- Nota: O script voará até o porão da Selva
        LP.Character.HumanoidRootPart.CFrame = CFrame.new(-1610, 13, 153)
        task.wait(1)
        
        -- 3. Ir para o Deserto queimar a porta
        LP.Character.HumanoidRootPart.CFrame = CFrame.new(1113, 5, 4350)
        task.wait(2)
        
        -- 4. Ir para a Vila de Neve pegar o Copo e encher
        LP.Character.HumanoidRootPart.CFrame = CFrame.new(1386, -87, -1297) -- Dentro da caverna
        task.wait(1)
        
        -- 5. Falar com o Rich Man e matar o Mob Leader
        LP.Character.HumanoidRootPart.CFrame = CFrame.new(-2998, 7, 2432) -- Mob Leader
        -- Aqui o AutoFarm (Parte 3) detectará o inimigo e matará sozinho
    end)
end

-- Adicionando à aba de Farm da Interface (Parte 6)
-- Procure a linha onde criou o FarmTab e adicione:
local MiscTab = CreateTab("Misc/Puzzles")
CreateToggle(MiscTab, "Auto Saber Puzzle", "AutoSaber")

-- Loop do Puzzle
task.spawn(function()
    while true do task.wait(1)
        if _G.Config.AutoSaber then
            SolveSaberPuzzle()
            _G.Config.AutoSaber = false -- Desliga após completar
        end
    end
end)
-- [[ KA HUB | PARTE 8: ANTI-ADMIN & STAFF DETECTOR ]]

_G.Config.AntiAdmin = true

-- Lista de IDs conhecidos ou níveis de permissão (Badge de Admin)
local function CheckForAdmin()
    for _, player in pairs(game:GetService("Players"):GetPlayers()) do
        -- Verifica se o jogador tem o Badge de Admin da Roblox ou está em um grupo oficial
        if player:GetRankInGroup(2830838) >= 200 or player.IsNoob == false then -- Exemplo de ID de grupo do Blox Fruits
            if _G.Config.AntiAdmin then
                LP:Kick("\n[KA HUB ALERT]\nAdministrador detectado no servidor: " .. player.Name .. "\nSua conta foi desconectada por segurança.")
            end
        end
    end
end

-- Monitora novos jogadores que entrarem enquanto você estiver farmando
game:GetService("Players").PlayerAdded:Connect(function(player)
    if _G.Config.AntiAdmin then
        -- Se o jogador tiver nome de "Admin", "Mod" ou "Staff" (filtro simples)
        local name = player.Name:lower()
        if name:find("admin") or name:find("staff") or name:find("mod") then
            LP:Kick("[KA HUB] Possível Staff detectado. Saindo...")
        end
    end
end)

-- Loop de checagem constante
task.spawn(function()
    while true do task.wait(2)
        if _G.Config.AntiAdmin then
            CheckForAdmin()
        end
    end
end)

-- Adicionando o botão na aba Misc
-- Procure a sua aba MiscTab criada anteriormente e adicione:
CreateToggle(MiscTab, "Anti-Admin (Auto Kick)", "AntiAdmin")
StartKAHUB()
