extends Button


func _on_playAgain_pressed():
	visible = false


func _on_game_finished():
	visible = true
