-- STUDIO BANANA HUB V2
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🍌 Studio Banana Hub",
   LoadingTitle = "Chargement du projet viral...",
   LoadingSubtitle = "par studio-banana-officiel",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "StudioBanana",
      FileName = "BananaHub"
   }
})

-- ONGLET MOUVEMENT
local Tab = Window:CreateTab("🏃 Joueur", 4483362458) -- Icône de course

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

local Slider2 = Tab:CreateSlider({
   Name = "Puissance de saut",
   Range = {50, 500},
   Increment = 1,
   Suffix = " Jump",
   CurrentValue = 150,
   Flag = "Slider2",
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
   end,
})

-- ONGLET VISUEL
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
   Content = "Hub prêt pour le tournage !",
   Duration = 5,
   Image = 4483362458,
})
