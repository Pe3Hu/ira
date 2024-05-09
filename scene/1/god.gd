extends MarginContainer


#region varsvar
@onready var dna = $HBox/DNA
@onready var core = $HBox/Core
@onready var foundation = $HBox/Foundation
@onready var ruin = $HBox/Ruin
@onready var backpack = $HBox/Backpack
@onready var sequence = $HBox/Sequence
@onready var grimoire = $HBox/Grimoire

var pantheon = null
var planet = null
var opponents = []
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	pantheon = input_.pantheon
	
	init_basic_setting()


func init_basic_setting() -> void:
	var input = {}
	input.god = self
	#dna.set_attributes(input)
	#core.set_attributes(input)
	foundation.set_attributes(input)
	#ruin.set_attributes(input)
	#grimoire.set_attributes(input)
	#sequence.set_attributes(input)
	#backpack.set_attributes(input)
#endregion


func pick_opponent() -> MarginContainer:
	var opponent = opponents.pick_random()
	return opponent


func concede_defeat() -> void:
	planet.loser = self
