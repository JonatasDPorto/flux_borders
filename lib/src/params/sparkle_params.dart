import 'dart:ui';
import 'package:flutter/material.dart';
import 'flux_border_params.dart';

class SparkleParams extends FluxBorderParams {
  final Color color;
  final Color backgroundColor;
  final double density;
  final double twinkleSpeed;

  const SparkleParams({
    this.color = Colors.white,
    this.backgroundColor = Colors.transparent,
    this.density = 1.0,
    this.twinkleSpeed = 1.0,
    super.borderWidth,
    super.borderRadius,
    super.speed,
    super.glow,
  });

  @override
  String get shaderAsset => 'packages/flux_borders/assets/shaders/sparkle.frag';

  @override
  void setUniforms(FragmentShader shader) {
    shader.setFloat(5, color.r);
    shader.setFloat(6, color.g);
    shader.setFloat(7, color.b);
    shader.setFloat(8, backgroundColor.r);
    shader.setFloat(9, backgroundColor.g);
    shader.setFloat(10, backgroundColor.b);
    shader.setFloat(11, density);
    shader.setFloat(12, twinkleSpeed);
    shader.setFloat(13, glow);
  }
}
