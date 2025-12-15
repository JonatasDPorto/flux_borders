import 'dart:ui';
import 'package:flutter/material.dart';
import 'flux_border_params.dart';

class FireParams extends FluxBorderParams {
  final Color color;
  final Color backgroundColor;
  final double flameHeight;
  final double turbulence;

  const FireParams({
    this.color = Colors.deepOrange,
    this.backgroundColor = Colors.transparent,
    this.flameHeight = 1.0,
    this.turbulence = 1.0,
    super.borderWidth,
    super.borderRadius,
    super.speed,
    super.glow,
  });

  @override
  String get shaderAsset => 'packages/flux_borders/assets/shaders/fire.frag';

  @override
  void setUniforms(FragmentShader shader) {
    shader.setFloat(5, color.r);
    shader.setFloat(6, color.g);
    shader.setFloat(7, color.b);
    shader.setFloat(8, backgroundColor.r);
    shader.setFloat(9, backgroundColor.g);
    shader.setFloat(10, backgroundColor.b);
    shader.setFloat(11, flameHeight);
    shader.setFloat(12, turbulence);
    shader.setFloat(13, glow);
  }
}
