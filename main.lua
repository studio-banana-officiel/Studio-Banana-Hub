local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🍌 Studio Banana Hub | V21",
   LoadingTitle = "Optimisation Console & Bateau...",
   LoadingSubtitle = "par studio-banana-officiel",
   ConfigurationSaving = { Enabled = false }
})

-- VARIABLES
local AutoBoat = false
local SelectedBoat = "Dinghy"
local BoatSpeed = 150

-- ONGLET BATEAU
local BoatTab = Window:CreateTab("⛵ Bateau")

BoatTab:CreateDropdown({
   Name = "1. Choisir le Bateau",
   Options = {"Dinghy", "Sloop", "Brigantine", "Grand Enforcer"},
   CurrentOption = {"Dinghy"},
   MultipleOptions = false,
   Callback = function(Option) SelectedBoat = Option[1] end,
})

BoatTab:CreateButton({
   Name = "2. Faire apparaître le bateau",
   Callback = function()
       game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat", SelectedBoat)
   end,
})

BoatTab:CreateToggle({
   Name = "3. Navigation Auto (Force Mode)",
   CurrentValue = false,
   Callback = function(Value)
      AutoBoat = Value
   end,
})

-- SYSTÈME DE NAVIGATION OPTIMISÉ (POUR ÉVITER LES ERREURS CONSOLE)
spawn(function()
    while true do
        task.wait(0.5) -- On attend plus longtemps pour ne pas saturer la console
        if AutoBoat then
            pcall(function()
                local player = game.Players.LocalPlayer
                local character = player.Character
                
                for _, v in pairs(game.Workspace.Boats:GetChildren()) do
                    if v:FindFirstChild("Owner") and v.Owner.Value == player.Name then
                        local seat = v:FindFirstChildOfClass("VehicleSeat")
                        if seat then
                            -- On s'assoit une seule fois
                            if character.Humanoid.SeatPart ~= seat then
                                seat:Sit(character.Humanoid)
                            end
                            
                            -- Ajout d'une force constante (évite les lags Windows 11)
                            local bv = seat:FindFirstChild("BananaVelocity") or Instance.new("BodyVelocity", seat)
                            bv.Name = "BananaVelocity"
                            bv.MaxForce = Vector3.new(9e9, 0, 9e9)
                            bv.Velocity = seat.CFrame.LookVector * BoatSpeed
                        end
                    end
                end
            end)
        else
            -- On nettoie la force quand on éteint
            pcall(function()
                for _, v in pairs(game.Workspace.Boats:GetChildren()) do
                    local seat = v:FindFirstChildOfClass("VehicleSeat")
                    if seat and seat:FindFirstChild("BananaVelocity") then
                        seat.BananaVelocity:Destroy()
                    end
                end
            end)
        end
    end
end)

-- ON GARDE TES AUTRES ONGLETS (AUTO-LEVEL, VISUEL, JOUEUR)
