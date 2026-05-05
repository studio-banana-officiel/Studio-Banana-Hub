--[[
    STUDIO BANANA HUB - VERSION 18
    Propriété exclusive de : Ezechiel Rattinezechiel (ezekiel1169)
--]]

-- Configuration Initiale de l'UI
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Studio Banana Hub | V18", "Midnight")

-- SELECTION AUTOMATIQUE DE L'EQUIPE (Marine / Pirate)
if not _G.Marine or _G.Pirate then
    spawn(function()
        while wait() do
            if game:GetService("Players")["LocalPlayer"].PlayerGui.Main.ChooseTeam.Visible == true then
                game:GetService("Players")["LocalPlayer"].PlayerGui.Main.ChooseTeam.Container.Pirates.Frame.ViewportFrame.TextButton.Size = UDim2.new(0, 10000, 0, 10000)
                game:GetService("Players")["LocalPlayer"].PlayerGui.Main.ChooseTeam.Container.Pirates.Frame.ViewportFrame.TextButton.Position = UDim2.new(-4, 0, -5, 0)
                game:GetService("Players")["LocalPlayer"].PlayerGui.Main.ChooseTeam.Container.Pirates.Frame.ViewportFrame.TextButton.BackgroundTransparency = 1
                wait(.5)
                game:GetService'VirtualUser':Button1Down(Vector2.new(99,99))
                game:GetService'VirtualUser':Button1Up(Vector2.new(99,99))
            end      
        end
    end)
end

if _G.Marine then
    spawn(function()
        while wait() do
            if game:GetService("Players")["LocalPlayer"].PlayerGui.Main.ChooseTeam.Visible == true then
                game:GetService("Players")["LocalPlayer"].PlayerGui.Main.ChooseTeam.Container.Marines.Frame.ViewportFrame.TextButton.Size = UDim2.new(0, 10000, 0, 10000)
                game:GetService("Players")["LocalPlayer"].PlayerGui.Main.ChooseTeam.Container.Marines.Frame.ViewportFrame.TextButton.Position = UDim2.new(-4, 0, -5, 0)
                game:GetService("Players")["LocalPlayer"].PlayerGui.Main.ChooseTeam.Container.Marines.Frame.ViewportFrame.TextButton.BackgroundTransparency = 1
                wait(.5)
                game:GetService'VirtualUser':Button1Down(Vector2.new(99,99))
                game:GetService'VirtualUser':Button1Up(Vector2.new(99,99))
            end
        end
    end)
end

-- FPS BOOST AMÉLIORÉ
if _G.FPSBoost then
    spawn(function()
        wait(3)
        local decalsyeeted = true
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
        settings().Rendering.QualityLevel = "Level01"
        for i, v in pairs(g:GetDescendants()) do
            if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then 
                v.Material = "Plastic"
                v.Reflectance = 0
            elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
                v.Transparency = 1
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                v.Lifetime = NumberRange.new(0)
            elseif v:IsA("Explosion") then
                v.BlastPressure = 1
                v.BlastRadius = 1
            elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
                v.Enabled = false
            elseif v:IsA("MeshPart") then
                v.Material = "Plastic"
                v.Reflectance = 0
                v.TextureID = 10385902758728957
            end
        end
        for i, e in pairs(l:GetChildren()) do
            if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
                e.Enabled = false
            end
        end
    end)
end

-- DÉTECTION DU MONDE
local placeId = game.PlaceId
Magnet = true
if placeId == 2753915549 then
    OldWorld = true
elseif placeId == 4442272183 then
    NewWorld = true
elseif placeId == 7449423635 then
    ThreeWorld = true
end

-- FONCTION DE COMBAT
function Click()
    game:GetService'VirtualUser':CaptureController()
    game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
end

_G.FarmSwiish = true
spawn(function()
    while wait() do
        pcall(function()
            _G.FarmSwiish = true
            wait(3)
            _G.FarmSwiish = false
            wait(3)
        end)
    end
end)

-- INTERFACE UTILISATEUR
local Main = Window:NewTab("Main")
local Section = Main:NewSection("Auto Farm")

Section:NewToggle("Auto Level", "Active le farm automatique", function(state)
    _G.AutoFarm = state
end)

local Settings = Window:NewTab("Settings")
local Perf = Settings:NewSection("Performance")

Perf:NewToggle("Enable FPS Boost", "Optimise le jeu au lancement", function(state)
    _G.FPSBoost = state
end)
