/// @description 拖拽结束时要处理的事件
// 你可以在此编辑器中写入代码
XYCheck = function(checkX, checkY) {
	if (abs(checkX - x) <=75 && abs(checkY - y) <= 75) {
		return true;
	} else {
		return false;
	}
}

if (global.state == "ready") {
	var borderFirst = instance_find(obj_borderSecond, 0);	//找到边框对象
	if (collision_point(x, y, obj_cube, false, true)) {
		x = originX;
		y = originY;
		borderFirst.cubeArray[(x - borderFirst.x) / 150][(y - borderFirst.y) / 150] = number;
		return;
	}
	for (var cc = 0; cc < 3; cc++) {
		for (var dd = 0; dd < 3; dd++) {
			var changeArrayFlag = XYCheck(borderFirst.x + cc * borderFirst.sprite_width / 3,
				borderFirst.y + dd * borderFirst.sprite_height / 3);
			if (changeArrayFlag) {
				if (borderFirst.cubeArray[cc][dd] == 0) {
					x = borderFirst.x + cc * borderFirst.sprite_width / 3;
					y = borderFirst.y + dd * borderFirst.sprite_height / 3;
					borderFirst.cubeArray[cc][dd] = number;	//将边框的实时数组换一下
				} else {
					x = originX;
					y = originY;
					borderFirst.cubeArray[(x - borderFirst.x) / 150][(y - borderFirst.y) / 150] = number;
				}
			}
		}
	}
}