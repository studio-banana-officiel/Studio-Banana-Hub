local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🍌 Studio Banana Hub | V19",
   LoadingTitle = "Correction du Système Maritime...",
   LoadingSubtitle = "par studio-banana-officiel",
   ConfigurationSaving = { Enabled = false }
})

-- VARIABLES
local AutoBoat = false
local SelectedBoat = "Dinghy"
local BoatSpeed = 150

-- ONGLET BATEAU (AMÉLIORÉ)
local BoatTab = Window:CreateTab("⛵ Bateau")

BoatTab:CreateDropdown({
   Name = "Choisir ton Bateau",
   Options = {"Dinghy", "Sloop", "Brigantine", "Grand Enforcer", "Swan Boat"},
   CurrentOption = {"Dinghy"},
   MultipleOptions = false,
   Callback = function(Option)
      SelectedBoat = Option[1]
   end,
})

BoatTab:CreateButton({
   Name = "Faire apparaître le bateau choisi",
   Callback = function()
       game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat", SelectedBoat)
   end,
})

BoatTab:CreateToggle({
   Name = "Auto-Navigate (Vitesse Solix)",
   CurrentValue = false,
   Callback = function(Value)
      AutoBoat = Value
   end,
})

BoatTab:CreateSlider({
   Name = "Vitesse du Bateau",
   Range = {100, 500},
   Increment = 10,
   CurrentValue = 150,
   Callback = function(Value)
      BoatSpeed = Value
   end,
})

-- BOUCLE DE NAVIGATION CORRIGÉE
spawn(function()
    while true do
        task.wait(0.1)
        if AutoBoat then
            pcall(function()
                -- On cherche le bateau qui appartient au joueur
                local myBoat = nil
                for _, v in pairs(game.Workspace.Boats:GetChildren()) do
                    if v:FindFirstChild("Owner") and v.Owner.Value == game.Players.LocalPlayer.Name then
                        myBoat = v
                        break
                    end
                end

                if myBoat and myBoat:FindFirstChild("VehicleSeat") then
                    local seat = myBoat.VehicleSeat
                    -- On s'assoit automatiquement
                    if game.Players.LocalPlayer.Character.Humanoid.SeatPart ~= seat then
                        seat:Sit(game.Players.LocalPlayer.Character.Humanoid)
                    end
                    -- Mouvement fluide vers l'avant
                    seat.Velocity = seat.CFrame.LookVector * BoatSpeed
                end
            end)
        end
    end
end)

-- ON GARDE TES AUTRES FONCTIONS (AUTO-LEVEL, JOUEUR, ETC.)
-- [Le reste du code pour l'Auto-Level V17 et le Visuel reste le même]
