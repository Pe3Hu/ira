extends MarginContainer


#region vars
@onready var gems = $Gems

var bag = null
var type = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	bag = input_.bag
	type = input_.type


func reshuffle_all_gems() -> void:
	var _gems = []
	
	while gems.get_child_count() > 0:
		var gem = gems.get_child(0)
		gems.remove_child(gem)
		_gems.append(gem)
	
	_gems.shuffle()
	
	for gem in _gems:
		gems.add_child(gem)


func advance_random_gem() -> void:
	refill_check()
	var gem = gems.get_children().pick_random()
	gem.advance_area()


func advance_all_gems() -> void:
	while gems.get_child_count() > 0:
		advance_random_gem()


func refill_check() -> void:
	if gems.get_child_count() == 0:
		var donor = Global.dict.area.prior[type]
		var gemstack = bag.get(donor)
		gemstack.advance_all_gems()
#endregion
