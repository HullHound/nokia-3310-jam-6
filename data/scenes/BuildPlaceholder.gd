extends Node2D
class_name BuildPlaceholder

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var game_map: GameMap2D
@export var not_ok_frame = 0
@export var ok_frame = 1
@export var canBeBuiltOnProperty = "canBeBuiltOn_Player"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if canBuild():
		animated_sprite_2d.frame = ok_frame;
	else:
		animated_sprite_2d.frame = not_ok_frame;
		
func canBuild():
	var tiles = game_map.getAllSurroundingTiles(global_position);
	
	var canBuild = true
	
	for tile in tiles:
		if !game_map.getTileData(tile)[canBeBuiltOnProperty]:
			canBuild = false
			
	return canBuild
			
