extends Node2D
class_name Lair

@export var spawns: Array[Node2D]
@export var spawn_container: Node2D
@export var goblin_image: Texture2D

@export var game_map: GameMap2D
@export var team_id: int = 0

@onready var spawner: Spawner2D = $Spawner

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawner.spawns = spawns
	spawner.spawn_container = spawn_container
	
	spawner.start_spawn()

func _on_spawner_spawn_callback(node: Node2D) -> void:
	
	var goblin = node as Goblin;
	goblin.image = goblin_image
	goblin.game_map = game_map
	goblin.team_id = team_id
	
	goblin.died.connect($Spawner.remove_spawn.bind(node))
