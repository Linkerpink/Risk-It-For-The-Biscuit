extends Control

@onready var batch_manager : BatchManager = %"Batch Manager"
@onready var hand_manager : HandManager = %"Hand Manager"

func _on_check_oven_button_pressed() -> void:
	pass # Replace with function body.

func _on_add_ingredient_button_pressed() -> void:
	batch_manager.add_ingredient(hand_manager.selected_card.ingredient)
