extends CharacterBody2D

@export var speed = 400
@export var gravity = 30 
@export var jump_force = 300

@onready var ap = $AnimationPlayer


func _physics_process(delta):
	if !is_on_floor():
		velocity.y += gravity
		
	velocity.x = speed
	
	move_and_slide()
	update_animation()

func update_animation():
	if is_on_floor():
		ap.play("run")
	else:
		ap.play("idle")
