-- STUDIO BANANA HUB - VERSION FORCE
print("--- INITIALISATION STUDIO BANANA ---")

local player = game.Players.LocalPlayer

-- Fonction simple pour booster le personnage
local function applyBoosts(character)
    local humanoid = character:WaitForChild("Humanoid", 10)
    if humanoid then
        humanoid.WalkSpeed = 100
        humanoid.JumpPower = 150
        print("--- BOOSTS APPLIQUÉS AVEC SUCCÈS ---")
    end
end

-- Appliquer maintenant
if player.Character then
    applyBoosts(player.Character)
end

-- Appliquer à chaque fois que tu réapparais (après une mort)
player.CharacterAdded:Connect(applyBoosts)

-- Notification visuelle en jeu
game.StarterGui:SetCore("SendNotification", {
    Title = "Studio Banana",
    Text = "Vitesse: 100 | Saut: 150",
    Duration = 10
})
