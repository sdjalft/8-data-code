/// @description 在此处插入描述 
// 你可以在此编辑器中写入代码
//初始化不同的方块
var count = 1;
for (var cc = 0; cc < 3; cc += 1) {
	for (var dd = 0; dd < 3; dd += 1) {
		if (cc != 1 || dd != 1) {
			var tempSemiCube = instance_create_layer(x + dd * sprite_width / 3,
				y + cc * sprite_height / 3, "SemiInstances", obj_semiCubeFirst);
			tempSemiCube.number = count;
			cubeArray[dd][cc] = count;
			count++;
		} else {
			cubeArray[dd][cc] = 0;
		}
	}
}
selfPriQueue = ds_priority_create();	//用来遍历的优先队列
resultStack = ds_stack_create();
processArrayMap = ds_map_create();	//用来区分数组是否重复的hash表
processValueMap = ds_map_create();	//储存value对应的数组状态
targetCubeArray = 0;
originArray = array_create(3);
step = 0;
diedai = 0;
qifaCount = 1;	//步数所占领的权重
animateFlag = true; //动画标记
againFlag = false;
alterStack = ds_stack_create();