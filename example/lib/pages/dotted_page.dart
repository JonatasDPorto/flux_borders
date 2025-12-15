import 'package:flutter/material.dart';
import 'package:flux_borders/flux_borders.dart';
import '../widgets/example_content.dart';
import '../widgets/demo_box.dart';

class DottedPage extends StatefulWidget {
  const DottedPage({super.key});

  @override
  State<DottedPage> createState() => _DottedPageState();
}

class _DottedPageState extends State<DottedPage> {
  bool _isPlaying = true;
  double _glowValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dotted Border Examples"),
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
              title: "Standard White Dots",
              child: FluxBorder.dotted(
                glow: _glowValue,
                speed: 1.0 * (_isPlaying ? 1.0 : 0.0),
                child: const DemoBox(),
              ),
            ),
            ExampleContent(
              title: "Dense Blue Dots",
              child: FluxBorder.dotted(
                color: Colors.blueAccent,
                dotSpacing: 1.5,
                glow: _glowValue,
                speed: 1.0 * (_isPlaying ? 1.0 : 0.0),
                child: const DemoBox(),
              ),
            ),
            ExampleContent(
              title: "Sparse Pink Dots",
              child: FluxBorder.dotted(
                color: Colors.pinkAccent,
                dotSpacing: 8.0,
                borderWidth: 4.0,
                glow: _glowValue,
                speed: 1.0 * (_isPlaying ? 1.0 : 0.0),
                child: const DemoBox(),
              ),
            ),
            ExampleContent(
              title: "Big Dots",
              child: FluxBorder.dotted(
                color: Colors.yellow,
                borderWidth: 8.0,
                dotSpacing: 2.0,
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
