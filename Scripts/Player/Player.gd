extends KinematicBody2D


var MOVE_SPEED = 40
const JUMP_FORCE = 150
const GRAVITY = 11
const MAX_FALL_SPEED = 200
var BULLET_SPEED = 125

onready var anim_player = $AnimationPlayer
onready var sprite = $Sprite

var velocity = Vector2(0,0)
var jump_max = 99
var jump_count = 0

var facing_right = false

var invincible = false

func _ready():
	Global.player = self

func _physics_process(delta):
	# hit escape to exit the game
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	
	# hit r to reset the game
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
		
	# hit f11 to fullscreen the game
	if Input.is_action_pressed("fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
	
	var move_dir = 0
	if Input.is_action_pressed("ui_right"):
		move_dir += 1
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		move_dir -= 1
		velocity.x -= 1

	move_and_slide(Vector2(velocity.x * MOVE_SPEED, velocity.y), Vector2(0, -1))
		
	velocity.x = lerp(velocity.x,0,0.5)
		
	var grounded = is_on_floor()
	if grounded:
		jump_count = 0
		
	velocity.y += GRAVITY
	if jump_count < jump_max:
		if Input.is_action_just_released("ui_up") && velocity.y < 0:
			velocity.y = 0
				
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = -JUMP_FORCE
			jump_count += 1
	
	if grounded and velocity.y >= 5:
			velocity.y = 5
	if velocity.y > MAX_FALL_SPEED:
		velocity.y = MAX_FALL_SPEED
	
	if grounded:
		if move_dir == 0 || is_on_wall():
			play_anim("Idle")
		else:
			play_anim("Move")
	else:
		play_anim("Air")
	
	if facing_right and velocity.x > 0:
		flip()
	if !facing_right and velocity.x < 0:
		flip()

func flip():
	facing_right = !facing_right
	sprite.flip_h = !sprite.flip_h

	
func play_anim(anim_name):
	if anim_player.is_playing() and anim_player.current_animation == anim_name:
		return
	anim_player.play(anim_name)
