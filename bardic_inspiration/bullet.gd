extends RigidBody2D
@export var bullet_resource: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var velocity = Vector2(200, 0)
	linear_velocity = velocity
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
