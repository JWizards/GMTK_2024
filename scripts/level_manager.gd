extends Node

# Assign the player node path
@export var player_path: NodePath
@export var level_path_list: Array[String]
@export var level_chance_weight_list: Array[float]

@onready var player = get_node(player_path)

var currently_loaded_levels: Array[Node] = []
var last_level_y: float = -1800
@export var level_height: float = 1800
@export var num_loaded_levels: int = 5

var rng = RandomNumberGenerator.new()


func _ready() -> void:	
	# Load `num_loaded_levels` levels initially
	load_level(level_path_list[0])
	while len(currently_loaded_levels) < num_loaded_levels:
		var new_level_path = choose_random_level()
		load_level(new_level_path)


func weighted_random_index(weights: Array) -> int:
	var total_weight = 0
	for weight in weights:
		total_weight += weight

	var random_weight = randi_range(0, total_weight - 1)
	var index = 0

	for weight in weights:
		random_weight -= weight
		if random_weight <= 0:
			return index
		index += 1

	# In case of rounding errors, return the last index
	return index - 1

func choose_random_level() -> String:
	var index = weighted_random_index(level_chance_weight_list)
	return level_path_list[index]

func unload_level() -> void:
	var level = currently_loaded_levels.pop_front()
	level.queue_free()

func load_level(level_path) -> void:
	var scene: PackedScene = load(level_path)
	if scene:
		# Instance the scene
		var instance = scene.instantiate()
		# Add it to the current scene tree
		add_child(instance)
		
		currently_loaded_levels.push_back(instance)
		last_level_y += level_height
		instance.global_position = Vector2(0, 0)
		instance.position.y = last_level_y
	else:
		push_error("Failed to load level: " + level_path)

func _process(delta):
	var cur_level_instance = currently_loaded_levels[0]
	if player.position.y > cur_level_instance.position.y + 3600:
		unload_level()
		var new_level_path = choose_random_level()
		load_level(new_level_path)
