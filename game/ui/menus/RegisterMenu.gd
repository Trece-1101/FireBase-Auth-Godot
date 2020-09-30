extends Menu

onready var http_request := $HTTPRequest
onready var user_name := $Container/UserContainer/DataInput
onready var password := $Container/PassContainer/DataInput
onready var confirm := $Container/ConfirmContainer/DataInput
onready var noti := $Notification

func _on_HTTPRequest_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray) -> void:
	var response_body := JSON.parse(body.get_string_from_ascii())
	noti.visible = true
	if response_code != 200:
		noti.text = response_body.result.error.message.capitalize()
	else:
		noti.text = "Exito"
		yield(get_tree().create_timer(2.5), "timeout")
		self.change_menu("res://game/ui/menus/LoginMenu.tscn")


func _on_OK_pressed() -> void:
	noti.visible = true
	
	if password.text.empty() or user_name.text.empty():
		noti.text = "Usuario y Contraseña no pueden estar vacios"
		return
	
	if password.text != confirm.text:
		noti.text = "No coincide contraseña con confirmacion"
		return
	
	Firebase.register(user_name.text, password.text, http_request)
