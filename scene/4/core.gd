extends MarginContainer


#region vars
@onready var summary = $HBox/Summary
@onready var scoreboard = $HBox/Scoreboard

var god = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	god = input_.god
	
	init_basic_setting()


func init_basic_setting() -> void:
	var input = {}
	input.core = self
	summary.set_attributes(input)
	scoreboard.set_attributes(input)


