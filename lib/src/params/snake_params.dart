import 'dart:ui';
import 'flux_border_params.dart';

class SnakeParams extends FluxBorderParams {
  final Color color;
  final Color backgroundColor;

  const SnakeParams({
    this.color = const Color(0xFF00FFFF),
    this.backgroundColor = const Color(0xFF2C2C2C),
    super.borderWidth,
    super.borderRadius,
    super.speed,
    super.glow,
  });

  @override
  String get shaderAsset => 'packages/flux_borders/assets/shaders/snake.frag';

  @override
  void setUniforms(FragmentShader shader) {
    shader.setFloat(5, color.r);
    shader.setFloat(6, color.g);
    shader.setFloat(7, color.b);

    shader.setFloat(8, backgroundColor.r);
    shader.setFloat(9, backgroundColor.g);
    shader.setFloat(10, backgroundColor.b);

    shader.setFloat(11, 0.0);
    shader.setFloat(12, 0.0);

    shader.setFloat(13, glow);
  }
}
