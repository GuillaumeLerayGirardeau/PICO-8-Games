--stars

function create_stars()
    stars = {}
    --Foreground Stars
    for i=1,15 do 
        fg_star = {
            x = rnd(128),
            y = rnd(128),
            speed = 1 + rnd(2),
            col = rnd({7,10})
        }
        add(stars, fg_star)
    end
    --Background Stars
    for i=1,8 do
        bg_star = {
            x = rnd(128),
            y = rnd(128),
            speed = 0.5 + rnd(1),
            col = rnd({1,5})
        }
        add(stars, bg_star)
    end
end

function update_stars()
    for s in all(stars) do
        s.y += s.speed
        if (s.y > 128) then
            s.y = 0
            s.x = rnd(128)
        end
    end
end
