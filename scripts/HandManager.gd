extends Node2D
class_name HandManager

@onready var deck = %Deck

@export var hand : Array[IngredientCard] = []
@onready var ingredient_card_scene = preload("res://scenes/IngredientCard.tscn")

var selected_cards : Array[IngredientCard]

func make_hand():
	var _rnd = randi_range(6, 6)
	for i in _rnd:
		add_card()
		
func destroy_hand():
	for i : IngredientCard in hand:
		i.queue_free()
	hand.clear()
	print(hand)
	
func add_card():
	var _rnd_ingr = deck.deck[randi_range(0, deck.unlocked_ingredients.size() - 1)]
	
	var card : IngredientCard = ingredient_card_scene.instantiate() 
	card.change_ingredient(_rnd_ingr)

	var ingredient_text : RichTextLabel = card.get_child(2).get_child(0)
	ingredient_text.text = "[outline_size={8}] [font_size={16}]" + str(card.ingredient_name) + \
		"\n\n[font_size={11}]biscuit value: [rainbow]" + str(card.ingredient.biscuit_value) + \
		"\n[/rainbow]burn value: [rainbow]" + str(card.ingredient.burn_value)

	add_child(card)
	hand.append(card)

	card.target_position = Vector2(125 * (hand.size() - 1), 0)

func remove_card(_card : IngredientCard):
	if not is_instance_valid(_card):
		return
	
	var _target_position = _card.target_position
	hand.erase(_card)
	_card.queue_free()
	
	var _rnd_ingr = deck.deck[randi_range(0, deck.unlocked_ingredients.size() - 1)]
	var card : IngredientCard = ingredient_card_scene.instantiate() 
	card.change_ingredient(_rnd_ingr)

	var ingredient_text : RichTextLabel = card.get_child(2).get_child(0)
	ingredient_text.text = "[outline_size={8}] [font_size={16}]" + str(card.ingredient_name) + \
		"\n\n[font_size={11}]biscuit value: [rainbow]" + str(card.ingredient.biscuit_value) + \
		"\n[/rainbow]burn value: [rainbow]" + str(card.ingredient.burn_value)

	add_child(card)
	hand.append(card)

	card.target_position = _target_position


func select_card(_card : IngredientCard):
	selected_cards.insert(selected_cards.size(), _card)
	
func unselect_card(_card : IngredientCard):
	selected_cards.erase(_card)
