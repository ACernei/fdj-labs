extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Home").pressed.connect(go_home)
	get_node("CoinsLabel").text = "		Coins: " + str(global.total_coins)
	get_node("BuyFood").pressed.connect(_on_BuyFood_pressed)
	get_node("BuyDuck").pressed.connect(_on_BuyDuck_pressed)
	
func go_home():
	get_tree().call_deferred("change_scene_to_file", "res://home/home.tscn")
	
func _on_BuyFood_pressed():
	# Increase the duck_energy counter by 1
	if global.total_coins - 5 >= 0:
		global.duck_energy += 1
		global.total_coins -= 5

func _on_BuyDuck_pressed():
	# Increase the duck_energy counter by 1
	if global.total_coins - 100 >= 0:
		#global.duck_energy += 1
		global.total_coins -= 100
		
func _process(delta):
	get_node("CoinsLabel").text = "		Coins: " + str(global.total_coins)
