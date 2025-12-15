import 'package:flutter/material.dart';
import 'package:flux_borders/flux_borders.dart';
import '../widgets/example_content.dart';
import '../widgets/demo_box.dart';

class SlashedPage extends StatefulWidget {
  const SlashedPage({super.key});

  @override
  State<SlashedPage> createState() => _SlashedPageState();
}

class _SlashedPageState extends State<SlashedPage> {
  bool _isPlaying = true;
  double _glowValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Slashed Border Examples"),
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
              title: "Construction Tape",
              child: FluxBorder.slashed(
                glow: _glowValue,
                speed: 1.0 * (_isPlaying ? 1.0 : 0.0),
                child: const DemoBox(),
              ),
            ),
            ExampleContent(
              title: "High Voltage Tape",
              child: FluxBorder.slashed(
                color: Colors.cyanAccent,
                backgroundColor: Colors.blueGrey.shade900,
                glow: _glowValue,
                speed: 1.0 * (_isPlaying ? 1.0 : 0.0),
                child: const DemoBox(),
              ),
            ),
            ExampleContent(
              title: "Long Dashes",
              child: FluxBorder.slashed(
                color: Colors.cyanAccent,
                dashRatio: 0.8,
                dashSpacing: 3.0,
                glow: _glowValue,
                speed: 1.0 * (_isPlaying ? 1.0 : 0.0),
                child: const DemoBox(),
              ),
            ),
            ExampleContent(
              title: "Short Blips",
              child: FluxBorder.slashed(
                color: Colors.redAccent,
                dashRatio: 0.2,
                dashSpacing: 4.0,
                glow: _glowValue,
                speed: 1.0 * (_isPlaying ? 1.0 : 0.0),
                child: const DemoBox(),
              ),
            ),
            ExampleContent(
              title: "Wide Spacing",
              child: FluxBorder.slashed(
                color: Colors.white,
                dashSpacing: 6.0,
                borderWidth: 4.0,
                glow: _glowValue,
                speed: 1.0 * (_isPlaying ? 1.0 : 0.0),
                child: const DemoBox(),
              ),
            ),
            ExampleContent(
              title: "Dense",
              child: FluxBorder.slashed(
                color: Colors.purple,
                dashSpacing: 1.5,
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
