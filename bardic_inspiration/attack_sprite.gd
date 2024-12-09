extends RigidBody2D

func _ready() -> void:
	Global.velocity
	linear_velocity = Global.velocity
	await get_tree().create_timer(1).timeout
	self.queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is piano:
		body.take_damage()
		self.queue_free()
	if body is harp:
		body.take_harp_damage()
		self.queue_free()
