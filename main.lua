-- Studio Banana Hub | V23 (corrigé & amélioré + Auto-Fruit)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🍌 Studio Banana Hub | V23",
   LoadingTitle = "Finalisation du Script...",
   LoadingSubtitle = "par studio-banana-officiel",
   ConfigurationSaving = { Enabled = false }
})

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

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

-- Auto-Fruit variables
local AutoFruit = false
local FruitRange = 200        -- portée max de recherche (studs)
local FruitPickupDelay = 0.6  -- délai entre tentatives en secondes

-- Utility
local lp = Players.LocalPlayer

-- ==========================================
-- 🏃 ONGLET JOUEUR
-- ==========================================
local Tab = Window:CreateTab("🏃 Joueur")

Tab:CreateSlider({
   Name = "Vitesse de marche",
   Range = {16, 300},
   CurrentValue = 16,
   Callback = function(Value)
      if lp and lp.Character and lp.Character:FindFirstChildOfClass("Humanoid") then
         lp.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = Value
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
UserInputService.JumpRequest:Connect(function()
   if InfJump then
      local char = lp and lp.Character
      if char then
         local hum = char:FindFirstChildOfClass("Humanoid")
         if hum and hum.Health > 0 then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
         end
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
           if ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("CommF_") then
               ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyBoat", SelectedBoat)
           end
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
          if lp and lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
              OriginalPos = lp.Character.HumanoidRootPart.CFrame
          end
      else
          task.wait(0.2)
          if OriginalPos and lp and lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
              lp.Character.HumanoidRootPart.CFrame = OriginalPos
              OriginalPos = nil
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
local ESP_NAME = "BananaESP_v23"

local function createESPForPlayer(player)
   if not player or not player.Character then return end
   local head = player.Character:FindFirstChild("Head")
   if not head or head:FindFirstChild(ESP_NAME) then return end

   local bgui = Instance.new("BillboardGui")
   bgui.Name = ESP_NAME
   bgui.Size = UDim2.new(0, 120, 0, 40)
   bgui.MaxDistance = 500
   bgui.AlwaysOnTop = true
   bgui.StudsOffset = Vector3.new(0, 1.5, 0)
   bgui.Parent = head

   local tl = Instance.new("TextLabel", bgui)
   tl.Size = UDim2.new(1, 0, 1, 0)
   tl.BackgroundTransparency = 1
   tl.Text = player.Name
   tl.TextColor3 = Color3.fromRGB(255, 255, 0)
   tl.Font = Enum.Font.GothamBold
   tl.TextSize = 14
end

local function removeESPForPlayer(player)
   if not player or not player.Character then return end
   local head = player.Character:FindFirstChild("Head")
   if head then
       local esp = head:FindFirstChild(ESP_NAME)
       if esp then esp:Destroy() end
   end
end

VisualTab:CreateButton({
   Name = "Activer ESP Joueurs",
   Callback = function()
       for _, v in pairs(Players:GetPlayers()) do
           if v ~= lp then createESPForPlayer(v) end
       end
       -- Ecoute les nouveaux joueurs / chars
       Players.PlayerAdded:Connect(function(p) p.CharacterAdded:Connect(function() createESPForPlayer(p) end) end)
       for _, p in pairs(Players:GetPlayers()) do
           p.CharacterAdded:Connect(function() createESPForPlayer(p) end)
       end
   end,
})

VisualTab:CreateButton({
   Name = "Désactiver ESP",
   Callback = function()
       for _, v in pairs(Players:GetPlayers()) do
           removeESPForPlayer(v)
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
           if lp and lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
               lp.Character.HumanoidRootPart.CFrame = CFrame.new(0, 100, 0)
           end
       end)
   end,
})

-- Auto-Fruit UI
FarmingTab:CreateToggle({
   Name = "Auto-Ramasser Fruits",
   CurrentValue = false,
   Callback = function(Value)
      AutoFruit = Value
   end,
})

FarmingTab:CreateSlider({
   Name = "Portée Recherche Fruits (studs)",
   Range = {50, 1000},
   CurrentValue = FruitRange,
   Callback = function(Value)
      FruitRange = Value
   end,
})

FarmingTab:CreateSlider({
   Name = "Délai Ramassage (ms)",
   Range = {100, 2000},
   CurrentValue = FruitPickupDelay * 1000,
   Callback = function(Value)
      FruitPickupDelay = Value / 1000
   end,
})

FarmingTab:CreateButton({
   Name = "Ramasser Tous les Fruits (une fois)",
   Callback = function()
       spawn(function()
           pcall(function()
               if not lp or not lp.Character or not lp.Character:FindFirstChild("HumanoidRootPart") then return end
               -- Collecte une fois tous les fruits trouvés
               local hrp = lp.Character.HumanoidRootPart
               local found = {}
               -- Cherche des containers usuels
               local candidates = {}

               if Workspace:FindFirstChild("Fruits") then
                   for _, f in pairs(Workspace.Fruits:GetChildren()) do table.insert(candidates, f) end
               end
               -- fallback: scan workspace for models/parts contenant 'Fruit' dans le nom
               for _, d in pairs(Workspace:GetDescendants()) do
                   if d:IsA("Model") and not table.find(candidates, d) and string.find(string.lower(d.Name), "fruit") then
                       table.insert(candidates, d)
                   elseif d:IsA("BasePart") and not table.find(candidates, d) and string.find(string.lower(d.Name), "fruit") then
                       table.insert(candidates, d)
                   end
               end

               for _, obj in pairs(candidates) do
                   if obj and not table.find(found, obj) then
                       -- get position
                       local pos = nil
                       if obj:IsA("Model") then
                           local primary = obj.PrimaryPart or obj:FindFirstChild("Handle") or obj:FindFirstChildWhichIsA("BasePart")
                           if primary then pos = primary.Position end
                       elseif obj:IsA("BasePart") then
                           pos = obj.Position
                       end
                       if pos then
                           -- Téléporte à proximité pour ramasser
                           hrp.CFrame = CFrame.new(pos + Vector3.new(0, 3, 0))
                           table.insert(found, obj)
                           task.wait(FruitPickupDelay)
                       end
                   end
               end
           end)
       end)
   end,
})

-- Helper: find fruit models/parts intelligently
local function findNearbyFruits(range)
   local fruits = {}
   -- Première priorité : Workspace.Fruits container
   if Workspace:FindFirstChild("Fruits") then
       for _, f in pairs(Workspace.Fruits:GetChildren()) do
           if f then
               local pos = nil
               if f:IsA("Model") then
                   local primary = f.PrimaryPart or f:FindFirstChild("Handle") or f:FindFirstChildWhichIsA("BasePart")
                   if primary then pos = primary.Position end
               elseif f:IsA("BasePart") then
                   pos = f.Position
               end
               if pos and lp and lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
                   local dist = (pos - lp.Character.HumanoidRootPart.Position).Magnitude
                   if dist <= range then
                       table.insert(fruits, {obj = f, pos = pos, dist = dist})
                   end
               end
           end
       end
   end

   -- Scanne workspace pour tout nom contenant "fruit" (fallback)
   for _, d in pairs(Workspace:GetDescendants()) do
       if d and (d:IsA("Model") or d:IsA("BasePart")) and string.find(string.lower(d.Name), "fruit") then
           local pos = nil
           if d:IsA("Model") then
               local primary = d.PrimaryPart or d:FindFirstChild("Handle") or d:FindFirstChildWhichIsA("BasePart")
               if primary then pos = primary.Position end
           elseif d:IsA("BasePart") then
               pos = d.Position
           end
           if pos and lp and lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
               local dist = (pos - lp.Character.HumanoidRootPart.Position).Magnitude
               if dist <= range then
                   table.insert(fruits, {obj = d, pos = pos, dist = dist})
               end
           end
       end
   end

   -- Trier par distance ascendante
   table.sort(fruits, function(a,b) return a.dist < b.dist end)
   return fruits
end

-- Tente d'utiliser un remote "pickup" si trouvé, sinon téléporte le joueur près du fruit
local function attemptPickupFruit(obj)
   pcall(function()
       -- Cherche des remotes plausibles
       local remotes = ReplicatedStorage:FindFirstChild("Remotes") or ReplicatedStorage
       local tryNames = {"Pickup", "PickUp", "PickupItem", "Collect", "CollectItem", "PickItem", "GiveFruit", "CollectFruit", "DropPickup"}
       for _, name in pairs(tryNames) do
           local r = remotes:FindFirstChild(name)
           if r then
               if r:IsA("RemoteEvent") then
                   pcall(function() r:FireServer(obj) end)
                   return true
               elseif r:IsA("RemoteFunction") then
                   pcall(function() r:InvokeServer(obj) end)
                   return true
               end
           end
       end
       -- Si l'objet est un Model, on essaie de trouver sa PrimaryPart
       local pos = nil
       if obj:IsA("Model") then
           local primary = obj.PrimaryPart or obj:FindFirstChild("Handle") or obj:FindFirstChildWhichIsA("BasePart")
           if primary then pos = primary.Position end
       elseif obj:IsA("BasePart") then
           pos = obj.Position
       end
       if pos and lp and lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
           -- Téléporte le joueur à proximité (léger offset dessus)
           lp.Character.HumanoidRootPart.CFrame = CFrame.new(pos + Vector3.new(0, 3, 0))
           return true
       end
   end)
   return false
end

-- ==========================================
-- BOUCLE AUTO-FARM AMÉLIORÉE
-- ==========================================
spawn(function()
   while true do
       task.wait(0.1)
       if AutoLevel then
           pcall(function()
               local player = lp
               if not player or not player.Character then return end
               local hrp = player.Character:FindFirstChild("HumanoidRootPart")
               local hum = player.Character:FindFirstChildOfClass("Humanoid")
               if not hrp or not hum or hum.Health <= 0 then return end

               local closestEnemy = nil
               local closestDistance = math.huge

               if Workspace:FindFirstChild("Enemies") then
                   for _, v in pairs(Workspace.Enemies:GetChildren()) do
                       if v and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                           local distance = (v.HumanoidRootPart.Position - hrp.Position).Magnitude
                           if distance < closestDistance and distance < 500 then
                               closestDistance = distance
                               closestEnemy = v
                           end
                       end
                   end
               end

               if closestEnemy and closestEnemy:FindFirstChild("HumanoidRootPart") then
                   local targetCFrame = closestEnemy.HumanoidRootPart.CFrame * CFrame.new(0, 2.5, 3)
                   hrp.CFrame = targetCFrame
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
                   if not lp or not lp.Character then return end
                   local hum = lp.Character:FindFirstChildOfClass("Humanoid")
                   if not hum or hum.Health <= 0 then return end

                   local invoked = false
                   local remotes = ReplicatedStorage:FindFirstChild("Remotes") or ReplicatedStorage
                   local commonNames = {"Damage", "Melee", "Attack", "Hit", "Swing", "Combat", "CommF_", "RemoteEvent"}
                   for _, name in pairs(commonNames) do
                       local r = remotes:FindFirstChild(name)
                       if r and r:IsA("RemoteEvent") then
                           pcall(function() r:FireServer() end)
                           invoked = true
                           break
                       elseif r and r:IsA("RemoteFunction") then
                           pcall(function() r:InvokeServer() end)
                           invoked = true
                           break
                       end
                   end

                   if not invoked then
                       local vu = game:GetService("VirtualUser")
                       vu:CaptureController()
                       pcall(function() vu:ClickButton1(Vector2.new(workspace.CurrentCamera.ViewportSize.X/2, workspace.CurrentCamera.ViewportSize.Y/2)) end)
                   end
              _*
