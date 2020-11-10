/// @description 在此处插入描述 
// 你可以在此编辑器中写入代码
if (global.state == "ready") {
	draw_set_font(Font2);
	draw_self();
	draw_text(x + (sprite_width - string_width("again?")) / 2,
		y + (sprite_height - string_height("again?")) / 2, "again?");
}