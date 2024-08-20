extends Node2D
class_name HealthComponent

@export var max_health: float = 10
@export var health_bar: ProgressBar
var health: float:
	get:
		return health
	set(val):
		health = val
		health_changed.emit(self)		

signal health_changed(health: HealthComponent)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = max_health

func apply_damage(points: float):
	health -= points

	if health <= 0:
		get_parent().queue_free()

func _on_hitbox_damage_taken(points: float) -> void:
	apply_damage(points)
