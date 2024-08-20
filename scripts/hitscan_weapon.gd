extends RayCast2D

@export var range: float = 30
@export var weapon: HitscanWeaponType
@onready var sound_source = $AudioStreamPlayer2D

var last_burst: int = 0


func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

func player_process() -> void:
	if Input.is_action_just_pressed("shoot") or Input.is_action_pressed("shoot") and weapon.is_automatic:
		attempt_burst(get_global_mouse_position())
			
func attempt_burst(target: Vector2):
	if Time.get_ticks_msec() - last_burst >= weapon.burst_interval * 1000:
		burst(target)	

func shoot(target: Vector2):
	last_burst = Time.get_ticks_msec()
	
	sound_source.play()
	
	var shoot_direction = (target - global_position).normalized() * range
	
	target_position = shoot_direction
	
	force_raycast_update()
	
	if is_colliding():
		var collider = get_collider()
		
		if collider.has_method("damage"):
			collider.damage(weapon.damage)

func burst(target: Vector2):
	last_burst = Time.get_ticks_msec()
	
	for i in range(weapon.shots_per_burst):
		shoot(target)
		await wait(weapon.shot_interval)

	
