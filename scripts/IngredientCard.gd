extends Area2D
class_name IngredientCard

@export var ingredient : Ingredient
var ingredient_name : String

var hand_manager : HandManager
var hovering : bool = false

var initial_position : Vector2
var initial_scale : Vector2
var selected : bool = false

@export var lerp_speed : float = 15

func _ready() -> void:
	hand_manager = get_tree().get_first_node_in_group("hand_manager")
	initial_position = position
	initial_scale = scale

func _process(delta: float) -> void:
	if hovering:
		var _scale = lerp(scale.x, initial_scale.x + 0.1, lerp_speed * delta)
		scale = Vector2(_scale, _scale)
		
		if Input.is_action_just_pressed("left_click"):
			if hand_manager.selected_card != self:
				hand_manager.select_card(self)
			else:
				hand_manager.select_card(null)
				
	else:
		var _scale = lerp(scale.x, initial_scale.x, lerp_speed * delta)
		scale = Vector2(_scale, _scale)
		
	if hand_manager.selected_card == self:
		position.y = lerp(position.y, initial_position.y - 16, lerp_speed * delta)
	else:
		position.y = lerp(position.y, initial_position.y, lerp_speed * delta)

func change_ingredient(_ingredient : Ingredient):
	ingredient = _ingredient
	ingredient_name = ingredient.name

func _on_mouse_entered() -> void:
	hovering = true

func _on_mouse_exited() -> void:
	hovering = false
