extends Line2D


#region vars
var nucleotide = null
var side = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	nucleotide = input_.nucleotide
	side = input_.side
	
	init_basic_setting(input_)


func init_basic_setting(input_: Dictionary) -> void:
	width = Global.num.width.nucleotide
	points = input_.points
	default_color = Global.color.nucleobase[side]
#endregion
