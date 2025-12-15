import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../params/flux_border_params.dart';
import '../params/snake_params.dart';
import '../params/rainbow_params.dart';
import '../params/electric_params.dart';
import '../params/spotlight_params.dart';
import '../params/dotted_params.dart';
import '../params/slashed_params.dart';
import '../params/wavy_params.dart';
import '../params/helix_params.dart';
import '../params/liquid_params.dart';
import '../params/glitch_params.dart';
import '../params/circuit_params.dart';
import '../params/fire_params.dart';
import '../params/sparkle_params.dart';

class FluxBorder extends StatefulWidget {
  final Widget child;
  final FluxBorderParams params;

  const FluxBorder({super.key, required this.child, required this.params});

  factory FluxBorder.snake({
    required Widget child,
    Color color = const Color(0xFF00FFFF),
    Color backgroundColor = const Color(0xFF2C2C2C),
    double borderWidth = 3.0,
    double borderRadius = 16.0,
    double speed = 1.0,
    double glow = 0.0,
  }) {
    return FluxBorder(
      params: SnakeParams(
        color: color,
        backgroundColor: backgroundColor,
        borderWidth: borderWidth,
        borderRadius: borderRadius,
        speed: speed,
        glow: glow,
      ),
      child: child,
    );
  }

  factory FluxBorder.rainbow({
    required Widget child,
    double borderWidth = 3.0,
    double borderRadius = 16.0,
    double speed = 1.0,
    double glow = 0.0,
  }) {
    return FluxBorder(
      params: RainbowParams(
        borderWidth: borderWidth,
        borderRadius: borderRadius,
        speed: speed,
        glow: glow,
      ),
      child: child,
    );
  }

  factory FluxBorder.electric({
    required Widget child,
    Color color = Colors.purpleAccent,
    Color backgroundColor = Colors.black,
    double borderWidth = 3.0,
    double borderRadius = 16.0,
    double speed = 1.0,
    double glow = 0.0,
  }) {
    return FluxBorder(
      params: ElectricParams(
        color: color,
        backgroundColor: backgroundColor,
        borderWidth: borderWidth,
        borderRadius: borderRadius,
        speed: speed,
        glow: glow,
      ),
      child: child,
    );
  }

  factory FluxBorder.spotlight({
    required Widget child,
    Color color = Colors.white,
    Color backgroundColor = const Color(0xFF212121),
    double borderWidth = 3.0,
    double borderRadius = 16.0,
    double speed = 1.0,
    double glow = 0.0,
  }) {
    return FluxBorder(
      params: SpotlightParams(
        color: color,
        backgroundColor: backgroundColor,
        borderWidth: borderWidth,
        borderRadius: borderRadius,
        speed: speed,
        glow: glow,
      ),
      child: child,
    );
  }

  factory FluxBorder.dotted({
    required Widget child,
    Color color = Colors.white,
    Color backgroundColor = Colors.transparent,
    double borderWidth = 3.0,
    double borderRadius = 16.0,
    double dotSpacing = 4.0,
    double speed = 1.0,
    double glow = 0.0,
  }) {
    return FluxBorder(
      params: DottedParams(
        color: color,
        backgroundColor: backgroundColor,
        borderWidth: borderWidth,
        borderRadius: borderRadius,
        dotSpacing: dotSpacing,
        speed: speed,
        glow: glow,
      ),
      child: child,
    );
  }

  factory FluxBorder.slashed({
    required Widget child,
    Color color = Colors.yellow,
    Color backgroundColor = Colors.black,
    double borderWidth = 3.0,
    double borderRadius = 16.0,
    double dashSpacing = 3.0,
    double dashRatio = 0.5,
    double speed = 1.0,
    double glow = 0.0,
  }) {
    return FluxBorder(
      params: SlashedParams(
        color: color,
        backgroundColor: backgroundColor,
        borderWidth: borderWidth,
        borderRadius: borderRadius,
        dashSpacing: dashSpacing,
        dashRatio: dashRatio,
        speed: speed,
        glow: glow,
      ),
      child: child,
    );
  }

