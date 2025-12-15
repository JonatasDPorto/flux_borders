import 'dart:ui';
import 'flux_border_params.dart';

class WavyParams extends FluxBorderParams {
  final Color color;
  final Color backgroundColor;
  final double wavelength;
  final double amplitude;

  const WavyParams({
    this.color = const Color(0xFF2196F3),
    this.backgroundColor = const Color(0x00000000),
    this.wavelength = 4.0,
    this.amplitude = 0.5,
    super.borderWidth,
    super.borderRadius,
    super.speed,
    super.glow,
  });

  @override
  String get shaderAsset => 'packages/flux_borders/assets/shaders/wavy.frag';

  @override
  void setUniforms(FragmentShader shader) {
    shader.setFloat(5, color.r);
    shader.setFloat(6, color.g);
    shader.setFloat(7, color.b);
    shader.setFloat(8, backgroundColor.r);
    shader.setFloat(9, backgroundColor.g);
    shader.setFloat(10, backgroundColor.b);
    shader.setFloat(11, wavelength);
    shader.setFloat(12, amplitude);
    shader.setFloat(13, glow);
  }

  @override
  bool get needsGlowPadding => true;
}
