extends MarginContainer


#region vars
@onready var paragraphs = $Paragraphs

var grimoire = null
var type = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	grimoire = input_.grimoire
	type = input_.type
	
	init_basic_setting()


func init_basic_setting() -> void:
	init_paragraphs()


func init_paragraphs() -> void:
	for _i in range(1, 7, 1):
		var input = {}
		input.page = self
		input.values = [_i, _i]
	
		var paragraph = Global.scene.paragraph.instantiate()
		paragraphs.add_child(paragraph)
		paragraph.set_attributes(input)
#endregion
