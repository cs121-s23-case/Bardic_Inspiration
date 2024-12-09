class_name Player
extends CharacterBody2D
@onready var anim_tree = $AnimationTree
@export var bullet = preload("res://attack_sprite.tscn")
@export var AttackSpriteScene = preload("res://attack_sprite.tscn")
@export var Val = 0
@export var ValChest = 0
const SPEED = 150.0
const JUMP_VELOCITY = -400.0
var facing = 1
var switch = 0
var can_control : bool = true
var original_position=Vector2(469, 220)
var health_min = 0


func _ready():
	Global.playerBody = self

	
func _process(_delta):
	if Input.is_action_pressed("Escape"):
		get_tree().quit()
		
	if Input.is_action_just_pressed("switch"):
		if Global.switch == 1:
			Global.switch -= 1
		elif Global.switch == 0 and Global.KeyVal == 1 and Global.AllSeeing == 1:
			Global.switch += 1
		print(Global.switch)
		
	var dir = Input.get_vector("left", "right", "switch", "attack")
	
	if dir.x < 0 and facing == 1:
		self.scale.x *= -1
		facing = -1
		
	if dir.x > 0 and facing == -1:
		self.scale.x *= -1
		facing = 1

	

	if velocity.length() > 0.01 and Global.switch == 0:
		anim_tree['parameters/conditions/walk'] = true
		anim_tree['parameters/conditions/idle'] = false
		anim_tree['parameters/conditions/walkingElectric'] = false
		anim_tree['parameters/conditions/idleElectric'] = false
	elif velocity.length() < 0.01 and Global.switch == 0:
		anim_tree['parameters/conditions/walk'] = false
		anim_tree['parameters/conditions/idle'] = true
		anim_tree['parameters/conditions/walkingElectric'] = false
		anim_tree['parameters/conditions/idleElectric'] = false
	elif velocity.length() > 0.01 and Global.switch == 1:
		anim_tree['parameters/conditions/walkingElectric'] = true
		anim_tree['parameters/conditions/idleElectric'] = false
		anim_tree['parameters/conditions/idle'] = false
		anim_tree['parameters/conditions/walk'] = false
	else:
		anim_tree['parameters/conditions/walkingElectric'] = false
		anim_tree['parameters/conditions/idleElectric'] = true
		anim_tree['parameters/conditions/idle'] = false
		anim_tree['parameters/conditions/walk'] = false
	
	
	if Input.is_action_just_pressed("attack") and Global.switch == 0:
		$GuitarSound.play()
		anim_tree['parameters/conditions/attack'] = true
		anim_tree['parameters/conditions/idle'] = false
		anim_tree['parameters/conditions/walk'] = false
		if facing == 1:
			Global.velocity = Vector2(400, 0)
			var bullet_instance = bullet.instantiate()
			bullet_instance.position.x = self.position.x+30
			bullet_instance.position.y = self.position.y
			bullet_instance.set_name("bullet")
			get_node("/root").add_child(bullet_instance)
		elif facing == -1:
			Global.velocity = Vector2(-400, 0)
			var bullet_instance = bullet.instantiate()
			bullet_instance.position.x = self.position.x-30
			bullet_instance.position.y = self.position.y
			bullet_instance.set_name("bullet")
			get_node("/root").add_child(bullet_instance)
	elif Input.is_action_just_pressed("attack") and Global.switch == 1:
		anim_tree['parameters/conditions/attackElectric'] = true
		$ElectricSound.play()
		anim_tree['parameters/conditions/walkingElectric'] = false
		anim_tree['parameters/conditions/idleElectric'] = false
	else:
		anim_tree['parameters/conditions/attack'] = false
		anim_tree['parameters/conditions/attackElectric'] = false
	
	if Input.is_action_pressed("left") and Global.switch == 0:
		self.position.x += -5;
		anim_tree['parameters/conditions/walk'] = true
		anim_tree['parameters/conditions/idle'] = false
		anim_tree['parameters/conditions/walkingElectric'] = false
		anim_tree['parameters/conditions/idleElectric'] = false
	elif Input.is_action_pressed("left") and Global.switch == 1:
		self.position.x += -5;
		anim_tree['parameters/conditions/walkingElectric'] = true
		anim_tree['parameters/conditions/idleElectric'] = false
		anim_tree['parameters/conditions/idle'] = false
		anim_tree['parameters/conditions/walk'] = false
		
	if Input.is_action_pressed("right") and Global.switch == 0:
		self.position.x += 5;
		anim_tree['parameters/conditions/walk'] = true
		anim_tree['parameters/conditions/idle'] = false
		anim_tree['parameters/conditions/walkingElectric'] = false
		anim_tree['parameters/conditions/idleElectric'] = false
	elif Input.is_action_pressed("right") and Global.switch == 1:
		self.position.x += 5;
		anim_tree['parameters/conditions/walkingElectric'] = true
		anim_tree['parameters/conditions/idleElectric'] = false
		anim_tree['parameters/conditions/idle'] = false
		anim_tree['parameters/conditions/walk'] = false
	
	if Input.is_action_pressed("up") and Global.switch == 0:
		self.position.y += -1;
		anim_tree['parameters/conditions/walk'] = true
		anim_tree['parameters/conditions/idle'] = false
		anim_tree['parameters/conditions/walkingElectric'] = false
		anim_tree['parameters/conditions/idleElectric'] = false
	elif Input.is_action_pressed("up") and Global.switch == 1:
		self.position.y += -1;
		anim_tree['parameters/conditions/walkingElectric'] = true
		anim_tree['parameters/conditions/idleElectric'] = false
		anim_tree['parameters/conditions/idle'] = false
		anim_tree['parameters/conditions/walk'] = false
	
	if Input.is_action_pressed("down") and Global.switch == 0:
		self.position.y += 1;
		anim_tree['parameters/conditions/walk'] = true
		anim_tree['parameters/conditions/idle'] = false
		anim_tree['parameters/conditions/walkingElectric'] = false
		anim_tree['parameters/conditions/idleElectric'] = false
	elif Input.is_action_pressed("down") and Global.switch == 1:
		self.position.y += 1;
		anim_tree['parameters/conditions/walkingElectric'] = true
		anim_tree['parameters/conditions/idleElectric'] = false
		anim_tree['parameters/conditions/idle'] = false
		anim_tree['parameters/conditions/walk'] = false
	
	
	
	move_and_slide()

