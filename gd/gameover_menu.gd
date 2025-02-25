extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $'AudioStreamPlayer'.playing == false:
		await get_tree().create_timer(1.0).timeout
		$'AudioStreamPlayer'.play()
	pass

func _on_retry_button_pressed() -> void:
	get_tree().change_scene_to_file("res://tscn/world.tscn")
	global.difficulty = 1


func _on_quit_button_pressed() -> void:
	get_tree().quit()
