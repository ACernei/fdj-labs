extends CharacterBody2D

@export var speed = 300
@export var gravity = 30 
@export var jump_force = 300

@onready var ap = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var cshape =$CollisionShape2D
var is_crawling = false

var player_standing = preload("res://colision_shape/player_standing.tres")
var player_crawl = preload("res://colision_shape/player_crawling.tres")
func _physics_process(delta):
	if !is_on_floor():
		velocity.y += gravity
		
	if Input.is_action_just_pressed("jump"): #&& is_on_floor():
		velocity.y = -jump_force
		
	var horizontal_direction = Input.get_axis("move_left", "move_right")
	velocity.x = speed * horizontal_direction
	
	if horizontal_direction != 0:
		switch_direction(horizontal_direction)
	
	if Input.is_action_just_pressed("crawl"):
		crawl()
	elif Input.is_action_just_released("crawl"): 
		stand()
	move_and_slide()
	
	update_animation(horizontal_direction)

func update_animation(horizontal_direction):
	if is_on_floor():
		if horizontal_direction == 0:
			if is_crawling:
				ap.play("crawl")
			else:
				ap.play("idle")
		else:
			if is_crawling:
				ap.play("crawl")
			else:
				ap.play("run")
	else:
		if is_crawling == false:
			if velocity.y < 0:
				ap.play("jump")
			elif velocity.y > 0:
				ap.play("fall")
		else:
			ap.play("crawl")

func switch_direction(horizontal_direction):
	sprite.flip_h = (horizontal_direction == -1)
	sprite.position.x = horizontal_direction

func wait():
	var timer: Timer = Timer.new()
	timer.one_shot = true
	timer.autostart = true
	timer.wait_time = 1
	#timer.start()
	stand()

func crawl():
	if is_crawling:
		return
	is_crawling = true
	cshape.shape = player_crawl
	cshape.position.y = -16
func stand():
	if !is_crawling:
		return
	is_crawling = false
	cshape.shape = player_standing
	cshape.position.y = -40
