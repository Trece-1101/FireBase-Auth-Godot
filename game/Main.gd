extends Control


func _ready() -> void:
	for but in $ButtonContainer.get_children():
		but.connect("pressed", self, "change_menu", [but.go_to_menu])

func change_menu(menu: String) -> void:
	get_tree().change_scene(menu)
