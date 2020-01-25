extends Node

class_name Weapon

#Weapon variables
export var fire_rate = 0.5
export var clip_size = 5
export var reload_rate = 1
export var fire_range = 1000 

var current_ammo = 0
var can_fire = true
var reloading = false

onready var raycast = $"../Head/Camera/WeaponRayCast"
func _ready():
	raycast.cast_to = Vector3(0,0, -fire_range)
	current_ammo = clip_size

func _process(delta):
	if Input.is_action_just_pressed("primary_fire") and can_fire:
		#fire weapon
		if current_ammo > 0 and not reloading:
			_fire()
		elif not reloading:
			_reload()

	#Reload
	if Input.is_action_just_pressed("reload") and not reloading:
		_reload()
		
#Check collision
func _check_collision():
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider.is_in_group("Enemies"):
			collider.queue_free()
			print("Killed " + collider.name) 
func _fire():
		print("Fired weapon("+String(current_ammo)+")")
		can_fire = false
		current_ammo -= 1
		_check_collision()
		yield(get_tree().create_timer(fire_rate),"timeout")
		can_fire = true

func _reload():
	#reloading
	print("Reloading")
	reloading = true
	yield(get_tree().create_timer(reload_rate), "timeout")
	current_ammo = clip_size
	print("Reload done")
	reloading = false