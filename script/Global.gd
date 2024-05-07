extends Node


var rng = RandomNumberGenerator.new()
var arr = {}
var num = {}
var vec = {}
var color = {}
var dict = {}
var flag = {}
var scene = {}


func _ready() -> void:
	init_arr()
	init_num()
	init_vec()
	init_color()
	init_dict()
	init_scene()


func init_arr() -> void:
	arr.fuel = ["endurance", "will", "lucky"]
	arr.power = ["dexterity", "intellect", "strength"]
	arr.aspect = ["endurance", "dexterity", "will", "intellect", "lucky", "strength"]
	
	arr.essence = ["lightning", "fire", "ice", "poison", "bone", "blood", "light", "void", "darkness"]
	arr.offense = ["whip", "hammer", "spear"]
	arr.defense = ["parry", "block", "dodge"]
	arr.role = ["offense", "defense"]


func init_num() -> void:
	num.index = {}
	
	num.area = {}
	num.area.n = 9
	num.area.col = num.area.n
	num.area.row = num.area.n
	
	num.step = {}
	num.step.coil = 45
	num.step.nucleotide = 9
	
	num.width = {}
	num.width.nucleotide = 4
	num.width.spiral = 4
	
	num.aspect = {}
	num.aspect.min = 10
	num.aspect.max = 19
	num.aspect.total = 15
	
	num.foundation = {}
	num.foundation.n = 9
	num.foundation.col = num.foundation.n
	num.foundation.row = num.foundation.n
	
	num.brick = {}
	num.brick.a = 32
	num.brick.r = num.brick.a / sqrt(2)
	num.brick.n = 4


func init_dict() -> void:
	init_neighbor()
	init_corner()
	init_font()
	init_predisposition()


func init_neighbor() -> void:
	dict.neighbor = {}
	dict.neighbor.linear3 = [
		Vector3( 0, 0, -1),
		Vector3( 1, 0,  0),
		Vector3( 0, 0,  1),
		Vector3(-1, 0,  0)
	]
	dict.neighbor.linear2 = [
		Vector2( 0,-1),
		Vector2( 1, 0),
		Vector2( 0, 1),
		Vector2(-1, 0)
	]
	dict.neighbor.diagonal = [
		Vector2( 1,-1),
		Vector2( 1, 1),
		Vector2(-1, 1),
		Vector2(-1,-1)
	]
	dict.neighbor.zero = [
		Vector2( 0, 0),
		Vector2( 1, 0),
		Vector2( 1, 1),
		Vector2( 0, 1)
	]
	dict.neighbor.brick = [
		[
			Vector2( 1,-1), 
			Vector2( 1, 0), 
			Vector2( 0, 1), 
			Vector2(-1, 0), 
			Vector2(-1,-1),
			Vector2( 0,-1)
		],
		[
			Vector2( 1, 0),
			Vector2( 1, 1),
			Vector2( 0, 1),
			Vector2(-1, 1),
			Vector2(-1, 0),
			Vector2( 0,-1)
		]
	]
	dict.neighbor.cube = [
		Vector3(0, -1, +1),
		Vector3(+1, -1, 0),
		Vector3(+1, 0, -1),
		Vector3(0, +1, -1), 
		Vector3(-1, +1, 0),
		Vector3(-1, 0, +1),   
	]


func init_corner() -> void:
	dict.order = {}
	dict.order.pair = {}
	dict.order.pair["even"] = "odd"
	dict.order.pair["odd"] = "even"
	var corners = [4]
	dict.corner = {}
	dict.corner.vector = {}
	
	for corners_ in corners:
		dict.corner.vector[corners_] = {}
		dict.corner.vector[corners_].even = {}
		
		for order_ in dict.order.pair.keys():
			dict.corner.vector[corners_][order_] = {}
		
			for _i in corners_:
				var angle = 2*PI*_i/corners_-PI/2
				
				if order_ == "odd":
					angle += PI/corners_
				
				var vertex = Vector2(1,0).rotated(angle)
				dict.corner.vector[corners_][order_][_i] = vertex


func init_font():
	dict.font = {}
	dict.font.size = {}
	dict.font.size["basic"] = 18
	dict.font.size["season"] = 18
	dict.font.size["phase"] = 18
	dict.font.size["moon"] = 18


