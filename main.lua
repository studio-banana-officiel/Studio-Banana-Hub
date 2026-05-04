local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🍌 Studio Banana Hub | PRO V17",
   LoadingTitle = "Intégration Auto-Clicker...",
   LoadingSubtitle = "par studio-banana-officiel",
   ConfigurationSaving = { Enabled = false }
})

-- VARIABLES
local OriginalPos = nil
local AutoLevel = false
local InfJump = false

-- ONGLET JOUEUR
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

-- GESTION SAUT
game:GetService("UserInputService").JumpRequest:Connect(function()
   if InfJump and game.Players.LocalPlayer.Character then
      game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
   end
end)

-- ONGLET AUTO-LEVEL
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
          -- Retour forcé à la position initiale
          task.wait(0.2)
          if OriginalPos and game.Players.LocalPlayer.Character then
              game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = OriginalPos
          end
      end
   end,
})

-- BOUCLE DE COMBAT & AUTO-CLICKER
spawn(function()
   while true do
      task.wait(0.1)
      if AutoLevel then
         pcall(function()
            local lp = game.Players.LocalPlayer
            local foundEnemy = false
            
            -- Détection et TP
            for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
               if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                  lp.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 9, 0)
                  lp.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
                  foundEnemy = true
                  break
               end
            end
            
            -- AUTO-CLICKER (S'active si l'Auto-Farm est ON)
            if foundEnemy then
                local VirtualUser = game:GetService('VirtualUser')
                VirtualUser:CaptureController()
                VirtualUser:ClickButton1(Vector2.new(0,0))
            end
         end)
      end
   end
end)

-- ONGLET VISUEL
local Tab2 = Window:CreateTab("👁️ Visuel")
Tab2:CreateButton({
   Name = "Activer ESP",
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
               tl.Parent = bgui
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
