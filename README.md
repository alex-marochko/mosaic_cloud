# Mosaic Cloud

A Flutter widget that arranges a collection of widgets in a visually appealing, dense mosaic layout. Perfect for creating
orthogonal word clouds, skill showcases, or any other creative composition.

The package uses a spiral-based algorithm to efficiently pack children without overlaps, supporting both horizontal and
vertical orientations.

![Example Animation](https://github.com/alex-marochko/mosaic_cloud/blob/main/assets/example.gif?raw=true)

*The animation shown above is an example of what you can achieve by combining `MosaicCloud` with Flutter's built-in
animation widgets. The package itself focuses purely on providing the layout algorithm.*

## Features

-   Arranges any collection of widgets in a dense, spiral-based mosaic.
-   Highly performant, using `CustomMultiChildLayout` for efficiency.
-   Simple and easy-to-use API.

## Getting started

To use this package, add `mosaic_cloud` as a dependency in your `pubspec.yaml` file.

```yaml
dependencies:
  mosaic_cloud: ^0.1.0 # Or the latest version
```

Then, import the package in your Dart code:

import 'package:mosaic_cloud/mosaic_cloud.dart';


## Usage

The basic usage is very simple. Just provide a list of widgets to the `MosaicCloud`.

```dart
import 'package:flutter/material.dart';
import 'package:mosaic_cloud/mosaic_cloud.dart';

class BasicMosaicScreen extends StatelessWidget {
   const BasicMosaicScreen({super.key});

@override
Widget build(BuildContext context) {
return Scaffold(
  body: const Center(
      child: MosaicCloud(
        children: [
          Text('Flutter'),
          Text('Dart'),
          RotatedBox(quarterTurns: 3, child: Text('Clean Architecture')),
          Text('BLoC'),
          Text('Firebase'),
          RotatedBox(quarterTurns: 3, child: Text('SOLID')),
          // ... and any other widget you want!
        ],
        ),
      ),
    );
  }
}
```


### Adding Animations

To create an animated effect like the one in the demo, you can wrap your children with any of Flutter's animation widgets.
Here is a simplified example of a staggered fade-in animation.

You would typically use a `StatefulWidget` with an `AnimationController` to drive the animations.

```dart
class AnimatedMosaicExample extends StatefulWidget {
    const AnimatedMosaicExample({super.key});

    @override
    State<AnimatedMosaicExample> createState() => _AnimatedMosaicExampleState();
}

class _AnimatedMosaicExampleState extends State<AnimatedMosaicExample> with SingleTickerProviderStateMixin {
late AnimationController _controller;

    final List<Widget> _skills = [
      Text('Flutter'),
      Text('Dart'),
      Text('BLoC'),
      // ... more widgets
    ];


    @override
    void initState() {
      super.initState();
      _controller = AnimationController(
        duration: const Duration(seconds: 2),
        vsync: this,
      )..forward();
    }

    @override
    void dispose() {
      _controller.dispose();
      super.dispose();
    }


    @override
    Widget build(BuildContext context) {
      return MosaicCloud(
        children: List.generate(_skills.length, (index) {
          final animation = CurvedAnimation(
            parent: _controller,
            curve: Interval((index / _skills.length) * 0.5, 1.0, curve: Curves.easeOut),
          );
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: animation,
              child: _skills[index],
            ),
          );
        }),
      );
    }
}
```


## Additional information

This package was developed by **Alex Marochko** as part of a portfolio project. Contributions, issues, and feature requests are
welcome!

Please visit the [GitHub repository](https://github.com/alex-marochko/mosaic_cloud) to see the full implementation and
example.
