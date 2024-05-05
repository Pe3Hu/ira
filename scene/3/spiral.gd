extends Line2D


#region vars
var dna = null
var shifts = null
var order = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	dna = input_.dna
	shifts = input_.shifts
	order = input_.order
	
	init_basic_setting()


func init_basic_setting() -> void:
	width = Global.num.width.spiral
	init_points()


func init_points() -> void:
	var n = dna.coils
	var m = Global.num.step.coil
	var angle = PI * 2 / m
	var steps = Global.vec.size.spiral#Vector2(10, 30)
	var vertexs = []
	
	for _i in n:
		for _j in m:
			var x = sin(angle * _j + shifts.angle)
			var y = _i * m + _j
			var vertex = Vector2(x, y) * steps
			vertexs.append(vertex)
	
	var _vertex = Vector2(sin(shifts.angle), m * n) * steps
	vertexs.append(_vertex)
	points = vertexs
	default_color = Global.color.spiral[order]
#endregion
