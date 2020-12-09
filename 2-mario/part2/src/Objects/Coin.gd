extends Area2D

onready var anim_player:= get_node("AnimationPlayer")

func _ready() -> void:
	pass # Replace with function body.




func _on_body_entered(body: Node) -> void:
	anim_player.play("fade")
