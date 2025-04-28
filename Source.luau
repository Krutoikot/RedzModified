-- Official Redz Modified

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

-- Трекер Pirate Raid та Factory Raid
local function RaidTracker()
    task.spawn(function()
        while true do
            wait(60) -- Перевіряти кожну хвилину

            local ServerAge = math.floor(workspace.DistributedGameTime / 60) -- Вік сервера в хвилинах

            local TimeUntilPirateRaid = 75 - (ServerAge % 75) -- Піратський рейд кожні 75 хвилин
            local TimeUntilFactoryRaid = 90 - (ServerAge % 90) -- Фабрика кожні 90 хвилин

            -- Повідомлення коли скоро рейди
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
    end)
end

-- Основний запуск
pcall(function()
    AutoJoinTeam()
    AutoTranslate()
    RaidTracker()
end)

-- Вітальне повідомлення
pcall(function()
    game.StarterGui:SetCore("SendNotification", {
        Title = "✅ REDZ Loaded",
        Text = "Модифікована версія активована!",
        Duration = 5
    })
end)
