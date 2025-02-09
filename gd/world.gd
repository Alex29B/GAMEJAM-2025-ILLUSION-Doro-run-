extends Node

@onready var player = $Player
@onready var enemy = $Doro

# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	get_tree().call_group('enemies', 'update_target_location', player.global_transform.origin)
