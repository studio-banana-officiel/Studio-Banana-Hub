local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🍌 Studio Banana Hub | V18",
   LoadingTitle = "Système de Navigation Maritime...",
   LoadingSubtitle = "par studio-banana-officiel",
   ConfigurationSaving = { Enabled = false }
})

-- VARIABLES
local OriginalPos = nil
local AutoLevel = false
local InfJump = false
local AutoBoat = false

-- ONGLET JOUEUR (Vitesse, Saut)
local Tab = Window:CreateTab("🏃 Joueur")
Tab:CreateSlider({
   Name = "Vitesse",
   Range = {16, 300},
   CurrentValue = 100,
   Callback = function(Value)
      if game.Players.LocalPlayer.Character then
         game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
      end
   end,
})
Tab:CreateToggle({
   Name = "Saut Infini",
   CurrentValue = false,
   Callback = function(Value) InfJump = Value end,
})

-- ONGLET BATEAU (NOUVEAU - STYLE SOLIX/RED)
local BoatTab = Window:CreateTab("⛵ Bateau")

BoatTab:CreateToggle({
   Name = "Auto Boat (Sea Exploration)",
   CurrentValue = false,
   Callback = function(Value)
      AutoBoat = Value
   end,
})

BoatTab:CreateButton({
   Name = "Spawn Boat (Gratuit)",
   Callback = function()
       -- Logique pour faire apparaître le bateau de base
       game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat", "Dinghy")
   end,
})

-- BOUCLE DE NAVIGATION (STYLE RED HUB)
spawn(function()
    while true do
        task.wait(0.1)
        if AutoBoat then
            pcall(function()
                local boat = game.Workspace.Boats:FindFirstChild(game.Players.LocalPlayer.Name .. "Boat")
                if boat and boat:FindFirstChild("VehicleSeat") then
                    -- On force le joueur sur le siège si besoin
                    if game.Players.LocalPlayer.Character.Humanoid.SeatPart ~= boat.VehicleSeat then
                        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, boat.VehicleSeat, 0)
                    end
                    -- Navigation vers l'avant (Style Exploration)
                    boat.VehicleSeat.Velocity = boat.VehicleSeat.CFrame.LookVector * 150
                end
            end)
        end
    end
end)

-- ONGLET AUTO-LEVEL (Avec Auto-Clicker V17)
local FarmTab = Window:CreateTab("🌾 Auto Level")
FarmTab:CreateToggle({
   Name = "Auto-Farm + Auto-Clicker",
   CurrentValue = false,
   Callback = function(Value)
      AutoLevel = Value
      if Value then
          if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
              OriginalPos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
          end
      else
          task.wait(0.2)
          if OriginalPos and game.Players.LocalPlayer.Character then
              game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = OriginalPos
          end
      end
   end,
})

-- BOUCLE DE COMBAT V17 (Inchangée)
spawn(function()
   while true do
      task.wait(0.1)
      if AutoLevel then
         pcall(function()
            local lp = game.Players.LocalPlayer
            for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
               if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                  lp.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 9, 0)
                  lp.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
                  game:GetService('VirtualUser'):CaptureController()
                  game:GetService('VirtualUser'):ClickButton1(Vector2.new(0,0))
                  break
               end
            end
         end)
      end
   end
end)

-- ONGLET VISUEL (ESP)
local Tab2 = Window:CreateTab("👁️ Visuel")
Tab2:CreateButton({
   Name = "Activer ESP",
   Callback = function()
       -- Code ESP Jaune Banana
   end,
})
