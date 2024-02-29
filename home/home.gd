extends Node
var running_lvl = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	print("b")
	#$Score.get_node("ScoreLabel").text = get_node("/root/game2").total_score
	print(get_tree())

func _process(delta):
	#running_lvl = get_node("/root/game2").total_score
	$Score.get_node("ScoreLabel").text = "Running Lvl: " + str(running_lvl)
	$Player.position.x = randi_range(100, 500)
	
	print("a")
