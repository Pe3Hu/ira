extends MarginContainer


#region vars
@onready var charges = $HBox/Charges

var page = null
var values = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	page = input_.page
	values = input_.values
	
	init_basic_setting()


func init_basic_setting() -> void:
	init_charges()


func init_charges() -> void:
	for value in values:
		var input = {}
		input.proprietor = self
		input.type = page.type
		input.subtype = "empty"
		input.value = value
	
		var token = Global.scene.token.instantiate()
		charges.add_child(token)
		token.set_attributes(input)
#endregion
