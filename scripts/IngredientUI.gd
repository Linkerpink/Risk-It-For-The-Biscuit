extends Control

@onready var batch_manager : BatchManager = %"Batch Manager"
@onready var hand_manager : HandManager = %"Hand Manager"

func _on_check_oven_button_pressed() -> void:
	batch_manager.start_oven_sequence()

func _on_add_ingredient_button_pressed() -> void:
	batch_manager.add_ingredients()


func _on_make_hand_button_pressed() -> void:
	hand_manager.make_hand()


func _on_continue_button_pressed() -> void:
	batch_manager.start_normal_gameplay()
