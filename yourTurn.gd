extends Label

const PLAYER1_X = 10
const PLAYER2_X = 325
const FINISHED_X = 180

var x_coord = PLAYER1_X
var is_game_finished = false

signal game_finished

func _process(delta):
	rect_global_position.x = lerp(rect_global_position.x, x_coord, 5 * delta)

func _on_Dollset1_turn_over(did_win):
	if did_win:
		is_game_finished = true
		x_coord = FINISHED_X
		text = "Player 1 Won"
		GlobalVars.player1_score += 1
		emit_signal("game_finished")
	elif !is_game_finished:
		x_coord = PLAYER2_X

func _on_Dollset2_turn_over(did_win):
	if did_win:
		is_game_finished = true
		x_coord = FINISHED_X
		text = "Player 2 Won"
		GlobalVars.player2_score += 1
		emit_signal("game_finished")
	elif !is_game_finished:
		x_coord = PLAYER1_X


func _on_Dollset_game_tie():
	is_game_finished = true
	x_coord = FINISHED_X
	text = "Game tie"
	emit_signal("game_finished")


func _on_playAgain_pressed():
	x_coord = PLAYER1_X
	text = "Your turn"
	is_game_finished = false
