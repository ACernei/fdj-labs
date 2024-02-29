extends CharacterBody2D

@export var speed = 1000
@export var gravity = 30
@export var jump_force_2 = 700
@export var jump_force_3= 825
@export var jump_force_4 = 950

@onready var ap = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var cshape =$CollisionShape2D

var is_crawling = false

var player_standing = preload("res://colision_shape/player_standing.tres")
var player_crawl = preload("res://colision_shape/player_crawling.tres")

func _physics_process(delta):
	if !is_on_floor():
		velocity.y += gravity
		
	if Input.is_action_just_pressed("jump2") && is_on_floor():
		velocity.y = -jump_force_2
	if Input.is_action_just_pressed("jump3") && is_on_floor():
		velocity.y = -jump_force_3
	if Input.is_action_just_pressed("jump4") && is_on_floor():
		velocity.y = -jump_force_4
	
	if Input.is_action_just_pressed("crawl"):
		crawl()
	elif Input.is_action_just_released("crawl"): 
		stand()
	
	#var horizontal_direction = Input.get_axis("move_left", "move_right")
	#velocity.x = speed * horizontal_direction
	#
	#if horizontal_direction != 0:
		#switch_direction(horizontal_direction)
	
	move_and_slide()
	
	update_animation()

func update_animation():
	if is_on_floor():
		#if horizontal_direction == 0:
			#ap.play("idle")
		#else:
		if is_crawling:
			ap.play("crawl")
		else:
			ap.play("run")
	elif Input.is_action_just_pressed("crawl") && is_on_floor():
		ap.play("crawl")
	else:
		if velocity.y < 0:
			ap.play("jump")
		elif velocity.y > 0:
			ap.play("fall")

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
	
#func switch_direction(horizontal_direction):
	#sprite.flip_h = (horizontal_direction == -1)
	#sprite.position.x = horizontal_direction
