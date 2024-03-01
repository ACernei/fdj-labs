extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("CoinsLabel").text = "		Coins: " + str(global.total_coins)
	get_node("BuyFood").pressed.connect(_on_BuyFood_pressed)
	
func _on_BuyFood_pressed():
	# Increase the duck_energy counter by 1
	if global.total_coins - 5 > 0:
		global.duck_energy += 1
		global.total_coins -= 5
		
func _process(delta):
	pass
