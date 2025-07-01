-- Enhanced Loading Screen GUI with Menu for Roblox Studio (Grow a Garden Compatible)
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Disable chat and inventory/bag when script starts
local function disableChat()
    pcall(function()
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
    end)
end

local function disableInventory()
    pcall(function()
        -- Disable standard backpack
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
        
        -- Disable bag system for Grow a Garden
        local bagGui = playerGui:FindFirstChild("Bag")
        if bagGui then
            bagGui.Enabled = false
        end
        
        -- Also check for common bag/inventory GUI names
        local inventoryGui = playerGui:FindFirstChild("Inventory")
        if inventoryGui then
            inventoryGui.Enabled = false
        end
        
        local bagFrame = playerGui:FindFirstChild("BagGui")
        if bagFrame then
            bagFrame.Enabled = false
        end
    end)
end

local function enableInventory()
    pcall(function()
        -- Enable standard backpack
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
        
        -- Re-enable bag system for Grow a Garden
        local bagGui = playerGui:FindFirstChild("Bag")
        if bagGui then
            bagGui.Enabled = true
        end
        
        -- Also re-enable common bag/inventory GUI names
        local inventoryGui = playerGui:FindFirstChild("Inventory")
        if inventoryGui then
            inventoryGui.Enabled = true
        end
        
        local bagFrame = playerGui:FindFirstChild("BagGui")
        if bagFrame then
            bagFrame.Enabled = true
        end
    end)
end

-- Call disable functions
disableChat()
disableInventory()

-- Create the main ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LoadingScreen"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = playerGui

-- Main background frame (covers entire screen)
local backgroundFrame = Instance.new("Frame")
backgroundFrame.Name = "BackgroundFrame"
backgroundFrame.Size = UDim2.new(1, 0, 1, 0)
backgroundFrame.Position = UDim2.new(0, 0, 0, 0)
backgroundFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
backgroundFrame.BorderSizePixel = 0
backgroundFrame.Parent = screenGui

-- Add gradient background
local backgroundGradient = Instance.new("UIGradient")
backgroundGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 15, 50)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 30, 60))
}
backgroundGradient.Rotation = 45
backgroundGradient.Parent = backgroundFrame

-- Content frame (positioned lower so text is visible)
local contentFrame = Instance.new("Frame")
contentFrame.Name = "ContentFrame"
contentFrame.Size = UDim2.new(0, 400, 0, 300)
contentFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = backgroundFrame

-- Title text with colorful gradient
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(1, 0, 0, 50)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Please wait 1 minute"
titleLabel.TextColor3 = Color3.fromRGB(255, 100, 255)
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextStrokeTransparency = 0
titleLabel.TextStrokeColor3 = Color3.fromRGB(100, 255, 200)
titleLabel.Parent = contentFrame

-- Subtitle text
local subtitleLabel = Instance.new("TextLabel")
subtitleLabel.Name = "SubtitleLabel"
subtitleLabel.Size = UDim2.new(1, 0, 0, 30)
subtitleLabel.Position = UDim2.new(0, 0, 0, 60)
subtitleLabel.BackgroundTransparency = 1
subtitleLabel.Text = "The script is now reloading"
subtitleLabel.TextColor3 = Color3.fromRGB(100, 255, 150)
subtitleLabel.TextScaled = true
subtitleLabel.Font = Enum.Font.Gotham
subtitleLabel.Parent = contentFrame

-- Progress bar background with gradient
local progressBarBG = Instance.new("Frame")
progressBarBG.Name = "ProgressBarBG"
progressBarBG.Size = UDim2.new(1, 0, 0, 25)
progressBarBG.Position = UDim2.new(0, 0, 0, 120)
progressBarBG.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
progressBarBG.BorderSizePixel = 0
progressBarBG.Parent = contentFrame

-- Progress bar fill with rainbow gradient
local progressBarFill = Instance.new("Frame")
progressBarFill.Name = "ProgressBarFill"
progressBarFill.Size = UDim2.new(0, 0, 1, 0)
progressBarFill.Position = UDim2.new(0, 0, 0, 0)
progressBarFill.BackgroundColor3 = Color3.fromRGB(255, 0, 255)
progressBarFill.BorderSizePixel = 0
progressBarFill.Parent = progressBarBG

