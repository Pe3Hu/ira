extends MarginContainer


#region var
@onready var nominal = $HBox/Nominal
@onready var available = $HBox/Available
@onready var discharged = $HBox/Discharged

var sequence = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	sequence = input_.sequence
	
	init_basic_setting(input_)


func init_basic_setting(input_: Dictionary) -> void:
	init_tokens(input_)



func init_tokens(input_: Dictionary) -> void:
	var input = {}
	input.proprietor = self
	input.type = "charge"
	input.subtype = input_.nominal
	nominal.set_attributes(input)
	nominal.custom_minimum_size = Global.vec.size.charge
	
	input.subtype = "available"
	input.value = 0
	available.set_attributes(input)
	available.custom_minimum_size = Global.vec.size.charge
	
	input.subtype = "discharged"
	input.value = input_.count
	discharged.set_attributes(input)
	discharged.custom_minimum_size = Global.vec.size.charge
