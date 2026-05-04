local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🍌 Studio Banana Hub | Pro Farm",
   LoadingTitle = "Optimisation style Solix...",
   LoadingSubtitle = "par studio-banana-officiel",
   ConfigurationSaving = { Enabled = false }
})

-- ONGLET JOUEUR (Vitesse + Saut Infini)
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
   Name = "Activer le Saut Infini",
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

-- ONGLET AUTO-FARM (Inspiration Solix)
local FarmTab = Window:CreateTab("🌾 Auto Farm")

local AutoFarm = false
FarmTab:CreateToggle({
   Name = "Auto-Farm (Level + Attaque)",
   CurrentValue = false,
   Callback = function(Value)
      AutoFarm = Value
   end,
})

-- Système de Farm Intelligent
spawn(function()
   while true do
      task.wait()
      if AutoFarm then
         pcall(function()
            local player = game.Players.LocalPlayer
            for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                    -- Téléportation au-dessus de l'ennemi (Comme Solix)
                    player.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0)
                    
                    -- Attaque automatique
                    local VirtualUser = game:GetService('VirtualUser')
                    VirtualUser:CaptureController()
                    VirtualUser:ClickButton1(Vector2.new(0,0))
                end
            end
         end)
      end
   end
end)

-- ONGLET VISUEL (Avec Option de Nettoyage)
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
