extends MarginContainer


#region vars
@onready var bg = $BG
@onready var hbox = $HBox
@onready var sockets = $HBox/Sockets

var proprietor = null
var area = null
var description = null
var selected = false
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	proprietor = input_.proprietor
	description = input_.description
	area = input_.area
	
	init_basic_setting()


func init_basic_setting() -> void:
	custom_minimum_size = Global.vec.size.gem
	init_bg()


func init_bg() -> void:
	var style = StyleBoxFlat.new()
	style.bg_color = Color.SLATE_GRAY
	bg.set("theme_override_styles/panel", style)
	set_selected(false)


func advance_area() -> void:
	var pocket = null
	
	if area == null:
		area = Global.dict.area.next[area]
		advance_area()
	else:
		pocket = proprietor.get(area)
		pocket.gems.remove_child(self)
	
		area = Global.dict.area.next[area]
		pocket = proprietor.get(area)
		pocket.gems.add_child(self)


func set_bag_as_proprietor(bag_: MarginContainer) -> void:
	var pocket = proprietor.get(area)
	var market = false
	
	if pocket == null:
		pocket = proprietor
		market = true
	
	pocket.gems.remove_child(self)
	proprietor = bag_
	area = "discharged"
	
	pocket = proprietor.get(area)
	pocket.gems.add_child(self)
	
	custom_minimum_size = Global.vec.size.gem
	size = Global.vec.size.gem
	set_selected(false)
	
	if !market:
		advance_area()


func set_selected(selected_: bool) -> void:
	selected = selected_
	var style = bg.get("theme_override_styles/panel")
	style.bg_color = Global.color.gem.selected[selected_]
#endregion
