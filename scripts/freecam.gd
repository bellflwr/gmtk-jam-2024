extends Camera2D

const CAM_SPEED = 100
const ZOOM_BASE = 4
const MIN_ZOOM = 0.2
const MAX_ZOOM = 5

var scalar_zoom: float = 5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var dir = Input.get_vector("left", "right", "up", "down")
		
	position += dir * delta * CAM_SPEED / (scalar_zoom / MAX_ZOOM)

	var zoom_dir = Input.get_axis("look_down", "look_up")
	
	var new_scalar_zooom = scalar_zoom * pow(ZOOM_BASE, zoom_dir * delta)
	
	scalar_zoom = clamp(new_scalar_zooom, MIN_ZOOM, MAX_ZOOM)
	
	zoom = Vector2.ONE * scalar_zoom
