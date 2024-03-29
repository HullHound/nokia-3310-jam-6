extends MoveToLocationState_Adjacent

@export var target: Node2D

func _physics_process(delta):
	if !enabled:
		return

	if target != null:
		super.set_target(target.global_position)
	
	super(delta)
