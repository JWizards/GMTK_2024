extends RigidBody2D


const SPEED = 300.0
const inflation_ratio = 2
const deflation_ratio = 0.5
const jump_force = 600

var inflated_physics = PhysicsMaterial.new()

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var coyote_timer: Timer = $CoyoteTimer

var inflated: bool = false
var is_dead: bool = false
var can_die: bool = true

func die() -> bool:
	if is_dead or not can_die:
		return false  # death unsuccessful - already dead
	is_dead = true
	if inflated:
		deflate()
	return true

func deflate() -> void:
	set_physics_material_override(null)
	sprite_2d.apply_scale(Vector2(deflation_ratio,deflation_ratio))
	collision_shape_2d.apply_scale(Vector2(deflation_ratio,deflation_ratio))
	animation_player.play("small")
	inflated = false

func _init() -> void:
	can_sleep = false
	contact_monitor = true
	max_contacts_reported = 5    
	inflated_physics.set_bounce(1)

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if is_dead:
		return
	# Handle jump.
	if Input.is_action_pressed("jump"):
		if not inflated:
			print_debug("coyote start")
			coyote_timer.start()
			can_die = false
			var number_contacts = get_contact_count();
			var jump_direction = Vector2()
			for i in number_contacts:
				jump_direction += state.get_contact_local_normal(i)
			jump_direction = jump_direction.normalized()
			apply_central_impulse(jump_force*jump_direction)

			set_physics_material_override(inflated_physics)
			sprite_2d.apply_scale(Vector2(inflation_ratio,inflation_ratio))
			collision_shape_2d.apply_scale(Vector2(inflation_ratio,inflation_ratio))
			animation_player.play("big")
			inflated = true
	elif inflated:
		deflate()


func _on_coyote_timer_timeout() -> void:
	print_debug("coyote worked")
	can_die = true
