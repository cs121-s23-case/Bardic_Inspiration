extends Node2D
@onready var Key = $key
@onready var Chest = $chest
@onready var SceneTransitionAnimation = $SceneTransitionAnimation/AnimationPlayer
@onready var anim_player = $AnimationPlayer
@export var txtScore : Label
@export var Player : CharacterBody2D
var score=0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SceneTransitionAnimation.play("fade_out")

var Val = 0
var ValChest = 0

func key_Collected() -> void:
	Val += 1

func chest_Open() -> void:
	if ValChest == 1:
		anim_player['parameters/conditions/open'] = true
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
#Does nothing
func incrementScore():
	score+=1
	var tempText = str(score)
	$score.text = tempText
	
func CheckAndCreateBoost():
	var tempText = str(score)
	if score>=20:
		#maybe drop something on the battlefield?
		$scoreLabel.text = tempText +" Woah, you got 20! Nice job! Maybe Ill give you a cookie or something!"
	
func returnScore():
	return score
	
func game_over():	#Friend put this in here, If the character player is gone, delete everything from screen
	if(Player==null):
		Player.queue_free()


func _on_screen_transition_body_entered(body: Node2D) -> void:
	if body is Player:
		SceneTransitionAnimation.play("fade_in")
		await get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_file("res://level_2.tscn")
