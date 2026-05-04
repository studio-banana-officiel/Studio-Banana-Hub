print("--- STUDIO BANANA V3 AVEC ESP ---")

-- Notification de succès
game.StarterGui:SetCore("SendNotification", {
    Title = "Studio Banana",
    Text = "ESP et Boosts Activés !",
    Duration = 5
})

-- Boosts de Vitesse et Saut
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

humanoid.WalkSpeed = 100 -- Course super rapide
humanoid.JumpPower = 150 -- Saut très haut

-- Fonction ESP pour voir les joueurs à travers les murs
local function createESP(playerToEsp)
    -- On attend que le personnage du joueur soit chargé
    local espCharacter = playerToEsp.Character or playerToEsp.CharacterAdded:Wait()
    local head = espCharacter:WaitForChild("Head")

    -- On crée l'étiquette au-dessus de la tête
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "StudioBananaESP"
    billboard.AlwaysOnTop = true -- Reste visible même derrière un mur
    billboard.Size = UDim2.new(0, 100, 0, 50)
    billboard.Adornee = head
    billboard.Parent = head

    local textLabel = Instance.new("TextLabel")
    textLabel.Text = playerToEsp.Name
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1 -- Fond transparent
    textLabel.TextColor3 = Color3.new(1, 1, 1) -- Couleur du texte (Blanc)
    textLabel.TextStrokeTransparency = 0 -- Contour noir pour lisibilité
    textLabel.Parent = billboard
end

-- Appliquer l'ESP à tous les joueurs déjà présents
for _, otherPlayer in ipairs(game.Players:GetPlayers()) do
    if otherPlayer ~= player then -- Pas besoin de voir sa propre étiquette
        createESP(otherPlayer)
    end
end

-- Appliquer l'ESP aux nouveaux joueurs qui se connectent
game.Players.PlayerAdded:Connect(function(newPlayer)
    newPlayer.CharacterAdded:Connect(function()
        createESP(newPlayer)
    end)
end)
