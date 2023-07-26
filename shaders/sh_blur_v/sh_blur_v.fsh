varying vec2 v_vTexcoord;
varying vec4 v_vColour;

vec4 blur(sampler2D tex, vec2 uv){
	vec4 acc = vec4(0, 0, 0, 1);
	for ( float i = -1.0; i<= 1.0; i+=.1 ){
		acc.rgb += texture2D(tex, uv - vec2(0., .0025 * i)).rgb * .1 * .5;	
	}
	return acc;
}

void main()
{
	gl_FragColor = blur(gm_BaseTexture, v_vTexcoord);
}
