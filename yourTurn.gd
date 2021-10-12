extends RichTextLabel

const PLAYER1_X = 48
const PLAYER2_X = 388
const FINISHED_X = 200

var x_coord = PLAYER1_X

func _process(delta):
	rect_global_position.x = lerp(rect_global_position.x, x_coord, 5 * delta)

func _on_Dollset1_turn_over(did_win):
	if did_win:
		x_coord = FINISHED_X
		text = "Player 1 Won"
	else:
		x_coord = PLAYER2_X

func _on_Dollset2_turn_over(did_win):
	if did_win:
		x_coord = FINISHED_X
		text = "Player 2 Won"
	else:
		x_coord = PLAYER1_X


func _on_Dollset_game_tie():
	x_coord = FINISHED_X
	text = "Game tie"
