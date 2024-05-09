extends "res://scene/7/gem.gd"


@onready var seal = $HBox/Seal


#region init
func init_basic_setting() -> void:
	super.init_basic_setting()
	init_tokens()


func init_tokens() -> void:
	var input = {}
	input.proprietor = self
	input.type = "seal"
	input.subtype = description.seal
	seal.set_attributes(input)
	
	for _i in description.capacity:
		input.type = "essence"
		input.subtype = "empty"
		
		var token = Global.scene.token.instantiate()
		sockets.add_child(token)
		token.set_attributes(input)
#endregion
