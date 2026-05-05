--[[
    STUDIO BANANA HUB
    Propriété de : Ezechiel Rattinezechiel
--]]

-- Initialisation de l'UI
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Studio Banana Hub | BLOX FRUIT", "Midnight")

-- Détection automatique du Monde (PlaceId)
local PlaceId = game.PlaceId
local World = ""
if PlaceId == 2753915549 then
    World = "Old World"
elseif PlaceId == 4442245229 then
    World = "New World"
elseif PlaceId == 744995991 then
    World = "Third World"
end

-- Fonction FPS Boost (Optimisation du système)
function FPSBoost()
    local decalsyeeter = true
    local g = game
    local w = g.Workspace
    local l = g.Lighting
    local t = w.Terrain
    t.WaterWaveSize = 0
    t.WaterWaveSpeed = 0
    t.WaterReflectance = 0
    t.WaterTransparency = 0
    l.GlobalShadows = false
    l.FogEnd = 9e9
    l.Brightness = 0
    for i, v in pairs(g:GetDescendants()) do
        if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
            v.Material = "Plastic"
            v.Reflectance = 0
        elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeter then
            v.Transparency = 1
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v.Lifetime = NumberRange.new(0)
        elseif v:IsA("Explosion") then
            v.BlastPressure = 1
            v.BlastRadius = 1
        end
    end
end

-- Système de Quêtes Automatiques (CheckQuest)
function CheckQuest()
    local Level = game.Players.LocalPlayer.Data.Level.Value
    if Level >= 1 and Level <= 9 then
        return "Bandit", "BanditQuest1", 1, CFrame.new(1059.37195, 15.4495068, 1550.4231), CFrame.new(1145, 17, 1630)
    elseif Level >= 10 and Level <= 14 then
        return "Monkey", "JungleQuest", 1, CFrame.new(-1598, 35, 153), CFrame.new(-1600, 36, 150)
    elseif Level >= 15 and Level <= 29 then
        return "Gorilla", "JungleQuest", 2, CFrame.new(-1598, 35, 153), CFrame.new(-1200, 10, -500)
    -- Continue avec les autres niveaux ici...
    end
end

-- Onglet Principal
local Main = Window:NewTab("Main")
local Section = Main:NewSection("Auto Farm")

Section:NewToggle("Auto Level", "Lance le farm automatique", function(state)
    _G.AutoFarm = state
    spawn(function()
        while _G.AutoFarm do
            wait()
            pcall(function()
                local Name, Quest, ID, PosQuest, PosMon = CheckQuest()
                -- La logique de combat et de mouvement s'insère ici
            end)
        end
    end)
end)

-- Onglet Combat / Styles
local Combat = Window:NewTab("Combat")
local Styles = Combat:NewSection("Fighting Styles")

Styles:NewToggle("Auto Superhuman", "Farm les styles pour Superhuman", function(state)
    _G.AutoSuperhuman = state
    spawn(function()
        while _G.AutoSuperhuman do
            wait()
            -- Logique d'achat : Black Leg, Electro, Fishman, Dragon Claw
        end
    end)
end)

-- Onglet Paramètres
local Settings = Window:NewTab("Settings")
local Config = Settings:NewSection("Optimisation")

Config:NewButton("FPS Boost", "Réduit les lags graphiques", function()
    FPSBoost()
end)

-- Sélection automatique de l'équipe au démarrage
spawn(function()
    local teamGui = game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("Main"):WaitForChild("ChooseTeam")
    if teamGui then
        local pirateBtn = teamGui.Container.Pirates.Frame.ViewportFrame.TextButton
        game:GetService("VirtualUser"):ClickButton1(Vector2.new(9e9, 9e9))
        fireclickdetector(pirateBtn)
    end
end)
