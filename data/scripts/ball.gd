extends Spatial

export var acceleration = 15.0
export var jump_velocity = 2.0
export var camera_distance = 7.5
export var camera_up = 2.5

var play_landing_sound = false

var body_node
var ray_node
var camera_node
var yaw_node
var spatial_sample_player_node

var global

func _ready():
	body_node = get_node("RigidBody")
	ray_node = get_node("RayCast")
	camera_node = get_node("Yaw/Camera")
	yaw_node = get_node("Yaw")
	spatial_sample_player_node = get_node("SpatialSamplePlayer")
	global = get_node("/root/Global")
	set_process_input(true)
	set_fixed_process(true)
	
func _input(event):
	if Input.is_action_pressed("quit_game"):
		global.go_to_main_menu()

func _fixed_process(delta):
	# Move camera, sample player and ray with the ball (but don't rotate them)
	camera_node.set_translation(Vector3(body_node.get_translation().x, body_node.get_translation().y + camera_up, body_node.get_translation().z + camera_distance))
	ray_node.set_translation(Vector3(body_node.get_translation().x, body_node.get_translation().y, body_node.get_translation().z))
	spatial_sample_player_node.set_translation(Vector3(body_node.get_translation().x, body_node.get_translation().y, body_node.get_translation().z))

	# Handle input
	if Input.is_action_pressed("move_forwards"):
		body_node.set_linear_velocity(Vector3(body_node.get_linear_velocity().x, body_node.get_linear_velocity().y, body_node.get_linear_velocity().z - acceleration * delta))

	if Input.is_action_pressed("move_backwards"):
		body_node.set_linear_velocity(Vector3(body_node.get_linear_velocity().x, body_node.get_linear_velocity().y, body_node.get_linear_velocity().z + acceleration * delta))

	if Input.is_action_pressed("move_left"):
		body_node.set_linear_velocity(Vector3(body_node.get_linear_velocity().x - acceleration * delta, body_node.get_linear_velocity().y, body_node.get_linear_velocity().z))

	if Input.is_action_pressed("move_right"):
		body_node.set_linear_velocity(Vector3(body_node.get_linear_velocity().x + acceleration * delta, body_node.get_linear_velocity().y, body_node.get_linear_velocity().z))

	if Input.is_action_pressed("jump") and ray_node.is_colliding():
		body_node.set_linear_velocity(Vector3(body_node.get_linear_velocity().x, body_node.get_linear_velocity().y + jump_velocity, body_node.get_linear_velocity().z))
		play_landing_sound = true

	# Landing sound
	if ray_node.is_colliding() and play_landing_sound:
		get_node("SpatialSamplePlayer").play("land")
		play_landing_sound = false