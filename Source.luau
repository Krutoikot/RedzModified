local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local collected = {}
local delayBetweenTargets = 0.5 -- затримка між цілями

-- Функція для наведення камери
local function lookAt(targetPosition)
    local character = player.Character or player.CharacterAdded:Wait()
    local hrp = character:WaitForChild("HumanoidRootPart")
    local direction = (targetPosition - hrp.Position).Unit
    local newCFrame = CFrame.new(hrp.Position, hrp.Position + direction)
    camera.CFrame = newCFrame
end

-- Функція для імітації натиску кнопки (мобільний режим)
local function tapScreen()
    local viewportSize = camera.ViewportSize
    local screenCenter = Vector2.new(viewportSize.X / 2, viewportSize.Y / 2)

    -- Генерує тап по центру екрана
    UserInputService.InputBegan:Fire({
        UserInputType = Enum.UserInputType.Touch,
        Position = screenCenter,
    }, false)
end

-- Основний цикл збору Bound
local function autoCollectBounds()
    while true do
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Part") and obj.Name == "Bound" and not collected[obj] then
                collected[obj] = true
                lookAt(obj.Position)
                wait(0.2) -- дати часу камері на оберт
                tapScreen()
                wait(delayBetweenTargets)
            end
        end
        wait(1) -- пауза перед новим проходом
    end
end

-- Запускаємо автофарм
coroutine.wrap(autoCollectBounds)()
