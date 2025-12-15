import 'dart:ui';

abstract class FluxBorderParams {
  final double borderWidth;
  final double borderRadius;

  final double speed;

  final double glow;

  const FluxBorderParams({
    this.borderWidth = 3.0,
    this.borderRadius = 16.0,
    this.speed = 1.0,
    this.glow = 0.0,
  });

  String get shaderAsset;

  void setUniforms(FragmentShader shader);

  bool get needsGlowPadding => true;
}