  factory FluxBorder.wavy({
    required Widget child,
    Color color = Colors.blue,
    Color backgroundColor = Colors.transparent,
    double borderWidth = 3.0,
    double borderRadius = 16.0,
    double wavelength = 4.0,
    double amplitude = 0.5,
    double speed = 1.0,
    double glow = 0.0,
  }) {
    return FluxBorder(
      params: WavyParams(
        color: color,
        backgroundColor: backgroundColor,
        borderWidth: borderWidth,
        borderRadius: borderRadius,
        wavelength: wavelength,
        amplitude: amplitude,
        speed: speed,
        glow: glow,
      ),
      child: child,
    );
  }

  factory FluxBorder.helix({
    required Widget child,
    Color color = Colors.cyanAccent,
    Color backgroundColor = Colors.transparent,
    double borderWidth = 3.0,
    double borderRadius = 16.0,
    double frequency = 4.0,
    double amplitude = 0.5,
    double speed = 1.0,
    double glow = 0.0,
  }) {
    return FluxBorder(
      params: HelixParams(
        color: color,
        backgroundColor: backgroundColor,
        borderWidth: borderWidth,
        borderRadius: borderRadius,
        frequency: frequency,
        amplitude: amplitude,
        speed: speed,
        glow: glow,
      ),
      child: child,
    );
  }

  factory FluxBorder.liquid({
    required Widget child,
    Color color = Colors.orangeAccent,
    Color backgroundColor = Colors.transparent,
    double borderWidth = 3.0,
    double borderRadius = 16.0,
    double frequency = 3.0,
    double viscosity = 1.0,
    double speed = 1.0,
    double glow = 0.0,
  }) {
    return FluxBorder(
      params: LiquidParams(
        color: color,
        backgroundColor: backgroundColor,
        borderWidth: borderWidth,
        borderRadius: borderRadius,
        frequency: frequency,
        viscosity: viscosity,
        speed: speed,
        glow: glow,
      ),
      child: child,
    );
  }

  factory FluxBorder.glitch({
    required Widget child,
    Color color = Colors.cyanAccent,
    Color backgroundColor = Colors.transparent,
    double borderWidth = 3.0,
    double borderRadius = 16.0,
    double intensity = 1.0,
    double segmentSize = 1.0,
    double speed = 1.0,
    double glow = 0.0,
  }) {
    return FluxBorder(
      params: GlitchParams(
        color: color,
        backgroundColor: backgroundColor,
        borderWidth: borderWidth,
        borderRadius: borderRadius,
        intensity: intensity,
        segmentSize: segmentSize,
        speed: speed,
        glow: glow,
      ),
      child: child,
    );
  }

  factory FluxBorder.circuit({
    required Widget child,
    Color color = const Color(0xFF00FF00),
    Color backgroundColor = Colors.transparent,
    double borderWidth = 3.0,
    double borderRadius = 16.0,
    double traceLength = 1.0,
    double density = 1.0,
    double speed = 1.0,
    double glow = 0.0,
  }) {
    return FluxBorder(
      params: CircuitParams(
        color: color,
        backgroundColor: backgroundColor,
        borderWidth: borderWidth,
        borderRadius: borderRadius,
        traceLength: traceLength,
        density: density,
        speed: speed,
        glow: glow,
      ),
      child: child,
    );
  }

  factory FluxBorder.fire({
    required Widget child,
    Color color = Colors.deepOrange,
    Color backgroundColor = Colors.transparent,
    double borderWidth = 3.0,
    double borderRadius = 16.0,
    double flameHeight = 1.0,
    double turbulence = 1.0,
    double speed = 1.0,
    double glow = 0.0,
  }) {
    return FluxBorder(
      params: FireParams(
        color: color,
        backgroundColor: backgroundColor,
        borderWidth: borderWidth,
        borderRadius: borderRadius,
        flameHeight: flameHeight,
        turbulence: turbulence,
        speed: speed,
        glow: glow,
      ),
      child: child,
    );
  }

