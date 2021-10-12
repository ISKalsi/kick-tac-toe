extends Label

export var is_first_turn: bool

func _ready():
	pass # Replace with function body.


func _on_game_finished():
	if is_first_turn:
		text = String(GlobalVars.player1_score)
	else:
		text = String(GlobalVars.player2_score)
