extends Node2D
@onready var SceneTransitionAnimation = $SceneTransitionAnimation/AnimationPlayer

func _on_screen_transition_body_entered(body: Node2D) -> void:
	if body is Player:
		SceneTransitionAnimation.play("fade_in")
		await get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_file("res://Bardic_Inspiration.tscn")
