#version 300 es

precision mediump float;


uniform sampler2D uTexture; // Текстура изображения
uniform float uPixelSize;  // Размер "пикселей"
uniform vec2 uResolution; // Размер экрана

in vec2 vTexCoord; // Текстурные координаты

out vec4 fragColor; // Цвет текущего фрагмента

void main() {

  vec2 pixelGrid = uPixelSize / uResolution;

  vec2 coord = floor(vTexCoord / pixelGrid) * pixelGrid;

  fragColor = texture(uTexture, coord);
}
