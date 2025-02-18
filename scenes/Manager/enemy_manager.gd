extends Node
#manager的主要作用就是管理敌人的生成，做好单一任务，避免冗杂
const Spawn_Radius = 375
@export var Enemy_ref : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.timeout.connect(Spawn_Enemy)

func Spawn_Enemy():
	var player_node = get_tree().get_first_node_in_group("player") as Node2D
	
	if player_node == null:
		return
	
	var spawn_direction = Vector2.RIGHT.rotated(randf_range(0,TAU))
	var Enemy = Enemy_ref.instantiate() as Node2D
	
	get_parent().add_child(Enemy)
	Enemy.global_position = player_node.global_position + (spawn_direction * Spawn_Radius)
	
