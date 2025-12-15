import 'dart:ui';
import 'package:flutter/material.dart';
import 'flux_border_params.dart';

class HelixParams extends FluxBorderParams {
  final Color color;
  final Color backgroundColor;

  /// Controls the frequency of the twists. Default 4.0.
  final double frequency;

  /// Controls the amplitude (width) of the helix strands. Default 0.5.
  final double amplitude;

  const HelixParams({
    this.color = Colors.cyanAccent,
    this.backgroundColor = Colors.transparent,
    this.frequency = 4.0,
    this.amplitude = 0.5,
    super.borderWidth,
    super.borderRadius,
    super.speed,
    super.glow,
  });

  @override
  String get shaderAsset => 'packages/flux_borders/assets/shaders/helix.frag';

  @override
  void setUniforms(FragmentShader shader) {
    shader.setFloat(5, color.r);
    shader.setFloat(6, color.g);
    shader.setFloat(7, color.b);
    shader.setFloat(8, backgroundColor.r);
    shader.setFloat(9, backgroundColor.g);
    shader.setFloat(10, backgroundColor.b);

    shader.setFloat(11, frequency);
    shader.setFloat(12, amplitude);
    shader.setFloat(13, glow);
  }

  @override
  bool get needsGlowPadding => true;
}
