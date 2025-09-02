local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "RitualHub"
gui.ResetOnSpawn = false
gui.DisplayOrder = 9999
gui.Parent = player:WaitForChild("PlayerGui")

-- 🧱 Docked Button
local dock = Instance.new("TextButton")
dock.Size = UDim2.new(0, 120, 0, 30)
dock.Position = UDim2.new(0, 10, 1, -40)
dock.Text = "InfiniteHub"
dock.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
dock.TextColor3 = Color3.new(1, 1, 1)
dock.Font = Enum.Font.SourceSansBold
dock.TextSize = 16
dock.Parent = gui
dock.Active = true
dock.Draggable = true

-- 🧿 Constrain Dock to Bottom
dock:GetPropertyChangedSignal("Position"):Connect(function()
    local y = dock.Position.Y.Scale
    local offsetY = dock.Position.Y.Offset
    if y ~= 1 or offsetY < -100 then
        dock.Position = UDim2.new(0, dock.Position.X.Offset, 1, math.max(-100, offsetY))
    end
end)

-- 📜 Expandable Panel
local panel = Instance.new("Frame")
panel.Size = UDim2.new(0, 300, 0, 400)
panel.Position = UDim2.new(0, 10, 1, -440)
panel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
panel.BorderSizePixel = 0
panel.Visible = false
panel.Parent = gui

-- 🖱️ Hover Reveal
dock.MouseEnter:Connect(function()
    panel.Visible = true
end)
panel.MouseLeave:Connect(function()
    panel.Visible = false
end)

-- 🔍 Search Bar
local searchBar = Instance.new("TextBox")
searchBar.Size = UDim2.new(1, -20, 0, 30)
searchBar.Position = UDim2.new(0, 10, 0, 10)
searchBar.PlaceholderText = "Search rituals..."
searchBar.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
searchBar.TextColor3 = Color3.new(1, 1, 1)
searchBar.Font = Enum.Font.SourceSans
searchBar.TextSize = 16
searchBar.Parent = panel

-- 📜 Scrollable Ritual List
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -20, 1, -50)
scrollFrame.Position = UDim2.new(0, 10, 0, 50)
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.ScrollBarThickness = 6
scrollFrame.BackgroundTransparency = 1
scrollFrame.Parent = panel

local layout = Instance.new("UIListLayout", scrollFrame)
layout.Padding = UDim.new(0, 6)
layout.SortOrder = Enum.SortOrder.LayoutOrder

-- 🧿 Ritual States
local states = {
    Invisible = false,
    Magnet = false,
    Freeze = false,
    Spin = false
}

