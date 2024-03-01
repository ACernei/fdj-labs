extends Node

func _ready():
	#get_node("Trainer").body_entered.connect(train)
	get_node("Battle").body_entered.connect(battle)
	get_node("Shop").body_entered.connect(shop)
	
	get_node("EnergyBar").value = global.duck_energy
	get_node("SpeedBar").value = global.run_score
	get_node("JumpBar").value = global.jump_score
	
	get_node("EnergyLabel").text += str(global.duck_energy)+"/100"
	get_node("SpeedLabel").text += str(global.run_score)+"/100"
	get_node("JumpLabel").text += str(global.jump_score)+"/100"
	print("b")

#func train(body):
	#print($Player.is_interacting)
	#if body.name == "Player" && $Player.is_interacting:
		#$Player.is_interacting = false
		#get_tree().change_scene_to_file("res://trainings/trainings.tscn")

func shop(body):
	if body.name == "Player" && $Player.is_interacting:
		$Player.is_interacting = false
		get_tree().change_scene_to_file("res://shop/shop.tscn")
	
func battle(body):
	if body.name == "Player" && $Player.is_interacting:
		$Player.is_interacting = false
		get_tree().change_scene_to_file("res://competitions/competition_1.tscn")

func _process(delta):
	pass
