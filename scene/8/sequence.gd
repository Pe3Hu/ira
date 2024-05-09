extends MarginContainer


#region var
@onready var charges = $Charges

var god = null
var nominals = {}
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	god = input_.god
	
	init_basic_setting()


func init_basic_setting() -> void:
	init_chargess()


func init_chargess() -> void:
	var rank = god.foundation.rank
	
	for nominal in Global.dict.foundation.rank[rank]:
		var input = {}
		input.sequence = self
		input.nominal = nominal
		input.count = Global.dict.foundation.rank[rank][nominal]

		var charge = Global.scene.charge.instantiate()
		charges.add_child(charge)
		charge.set_attributes(input)
		nominals[nominal] = charge
	
	#for gem in god.backpack.gems.topaz.available.gems.get_children():
		#for socket in gem.sockets.get_children():
			#var value = socket.get_value()
			#
			#if !statistic.available.has(value):
				#for key in keys:
					#var input = {}
					#input.proprietor = self
					#input.type = "statistic"
					#input.subtype = key
					#input.value = 0
					#
					#var node = get(key)
					#var token = Global.scene.token.instantiate()
					#node.add_child(token)
					#token.set_attributes(input)
					#statistic[key][value] = token
			#
			#statistic.available[value].change_value(1)
#endregion