-- 🧿 Ritual Definitions
local rituals = {
    {
        Name = "Invisibility: OFF",
        Toggle = function(btn)
            states.Invisible = not states.Invisible
            btn.Text = states.Invisible and "Invisibility: ON" or "Invisibility: OFF"
            local char = player.Character or player.CharacterAdded:Wait()
            for _, part in pairs(char:GetChildren()) do
                if part:IsA("BasePart") then
                    part.Transparency = states.Invisible and 1 or 0
                end
            end
        end
    },
    {
        Name = "Magnet: OFF",
        Toggle = function(btn)
            states.Magnet = not states.Magnet
            btn.Text = states.Magnet and "Magnet: ON" or "Magnet: OFF"
            if states.Magnet then
                coroutine.wrap(function()
                    while states.Magnet do
                        local char = player.Character or player.CharacterAdded:Wait()
                        local root = char:FindFirstChild("HumanoidRootPart")
                        if root then
                            for _, part in pairs(workspace:GetChildren()) do
                                if part:IsA("BasePart") and not part.Anchored and part ~= root then
                                    local dist = (part.Position - root.Position).Magnitude
                                    if dist < 20 then
                                        part.Velocity = (root.Position - part.Position).Unit * 50
                                    end
                                end
                            end
                        end
                        wait(0.2)
                    end
                end)()
            end
        end
    },
    {
        Name = "Explode",
        Toggle = function(btn)
            local char = player.Character or player.CharacterAdded:Wait()
            local root = char:FindFirstChild("HumanoidRootPart")
            if root then
                local explosion = Instance.new("Explosion")
                explosion.Position = root.Position
                explosion.BlastRadius = 10
                explosion.BlastPressure = 500000
                explosion.Parent = workspace
            end
        end
    },
    {
        Name = "Freeze: OFF",
        Toggle = function(btn)
            states.Freeze = not states.Freeze
            btn.Text = states.Freeze and "Freeze: ON" or "Freeze: OFF"
            local root = player.Character:FindFirstChild("HumanoidRootPart")
            if root then root.Anchored = states.Freeze end
        end
    },
    {
{
    Name = "Switch to Legacy Panel",
    Toggle = function(btn)
        gui:Destroy() -- Remove RitualHub
local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "RitualPanel"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local panel = Instance.new("Frame")
panel.Size = UDim2.new(0, 300, 0, 510)
panel.Position = UDim2.new(0.5, -150, 0.5, -255)
panel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
panel.BorderSizePixel = 0
panel.Active = true
panel.Draggable = true
panel.Visible = true
panel.Parent = gui

local reopenBtn = Instance.new("TextButton", gui)
reopenBtn.Size = UDim2.new(0, 100, 0, 30)
reopenBtn.Position = UDim2.new(0, 10, 0, 10)
reopenBtn.Text = "Open Panel"
reopenBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
reopenBtn.TextColor3 = Color3.new(1, 1, 1)
reopenBtn.Font = Enum.Font.SourceSansBold
reopenBtn.TextSize = 16
reopenBtn.Visible = false

-- Button Factory
local function createButton(name, posY, color)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 280, 0, 40)
    btn.Position = UDim2.new(0, 10, 0, posY)
    btn.Text = name
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 18
    btn.Parent = panel
    return btn
end

-- Buttons
local eraseBtn = createButton("Erase Animations", 10, Color3.fromRGB(70,130,180))
local invisBtn = createButton("Invisible: OFF", 60, Color3.fromRGB(80,80,80))
local magnetBtn = createButton("Magnet: OFF", 110, Color3.fromRGB(150,100,200))
local explodeBtn = createButton("Explode", 160, Color3.fromRGB(255,80,80))
local freezeBtn = createButton("Freeze: OFF", 210, Color3.fromRGB(100,180,220))
local spinBtn = createButton("Spin: OFF", 260, Color3.fromRGB(160,80,200))
local killBtn = createButton("Kill GUI", 310, Color3.fromRGB(200,30,30))
local cloneBtn = createButton("Summon Clone", 360, Color3.fromRGB(100,100,255))
local closeBtn = createButton("Close Panel", 410, Color3.fromRGB(180,50,50))
closeBtn.TextSize = 24
local stealthBtn = createButton("Stealth: OFF", 460, Color3.fromRGB(50, 50, 120))

-- Logic
eraseBtn.MouseButton1Click:Connect(function()
    local char = player.Character or player.CharacterAdded:Wait()
    local animate = char:FindFirstChild("Animate")
    local animator = char:FindFirstChildWhichIsA("Animator", true)
    if animate then animate.Disabled = true end
    if animator then animator:Destroy() end
end)

local invisible = false
invisBtn.MouseButton1Click:Connect(function()
    invisible = not invisible
    invisBtn.Text = invisible and "Invisible: ON" or "Invisible: OFF"
    local char = player.Character or player.CharacterAdded:Wait()
    for _, part in pairs(char:GetChildren()) do
        if part:IsA("BasePart") then
            part.Transparency = invisible and 1 or 0
        end
    end
end)

local magnetActive = false
magnetBtn.MouseButton1Click:Connect(function()
    magnetActive = not magnetActive
    magnetBtn.Text = magnetActive and "Magnet: ON" or "Magnet: OFF"
    if magnetActive then
        coroutine.wrap(function()
            while magnetActive do
                local char = player.Character or player.CharacterAdded:Wait()
                local root = char:FindFirstChild("HumanoidRootPart")
                if root then
                    for _, part in pairs(workspace:GetChildren()) do
                        if part:IsA("BasePart") and not part.Anchored and part ~= root then
                            local dist = (part.Position - root.Position).Magnitude
                            if dist < 20 then
                                part.Velocity = (root.Position - part.Position).Unit * 50
                            end
                        end
                    end
                end
                wait(0.2)
            end
        end)()
    end
end)

explodeBtn.MouseButton1Click:Connect(function()
    local char = player.Character or player.CharacterAdded:Wait()
    local root = char:FindFirstChild("HumanoidRootPart")
    if root then
        local explosion = Instance.new("Explosion")
        explosion.Position = root.Position
        explosion.BlastRadius = 10
        explosion.BlastPressure = 500000
        explosion.Parent = workspace
    end
end)

local frozen = false
freezeBtn.MouseButton1Click:Connect(function()
    frozen = not frozen
    freezeBtn.Text = frozen and "Freeze: ON" or "Freeze: OFF"
    local char = player.Character or player.CharacterAdded:Wait()
    local root = char:FindFirstChild("HumanoidRootPart")
    if root then root.Anchored = frozen end
end)

local spinning = false
spinBtn.MouseButton1Click:Connect(function()
    spinning = not spinning
    spinBtn.Text = spinning and "Spin: ON" or "Spin: OFF"
    if spinning then
        coroutine.wrap(function()
            while spinning do
                local char = player.Character or player.CharacterAdded:Wait()
                local root = char:FindFirstChild("HumanoidRootPart")
                if root then
                    root.CFrame *= CFrame.Angles(0, math.rad(30), 0)
                end
                wait(0.05)
            end
        end)()
    end
end)

killBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

local cloneModel = nil
local cloneLoop = nil
cloneBtn.MouseButton1Click:Connect(function()
    local char = player.Character or player.CharacterAdded:Wait()
    if cloneModel then
        cloneModel:Destroy()
        cloneModel = nil
        cloneBtn.Text = "Summon Clone"
        return
    end

    cloneModel = char:Clone()
    cloneModel.Name = "PlayerClone"
    cloneModel.Parent = workspace

    for _, obj in pairs(cloneModel:GetDescendants()) do
        if obj:IsA("Humanoid") or obj:IsA("Script") or obj:IsA("LocalScript") then
            obj:Destroy()
        elseif obj:IsA("BasePart") then
            obj.Anchored = true
            obj.CanCollide = false
        end
    end

    cloneBtn.Text = "Remove Clone"

    cloneLoop = coroutine.create(function()
        while cloneModel do
            local root = char:FindFirstChild("HumanoidRootPart")
            local cloneRoot = cloneModel:FindFirstChild("HumanoidRootPart")
            if root and cloneRoot then
                cloneRoot.CFrame = root.CFrame * CFrame.new(3, 0, 0)
                for _, part in pairs(char:GetChildren()) do
                    if part:IsA("BasePart") then
                        local clonePart = cloneModel:FindFirstChild(part.Name)
                        if clonePart then
                            clonePart.CFrame = part.CFrame * CFrame.new(3, 0, 0)
                        end
                    end
                end
            end
            wait(0.05)
        end
    end)
    coroutine.resume(cloneLoop)
end)

closeBtn.MouseButton1Click:Connect(function()
    panel.Visible = false
    reopenBtn.Visible = true
end)

reopenBtn.MouseButton1Click:Connect(function()
    panel.Visible = true
    reopenBtn.Visible = false
end)

local stealthActive = false
stealthBtn.MouseButton1Click:Connect(function()
    stealthActive = not stealthActive
    stealthBtn.Text = stealthActive and "Stealth: ON" or "Stealth: OFF"

    if stealthActive then
        panel.Visible = false
        gui.Parent = game:GetService("ReplicatedFirst")
    else
        gui.Parent = player:WaitForChild("PlayerGui")
        panel.Visible = true
    end
end)

    end
}
      
    end
},
    {
        Name = "Spin: OFF",
        Toggle = function(btn)
            states.Spin = not states.Spin
            btn.Text = states.Spin and "Spin: ON" or "Spin: OFF"
            if states.Spin then
                coroutine.wrap(function()
                    while states.Spin do
                        local root = player.Character:FindFirstChild("HumanoidRootPart")
                        if root then
                            root.CFrame *= CFrame.Angles(0, math.rad(30), 0)
                        end
                        wait(0.05)
                    end
                end)()
            end
        end
    }
}

-- 🧿 Generate Buttons
for _, ritual in pairs(rituals) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.Text = ritual.Name
    btn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 18
    btn.Parent = scrollFrame

    btn.MouseButton1Click:Connect(function()
        ritual.Toggle(btn)
    end)
end

-- 🔍 Search Filter
searchBar:GetPropertyChangedSignal("Text"):Connect(function()
    local query = searchBar.Text:lower()
    for _, btn in pairs(scrollFrame:GetChildren()) do
        if btn:IsA("TextButton") then
            btn.Visible = btn.Text:lower():find(query) ~= nil
        end
    end
end)
