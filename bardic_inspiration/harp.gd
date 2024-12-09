extends CharacterBody2D
class_name harp
@onready var anim_tree = $AnimationTree
const speed = 100.0
var dir: Vector2
var player: Player
var is_harp_chase: bool
var is_roaming: bool
var taking_damage: bool = false
var is_dealing_damage: bool = false
var player_in_area = false
var health_min = 0
var damage_to_deal = 20
var knockback_force = -200
var facing = 1
var harp_health = 50

func _ready():
	is_harp_chase = true
	
func _process(delta):
	move(delta)
	handle_animation()
	
func move(delta):
	if is_harp_chase:
		player = Global.playerBody
		velocity = position.direction_to(player.position) * speed
		dir.x = abs(velocity.x) / velocity.x
		
	elif !is_harp_chase:
		velocity += dir * speed * delta
	elif is_harp_chase and !taking_damage:
		var velocity = position.direction_to(player.position) * speed
			
	move_and_slide()
	
func handle_death():
	self.queue_free()
	
func handle_animation():
	if !is_dealing_damage:
		anim_tree['parameters/conditions/walk'] = true
		if dir.x < 0 and facing == -1:
			self.scale.x *= -1
			facing = 1
		elif dir.x > 0.1 and facing == 1:
			self.scale.x *= -1
			facing = -1
			
func _on_timer_timeout():
	$Timer.wait_time = choose([0.5,0.8,1.3])
	if !is_harp_chase:
		dir = choose([Vector2.RIGHT, Vector2.LEFT, Vector2.UP, Vector2.DOWN])
		
func choose(array):
	array.shuffle()
	return array.front()

func _on_harp_hit_box_area_entered(area: Area2D) -> void:
	var damage = Global.playerDamage
	if area == Global.playerDamageZone:
		take_harp_damage()

func _on_harp_attack_area_body_entered(body: Node2D) -> void:
	if body is Player:
		body.get_damage()
		if Global.switch == 0:
			$HarpSound1.play()
		else:
			$HarpSound2.play()
		anim_tree['parameters/conditions/attack'] = true

func _on_harp_attack_area_body_exited(body: Node2D) -> void:
	if body is Player:
		anim_tree['parameters/conditions/attack'] = false

func take_harp_damage():
	harp_health -= damage_to_deal
	print("Harp Health is: ")
	print(harp_health)
	$HealthBarHarp.harp_health = harp_health
	taking_damage = true
	
	if harp_health <= health_min:
		handle_harp_death()
		
func handle_harp_death() -> void:
	print("Harp Died")
	self.queue_free()
	harp_health += 60
