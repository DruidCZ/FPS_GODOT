extends Interactable

func _get_interaction_text():
	return "use home"
	
func _interact():
	print("My home")