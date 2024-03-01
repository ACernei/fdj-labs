extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("EnergyBar").value = global.duck_energy
	get_node("SpeedBar").value = global.run_score
	get_node("JumpBar").value = global.jump_score
	
	get_node("EnergyLabel").text += str(global.duck_energy)+"/100"
	get_node("SpeedLabel").text += str(global.run_score)+"/100"
	get_node("JumpLabel").text += str(global.jump_score)+"/100"
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
