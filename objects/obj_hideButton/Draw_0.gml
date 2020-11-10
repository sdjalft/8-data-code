/// @description 在此处插入描述 
// 你可以在此编辑器中写入代码

if (global.state == "fail") {
	draw_set_font(Font2);
	draw_self();
	draw_text(x + (sprite_width - string_width("retry?")) / 2,
		y + (sprite_height - string_height("retry?")) / 2, "retry?");
}
if (global.state == "ready") {
	draw_set_font(Font2);
	var temp = instance_find(obj_borderFirst, 0);
	draw_self();
	draw_text(x + (sprite_width - string_width("step:" + string(temp.step))) / 2,
		y + (sprite_height - string_height("step:" + string(temp.step))) / 2,
		"step:" + string(temp.step));
	draw_text(0, 0, "loop times:" + string(temp.diedai));
}