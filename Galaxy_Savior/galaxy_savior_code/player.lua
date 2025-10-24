--player

function update_player()
    shield_press = 0
    shield_on = 0
    ship_sprite = 0
    --controls
    newx = player.x
    newy = player.y
    if (btn(➡️)) then 
        newx += player.speed
        ship_sprite = 1
    end
    if (btn(⬅️)) then 
        newx -= player.speed
        ship_sprite = 2
    end
    if (btn(⬇️)) newy += player.speed
    if (btn(⬆️)) newy -= player.speed
    if btn(❎) then
        shoot()
    end
    if btn(🅾️) then 
        shield_press = 1
    end

    player.x = mid(3,newx,117)
    player.y = mid(10,newy,104)
    -- life
    if can_loose_life == 1 then
        timer_life -= 1
        if timer_life == 0 then
            can_loose_life = 0
            timer_life = 120
        end
    end
end

function shoot()
    if can_shoot == 0 then
        if cd_shoot == 0 then
            new_bullet = {
                x = player.x,
                y = player.y,
                speed = 3
            }
            add(bullets, new_bullet)
            if amo_on == 1 then
                sfx(22)
            else
                sfx(16)
            end
            cd_shoot = 5
            if (amo_on == 0) heat_shoot += 0.5
            heat_wait = 30
        end
    end
end

function update_shield()
    if shield_press == 1 then
        if (heat_shield > 88) then 
            shield_on = 1
        end
    end
    if (shield_on == 1) then
        if (heat_shield > 88) heat_shield -= 0.8
    end
    if heat_shield < 120 then
        if shield_press == 0 then
            heat_shield += 0.5
        end
    end
    if (shield_on == 0) shield_anim = 0
    if shield_press == 1 and shield_sound == 0 then
        sfx(17)
        shield_sound = 1
    elseif shield_press == 0 then
        shield_sound = 0
    end
end

function update_bullets()
    for b in all(bullets) do
        b.y -= b.speed
    end
end