extends Line2D


#region vars
@onready var left = $Nucleobases/Left
@onready var right = $Nucleobases/Right

var dna = null
var order = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	dna = input_.dna
	order = input_.order
	
	init_basic_setting(input_)


func init_basic_setting(input_: Dictionary) -> void:
	width = Global.num.width.nucleotide
	points = input_.points
	init_nucleobases()


func init_nucleobases() -> void:
	var limit = 1.0 / 3
	Global.rng.randomize()
	var coefficient = Global.rng.randf_range(limit, 1 - limit)
	var middle = (points[0] - points[1]) * coefficient + points[1]
	
	var datas = [[points[0], middle], [points[1], middle]]
	
	for data in datas:
		var input = {}
		input.nucleotide = self
		input.points = []
		input.points.append_array(data)
		input.points.sort_custom(func(a, b): return a.x < b.x)
		input.side = "left"
		
		if input.points[0] == middle:
			input.side = "right"
		
		var nucleobase = get(input.side)
		nucleobase.set_attributes(input)
#endregion
