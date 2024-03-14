extends CharacterBody2D

class_name Player

@onready var sprite_2d = $Sprite2D
@onready var animation_player = $AnimationPlayer

const GRAVITY: float = 1000.0

func _ready():
	pass
	

func _physics_process(delta):
	if is_on_floor() == false:
		velocity.y += GRAVITY * delta
	
	move_and_slide()
