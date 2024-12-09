extends Node2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		$You_Win.visible = true
		$Area2D/Yippee.play()
		await get_tree().create_timer(3).timeout
		$You_Win.visible = false
		$Amount.visible = true
		await get_tree().create_timer(3).timeout
		get_tree().quit()
