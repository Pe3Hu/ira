extends MarginContainer


#region var
@onready var bricks = $Bricks

var god = null
var ruin = null
var rank = null
var grids = {}
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	god = input_.god
	
	init_basic_setting()


func init_basic_setting() -> void:
	rank = 1
	ruin = god.ruin
	
	init_bricks()


func init_bricks() -> void:
	custom_minimum_size = (rank + 2) * Global.vec.size.brick
	bricks.position = Global.vec.size.brick / 2
	
	for _i in rank + 2:
		for _j in rank + 2:
			var grid = Vector2(_j, _i)
			add_brick(grid)
	
	update_brick_neighbors()
	spread_charges()


func add_brick(grid_: Vector2) -> void:
	var input = {}
	input.proprietor = self
	input.grid = grid_

	var brick = Global.scene.brick.instantiate()
	bricks.add_child(brick)
	brick.set_attributes(input)


func update_brick_neighbors() -> void:
	for brick in bricks.get_children():
		for direction in Global.dict.neighbor.linear2:
			var grid = direction + brick.grid
			
			if grids.has(grid):
				var neighbor = grids[grid]
				
				if !brick.neighbors.has(neighbor):
					brick.neighbors[neighbor] = direction
					neighbor.neighbors[brick] = -direction
					brick.directions[direction] = neighbor
					neighbor.directions[-direction] = brick


func spread_charges() -> void:
	var options = []
	
	for charge in Global.dict.foundation.rank[rank]:
		for _i in Global.dict.foundation.rank[rank][charge]:
			options.append(charge)
	
	options.shuffle()
	
	for _i in bricks.get_child_count():
		var brick = bricks.get_child(_i)
		var value = options.pop_front()
		brick.charge.set_subtype(str(value))


func reset() -> void:
	pass
#endregion

