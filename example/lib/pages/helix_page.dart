import 'package:flutter/material.dart';
import 'package:flux_borders/flux_borders.dart';
import '../widgets/example_content.dart';
import '../widgets/demo_box.dart';

class HelixPage extends StatefulWidget {
  const HelixPage({super.key});

  @override
  State<HelixPage> createState() => _HelixPageState();
}

class _HelixPageState extends State<HelixPage> {
  bool _isPlaying = true;
  double _glowValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Helix Border Examples"),
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
              title: "Standard DNA",
              child: FluxBorder.helix(
                glow: _glowValue,
                speed: 1.0 * (_isPlaying ? 1.0 : 0.0),
                child: const DemoBox(),
              ),
            ),
            ExampleContent(
              title: "High Tech (Green)",
              child: FluxBorder.helix(
                color: Colors.greenAccent,
                frequency: 6.0,
                glow: _glowValue,
                speed: 1.5 * (_isPlaying ? 1.0 : 0.0),
                child: const DemoBox(),
              ),
            ),
            ExampleContent(
              title: "Thick & Slow",
              child: FluxBorder.helix(
                color: Colors.purpleAccent,
                borderWidth: 6.0,
                amplitude: 0.3,
                frequency: 3.0,
                glow: _glowValue,
                speed: 0.5 * (_isPlaying ? 1.0 : 0.0),
                child: const DemoBox(),
              ),
            ),
            ExampleContent(
              title: "Tight Twist",
              child: FluxBorder.helix(
                color: Colors.redAccent,
                frequency: 8.0,
                amplitude: 0.2,
                glow: _glowValue,
                speed: 1.0 * (_isPlaying ? 1.0 : 0.0),
                child: const DemoBox(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

