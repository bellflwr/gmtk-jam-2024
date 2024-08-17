extends CharacterBody2D

@onready var animation = $AnimatedSprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _process(delta):
	var mouse_position = get_global_mouse_position()
	animation.play()
		
	var direction = Input.get_vector("left", "right", "up", "down")
	
	if direction != Vector2.ZERO:
		velocity = velocity.move_toward(direction * 100, delta * 800)
		animation.set_animation("walk")
	else:
		velocity = velocity.move_toward(Vector2.ZERO, (delta * 1200))
		animation.set_animation("idle")
	print(velocity)
	
	look_at(mouse_position)
	
func _physics_process(delta):
	move_and_slide()
