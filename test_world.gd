extends Node2D
var spawn_position = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	var player = preload("res://Scenes/player_bot.tscn").instantiate()
	player.position = spawn_position
	add_child(player)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
