extends Node2D
class_name GameWorld

signal started
signal finished

onready var _tile_map : TileMap = $TileMap

enum Cell {OBSTACLE, GROUND, OUTER}

export var inner_size:= Vector2(10,8);
export var perimeter_size := Vector2(1,1);
export(float, 0, 1) var ground_probability := 0.1

var size:= inner_size+2*perimeter_size

# private
var _rng := RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
