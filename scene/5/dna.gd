extends MarginContainer


#region vars
@onready var spirals = $Spirals
@onready var nucleotides = $Nucleotides
@onready var first = $Spirals/First
@onready var second = $Spirals/Second

var god = null
var coils = null
#endregion


#region init
func set_attributes(input_: Dictionary) -> void:
	god = input_.god
	
	init_basic_setting()


func init_basic_setting() -> void:
	custom_minimum_size = Global.vec.size.dna
	size = custom_minimum_size
	coils = 2
	
	init_spirals()
	init_nucleotides()


func init_spirals() -> void:
	spirals.position = Vector2(Global.vec.size.spiral.x + Global.num.width.spiral / 2, Global.num.width.nucleotide / 2)
	
	var angle = -PI / 2
	var descriptions = []
	var description = {}
	description.order = "first"
	description.shifts = {}
	description.shifts.angle = 0 + angle
	descriptions.append(description)
	description = {}
	description.order = "second"
	description.shifts = {}
	description.shifts.angle = PI * 4 / 6 + angle
	descriptions.append(description)
	
	for _description in descriptions:
		_description.dna = self
		var spiral = get(_description.order)
		spiral.set_attributes(_description)


func init_nucleotides() -> void:
	nucleotides.position = Vector2(Global.vec.size.spiral.x + Global.num.width.spiral / 2, Global.num.width.nucleotide / 2)
	
	var datas = []
	var n = 4#Global.num.step.coil / Global.num.step.nucleotide
	var m = Global.num.step.coil * coils + 1
	var l = 0
	
	for _i in n:
		datas.append([])
	
	for _i in m:
		var points = []
		for spiral in spirals.get_children():
			var point = spiral.points[_i]
			points.append(point)
		
		var _l = points.front().distance_to(points.back())
		var _j = _i % n
		datas[_j].append(points)
		
		if _l > l:
			l = _l
	
	var limiter = 0.33
	
	#for _i in datas.size():
		#var k = 0
		#
		#for points in datas[_i]:
			#var _l = points.front().distance_to(points.back())
			#
			#if _l > l * limiter:
				#k += 1
		#
		#print([_i, k])
	
	var optimals = datas[0]
	var input = {}
	input.order = 0
	input.dna = self
	
	for points in optimals:
		var _l = points.front().distance_to(points.back())
		
		if _l > l * limiter:
			input.points = points
			
			var nucleotide = Global.scene.nucleotide.instantiate()
			nucleotides.add_child(nucleotide)
			nucleotide.set_attributes(input)
			input.order += 1
#endregion
