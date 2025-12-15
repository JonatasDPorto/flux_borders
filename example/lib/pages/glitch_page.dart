import 'package:flutter/material.dart';
import 'package:flux_borders/flux_borders.dart';
import '../widgets/example_content.dart';
import '../widgets/demo_box.dart';

class GlitchPage extends StatefulWidget {
  const GlitchPage({super.key});

  @override
  State<GlitchPage> createState() => _GlitchPageState();
}

class _GlitchPageState extends State<GlitchPage> {
  bool _isPlaying = true;
  double _glowValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Glitch Border Examples"),
        actions: [
          IconButton(
            icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
            onPressed: () {
              setState(() {
                _isPlaying = !_isPlaying;
              });
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                const Text("Glow: ", style: TextStyle(color: Colors.white70)),
                Expanded(
                  child: Slider(
                    value: _glowValue,
                    min: 0.0,
                    max: 1.0,
                    divisions: 10,
                    label: _glowValue.toStringAsFixed(1),
                    onChanged: (value) {
                      setState(() {
                        _glowValue = value;
                      });
                    },
                  ),
                ),
                Text(
                  _glowValue.toStringAsFixed(1),
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ExampleContent(
              title: "Standard Glitch",
              child: FluxBorder.glitch(
                glow: _glowValue,
                speed: 1.0 * (_isPlaying ? 1.0 : 0.0),
                child: const DemoBox(),
              ),
            ),
            ExampleContent(
              title: "Heavy Distortion",
              child: FluxBorder.glitch(
                color: Colors.purpleAccent,
                intensity: 2.0,
                glow: _glowValue,
                speed: 1.0 * (_isPlaying ? 1.0 : 0.0),
                child: const DemoBox(),
              ),
            ),
            ExampleContent(
              title: "Fine Digital Noise",
              child: FluxBorder.glitch(
                color: Colors.greenAccent,
                segmentSize: 0.2,
                glow: _glowValue,
                speed: 1.0 * (_isPlaying ? 1.0 : 0.0),
                child: const DemoBox(),
              ),
            ),
            ExampleContent(
              title: "Slow Corruption",
              child: FluxBorder.glitch(
                color: Colors.redAccent,
                speed: 0.2 * (_isPlaying ? 1.0 : 0.0),
                glow: _glowValue,
                child: const DemoBox(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
