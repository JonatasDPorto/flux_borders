import 'dart:ui';
import 'flux_border_params.dart';

class SlashedParams extends FluxBorderParams {
  final Color color;
  final Color backgroundColor;
  final double dashSpacing;
  final double dashRatio;

  const SlashedParams({
    this.color = const Color(0xFFFFEB3B),
    this.backgroundColor = const Color(0xFF000000),
    this.dashSpacing = 3.0,
    this.dashRatio = 0.5,
    super.borderWidth,
    super.borderRadius,
    super.speed,
    super.glow,
  });

  @override
  String get shaderAsset => 'packages/flux_borders/assets/shaders/slashed.frag';

  @override
  void setUniforms(FragmentShader shader) {
    shader.setFloat(5, color.r);
    shader.setFloat(6, color.g);
    shader.setFloat(7, color.b);
    shader.setFloat(8, backgroundColor.r);
    shader.setFloat(9, backgroundColor.g);
    shader.setFloat(10, backgroundColor.b);
    shader.setFloat(11, dashSpacing);
    shader.setFloat(12, dashRatio);

    shader.setFloat(13, glow);
  }
}
