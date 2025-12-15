import 'dart:ui';
import 'flux_border_params.dart';

class RainbowParams extends FluxBorderParams {
  const RainbowParams({
    super.borderWidth,
    super.borderRadius,
    super.speed,
    super.glow,
  });

  @override
  String get shaderAsset => 'packages/flux_borders/assets/shaders/rainbow.frag';

  @override
  void setUniforms(FragmentShader shader) {
    shader.setFloat(5, 0.0);
    shader.setFloat(6, 0.0);
    shader.setFloat(7, 0.0);
    shader.setFloat(8, 0.0);
    shader.setFloat(9, 0.0);
    shader.setFloat(10, 0.0);
    shader.setFloat(11, 0.0);
    shader.setFloat(12, 0.0);

    shader.setFloat(13, glow);
  }
}
