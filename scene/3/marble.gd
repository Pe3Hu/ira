extends "res://scene/3/brick.gd"


var brick = null


#region init
func init_basic_setting() -> void:
	super.init_basic_setting()
	
	brick.set_pillar(proprietor)
	proprietor.bricks.append(brick)
	
	if proprietor.intersections.has(brick):
		proprietor.intersections.erase(brick)
	
	proprietor.update_corners(position)
	update_intersections()


func update_intersections() -> void:
	for neighbor in brick.neighbors:
		if !neighbor.fade and neighbor.pillar == null and !proprietor.bricks.has(neighbor) and !proprietor.intersections.has(neighbor):
			proprietor.intersections.append(neighbor)
	
	for _pillar in proprietor.ruin.pillars.get_children():
		if _pillar != proprietor and _pillar.intersections.has(brick):
			_pillar.intersections.erase(brick)
#endregion
