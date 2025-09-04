extends Node2D
class_name BatchManager

var batch_biscuit_value : int = 0
var batch_burn_value : float = 0

@onready var main_ui : Control = $"../CanvasLayer/Ingredient UI/MarginContainer/Main UI"
@onready var oven_sequence_ui : Control = $"../CanvasLayer/Ingredient UI/MarginContainer/Oven Sequence UI"
@onready var game_over_ui : Control = $"../CanvasLayer/Ingredient UI/MarginContainer/Game Over UI"

@onready var biscuit_value_text : RichTextLabel = $"../CanvasLayer/Ingredient UI/MarginContainer/Oven Sequence UI/VBoxContainer/Biscuit Value Text"
@onready var burn_value_text_main : RichTextLabel = $"../CanvasLayer/Ingredient UI/MarginContainer/Main UI/VBoxContainer/Burn Value Text"
@onready var burn_value_text_oven : RichTextLabel = $"../CanvasLayer/Ingredient UI/MarginContainer/Oven Sequence UI/VBoxContainer/Burn Value Text"
@onready var reason_for_death_text : RichTextLabel = $"../CanvasLayer/Ingredient UI/MarginContainer/Game Over UI/VBoxContainer/Reason For Death Text"

@onready var quota_manager = %QuotaManager

var hand_manager : HandManager

var ingredients : Array[Ingredient] = []

func _ready() -> void:
	hand_manager = get_tree().get_first_node_in_group("hand_manager")
	
	_change_biscuit_value_text()
	_change_burn_value_text_main()
	
	main_ui.show()
	oven_sequence_ui.hide()
	game_over_ui.hide()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("debug_restart_scene"):
		get_tree().reload_current_scene()
	
func add_ingredients():
	for i : IngredientCard in hand_manager.selected_cards:
		hand_manager.remove_card(i)
		
		var _ingredient = i.get_ingredient()
		ingredients.insert(ingredients.size(), _ingredient)
		change_batch_biscuit_value(_ingredient.biscuit_value)
		change_batch_burn_value(_ingredient.burn_value)
		
	ingredients.clear()
	hand_manager.selected_cards.clear()

func start_oven_sequence():
	hand_manager.destroy_hand()
	_change_burn_value_text_oven()
	_calculate_oven()

func start_new_round():
	main_ui.show()
	oven_sequence_ui.hide()
	quota_manager._on_nextround_pressed()
	_reset_batch()
	hand_manager.make_hand()
	
func _reset_batch():
	batch_biscuit_value = 0
	batch_burn_value = 0
	_change_burn_value_text_main()
	
func _calculate_oven():
	if batch_biscuit_value >= quota_manager.current_quota:
		print("reached quota")
		
		var _rnd = randi_range(0,99)
		
		print(_rnd)
		
		if _rnd < batch_burn_value:
			_death_sequence("Batch got burned...")
		else:
			oven_sequence_ui.show()
			main_ui.hide()
	else:
		print("didn't reach quota")
		_death_sequence("Didn't reach quota...")

func _death_sequence(_reason_for_death : String):
	oven_sequence_ui.hide()
	main_ui.hide()
	game_over_ui.show()
	var _effects : String = "[wave]"
	reason_for_death_text.text = _effects + _reason_for_death

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
	
	_change_burn_value_text_main()

func _change_burn_value_text_main():
	burn_value_text_main.text = "Burn Value: " + _burn_text_effects() + str(batch_burn_value) + "%"

func _change_burn_value_text_oven():
	burn_value_text_oven.text = "Burn Value: " + _burn_text_effects() + str(batch_burn_value) + "%"

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

func _on_make_hand_timer_timeout() -> void:
	hand_manager.make_hand()
