import 'dart:ui';
import 'flux_border_params.dart';

class CircuitParams extends FluxBorderParams {
  final Color color;
  final Color backgroundColor;
  final double traceLength;
  final double density;

  const CircuitParams({
    this.color = const Color(0xFF00FF00),
    this.backgroundColor = const Color(0x00000000),
    this.traceLength = 1.0,
    this.density = 1.0,
    super.borderWidth,
    super.borderRadius,
    super.speed,
    super.glow,
  });

  @override
  String get shaderAsset => 'packages/flux_borders/assets/shaders/circuit.frag';

  @override
  void setUniforms(FragmentShader shader) {
    shader.setFloat(5, color.r);
    shader.setFloat(6, color.g);
    shader.setFloat(7, color.b);
    shader.setFloat(8, backgroundColor.r);
    shader.setFloat(9, backgroundColor.g);
    shader.setFloat(10, backgroundColor.b);
    shader.setFloat(11, traceLength);
    shader.setFloat(12, density);
    shader.setFloat(13, glow);
  }
}
