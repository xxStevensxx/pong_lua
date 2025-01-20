-- Débogueur Visual Studio Code tomblind.local-lua-debugger-vscode
if pcall(require, "lldebugger") then
    require("lldebugger").start()
  end
  
  -- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
  io.stdout:setvbuf("no")

-- On creer notre padG placé dans une liste puis on lui ajoute des champs
padG = {}
padG.x = 0
padG.y = 0
padG.largeur = 20
padG.hauteur = 150


-- On creer notre padD placé dans une liste puis on lui ajoute des champs
padD = {}
padD.largeur = 20
padD.hauteur = 150
padD.x = love.graphics.getWidth() - padD.largeur
padD.y = love.graphics.getHeight()/2 - padD.hauteur


-- On creer notre balle placé dans une liste puis on lui ajoute des champs
balle = {}
balle.largeur = 20 
balle.hauteur = 20
balle.x = love.graphics.getWidth()/2 - balle.largeur
balle.y = love.graphics.getHeight()/2 - balle.hauteur
balle.vitesse_y = 2
balle.vitesse_x = 2


-- scoring
score = {}
score.joueurUn = 0
score.joueurDeux = 0

-----------------------------------------------

function CenterBalle()
    balle.x = love.graphics.getWidth()/ 2 - balle.largeur
    balle.y = love.graphics.getHeight()/2 - balle.hauteur

    balle.vitesse_y = -balle.vitesse_y
end

  
function love.load()
end

function love.update(dt)

    -- Condition de gestion des effetes de bords avec la raquette on l'empeche de sortir de l'ecran
    -- pad gauche
    if love.keyboard.isDown("s") and padG.y < love.graphics.getHeight() - padG.hauteur then 
        padG.y = padG.y +3
    end

    if love.keyboard.isDown ("w") and padG.y > 0 then
        padG.y = padG.y - 3
    end

    -- Condition de gestion des effetes de bords avec la raquette on l'empeche de sortir de l'ecran
    -- pad droit
    if love.keyboard.isDown("down") and padD.y < love.graphics.getHeight() - padD.hauteur then
        padD.y = padD.y +3
    end

    if love.keyboard.isDown("up") and padD.y > 0 then
        padD.y = padD.y -3
    end

    -- if love.keyboard.isDown()

    -- On ajoute du mouvement et de la velocité à notre balle
    balle.x = balle.x + balle.vitesse_x
    balle.y = balle.y + balle.vitesse_y


    if balle.y > love.graphics.getHeight() - balle.hauteur then
        -- on inverse la direction de la balle quand elle entre en contact avec le bord bas avec *1 a la fin de l'element ou 0- ou - avant l'element
        balle.vitesse_y = -balle.vitesse_y
    elseif balle.y < 0  then
        balle.vitesse_y = -balle.vitesse_y
    end


    if balle.x > love.graphics.getWidth() - balle.largeur then
        -- on inverse la direction de la balle avec *1 a la fin de l'element ou 0- ou - avant l'element
        balle.vitesse_x = -balle.vitesse_x
    elseif balle.x < 0 then
        balle.vitesse_x = -balle.vitesse_x
    end
    
    -- On verifie si la balle a atteint la raquette gauche
    if balle.x <= padG.x + padG.largeur then
        -- on test si la balle est sur la raquette gauche
        if balle.y + balle.hauteur > padG.y and balle.y < padG.y + padG.hauteur then
            -- on inverse l'inertie de la balle pour simuler un renvoi
            balle.vitesse_x = -balle.vitesse_x
            balle.x = padG.x + padG.largeur
        end
    end
    
        -- On verifie si la balle a atteint la raquette droite
        if balle.x + balle.largeur > padD.x then
            -- on test si la balle est sur la raquette droite
            if balle.y + balle.hauteur > padD.y and balle.y < padD.y + padD.hauteur then
                -- on inverse l'inertie de la balle pour simuler un renvoi
                balle.vitesse_x = -balle.vitesse_x
                print("ok")
            end
        end

    -- if balle.x + balle.largeur > love.graphics

    -- Si la balle sort de l'ecran a gauche
    if balle.x < 0 then
        CenterBalle()
    end
        
    -- Si la balle sort de l'ecran
    if balle.x > love.graphics.getWidth() - balle.largeur then
        CenterBalle()
    end

end


function love.draw()
    -- On affiche la raquette et le padG
    love.graphics.rectangle("fill", padG.x, padG.y, padG.largeur, padG.hauteur)
    love.graphics.rectangle("fill", padD.x, padD.y, padD.largeur, padD.hauteur)

    love.graphics.rectangle("fill", balle.x, balle.y, balle.largeur, balle.hauteur)
    --   on affiche le score
    love.graphics.print("Score :", love.graphics.getWidth()/2, 20, score.joueurUn)
end

-- print(love.graphics.getHeight())
-- print(love.graphics.getWidth())


function love.keypressed(key)
end
  
-----------------------------------------------
