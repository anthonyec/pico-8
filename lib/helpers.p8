function get_distance(a, b)
	dx = a.x-b.x
	dy = a.y-b.y

	return sqrt(dx*dx+dy*dy)
end

--  Minkowski sum http://gamedev.stackexchange.com/questions/24078/which-side-was-hit
function get_side(a, b)
	local wy = (a.w + b.w) * ((a.y + a.h/2) - (b.y + b.h/2));
	local hx = (a.h + b.h) * ((a.x + a.w/2) - (b.x + b.w/2));

	if wy > hx then
		if wy > -hx then
			-- top
			return 2
		else
			-- left
			return 3
		end
	else
		if wy > -hx then
			-- right
			return 1
		else
			-- bottom
			return 0
		end
	end
end

-- http://gamemath.com/2011/09/detecting-whether-two-boxes-overlap/
function rects_intersect(a, b)
	if ((a.x+a.w) < b.x) return false
    if (a.x > (b.x+b.w)) return false
    if ((a.y+a.h) < b.y) return false
    if (a.y > (b.y+b.h)) return false

    return true
end