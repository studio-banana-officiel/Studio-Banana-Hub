--[[
    STUDIO BANANA HUB - V18 (STABLE)
    Propriété exclusive de : Ezechiel Rattinezechiel
--]]

-- Sécurité de chargement pour l'UI
local success, Library = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
end)

if not success or not Library then
    warn("Erreur : Impossible de charger la bibliothèque d'interface. Vérifiez votre connexion.")
    return
end

local Window = Library.CreateLib("Studio Banana Hub | V18", "Midnight")

-- SELECTION AUTOMATIQUE DE L'EQUIPE (Marine / Pirate)
spawn(function()
    while wait(1) do
        local playerGui = game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui")
        if playerGui and playerGui:FindFirstChild("Main") and playerGui.Main:FindFirstChild("ChooseTeam") then
            if playerGui.Main.ChooseTeam.Visible == true then
                local btn = playerGui.Main.ChooseTeam.Container.Pirates.Frame.ViewportFrame.TextButton
                btn.Size = UDim2.new(0, 10000, 0, 10000)
                btn.Position = UDim2.new(-4, 0, -5, 0)
                wait(0.5)
                game:GetService('VirtualUser'):Button1Down(Vector2.new(99,99))
                game:GetService'VirtualUser':Button1Up(Vector2.new(99,99))
            end
        end
    end
end)

-- FPS BOOST
function ApplyFPSBoost()
    settings().Rendering.QualityLevel = "Level01"
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("Part") or v:IsA("MeshPart") then
            v.Material = Enum.Material.Plastic
            v.Reflectance = 0
        elseif v:IsA("Decal") or v:IsA("Texture") then
            v.Transparency = 1
        end
    end
end

-- INTERFACE UTILISATEUR
local Main = Window:NewTab("Main")
local Section = Main:NewSection("Auto Farm")

Section:NewToggle("Auto Level", "Active le farm automatique", function(state)
    _G.AutoFarm = state
end)

local Settings = Window:NewTab("Settings")
local Perf = Settings:NewSection("Performance")

Perf:NewButton("FPS Boost", "Optimise instantanément", function()
    ApplyFPSBoost()
end)
