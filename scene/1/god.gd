extends MarginContainer


#region varsvar
@onready var dna = $HBox/DNA
@onready var core = $HBox/Core
@onready var foundation = $HBox/Foundation
@onready var ruin = $HBox/Ruin

var pantheon = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	pantheon = input_.pantheon
	
	init_basic_setting()


func init_basic_setting() -> void:
	var input = {}
	input.god = self
	#dna.set_attributes(input)
	#core.set_attributes(input)
	foundation.set_attributes(input)
	ruin.set_attributes(input)
#endregion