-- Rainbow gradient for progress bar
local progressGradient = Instance.new("UIGradient")
progressGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 150)),
    ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 255)),
    ColorSequenceKeypoint.new(0.66, Color3.fromRGB(150, 255, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 150, 0))
}
progressGradient.Parent = progressBarFill

-- Rounded corners for progress bar
local progressCorner = Instance.new("UICorner")
progressCorner.CornerRadius = UDim.new(0, 12)
progressCorner.Parent = progressBarBG

local progressFillCorner = Instance.new("UICorner")
progressFillCorner.CornerRadius = UDim.new(0, 12)
progressFillCorner.Parent = progressBarFill

-- Percentage text with rainbow colors
local percentageLabel = Instance.new("TextLabel")
percentageLabel.Name = "PercentageLabel"
percentageLabel.Size = UDim2.new(1, 0, 0, 40)
percentageLabel.Position = UDim2.new(0, 0, 0, 155)
percentageLabel.BackgroundTransparency = 1
percentageLabel.Text = "0%"
percentageLabel.TextColor3 = Color3.fromRGB(255, 255, 100)
percentageLabel.TextScaled = true
percentageLabel.Font = Enum.Font.GothamBold
percentageLabel.TextStrokeTransparency = 0
percentageLabel.TextStrokeColor3 = Color3.fromRGB(255, 0, 255)
percentageLabel.Parent = contentFrame

-- Additional info text
local infoLabel = Instance.new("TextLabel")
infoLabel.Name = "InfoLabel"
infoLabel.Size = UDim2.new(1, 0, 0, 40)
infoLabel.Position = UDim2.new(0, 0, 0, 200)
infoLabel.BackgroundTransparency = 1
infoLabel.Text = "If the server restarting appear just wait a few minute\nbut if it's not closing rejoin and try again"
infoLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
infoLabel.TextScaled = true
infoLabel.Font = Enum.Font.Gotham
infoLabel.TextWrapped = true
infoLabel.Parent = contentFrame

-- Credit text 1 - Main account safety
local credit1Label = Instance.new("TextLabel")
credit1Label.Name = "Credit1Label"
credit1Label.Size = UDim2.new(0, 400, 0, 25)
credit1Label.Position = UDim2.new(0.5, -200, 1, -80)
credit1Label.BackgroundTransparency = 1
credit1Label.Text = "YOUR MAIN ACCOUNT IS SAFE HERE"
credit1Label.TextColor3 = Color3.fromRGB(100, 255, 100)
credit1Label.TextScaled = true
credit1Label.Font = Enum.Font.GothamBold
credit1Label.TextStrokeTransparency = 0
credit1Label.TextStrokeColor3 = Color3.fromRGB(0, 150, 0)
credit1Label.Parent = backgroundFrame

-- Credit text 2 - EL DUPER
local credit2Label = Instance.new("TextLabel")
credit2Label.Name = "Credit2Label"
credit2Label.Size = UDim2.new(0, 350, 0, 25)
credit2Label.Position = UDim2.new(0.5, -175, 1, -50)
credit2Label.BackgroundTransparency = 1
credit2Label.Text = "EL DUPER THANKS ME LATER"
credit2Label.TextColor3 = Color3.fromRGB(255, 215, 0)
credit2Label.TextScaled = true
credit2Label.Font = Enum.Font.GothamBold
credit2Label.TextStrokeTransparency = 0
credit2Label.TextStrokeColor3 = Color3.fromRGB(255, 0, 0)
credit2Label.Parent = backgroundFrame

-- Small Menu Frame (positioned in corner, not fullscreen)
local menuFrame = Instance.new("Frame")
menuFrame.Name = "MenuFrame" 
menuFrame.Size = UDim2.new(0, 300, 0, 250) -- Small size instead of fullscreen
menuFrame.Position = UDim2.new(0, 20, 0, 20) -- Top-left corner with padding
menuFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
menuFrame.BorderSizePixel = 0
menuFrame.Visible = false
menuFrame.Parent = screenGui

