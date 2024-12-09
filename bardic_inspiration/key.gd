extends Area2D

func _on_body_entered(body):
	if body is Player:
		Global.KeyVal += 1
		body.key()
		$Wall.queue_free()
		self.queue_free()
