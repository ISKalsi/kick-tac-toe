extends Area2D

signal turn_played(box_index)

var selected = false
var fitted = false

onready var grid_space

onready var home_position = self.global_position

const GRID_SPACE_WIDTH = 48
const OFFSET = Vector2(-GRID_SPACE_WIDTH / 2, -GRID_SPACE_WIDTH)

export var texture: Texture
export var frame: int

func _ready():
	setup_doll_texture(texture, frame)

func setup_doll_texture(t, f):
	$Sprite.texture = t
	$Sprite.frame = f

func _physics_process(delta):
	if !fitted and selected:
		global_position = lerp(global_position, get_global_mouse_position() + OFFSET, 25 * delta)
	elif grid_space != null:
		global_position = lerp(global_position, grid_space.global_position, 10 * delta)
	else:
		global_position = lerp(global_position, home_position, 35 * delta)

func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if !fitted and event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			selected = true

func _input(event):
	if !fitted and event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and !event.pressed:
			var shortest_dist = GRID_SPACE_WIDTH
			for space in GlobalVars.grid_spaces:
				var dist = global_position.distance_to(space.global_position)
				if dist < shortest_dist:
					grid_space = space
					shortest_dist = dist
			
			if grid_space != null:
				var weight = $Sprite.frame
				if weight > grid_space.doll_weight:
					grid_space.doll_weight = weight
					fitted = true
					GlobalVars.grid[grid_space.index] = weight
					emit_signal("turn_played", grid_space.index)
				else:
					grid_space = null
			
			selected = false
