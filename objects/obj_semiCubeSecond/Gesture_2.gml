/// @description 拖拽时鼠标与cube的位置差将计算出来
// 你可以在此编辑器中写入代码
if (global.state == "ready") {
	originX = x;
	originY = y;
	dragX = mouse_x - x;
	dragY = mouse_y - y;
	var borderFirst = instance_find(obj_borderSecond, 0);
	if (x - borderFirst.x >= 0 && x - borderFirst.x <= 300) {
		borderFirst.cubeArray[(x - borderFirst.x) / 150][(y - borderFirst.y) / 150] = 0;	
	}
}
