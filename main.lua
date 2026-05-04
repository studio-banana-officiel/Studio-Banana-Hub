print("--- STUDIO BANANA V2 ACTIVÉE ---")

-- Notification de succès
game.StarterGui:SetCore("SendNotification", {
    Title = "Studio Banana",
    Text = "Mode Vitesse et Saut Activé !",
    Duration = 5
})

-- Tes premières fonctions de "Cheats"
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100 -- Tu vas courir super vite
game.Players.LocalPlayer.Character.Humanoid.JumpPower = 150 -- Tu vas sauter très haut
