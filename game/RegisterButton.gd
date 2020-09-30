class_name GoButton
extends Button

export var go_to_menu := ""


func _on_RegisterButton_pressed(extra_arg_0: String) -> void:
	print(extra_arg_0)

func change_menu(menu: String) -> void:
	get_tree().change_scene(menu)