  factory FluxBorder.sparkle({
    required Widget child,
    Color color = Colors.white,
    Color backgroundColor = Colors.transparent,
    double borderWidth = 3.0,
    double borderRadius = 16.0,
    double density = 1.0,
    double twinkleSpeed = 1.0,
    double speed = 1.0,
    double glow = 0.0,
  }) {
    return FluxBorder(
      params: SparkleParams(
        color: color,
        backgroundColor: backgroundColor,
        borderWidth: borderWidth,
        borderRadius: borderRadius,
        density: density,
        twinkleSpeed: twinkleSpeed,
        speed: speed,
        glow: glow,
      ),
      child: child,
    );
  }

  @override
  State<FluxBorder> createState() => _FluxBorderState();
}

class _FluxBorderState extends State<FluxBorder>
    with SingleTickerProviderStateMixin {
  FragmentShader? _shader;
  late Ticker _ticker;
  double _time = 0.0;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_tick);
    _loadShader();
  }

  @override
  void didUpdateWidget(FluxBorder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.params.shaderAsset != widget.params.shaderAsset) {
      _loadShader();
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void _tick(Duration elapsed) {
    if (!mounted) return;
    setState(() {
      _time = elapsed.inMilliseconds / 1000.0;
    });
  }

  Future<void> _loadShader() async {
    try {
      final program = await FragmentProgram.fromAsset(
        widget.params.shaderAsset,
      );

      if (mounted) {
        setState(() {
          _shader = program.fragmentShader();
          _initialized = true;
          if (!_ticker.isActive) {
            _ticker.start();
          }
        });
      }
    } catch (e) {
      debugPrint('Error loading shader: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized || _shader == null) {
      return Padding(
        padding: EdgeInsets.all(widget.params.borderWidth / 2.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            (widget.params.borderRadius - widget.params.borderWidth / 2.0)
                .clamp(0.0, double.infinity),
          ),
          child: widget.child,
        ),
      );
    }

    double extraGlowSpace =
        (widget.params.glow > 0.0 && widget.params.needsGlowPadding)
        ? (widget.params.borderWidth * 3.0).clamp(15.0, 50.0)
        : 0.0;

    return CustomPaint(
      foregroundPainter: _FluxBorderPainter(
        shader: _shader!,
        time: _time,
        params: widget.params,
      ),
      child: Padding(
        padding: EdgeInsets.all(
          widget.params.borderWidth / 2.0 + extraGlowSpace,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            (widget.params.borderRadius - widget.params.borderWidth / 2.0)
                .clamp(0.0, double.infinity),
          ),
          child: widget.child,
        ),
      ),
    );
  }
}

class _FluxBorderPainter extends CustomPainter {
  final FragmentShader shader;
  final double time;
  final FluxBorderParams params;

  _FluxBorderPainter({
    required this.shader,
    required this.time,
    required this.params,
  });

  @override
  void paint(Canvas canvas, Size size) {
    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);

    shader.setFloat(2, time * params.speed);

    double extraGlowSpace = (params.glow > 0.0 && params.needsGlowPadding)
        ? (params.borderWidth * 3.0).clamp(15.0, 50.0)
        : 0.0;

    double innerRadius = params.borderRadius - params.borderWidth;
    if (innerRadius < 0) innerRadius = 0;

    double centerRadius = innerRadius + params.borderWidth / 2.0;

    shader.setFloat(3, centerRadius);

    shader.setFloat(4, params.borderWidth);

    params.setUniforms(shader);

    shader.setFloat(14, extraGlowSpace);

    final paint = Paint()..shader = shader;
    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(covariant _FluxBorderPainter oldDelegate) {
    return oldDelegate.time != time || oldDelegate.params != params;
  }
}
