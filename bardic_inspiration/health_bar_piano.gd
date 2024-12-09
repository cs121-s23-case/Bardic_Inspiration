extends ProgressBar
@onready var piano_health: int = max_value : set = _set_piano_health

func _set_piano_health(new_health: int) -> void:
	piano_health = new_health
	value = piano_health
