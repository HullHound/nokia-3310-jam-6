extends MoveToLocationState

@export var target: Node2D

func _physics_process(delta):
	if !enabled:
		return

	super.set_target(target.global_position)
	
	super(delta)
