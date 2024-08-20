extends CharacterBody2D

@onready var animation = %AnimatedSprite2D
@onready var pivot = %SpritePivot
@onready var weapon = $HitscanWeapon

@export var speed: float = 100.0
@export var accel: float = 500.0
@export var look_speed: float = 360

func _process(delta):
	animation.play()
		
	var direction = Input.get_vector("left", "right", "up", "down")
	
	velocity = velocity.move_toward(direction * speed, accel * delta)
		
	if velocity:
		animation.set_animation("walk")
	else:
		animation.set_animation("idle")
		
	var mouse_position = get_global_mouse_position()
	pivot.look_at(mouse_position)
	
	
	
	
	
func _physics_process(delta):
	move_and_slide()
	weapon.player_process()
