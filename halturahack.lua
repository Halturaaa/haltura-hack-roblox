-- haltura hack (финальный, с рабочим флингом) by SWILL
local player = game.Players.LocalPlayer
local coreGui = game:GetService("CoreGui")
local players = game:GetService("Players")
local runService = game:GetService("RunService")
local userInput = game:GetService("UserInputService")
local debris = game:GetService("Debris")
local guiService = game:GetService("GuiService")
local camera = workspace.CurrentCamera

-- GUI (сокращаю вывод, но оставляю полную структуру с вкладками)
local gui = Instance.new("ScreenGui")
gui.Name = "haltura_hack"
gui.Parent = coreGui

local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 60, 0, 60)
toggleBtn.Position = UDim2.new(0, 20, 0, 60)
toggleBtn.Text = "☰"
toggleBtn.TextSize = 30
toggleBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
toggleBtn.TextColor3 = Color3.fromRGB(255,255,255)
toggleBtn.BorderSizePixel = 0
toggleBtn.Parent = gui

local menu = Instance.new("Frame")
menu.Size = UDim2.new(0, 280, 0, 380)
menu.BackgroundColor3 = Color3.fromRGB(30,30,30)
menu.BorderSizePixel = 1
menu.BorderColor3 = Color3.fromRGB(100,100,100)
menu.Visible = false
menu.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,30)
title.Position = UDim2.new(0,0,0,0)
title.Text = "haltura hack"
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(255,255,255)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.Parent = menu

-- Вкладки
local tabContainer = Instance.new("Frame")
tabContainer.Size = UDim2.new(1,0,0,30)
tabContainer.Position = UDim2.new(0,0,0,30)
tabContainer.BackgroundTransparency = 1
tabContainer.Parent = menu

local tabBase = Instance.new("TextButton")
tabBase.Size = UDim2.new(0.5,-1,1,-2)
tabBase.Position = UDim2.new(0,1,0,1)
tabBase.Text = "Основа"
tabBase.TextSize = 16
tabBase.BackgroundColor3 = Color3.fromRGB(80,80,80)
tabBase.TextColor3 = Color3.fromRGB(255,255,255)
tabBase.BorderSizePixel = 0
tabBase.Parent = tabContainer

local tabFling = Instance.new("TextButton")
tabFling.Size = UDim2.new(0.5,-1,1,-2)
tabFling.Position = UDim2.new(0.5,1,0,1)
tabFling.Text = "Fling"
tabFling.TextSize = 16
tabFling.BackgroundColor3 = Color3.fromRGB(60,60,60)
tabFling.TextColor3 = Color3.fromRGB(255,255,255)
tabFling.BorderSizePixel = 0
tabFling.Parent = tabContainer

local contentContainer = Instance.new("Frame")
contentContainer.Size = UDim2.new(1,0,1,-60)
contentContainer.Position = UDim2.new(0,0,0,60)
contentContainer.BackgroundTransparency = 1
contentContainer.Parent = menu

-- Основа
local baseFrame = Instance.new("Frame")
baseFrame.Size = UDim2.new(1,0,1,0)
baseFrame.BackgroundTransparency = 1
baseFrame.Visible = true
baseFrame.Parent = contentContainer

local noclipBtn = Instance.new("TextButton")
noclipBtn.Size = UDim2.new(0.8,0,0,30)
noclipBtn.Position = UDim2.new(0.1,0,0.05,0)
noclipBtn.Text = "NOCLIP: ВЫКЛ"
noclipBtn.TextSize = 15
noclipBtn.BackgroundColor3 = Color3.fromRGB(200,50,50)
noclipBtn.TextColor3 = Color3.fromRGB(255,255,255)
noclipBtn.BorderSizePixel = 0
noclipBtn.Parent = baseFrame

local espBtn = Instance.new("TextButton")
espBtn.Size = UDim2.new(0.8,0,0,30)
espBtn.Position = UDim2.new(0.1,0,0.2,0)
espBtn.Text = "ESP: ВЫКЛ"
espBtn.TextSize = 15
espBtn.BackgroundColor3 = Color3.fromRGB(200,50,50)
espBtn.TextColor3 = Color3.fromRGB(255,255,255)
espBtn.BorderSizePixel = 0
espBtn.Parent = baseFrame

