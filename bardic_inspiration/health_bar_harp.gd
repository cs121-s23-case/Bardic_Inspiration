extends ProgressBar
@onready var harp_health: int = max_value : set = _set_harp_health

func _set_harp_health(new_health: int) -> void:
	harp_health = new_health
	value = harp_health
