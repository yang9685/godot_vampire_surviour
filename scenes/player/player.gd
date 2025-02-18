extends CharacterBody2D
#这里是主角的代码
const MAX_SPEED = 150
const ACCELERATION = 20

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var movement_vector = Get_Movement_Vector()
	var direction = movement_vector.normalized()
	#velocity和move_and_slide是他本来就有的功能，封装好的
	var target_velocity = direction * MAX_SPEED
	
	velocity = velocity.lerp(target_velocity, 1-exp(-delta * ACCELERATION))
	move_and_slide()
	 
	


func Get_Movement_Vector():
	var x_movement = Input.get_action_strength("move_right")-Input.get_action_strength("move_left")
	var y_movement = Input.get_action_strength("move_down")-Input.get_action_strength("move_up")
	
	return Vector2(x_movement,y_movement) 
	