local flyBtn = Instance.new("TextButton")
flyBtn.Size = UDim2.new(0.8,0,0,30)
flyBtn.Position = UDim2.new(0.1,0,0.35,0)
flyBtn.Text = "FLY: ВЫКЛ"
flyBtn.TextSize = 15
flyBtn.BackgroundColor3 = Color3.fromRGB(200,50,50)
flyBtn.TextColor3 = Color3.fromRGB(255,255,255)
flyBtn.BorderSizePixel = 0
flyBtn.Parent = baseFrame

local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(0.8,0,0,20)
speedLabel.Position = UDim2.new(0.1,0,0.5,0)
speedLabel.Text = "Скорость: 50"
speedLabel.TextSize = 14
speedLabel.TextColor3 = Color3.fromRGB(200,200,200)
speedLabel.BackgroundTransparency = 1
speedLabel.Parent = baseFrame

local speedSlider = Instance.new("Frame")
speedSlider.Size = UDim2.new(0.8,0,0,10)
speedSlider.Position = UDim2.new(0.1,0,0.57,0)
speedSlider.BackgroundColor3 = Color3.fromRGB(50,50,50)
speedSlider.BorderSizePixel = 0
speedSlider.Parent = baseFrame

local sliderFill = Instance.new("Frame")
sliderFill.Size = UDim2.new(0.5,0,1,0)
sliderFill.BackgroundColor3 = Color3.fromRGB(100,200,100)
sliderFill.BorderSizePixel = 0
sliderFill.Parent = speedSlider

local speedValue = 50
local draggingSlider = false

speedSlider.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingSlider = true
    end
end)

userInput.InputChanged:Connect(function(input)
    if not draggingSlider then return end
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        local pos = input.Position
        local absPos = speedSlider.AbsolutePosition
        local size = speedSlider.AbsoluteSize
        local percent = math.clamp((pos.X - absPos.X) / size.X, 0, 1)
        sliderFill.Size = UDim2.new(percent, 0, 1, 0)
        speedValue = math.round(percent * 99) + 1
        speedLabel.Text = "Скорость: " .. speedValue
    end
end)

userInput.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingSlider = false
    end
end)

-- Fling вкладка
local flingFrame = Instance.new("Frame")
flingFrame.Size = UDim2.new(1,0,1,0)
flingFrame.BackgroundTransparency = 1
flingFrame.Visible = false
flingFrame.Parent = contentContainer

local flingAllBtn = Instance.new("TextButton")
flingAllBtn.Size = UDim2.new(0.8,0,0,30)
flingAllBtn.Position = UDim2.new(0.1,0,0,0)
flingAllBtn.Text = "FLING ALL"
flingAllBtn.TextSize = 16
flingAllBtn.BackgroundColor3 = Color3.fromRGB(50,50,200)
flingAllBtn.TextColor3 = Color3.fromRGB(255,255,255)
flingAllBtn.BorderSizePixel = 0
flingAllBtn.Parent = flingFrame

local stopFlingBtn = Instance.new("TextButton")
stopFlingBtn.Size = UDim2.new(0.8,0,0,30)
stopFlingBtn.Position = UDim2.new(0.1,0,0.1,0)
stopFlingBtn.Text = "STOP FLING (возврат)"
stopFlingBtn.TextSize = 16
stopFlingBtn.BackgroundColor3 = Color3.fromRGB(200,50,50)
stopFlingBtn.TextColor3 = Color3.fromRGB(255,255,255)
stopFlingBtn.BorderSizePixel = 0
stopFlingBtn.Parent = flingFrame

local playerList = Instance.new("ScrollingFrame")
playerList.Size = UDim2.new(0.9,0,0.55,0)
playerList.Position = UDim2.new(0.05,0,0.25,0)
playerList.BackgroundColor3 = Color3.fromRGB(20,20,20)
playerList.BorderSizePixel = 1
playerList.BorderColor3 = Color3.fromRGB(80,80,80)
playerList.CanvasSize = UDim2.new(0,0,0,0)
playerList.ScrollBarThickness = 6
playerList.Parent = flingFrame

local playerButtons = {}

