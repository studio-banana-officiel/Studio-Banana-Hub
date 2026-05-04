-- Version sécurisée pour Studio Banana
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()

print("Tentative d'activation Studio Banana...")

-- Notification pour confirmer que le bouton a été pressé
game.StarterGui:SetCore("SendNotification", {
    Title = "Studio Banana",
    Text = "Chargement en cours...",
    Duration = 3
})

-- On enveloppe le code dans un pcall (Protective Call) pour éviter les erreurs
pcall(function()
    char.Humanoid.WalkSpeed = 100
    char.Humanoid.JumpPower = 150
end)

print("Studio Banana est prêt !")
