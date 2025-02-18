extends Node2D
#在写技能的时候，一般可以分为控制器和控制的效果，分开来编写特定的功能，解耦合。
#控制器主要来控制使用，其他效果在武器那里编写，这样别的角色也可以使用
const MAX_RADIUS = 150

@export var sword_ability : PackedScene
#这里是暴露一个变量可以给检查器使用，用来指定对应的场景
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#当你想要获取当前场景的某个节点时，可以通过下面的方法来调用，$+...，然后你就可以调用他的函数(信号)了
	#这里是将timeout信号和函数绑定起来，当信号发出时会自动调用该函数
	$Timer.timeout.connect(sword_attack)


func sword_attack():
	var player_node = get_tree().get_first_node_in_group("player") as Node2D
	var enemies_node = get_tree().get_nodes_in_group("Enemy")
	if player_node == null:
		return
	
	#这里将数组进行过滤，过滤的函数可以在这里写，也可以在外面写，含义是将攻击范围外的敌人过滤掉
	enemies_node = enemies_node.filter(func(enemy:Node2D):
		return enemy.global_position.distance_squared_to(player_node.global_position) <= pow(MAX_RADIUS,2)
		)
	
	if enemies_node.size() <= 0:
		return
		
	#这里是保留距离角色最近的敌人
	enemies_node.sort_custom(func(a:Node2D,b:Node2D):
		var a_distance = a.global_position.distance_squared_to(player_node.global_position)
		var b_distance = b.global_position.distance_squared_to(player_node.global_position)
		return a_distance <= b_distance
	)
	
	#这里是实例化场景，并将该场景添加到主场景中
	#让剑可以对着敌人切
	var sword_instance = sword_ability.instantiate() as Node2D
	player_node.get_parent().add_child(sword_instance)
	sword_instance.global_position = enemies_node[0].global_position
	sword_instance.global_position += Vector2.RIGHT.rotated(randf_range(0,TAU))*4
	var direction = enemies_node[0].global_position - sword_instance.global_position
	sword_instance.rotation = direction.angle()
	#这里是将实例化的技能和main场景结合起来，生成在main中，如果是和player联系起来，则会跟着player一起动
