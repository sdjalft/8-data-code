/// @description 在此处插入描述 
// 你可以在此编辑器中写入代码
draw_self();
draw_set_font(Font2);
switch (global.state) {
	case "ready":
		draw_text(x + (sprite_width - string_width("ready")) / 2
			, y + (sprite_height - string_height("ready")) / 2, "ready");
		break;
	case "calculating":
		global.state = "calculate";
		draw_text(x + (sprite_width - string_width("calculating")) / 2
			, y + (sprite_height - string_height("calculating")) / 2, "calculating");
		break;
	case "again":
		draw_text(x + (sprite_width - string_width("againing")) / 2
			, y + (sprite_height - string_height("againing")) / 2, "againing");
		break;
	case "complete":
		draw_text(x + (sprite_width - string_width("complete")) / 2
			, y + (sprite_height - string_height("complete")) / 2, "complete");
		break;
	case "fail":
		draw_text(x + (sprite_width - string_width("fail")) / 2
			, y + (sprite_height - string_height("fail")) / 2, "fail");
		break;
}