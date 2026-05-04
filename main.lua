local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🍌 Studio Banana Hub | V23",
   LoadingTitle = "Finalisation du Script...",
   LoadingSubtitle = "par studio-banana-officiel",
   ConfigurationSaving = { Enabled = false }
})

-- VARIABLES
local OriginalPos = nil
local AutoLevel = false
local InfJump = false
local AutoBoat = false
local SelectedBoat = "Dinghy"
local BoatSpeed = 150

-- ==========================================
-- 🏃 ONGLET JOUEUR (FIX SAUT INFINI)
-- ==========================================
local Tab = Window:CreateTab("🏃 Joueur")

Tab:CreateSlider({
   Name = "Vitesse de marche",
   Range = {16, 300},
   CurrentValue = 16,
   Callback = function(Value)
      if game.Players.LocalPlayer.Character then
         game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
      end
   end,
})

Tab:CreateToggle({
   Name = "Saut Infini (Fixé)",
   CurrentValue = false,
   Callback = function(Value) 
      InfJump = Value 
   end,
})

-- LOGIQUE SAUT INFINI AMÉLIORÉE
game:GetService("UserInputService").JumpRequest:Connect(function()
   if InfJump then
      local char = game.Players.LocalPlayer.Character
      if char and char:FindFirstChildOfClass("Humanoid") then
         char:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
      end
   end
end)

-- ==========================================
-- ⛵ ONGLET BATEAU (SÉLECTION + FIX)
-- ==========================================
local BoatTab = Window:CreateTab("⛵ Bateau")

BoatTab:CreateDropdown({
   Name = "Choisir le Bateau",
   Options = {"Dinghy", "Sloop", "Brigantine", "Grand Enforcer"},
   CurrentOption = {"Dinghy"},
   MultipleOptions = false,
   Callback = function(Option) 
      SelectedBoat = Option[1] 
   end,
})

BoatTab:CreateButton({
   Name = "Faire apparaître le bateau",
   Callback = function()
       game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat", SelectedBoat)
   end,
})

BoatTab:CreateToggle({
   Name = "Navigation Auto (Force Mode)",
   CurrentValue = false,
   Callback = function(Value) 
      AutoBoat = Value 
   end,
})

-- ==========================================
-- 🌾 ONGLET AUTO-LEVEL
-- ==========================================
local FarmTab = Window:CreateTab("🌾 Auto Level")

FarmTab:CreateToggle({
   Name = "Auto-Farm + Auto-Clicker",
   CurrentValue = false,
   Callback = function(Value)
      AutoLevel = Value
      if Value then
          if game.Players.LocalPlayer.Character then
              OriginalPos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
          end
      else
          task.wait(0.2)
          if OriginalPos then game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = OriginalPos end
      end
   end,
})

-- ==========================================
-- 👁️ ONGLET VISUEL (AVEC BOUTON DÉSACTIVER)
-- ==========================================
local Tab2 = Window:CreateTab("👁️ Visuel")

Tab2:CreateButton({
   Name = "Activer ESP (Jaune)",
   Callback = function()
       for _, v in pairs(game.Players:GetPlayers()) do
           if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Head") then
               if not v.Character.Head:FindFirstChild("BananaESP") then
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

-- ==========================================
-- BOUCLE NAVIGATION BATEAU (ARRIÈRE-PLAN)
-- ==========================================
spawn(function()
    while true do task.wait(0.5)
        if AutoBoat then
            pcall(function()
                local lp = game.Players.LocalPlayer
                for _, v in pairs(game.Workspace.Boats:GetChildren()) do
                    if v:FindFirstChild("Owner") and v.Owner.Value == lp.Name then
                        local seat = v:FindFirstChildOfClass("VehicleSeat")
                        if seat then
                            if lp.Character.Humanoid.SeatPart ~= seat then seat:Sit(lp.Character.Humanoid) end
                            local bv = seat:FindFirstChild("BananaVelocity") or Instance.new("BodyVelocity", seat)
                            bv.Name = "BananaVelocity"
                            bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                            bv.Velocity = seat.CFrame.LookVector * BoatSpeed
                        end
                    end
                end
            end)
        end
    end
end)

-- BOUCLE AUTO-FARM (ARRIÈRE-PLAN)
spawn(function()
   while true do task.wait(0.1)
      if AutoLevel then
         pcall(function()
            for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
               if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 9, 0)
                  game:GetService('VirtualUser'):CaptureController()
                  game:GetService('VirtualUser'):ClickButton1(Vector2.new(0,0))
                  break
               end
            end
         end)
      end
   end
end)
