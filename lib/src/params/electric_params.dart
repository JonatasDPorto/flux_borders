import 'dart:ui';
import 'package:flutter/material.dart';
import 'flux_border_params.dart';

class ElectricParams extends FluxBorderParams {
  final Color color;
  final Color backgroundColor;

  const ElectricParams({
    this.color = Colors.purpleAccent,
    this.backgroundColor = Colors.black,
    super.borderWidth,
    super.borderRadius,
    super.speed,
    super.glow,
  });

  @override
  String get shaderAsset =>
      'packages/flux_borders/assets/shaders/electric.frag';

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
