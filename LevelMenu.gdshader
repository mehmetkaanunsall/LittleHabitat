
shader_type canvas_item;

uniform float corner_radius = 0.12;

void fragment() {
    vec2 uv = UV;
    vec2 size = 1.0 / TEXTURE_PIXEL_SIZE;

    vec2 pixel_pos = uv * size;
    vec2 half_size = size * 0.5;

    float radius = min(corner_radius * min(size.x, size.y), min(half_size.x, half_size.y));

    vec2 q = abs(pixel_pos - half_size) - (half_size - vec2(radius));
    float distance = length(max(q, vec2(0.0))) + min(max(q.x, q.y), 0.0) - radius;

    float alpha = 1.0 - smoothstep(-1.0, 1.0, distance);

    COLOR = texture(TEXTURE, UV);
    COLOR.a *= alpha;
}
