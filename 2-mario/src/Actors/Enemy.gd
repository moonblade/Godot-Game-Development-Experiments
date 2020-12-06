extends "res://src/Actors/Actor.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	if is_on_wall():
		_velocity.x *= -1
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y

func _ready() -> void:
	_velocity.x = -speed.x

