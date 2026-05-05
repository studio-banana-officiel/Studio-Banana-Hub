local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🍌 Studio Banana Hub | V18",
   LoadingTitle = "Initialisation Blox Fruits...",
   LoadingSubtitle = "par studio-banana-officiel",
   ConfigurationSaving = { Enabled = false }
})

-- SERVICES & VARIABLES
local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local RS = game:GetService("ReplicatedStorage")
local VU = game:GetService("VirtualUser")

local AutoLevel = false
local AutoBoat = false
local InfJump = false
local SelectedBoat = "Dinghy"
local OriginalPos = nil

-- ==========================================
-- 🏃 ONGLET JOUEUR
-- ==========================================
local PlayerTab = Window:CreateTab("🏃 Joueur")

PlayerTab:CreateSlider({
   Name = "Vitesse de marche",
   Range = {16, 300},
   CurrentValue = 16,
   Callback = function(v)
      if lp.Character and lp.Character:FindFirstChild("Humanoid") then
         lp.Character.Humanoid.WalkSpeed = v
      end
   end,
})

PlayerTab:CreateToggle({
   Name = "Saut Infini",
   CurrentValue = false,
   Callback = function(v) InfJump = v end,
})

-- Logique Saut Infini
game:GetService("UserInputService").JumpRequest:Connect(function()
    if InfJump and lp.Character and lp.Character:FindFirstChildOfClass("Humanoid") then
        lp.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- ==========================================
-- ⛵ ONGLET NAVIGATION (STYLE RED HUB)
-- ==========================================
local BoatTab = Window:CreateTab("⛵ Bateau")

BoatTab:CreateToggle({
   Name = "Auto Boat (Exploration)",
   CurrentValue = false,
   Callback = function(v) AutoBoat = v end,
})

BoatTab:CreateButton({
   Name = "Spawn Boat (Gratuit)",
   Callback = function()
       RS.Remotes.CommF_:InvokeServer("BuyBoat", "Dinghy")
   end,
})

-- Boucle de Navigation
spawn(function()
    while task.wait(0.1) do
        if AutoBoat then
            pcall(function()
                -- Recherche du bateau possédé par le joueur
                for _, boat in pairs(workspace.Boats:GetChildren()) do
                    local owner = boat:FindFirstChild("Owner")
                    if owner and (owner.Value == lp.Name or owner.Value == lp) then
                        local seat = boat:FindFirstChildOfClass("VehicleSeat")
                        if seat then
                            -- Force l'assise si pas sur le siège
                            if lp.Character.Humanoid.SeatPart ~= seat then
                                lp.Character.HumanoidRootPart.CFrame = seat.CFrame
                            end
                            -- Mouvement (On utilise Velocity pour la compatibilité)
                            seat.Velocity = seat.CFrame.LookVector * 150
                        end
                    end
                end
            end)
        end
    end
end)

-- ==========================================
-- ⚔️ ONGLET AUTO-FARM (V18 STABLE)
-- ==========================================
local FarmTab = Window:CreateTab("🌾 Auto Farm")

FarmTab:CreateToggle({
   Name = "Auto-Farm Level (Quêtes + Combat)",
   CurrentValue = false,
   Callback = function(v) 
      AutoLevel = v 
      if v then 
         OriginalPos = lp.Character.HumanoidRootPart.CFrame 
      end
   end,
})

-- LOGIQUE DE COMBAT ET QUÊTES
spawn(function()
    while task.wait(0.1) do
        if AutoLevel then
            pcall(function()
                -- 1. Vérification de la quête (si on n'en a pas, on en prend une)
                local data = lp.Data
                if data.Quest.Value == "" then
                    -- Note: Dans un vrai script complet, on listerait les NPCs par niveau.
                    -- Ici on simule l'appel à la quête la plus proche.
                    RS.Remotes.CommF_:InvokeServer("StartQuest", "BanditQuest1", 1) 
                else
                    -- 2. Recherche et TP sur les ennemis
                    -- Blox Fruits place souvent les ennemis dans workspace ou workspace.Enemies
                    local enemies = workspace:FindFirstChild("Enemies") or workspace
                    for _, enemy in pairs(enemies:GetChildren()) do
                        if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                            -- Positionnement "Safe" au-dessus de l'ennemi
                            lp.Character.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0)
                            
                            -- Désactiver la gravité pour ne pas tomber
                            lp.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)

                            -- Auto Click (Attack)
                            VU:CaptureController()
                            VU:ClickButton1(Vector2.new(0,0))
                            break
                        end
                    end
                end
            end)
        end
    end
end)

-- ==========================================
-- 👁️ VISUEL & NOTIFS
-- ==========================================
local VisualTab = Window:CreateTab("👁️ Visuel")
VisualTab:CreateButton({
   Name = "Activer ESP (Simple)",
   Callback = function()
       for _, p in pairs(Players:GetPlayers()) do
           if p ~= lp and p.Character then
               local b = Instance.new("BoxHandleAdornment", p.Character)
               b.Adornee = p.Character
               b.Size = Vector3.new(4, 6, 1)
               b.Color3 = Color3.fromRGB(255, 255, 0) -- Jaune Banana
               b.AlwaysOnTop = true
               b.ZIndex = 10
               b.Transparency = 0.5
           end
       end
   end,
})

Rayfield:Notify({
   Title = "Banana Hub Chargé",
   Content = "Prêt pour Blox Fruits !",
   Duration = 5,
   Image = 4483362458,
})
