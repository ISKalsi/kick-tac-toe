extends Node2D

export var doll_texture: Texture
export var is_first_turn: bool

signal turn_over(did_win)
signal game_tie

onready var dolls = get_children()

var turn_map = {}
var dolls_left = {}

func _ready():
	for i in range(1, 7):
		dolls_left[i] = true
		
	var i = 1
	for doll in dolls:
		doll.setup_doll_texture(doll_texture, i)
		doll.connect("turn_played", self, "_on_Doll_turn_played")
		doll.input_pickable = is_first_turn
		doll.z_index = i
		i += 1

func _on_Doll_turn_played(box_index):
	for doll in dolls:
		doll.input_pickable = false
	
	turn_map[box_index] = true
	dolls_left[GlobalVars.grid[box_index]] = false
	emit_signal("turn_over", hasWon())

func _on_Dollset_turn_over(did_win):
	if !did_win and !GlobalVars.player1_moves_finished and !GlobalVars.player2_moves_finished:
		if !canMakeNextMove():
			if is_first_turn:
				GlobalVars.player1_moves_finished = true
			else:
				GlobalVars.player2_moves_finished = true
			emit_signal("turn_over", false)
		else:
			for doll in dolls:
				doll.input_pickable = true
	else:
		emit_signal("game_tie")
		
func hasWon():
	for moves in GlobalVars.win_scenarios:
		if turn_map.has_all(moves):
			return true
	
	return false
	
func canMakeNextMove():
	var biggest_doll
	for i in range(6, 0, -1):
		biggest_doll = i
		if dolls_left[i]:
			break
	
	for weight in GlobalVars.grid:
		if biggest_doll > weight:
			return true
	
	return false
