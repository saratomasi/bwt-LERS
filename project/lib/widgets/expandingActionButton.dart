import 'package:flutter/material.dart' ;
import 'dart:math' as math;

// Custom Flutter widget ExpandingActionButton: an animated button that expands,
// rotates, and fades based on a progress value (0 to 1). It can move in any 
// direction (specified in degrees) up to a maximum distance.

@immutable
class ExpandingActionButton extends StatelessWidget {
  const ExpandingActionButton({
    required this.directionInDegrees, // Button movement direction in degrees.
    required this.maxDistance,        // Maximum distance the button travels.
    required this.progress,           // Animation value (0 to 1) controlling position and rotation.
    required this.child,              // The button's content widget.
  });

  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      // animation: progress: An Animation<double> instance controlling the animation.
      // AnimatedBuilder rebuilds its children whenever progress changes.
      // builder: A function defining how to build the widget whenever the animation changes.
      builder: (context, child,) {
        // Offset.fromDirection: Creates an Offset object based on angular direction and distance.
        // directionInDegrees * (math.pi / 180.0): Converts degrees to radians.
        // progress.value * maxDistance: Multiplies current animation value by max distance, determining button movement.
        final offset = Offset.fromDirection(
          directionInDegrees * (math.pi / 180.0),
          progress.value * maxDistance,
        );
        // Positioned: Positions the child widget within a positioned layout container.
        // right: 160 + offset.dx: Places the widget at a fixed distance of 160 pixels from the right edge, plus the offset along the x-axis.
        // bottom: offset.dy: Positions the widget at a distance from the bottom edge based on the offset along the y-axis.
        return Positioned(
          right: MediaQuery.of(context).size.width / 2 - 28 - 10 - offset.dx, // Screen width/2 diviso per 2 - fab width/2 - padding - offset.dx
          bottom: offset.dy,
          child: Transform.rotate(
            angle: (1.0 - progress.value) * math.pi / 2,
            child: child!,
          ),
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}