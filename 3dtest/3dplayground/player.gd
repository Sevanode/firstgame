extends RigidBody3D

var mouse_sense := 0.001
var twist_input := 0.0
var pitch_input :=0.0


@onready var twistpivot = $twistpivot
@onready var pitchpivot = $twistpivot/pitchpivot
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var input := Vector3.ZERO
	input.x = Input.get_axis("move_left","move_right")
	input.z = Input.get_axis("move_foward","move_back")
	
	
	#User Input
	apply_central_force(twistpivot.basis*input * 1200 * delta)
	twistpivot.rotate_y(twist_input)
	pitchpivot.rotate_x(pitch_input)
	pitchpivot.rotation.x = clamp(pitchpivot.rotation.x,
	-1,
	0.5
	)
	twist_input = 0.0
	pitch_input = 0.0
	
	

	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			twist_input = - event.relative.x * mouse_sense
			pitch_input = - event.relative.y * mouse_sense
