extends Area2D
class_name IngredientCard

@onready var deck = %Deck

@export var ingredient : Ingredient
var ingredient_name : String

var hand_manager : HandManager
var hovering : bool = false

var selected : bool = false

@export var lerp_speed : float = 15

@export var spawn_animation_length = 0.25
var spawn_animation_completed = false
@onready var spawn_timer = $"Spawn Timer"
var target_position : Vector2
var target_scale : Vector2 = Vector2(1,1)

func _ready() -> void:
	position = get_viewport_rect().size * 0.5
	hand_manager = get_tree().get_first_node_in_group("hand_manager")
	spawn_timer.wait_time = spawn_animation_length

func _process(delta: float) -> void:
	if not spawn_animation_completed:
		_spawn_animation()
		
	if hovering:
		var _scale = lerp(scale.x, target_scale.x + 0.1, lerp_speed * delta)
		scale = Vector2(_scale, _scale)
		
		if Input.is_action_just_pressed("left_click"):
			if not selected:
				hand_manager.select_card(self)
				selected = true
			else:
				hand_manager.unselect_card(self)
				selected = false
	else:
		var _scale = lerp(scale.x, target_scale.x, lerp_speed * delta)
		scale = Vector2(_scale, _scale)
		
	if selected:
		position.y = lerp(position.y, target_position.y - 16, lerp_speed * delta)
	else:
		position.y = lerp(position.y, target_position.y, lerp_speed * delta)

func change_ingredient(_ingredient : Ingredient):
	ingredient = _ingredient
	ingredient_name = ingredient.name

func _on_mouse_entered() -> void:
	hovering = true

func _on_mouse_exited() -> void:
	hovering = false

func get_ingredient():
	return ingredient

func _spawn_animation():
	var _tween = create_tween()
	_tween.set_ease(Tween.EASE_IN_OUT)
	_tween.tween_property(self, "position", target_position, spawn_animation_length)
	_tween.play()

func _on_spawn_timer_timeout() -> void:
	spawn_animation_completed = true
