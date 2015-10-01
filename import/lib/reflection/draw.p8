-- char
spr(21, 10, 25)
-- hat
spr(5, 9, 18)
-- flash
spr(22, 18, 25)
-- jumpy char
spr(21, 40 + sin(t) * 5, 25 + cos(t) * 10)

t += 0.05

if t > 1 then
	t = 0
end

rectfill(newx, newy + 1, newx+width, newy+height, 1)

for r=1, width do
	for c=1, height do
		multi = 1.5
		-- multi = 0
		rpercent = width / c
		cpercent = height / c

		sine = sin(rpercent + t) * multi
		cosine = cos(cpercent + t) * multi

		color = pget(x+r+cosine, y+c)

		local setColor = 13
		local setX = (newx+(r))
		local setY = (newy+(height-c))
		-- pset((newx+r), (newy+c), color)

		-- Black is transparent
		if color != 0 then
			if color == 9 or color == 10 then
				setColor = 13
			end

			pset(setX, setY, color)
		-- divide color by a int to fade out
		-- pset(newx+r, newy+c, color / rot)
		end
	end
end