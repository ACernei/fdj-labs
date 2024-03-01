extends CharacterBody2D

@export var speed = global.run_score * 5
@export var gravity = 30 
@export var jump_force = global.jump_score

@onready var ap = $AnimationPlayer


func _physics_process(delta):
	if !is_on_floor():
		velocity.y += gravity
		
	velocity.x = speed
	
	move_and_slide()
	update_animation()
	#print(global.nr_of_coins)

func update_animation():
	if is_on_floor():
		ap.play("run")
	else:
		ap.play("idle")
