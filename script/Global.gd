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
	
	arr.bag = ["amulet", "ring", "gem"]
	arr.gem = ["emerald", "amethyst", "sapphire", "topaz", "pearl"]
	arr.page = ["spell", "mantra"]
	arr.offense = ["whip", "hammer", "spear"]
	arr.defense = ["parry", "block", "dodge"]
	arr.essence = ["lightning", "fire", "ice", "poison", "bone", "blood", "light", "void", "darkness"]
	
	arr.criterion = ["equal", "larger", "even", "odd", "identical", "unique"]


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
	init_area()
	init_season()
	init_gem()
	
	init_foundation()


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


func init_area() -> void:
	dict.area = {}
	dict.area.next = {}
	dict.area.next[null] = "discharged"
	dict.area.next["discharged"] = "available"
	dict.area.next["available"] = "hand"
	dict.area.next["hand"] = "discharged"
	dict.area.next["broken"] = "discharged"
	
	dict.area.prior = {}
	dict.area.prior["available"] = "discharged"
	dict.area.prior["hand"] = "available"


func init_season() -> void:
	dict.season = {}
	dict.season.phase = {}
	dict.season.phase["spring"] = ["incoming"]
	dict.season.phase["summer"] = ["selecting", "outcoming"]
	dict.season.phase["autumn"] = ["wounding"]
	dict.season.phase["winter"] = ["wilting", "sowing"]


func init_gem() -> void:
	var n = 3
	var m = n * 2
	dict.gem = {}
	var counts = {}
	counts["topaz"] = Vector2(6, n)
	counts["pearl"] = Vector2(arr.essence.size(), n)
	counts["emerald"] = Vector2(10, 1)
	counts["amethyst"] = Vector2(arr.offense.size(), m)
	counts["sapphire"] = Vector2(arr.defense.size(), m)
	
	for gem in arr.gem:
		dict.gem[gem] = {}
		var count = counts[gem]
		
		for _i in count.x:
			var description = {}
			description.type = gem
		
			match gem:
				"topaz":
					description.charge = _i + 1
					description.capacity = 1
				"pearl":
					description.essence = arr.essence[_i]
					description.capacity = 1
				"emerald":
					description.power = _i + 5
				"amethyst":
					description.seal = arr.offense[_i]
					description.capacity = 3
				"sapphire":
					description.seal = arr.defense[_i]
					description.capacity = 3
			
			for _j in count.y:
				dict.gem[gem][description] = [_j]


func init_foundation() -> void:
	dict.foundation = {}
	dict.foundation.rank = {}
	var exceptions = ["rank"]
	
	var path = "res://asset/json/ira_foundation.json"
	var array = load_data(path)
	
	for foundation in array:
		foundation.rank = int(foundation.rank)
		var data = {}
		
		for key in foundation:
			if !exceptions.has(key) and foundation[key] > 0:
				data[int(key)] = foundation[key]
			
		if !dict.foundation.rank.has(foundation.rank):
			dict.foundation.rank[foundation.rank] = []
	
		dict.foundation.rank[foundation.rank] = data
	
	init_kits()


func init_kits() -> void:
	var lengths = {}
	
	for _i in 3:
		for _j in 3:
			var rank = _i * 3 + _j + 1
			lengths[rank] = _i + 2#_i * 2 + 2
	
	for rank in lengths:
		for length in lengths[rank]:
			pass
	
	var rank = 2
	var source = dict.foundation.rank[rank]
	var result = get_all_constituents_based_on_limit(source, 2)
	
	for limit in result:
		for constituent in result[limit]:
			var criterions = get_appropriate_criterions(constituent)
			print([constituent, criterions])


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
	
	scene.bag = load("res://scene/6/bag.tscn")
	
	for gem in arr.gem:
		scene[gem] = load("res://scene/7/" + gem + ".tscn")
	
	scene.paragraph = load("res://scene/8/paragraph.tscn")
	scene.charge = load("res://scene/8/charge.tscn")


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
	
	vec.size.gem = Vector2(vec.size.token.x, vec.size.token.y)
	vec.size.bag = Vector2()#vec.size.token.x * 6, vec.size.token.y * 5)
	
	vec.size.charge = Vector2(vec.size.token.x, vec.size.token.y)
	
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
	
	color.gem = {}
	color.gem.selected = {}
	color.gem.selected[true] = Color.from_hsv(160 / h, 0.4, 0.7)
	color.gem.selected[false] = Color.from_hsv(60 / h, 0.2, 0.9)


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


func get_all_constituents_based_on_limit(source_: Dictionary, limit_: int) -> Dictionary:
	var constituents = {}
	constituents[1] = []
	
	for nominal in source_:
		var constituent = {}
		constituent[nominal] = 1
		constituents[1].append(constituent)
	
	for _i in limit_ - 1:
		var limit = _i + 2
		constituents[limit] = []
		
		for parent in constituents[limit - 1]:
			for nominal in source_:
				var child = parent.duplicate()
				
				if !child.has(nominal):
					child[nominal] = 0
				
				child[nominal] += 1
				
				var constituent = {}
				var nominals = child.keys()
				nominals.sort()
				
				for _nominal in nominals:
					constituent[_nominal] = child[nominal]
				
				
				if source_[nominal] >= constituent[nominal] and !constituents[limit].has(constituent):
					constituents[limit].append(constituent)
	
	return constituents


func get_appropriate_criterions(constituent_: Dictionary) -> Array:
	var criterions = []
	var sum = 0
	var count = 0
	var minimum = constituent_.keys().front()
	
	for nominal in constituent_:
		sum += constituent_[nominal] * nominal
		count += constituent_[nominal]
		
		if minimum > nominal:
			minimum = nominal
	
	for criterion in arr.criterion:
		var description = {}
		description.criterion = criterion
		
		match criterion:
			"equal":
				description.value = int(sum)
				criterions.append(description)
			"larger":
				print(minimum)
				for value in range(1, minimum, 1):
					var _description = description.duplicate()
					_description.value = int(value)
					criterions.append(_description)
			"even":
				if sum % 2 == 0:
					criterions.append(description)
			"odd":
				if sum % 2 == 1:
					criterions.append(description)
			"identical":
				if constituent_.keys().size() == 1 and count > 1:
					criterions.append(description)
			"unique":
				if count > 1:
					var flag = true
					
					for nominal in constituent_:
						if constituent_[nominal] > 1:
							flag = false
							break
					
					if flag:
						criterions.append(description)
	
	return criterions
