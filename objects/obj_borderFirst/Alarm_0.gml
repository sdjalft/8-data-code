/// @description 在此处插入描述 
// 你可以在此编辑器中写入代码
if (!ds_stack_empty(resultStack)) {
	var tempId = ds_stack_pop(resultStack);
	instance_destroy(obj_semiCubeFirst)
	var motionArray = processValueMap[? tempId];
	for (var cc = 0; cc < 3; cc++) {
		for (var dd = 0; dd < 3; dd++) {
			if (motionArray[dd][cc] != 0) {
				var tempSemiCube = instance_create_layer(x + dd * sprite_width / 3,
					y + cc * sprite_height / 3, "SemiInstances", obj_semiCubeFirst);
				tempSemiCube.number = motionArray[dd][cc];
				cubeArray[dd][cc] = motionArray[dd][cc];
			} else {
				cubeArray[dd][cc] = 0;
			}
		}
	}
	alarm[0] = 1 * room_speed;
} else {
	selfPriQueue = ds_priority_create();	//用来遍历的优先队列
	resultStack = ds_stack_create();
	processArrayMap = ds_map_create();	//用来区分数组是否重复的hash表
	//processValueMap = ds_map_create();	//储存value对应的数组状态
	animateFlag = true;
	global.state = "ready";	
}