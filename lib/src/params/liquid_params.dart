import 'dart:ui';
import 'package:flutter/material.dart';
import 'flux_border_params.dart';

class LiquidParams extends FluxBorderParams {
  final Color color;
  final Color backgroundColor;

  /// Controls the frequency of blobs. Default 3.0.
  final double frequency;

  /// Controls the viscosity/speed variance of blobs. Default 1.0.
  final double viscosity;

  const LiquidParams({
    this.color = Colors.orangeAccent,
    this.backgroundColor = Colors.transparent,
    this.frequency = 3.0,
    this.viscosity = 1.0,
    super.borderWidth,
    super.borderRadius,
    super.speed,
    super.glow,
  });

  @override
  String get shaderAsset => 'packages/flux_borders/assets/shaders/liquid.frag';

  @override
  void setUniforms(FragmentShader shader) {
    shader.setFloat(5, color.r);
    shader.setFloat(6, color.g);
    shader.setFloat(7, color.b);
    shader.setFloat(8, backgroundColor.r);
    shader.setFloat(9, backgroundColor.g);
    shader.setFloat(10, backgroundColor.b);

    shader.setFloat(11, frequency);
    shader.setFloat(12, viscosity);
    shader.setFloat(13, glow);
  }

  @override
  bool get needsGlowPadding => true;
}
