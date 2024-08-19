extends Camera2D

# Assign the player node path
@export var player_path: NodePath
@export var level_path_list: Array[String]
@export var level_chance_weight_list: Array[String]

@onready var player = get_node(player_path)

var level_list: Array[LevelData] = []
var cur_level_path: String
var currently_loaded_levels: Array[Node] = []

class LevelData:
	var path: String
	var weight: float

	func _init(_path: String, _weight: float):
		path = _path
		weight = _weight


func _ready() -> void:
	for i in range(len(level_path_list)):
		var weight = 1 if i >= len(level_chance_weight_list) else level_chance_weight_list[i]
		level_list.append(LevelData.new(level_path_list[i], weight))
	cur_level_path = level_list[0].path


func choose_random_level() -> String:
	return level_list[randi() % len(level_list)].path

func unload_level() -> void:
	var level = currently_loaded_levels.pop_front()
	level.queue_free()

func load_level(level_path) -> void:
	var scene = load(level_path)
	if scene:
		# Instance the scene
		var instance = scene.instance()
		# Add it to the current scene tree
		add_child(instance)
		currently_loaded_levels.push_back(instance)
	else:
		push_error("Failed to load level: " + level_path)

func _physics_process(delta):
	pass