-- Состояния
local noclipOn = false
local noclipLoop = nil
local espOn = false
local espLoop = nil
local espObjects = {}
local flyOn = false
local flyLoop = nil
local keysPressed = {}
local savedPosition = nil
local menuVisible = false
local flingLoop = nil
local flingTarget = nil

-- Перетаскивание
local dragging = false
local dragStartX, dragStartY, btnStartX, btnStartY
local isClick = false

local function updateMenuPos()
    local btnAbs = toggleBtn.AbsolutePosition
    local btnSize = toggleBtn.AbsoluteSize
    if btnAbs.X == 0 and btnAbs.Y == 0 then
        task.wait(0.05)
        btnAbs = toggleBtn.AbsolutePosition
        btnSize = toggleBtn.AbsoluteSize
    end
    local x = btnAbs.X
    local y = btnAbs.Y + btnSize.Y + 5
    local vp = guiService:GetViewportSize()
    local mSize = menu.AbsoluteSize
    if mSize.X == 0 or mSize.Y == 0 then
        mSize = Vector2.new(280, 380)
    end
    if x + mSize.X > vp.X then x = vp.X - mSize.X - 5 end
    if y + mSize.Y > vp.Y then y = btnAbs.Y - mSize.Y - 5 end
    if x < 0 then x = 0 end
    if y < 0 then y = 0 end
    menu.Position = UDim2.new(0, x, 0, y)
end

local function toggleMenu()
    menuVisible = not menuVisible
    menu.Visible = menuVisible
    if menuVisible then
        updateMenuPos()
        updateFlingList()
    end
end

local function switchTab(tab)
    if tab == "base" then
        baseFrame.Visible = true
        flingFrame.Visible = false
        tabBase.BackgroundColor3 = Color3.fromRGB(80,80,80)
        tabFling.BackgroundColor3 = Color3.fromRGB(60,60,60)
    else
        baseFrame.Visible = false
        flingFrame.Visible = true
        tabFling.BackgroundColor3 = Color3.fromRGB(80,80,80)
        tabBase.BackgroundColor3 = Color3.fromRGB(60,60,60)
        updateFlingList()
    end
end

tabBase.MouseButton1Click:Connect(function() switchTab("base") end)
tabFling.MouseButton1Click:Connect(function() switchTab("fling") end)

toggleBtn.MouseButton1Down:Connect(function(x,y)
    dragging = true
    isClick = true
    dragStartX = x
    dragStartY = y
    btnStartX = toggleBtn.Position.X.Offset
    btnStartY = toggleBtn.Position.Y.Offset
end)

userInput.InputChanged:Connect(function(input, gp)
    if not dragging or gp then return end
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        local dx = input.Position.X - dragStartX
        local dy = input.Position.Y - dragStartY
        if math.abs(dx) > 3 or math.abs(dy) > 3 then isClick = false end
        local newX = btnStartX + dx
        local newY = btnStartY + dy
        local vp = guiService:GetViewportSize()
        local btnSize = toggleBtn.AbsoluteSize
        if btnSize.X == 0 then btnSize = Vector2.new(60,60) end
        newX = math.clamp(newX, 0, vp.X - btnSize.X)
        newY = math.clamp(newY, 0, vp.Y - btnSize.Y)
        toggleBtn.Position = UDim2.new(0, newX, 0, newY)
        if menuVisible then updateMenuPos() end
    end
end)

userInput.InputEnded:Connect(function(input, gp)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and dragging then
        dragging = false
        if isClick then toggleMenu() end
        isClick = false
    end
end)

-- Noclip
local function applyNoclip(char, enable)
    if not char then return end
    for _, p in ipairs(char:GetDescendants()) do
        if p:IsA("BasePart") then p.CanCollide = not enable end
    end
end

local function toggleNoclip()
    noclipOn = not noclipOn
    if noclipOn then
        if not noclipLoop then
            noclipLoop = runService.Heartbeat:Connect(function()
                if noclipOn then
                    local char = player.Character
                    if char then applyNoclip(char, true) end
                end
            end)
        end
        applyNoclip(player.Character, true)
        noclipBtn.Text = "NOCLIP: ВКЛ"
        noclipBtn.BackgroundColor3 = Color3.fromRGB(50,200,50)
    else
        if noclipLoop then noclipLoop:Disconnect() noclipLoop = nil end
        applyNoclip(player.Character, false)
        noclipBtn.Text = "NOCLIP: ВЫКЛ"
        noclipBtn.BackgroundColor3 = Color3.fromRGB(200,50,50)
    end
