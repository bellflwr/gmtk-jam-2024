extends CharacterBody2D

@onready var animation = %AnimatedSprite2D
@onready var pivot = %SpritePivot
@onready var weapon = $HitscanWeapon

@export var speed: float = 50.0
@export var accel: float = 500.0
@export var encounter_distance: float = 50.0
@export var distance_allowance: float = 10.0
@export var max_distance: float = 200.0

var target: Node2D

func _process(delta):
	animation.play()
	
	var direction = Vector2.ZERO
	
	if target:
		pivot.look_at(target.position)
		
		var dist = position.distance_to(target.position)
		
		if dist >= max_distance:
			target = null
			return
		
		var toward = (target.position - position).normalized()
		
		
		if dist >= encounter_distance + distance_allowance:
			direction = toward
		elif dist <= encounter_distance - distance_allowance:
			direction = -toward
		else:
			weapon.attempt_burst(target.global_position)
			
	velocity = velocity.move_toward(direction * speed, accel * delta)
	
	if velocity:
		animation.set_animation("walk")
	else:
		animation.set_animation("idle")
	
	
	
func _physics_process(delta):
	move_and_slide()


func _on_vision_field_body_entered(body: Node2D) -> void:
	if body == self:
		return
		
	target = body
		
	
	
	
	
	
