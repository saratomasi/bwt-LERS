import 'package:flutter/material.dart' ;

@immutable
class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    this.onPressed,
    required this.icon,
    required this.text,
  });

  final VoidCallback? onPressed;
  final Widget icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text),
        Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          color: theme.colorScheme.secondary,
          elevation: 4,
          child: IconButton(
            onPressed: onPressed,
            icon: icon,
            color: theme.colorScheme.onSecondary,
          ),
        ),
      ],
    );
  }
}