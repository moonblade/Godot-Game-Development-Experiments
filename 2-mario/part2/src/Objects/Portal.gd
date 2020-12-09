tool
extends Area2D

onready var anim_player:= $AnimationPlayer
export var next_scene: PackedScene

func _on_Portal_body_entered(body: Node) -> void:
	teleport()

func _get_configuration_warning() -> String:
	return "Next scene is empty" if not next_scene else ""

func teleport() -> void:
	anim_player.play("fade")
	yield(anim_player, "animation_finished")
	get_tree().change_scene_to(next_scene)
	
