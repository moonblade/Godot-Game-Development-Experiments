extends Node2D
class_name GameWorld

signal started
signal finished

onready var _tile_map : TileMap = $TileMap

enum Cell {OBSTACLE, GROUND, OUTER}

export var inner_size:= Vector2(10,8);
export var perimeter_size := Vector2(1,1);
export(float, 0, 1) var ground_probability := 0.9

var size:= inner_size+2*perimeter_size

# private
var _rng := RandomNumberGenerator.new()

func setup() -> void:
	var map_size_px := size * _tile_map.cell_size
	get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_2D, SceneTree.STRETCH_ASPECT_KEEP, map_size_px)
	OS.set_window_size(2 * map_size_px)

# Called when the node enters the scene tree for the first time.
func _ready():
	setup()
	generate()

func generate():
	emit_signal("started")
	
	_generate_perimeter()
	_generate_inner()
	emit_signal("finished")

func _pick_random_texture(cellType):
	var interval := Vector2()
	if cellType == Cell.OUTER:
		interval = Vector2(0, 9)
	elif cellType == Cell.GROUND:
		interval = Vector2(15, 27)
	elif cellType == Cell.OBSTACLE:
		interval = Vector2(10, 14)
	return _rng.randi_range(interval.x, interval.y)
	
func _generate_perimeter():
	for x in [0, size.x - 1]:
		for y in range(0, size.y):
			_tile_map.set_cell(x , y, _pick_random_texture(Cell.OUTER))
	for x in range(1, size.x - 1):
		for y in [0, size.y - 1]:
			_tile_map.set_cell(x , y, _pick_random_texture(Cell.OUTER))

func _generate_inner():
	for x in range(1, size.x-1):
		for y in range(1, size.y-1):
			var cellType = Cell.OBSTACLE;
			if _rng.randf() <= ground_probability:
				cellType = Cell.GROUND
			_tile_map.set_cell(x, y, _pick_random_texture(cellType))
	pass

func _unhandled_input(event):
	if event.is_action_pressed("confirm"):
		generate()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