func _on_attack_area_body_entered(body: Node2D) -> void:
	if body is piano:
		body.take_damage()
	if body is harp:
		body.take_harp_damage()
	

func get_damage():
	await get_tree().create_timer(0.3).timeout
	Global.player_health -= 20
	print("Player Health is: ")
	print( Global.player_health)
	pass
	
	if Global.player_health <= health_min:
		handle_death()

func handle_death() -> void:
	print("Player Died")
	Global.player_health += 100
	Global.lives -= 1
	if Global.lives == 0:
		get_tree().change_scene_to_file("res://game_over.tscn")
	elif Global.lives <= 0:
		get_tree().quit()
		
	visible = false
	can_control = false
	if Global.lives >= 1:
		await get_tree().create_timer(.3).timeout
		reset_player()
		
		
func reset_player() -> void:
	if can_control:
		return
	can_control=true
	transform=Transform2D(0,original_position)
	visible = true
	can_control = true

func _physics_process(delta: float) -> void:
	
	if Input.is_action_pressed("up"):
		self.position.y += -4;
		anim_tree['parameters/conditions/walk'] = true
	if Input.is_action_pressed("down"):
		self.position.y += 4;
		anim_tree['parameters/conditions/walk'] = true

func key() -> void:
	print(Val)

func Guitar() -> void:
	print(Global.switch)
	
#Damaged animation does work now, but wont let you attack unless I make a damaged
#animation for all my sprites and then link it all. Or I could figure out how to
#color shift the player to red when you enter the piano body, but I dont know if
#that's possible
	
#func taking_damage():
#	if Global.switch == 0:
#		anim_tree['parameters/conditions/damaged'] = true
#	elif Global.switch == 1:
#		anim_tree['parameters/conditions/damagedElectric'] = true

#func not_taking_damage():
#	if Global.switch == 0:
#		anim_tree['parameters/conditions/damaged'] = false
#	elif Global.switch == 1:
#		anim_tree['parameters/conditions/damagedElectric'] = false
