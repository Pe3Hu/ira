extends MarginContainer


#region vars
@onready var available = $Gems/Available
@onready var discharged = $Gems/Discharged
@onready var broken = $Gems/Broken
@onready var hand = $Gems/Hand

var backpack = null
var type = null
var capacity = {}
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	backpack = input_.backpack
	type = input_.type
	
	init_basic_setting(input_)


func init_basic_setting(input_: Dictionary) -> void:
	custom_minimum_size = Global.vec.size.bag
	capacity.current = 3
	capacity.limit = 10
	input_.bag = self
	
	for key in Global.dict.area.next:
		if key != null:
			input_.type = key
			var pocket = get(key)
			pocket.set_attributes(input_)
	
	init_starter_kit_gems()


func init_starter_kit_gems() -> void:
	if type != "topaz":
		for description in Global.dict.gem[type]:
			for _i in Global.dict.gem[type]:
				add_gem(description)
	else:
		var rank = backpack.god.foundation.rank
		
		for charge in Global.dict.foundation.rank[rank]:
			for _i in Global.dict.foundation.rank[rank][charge]:
				var description = {}
				description.charge = charge
				description.capacity = 1
				add_gem(description)


func add_gem(description_: Dictionary) -> void:
	var input = {}
	input.proprietor = self
	input.description = description_
	input.area = "discharged"

	var gem = Global.scene[type].instantiate()
	discharged.gems.add_child(gem)
	gem.set_attributes(input)
	gem.set_bag_as_proprietor(self)


#endregion



func refill_hand() -> void:
	var gemstack = get(Global.dict.area.prior[hand.type])
	
	while hand.gems.get_child_count() < capacity.current:
		gemstack.advance_random_gem()


func disgem_hand() -> void:
	hand.advance_all_gems()
