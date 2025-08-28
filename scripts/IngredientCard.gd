extends Area2D
class_name IngredientCard

@export var ingredient : Ingredient
var ingredient_name : String

func change_ingredient(_ingredient : Ingredient):
	ingredient = _ingredient
	ingredient_name = ingredient.name
