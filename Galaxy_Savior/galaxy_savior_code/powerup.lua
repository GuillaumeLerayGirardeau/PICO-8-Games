--powerup

function drop_powerup(position)
    if flr(rnd(10)) == 1 then
        new_powerup = {
            x = position.x,
            y = position.y,
            rand_power = rnd({34, 35})
        }
        add(powerups_list, new_powerup)
    end  
end

function update_powerup()
    for p in all(powerups_list) do
        p.y += 0.5
        if collision(p, player) then
            if (p.rand_power == 34) then
                laser_on = 1
                power_laser()
                sfx(20,0,3)
            elseif (p.rand_power == 35) then
                amo_on = 1
                heat_shoot = 7
                power_amo()
                sfx(21)
            end
            del(powerups_list, p) 
        elseif p.y > 120 then
            del(powerups_list, p)
        end
    end
end

function power_laser()
    if timer_laser > 0 and laser_on == 1 then
        timer_laser -= 1
    else
        laser_on = 0
        timer_laser = 180
        laser_anim = 30
    end
end

function power_amo()
    if timer_amo > 0 and amo_on == 1 then
        timer_amo -= 1
    else
        amo_on = 0
        timer_amo = 600
        amo_anim = 20
    end
end
