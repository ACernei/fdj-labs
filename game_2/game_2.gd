extends Node

#preload obstacles
var ground_scene = preload("res://game_2/obstacle/ground.tscn")
var obstacle_1_scene = preload("res://game_2/obstacle/obstacle_1.tscn")
var obstacle_2_scene = preload("res://game_2/obstacle/obstacle_2.tscn")
var obstacle_3_scene = preload("res://game_2/obstacle/obstacle_3.tscn")
var obstacle_4_scene = preload("res://game_2/obstacle/obstacle_4.tscn")
var obstacle_5_scene = preload("res://game_2/obstacle/obstacle_5.tscn")
var obstacle_6_scene = preload("res://game_2/obstacle/obstacle_6.tscn")
var obstacle_types := [obstacle_1_scene, obstacle_2_scene, obstacle_3_scene, obstacle_4_scene, obstacle_5_scene, obstacle_6_scene]
var obstacles : Array

var coin_scene  = preload("res://game_2/coin_2.tscn")
var coins : Array

#game variables
const PLAYER_START_POS := Vector2i(300, 500)
const CAM_START_POS := Vector2i(576, 324)

var score : int
const SCORE_MODIFIER : int = 100
var speed : float
const START_SPEED : float = 20
const MAX_SPEED : int = 50
const SPEED_MODIFIER : int = 5000
var screen_size : Vector2i
var ground_height : int = 50
var last_obs
var obstacle_disctance : int = 0
var game_running : bool
var coin_counter: int
var coins_collected: int = 0
var total_score: int = 0

var difficulty
const MAX_DIFFICULTY : int = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_window().size
	$GameOver.get_node("PlayAgain").pressed.connect(new_game)
	new_game()

func new_game():
	#reset variables
	$Score.show()
	score = 0
	coins_collected = 0
	difficulty = 0
	obstacle_disctance = 0
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
	$Ground.position = Vector2i(0, 0)
	$GameOver.hide()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Background.position.x = $Camera2D.position.x - screen_size.x/2.5
	if game_running:
		obstacle_disctance += 700
		adjust_difficulty()
		generate_obs()
		show_score()
		
		#speed up and adjust difficulty
		speed = START_SPEED + score / SPEED_MODIFIER
		if speed > MAX_SPEED:
			speed = MAX_SPEED
		
		#move camera and player
		$Player.position.x += speed/10
		$Camera2D.position.x += speed/10
		$Ground.position.x += speed/10
		
		#update score
		score += speed
		
		#remove obstacles that have gone off screen
		for obs in obstacles:
			if obs.position.x < ($Camera2D.position.x - screen_size.x/2):
				remove_obs(obs)
	else:
		if Input.is_action_pressed("ui_accept"):
			game_running = true
			#$HUD.get_node("StartLabel").hide()

func generate_obs():
	#generate ground obstacles
	if obstacles.is_empty() or last_obs.position.x < obstacle_disctance + randi_range(300, 500):
		var obs_type = obstacle_types[randi() % obstacle_types.size()]
		var obs
		var max_obs = difficulty + 1
		for i in range(randi() % max_obs + 1):
			obs = obs_type.instantiate()
			var obs_x : int = obstacle_disctance + randi_range(100, 333)
			var obs_y : int = ground_height -75
		
			if last_obs != null and randi_range(0,1) == 1:
				var coin
				coin = coin_scene.instantiate()
				var coin_x : int = (last_obs.position.x + obs_x)/2 + randi_range(-200, 200)
				var coin_y : int = ground_height+450 - randi_range(0, 300)
				add_coin(coin, coin_x, coin_y)
			
			last_obs = obs
			add_obs(obs, obs_x, obs_y)

func add_obs(obs, x, y):
	obs.position = Vector2i(x, y)
	obs.body_entered.connect(hit_obs)
	add_child(obs)
	obstacles.append(obs)

func remove_obs(obs):
	obs.queue_free()
	obstacles.erase(obs)

func hit_obs(body):
	if body.name == "Player":
		game_over()

func add_coin(coin, x, y):
	coin.position = Vector2i(x, y)
	coin.body_entered.connect(coin._on_body_entered)
	add_child(coin)
	coins.append(coin)

func show_score():
	$Score.get_node("ScoreLabel").text = str(score / SCORE_MODIFIER)

func adjust_difficulty():
	difficulty = score / SPEED_MODIFIER / 5
	if difficulty > MAX_DIFFICULTY:
		difficulty = MAX_DIFFICULTY
	print(difficulty)

func game_over():
	get_tree().paused = true
	game_running = false
	global.total_coins += coins_collected
	$Score.hide()
	$GameOver.get_node("RichTextLabel").text = "	Jumping Training Complete"
	$GameOver.get_node("DistanceLabel").text = "Distance: 	" + str(score / SCORE_MODIFIER)
	$GameOver.get_node("CoinsLabel").text = "Coins: 		" + str(coins_collected)
	global.jump_score += score / SCORE_MODIFIER / 20
	$GameOver.get_node("ProgressBar").value = global.jump_score
	$GameOver.get_node("LevelLabel").text = "Jumping: Lvl " + str($GameOver.get_node("ProgressBar").value)
	
	$GameOver.show()
