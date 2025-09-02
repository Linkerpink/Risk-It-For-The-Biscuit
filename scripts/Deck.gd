extends Area2D
class_name Deck

@export var deck_size : int = 26
@export var deck : Array[Ingredient] = [] #26
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
	#_set_position()

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

func _get_ingredients():
	sugar = unlocked_ingredients.get(0) 
	flour = unlocked_ingredients.get(1)
	water = unlocked_ingredients.get(2)
	salt = unlocked_ingredients.get(3) 
	milk = unlocked_ingredients.get(4)
	buttermilk = unlocked_ingredients.get(5)
	butter = unlocked_ingredients.get(6)
	
func _set_position():
	position = get_viewport_rect().size
	print(position)
