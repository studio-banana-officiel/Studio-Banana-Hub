-- STUDIO BANANA HUB V4 - AUTO-LEVEL EDITION
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🍌 Studio Banana Hub | Auto-Level",
   LoadingTitle = "Chargement du Farm Automatique...",
   LoadingSubtitle = "par studio-banana-officiel",
   ConfigurationSaving = { Enabled = false }
})

-- ONGLET AUTOMATISATION
local FarmTab = Window:CreateTab("🌾 Auto Farm")

local AutoFarm = false
FarmTab:CreateToggle({
   Name = "Auto-Level (Attaque Proche)",
   CurrentValue = false,
   Callback = function(Value)
      AutoFarm = Value
   end,
})

-- BOUCLE DE FARM (Attaque les ennemis automatiquement)
spawn(function()
   while true do
      task.wait(0.1) 
      if AutoFarm then
         pcall(function()
            local player = game.Players.LocalPlayer
            local character = player.Character
            -- On cherche l'ennemi le plus proche pour l'attaquer
            for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                    if (character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude < 50 then
                        -- Simule un clic pour attaquer
                        local VirtualUser = game:GetService('VirtualUser')
                        VirtualUser:Button1Down(Vector2.new(0,0), game.Workspace.CurrentCamera.CFrame)
                    end
                end
            end
         end)
      end
   end
end)

-- ONGLET MOUVEMENT
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

-- ONGLET VISUEL
local Tab2 = Window:CreateTab("👁️ Visuel")
Tab2:CreateButton({
   Name = "Activer ESP",
   Callback = function()
       -- Code ESP (Nom des joueurs)
       for _, v in pairs(game.Players:GetPlayers()) do
           if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Head") then
               local bgui = Instance.new("BillboardGui", v.Character.Head)
               bgui.Name = "BananaESP"
               bgui.Size = UDim2.new(0,100,0,50)
               bgui.AlwaysOnTop = true
               local tl = Instance.new("TextLabel", bgui)
               tl.Text = v.Name
               tl.TextColor3 = Color3.fromRGB(255, 255, 0)
               tl.BackgroundTransparency = 1
               tl.Parent = bgui
           end
       end
   end,
})
