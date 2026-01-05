-- [[ KA HUB | LOADER OFICIAL ]]
local KeyOficial = "KA-"..os.date("%d%m").."-HUB"

-- Função que puxa o código principal do seu GitHub
local function LoadMain()
    -- IMPORTANTE: Troque o link abaixo pelo seu link RAW do source.lua
    loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptgif/KA-HUB-V1/refs/heads/main/Source.lua"))()
end

-- Aqui você coloca aquela telinha de "Insira a Key" que criamos
-- No botão de confirmar da telinha, você coloca:
-- if TextBox.Text == KeyOficial then
--    LoadMain()
-- end
