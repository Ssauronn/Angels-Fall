///@argument0 x
///@argument1 y
///@argument2 radius
///@argument3 thickness
///@argument4 maxSegments
///@argument5 segments
///@argument6 startAngle
///@argument7 totalAngle
///@argument8 direction
///@argument9 color

//draw_ring_healthbar(x, y, radius, thickness, maxSegments, segments, startAngle, totalAngle, direction, color);

var i, ax, ay, bx, by, cx, cy, dx, dy;

var angle_change_ = (argument7/argument4)*(pi/180)
i = argument6*(pi/180)

ax = argument0+(cos(i)*argument2)
ay = argument1-(sin(i)*argument2)

bx = argument0+(cos(i)*(argument2+argument3))
by = argument1-(sin(i)*(argument2+argument3))

repeat(argument5) {
	i += argument8 * angle_change_;

	cx = argument0+(cos(i)*argument2)
	cy = argument1-(sin(i)*argument2)

	dx = argument0+(cos(i)*(argument2+argument3))
	dy = argument1-(sin(i)*(argument2+argument3))

	draw_triangle_colour(ax,ay,bx,by,dx,dy,argument9,argument9,argument9,0)
	draw_triangle_colour(ax,ay,cx,cy,dx,dy,argument9,argument9,argument9,0)

	ax = cx
	ay = cy

	bx = dx
	by = dy
}