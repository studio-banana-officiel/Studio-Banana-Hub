print("--- CHARGEMENT STUDIO BANANA HUB ---")

-- 1. Notification pour confirmer que ça marche
game.StarterGui:SetCore("SendNotification", {
    Title = "Studio Banana",
    Text = "Vitesse et Saut activés !",
    Duration = 5
})

-- 2. Fonction pour que ça marche même après une mort
local player = game.Players.LocalPlayer
player.CharacterAppearanceLoaded:Connect(function(char)
    local hum = char:WaitForChild("Humanoid")
    hum.WalkSpeed = 100
    hum.JumpPower = 150
end)

-- 3. Activation immédiate
if player.Character then
    local hum = player.Character:FindFirstChild("Humanoid")
    if hum then
        hum.WalkSpeed = 100
        hum.JumpPower = 150
    end
end

print("--- STUDIO BANANA EST OPÉRATIONNEL ---")
