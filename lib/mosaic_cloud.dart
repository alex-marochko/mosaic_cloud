import 'package:flutter/material.dart';
import 'dart:math';

class MosaicCloud extends StatelessWidget {
  final List<Widget> children;
  final double spacing;

  const MosaicCloud({super.key, required this.children, this.spacing = 4.0});

  @override
  Widget build(BuildContext context) {
    return CustomMultiChildLayout(
      delegate: MosaicLayoutDelegate(childCount: children.length, spacing: spacing),
      children: [
        for (int i = 0; i < children.length; i++)
          LayoutId(
            id: i,
            child: children[i],
          ),
      ],
    );
  }
}

@visibleForTesting
class MosaicLayoutDelegate extends MultiChildLayoutDelegate {
  final int childCount;
  final double spacing;

  MosaicLayoutDelegate({required this.childCount, required this.spacing});

  @override
  void performLayout(Size size) {
    final center = size.center(Offset.zero);
    final List<Rect> placedRects = [];

    for (int i = 0; i < childCount; i++) {
      if (hasChild(i)) {
        final childSize = layoutChild(i, BoxConstraints.loose(size));

        Rect childRect;
        if (i == 0) {
          // Place the first child in the center
          final firstChildPosition = center - Offset(childSize.width / 2, childSize.height / 2);
          positionChild(i, firstChildPosition);
          childRect = firstChildPosition & childSize;
        } else {
          // Use a spiral algorithm to find the next position
          childRect = _findNextPosition(childSize, placedRects);
          positionChild(i, childRect.topLeft);
        }
        placedRects.add(childRect);
      }
    }
  }

  Rect _findNextPosition(Size childSize, List<Rect> placedRects) {
    // Simple spiral placement algorithm.
    // This is a basic implementation and can be optimized.
    const double angleStep = 0.2; // The angle increment for the spiral.
                                 // Smaller values are more accurate but slower.
    double step = 10.0;
    double angle = 0.0;
    double distance = step;
    int turns = 0;

    while (true) {
      final point = Offset(
        distance * cos(angle),
        distance * sin(angle),
      ) +
          placedRects.first.center; // Spiral out from the center of the first item

      final candidateRect = Rect.fromCenter(
        center: point,
        width: childSize.width,
        height: childSize.height,
      );

      bool intersects = false;
      for (final rect in placedRects) {
        if (candidateRect.overlaps(rect.inflate(spacing))) {
          // Use the spacing parameter
          intersects = true;
          break;
        }
      }

      if (!intersects) {
        return candidateRect;
      }

      angle += angleStep; // Adjust for tighter/looser spiral
      if (angle > 2 * pi) {
        angle = 0;
        turns++;
        distance += step * (turns / 2); // Increase distance after each full turn
      }
    }
  }

  @override
  bool shouldRelayout(covariant MosaicLayoutDelegate oldDelegate) {
    return oldDelegate.childCount != childCount ||
        oldDelegate.spacing != spacing;
  }
}