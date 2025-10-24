--tutorial

function update_tutorial()
    if tutorial_timer > 0 then
        tutorial_timer -= 1
    else
        status = 0
        tutorial_timer = 180
    end
end

function draw_tutorial()
    cls()
    map(16,0,0,0)
    rectfill(20, 68, 106, 102, 8)
    rectfill(22, 70, 104, 100, 1)
        print("tutorial not\navailable yet !", 37, 78, play_color)
    spr(1, 60, place_ship)
end

--[[
function update_tutorial()
    update_msg()
    if place_ship != 60 then
        place_ship -= 1
    elseif place_ship == 60 then
        create_msg("Bienvenue !", "Vous etes au centre\nde formation des pilotes d'elite !")
    end
end

function create_msg(name, ...)
    message = {...}
end

function update_msg()
    if btnp(❎) then
        deli(message, 0)
    end
end

function draw_msg()
    if message[0] then
        print(message[0], 20, 60, 10)
    end
end

function draw_tutorial()
    cls()
    map(16,0,0,0)
    spr(1, 60, place_ship)
    draw_msg()
end
--]]
