extends Node

# Va como var para evitar exponer mi api key en un repo publico
# hay que colocar a mano una api key y borrar antes de un commit
# tough life
var API_KEY := ""
var REGISTER_URL: String
var LOGIN_URL: String

var current_token := ""

func _ready() -> void:
	REGISTER_URL = "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key={key}".format({"key": API_KEY})
	LOGIN_URL = ""

func get_token_id_from_result(result: Array) -> String:
	var result_body := JSON.parse(result[3].get_string_from_ascii()).result as Dictionary
	print(result_body)
	
	return result_body.idToken
