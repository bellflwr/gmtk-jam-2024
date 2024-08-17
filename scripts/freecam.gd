extends Camera2D


const CAM_SPEED = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var dir = Vector2()
	
	if Input.is_action_pressed("up"):
		dir += Vector2.UP
	if Input.is_action_pressed("down"):
		dir += Vector2.DOWN
	if Input.is_action_pressed("left"):
		dir += Vector2.LEFT
	if Input.is_action_pressed("right"):
		dir += Vector2.RIGHT
		
	position += dir.normalized() * delta * CAM_SPEED
