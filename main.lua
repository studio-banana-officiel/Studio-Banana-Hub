local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🍌 Studio Banana Hub | V15",
   LoadingTitle = "Correction du système de TP...",
   LoadingSubtitle = "par studio-banana-officiel",
   ConfigurationSaving = { Enabled = false }
})

-- VARIABLES DE MÉMOIRE
local OriginalPos = nil
local AutoLevel = false

-- ONGLET JOUEUR
local Tab = Window:CreateTab("🏃 Joueur")

local InfJump = false
Tab:CreateToggle({
   Name = "Saut Infini",
   CurrentValue = false,
   Callback = function(Value) InfJump = Value end,
})

-- ONGLET AUTO-LEVEL
local FarmTab = Window:CreateTab("🌾 Auto Level")

FarmTab:CreateToggle({
   Name = "Auto-Farm (Retour au point de départ)",
   CurrentValue = false,
   Callback = function(Value)
      AutoLevel = Value
      
      if Value == true then
          -- On sauvegarde l'endroit exact AVANT de bouger
          if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
              OriginalPos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
              print("Position de départ sauvegardée !")
          end
      else
          -- Dès qu'on coupe (Value == false), on force le retour
          task.wait(0.1)
          if OriginalPos and game.Players.LocalPlayer.Character then
              game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = OriginalPos
              print("Retour à la position initiale effectué.")
          end
      end
   end,
})

-- BOUCLE DE FARM FLUIDE
spawn(function()
   while true do
      task.wait(0.1)
      if AutoLevel then
         pcall(function()
            local lp = game.Players.LocalPlayer
            for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
               if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                  -- On reste en l'air à 9 studs
                  lp.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 9, 0)
                  
                  -- Auto-Click
                  local VirtualUser = game:GetService('VirtualUser')
                  VirtualUser:CaptureController()
                  VirtualUser:ClickButton1(Vector2.new(0,0))
                  break
               end
            end
         end)
      end
   end
end)
