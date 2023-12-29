#version 120

#ifdef GL_ES
precision mediump float;
#endif

varying vec2 texCoordVarying;

void main(void) {
	texCoordVarying = gl_MultiTexCoord0.xy;   
	gl_Position = ftransform();
}
