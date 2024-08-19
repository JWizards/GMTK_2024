extends Node

# Declare the timer and the interval duration in seconds
@export var interval = 5.0

var timer: Timer

# Called when the node enters the scene tree for the first time
func _ready():
	# Initialize the timer
	timer = Timer.new()
	timer.wait_time = interval
	timer.autostart = true
	timer.one_shot = false
	timer.connect("timeout", Callable(self, "_on_Timer_timeout"))
	add_child(timer)

# Callback function that toggles the sprite's visibility
func _on_Timer_timeout():
	var sprite = $Sprite2D_harmful
	var collider = $CollisionShape2D
	var killzone_collider = $Sprite2D_harmful/Killzone/CollisionShape2D
	sprite.visible = not sprite.visible
	collider.disabled = not collider.disabled
	killzone_collider.disabled = not killzone_collider.disabled
