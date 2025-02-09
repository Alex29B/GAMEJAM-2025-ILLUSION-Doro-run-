extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event):
	if event.is_action_pressed("quit"):
		get_tree().quit()
	if event.is_action_pressed("enter"):
		get_tree().change_scene_to_file("res://tscn/world.tscn")

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://tscn/world.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
