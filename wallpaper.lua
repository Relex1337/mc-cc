-- Monitor initialisieren
local monitor = peripheral.wrap("top")  -- Passe die Seite an, falls der Monitor anders angeschlossen ist
monitor.setTextScale(0.5)  -- Textgröße verringern, damit mehr Elemente auf dem Bildschirm passen
monitor.clear()

-- Farben, die in der Animation verwendet werden
local colorsList = {colors.red, colors.orange, colors.yellow, colors.green, colors.cyan, colors.blue, colors.purple, colors.white}

-- Initialisierung der Quadrate
local squares = {}
local numSquares = 20  -- Anzahl der Quadrate auf dem Bildschirm

-- Bildschirmgröße
local width, height = monitor.getSize()

-- Quadrate mit zufälligen Positionen und Geschwindigkeiten generieren
for i = 1, numSquares do
    table.insert(squares, {
        x = math.random(1, width),
        y = math.random(1, height),
        dx = math.random(-1, 1),
        dy = math.random(-1, 1),
        color = colorsList[math.random(#colorsList)]
    })
end

-- Funktion zur Aktualisierung der Quadrate
local function updateSquares()
    for i, square in ipairs(squares) do
        -- Position aktualisieren
        square.x = square.x + square.dx
        square.y = square.y + square.dy

        -- Begrenzungen prüfen und Richtung umkehren
        if square.x < 1 or square.x > width then
            square.dx = -square.dx
            square.x = math.max(1, math.min(square.x, width))
        end
        if square.y < 1 or square.y > height then
            square.dy = -square.dy
            square.y = math.max(1, math.min(square.y, height))
        end
    end
end

-- Funktion zur Anzeige der Quadrate auf dem Monitor
local function drawSquares()
    monitor.clear()
    for _, square in ipairs(squares) do
        monitor.setBackgroundColor(square.color)
        monitor.setCursorPos(square.x, square.y)
        monitor.write(" ")  -- Quadrat darstellen
    end
    monitor.setBackgroundColor(colors.black)  -- Hintergrundfarbe zurücksetzen
end

-- Hauptanimationsschleife
while true do
    updateSquares()  -- Positionen aktualisieren
    drawSquares()    -- Zeichnen
    sleep(0.1)       -- Kurze Pause für Animationseffekt
end
