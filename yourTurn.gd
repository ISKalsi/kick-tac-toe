extends Label

const PLAYER1_X = 10
const PLAYER2_X = 325
const FINISHED_X = 180

var x_coord = PLAYER1_X
var game_finished = false

func _process(delta):
	rect_global_position.x = lerp(rect_global_position.x, x_coord, 5 * delta)

func _on_Dollset1_turn_over(did_win):
	if did_win:
		game_finished = true
		x_coord = FINISHED_X
		text = "Player 1 Won"
	elif !game_finished:
		x_coord = PLAYER2_X

func _on_Dollset2_turn_over(did_win):
	if did_win:
		game_finished = true
		x_coord = FINISHED_X
		text = "Player 2 Won"
	elif !game_finished:
		x_coord = PLAYER1_X


func _on_Dollset_game_tie():
	game_finished = true
	x_coord = FINISHED_X
	text = "Game tie"
