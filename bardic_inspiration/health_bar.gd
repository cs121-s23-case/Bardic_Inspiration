extends ProgressBar

func _process(delta):
	self.value = Global.player_health
	if Global.player_health < 100:
		self.visible = true
		if Global.player_health == 0:
			self.visible = false
