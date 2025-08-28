extends Node2D

@export var deck_size : int = 26
@export var deck : Array[Ingredient] = [] #26
@export var hand : Array[IngredientCard] = []
@onready var ingredient_card_scene = preload("res://scenes/IngredientCard.tscn")
@export var unlocked_ingredients : Array[Ingredient] = [] # 0: sugar 1: flour 2: water 3: salt 4: milk 5: buttermilk 6: butter

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
		var _rnd_ingr = deck.get(randi_range(0, unlocked_ingredients.size()))
		hand.insert(hand.size(), _rnd_ingr)
		
		var card : IngredientCard = ingredient_card_scene.instantiate()
		card.change_ingredient(_rnd_ingr)

func _get_ingredients():
	var sugar = unlocked_ingredients.get(0) 
	var flour = unlocked_ingredients.get(1)
	var water = unlocked_ingredients.get(2)
	var salt = unlocked_ingredients.get(3) 
	var milk = unlocked_ingredients.get(4)
	var buttermilk = unlocked_ingredients.get(5)
	var butter = unlocked_ingredients.get(6)
