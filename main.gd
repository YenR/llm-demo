extends Control

@export var model_name: String = "google/gemma-3-4b"

@onready var http_request = $HTTPRequest
@onready var btn = $FetchButton
@onready var label = $FortuneLabel

func _ready():
	btn.pressed.connect(_on_button_pressed)
	http_request.request_completed.connect(_on_request_completed)


func _on_button_pressed():
	label.text = "Loading..."
	var url = "http://127.0.0.1:1234/v1/completions"
	var headers = ["Content-Type: application/json"]
	var body = {
		"model": model_name,
		"prompt": "Give me a random fortune cookie wisdom.",
		"temperature": 0.7,
		"max_tokens": 50
	}
	
	var json_body = JSON.stringify(body)
	var err = http_request.request(url, headers, HTTPClient.METHOD_POST, json_body)
	if err != OK:
		label.text = "Failed to send request: %s" % err


func _on_request_completed(_result, response_code, _headers, body_bytes):
	if response_code != 200:
		label.text = "Server error: %d" % response_code
		return
		
	var body_text = body_bytes.get_string_from_utf8()
	var json = JSON.new()  
	var err = json.parse(body_text)
	
	if err != OK:
		label.text = "JSON error: %s" % json.get_error_message()
		return
	
	var root = json.get_data()
	if not root.has("choices"):
		label.text = "No choices key in response."
		return
	
	var choices = root["choices"]
	if typeof(choices) == TYPE_ARRAY and choices.size() > 0:
		var text = choices[0].get("text", "")
		label.autowrap_mode = true
		label.size_flags_horizontal = Control.SIZE_FILL  
		label.text = text.strip_edges()
	else:
		label.text = "No text returned."
