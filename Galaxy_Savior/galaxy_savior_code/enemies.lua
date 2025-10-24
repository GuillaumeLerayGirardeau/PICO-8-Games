--enemies

--meteors
function create_meteors(amount)
    for i = 1,amount do
        new_meteor = {
            x = 5 + rnd(110),
            y = -10 + rnd(8),
            speed = 0.3 + rnd(0.3),
            life = 2
        }
        add(meteors, new_meteor)
    end
end

function update_meteors()
    for i in all(meteors) do
        i.y += i.speed

        if (i.y > 120) then
            del(meteors, i)

        -- collision player
        elseif collision(i, player) and shield_on == 1 then
            del(meteors, i)
            score += 10
        elseif collision(i, player) and can_loose_life == 0 then
            player.life -= 1
            del(meteors, i)
            sfx(23)
            if (player.life == 0) then 
                status = 2
                music(-1)
            end
            can_loose_life = 1
        --collision laser
        elseif laser_on == 1 and laser_anim == 0 and collision_laser(i) then
            i.life -= 10
        end

        --collision bullet
        for b in all(bullets) do
            if collision(i, b) then
                del(bullets, b)
                i.life -= 1
            end
        end

        -- delete meteor
        if i.life <= 0 then
            if (laser_on == 0) drop_powerup(i)
            create_explosion(i.x, i.y)
            del(meteors, i)
            score += 10
        end
    end
end