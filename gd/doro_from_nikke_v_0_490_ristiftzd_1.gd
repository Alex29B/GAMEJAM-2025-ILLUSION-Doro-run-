extends Sprite2D

var texture1 : Texture = preload("res://assets/doro/doro-from-nikke-v0-490ristiftzd1.webp")
var texture2 : Texture = preload("res://assets/doro/doro_mad.webp")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture = texture1
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotate(15)
	rotate(-15)
	
func switch_texture():
	if (texture == texture1):
		texture = texture2
	else:
		texture = texture1

func _on_hardmode_button_pressed() -> void:
	if global.difficulty != 2:
		global.difficulty = 2
	else:
		global.difficulty = 1
	switch_texture()
