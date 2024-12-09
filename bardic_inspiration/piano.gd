extends CharacterBody2D
class_name piano
@onready var anim_tree = $AnimationTree
#@onready var nav: NavigationAgent2D = $NavigationAgent2D
const speed = 200.0
var is_piano_chase: bool
var is_roaming: bool
var dead: bool
var dir: Vector2
var player: Player
var taking_damage: bool = false
var is_dealing_damage: bool = false
var player_in_area = false
var health_min = 0
var damage_to_deal = 20
var knockback_force = -200
var facing = 1
var piano_health = 60

func _ready():
	is_piano_chase = false
	
func _process(delta):
	move(delta)
	handle_animation()

func move(delta):
	if is_piano_chase:
		player = Global.playerBody
		velocity = position.direction_to(player.position) * speed
		
	elif !is_piano_chase:
		velocity += dir * speed * delta
	elif is_piano_chase and !taking_damage:
		var velocity = position.direction_to(player.position) * speed
			
	elif taking_damage:
		var knockback_dir = position.direction_to(player.position) * knockback_force
		velocity.x = knockback_dir
		is_roaming = true
	elif dead:
		velocity.x = 0
		
	move_and_slide()
	
	
func handle_death():
	self.queue_free()
	
func handle_animation():
	if !dead and !taking_damage and !is_dealing_damage:
		anim_tree['parameters/conditions/walk'] = true
		if dir.x < 0 and facing == -1:
			self.scale.x *= -1
			facing = 1
	
		if dir.x > 0 and facing == 1:
			self.scale.x *= -1
			facing = -1
		

func _on_timer_timeout():
	$Timer.wait_time = choose([0.5,0.8,1.3])
	if !is_piano_chase:
		dir = choose([Vector2.RIGHT, Vector2.LEFT, Vector2.UP, Vector2.DOWN])
		
func choose(array):
	array.shuffle()
	return array.front()


func _on_piano_hitbox_area_entered(area: Area2D) -> void:
	var damage = Global.playerDamage
	if area == Global.playerDamageZone:
		take_damage()
	
func _on_piano_attack_area_body_entered(body: Node2D) -> void:
	if body is Player: 
		body.get_damage()
		if Global.switch == 0:
			$PianoSound1.play()
		else:
			$PianoSound2.play()
		anim_tree['parameters/conditions/attack'] = true

func _on_piano_attack_area_body_exited(body: Node2D) -> void:
	if body is Player:
#		body.not_taking_damage() #code for damage animation
		anim_tree['parameters/conditions/attack'] = false


func take_damage():
	piano_health -= damage_to_deal
	print("Piano Health is: ")
	print(piano_health)
	$HealthBarPiano.piano_health = piano_health
	taking_damage = true
	
	if piano_health <= health_min:
		handle_piano_death()
		
func handle_piano_death() -> void:
	print("Piano Died")
	self.queue_free()
	piano_health += 60
