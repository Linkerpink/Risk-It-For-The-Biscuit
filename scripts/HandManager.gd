extends Node2D
class_name HandManager

@export var deck_size : int = 26
@export var deck : Array[Ingredient] = [] #26
@export var hand : Array[IngredientCard] = []
@onready var ingredient_card_scene = preload("res://scenes/IngredientCard.tscn")
@export var unlocked_ingredients : Array[Ingredient] = [] # 0: sugar 1: flour 2: water 3: salt 4: milk 5: buttermilk 6: butter

var selected_card : IngredientCard

var sugar
var flour
var water
var salt
var milk
var buttermilk
var butter

func _ready() -> void:
	_get_ingredients()
	_make_deck()
	_make_hand()
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().reload_current_scene()

func _make_deck():
	for i in 3: # Make sure every ingredient is added at least 3 times to the deck
		deck.insert(deck.size(), sugar)
		deck.insert(deck.size(), flour)
		deck.insert(deck.size(), water)
		deck.insert(deck.size(), salt)
		deck.insert(deck.size(), milk)
		deck.insert(deck.size(), buttermilk)
		deck.insert(deck.size(), butter)
	
	# Add the ones that need to be in the deck 4 times
	deck.insert(deck.size(), sugar)
	deck.insert(deck.size(), flour)
	deck.insert(deck.size(), water)
	deck.insert(deck.size(), salt)
	deck.insert(deck.size(), milk)
	
func _make_hand():
	var _rnd = randi_range(3, 6)
	for i in _rnd:
		var _rnd_ingr = deck.get(randi_range(0, unlocked_ingredients.size() - 1))
		hand.insert(hand.size(), _rnd_ingr)
		
		var card : IngredientCard = ingredient_card_scene.instantiate() 
		card.change_ingredient(_rnd_ingr)
		card.position = Vector2(125 * i, 0)
		var ingredient_text : RichTextLabel = card.get_child(2).get_child(0)
		add_child(card)
		ingredient_text.text = "[outline_size={8}] [font_size={16}]" + str(card.ingredient_name) + "\n\n[font_size={11}]biscuit value: [rainbow]" + str(card.ingredient.biscuit_value) + "\n[/rainbow]burn value: [rainbow]" + str(card.ingredient.burn_value)

func select_card(_card : IngredientCard):
	selected_card = _card
	print("selected card " + str(_card))

func _get_ingredients():
	sugar = unlocked_ingredients.get(0) 
	flour = unlocked_ingredients.get(1)
	water = unlocked_ingredients.get(2)
	salt = unlocked_ingredients.get(3) 
	milk = unlocked_ingredients.get(4)
	buttermilk = unlocked_ingredients.get(5)
	butter = unlocked_ingredients.get(6)
