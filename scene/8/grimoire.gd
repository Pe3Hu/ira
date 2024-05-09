extends MarginContainer


#region vars
@onready var spells = $VBox/Pages/Spells
@onready var mantras = $VBox/Pages/Mantras
@onready var threats = $VBox/Threats

var god = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	god = input_.god
	
	init_basic_setting()


func init_basic_setting() -> void:
	init_pages()


func init_pages() -> void:
	var input = {}
	input.grimoire = self
	
	for type in Global.arr.page:
		input.type = type
		var page = get(type+"s")
		page.set_attributes(input)
#endregion


func spread_topazes() -> void:
	var _threats = get_threats()
	
	if _threats.is_empty():
		pass


func get_threats() -> Array:
	return god.opponents.front().grimoire.threats.get_children()
