/// @description 在此处插入描述 
// 你可以在此编辑器中写入代码
var count = 1;
for (var cc = 0; cc < 3; cc += 1) {
	for (var dd = 0; dd < 3; dd += 1) {
		if (cc != 1 || dd != 1) {
			var tempSemiCube = instance_create_layer(x + dd * sprite_width / 3,
				y + cc * sprite_height / 3, "SemiInstances", obj_semiCubeSecond);
			tempSemiCube.number = count;
			cubeArray[dd][cc] = count;
			count++;
		} else {
			cubeArray[dd][cc] = 0;
		}
	}
} 