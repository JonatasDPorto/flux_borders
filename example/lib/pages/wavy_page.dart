import 'package:flutter/material.dart';
import 'package:flux_borders/flux_borders.dart';
import '../widgets/example_content.dart';
import '../widgets/demo_box.dart';

class WavyPage extends StatefulWidget {
  const WavyPage({super.key});

  @override
  State<WavyPage> createState() => _WavyPageState();
}

class _WavyPageState extends State<WavyPage> {
  bool _isPlaying = true;
  double _glowValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wavy Border Examples"),
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
              title: "Standard Waves",
              child: FluxBorder.wavy(
                glow: _glowValue,
                speed: 1.0 * (_isPlaying ? 1.0 : 0.0),
                child: const DemoBox(),
              ),
            ),
            ExampleContent(
              title: "High Amplitude",
              child: FluxBorder.wavy(
                color: Colors.pinkAccent,
                amplitude: 1.0,
                glow: _glowValue,
                speed: 1.0 * (_isPlaying ? 1.0 : 0.0),
                child: const DemoBox(),
              ),
            ),
            ExampleContent(
              title: "High Frequency (Short Wavelength)",
              child: FluxBorder.wavy(
                color: Colors.greenAccent,
                wavelength: 1.5,
                glow: _glowValue,
                speed: 1.0 * (_isPlaying ? 1.0 : 0.0),
                child: const DemoBox(),
              ),
            ),
            ExampleContent(
              title: "Gentle Ocean",
              child: FluxBorder.wavy(
                color: Colors.cyan,
                wavelength: 6.0,
                amplitude: 0.3,
                borderWidth: 5.0,
                glow: _glowValue,
                speed: 0.5 * (_isPlaying ? 1.0 : 0.0),
                child: const DemoBox(),
              ),
            ),
            ExampleContent(
              title: "Static Stamp Edge",
              child: FluxBorder.wavy(
                color: Colors.orange,
                wavelength: 2.0,
                amplitude: 0.2,
                glow: _glowValue,
                speed: 0.0, // Static
                child: const DemoBox(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