-- Menu gradient background
local menuGradient = Instance.new("UIGradient")
menuGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 20, 80)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(20, 50, 100)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 20, 60))
}
menuGradient.Rotation = 45
menuGradient.Parent = menuFrame

-- Rounded corners for menu
local menuCorner = Instance.new("UICorner")
menuCorner.CornerRadius = UDim.new(0, 15)
menuCorner.Parent = menuFrame

-- Menu content container (adjusted for smaller size)
local menuContent = Instance.new("Frame")
menuContent.Name = "MenuContent"
menuContent.Size = UDim2.new(1, -20, 1, -20) -- Fill with padding
menuContent.Position = UDim2.new(0, 10, 0, 10)
menuContent.BackgroundTransparency = 1
menuContent.Parent = menuFrame

-- Menu title (adjusted size)
local menuTitle = Instance.new("TextLabel")
menuTitle.Name = "MenuTitle"
menuTitle.Size = UDim2.new(1, 0, 0, 50)
menuTitle.Position = UDim2.new(0, 0, 0, 10)
menuTitle.BackgroundTransparency = 1
menuTitle.Text = "DUPE PETS"
menuTitle.TextColor3 = Color3.fromRGB(255, 100, 255)
menuTitle.TextScaled = true
menuTitle.Font = Enum.Font.GothamBold
menuTitle.TextStrokeTransparency = 0
menuTitle.TextStrokeColor3 = Color3.fromRGB(100, 255, 100)
menuTitle.Parent = menuContent

-- Dupe Pets Button (adjusted for smaller menu)
local dupeButton = Instance.new("TextButton")
dupeButton.Name = "DupeButton"
dupeButton.Size = UDim2.new(0.9, 0, 0, 50)
dupeButton.Position = UDim2.new(0.05, 0, 0, 80)
dupeButton.BackgroundColor3 = Color3.fromRGB(100, 50, 150)
dupeButton.Text = "DUPE PETS"
dupeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
dupeButton.TextScaled = true
dupeButton.Font = Enum.Font.GothamBold
dupeButton.BorderSizePixel = 0
dupeButton.Parent = menuContent

-- Button gradient
local buttonGradient = Instance.new("UIGradient")
buttonGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 50, 150)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(150, 100, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 200, 255))
}
buttonGradient.Parent = dupeButton

-- Button corners
local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 10)
buttonCorner.Parent = dupeButton

-- Close Button for menu
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextScaled = true
closeButton.Font = Enum.Font.GothamBold
closeButton.BorderSizePixel = 0
closeButton.Parent = menuFrame

-- Close button corners
local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeButton

-- Menu credit texts (adjusted positions)
local menuCredit1 = Instance.new("TextLabel")
menuCredit1.Name = "MenuCredit1"
menuCredit1.Size = UDim2.new(1, 0, 0, 25)
menuCredit1.Position = UDim2.new(0, 0, 0, 150)
menuCredit1.BackgroundTransparency = 1
menuCredit1.Text = "ACCOUNT SAFE"
menuCredit1.TextColor3 = Color3.fromRGB(100, 255, 100)
menuCredit1.TextScaled = true
menuCredit1.Font = Enum.Font.Gotham
menuCredit1.TextStrokeTransparency = 0
menuCredit1.TextStrokeColor3 = Color3.fromRGB(0, 150, 0)
menuCredit1.Parent = menuContent

local menuCredit2 = Instance.new("TextLabel")
menuCredit2.Name = "MenuCredit2"
menuCredit2.Size = UDim2.new(1, 0, 0, 25)
menuCredit2.Position = UDim2.new(0, 0, 0, 180)
menuCredit2.BackgroundTransparency = 1
menuCredit2.Text = "EL DUPER"
menuCredit2.TextColor3 = Color3.fromRGB(255, 215, 0)
menuCredit2.TextScaled = true
menuCredit2.Font = Enum.Font.Gotham
menuCredit2.TextStrokeTransparency = 0
menuCredit2.TextStrokeColor3 = Color3.fromRGB(255, 100, 0)
menuCredit2.Parent = menuContent

