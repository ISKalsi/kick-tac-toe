extends Node2D

const EMPTY = -1

var grid = [
	EMPTY, EMPTY, EMPTY,
	EMPTY, EMPTY, EMPTY,
	EMPTY, EMPTY, EMPTY
]

onready var grid_spaces = get_tree().get_nodes_in_group("grid_spaces")

var player1_moves_finished = false
var player2_moves_finished = false

var player1_score = 0
var player2_score = 0

const win_scenarios = [
	[0, 1, 2],
	[3, 4, 5],
	[6, 7, 8],
	[0, 3, 6],
	[1, 4, 7],
	[2, 5, 8],
	[0, 4, 8],
	[2, 4, 6],
]

func reset_grid():
	for i in range(grid.size()):
		grid[i] = EMPTY
	
	for space in grid_spaces:
		space.doll_weight = 0

func reset():
	player1_moves_finished = false
	player2_moves_finished = false
	reset_grid()
