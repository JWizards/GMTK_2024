extends RigidBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _physics_process(delta: float) -> void:
	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		apply_central_impulse(Vector2(0,-600))
		print_debug("Test!")
		sprite_2d.apply_scale(Vector2(1.1,1.1))
		collision_shape_2d.apply_scale(Vector2(1.1,1.1))
		animation_player.play("big")
		
