extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	print("b")
	get_node("Home").pressed.connect(go_home)
	get_node("Run").pressed.connect(train_running)
	get_node("Jump").pressed.connect(train_jumping)
	#get_node("Home").pressed.connect(go_home)
	#get_node("Home").pressed.connect(go_home)
	

func go_home():
	get_tree().call_deferred("change_scene_to_file", "res://home/home.tscn")
	
func train_running():
	get_tree().change_scene_to_file("res://game_1/game_1.tscn")

func train_jumping():
	get_tree().change_scene_to_file("res://game_2/game_2.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


#func _on_run_pressed():
	#get_tree().change_scene_to_file("res://game_1/game_1.tscn")
