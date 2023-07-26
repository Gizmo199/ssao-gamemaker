attribute vec3 in_Position;                  // (x,y,z)
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec3 v_vViewDir;
varying mat4 v_vProjInv;

uniform mat4 projmat_inv;

void main()
{
    vec4 osp = vec4( in_Position, 1 );
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * osp;
	
    v_vColour	= in_Colour;
    v_vTexcoord = in_TextureCoord;
	v_vViewDir	= ( projmat_inv * vec4(in_Position.xy, 0., 1.) ).xyz;
	v_vProjInv	= projmat_inv;
	
}
