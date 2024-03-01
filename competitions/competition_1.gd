extends Node2D
var coin_counter: int
var energy_decrease_timer = 0
var game_running
# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Player/EnergyBar").value = global.duck_energy
	$Finish.body_entered.connect(finish)
	$Victory.hide()
	$Defeat.hide()
	get_tree().paused = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	energy_decrease_timer += 1
	if energy_decrease_timer == 20:
		get_node("Player/EnergyBar").value -= 1
		energy_decrease_timer = 0
		
	if get_node("Player/EnergyBar").value == 0:
		defeat()

func finish(body):
	if body.name == "Player":
		victory()
	else:
		defeat()
		
func victory():
	get_tree().paused = true
	coin_counter += 100
	global.jump_training_available = true
	$Victory.show()

func defeat():
	get_tree().paused = true
	$Defeat.show()
