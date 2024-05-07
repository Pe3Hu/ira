extends MarginContainer


#region var
@onready var marbles = $Marbles

var ruin = null
var shift = null
var grids = {}
var corners = {}
var intersections = []
var bricks = []
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	ruin = input_.ruin
	
	init_basic_setting(input_)


func init_basic_setting(input_: Dictionary) -> void:
	corners.min = Vector2()
	corners.max = Vector2()
	shift = input_.brick.grid
	
	add_marble(input_.brick)


func add_marble(brick_: Polygon2D) -> void:
	var input = {}
	input.proprietor = self
	input.grid = brick_.grid - shift
	input.brick = brick_

	var marble = Global.scene.marble.instantiate()
	marbles.add_child(marble)
	marble.set_attributes(input)


func update_corners(vector_: Vector2) -> void:
	if corners.min.y > vector_.y:
		corners.min.y = vector_.y
	if corners.min.x > vector_.x:
		corners.min.x = vector_.x
	if corners.max.y < vector_.y:
		corners.max.y = vector_.y
	if corners.max.x < vector_.x:
		corners.max.x = vector_.x


func update_size() -> void:
	corners.min.x -= Global.num.brick.a / 2
	corners.min.y -= Global.num.brick.a / 2
	corners.max.x += Global.num.brick.a / 2
	corners.max.y += Global.num.brick.a / 2
	
	custom_minimum_size = corners.max - corners.min
	marbles.position = -corners.min# + Global.vec.size.brick / 2
#endregion
