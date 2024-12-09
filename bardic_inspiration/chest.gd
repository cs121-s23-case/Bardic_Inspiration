extends Area2D
@onready var openChest = $AnimatedSprite2D

func _on_body_entered(body):
	if body is Player and Global.KeyVal == 1 and Global.AllSeeing == 0:
		body.key()
		openChest.play("open")
		$ElectricGuitar/ElectricGuitarSprite.visible = true
		$ElectricGuitar/Collision.visible = true
		$Label.visible = true
	else:
		print("Not Happening")
