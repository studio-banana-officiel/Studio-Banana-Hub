local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🍌 Studio Banana Hub | V23",
   LoadingTitle = "Initialisation du Système...",
   LoadingSubtitle = "par studio-banana-officiel",
   ConfigurationSaving = { Enabled = false }
})

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

-- VARIABLES
local lp = Players.LocalPlayer
local OriginalPos = nil
local AutoLevel = false
local InfJump = false
local AutoBoat = false
local SelectedBoat = "Dinghy"
local BoatSpeed = 150
local ClickSpeed = 0.05
local AutoAttack = false

-- Auto-Fruit variables
local AutoFruit = false
local FruitRange = 500
local FruitPickupDelay = 0.5

-- ==========================================
-- 🏃 ONGLET JOUEUR
-- ==========================================
local Tab = Window:CreateTab("🏃 Joueur")

Tab:CreateSlider({
   Name = "Vitesse de marche",
   Range = {16, 300},
   CurrentValue = 16,
   Callback = function(Value)
      if lp.Character and lp.Character:FindFirstChildOfClass("Humanoid") then
         lp.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = Value
      end
   end,
})

Tab:CreateToggle({
   Name = "Saut Infini",
   CurrentValue = false,
   Callback = function(Value) InfJump = Value end,
})

UserInputService.JumpRequest:Connect(function()
   if InfJump and lp.Character then
      local hum = lp.Character:FindFirstChildOfClass("Humanoid")
      if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
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
   Callback = function(Option) SelectedBoat = Option end,
})

BoatTab:CreateButton({
   Name = "Faire apparaître le bateau",
   Callback = function()
       pcall(function()
           ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyBoat", SelectedBoat)
       end)
   end,
})

BoatTab:CreateToggle({
   Name = "Navigation Auto (Frontal)",
   CurrentValue = false,
   Callback = function(Value) AutoBoat = Value end,
})

-- ==========================================
-- ⚔️ ONGLET COMBAT
-- ==========================================
local CombatTab = Window:CreateTab("⚔️ Combat")

CombatTab:CreateToggle({
   Name = "Auto-Farm Ennemis",
   CurrentValue = false,
   Callback = function(Value)
      AutoLevel = Value
      if Value then
          if lp.Character then OriginalPos = lp.Character.HumanoidRootPart.CFrame end
      else
          task.wait(0.2)
          if OriginalPos then lp.Character.HumanoidRootPart.CFrame = OriginalPos end
      end
   end,
})

CombatTab:CreateToggle({
   Name = "Auto-Attack (Rapide)",
   CurrentValue = false,
   Callback = function(Value) AutoAttack = Value end,
})

-- ==========================================
-- 🌾 ONGLET FARMING (FRUITS)
-- ==========================================
local FarmingTab = Window:CreateTab("🌾 Farming")

FarmingTab:CreateToggle({
   Name = "Auto-Ramasser Fruits (TPS)",
   CurrentValue = false,
   Callback = function(Value) AutoFruit = Value end,
})

FarmingTab:CreateButton({
   Name = "Collecter tous les fruits du serveur",
   Callback = function()
       local currentPos = lp.Character.HumanoidRootPart.CFrame
       for _, v in pairs(Workspace:GetChildren()) do
           if v:IsA("Tool") or string.find(string.lower(v.Name), "fruit") then
               if v:FindFirstChild("Handle") then
                   lp.Character.HumanoidRootPart.CFrame = v.Handle.CFrame
                   task.wait(0.5)
               end
           end
       end
       lp.Character.HumanoidRootPart.CFrame = currentPos
   end,
})

-- ==========================================
-- BOUCLES DE FONCTIONNEMENT (BACKGROUND)
-- ==========================================

-- Boucle Combat & Attack
spawn(function()
    while true do
        task.wait(ClickSpeed)
        if AutoAttack and AutoLevel then
            pcall(function()
                game:GetService("VirtualUser"):CaptureController()
                game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
            end)
        end
    end
end)

-- Boucle Auto-Farm (TP Ennemis)
spawn(function()
    while true do
        task.wait(0.1)
        if AutoLevel then
            pcall(function()
                for _, v in pairs(Workspace.Enemies:GetChildren()) do
                    if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                        lp.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0)
                        break
                    end
                end
            end)
        end
    end
end)

-- Boucle Auto-Fruit
spawn(function()
    while true do
        task.wait(FruitPickupDelay)
        if AutoFruit then
            pcall(function()
                for _, v in pairs(Workspace:GetChildren()) do
                    if string.find(string.lower(v.Name), "fruit") and v:IsA("Tool") then
                        local handle = v:FindFirstChild("Handle")
                        if handle and (handle.Position - lp.Character.HumanoidRootPart.Position).Magnitude <= FruitRange then
                            lp.Character.HumanoidRootPart.CFrame = handle.CFrame
                        end
                    end
                end
            end)
        end
    end
end)

-- Boucle Auto-Boat
spawn(function()
    while true do
        task.wait(0.1)
        if AutoBoat then
            pcall(function()
                local boat = Workspace.Boats:FindFirstChild(lp.Name .. "Boat")
                if boat and boat:FindFirstChild("VehicleSeat") then
                    boat.VehicleSeat.Velocity = boat.VehicleSeat.CFrame.LookVector * BoatSpeed
                end
            end)
        end
    end
end)

Rayfield:Notify({
   Title = "Studio Banana Hub",
   Content = "Script chargé avec succès !",
   Duration = 5,
   Image = 4483362458,
})