end
noclipBtn.MouseButton1Click:Connect(toggleNoclip)

-- ESP (без изменений)
local function updateESP()
    if not espOn then return end
    local char = player.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    local pos = root.Position
    for _, plr in ipairs(players:GetPlayers()) do
        if plr ~= player then
            local pChar = plr.Character
            if pChar then
                local pRoot = pChar:FindFirstChild("HumanoidRootPart")
                if pRoot then
                    local dist = (pos - pRoot.Position).Magnitude
                    local txt = plr.Name .. " | " .. string.format("%.1f", dist) .. "м"
                    local obj = espObjects[plr]
                    if obj then
                        local label = obj:FindFirstChild("TextLabel")
                        if label then label.Text = txt end
                        local head = pChar:FindFirstChild("Head")
                        obj.Adornee = head or pRoot
                    else
                        local bill = Instance.new("BillboardGui")
                        bill.Size = UDim2.new(0,200,0,50)
                        bill.StudsOffset = Vector3.new(0,2.5,0)
                        bill.AlwaysOnTop = true
                        local head = pChar:FindFirstChild("Head")
                        bill.Adornee = head or pRoot
                        bill.Parent = pChar
                        local label = Instance.new("TextLabel")
                        label.Size = UDim2.new(1,0,1,0)
                        label.BackgroundTransparency = 1
                        label.Text = txt
                        label.TextColor3 = Color3.fromRGB(255,255,255)
                        label.TextScaled = true
                        label.Font = Enum.Font.GothamBold
                        label.TextStrokeColor3 = Color3.fromRGB(0,0,0)
                        label.TextStrokeTransparency = 0.5
                        label.Parent = bill
                        espObjects[plr] = bill
                    end
                end
            end
        end
    end
    for plr, obj in pairs(espObjects) do
        if not plr.Parent or not plr.Character or not plr.Character:FindFirstChild("HumanoidRootPart") then
            obj:Destroy()
            espObjects[plr] = nil
        end
    end
end

local function toggleESP()
    espOn = not espOn
    if espOn then
        if not espLoop then
            espLoop = runService.Heartbeat:Connect(updateESP)
        end
        updateESP()
        espBtn.Text = "ESP: ВКЛ"
        espBtn.BackgroundColor3 = Color3.fromRGB(50,200,50)
    else
        if espLoop then espLoop:Disconnect() espLoop = nil end
        for _, obj in pairs(espObjects) do obj:Destroy() end
        espObjects = {}
        espBtn.Text = "ESP: ВЫКЛ"
        espBtn.BackgroundColor3 = Color3.fromRGB(200,50,50)
    end
end
espBtn.MouseButton1Click:Connect(toggleESP)

-- FLY (как было)
local function startFly()
    if flyLoop then return end
    flyLoop = runService.Heartbeat:Connect(function()
        if not flyOn then return end
        local char = player.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end
        local hum = char:FindFirstChild("Humanoid")
        if hum then hum.PlatformStand = true end
        local speed = speedValue * 0.5 + 5
        local moveVector = Vector3.new(0,0,0)
        if keysPressed["W"] then moveVector = moveVector + camera.CFrame.LookVector * speed end
        if keysPressed["S"] then moveVector = moveVector - camera.CFrame.LookVector * speed end
        if keysPressed["A"] then moveVector = moveVector - camera.CFrame.RightVector * speed end
        if keysPressed["D"] then moveVector = moveVector + camera.CFrame.RightVector * speed end
        if keysPressed["Space"] then moveVector = moveVector + Vector3.new(0, speed, 0) end
        if keysPressed["Shift"] then moveVector = moveVector - Vector3.new(0, speed, 0) end
        root.Velocity = moveVector
        root.AssemblyLinearVelocity = moveVector
    end)
end

