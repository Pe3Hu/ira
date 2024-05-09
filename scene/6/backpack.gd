extends MarginContainer


#region vars
@onready var bags = $Bags

var gems = {}
var god = null
var sequence = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	god = input_.god
	
	init_basic_setting()


func init_basic_setting() -> void:
	sequence = god.sequence
	init_bags()


func init_bags() -> void:
	var input = {}
	input.backpack = self
	
	for type in Global.arr.gem:
		input.type = type
		
		var bag = Global.scene.bag.instantiate()
		bags.add_child(bag)
		bag.set_attributes(input)
		gems[type] = bag
#endregion
