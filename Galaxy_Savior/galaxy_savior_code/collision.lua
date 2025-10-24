--collision

function collision(a, b)
  if a.x > b.x + 8
  or a.y > b.y + 8
  or a.x + 8 < b.x
  or a.y + 8 < b.y then
    return false
  else
    return true
  end
end

--collision laser
function collision_laser(a)
  if a.x > player.x + 5
  or a.y > player.y
  or a.x + 8 < player.x + 2 then
    return false
  else
    return true
  end
end