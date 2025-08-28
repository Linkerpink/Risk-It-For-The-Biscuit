extends Node2D

var cards : Array[IngredientCard] = []
@onready var ingredient_card_scene = preload("res://scenes/IngredientCard.tscn")
@export var unlocked_ingredients : Array[Ingredient] = []

func _ready() -> void:
	var _rnd = randi_range(4, 6)
	for i in _rnd:
		var _rnd_ingr = unlocked_ingredients.get(randi_range(0,unlocked_ingredients.size()))
		print(_rnd_ingr)
		#cards.
	
	print(cards.size())
