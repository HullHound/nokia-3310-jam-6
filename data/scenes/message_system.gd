extends ColorRect

@export var displayMessageTime = 3.0

var time_left_on_message = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MessageSystem.new_message.connect(display)
	time_left_on_message = 0.0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	time_left_on_message -= delta;
	
	if time_left_on_message <= 0.0:
		self.visible = false

func display(message: String):
	$Label.text = message;
	time_left_on_message = displayMessageTime
	self.visible = true

