local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🍌 Studio Banana Hub | V20",
   LoadingTitle = "Correction Navigation Maritime...",
   LoadingSubtitle = "par studio-banana-officiel",
   ConfigurationSaving = { Enabled = false }
})

-- VARIABLES
local AutoBoat = false
local SelectedBoat = "Dinghy"
local BoatSpeed = 150

-- ONGLET BATEAU (TOTALEMENT REFAIT)
local BoatTab = Window:CreateTab("⛵ Bateau")

BoatTab:CreateDropdown({
   Name = "1. Choisir le Bateau",
   Options = {"Dinghy", "Sloop", "Brigantine", "Grand Enforcer"},
   CurrentOption = {"Dinghy"},
   MultipleOptions = false,
   Callback = function(Option)
      SelectedBoat = Option[1]
   end,
})

BoatTab:CreateButton({
   Name = "2. Faire apparaître le bateau",
   Callback = function()
       -- Appel direct au serveur pour le bateau choisi
       game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat", SelectedBoat)
   end,
})

BoatTab:CreateToggle({
   Name = "3. Activer la Navigation (Auto-Move)",
   CurrentValue = false,
   Callback = function(Value)
      AutoBoat = Value
   end,
})

BoatTab:CreateSlider({
   Name = "Vitesse de navigation",
   Range = {100, 500},
   Increment = 10,
   CurrentValue = 150,
   Callback = function(Value)
      BoatSpeed = Value
   end,
})

-- LOGIQUE DE NAVIGATION "PRO"
spawn(function()
    while true do
        task.wait(0.1)
        if AutoBoat then
            pcall(function()
                local player = game.Players.LocalPlayer
                local character = player.Character
                
                -- Recherche du bateau avec ton nom dans le dossier Boats
                for _, v in pairs(game.Workspace.Boats:GetChildren()) do
                    if tostring(v:FindFirstChild("Owner")) == player.Name or v.Name:find(player.Name) then
                        local seat = v:FindFirstChildOfClass("VehicleSeat")
                        if seat then
                            -- Si tu n'es pas assis, le script te force sur le siège
                            if character.Humanoid.SeatPart ~= seat then
                                seat:Sit(character.Humanoid)
                            end
                            -- Application de la force pour avancer (Style Red Hub)
                            seat.Velocity = seat.CFrame.LookVector * BoatSpeed
                        end
                    end
                end
            end)
        end
    end
end)

-- ON GARDE TES AUTRES ONGLETS (AUTO-LEVEL, VISUEL, JOUEUR)
-- [Le code reste identique aux versions précédentes pour le reste]
