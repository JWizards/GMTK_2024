extends RigidBody2D


const SPEED = 300.0
const inflation_ratio = 2
const deflation_ratio = 0.5


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
			sprite_2d.apply_scale(Vector2(inflation_ratio,inflation_ratio))
			collision_shape_2d.apply_scale(Vector2(inflation_ratio,inflation_ratio))
			animation_player.play("big")
			flag = true		
	elif flag:
		sprite_2d.apply_scale(Vector2(deflation_ratio,deflation_ratio))
		collision_shape_2d.apply_scale(Vector2(deflation_ratio,deflation_ratio))
		animation_player.play("small")
		flag = false
