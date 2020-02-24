extends KinematicBody2D

var ANIMATION_STATE

var VELOCITY = Vector2()
var SPEED = 200


func _ready():
	ANIMATION_STATE = $AnimationTree.get("parameters/playback")
	ANIMATION_STATE.start("idle")
	pass

func get_input():
	VELOCITY = Vector2()
	
	if Input.is_action_just_pressed("attack"):
		ANIMATION_STATE.travel("attack")
		return
	
	if ANIMATION_STATE.get_current_node() != "attack":
		if Input.is_action_pressed("right"):
			VELOCITY.x += 1
			$Sprite.scale.x = 1
		if Input.is_action_pressed("left"):
			VELOCITY.x -= 1
			$Sprite.scale.x = -1
		if Input.is_action_pressed("down"):
			VELOCITY.y += 1
		if Input.is_action_pressed("up"):
			VELOCITY.y -= 1
	
	if VELOCITY.length() == 0:
		ANIMATION_STATE.travel("idle")
	if VELOCITY.length() > 0:
		ANIMATION_STATE.travel("run")
	
	VELOCITY = VELOCITY.normalized() * SPEED
	pass

func _process(delta):
	get_input()
	move_and_slide(VELOCITY)
	pass




func _on_hitbox_body_entered(body):
	if body.is_in_group("smashable"):
		body.smashed()
	pass 
