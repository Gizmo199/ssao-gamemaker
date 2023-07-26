#macro vertex_format global.__vertex_format
vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_normal();
vertex_format_add_texcoord();
vertex_format_add_color();
vertex_format = vertex_format_end();

function vertex_buffer_load(filename){
	if ( !file_exists(filename) || filename = "" ) return;
	var _buffer = buffer_load(filename);
	var _vbuffr = vertex_create_buffer_from_buffer(_buffer, vertex_format);
	vertex_freeze(_vbuffr);
	buffer_delete(_buffer);
	return _vbuffr;
}