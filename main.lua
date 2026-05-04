-- STUDIO BANANA HUB V3 - EDITION BLOX FRUITS
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🍌 Studio Banana Hub | Blox Fruits",
   LoadingTitle = "Chargement du projet viral...",
   LoadingSubtitle = "par studio-banana-officiel",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "StudioBanana",
      FileName = "BananaHub"
   }
})

-- ONGLET MOUVEMENT (Déjà fonctionnel)
local Tab = Window:CreateTab("🏃 Joueur", 4483362458)

local Slider = Tab:CreateSlider({
   Name = "Vitesse de marche",
   Range = {16, 300},
   Increment = 1,
   Suffix = " Speed",
   CurrentValue = 100,
   Flag = "Slider1",
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
   end,
})

-- NOUVEAU : INFINITE JUMP (Pour ne jamais tomber dans l'eau)
local InfiniteJumpEnabled = false
Tab:CreateToggle({
   Name = "Saut Infini",
   CurrentValue = false,
   Flag = "InfJump",
   Callback = function(Value)
      InfiniteJumpEnabled = Value
   end,
})

game:GetService("UserInputService").JumpRequest:Connect(function()
   if InfiniteJumpEnabled then
      game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
   end
end)

-- ONGLET COMBAT (Pour Farmer)
local CombatTab = Window:CreateTab("⚔️ Combat", 4483362458)

local AutoClickEnabled = false
CombatTab:CreateToggle({
   Name = "Auto-Click (Farm)",
   CurrentValue = false,
   Flag = "AutoClick",
   Callback = function(Value)
      AutoClickEnabled = Value
   end,
})

-- Boucle pour l'Auto-Click
spawn(function()
   while wait() do
      if AutoClickEnabled then
         local VirtualUser = game:GetService('VirtualUser')
         VirtualUser:CaptureController()
         VirtualUser:ClickButton1(Vector2.new(0,0))
      end
   end
end)

-- ONGLET VISUEL (ESP)
local Tab2 = Window:CreateTab("👁️ Visuel", 4483362458)

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
               tl.TextColor3 = Color3.fromRGB(255, 255, 0) -- Jaune Banane
               tl.BackgroundTransparency = 1
           end
       end
   end,
})

Rayfield:Notify({
   Title = "Studio Banana",
   Content = "Hub Blox Fruits prêt !",
   Duration = 5,
   Image = 4483362458,
})
