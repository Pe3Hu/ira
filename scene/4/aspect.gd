extends MarginContainer


#region vars
@onready var result = $HBox/Result
@onready var buffs = $HBox/Buffs
@onready var debuffs = $HBox/Debuffs

var scoreboard = null
var aspect = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	scoreboard = input_.scoreboard
	aspect = input_.aspect
	
	init_basic_setting()


func init_basic_setting() -> void:
	var input = {}
	input.proprietor = self
	input.type = "aspect"
	input.subtype = aspect.subtype
	input.value = aspect.get_value()
	
	result.set_attributes(input)
#endregion
