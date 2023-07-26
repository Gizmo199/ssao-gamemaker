attribute vec3 in_Position;                  // (x,y,z)
attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2	v_vTexcoord;
varying vec4	v_vColour;
varying vec3	v_vNormal;
varying float	v_vDepth;
varying vec3	v_vViewNorm;

void main()
{
    vec4 osp = vec4( in_Position, 1);
	vec4 osn = vec4(in_Normal, 0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * osp;
    
    v_vColour	= in_Colour;
    v_vTexcoord = in_TextureCoord;
	v_vNormal	= normalize( gm_Matrices[MATRIX_WORLD] * osn ).xyz;
	v_vViewNorm = normalize( gm_Matrices[MATRIX_WORLD_VIEW] * osn ).xyz;
	v_vDepth	= gl_Position.z / gl_Position.w;
}
