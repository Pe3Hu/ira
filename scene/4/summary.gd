extends MarginContainer


#region vars
@onready var aspects = $Aspects

var core = null
var predispositions = {}
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	core = input_.core
	
	init_basic_setting()


func init_basic_setting() -> void:
	init_aspects()
	init_predispositions()
	spread_aspects()


func init_aspects() -> void:
	for subtype in Global.arr.aspect:
		var input = {}
		input.proprietor = self
		input.type = "aspect"
		input.subtype = subtype
		input.value = Global.num.aspect.min
	
		var aspect = Global.scene.token.instantiate()
		aspects.add_child(aspect)
		aspect.set_attributes(input)


func init_predispositions() -> void:
	var data = Global.dict.predisposition.keys().pick_random()
	
	for key in data:
		var options = []
		options.append_array(Global.arr[key])
		
		while options.size() > data[key]:
			var aspect = options.pick_random()
			options.erase(aspect)
		
		for aspect in options:
			predispositions[aspect] = 1


func spread_aspects() -> void:
	var total = int(Global.num.aspect.total)
	var weights = {}
	
	for subtype in predispositions:
		weights[subtype] = Global.num.aspect.max - Global.num.aspect.min
	
	while total > 0:
		var subtype = Global.get_random_key(weights)
		var aspect = get_aspect(subtype)
		var value = Global.num.aspect.max - aspect.get_value()
		value = Global.rng.randi_range(1, value)
		value = min(value, total)
		weights[subtype] -= value
		aspect.change_value(value)
		total -= value
		
		if weights[subtype] <= 0:
			weights.erase(subtype)
	


func get_aspect(aspect_: String) -> MarginContainer:
	var index = Global.arr.aspect.find(aspect_)
	return aspects.get_child(index)
#endregion
