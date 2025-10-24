--countdowns

function countdown_shoot()

    --cooldown_shoot
    if (cd_shoot > 0) cd_shoot -= 1
    if (heat_wait > 0) heat_wait -= 1

    --over_heat shoot
    if (can_shoot == 0) timer_shoot = 120
    
    if can_shoot == 0 then
        if heat_shoot > 7 then 
            if heat_shoot < 38 then 
                if (heat_wait == 0) heat_shoot -= 0.5
            end
        end
    end

    if (heat_shoot >= 38) can_shoot = 1

    if can_shoot == 1 then
        timer_shoot -= 1
        if timer_shoot <= 30 then
            if (heat_shoot > 7) heat_shoot -= 1
        end
        if (timer_shoot == 1) then
            heat_shoot = 7
            can_shoot = 0
        end
    end
end

function create_explosion(_x,_y)
    add(explosion,{
        x = _x,
        y = _y,
        timer = 0
    })
end