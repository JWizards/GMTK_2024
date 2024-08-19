extends Camera2D

# Assign the player node path
@export var player_path: NodePath
@export var offset_y: float
@export var interp_speed: float = 8.0  # Adjust this value to control the speed of the interpolation

@onready var player = get_node(player_path)

func _ready() -> void:
	make_current()

func _physics_process(delta):
	if player:
		var target_y = player.position.y + offset_y
		position.y = lerp(position.y, target_y, interp_speed * delta)
