extends Node2D
var coin_counter: int

# Called when the node enters the scene tree for the first time.
func _ready():
	$Finish.body_entered.connect(finish)
	$Victory.hide()
	$Defeat.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func finish(body):
	if body.name == "Player":
		victory()
	else:
		defeat()
		
func victory():
	get_tree().paused = true
	coin_counter += 100
	$Victory.show()

func defeat():
	get_tree().paused = true
	$Defeat.show()
