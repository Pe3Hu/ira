extends "res://scene/7/gem.gd"

#region init
func init_basic_setting() -> void:
	super.init_basic_setting()
	init_tokens()


func init_tokens() -> void:
	var input = {}
	input.proprietor = self
	
	for _i in description.capacity:
		input.type = "stone"
		input.subtype = "charge"
		input.value = description.charge
		
		var token = Global.scene.token.instantiate()
		sockets.add_child(token)
		token.set_attributes(input)


func advance_area() -> void:
	super.advance_area()
	var nominals = proprietor.backpack.sequence.nominals
	
	for socket in sockets.get_children():
		var nominal = socket.get_value()
		
		match area:
			"available":
				nominals[nominal].available.change_value(1)
				
				if nominals[nominal].discharged.get_value() > 0:
					nominals[nominal].discharged.change_value(-1)
			"hand":
				if nominals[nominal].available.get_value() > 0:
					nominals[nominal].available.change_value(-1)
			"discharged":
				nominals[nominal].discharged.change_value(1)
#endregion
