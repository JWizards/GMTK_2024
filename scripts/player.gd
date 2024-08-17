extends RigidBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var flag: bool = false

func _physics_process(delta: float) -> void:
	# Handle jump.
	if Input.is_action_pressed("jump"):
		print_debug("Test!")
		if not flag:
			apply_central_impulse(Vector2(0,-600))
			sprite_2d.apply_scale(Vector2(1.25,1.25))
			collision_shape_2d.apply_scale(Vector2(1.25,1.25))
			animation_player.play("big")
			flag = true		
	elif flag:
		sprite_2d.apply_scale(Vector2(0.8,0.8))
		collision_shape_2d.apply_scale(Vector2(0.8,0.8))
		animation_player.play("small")
		flag = false