func init_predisposition() -> void:
	dict.predisposition = {}
	
	var limits = [[0, 2], [1, 1], [2, 0], [1, 2], [2, 1]]
	
	for limit in limits:
		var predisposition = {}
		predisposition.fuel = limit.front()
		predisposition.power = limit.back()
		dict.predisposition[predisposition] = 1


func init_blank() -> void:
	dict.blank = {}
	dict.blank.rank = {}
	var exceptions = ["rank"]
	
	var path = "res://asset/json/maoiri_blank.json"
	var array = load_data(path)
	
	for blank in array:
		blank.rank = int(blank.rank)
		var data = {}
		
		for key in blank:
			if !exceptions.has(key):
				data[key] = blank[key]
			
		if !dict.blank.rank.has(blank.rank):
			dict.blank.rank[blank.rank] = []
	
		dict.blank.rank[blank.rank].append(data)


func init_scene() -> void:
	scene.token = load("res://scene/0/token.tscn")
	
	scene.pantheon = load("res://scene/1/pantheon.tscn")
	scene.god = load("res://scene/1/god.tscn")
	
	scene.planet = load("res://scene/2/planet.tscn")
	scene.area = load("res://scene/2/area.tscn")
	
	scene.brick = load("res://scene/3/brick.tscn")
	scene.pillar = load("res://scene/3/pillar.tscn")
	scene.marble = load("res://scene/3/marble.tscn")
	
	scene.aspect = load("res://scene/4/aspect.tscn")
	
	scene.nucleotide = load("res://scene/5/nucleotide.tscn")


func init_vec():
	vec.size = {}
	vec.size.sixteen = Vector2(16, 16)
	vec.size.area = Vector2(60, 60)
	vec.size.token = Vector2(vec.size.sixteen * 2)
	
	vec.size.spiral = Vector2(40, 3)
	vec.size.dna = Vector2(vec.size.spiral.x * 2, vec.size.spiral.y * 2 * num.step.coil)
	vec.size.dna += Vector2(num.width.spiral, num.width.nucleotide)
	
	vec.size.brick = Vector2.ONE * num.brick.a
	vec.size.essence = vec.size.brick * 0.75
	
	init_window_size()


func init_window_size():
	vec.size.window = {}
	vec.size.window.width = ProjectSettings.get_setting("display/window/size/viewport_width")
	vec.size.window.height = ProjectSettings.get_setting("display/window/size/viewport_height")
	vec.size.window.center = Vector2(vec.size.window.width/2, vec.size.window.height/2)


func init_color():
	var h = 360.0
	
	color.spiral = {}
	color.spiral.first = Color.from_hsv(0 / h, 0.6, 0.7)
	color.spiral.second = Color.from_hsv(210 / h, 0.6, 0.7)
	
	color.nucleobase = {}
	color.nucleobase.left = Color.from_hsv(60 / h, 0.6, 0.7)
	color.nucleobase.right = Color.from_hsv(120 / h, 0.6, 0.7)
	
	color.brick = {}
	color.brick.source = Color.from_hsv(0 / h, 0.9, 0.7)
	color.brick.connector = Color.from_hsv(120 / h, 0.9, 0.7)
	color.brick.wire = Color.from_hsv(210 / h, 0.9, 0.7)
	color.brick.insulation = Color.from_hsv(270 / h, 0.9, 0.7)
	
	color.remoteness = {}
	color.remoteness[1] = Color.from_hsv(20 / h, 0.8, 0.4)
	color.remoteness[2] = Color.from_hsv(40 / h, 0.8, 0.4)
	color.remoteness[3] = Color.from_hsv(60 / h, 0.8, 0.4)


func save(path_: String, data_: String):
	var path = path_ + ".json"
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_string(data_)


func load_data(path_: String):
	var file = FileAccess.open(path_, FileAccess.READ)
	var text = file.get_as_text()
	var json_object = JSON.new()
	var _parse_err = json_object.parse(text)
	return json_object.get_data()


func get_random_key(dict_: Dictionary):
	if dict_.keys().size() == 0:
		print("!bug! empty array in get_random_key func")
		return null
	
	var total = 0
	
	for key in dict_.keys():
		total += dict_[key]
	
	rng.randomize()
	var index_r = rng.randf_range(0, 1)
	var index = 0
	
	for key in dict_.keys():
		var weight = float(dict_[key])
		index += weight/total
		
		if index > index_r:
			return key
	
	print("!bug! index_r error in get_random_key func")
	return null
