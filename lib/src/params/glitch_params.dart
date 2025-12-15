import 'dart:ui';
import 'package:flutter/material.dart';
import 'flux_border_params.dart';

class GlitchParams extends FluxBorderParams {
  final Color color;
  final Color backgroundColor;
  final double intensity;
  final double segmentSize;

  const GlitchParams({
    this.color = Colors.cyanAccent,
    this.backgroundColor = Colors.transparent,
    this.intensity = 1.0,
    this.segmentSize = 1.0,
    super.borderWidth,
    super.borderRadius,
    super.speed,
    super.glow,
  });

  @override
  String get shaderAsset => 'packages/flux_borders/assets/shaders/glitch.frag';

  @override
  void setUniforms(FragmentShader shader) {
    shader.setFloat(5, color.r);
    shader.setFloat(6, color.g);
    shader.setFloat(7, color.b);
    shader.setFloat(8, backgroundColor.r);
    shader.setFloat(9, backgroundColor.g);
    shader.setFloat(10, backgroundColor.b);
    shader.setFloat(11, intensity);
    shader.setFloat(12, segmentSize);
    shader.setFloat(13, glow);
  }
}
