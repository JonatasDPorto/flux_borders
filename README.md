# Flux Borders

A high-performance Flutter package for creating stunning, animated, and customizable borders using Fragment Shaders (GLSL).

Flux Borders allows you to add unique visual effects to your Flutter widgets with minimal performance impact, thanks to hardware-accelerated shaders.

## Features

📹 **[Watch the demo video](https://github.com/user-attachments/assets/f1248248-b3e8-489f-9a7f-edce5f451f52)**

*   **High Performance**: Uses Fragment Shaders (`.frag`) for smooth animations (60 FPS+).
*   **Diverse Effects**: Includes 13+ unique border types ranging from classic Neon to complex effects like Fire, Liquid, and Circuit.
*   **Highly Customizable**: Adjust colors, speeds, widths, spacing, and more.
*   **Global Parameters**:
    *   **Glow**: Add a beautiful outer glow to any border.
    *   **Speed**: Control animation speed and direction (positive for clockwise, negative for counter-clockwise, 0 for static).
    *   **Responsive**: Automatically adapts to widget size and border radius.

## Installation

Add `flux_borders` to your `pubspec.yaml`:

```yaml
dependencies:
  flux_borders: ^0.0.1
```

Then run:

```bash
flutter pub get
```

## Basic Usage

Wrap any widget with `FluxBorder` using one of the factory constructors:

```dart
import 'package:flux_borders/flux_borders.dart';

FluxBorder.snake(
  color: Colors.cyanAccent,
  borderWidth: 4.0,
  borderRadius: 12.0,
  glow: 0.5, // Add a nice glow effect
  child: Container(
    padding: const EdgeInsets.all(20),
    child: const Text("Hello World"),
  ),
);
```

## Available Borders

### 1. Snake
A solid line that chases itself around the border.

```dart
FluxBorder.snake(
  color: Colors.cyan,
  backgroundColor: Colors.grey[900]!,
  child: myWidget,
)
```

### 2. Rainbow
A rotating gradient of full spectrum colors.

```dart
FluxBorder.rainbow(
  speed: 1.5,
  child: myWidget,
)
```

### 3. Electric
Simulates electrical current flowing through the border.

```dart
FluxBorder.electric(
  color: Colors.purpleAccent,
  child: myWidget,
)
```

### 4. Spotlight
A spotlight effect that moves around the border, illuminating it.

```dart
FluxBorder.spotlight(
  color: Colors.white,
  child: myWidget,
)
```

### 5. Dotted
Moving dots with customizable spacing.

```dart
FluxBorder.dotted(
  color: Colors.amber,
  dotSpacing: 10.0,
  child: myWidget,
)
```

### 6. Slashed
Moving diagonal slashes.

```dart
FluxBorder.slashed(
  color: Colors.lime,
  dashSpacing: 5.0,
  dashRatio: 0.5,
  child: myWidget,
)
```

### 7. Wavy
A sinusoidal wave pattern that flows around the border.

```dart
FluxBorder.wavy(
  color: Colors.blueAccent,
  amplitude: 0.5,
  wavelength: 4.0,
  child: myWidget,
)
```

### 8. Helix
A double-helix DNA-like structure.

```dart
FluxBorder.helix(
  color: Colors.pink,
  frequency: 3.0,
  child: myWidget,
)
```

### 9. Liquid
A fluid, organic blob effect that flows within the border.

```dart
FluxBorder.liquid(
  color: Colors.teal,
  viscosity: 0.8,
  child: myWidget,
)
```

### 10. Glitch
Digital glitch artifacts and noise.

```dart
FluxBorder.glitch(
  color: Colors.greenAccent,
  intensity: 0.8,
  child: myWidget,
)
```

### 11. Circuit
Tech-inspired circuit board traces appearing and disappearing.

```dart
FluxBorder.circuit(
  color: Colors.green,
  density: 0.7,
  child: myWidget,
)
```

### 12. Fire
Realistic fire effect burning around the edges.

```dart
FluxBorder.fire(
  color: Colors.orange,
  turbulence: 1.2,
  child: myWidget,
)
```

### 13. Sparkle
Twinkling stars or particles.

```dart
FluxBorder.sparkle(
  color: Colors.white,
  density: 0.9,
  child: myWidget,
)
```

## Customization Parameters

Most borders share these common parameters:

| Parameter | Type | Default | Description |
|---|---|---|---|
| `child` | `Widget` | Required | The content widget. |
| `borderWidth` | `double` | `3.0` | Thickness of the border. |
| `borderRadius` | `double` | `16.0` | Radius of the corners. |
| `speed` | `double` | `1.0` | Animation speed. Negative values reverse direction. `0.0` stops animation. |
| `glow` | `double` | `0.0` | Intensity of the outer glow (0.0 to 1.0 recommended). |
| `color` | `Color` | varies | Primary color of the effect. |
| `backgroundColor` | `Color` | `transparent` | Color behind the effect (inside the border). |

Each border type may have specific parameters (like `dotSpacing`, `wavelength`, `viscosity`, etc.) exposed in their respective factory constructors.

## License

MIT License
