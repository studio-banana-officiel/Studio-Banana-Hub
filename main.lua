local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🍌 Studio Banana Hub | V13",
   LoadingTitle = "Chargement du Smooth Farm...",
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

-- BOUTON SAUT INFINI (Désactivable)
local InfJump = false
Tab:CreateToggle({
   Name = "Saut Infini",
   CurrentValue = false,
   Callback = function(Value)
      InfJump = Value
   end,
})

game:GetService("UserInputService").JumpRequest:Connect(function()
   if InfJump and game.Players.LocalPlayer.Character then
      game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
   end
end)

-- ONGLET AUTO-LEVEL (STYLE RED HUB)
local FarmTab = Window:CreateTab("🌾 Auto Level")

local AutoLevel = false
FarmTab:CreateToggle({
   Name = "Smooth Auto-Farm (Level 2050+)",
   CurrentValue = false,
   Callback = function(Value)
      AutoLevel = Value
   end,
})

-- FONCTION DE MOUVEMENT FLUIDE (TWEEN)
local function TweenTo(targetCFrame)
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local tweenService = game:GetService("TweenService")
        local info = TweenInfo.new((char.HumanoidRootPart.Position - targetCFrame.Position).Magnitude / 100, Enum.EasingStyle.Linear)
        local tween = tweenService:Create(char.HumanoidRootPart, info, {CFrame = targetCFrame})
        tween:Play()
        return tween
    end
end

-- BOUCLE DE FARM
spawn(function()
   while true do
      task.wait(0.1)
      if AutoLevel then
         pcall(function()
            local lp = game.Players.LocalPlayer
            for _, v in pairs(game.Workspace.Enemies:GetChildren()) do
               if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                  -- On se place au-dessus de l'ennemi en douceur
                  local targetPos = v.HumanoidRootPart.CFrame * CFrame.new(0, 8, 0)
                  lp.Character.HumanoidRootPart.CFrame = targetPos
                  
                  -- On attaque
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
