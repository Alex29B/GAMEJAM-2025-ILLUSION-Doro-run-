extends Sprite2D

var texture1 : Texture = preload("res://assets/doro/doro-from-nikke-v0-490ristiftzd1.png")
var texture2 : Texture = preload("res://assets/doro/doro_mad.png")
var is_rotate = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture = texture1
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (is_rotate):
		rotate(0.05)
	
func switch_texture():
	if (texture == texture1):
		texture = texture2
	else:
		texture = texture1

func _on_hardmode_button_pressed() -> void:
	if global.difficulty != 2:
		global.difficulty = 2
		is_rotate = true
	else:
		global.difficulty = 1
		is_rotate = false
		rotation = 0
	switch_texture()
