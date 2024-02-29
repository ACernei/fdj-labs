extends Node2D

func _ready():
	pass

# Handle collision with the player
func _on_body_entered(body):
	if body.name == "Player":
		# Increment coin counter (assuming coin_counter is defined in a global script)
		get_node("/root/game2").coins_collected += 1
		# Remove the coin from the scene
		get_node("/root/game2").coins.erase(self)
		queue_free()
