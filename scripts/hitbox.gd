extends Area2D

signal damage_taken(points: float)
signal collectible_touched(collectible: CollectibleComponent)

func damage(points: float):
	damage_taken.emit(points)


func _on_area_entered(area: Area2D) -> void:
	if area is CollectibleComponent:
		collectible_touched.emit(area)
