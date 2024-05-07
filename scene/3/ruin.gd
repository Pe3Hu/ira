extends MarginContainer


#region var
@onready var pillars = $Pillars

var god = null
var foundation = null
var parts = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	god = input_.god
	
	init_basic_setting()


func init_basic_setting() -> void:
	foundation = god.foundation
	parts = foundation.rank - 1
	
	init_pillars()
	fill_pillars()
	
	for pillar in pillars.get_children():
		for brick in pillar.bricks:
			brick.recolor_based_on_pillar()
		
		print([pillar.get_index(), pillar.bricks.size()])


func init_pillars() -> void:
	var datas = {}
	
	for brick in foundation.bricks.get_children():
		if !brick.fade:
			datas[brick] = brick.get_count_available_neighbors()
			
	
	var _brick = datas.keys().pick_random()
	_brick.set_fade(true)
	datas.erase(_brick)
	
	for neighbor in _brick.neighbors:
		datas[neighbor] -= 1
		
		if datas[neighbor] == 0:
			datas.erase(neighbor)
	
	for _i in parts:
		add_pillar(datas)


func add_pillar(datas_: Dictionary) -> void:
	var maximum = 0
	
	for brick in datas_:
		if maximum < datas_[brick]:
			maximum = datas_[brick]
	
	var options = []
	
	for brick in datas_:
		if datas_[brick] == maximum:
			options.append(brick)
	
	var input = {}
	input.ruin = self
	input.brick = options.pick_random()

	var pillar = Global.scene.pillar.instantiate()
	pillars.add_child(pillar)
	pillar.set_attributes(input)
	
	datas_.erase(input.brick)
	
	for neighbor in input.brick.neighbors:
		if datas_.has(neighbor):
			datas_[neighbor] -= 1
			
			if datas_[neighbor] == 0:
				datas_.erase(neighbor)


func fill_pillars() -> void:
	var options = []
	
	for brick in foundation.bricks.get_children():
		if !brick.fade and brick.pillar == null:
			options.append(brick)
	
	while !options.is_empty():
		var _pillars = []
		_pillars.append_array(pillars.get_children())
		_pillars.sort_custom(func(a, b): return a.intersections.size() < b.intersections.size())
		
		for pillar in _pillars:
			if !pillar.intersections.is_empty():
				var datas = {}
				
				for _brick in pillar.intersections:
					datas[_brick] = _brick.get_count_available_neighbors()
				
				var maximum = 0
				
				for brick in datas:
					if maximum < datas[brick]:
						maximum = datas[brick]
				
				var _options = []
				
				for _brick in datas:
					if datas[_brick] == maximum:
						_options.append(_brick)
				
				var brick = _options.pick_random()
				pillar.add_marble(brick)
				options.erase(brick)
	
	for pillar in pillars.get_children():
		pillar.update_size()
#endregion
