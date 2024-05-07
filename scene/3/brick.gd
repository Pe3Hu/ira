extends Polygon2D


#region var
@onready var index = $Index
@onready var essence = $Essence

var proprietor = null
var grid = null
var neighbors = {}
var directions = {}
var fade = null
var pillar = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	for key in input_:
		set(key, input_[key])
	
	init_basic_setting()


func init_basic_setting() -> void:
	position = grid * Global.num.brick.a
	fade = false
	proprietor.grids[grid] = self
	
	init_tokens()
	set_vertexs()



func init_tokens() -> void:
	var input = {}
	input.proprietor = self
	input.type = "essence"
	input.subtype = "empty"
	essence.set_attributes(input)
	essence.custom_minimum_size = Global.vec.size.essence
	
	input.type = "index"
	input.subtype = "brick"
	input.value = proprietor.grids.keys().size() - 1
	index.set_attributes(input)
	index.custom_minimum_size = Global.vec.size.brick


func set_vertexs() -> void:
	var order = "odd"
	var corners = 4
	var r = Global.num.brick.r
	var vertexs = []
	
	for corner in corners:
		var vertex = Global.dict.corner.vector[corners][order][corner] * r
		vertexs.append(vertex)
	
	set_polygon(vertexs)


func set_fade(fade_: bool) -> void:
	fade = fade_
	
	if fade:
		visible = false


func set_pillar(pillar_: MarginContainer) -> void:
	pillar = pillar_
	
	#recolor_based_on_pillar()


func recolor_based_on_pillar() -> void:
	var h = float(pillar.get_index()) / proprietor.ruin.pillars.get_child_count()
	color = Color.from_hsv(h, 0.75, 1.0)


func get_available_neighbors() -> Array:
	var available = []
	
	for neighbor in neighbors:
		if !neighbor.fade and neighbor.pillar == null:
			available.append(neighbor)
	
	return available


func get_count_available_neighbors() -> int:
	var available = 0
	
	for neighbor in neighbors:
		if !neighbor.fade and neighbor.pillar == null:
			available += 1
	
	return available 


func clean() -> void:
	for neighbor in neighbors:
		neighbor.neighbors.erase(self)
	
	for direction in directions:
		var neighbor = directions[direction]
		neighbor.directions.erase(-direction)
	
	proprietor.grids.erase(grid)
	
	get_parent().remove_child(self)
	queue_free()
#endregion
