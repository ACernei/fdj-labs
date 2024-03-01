extends Node2D

func _ready():
	get_node("Home").pressed.connect(go_home)
	get_node("Run").pressed.connect(train_running)
	get_node("Jump").pressed.connect(train_jumping)
	$Jump.hide()
	
func go_home():
	get_tree().call_deferred("change_scene_to_file", "res://home/home.tscn")
	
func train_running():
	get_tree().change_scene_to_file("res://game_1/game_1.tscn")

func train_jumping():
	get_tree().change_scene_to_file("res://game_2/game_2.tscn")
	

func _process(delta):
	if global.jump_training_available:
		$Jump.show()
