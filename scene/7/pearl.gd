extends "res://scene/7/gem.gd"

#region init
func init_basic_setting() -> void:
	super.init_basic_setting()
	init_tokens()


func init_tokens() -> void:
	var input = {}
	input.proprietor = self
	
	for _i in description.capacity:
		input.type = "essence"
		input.subtype = description.essence
		
		var token = Global.scene.token.instantiate()
		sockets.add_child(token)
		token.set_attributes(input)
#endregion
