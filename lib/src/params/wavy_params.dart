import 'dart:ui';
import 'package:flutter/material.dart';
import 'flux_border_params.dart';

class WavyParams extends FluxBorderParams {
  final Color color;
  final Color backgroundColor;

  /// The wavelength relative to the border width.
  /// Higher values mean longer waves (lower frequency). Default 4.0.
  final double wavelength;

  /// The amplitude of the wave relative to the border width.
  /// 0.5 means the wave peak is half the border width. Default 0.5.
  final double amplitude;

  const WavyParams({
    this.color = Colors.blue,
    this.backgroundColor = Colors.transparent,
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

    // uParam1: Wavelength
    shader.setFloat(11, wavelength);
    // uParam2: Amplitude
    shader.setFloat(12, amplitude);
    // uGlow
    shader.setFloat(13, glow);
  }

  @override
  bool get needsGlowPadding => true;
}
