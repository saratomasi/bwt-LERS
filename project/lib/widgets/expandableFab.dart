import 'package:flutter/material.dart' ;
import 'package:project/widgets/expandingActionButton.dart';

// Defines an ExpandableFab widget representing an expandable action button.
// The main button expands to reveal secondary action buttons and vice versa.
// Expansion animation is controlled by an AnimationController and managed by the widget's state.
// Main and secondary buttons are separate widgets (FloatingActionButton and ExpandingActionButton).

@immutable
class ExpandableFab extends StatefulWidget {
  const ExpandableFab({
    super.key,
    this.initialOpen,       // Boolean indicating whether the button should be initially open or not.
    required this.distance, // Max distance for positioning secondary action buttons relative to the main button.
    required this.children, // List of widgets to display as secondary action buttons
  });

  final bool? initialOpen;
  final double distance;
  final List<Widget> children;

  @override
  State<ExpandableFab> createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab> with SingleTickerProviderStateMixin{
  late final AnimationController _controller;    // handles the expansion and contraction animation of the main button.
  late final Animation<double> _expandAnimation; // represents the expansion animation.
  bool _open = false;                            // tracks the state of the button (open (true) or closed (false)).

  @override
  void initState() {
    super.initState();
    // Decide whether the button is initially open or closed based on the value of initialOpen.
    // initialOpen true -> _open true; initialOpen false or null -> _open false
    _open = widget.initialOpen ?? false;

    _controller = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
  }

  @override
  // Free up resources when the widget state is disposed.
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Toggles the button state and starts or cancels the expansion animation.
  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  // Builds the widget, calls private methods to build the main button, secondary action buttons, and close button.
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          _buildTapToCloseFab(),
          ..._buildExpandingActionButtons(),
          _buildTapToOpenFab(),
        ],
      ),
    );
  }

  // Build a circular close button with a close icon at the center. 
  // When pressed, it calls the _toggle method to close the main button.
  Widget _buildTapToCloseFab() {
    return SizedBox(
      width: 56,
      height: 56,
      child: Center(
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          elevation: 4,
          child: InkWell(
            onTap: _toggle,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.close,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildExpandingActionButtons() {
    final children = <Widget>[];
    final count = widget.children.length;
    final step = 90.0 / (count - 1);
    for (var i = 0, angleInDegrees = 135.0;
        i < count;
        i++, angleInDegrees -= step) {
      children.add(
        ExpandingActionButton(
          directionInDegrees: angleInDegrees,
          maxDistance: widget.distance,
          progress: _expandAnimation,
          child: widget.children[i],
        ),
      );
    }
    return children;
  }

  Widget _buildTapToOpenFab() {
    return IgnorePointer(
      ignoring: _open,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          _open ? 0.7 : 1.0,
          _open ? 0.7 : 1.0,
          1.0,
        ),
        duration: const Duration(milliseconds: 250),
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: _open ? 0.0 : 1.0,
          curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
          duration: const Duration(milliseconds: 250),
          child: FloatingActionButton(
            onPressed: _toggle,
            child: const Icon(Icons.hiking),
          ),
        ),
      ),
    );
  }
}