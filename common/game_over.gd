extends CanvasLayer

#func _on_change_game_pressed():
	#get_tree().change_scene_to_file("res://trainings/trainings.tscn")

func _ready():
	#get_node("PlayAgain").pressed.connect(new_game)
	get_node("Home").pressed.connect(go_home)
	get_node("ChangeGame").pressed.connect(change_game)
	
func go_home():
	#get_tree().change_scene_to_packed(house)
	get_tree().call_deferred("change_scene_to_file", "res://home/home.tscn")
	#get_tree().change_scene_to_file.bind("res://home/house.tscn").call_deferred()
	print("Home")
	
func change_game():
	get_tree().change_scene_to_file("res://trainings/trainings.tscn")
