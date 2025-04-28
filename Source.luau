-- Official Redz Modified with Raid Timers

local Settings = _G.Settings or {
    JoinTeam = "Pirates"; -- Pirates/Marines
    Translator = true; -- true/false
}

-- Автовступ до команди
local function AutoJoinTeam()
    if Settings.JoinTeam == "Pirates" or Settings.JoinTeam == "Marines" then
        repeat
            wait()
            if game.Players.LocalPlayer.Team == nil then
                local args = {
                    [1] = Settings.JoinTeam
                }
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", unpack(args))
            end
        until game.Players.LocalPlayer.Team ~= nil
    end
end

-- Запуск автозміни мови інтерфейсу
local function AutoTranslate()
    if Settings.Translator then
        game:GetService("Players").LocalPlayer.PlayerGui.Main.Menu.Language.Visible = false
    end
end

-- Функція для створення GUI таймерів
local function CreateRaidTimers()
    -- Створення GUI
    local player = game.Players.LocalPlayer
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = player.PlayerGui

    -- Стиль для таймерів
    local timerStyle = {
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Font = Enum.Font.GothamBold,
        TextSize = 20,
        TextStrokeTransparency = 0.8,
        TextStrokeColor3 = Color3.fromRGB(0, 0, 0),
    }

    -- Створення текстових полів для таймерів
    local pirateRaidTimer = Instance.new("TextLabel")
    pirateRaidTimer.Size = UDim2.new(0, 200, 0, 50)
    pirateRaidTimer.Position = UDim2.new(0.5, -100, 0, 20)  -- Центр
    pirateRaidTimer.Text = "🛡 Піратський рейд через: 00:00"
    pirateRaidTimer.Parent = screenGui
    for key, value in pairs(timerStyle) do
        pirateRaidTimer[key] = value
    end

    local factoryRaidTimer = Instance.new("TextLabel")
    factoryRaidTimer.Size = UDim2.new(0, 200, 0, 50)
    factoryRaidTimer.Position = UDim2.new(0.5, -100, 0, 70) -- Під першим таймером
    factoryRaidTimer.Text = "🏭 Фабрика через: 00:00"
    factoryRaidTimer.Parent = screenGui
    for key, value in pairs(timerStyle) do
        factoryRaidTimer[key] = value
    end

    -- Функція для обчислення часу до рейду
    local function UpdateRaidTimers()
        while true do
            wait(1)  -- Оновлювати кожну секунду

            local ServerAge = math.floor(workspace.DistributedGameTime / 60) -- Вік сервера в хвилинах

            local TimeUntilPirateRaid = 75 - (ServerAge % 75) -- Піратський рейд кожні 75 хвилин
            local TimeUntilFactoryRaid = 90 - (ServerAge % 90) -- Фабрика кожні 90 хвилин

            -- Форматування часу до рейдів
            local minutesPirate = math.floor(TimeUntilPirateRaid)
            local secondsPirate = math.floor((TimeUntilPirateRaid - minutesPirate) * 60)

            local minutesFactory = math.floor(TimeUntilFactoryRaid)
            local secondsFactory = math.floor((TimeUntilFactoryRaid - minutesFactory) * 60)

            -- Оновлення тексту таймерів
            pirateRaidTimer.Text = "🛡 Піратський рейд через: " .. string.format("%02d:%02d", minutesPirate, secondsPirate)
            factoryRaidTimer.Text = "🏭 Фабрика через: " .. string.format("%02d:%02d", minutesFactory, secondsFactory)

            -- Якщо залишилось менше 5 хвилин - показуємо повідомлення
            if TimeUntilPirateRaid <= 5 then
                pcall(function()
                    game.StarterGui:SetCore("SendNotification", {
                        Title = "⚔️ Піратський Рейд",
                        Text = "Почнеться через " .. TimeUntilPirateRaid .. " хвилин!",
                        Duration = 10
                    })
                end)
            end

            if TimeUntilFactoryRaid <= 5 then
                pcall(function()
                    game.StarterGui:SetCore("SendNotification", {
                        Title = "🏭 Рейд Фабрики",
                        Text = "Фабрика відкриється через " .. TimeUntilFactoryRaid .. " хвилин!",
                        Duration = 10
                    })
                end)
            end
        end
    end

    -- Оновлюємо таймери
    UpdateRaidTimers()
end

-- Основний запуск
pcall(function()
    AutoJoinTeam()
    AutoTranslate()
    CreateRaidTimers()
end)

-- Вітальне повідомлення
pcall(function()
    game.StarterGui:SetCore("SendNotification", {
        Title = "✅ REDZ Loaded",
        Text = "Модифікована версія активована!",
        Duration = 5
    })
end)
