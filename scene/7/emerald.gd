extends "res://scene/7/gem.gd"


@onready var power = $HBox/Power


func init_basic_setting() -> void:
	super.init_basic_setting()
	init_tokens()


func init_tokens() -> void:
	var input = {}
	input.proprietor = self
	input.type = "stone"
	input.subtype = "power"
	input.value = description.power
	power.set_attributes(input)
