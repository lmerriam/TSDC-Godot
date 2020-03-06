extends Line2D

func init(start = Vector2(0,0), end = Vector2(0,0)):
	position_line(start,end)

func position_line(start, end):
	set_point_position(0,start)
	set_point_position(1,end)