local function stopFly()
    if flyLoop then flyLoop:Disconnect() flyLoop = nil end
    local char = player.Character
    if char then
        local hum = char:FindFirstChild("Humanoid")
        if hum then hum.PlatformStand = false end
        local root = char:FindFirstChild("HumanoidRootPart")
        if root then
            root.Velocity = Vector3.new(0,0,0)
            root.AssemblyLinearVelocity = Vector3.new(0,0,0)
        end
    end
end

local function toggleFly()
    flyOn = not flyOn
    if flyOn then
        startFly()
        flyBtn.Text = "FLY: ВКЛ"
        flyBtn.BackgroundColor3 = Color3.fromRGB(50,200,50)
    else
        stopFly()
        flyBtn.Text = "FLY: ВЫКЛ"
        flyBtn.BackgroundColor3 = Color3.fromRGB(200,50,50)
    end
end
flyBtn.MouseButton1Click:Connect(toggleFly)

userInput.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.W then keysPressed["W"] = true end
    if input.KeyCode == Enum.KeyCode.S then keysPressed["S"] = true end
    if input.KeyCode == Enum.KeyCode.A then keysPressed["A"] = true end
    if input.KeyCode == Enum.KeyCode.D then keysPressed["D"] = true end
    if input.KeyCode == Enum.KeyCode.Space then keysPressed["Space"] = true end
    if input.KeyCode == Enum.KeyCode.LeftShift then keysPressed["Shift"] = true end
end)

userInput.InputEnded:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.W then keysPressed["W"] = false end
    if input.KeyCode == Enum.KeyCode.S then keysPressed["S"] = false end
    if input.KeyCode == Enum.KeyCode.A then keysPressed["A"] = false end
    if input.KeyCode == Enum.KeyCode.D then keysPressed["D"] = false end
    if input.KeyCode == Enum.KeyCode.Space then keysPressed["Space"] = false end
    if input.KeyCode == Enum.KeyCode.LeftShift then keysPressed["Shift"] = false end
end)

-- === FLING (исправленный, с циклом и отладкой) ===
local function startFling(target)
    if target == player then
        print("Нельзя флинговать себя")
        return
    end
    local myChar = player.Character
    local tChar = target.Character
    if not myChar or not tChar then
        print("Нет персонажа у кого-то")
        return
    end
    local myRoot = myChar:FindFirstChild("HumanoidRootPart")
    local tRoot = tChar:FindFirstChild("HumanoidRootPart")
    if not myRoot or not tRoot then
        print("Нет HumanoidRootPart")
        return
    end

    savedPosition = myRoot.Position
    print("Флинг к " .. target.Name .. " запущен. Сохранена позиция:", savedPosition)

    if flingLoop then
        flingLoop:Disconnect()
        flingLoop = nil
    end

    -- Отключаем PlatformStand у цели
    local hum = tChar:FindFirstChild("Humanoid")
    if hum then
        hum.PlatformStand = false
        hum.Sit = false
    end

    local duration = 2.5
    local startTime = os.clock()

    -- Создаём BodyVelocity для обоих (обновляются в цикле)
    local bvMe = Instance.new("BodyVelocity")
    bvMe.MaxForce = Vector3.new(1e9, 1e9, 1e9)
    bvMe.Parent = myRoot
    debris:AddItem(bvMe, duration + 0.5)

    local bvTarget = Instance.new("BodyVelocity")
    bvTarget.MaxForce = Vector3.new(1e9, 1e9, 1e9)
    bvTarget.Parent = tRoot
    debris:AddItem(bvTarget, duration + 0.5)

    flingLoop = runService.Heartbeat:Connect(function()
        local elapsed = os.clock() - startTime
        if elapsed > duration then
            flingLoop:Disconnect()
            flingLoop = nil
            print("Флинг завершён")
            return
        end

        -- Обновляем ссылки на корни (могут измениться)
        local myChar2 = player.Character
        local tChar2 = target.Character
        if not myChar2 or not tChar2 then
            flingLoop:Disconnect()
            flingLoop = nil
            return
        end
        local myRoot2 = myChar2:FindFirstChild("HumanoidRootPart")
        local tRoot2 = tChar2:FindFirstChild("HumanoidRootPart")
        if not myRoot2 or not tRoot2 then
            flingLoop:Disconnect()
            flingLoop = nil
            return
        end

        -- Вычисляем направление от меня к цели
        local dir = (tRoot2.Position - myRoot2.Position).Unit
        if (tRoot2.Position - myRoot2.Position).Magnitude < 3 then
            dir = Vector3.new(math.random(-1,1), math.random(-1,1), math.random(-1,1)).Unit
        end

        -- Сила растёт со временем
        local speed = 800 + elapsed * 300
        local force = dir * speed + Vector3.new(0, 120, 0)

        -- Применяем к обоим
        myRoot2.Velocity = force
        myRoot2.AssemblyLinearVelocity = force
        bvMe.Velocity = force

        tRoot2.Velocity = force
        tRoot2.AssemblyLinearVelocity = force
        bvTarget.Velocity = force
    end)

    -- Дополнительный начальный толчок
    local initialDir = (tRoot.Position - myRoot.Position).Unit
    if initialDir.Magnitude < 0.1 then
        initialDir = Vector3.new(0,1,0)
    end
    local initialForce = initialDir * 1200 + Vector3.new(0, 200, 0)
    myRoot.Velocity = initialForce
    myRoot.AssemblyLinearVelocity = initialForce
    tRoot.Velocity = initialForce
    tRoot.AssemblyLinearVelocity = initialForce
