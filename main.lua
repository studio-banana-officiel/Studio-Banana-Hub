
-- STUDIO BANANA HUB V1
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Studio Banana Hub", "DarkScene")

-- ONGLET PRINCIPAL
local Main = Window:NewTab("Joueur")
local MainSection = Main:NewSection("Boosts de Mouvement")

-- Bouton Vitesse
MainSection:NewButton("Vitesse Éclair (200)", "Cours super vite", function()
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 200
end)

-- Bouton Saut
MainSection:NewButton("Super Saut (300)", "Saute très haut", function()
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = 300
end)

-- ONGLET VISUEL (ESP)
local Visual = Window:NewTab("Visuel")
local VisualSection = Visual:NewSection("ESP Joueurs")

VisualSection:NewButton("Activer ESP", "Voir les joueurs à travers les murs", function()
    -- Ton code ESP simplifié ici
    for _, v in pairs(game.Players:GetPlayers()) do
        if v.Name ~= game.Players.LocalPlayer.Name then
            local bgui = Instance.new("BillboardGui", v.Character.Head)
            bgui.Size = UDim2.new(0,100,0,50)
            bgui.AlwaysOnTop = true
            local tl = Instance.new("TextLabel", bgui)
            tl.Size = UDim2.new(1,0,1,0)
            tl.Text = v.Name
            tl.TextColor3 = Color3.new(1,1,1)
            tl.BackgroundTransparency = 1
        end
    end
end)
