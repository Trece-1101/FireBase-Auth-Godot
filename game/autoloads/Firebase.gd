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
	LOGIN_URL = "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key={key}".format({"key": API_KEY})

func get_token_id_from_result(result: Array, debug := false) -> String:
	var result_body := JSON.parse(result[3].get_string_from_ascii()).result as Dictionary
	if debug:
		print(result_body)
	
	return result_body.idToken

func request(data: Dictionary, request_to: String, http: HTTPRequest) -> void:
	var body := data
	
	http.request(request_to, [], false, HTTPClient.METHOD_POST, to_json(body))
	var result := yield(http, "request_completed") as Array
	if result[1] == 200:
		current_token = get_token_id_from_result(result)


func register(email: String, password: String, http: HTTPRequest) -> void:
	var body := {
		"email": email,
		"password": password
	}
	request(body, REGISTER_URL, http)


func login(email: String, password: String, http: HTTPRequest) -> void:
	var body := {
		"email": email,
		"password": password
	}
	
	request(body, LOGIN_URL, http)

