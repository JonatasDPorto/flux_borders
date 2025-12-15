import 'package:flutter/material.dart';
import 'package:flux_borders/flux_borders.dart';
import 'pages/snake_page.dart';
import 'pages/rainbow_page.dart';
import 'pages/electric_page.dart';
import 'pages/spotlight_page.dart';
import 'pages/dotted_page.dart';
import 'pages/slashed_page.dart';
import 'pages/wavy_page.dart';
import 'pages/helix_page.dart';
import 'pages/liquid_page.dart';
import 'pages/glitch_page.dart';
import 'pages/circuit_page.dart';
import 'pages/fire_page.dart';
import 'pages/sparkle_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flux Borders Gallery',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E1E1E),
          elevation: 0,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flux Borders Gallery"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildNavButton(
            context,
            "Snake Border",
            const SnakePage(),
            Colors.cyan,
            (child) => FluxBorder.snake(
              color: Colors.cyan,
              glow: 0.5,
              borderRadius: 15,
              child: child,
            ),
          ),
          _buildNavButton(
            context,
            "Rainbow Border",
            const RainbowPage(),
            Colors.purple,
            (child) =>
                FluxBorder.rainbow(glow: 0.5, borderRadius: 15, child: child),
          ),
          _buildNavButton(
            context,
            "Electric Border",
            const ElectricPage(),
            Colors.amber,
            (child) => FluxBorder.electric(
              color: Colors.amber,
              glow: 0.5,
              borderRadius: 15,
              child: child,
            ),
          ),
          _buildNavButton(
            context,
            "Spotlight Border",
            const SpotlightPage(),
            Colors.white,
            (child) => FluxBorder.spotlight(
              color: Colors.white,
              glow: 0.5,
              borderRadius: 15,
              child: child,
            ),
          ),
          _buildNavButton(
            context,
            "Dotted Border",
            const DottedPage(),
            Colors.pinkAccent,
            (child) => FluxBorder.dotted(
              color: Colors.pinkAccent,
              glow: 0.5,
              borderRadius: 15,
              child: child,
            ),
          ),
          _buildNavButton(
            context,
            "Slashed Border",
            const SlashedPage(),
            Colors.limeAccent,
            (child) => FluxBorder.slashed(
              color: Colors.limeAccent,
              glow: 0.5,
              borderRadius: 15,
              child: child,
            ),
          ),
          _buildNavButton(
            context,
            "Wavy Border",
            const WavyPage(),
            Colors.indigoAccent,
            (child) => FluxBorder.wavy(
              color: Colors.indigoAccent,
              glow: 0.5,
              borderRadius: 15,
              child: child,
            ),
          ),
          _buildNavButton(
            context,
            "Helix Border",
            const HelixPage(),
            Colors.tealAccent,
            (child) => FluxBorder.helix(
              color: Colors.tealAccent,
              glow: 0.1,
              borderRadius: 15,
              child: child,
            ),
          ),
          _buildNavButton(
            context,
            "Liquid Border",
            const LiquidPage(),
            Colors.deepOrangeAccent,
            (child) => FluxBorder.liquid(
              color: Colors.deepOrangeAccent,
              glow: 0.5,
              borderRadius: 15,
              child: child,
            ),
          ),
          _buildNavButton(
            context,
            "Glitch Border",
            const GlitchPage(),
            Colors.cyanAccent,
            (child) => FluxBorder.glitch(
              color: Colors.cyanAccent,
              glow: 0.5,
              borderRadius: 15,
              child: child,
            ),
          ),
          _buildNavButton(
            context,
            "Circuit Border",
            const CircuitPage(),
            Colors.green,
            (child) => FluxBorder.circuit(
              color: Colors.green,
              glow: 0.1,
              borderRadius: 15,
              child: child,
            ),
          ),
          _buildNavButton(
            context,
            "Fire Border",
            const FirePage(),
            Colors.deepOrange,
            (child) => FluxBorder.fire(
              color: Colors.deepOrange,
              glow: 0.5,
              borderRadius: 15,
              child: child,
            ),
          ),
          _buildNavButton(
            context,
            "Sparkle Border",
            const SparklePage(),
            Colors.white,
            (child) => FluxBorder.sparkle(
              color: Colors.white,
              glow: 0.1,
              borderRadius: 15,
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton(
    BuildContext context,
    String title,
    Widget page,
    Color color,
    Widget Function(Widget child) borderBuilder,
  ) {
    Widget buttonContent = Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(15),
        // Remove border side here as FluxBorder handles it
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Icon(Icons.arrow_forward_ios, color: color, size: 20),
        ],
      ),
    );

    // Apply the specific border
    Widget borderedButton = borderBuilder(buttonContent);

    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        child: borderedButton,
      ),
    );
  }
}
