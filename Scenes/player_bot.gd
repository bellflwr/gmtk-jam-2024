extends CharacterBody2D

@onready var animation = $AnimatedSprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _process(delta):
	var mouse_position = get_global_mouse_position()
	animation.play()
	var direction = Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		direction += Vector2.UP
	if Input.is_action_pressed("move_down"):
		direction += Vector2.DOWN
	if Input.is_action_pressed("move_left"):
		direction += Vector2.LEFT
	if Input.is_action_pressed("move_right"):
		direction += Vector2.RIGHT
	
	if direction != Vector2.ZERO:
		velocity = velocity.move_toward((direction.normalized() * 100), (delta * 800))
		animation.set_animation("walk")
	else:
		velocity = velocity.move_toward(Vector2.ZERO, (delta * 1200))
		animation.set_animation("idle")
	print(velocity)
	
	look_at(mouse_position)
	
func _physics_process(delta):
	move_and_slide()
