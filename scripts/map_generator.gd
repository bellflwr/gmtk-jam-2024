extends TileMapLayer

var roads = {}
var intersections = {}

const SCALE = 15
const MAP_SIZE = 20

const ASPHALT = Vector2i(0, 0)
const LINE_Y = Vector2i(1, 0)
const LINE_X = Vector2i(2, 0)
const INTERSECTION = Vector2i(3, 0)
const CURB = Vector2i(0, 1)

func make_pair_key(pos1: Vector2i, pos2: Vector2i):
	if pos1.x > pos2.x:
		return [pos2, pos1]
	elif pos1.x == pos2.x:
		if pos1.y > pos2.y:
			return [pos2, pos1]
	return [pos1, pos2]

func in_bounds(pos: Vector2i):
	return pos.x >= 0 and pos.y >= 0 and pos.x < MAP_SIZE and pos.y < MAP_SIZE

func get_neighbors(pos: Vector2i):
	return [
		pos + Vector2i.UP,
		pos + Vector2i.DOWN,
		pos + Vector2i.LEFT,
		pos + Vector2i.RIGHT,
	]
	
func get_neighbors_in_bounds(pos: Vector2i):
	return get_neighbors(pos).filter(in_bounds)

func isnt_visited(pos: Vector2i):
	return not intersections[pos]

func get_unvisited_neighbors(pos: Vector2i):
	return get_neighbors_in_bounds(pos).filter(isnt_visited)

func simple_set_cell(pos: Vector2i, atlas_coords: Vector2i):
	set_cell(pos, 1, atlas_coords, 0)
	
func set_cell_if_empty(pos: Vector2i, atlas_coords: Vector2i):
	if get_cell_tile_data(pos) == null:
		simple_set_cell(pos, atlas_coords)

func generate_map():
	for x in range(MAP_SIZE):
		for y in range(MAP_SIZE):
			var pos1 = Vector2i(x, y)
			intersections[pos1] = false
			for pos2 in get_neighbors_in_bounds(pos1):
				var key = make_pair_key(pos1, pos2)
				if key not in roads:
					roads[key] = false
					
	var stack = []
	
	var init_cell = Vector2i(floor(MAP_SIZE/2), floor(MAP_SIZE/2))
	
	print(get_unvisited_neighbors(init_cell))
	
	intersections[init_cell] = true
	stack.append(init_cell)
	
	while not stack.is_empty():
		var current_cell = stack.pop_back()
		
		var unvisited_neighbors = get_unvisited_neighbors(current_cell)
		if unvisited_neighbors:
			stack.append(current_cell)
			var chosen_cell = unvisited_neighbors.pick_random()
			var key = make_pair_key(current_cell, chosen_cell)
			roads[key] = true
			intersections[chosen_cell] = true
			stack.append(chosen_cell)
		
	for i in range(roads.size()/4):
		var key = roads.keys().pick_random()
		roads[key] = true
	
		
	for k in roads.keys():
		if not roads[k]:
			continue
		
		var pos1 = k[0]
		var pos2 = k[1]
		
		var atlas_coords
		var p_offset
		
		if pos1.x == pos2.x:
			atlas_coords = LINE_Y
			p_offset = Vector2i.LEFT
		else:
			atlas_coords = LINE_X
			p_offset = Vector2i.UP
			
		
		var offset = pos2-pos1
		
		var start = pos1 * SCALE
		var end = start + offset * SCALE
		
		for i in range(SCALE+1):
			var cell = start + offset * i
			
			var posa
			
			for j in range(1, 3+1):
				posa = cell+p_offset*j
				if get_cell_atlas_coords(posa) not in [LINE_X, LINE_Y, INTERSECTION]:
					simple_set_cell(cell+p_offset*j, ASPHALT)
				posa = cell-p_offset*j
				if get_cell_atlas_coords(posa) not in [LINE_X, LINE_Y, INTERSECTION]:
					simple_set_cell(cell-p_offset*j, ASPHALT)
				
			for j in range(4, 6+1):
				posa = cell+p_offset*j
				if get_cell_atlas_coords(posa) not in [ASPHALT]:
					set_cell_if_empty(cell+p_offset*j, CURB)
				posa = cell+p_offset*j
				if get_cell_atlas_coords(posa) not in [ASPHALT]:
					set_cell_if_empty(cell-p_offset*j, CURB)
					
			simple_set_cell(cell, atlas_coords)
				
			
		set_cell(start, 1, INTERSECTION, 0)
		set_cell(end, 1, INTERSECTION, 0)
		
	
			
		
			
			
				
				


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generate_map()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if Input.is_action_pressed()
	pass
