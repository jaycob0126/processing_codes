uniform mat4 transform;
uniform mat3 normalMatrix;
uniform vec3 lightNormal;

in vec4 position;
in vec4 color;
in vec3 normal;

out vec4 fragCoord;

void main() {
  gl_Position = transform * position;
  fragCoord = transform * position;
}