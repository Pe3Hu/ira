extends MarginContainer


#region vars
@onready var aspects = $Aspects

var core = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	core = input_.core
	
	init_basic_setting()


func init_basic_setting() -> void:
	init_aspects()


func init_aspects() -> void:
	for donor in core.summary.aspects.get_children():
		var input = {}
		input.scoreboard = self
		input.aspect = donor
	
		var aspect = Global.scene.aspect.instantiate()
		aspects.add_child(aspect)
		aspect.set_attributes(input)
#endregion
