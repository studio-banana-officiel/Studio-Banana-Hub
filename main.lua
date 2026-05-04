-- STUDIO BANANA HUB : VERSION STABLE
print("--- CHARGEMENT STUDIO BANANA HUB ---")

-- Création d'un menu simple (ScreenGui)
local sg = Instance.new("ScreenGui", game.CoreGui)
local frame = Instance.new("Frame", sg)
frame.Size = UDim2.new(0, 200, 0, 150)
frame.Position = UDim2.new(0.1, 0, 0.1, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Active = true
frame.Draggable = true -- Tu peux déplacer le menu avec la souris

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "Studio Banana Hub"
title.TextColor3 = Color3.new(1, 1, 0) -- Jaune
title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

-- BOUTON VITESSE
local speedBtn = Instance.new("TextButton", frame)
speedBtn.Size = UDim2.new(0.8, 0, 0, 30)
speedBtn.Position = UDim2.new(0.1, 0, 0.3, 0)
speedBtn.Text = "Vitesse (100)"
speedBtn.MouseButton1Click:Connect(function()
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100
end)

-- BOUTON SAUT
local jumpBtn = Instance.new("TextButton", frame)
jumpBtn.Size = UDim2.new(0.8, 0, 0, 30)
jumpBtn.Position = UDim2.new(0.1, 0, 0.6, 0)
jumpBtn.Text = "Saut (150)"
jumpBtn.MouseButton1Click:Connect(function()
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = 150
end)

print("--- STUDIO BANANA EST PRÊT ! ---")
