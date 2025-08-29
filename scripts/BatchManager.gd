extends Node2D
class_name BatchManager

var batch_biscuit_value : int = 0
var batch_burn_value : float = 0

@onready var biscuit_value_text : RichTextLabel = $"../CanvasLayer/Ingredient UI/MarginContainer/VBoxContainer/Biscuit Value Text"
@onready var burn_value_text : RichTextLabel = $"../CanvasLayer/Ingredient UI/MarginContainer/VBoxContainer/Burn Value Text"

var ingredients : Array[Ingredient] = []

func _ready() -> void:
	_change_biscuit_value_text()
	_change_burn_value_text()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("debug_toggle_biscuit_text"):
		biscuit_value_text.show()
	
func add_ingredient(_ingredient : Ingredient):
	ingredients.insert(ingredients.size(), _ingredient)
	change_batch_biscuit_value(_ingredient.biscuit_value)
	change_batch_burn_value(_ingredient.burn_value)

#region Biscuits
func change_batch_biscuit_value(_amount : int):
	batch_biscuit_value += _amount
	
	if (batch_burn_value > 100):
		batch_burn_value = 100
		
	if (batch_burn_value < 0):
		batch_burn_value = 0
	
	_change_biscuit_value_text()

func _change_biscuit_value_text():
	biscuit_value_text.text = "Biscuit Value: " + _biscuit_text_effects() + str(batch_biscuit_value)
	print(_biscuit_text_effects())

func _biscuit_text_effects():
	var _text = ""
	
	if batch_biscuit_value <= 50:
		_text = "[font_size={16}]"
	
	if batch_biscuit_value > 50 and batch_biscuit_value <= 150:
		_text = "[font_size={18}][shake]"

	if batch_biscuit_value > 150 and batch_biscuit_value <= 500:
		_text = "[font_size={20}][shake][rainbow]"
		
	if batch_biscuit_value > 500 and batch_biscuit_value <= 750:
		_text = "[font_size={22}][shake][rainbow]"
	
	if batch_biscuit_value > 750 and batch_biscuit_value <= 1000:
		_text = "[font_size={24}][shake][rainbow]"
		
	if batch_biscuit_value > 750:
		_text = "[font_size={28}][shake][rainbow]"
	
	return _text
#endregion

#region Burn
func change_batch_burn_value(_amount : float):
	batch_burn_value += _amount
	
	if (batch_burn_value > 100):
		batch_burn_value = 100
		
	if (batch_burn_value < 0):
		batch_burn_value = 0
	
	_change_burn_value_text()

func _change_burn_value_text():
	burn_value_text.text = "Burn Value: " + _burn_text_effects() + str(batch_burn_value) + "%"
	print(_burn_text_effects())

func _burn_text_effects():
	var _text = ""
	
	if batch_burn_value <= 15:
		_text = "[color=green]"
	
	if batch_burn_value > 15 and batch_burn_value <= 30:
		_text = "[color=orange]"

	if batch_burn_value > 30 and batch_burn_value <= 45:
		_text = "[color=red]"
		
	if batch_burn_value > 45:
		_text = "[color=red][shake]"
	
	return _text
#endregion
