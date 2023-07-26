varying vec2	v_vTexcoord;
varying vec4	v_vColour;
varying vec3	v_vNormal;
varying float	v_vDepth;
varying vec3	v_vViewNorm;

void main()
{
	vec4 color = texture2D( gm_BaseTexture, v_vTexcoord );
	color.rgb *= .5 + max(-dot(v_vNormal, vec3(1)), 0.) * .5;
	
	// Color 
	gl_FragData[0] = color;						
	
	// Normal
	gl_FragData[1] = vec4(normalize(v_vViewNorm * .5 + .5), 1.);	
	
	// Depth
	gl_FragData[2] = vec4(vec3(v_vDepth), 1.);						
	
}
