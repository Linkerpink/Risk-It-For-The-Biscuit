extends Node

@export var quota_preset: Array[int]

## every rounds quota gets higher by this amount (multiplicative)
#@export var next_round_quota_multiplication: float
@export var quota_exponent: float


var current_quota: int
var current_round: int = 0
var current_ante: int = 1
var ante_round: int


#TEST VARIABLES FOR TESTING PURPOSES
@export var quota_label: Label 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_quota = quota_preset[current_ante]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if round(quota_label.text.to_float()) != current_quota:
		quota_label.text = str(current_quota)

#TESTING 
func _on_nextround_pressed() -> void:
	if ante_round >= 2:
		ante_round = -1
		current_ante += 1
	current_quota = calculate_next_quota()

# METHODS FOR CALCULATING STUFF

## Call this for when the quota needs to grow larger
func calculate_next_quota():
	current_round += 1
	ante_round += 1
	var next_quota = quota_preset[current_ante]
	
	if ante_round == 1:
		next_quota = quota_preset[current_ante] * 1.5
	if ante_round == 2:
		next_quota = quota_preset[current_ante] * 2
	
	print(next_quota)
	return next_quota
