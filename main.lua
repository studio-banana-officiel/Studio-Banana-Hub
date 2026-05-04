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
local AutoClick = false
local SelectedBoat = "Dinghy"
local BoatSpeed = 150
local ClickSpeed = 0.1
local AutoAttack = false

-- ==========================================
-- 🏃 ONGLET JOUEUR
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
   Name = "Saut Infini",
   CurrentValue = false,
   Callback = function(Value) 
      InfJump = Value 
   end,
})

-- LOGIQUE SAUT INFINI
game:GetService("UserInputService").JumpRequest:Connect(function()
   if InfJump then
      local char = game.Players.LocalPlayer.Character
      if char and char:FindFirstChildOfClass("Humanoid") then
         char:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
      end
   end
end)

-- ==========================================
-- ⛵ ONGLET BATEAU
-- ==========================================
local BoatTab = Window:CreateTab("⛵ Bateau")

BoatTab:CreateDropdown({
   Name = "Choisir le Bateau",
   Options = {"Dinghy", "Sloop", "Brigantine", "Grand Enforcer"},
   CurrentOption = "Dinghy",
   Callback = function(Option) 
      SelectedBoat = Option 
   end,
})

BoatTab:CreateButton({
   Name = "Faire apparaître le bateau",
   Callback = function()
       pcall(function()
           game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat", SelectedBoat)
       end)
   end,
})

BoatTab:CreateToggle({
   Name = "Navigation Auto",
   CurrentValue = false,
   Callback = function(Value) 
      AutoBoat = Value 
   end,
})

BoatTab:CreateSlider({
   Name = "Vitesse Bateau",
   Range = {50, 500},
   CurrentValue = 150,
   Callback = function(Value)
      BoatSpeed = Value
   end,
})

-- ==========================================
-- ⚔️ ONGLET COMBAT (AUTO-LEVEL AMÉLIORÉ)
-- ==========================================
local CombatTab = Window:CreateTab("⚔️ Combat")

CombatTab:CreateToggle({
   Name = "Auto-Farm Ennemis",
   CurrentValue = false,
   Callback = function(Value)
      AutoLevel = Value
      if Value then
          if game.Players.LocalPlayer.Character then
              OriginalPos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
          end
      else
          task.wait(0.2)
          if OriginalPos and game.Players.LocalPlayer.Character then 
              game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = OriginalPos 
          end
      end
   end,
})

CombatTab:CreateToggle({
   Name = "Auto-Attack (M1)",
   CurrentValue = false,
   Callback = function(Value) 
      AutoAttack = Value 
      AutoClick = Value
   end,
})

CombatTab:CreateSlider({
   Name = "Vitesse Attack (ms)",
   Range = {10, 500},
   CurrentValue = 50,
   Callback = function(Value)
      ClickSpeed = Value / 1000
   end,
})

-- ==========================================
-- 👁️ ONGLET VISUEL
-- ==========================================
local VisualTab = Window:CreateTab("👁️ Visuel")

VisualTab:CreateButton({
   Name = "Activer ESP Joueurs",
   Callback = function()
       for _, v in pairs(game.Players:GetPlayers()) do
           if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Head") then
               if not v.Character.Head:FindFirstChild("BananaESP") then
                   local bgui = Instance.new("BillboardGui", v.Character.Head)
                   bgui.Name = "BananaESP"
                   bgui.Size = UDim2.new(0,100,0,50)
                   bgui.MaxDistance = 500
                   bgui.AlwaysOnTop = true
                   
                   local tl = Instance.new("TextLabel", bgui)
                   tl.Size = UDim2.new(1,0,1,0)
                   tl.Text = v.Name
                   tl.TextColor3 = Color3.fromRGB(255, 255, 0)
                   tl.BackgroundTransparency = 1
                   tl.Font = Enum.Font.GothamBold
                   tl.TextSize = 14
               end
           end
       end
   end,
})

VisualTab:CreateButton({
   Name = "Désactiver ESP",
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
-- 🌾 ONGLET FARMING
-- ==========================================
local FarmingTab = Window:CreateTab("🌾 Farming")

FarmingTab:CreateButton({
   Name = "Teleport à l'île",
   Callback = function()
       pcall(function()
           if game.Players.LocalPlayer.Character then
               game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 100, 0)
           end
       end)
   end,
})

-- ==========================================
-- BOUCLE AUTO-FARM AMÉLIORÉE
-- ==========================================
spawn(function()
   while true do 
       task.wait(0.05)
       if AutoLevel then
           pcall(function()
               local lp = game.Players.LocalPlayer
               if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") and lp.Character:FindFirstChild("Humanoid") then
                   local closestEnemy = nil
                   local closestDistance = math.huge
                   
                   -- Chercher l'ennemi le plus proche
                   if game.Workspace:FindFirstChild("Enemies") then
                       for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
                           if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                               local distance = (v.HumanoidRootPart.Position - lp.Character.HumanoidRootPart.Position).Magnitude
                               if distance < closestDistance and distance < 500 then
                                   closestDistance = distance
                                   closestEnemy = v
                               end
                           end
                       end
                   end
                   
                   -- Se téléporter et attaquer
                   if closestEnemy then
                       lp.Character.HumanoidRootPart.CFrame = closestEnemy.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                   end
               end
           end)
       end
   end
end)

-- ==========================================
-- BOUCLE AUTO-ATTACK AMÉLIORÉE
-- ==========================================
spawn(function()
   local lastClick = 0
   while true do
       task.wait(0.01)
       if AutoAttack then
           local currentTime = tick()
           if currentTime - lastClick >= ClickSpeed then
               pcall(function()
                   local lp = game.Players.LocalPlayer
                   if lp.Character and lp.Character:FindFirstChild("Humanoid") and lp.Character.Humanoid.Health > 0 then
                       -- Méthode 1: VirtualUser (pour certains jeux)
                       game:GetService('VirtualUser'):CaptureController()
                       game:GetService('VirtualUser'):ClickButton1(Vector2.new(640, 360))
                       
                       -- Méthode 2: Signal UserInputService
                       local UserInputService = game:GetService("UserInputService")
                       UserInputService:SendKeyEvent(true, Enum.KeyCode.Unknown, false)
                       UserInputService:SendKeyEvent(false, Enum.KeyCode.Unknown, false)
                   end
               end)
               lastClick = currentTime
           end
       end
   end
end)

-- ==========================================
-- BOUCLE BATEAU AUTO
-- ==========================================
spawn(function()
    while true do 
        task.wait(0.5)
        if AutoBoat then
            pcall(function()
                local lp = game.Players.LocalPlayer
                if lp.Character then
                    for _, v in pairs(game.Workspace.Boats:GetChildren()) do
                        if v:FindFirstChild("Owner") and v.Owner.Value == lp.Name then
                            local seat = v:FindFirstChildOfClass("VehicleSeat")
                            if seat then
                                if lp.Character.Humanoid.SeatPart ~= seat then 
                                    seat:Sit(lp.Character.Humanoid) 
                                end
                                local bv = seat:FindFirstChild("BananaVelocity") or Instance.new("BodyVelocity", seat)
                                bv.Name = "BananaVelocity"
                                bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                                bv.Velocity = seat.CFrame.LookVector * BoatSpeed
                            end
                        end
                    end
                end
            end)
        end
    end
end)
