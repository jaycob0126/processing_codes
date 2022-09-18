#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform float resolutionX;
uniform float resolutionY;

in vec4 fragCoord;

void main() {
  vec2 st = fragCoord.xy;
  gl_FragColor = vec4(st.x/resolutionX, st.y/resolutionY, 0, 1);
}