extends Node2D
var spawn_position = Vector2.ZERO

@onready var materials = $materials

# Called when the node enters the scene tree for the first time.
func _ready():
	var player = preload("res://Scenes/player_bot.tscn").instantiate()
	player.position = spawn_position
	add_child(player)
	
	var iron = materials.get_children()
	for material in iron:
		material.Collected.connect(_on_collected)
		
		
	for i in randi(10):
		var pos = (randi(100),randi(100))
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_collected():
	print("collected")
