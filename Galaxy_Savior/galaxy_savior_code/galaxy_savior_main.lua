--main code

function _init()
    game_start_condition()
    status = 0
end

function game_start_condition()
    cls(0)
    player={x = 60, y = 80, speed = 2, life = 3}
    total_life = player.life
    can_loose_life = 0
    bullets = {}
    powerups_list = {}
    explosion = {}
    ship_sprite = 0
    cd_shoot = 5
    heat_wait = 0
    heat_shoot = 7
    timer_shoot, timer_life = 120, 120
    timer_laser, timer_amo = 180, 600
    laser_anim, amo_anim = 30, 20
    can_shoot, shield_anim, shield_on = 0, 0, 0
    laser_on, amo_on = 0, 0
    heat_shield = 120
    shield_press = 0
    meteors = {}
    menu_select_y = 76
    play_color = 9
    tuto_color = 9
    score = 0
    tutorial_timer = 180
    --place_ship = 130
    --message={}
    create_stars()
end

--update

function _update60()
    if (status == 0) update_title_screen()
    if (status == 1) update_game()
    if (status == 2) update_game_over()
    if (status == 3) update_tutorial()
end

function update_title_screen()
    update_stars()
    if (btnp(⬇️) and menu_select_y < 86) menu_select_y += 10
    if (btnp(⬆️) and menu_select_y > 76) menu_select_y -= 10
    if (btnp(❎) and menu_select_y == 76) then
        status = 1
        music(0, 0, 11)
    end
    if (btnp(❎) and menu_select_y == 86) status = 3
    if menu_select_y == 76 then
        play_color = 10
    else
        play_color = 9
    end
    if menu_select_y == 86 then
        tuto_color = 10
    else
        tuto_color = 9
    end
end

function update_game()
    update_stars()
    update_player()
    update_bullets()
    countdown_shoot()
    update_shield()
    update_powerup()
    power_laser()
    power_amo()
    if (#meteors == 0) create_meteors(ceil(rnd(6)))
    update_meteors()
end

function update_game_over()
    update_stars()
    if (btnp(❎)) then
        game_start_condition()
        status = 0
    end
end

--draw

function _draw()
    if (status == 0) draw_title_screen()
    if (status == 1) draw_game()
    if (status == 2) draw_game_over()
    if (status == 3) draw_tutorial()
end

function print_outline(text, x, y)
    print(text, x+1, y, 0)
    print(text, x-1, y, 0)
    print(text, x, y-1, 0)
    print(text, x, y+1, 0)
    print(text, x, y, 10)
end

function draw_title_screen()
    cls(0)
    for s in all(stars) do
        pset(s.x, s.y, s.col)
    end
    map(32, 2, 0, 0)
    rectfill(20, 68, 106, 102, 8)
    rectfill(22, 70, 104, 100, 1)
    print("play", 55, 78, play_color)
    print("tuto", 55, 88, tuto_color)
    spr(36, 38, menu_select_y)
    print("press x to select", 31, 115, 7)

end

function draw_game_over()
    cls(0)
    for s in all(stars) do
        pset(s.x, s.y, s.col)
    end
    map(48, 2, 0, 0)
    rectfill(20, 68, 106, 98, 8)
    rectfill(22, 70, 104, 96, 1)
    print("your score : "..score, 28, 80, 9)
    print("press x to go back to menu", 14, 115, 7)
end

function draw_game()
    cls(0)
    --stars
    for s in all(stars) do
        pset(s.x, s.y, s.col)
    end
    --bullets
    for b in all(bullets) do
        if amo_on == 1 then
            spr(19, b.x, b.y)
        else 
        spr(2, b.x, b.y)
        end
    end
    --powerup
    for p in all(powerups_list) do
        spr(p.rand_power, p.x, p.y)
    end
    -------laser
    if laser_on == 1 then
        if laser_anim > 0 then
            circfill(player.x + 3, player.y, laser_anim / 2.5, 12)
            circ(player.x + 3, player.y, laser_anim / 2.5, 7)
            laser_anim -= 1
        else
        rectfill(player.x + 2, player.y+2, player.x + 5, 0, 12)
        rect(player.x + 2, player.y+2, player.x + 5, 0, 7)
        spr(18, player.x, player.y)
        end
    end
    -------amo
    if amo_on == 1 then 
        if amo_anim > 0 then
            circfill(player.x + 3, player.y + 3, amo_anim, 9)
            circ(player.x + 3, player.y + 3, amo_anim, 10)
            amo_anim -= 1
        end
    end
    --shield
    if (shield_on == 1) then
        if (shield_anim > 8) then
            spr(16, player.x - 4, player.y - 4, 2, 2)
        else
            circfill(player.x + 4, player.y + 4, shield_anim, 12)
            shield_anim += 3
        end
    end
    --player spaceship
    if can_loose_life == 1 then
        if (timer_life % 5 == 0) then
            spr(0, player.x, player.y)
        else
            if (ship_sprite == 0) spr(7, player.x, player.y)
            if (ship_sprite == 1) spr(8, player.x, player.y, 1, 1, true)
            if (ship_sprite == 2) spr(8, player.x, player.y)
        end
    elseif amo_on == 1 then
        if (ship_sprite == 0) spr(9, player.x, player.y)
        if (ship_sprite == 1) spr(10, player.x, player.y, 1, 1, true)
        if (ship_sprite == 2) spr(10, player.x, player.y)
    else
        if (ship_sprite == 0) spr(1, player.x, player.y)
        if (ship_sprite == 1) spr(5, player.x, player.y, 1, 1, true)
        if (ship_sprite == 2) spr(5, player.x, player.y)
    end
    --meteors
    for i in all(meteors) do
        spr(6, i.x, i.y)
    end
    for e in all(explosion) do
        if e.timer < 6 then
            circ(e.x, e.y, e.timer + 1, 8)
            circ(e.x, e.y, e.timer, 10)
            e.timer += 1
        end 
    end
    --ui
    map(0,0,0,0)
    --shoot_bar
    rectfill(7, 119, 39, 123, 6)
    rectfill(7, 119, heat_shoot, 123, 9)
    if (amo_on == 1) rectfill(7, 119, 38, 123, 10)
    rect(7, 119, 39, 123, 8)
    --shield_bar
    rectfill(87, 119, 120, 123, 6)
    rectfill(87, 119, heat_shield, 123, 12)
    rect(87, 119, 120, 123, 1)
    --score
    rectfill(50, 1, 77, 8, 1)
    if (score > 30000) score = 30000
    if (score < 30000) print(score, 54.5, 2, 7)
    if (score == 30000) print(score, 54.5, 2, 10)
    --player life
    for i = 1,total_life do 
        if (total_life - player.life >= i) then
            spr(3, 78 - i*9, 116)
        else
            spr(4, 78 - i*9, 116)
        end
    end
end
