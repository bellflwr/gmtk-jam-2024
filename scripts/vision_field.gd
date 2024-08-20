extends Area2D
class_name VisionField

@export var range: float = 50
@export var fov: float = 120
@export var segment_size: float = 30

@onready var polygon = $CollisionPolygon2D


func generate_field():
	var shape = PackedVector2Array([Vector2(0, 0)])
	
	var segments: int = floor(fov/segment_size) + 1
	
	var first = floor(segments/2)
	
	for i in range(segments):
		var j = ((2.0*i) / (segments - 1)) - 1
		
		var angle = fov/2.0 * j
		
		var vec = Vector2.from_angle(deg_to_rad(angle)) * range

		shape.append(vec)
	
	polygon.polygon = shape

func _ready() -> void:
	generate_field()