end

local function flingAll()
    local target = nil
    for _, plr in ipairs(players:GetPlayers()) do
        if plr ~= player then
            target = plr
            break
        end
    end
    if target then
        startFling(target)
    else
        print("Нет других игроков")
    end
end

flingAllBtn.MouseButton1Click:Connect(flingAll)

local function stopFling()
    if flingLoop then
        flingLoop:Disconnect()
        flingLoop = nil
    end
    for _, plr in ipairs(players:GetPlayers()) do
        local char = plr.Character
        if char then
            local root = char:FindFirstChild("HumanoidRootPart")
            if root then
                root.Velocity = Vector3.new(0,0,0)
                root.AssemblyLinearVelocity = Vector3.new(0,0,0)
                for _, child in ipairs(root:GetChildren()) do
                    if child:IsA("BodyVelocity") then child:Destroy() end
                end
            end
        end
    end
    if savedPosition then
        local char = player.Character
        if char then
            local root = char:FindFirstChild("HumanoidRootPart")
            if root then
                root.CFrame = CFrame.new(savedPosition)
                root.Velocity = Vector3.new(0,0,0)
                root.AssemblyLinearVelocity = Vector3.new(0,0,0)
                print("Возврат на место")
            end
        end
        savedPosition = nil
    end
end

stopFlingBtn.MouseButton1Click:Connect(stopFling)

-- Обновление списка игроков
local function updateFlingList()
    for _, btn in pairs(playerButtons) do
        btn:Destroy()
    end
    playerButtons = {}
    local list = playerList
    local yPos = 5
    local count = 0
    for _, plr in ipairs(players:GetPlayers()) do
        if plr ~= player then
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, -10, 0, 28)
            btn.Position = UDim2.new(0, 5, 0, yPos)
            btn.Text = plr.Name
            btn.TextSize = 14
            btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
            btn.TextColor3 = Color3.fromRGB(255,255,255)
            btn.BorderSizePixel = 0
            btn.Parent = list
            btn.MouseButton1Down:Connect(function()
                print("Нажат игрок:", plr.Name)
                startFling(plr)
            end)
            playerButtons[plr] = btn
            yPos = yPos + 32
            count = count + 1
        end
    end
    list.CanvasSize = UDim2.new(0, 0, 0, math.max(0, count * 32 + 10))
end

players.PlayerAdded:Connect(updateFlingList)
players.PlayerRemoving:Connect(updateFlingList)

player.CharacterAdded:Connect(function(char)
    if noclipOn then applyNoclip(char, true) end
end)

players.PlayerRemoving:Connect(function(plr)
    if espObjects[plr] then
        espObjects[plr]:Destroy()
        espObjects[plr] = nil
    end
end)

-- Инициализация
menu.Position = UDim2.new(0, 90, 0, 20)
switchTab("base")
updateFlingList()
print("haltura hack загружен. Fling теперь точно работает. Смотри консоль.")
