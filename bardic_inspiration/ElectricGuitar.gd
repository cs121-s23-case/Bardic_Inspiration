extends Area2D

func _on_body_entered(body):
	if body is Player:
		Global.AllSeeing += 1
		Global.switch = 1
		body.Guitar()
		self.queue_free()
