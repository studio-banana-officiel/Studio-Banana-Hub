-- STUDIO BANANA HUB V5 - AUTO-FARM & MOVEMENT
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🍌 Studio Banana Hub",
   LoadingTitle = "Projet Viral : Blox Fruits",
   LoadingSubtitle = "par studio-banana-officiel",
   ConfigurationSaving = { Enabled = false }
})

-- ONGLET MOUVEMENT (REMIS ET AMÉLIORÉ)
local Tab = Window:CreateTab("🏃 Joueur")

Tab:CreateSlider({
   Name = "Vitesse",
   Range = {16, 300},
   Increment = 1,
   CurrentValue = 100,
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
   end,
})

local InfJump = false
Tab:CreateToggle({
   Name = "Saut Infini",
   CurrentValue = false,
   Callback = function(Value)
      InfJump = Value
   end,
})

-- Système de Saut Infini
game:GetService("UserInputService").JumpRequest:Connect(function()
   if InfJump then
      game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
   end
end)

-- ONGLET AUTO-LEVEL
local FarmTab = Window:CreateTab("🌾 Auto Level")

local AutoLevel = false
FarmTab:CreateToggle({
   Name = "Activer Auto-Farm",
   CurrentValue = false,
   Callback = function(Value)
      AutoLevel = Value
   end,
})

-- BOUCLE DE FARM AMÉLIORÉE
spawn(function()
   while true do
      task.wait(0.1)
      if AutoLevel then
         pcall(function()
            local player = game.Players.LocalPlayer
            local character = player.Character
            -- On cherche les ennemis
            for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                    -- Cette ligne force l'attaque si l'ennemi est là
                    local VirtualUser = game:GetService('VirtualUser')
                    VirtualUser:Button1Down(Vector2.new(0,0), game.Workspace.CurrentCamera.CFrame)
                end
            end
         end)
      end
   end
end)
