extends Interactable

export var light : NodePath
export var on_by_default = true
export var energy_on = 1
export var energy_off = 0

onready var light_node = get_node(light)
onready var on = on_by_default

func _ready():
	_set_light_energy()

func _get_interaction_text():
	return "Switch light OFF" if energy_on else "Switch light ON"

func _interact():
	on = !on
	_set_light_energy()
	
func _set_light_energy():
	light_node.set_param(Light.PARAM_ENERGY, energy_on if on else energy_off)
	