extends Node

#preload obstacles
var asd = 10
var ground_scene = preload("res://game_1/obstacle/ground.tscn")
var obstacle_1_scene = preload("res://game_1/obstacle/obstacle_1.tscn")
var obstacle_2_scene = preload("res://game_1/obstacle/obstacle_2.tscn")
var obstacle_3_scene = preload("res://game_1/obstacle/obstacle_3.tscn")
var coin_scene  = preload("res://game_1/coin_1.tscn")
var obstacle_types := [obstacle_1_scene, obstacle_2_scene, obstacle_3_scene]
var obstacles : Array
var coins : Array

#game variables
const PLAYER_START_POS := Vector2i(154, 55)
const CAM_START_POS := Vector2i(576, 324)

var score : int
const SCORE_MODIFIER : int = 100
var speed : float
const START_SPEED : float = 5.0
const MAX_SPEED : int = 25
const SPEED_MODIFIER : int = 2000
var screen_size : Vector2i
var ground_height : int
var last_obs
var obstacle_disctance : int = 150
var game_running : bool
#var coin_counter: int
var coins_collected: int = 0
#var total_score: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_window().size
	$GameOver.get_node("PlayAgain").pressed.connect(new_game)
	new_game()

func new_game():
	#reset variables
	$Score.show()
	score = 0
	obstacle_disctance = 150
	game_running = true
	get_tree().paused = false
	
	#delete all obstacles
	for obs in obstacles:
		obs.queue_free()
	obstacles.clear()
	
	for coin in coins:
		coin.queue_free()
	coins.clear()
	
	#reset the nodes
	$Player.position = PLAYER_START_POS
	$Camera2D.position = CAM_START_POS
	$GameOver.hide()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Background.position.y = $Camera2D.position.y - screen_size.y/2.5
	if game_running:
		obstacle_disctance += 150
		generate_obs()
		show_score()
		if $Player.position.y > 160:
			#speed up and adjust difficulty
			speed = START_SPEED + score / SPEED_MODIFIER
			if speed > MAX_SPEED:
				speed = MAX_SPEED
			
			$Walls.position.y = $Player.position.y
			
			#move camera
			$Camera2D.position.y += speed / 10
			
			if $Player.position.y > $Camera2D.position.y:
				$Camera2D.position.y = $Player.position.y
			
			#update score
			score += speed
			
			#remove obstacles that have gone off screen
			for obs in obstacles:
				if obs.position.y < ($Camera2D.position.y - screen_size.y):
					remove_obs(obs)

			 # Check if the player is out of the screen from the top
			if $Player.position.y < $Camera2D.position.y - screen_size.y/2:
				game_over()
	else:
		if Input.is_action_pressed("ui_accept"):
			game_running = true
			#$HUD.get_node("StartLabel").hide()

func generate_obs():
	#generate ground obstacles
	if obstacles.is_empty() or last_obs.position.y < obstacle_disctance:	
		var obs_type = obstacle_types[randi() % obstacle_types.size()]
		var obs
		obs = obs_type.instantiate()
		var obs_x : int = randi_range(0, 50)
		var obs_y : int = obstacle_disctance + randi_range(10, 50)
		
		if last_obs != null and randi_range(0,2) == 1:
			var coin
			coin = coin_scene.instantiate()
			var coin_x : int = randi_range(10, 1010)
			var coin_y : int = (last_obs.position.y + obs_y)/2
			add_coin(coin, coin_x, coin_y)
		
		last_obs = obs
		add_obs(obs, obs_x, obs_y)

func add_obs(obs, x, y):
	obs.position = Vector2i(x, y)
	add_child(obs)
	obstacles.append(obs)

func remove_obs(obs):
	obs.queue_free()
	obstacles.erase(obs)

func add_coin(coin, x, y):
	coin.position = Vector2i(x, y)
	coin.body_entered.connect(coin._on_body_entered)
	add_child(coin)
	coins.append(coin)

func show_score():
	$Score.get_node("ScoreLabel").text = str(score / SCORE_MODIFIER)

func game_over():
	get_tree().paused = true
	game_running = false
	global.total_coins += coins_collected
	print(global.total_coins)
	$Score.hide()
	$GameOver.get_node("DistanceLabel").text = "Distance: 	" + str(score / SCORE_MODIFIER)
	$GameOver.get_node("CoinsLabel").text = "Coins: 		" + str(coins_collected)
	global.run_score += score / SCORE_MODIFIER / 20
	$GameOver.get_node("ProgressBar").value = global.run_score
	$GameOver.get_node("LevelLabel").text = "Running: Lvl " + str($GameOver.get_node("ProgressBar").value)
	$GameOver.show()
