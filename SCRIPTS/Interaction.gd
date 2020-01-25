extends RayCast

#Variables
var current_collider
var loadui = load("res://UI/UI.tscn/UI/interaction_text")
var interaction_label  = loadui.instance()

func _ready():
	add_child(interaction_label)
	_set_interaction_text("")

# warning-ignore:unused_argument
func _process(delta):
	var collider = get_collider()
	if is_colliding() and collider is Interactable:
		if current_collider != collider:
			_set_interaction_text(collider._get_interaction_text())
			current_collider = collider
            
	if Input.is_action_just_pressed("interact"):
		collider._interact()
		_set_interaction_text(collider._get_interaction_text())
	elif current_collider:
		current_collider = null
		_set_interaction_text("") 

func _set_interaction_text(text):
	if !text:
		interaction_label.set_text("")
		interaction_label.set_visible(false)
	else:
		var interact_key = OS.get_scancode_string(InputMap.get_action_list("interact")[0].scancode)
		interaction_label.set_text("Press %s to %s" %[interact_key,text])
		interaction_label.set_visible(true)