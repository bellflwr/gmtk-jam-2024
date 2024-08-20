extends CharacterBody2D

@onready var treads = $Treads
@onready var body = $body
@onready var arm_r = $right_arm
@onready var arm_l = $left_arm
@onready var head = $head

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _ready():
	treads.play()
	arm_r.play()
	arm_l.play()

func _process(delta):
	var mouse_position = get_global_mouse_position()
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
		treads.set_animation("move")
		arm_r.set_animation("move")
		arm_l.set_animation("move")
	else:
		velocity = velocity.move_toward(Vector2.ZERO, (delta * 1200))
		treads.set_animation("default")
		arm_r.set_animation("default")
		arm_l.set_animation("default")
	print(velocity)
	
	look_at(mouse_position)
	
func _physics_process(delta):
	move_and_slide()
