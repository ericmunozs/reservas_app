import 'package:flutter/material.dart';

class SettingsButton extends StatelessWidget {
  final Function()? onPressed;

  const SettingsButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.settings),
      onPressed: onPressed,
    );
  }
}
