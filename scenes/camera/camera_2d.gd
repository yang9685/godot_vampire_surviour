extends Camera2D
#camera主要是用来追踪主角的，同时加上一点拖拽效果，看起来更舒适一点
var target_location = Vector2.ZERO
var rate = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	make_current()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	Get_Target_Location()
	#这里的镜头会有一点抖动，可以修改一下，改成小于某个值直接相等
	#镜头抖动的问题还需要解决
	#if (global_position-target_location).length() <= 2 :
	#	rate = 0
	#else :
	#	rate = 1 - exp( -delta * 10 )
	#global_position = global_position.lerp(target_location, rate)
	#这里带有一定的数学原理，总体来说就是避免帧数的影响
	global_position = target_location
	#godot自带有位置平滑，可以通过代码实现，也可以直接设置
	
	
func Get_Target_Location():
	var player_group = get_tree().get_nodes_in_group("player")
	if player_group.size() > 0:
		var player = player_group[0] as Node2D
		target_location = player.global_position 
	
