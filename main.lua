local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🍌 Studio Banana Hub | PRO V12",
   LoadingTitle = "Optimisation Cimetière...",
   LoadingSubtitle = "par studio-banana-officiel",
   ConfigurationSaving = { Enabled = false }
})

-- ONGLET JOUEUR
local Tab = Window:CreateTab("🏃 Joueur")

Tab:CreateSlider({
   Name = "Vitesse",
   Range = {16, 300},
   Increment = 1,
   CurrentValue = 100,
   Callback = function(Value)
      if game.Players.LocalPlayer.Character then
         game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
      end
   end,
})

local InfJump = false
Tab:CreateToggle({
   Name = "Saut Infini",
   CurrentValue = false,
   Callback = function(Value)
      InfJump = Value -- Désactive ou active le saut ici
   end,
})

game:GetService("UserInputService").JumpRequest:Connect(function()
   if InfJump and game.Players.LocalPlayer.Character then
      game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
   end
end)

-- ONGLET AUTO-LEVEL (MODE CIMETIÈRE)
local FarmTab = Window:CreateTab("🌾 Auto Farm")

local AutoLevel = false
FarmTab:CreateToggle({
   Name = "Auto-Farm (Stay Above)",
   CurrentValue = false,
   Callback = function(Value)
      AutoLevel = Value
   end,
})

-- Boucle de Farm style Solix (Correction Position)
spawn(function()
   while true do
      task.wait(0.05)
      if AutoLevel then
         pcall(function()
            local lp = game.Players.LocalPlayer
            -- On cherche les ennemis (Squelettes, etc.)
            for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
               if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then
                  -- POSITION : On se fixe à 7 studs au-dessus d'eux
                  lp.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 7, 0)
                  
                  -- ANTI-CHUTE : On bloque la gravité pour ne pas glisser au sol
                  lp.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
                  
                  -- ATTAQUE
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
