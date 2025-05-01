-- Створення GUI
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local InputBox = Instance.new("TextBox")
local EnterButton = Instance.new("TextButton")
local GenerateButton = Instance.new("TextButton")
local Title = Instance.new("TextLabel")

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.Name = "CodeGui"

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Frame.Size = UDim2.new(0, 300, 0, 180)
Frame.Position = UDim2.new(0.5, -150, 0.5, -90)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true

Title.Parent = Frame
Title.Text = "Blox Fruits Code GUI"
Title.Size = UDim2.new(1, 0, 0, 30)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

InputBox.Parent = Frame
InputBox.Position = UDim2.new(0.1, 0, 0.3, 0)
InputBox.Size = UDim2.new(0.8, 0, 0.2, 0)
InputBox.PlaceholderText = "Введи або згенеруй код"
InputBox.Text = ""
InputBox.Font = Enum.Font.Code
InputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
InputBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

EnterButton.Parent = Frame
EnterButton.Position = UDim2.new(0.1, 0, 0.6, 0)
EnterButton.Size = UDim2.new(0.35, 0, 0.2, 0)
EnterButton.Text = "Ввести"
EnterButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
EnterButton.Font = Enum.Font.GothamBold
EnterButton.TextColor3 = Color3.fromRGB(255, 255, 255)

GenerateButton.Parent = Frame
GenerateButton.Position = UDim2.new(0.55, 0, 0.6, 0)
GenerateButton.Size = UDim2.new(0.35, 0, 0.2, 0)
GenerateButton.Text = "Генерувати"
GenerateButton.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
GenerateButton.Font = Enum.Font.GothamBold
GenerateButton.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Генератор випадкових кодів
local function generateCode()
    local charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local function randSeg()
        local s = ""
        for _ = 1, 4 do
            local i = math.random(1, #charset)
            s = s .. charset:sub(i, i)
        end
        return s
    end
    return "BF-PLUSH-" .. randSeg() .. "-" .. randSeg()
end

-- Обробка кнопок
GenerateButton.MouseButton1Click:Connect(function()
    InputBox.Text = generateCode()
end)

EnterButton.MouseButton1Click:Connect(function()
    local code = InputBox.Text
    if code ~= "" then
        local success, err = pcall(function()
            game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer(code)
        end)
        if not success then
            warn("Не вдалося ввести код: " .. tostring(err))
        end
    end
end)
