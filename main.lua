local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🍌 Studio Banana Hub | Blox Fruits",
   LoadingTitle = "Projet Viral : Studio Banana",
   LoadingSubtitle = "par studio-banana-officiel",
   ConfigurationSaving = { Enabled = false }
})

-- ONGLET JOUEUR (Vitesse + Saut)
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

-- Script Technique du Saut
game:GetService("UserInputService").JumpRequest:Connect(function()
   if InfJump then
      game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
   end
end)

-- ONGLET AUTO-LEVEL (Attaque forcée)
local FarmTab = Window:CreateTab("🌾 Auto Level")

local AutoLevel = false
FarmTab:CreateToggle({
   Name = "Activer Auto-Farm",
   CurrentValue = false,
   Callback = function(Value)
      AutoLevel = Value
   end,
})

-- Boucle Auto-Level
spawn(function()
   while true do
      task.wait(0.1)
      if AutoLevel then
         pcall(function()
            -- Simule un clic pour attaquer avec ton arme équipée
            local VirtualUser = game:GetService('VirtualUser')
            VirtualUser:CaptureController()
            VirtualUser:ClickButton1(Vector2.new(0,0))
         end)
      end
   end
end)

-- ONGLET VISUEL (Avec bouton Désactiver)
local Tab2 = Window:CreateTab("👁️ Visuel")

Tab2:CreateButton({
   Name = "Activer ESP (Noms)",
   Callback = function()
       for _, v in pairs(game.Players:GetPlayers()) do
           if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Head") then
               local bgui = Instance.new("BillboardGui", v.Character.Head)
               bgui.Name = "BananaESP"
               bgui.Size = UDim2.new(0,100,0,50)
               bgui.AlwaysOnTop = true
               local tl = Instance.new("TextLabel", bgui)
               tl.Size = UDim2.new(1,0,1,0)
               tl.Text = v.Name
               tl.TextColor3 = Color3.fromRGB(255, 255, 0)
               tl.BackgroundTransparency = 1
           end
       end
   end,
})

Tab2:CreateButton({
   Name = "Désactiver le Visuel",
   Callback = function()
       for _, v in pairs(game.Players:GetPlayers()) do
           if v.Character and v.Character:FindFirstChild("Head") then
               local esp = v.Character.Head:FindFirstChild("BananaESP")
               if esp then esp:Destroy() end
           end
       end
   end,
})
