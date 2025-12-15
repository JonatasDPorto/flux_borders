import 'dart:ui';
import 'package:flutter/material.dart';
import 'flux_border_params.dart';

class DottedParams extends FluxBorderParams {
  final Color color;
  final Color backgroundColor;
  final double dotSpacing;

  const DottedParams({
    this.color = Colors.white,
    this.backgroundColor = Colors.transparent,
    this.dotSpacing = 4.0,
    super.borderWidth,
    super.borderRadius,
    super.speed,
    super.glow,
  });

  @override
  String get shaderAsset => 'packages/flux_borders/assets/shaders/dotted.frag';

  @override
  void setUniforms(FragmentShader shader) {
    shader.setFloat(5, color.r);
    shader.setFloat(6, color.g);
    shader.setFloat(7, color.b);
    shader.setFloat(8, backgroundColor.r);
    shader.setFloat(9, backgroundColor.g);
    shader.setFloat(10, backgroundColor.b);
    shader.setFloat(11, dotSpacing);
    shader.setFloat(12, 0.0);

    shader.setFloat(13, glow);
  }

  @override
  bool get needsGlowPadding => true;
}
