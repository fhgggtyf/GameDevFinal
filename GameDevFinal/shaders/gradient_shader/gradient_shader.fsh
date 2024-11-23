varying vec2 v_vTexcoord;

uniform int u_num_lights;         // Number of active lights
uniform vec2 u_centers[16];       // Array of light centers
uniform vec2 u_directions[16];    // Array of light directions
uniform float u_clear_rads[16];   // Array of clear radii
uniform float u_dim_rads[16];     // Array of dim radii
uniform float u_angles[16];       // Array of cone angles (in radians)
uniform float u_alpha_env;        // Environment base alpha
uniform vec4 u_env_color;         // Environment mask color

void main() {
    float alpha_final = u_alpha_env;

    for (int i = 0; i < u_num_lights; i++) {
        vec2 light_center = u_centers[i];
        vec2 light_dir = normalize(u_directions[i]);
        float cone_angle = u_angles[i];

        // Vector from light to the fragment
        vec2 frag_dir = normalize(gl_FragCoord.xy - light_center);

        float alpha_light = 0.0;

        // Check if it's a point light (360-degree cone)
        if (cone_angle >= 6.28318) { // 2π radians for a full circle
            // Skip angle blending, handle only distance attenuation
            float dist = distance(gl_FragCoord.xy, light_center);
            if (dist <= u_clear_rads[i]) {
                alpha_light = 1.0; // Fully transparent within the clear radius
            } else if (dist <= u_dim_rads[i]) {
                float t = (dist - u_clear_rads[i]) / (u_dim_rads[i] - u_clear_rads[i]);
                alpha_light = 1.0 - t; // Linearly reduce light intensity
            }
        } else {
            // Apply angle-based blending for directional/cone lights
            float angle_diff = acos(dot(light_dir, frag_dir));
            if (angle_diff > cone_angle / 2.0) {
                // Outside the cone
                continue;
            }

            // Smooth edge blending for the cone
            float angle_blend = smoothstep(cone_angle / 2.0 - 0.2, cone_angle / 2.0, angle_diff);

            // Calculate distance attenuation
            float dist = distance(gl_FragCoord.xy, light_center);
            if (dist <= u_clear_rads[i]) {
                alpha_light = 1.0 * (1.0 - angle_blend); // Fully transparent within the clear radius
            } else if (dist <= u_dim_rads[i]) {
                float t = (dist - u_clear_rads[i]) / (u_dim_rads[i] - u_clear_rads[i]);
                alpha_light = (1.0 - t) * (1.0 - angle_blend); // Combine distance and angle blending
            }
        }

        // Combine the light's contribution with the current alpha
        alpha_final *= (1.0 - alpha_light);
    }

    vec4 final_color = vec4(u_env_color.rgb, alpha_final);
    gl_FragColor = final_color;
}