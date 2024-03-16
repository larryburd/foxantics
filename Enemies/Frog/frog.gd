extends EnemyBase

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var jump_timer = $JumpTimer

const JUMP_VELOCITY: Vector2 = Vector2(100, -150)
const JUMP_WAIT_RANGE: Vector2 = Vector2(2.5, 5.0)

var _jump: bool = false
var _seen_player: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	start_timer()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	super._physics_process(delta)
	
	if !is_on_floor():
		velocity.y += _gravity * delta
	else:
		velocity.x = 0
		animated_sprite_2d.play("idle")
		
	apply_jump()
	move_and_slide()
	flip_direction()

func start_timer() -> void:
	jump_timer.wait_time = randf_range(JUMP_WAIT_RANGE.x, JUMP_WAIT_RANGE.y)
	jump_timer.start()

func apply_jump() -> void:
	if !is_on_floor() or !_seen_player or !_jump:
		return
		
	velocity = JUMP_VELOCITY
	
	if !animated_sprite_2d.flip_h:
		velocity.x = velocity.x * -1
		
	_jump = false
	animated_sprite_2d.play("jump")
	start_timer()
	

func flip_direction() -> void:
	var isXPosGreater = _player_ref.global_position.x > global_position.x 
	
	if (isXPosGreater and !animated_sprite_2d.flip_h):
		animated_sprite_2d.flip_h = true
	elif(!isXPosGreater and animated_sprite_2d.flip_h):
		animated_sprite_2d.flip_h = false

func _on_jump_timer_timeout():
	_jump = true
	
	
func _on_visible_on_screen_notifier_2d_screen_entered():
	_seen_player = true
