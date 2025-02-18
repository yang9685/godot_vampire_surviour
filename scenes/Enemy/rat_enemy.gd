extends CharacterBody2D
#这里编写敌人的脚本，
const MAX_SPEED = 40

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Area2D.area_entered.connect(be_attacked)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction = get_player_direction()
	velocity = direction * MAX_SPEED
	move_and_slide()	

#这里涉及到一个组的概念，可以将不同节点放进一个组里面，这样在其他脚本之中就可以调用
#这里就通过player组来获得角色的引用
func get_player_direction():
	var player_node = get_tree().get_first_node_in_group("player") as Node2D
	
	if player_node != null :
		return (player_node.global_position-global_position).normalized()
	
	return Vector2.ZERO
	

func be_attacked(other_area:Area2D):
	queue_free()
