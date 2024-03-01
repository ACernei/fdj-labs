extends CanvasLayer

func _ready():
	get_node("Home").pressed.connect(go_home)
	
func go_home():
	get_tree().call_deferred("change_scene_to_file", "res://home/home.tscn")

func _process(delta):
	pass
