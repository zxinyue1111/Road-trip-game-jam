extends CharacterBody2D

const speed = 230
var currentDir = "none"

func _ready():
	$Animation2D.play("frontStand")

func _physics_process(delta: float) -> void:
	player_movement(delta)
	
func player_movement(delta):
	if Input.is_action_pressed("ui_right"):
		currentDir = "right"
		play_anim(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		currentDir = "left"
		play_anim(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_down"):
		currentDir = "down"
		play_anim(1)
		velocity.y = speed
		velocity.x = 0
	elif Input.is_action_pressed("ui_up"):
		currentDir = "up"
		play_anim(1)
		velocity.y = -speed
		velocity.x = 0
	else:
		play_anim(0)
		velocity.x = 0
		velocity.y = 0
		
	move_and_slide()
	
func play_anim(movement):
	var dir = currentDir
	var anim = $Animation2D
	
	if dir == "right":
		anim.flip_h = true
		if movement == 1:
			anim.play("sideWalk")
		elif movement == 0:
			anim.play("sideStand")
			
	if dir == "left":
		anim.flip_h = false
		if movement == 1:
			anim.play("sideWalk")
		elif movement == 0:
			anim.play("sideStand")
			
	if dir == "down":
		anim.flip_h = false
		if movement == 1:
			anim.play("frontWalk")
		elif movement == 0:
			anim.play("frontStand")
			
	if dir == "up":
		anim.flip_h = false
		if movement == 1:
			anim.play("backWalk")
		elif movement == 0:
			anim.play("backStand")