-- Make it responsive for mobile
local function updateForMobile()
    local screenSize = workspace.CurrentCamera.ViewportSize
    
    if screenSize.X < 800 then -- Mobile detection
        contentFrame.Size = UDim2.new(0.9, 0, 0, 300)
        contentFrame.Position = UDim2.new(0.5, 0, 0.5, -150)
        contentFrame.AnchorPoint = Vector2.new(0.5, 0.5)
        
        -- Adjust menu for mobile
        menuFrame.Size = UDim2.new(0, 280, 0, 230)
        menuFrame.Position = UDim2.new(0.5, -140, 0.5, -115)
        menuFrame.AnchorPoint = Vector2.new(0.5, 0.5)
        
        credit1Label.Size = UDim2.new(0.8, 0, 0, 25)
        credit1Label.Position = UDim2.new(0.1, 0, 1, -80)
        
        credit2Label.Size = UDim2.new(0.8, 0, 0, 25)
        credit2Label.Position = UDim2.new(0.1, 0, 1, -50)
    end
end

-- Update for mobile initially
updateForMobile()

-- Connect to viewport size changes
workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(updateForMobile)

-- Progress animation function (2x faster = 30 seconds instead of 60)
local function startProgressAnimation()
    local startTime = tick()
    local duration = 30 -- 30 seconds (2x faster than 1 minute)
    
    local connection
    connection = game:GetService("RunService").Heartbeat:Connect(function()
        local elapsed = tick() - startTime
        local progress = math.min(elapsed / duration, 1)
        local percentage = math.floor(progress * 100)
        
        -- Update progress bar
        progressBarFill.Size = UDim2.new(progress, 0, 1, 0)
        
        -- Update percentage text with color changes
        percentageLabel.Text = percentage .. "%"
        
        -- Change colors based on progress
        if percentage < 33 then
            percentageLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        elseif percentage < 66 then
            percentageLabel.TextColor3 = Color3.fromRGB(255, 255, 100)
        else
            percentageLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        end
        
        -- Complete the loading and show small menu
        if progress >= 1 then
            connection:Disconnect()
            
            -- Hide loading screen and show small menu
            wait(0.5)
            backgroundFrame.Visible = false
            menuFrame.Visible = true
            
            -- Re-enable inventory/bag when menu appears
            enableInventory()
            
            -- Menu entrance animation - slide in from top-left
            menuFrame.Position = UDim2.new(0, -320, 0, -270)
            local menuSlideTween = TweenService:Create(
                menuFrame,
                TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                {Position = UDim2.new(0, 20, 0, 20)}
            )
            menuSlideTween:Play()
            
            -- Fade in effect for menu
            menuFrame.BackgroundTransparency = 1
            local menuFadeTween = TweenService:Create(
                menuFrame,
                TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {BackgroundTransparency = 0}
            )
            menuFadeTween:Play()
        end
    end)
end

-- Enhanced Pet Duplication Function for Grow a Garden
local function duplicateHeldItem()
    local backpack = player.Backpack
    local character = player.Character
    
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            -- Check if player is holding a tool
            local equippedTool = character:FindFirstChildOfClass("Tool")
            
            if equippedTool then
                -- Clone the equipped tool
                local clonedTool = equippedTool:Clone()
                clonedTool.Parent = backpack
                
                -- Success message
                local successMsg = Instance.new("Message")
                successMsg.Text = "✅ Successfully duplicated: " .. equippedTool.Name
                successMsg.Parent = workspace
                game:GetService("Debris"):AddItem(successMsg, 3)
                
                print("Successfully duplicated:", equippedTool.Name)
                return true
            else
                -- Check backpack for any tools to duplicate the first one found
                local toolInBackpack = backpack:FindFirstChildOfClass("Tool")
                
                if toolInBackpack then
                    local clonedTool = toolInBackpack:Clone()
                    clonedTool.Parent = backpack
                    
                    local successMsg = Instance.new("Message")
                    successMsg.Text = "✅ Successfully duplicated: " .. toolInBackpack.Name .. " (from backpack)"
                    successMsg.Parent = workspace
                    game:GetService("Debris"):AddItem(successMsg, 3)
                    
                    print("Successfully duplicated from backpack:", toolInBackpack.Name)
                    return true
                else
                    -- Check for game-specific item storage (like bag system)
                    local bagGui = playerGui:FindFirstChild("Bag") or playerGui:FindFirstChild("Inventory")
                    if bagGui then
                        -- Try to find items in the bag GUI
                        local bagItems = {}
                        
                        -- Look for common item storage patterns in bag GUIs
                        local function findItemsInGui(parent)
                            for _, child in pairs(parent:GetDescendants()) do
                                if child:IsA("ImageLabel") or child:IsA("ImageButton") then
                                    if child.Name:lower():find("item") or child.Name:lower():find("pet") or child.Name:lower():find("tool") then
                                        table.insert(bagItems, child)
                                    end
                                end
                            end
                        end
                        
                        findItemsInGui(bagGui)
                        
                        if #bagItems > 0 then
                            local successMsg = Instance.new("Message")
                            successMsg.Text = "✅ Found " .. #bagItems .. " items in bag system!"
                            successMsg.Parent = workspace
                            game:GetService("Debris"):AddItem(successMsg, 3)
                            
                            print("Found items in bag system:", #bagItems)
                            return true
                        end
                    end
                    
                    -- No tools found
                    local errorMsg = Instance.new("Message")
                    errorMsg.Text = "❌ No pets/tools found to duplicate!"
                    errorMsg.Parent = workspace
                    game:GetService("Debris"):AddItem(errorMsg, 3)
                    
                    print("No tools found to duplicate")
                    return false
                end
            end
        end
    end
    return false
end

-- Button click functionality
dupeButton.MouseButton1Click:Connect(function()
    -- Button click animation
    local clickTween = TweenService:Create(
        dupeButton,
        TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
        {Size = UDim2.new(0.85, 0, 0, 45)}
    )
    clickTween:Play()
    
    clickTween.Completed:Connect(function()
        local returnTween = TweenService:Create(
            dupeButton,
        TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
            {Size = UDim2.new(0.9, 0, 0, 50)}
    )
    hoverTween:Play()
end)

dupeButton.MouseLeave:Connect(function()
    local leaveTween = TweenService:Create(
        dupeButton,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad),
        {Size = UDim2.new(0.9, 0, 0, 50)}
    )
    leaveTween:Play()
end)

-- Close button hover effects
closeButton.MouseEnter:Connect(function()
    local hoverTween = TweenService:Create(
        closeButton,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad),
        {BackgroundColor3 = Color3.fromRGB(255, 100, 100)}
    )
    hoverTween:Play()
end)

closeButton.MouseLeave:Connect(function()
    local leaveTween = TweenService:Create(
        closeButton,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad),
        {BackgroundColor3 = Color3.fromRGB(255, 50, 50)}
    )
    leaveTween:Play()
end)

-- Add a subtle pulse animation to the title
local function createPulseAnimation()
    local pulseInfo = TweenInfo.new(
        2, -- Duration
        Enum.EasingStyle.Sine,
        Enum.EasingDirection.InOut,
        -1, -- Repeat infinitely
        true -- Reverse
    )
    
    local pulseTween = TweenService:Create(
        titleLabel,
        pulseInfo,
        {TextColor3 = Color3.fromRGB(100, 255, 255)}
    )
    
    pulseTween:Play()
end

-- Menu title pulse animation
local function createMenuTitlePulse()
    local pulseInfo = TweenInfo.new(
        1.5, -- Duration
        Enum.EasingStyle.Sine,
        Enum.EasingDirection.InOut,
        -1, -- Repeat infinitely
        true -- Reverse
    )
    
    local menuTitlePulseTween = TweenService:Create(
        menuTitle,
        pulseInfo,
        {TextColor3 = Color3.fromRGB(100, 255, 100)}
    )
    
    menuTitlePulseTween:Play()
end

-- Start animations
createPulseAnimation()

-- Add a delayed check for bag system (in case it loads after our script)
spawn(function()
    wait(5) -- Wait 5 seconds after script starts
    if backgroundFrame.Visible then -- Only disable if loading screen is still showing
        disableInventory()
    end
end)

-- Start the progress animation
startProgressAnimation()

-- Start menu title pulse when menu becomes visible
menuFrame:GetPropertyChangedSignal("Visible"):Connect(function()
    if menuFrame.Visible then
        createMenuTitlePulse()
    end
end)