import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmationModal extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback callback;

  const ConfirmationModal({
    super.key,
    required this.title,
    required this.message,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      elevation: 0,
      backgroundColor: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.help_outline_rounded,
              color: theme.colorScheme.primary,
              size: 45,
            ),

            const SizedBox(height: 12),

            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: theme.colorScheme.onSurface,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: theme.colorScheme.onSurface.withOpacity(0.75),
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SimpleBtn1(
                  text: "No",
                  onPressed: Get.back,
                  invertedColors: true,
                ),
                SimpleBtn1(
                  text: "Yes",
                  onPressed: () {
                    Get.back();
                    callback();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SimpleBtn1 extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool invertedColors;

  const SimpleBtn1({
    super.key,
    required this.text,
    required this.onPressed,
    this.invertedColors = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.symmetric(
          horizontal: 28,
          vertical: 12,
        ),
        backgroundColor: invertedColors
            ? theme.colorScheme.surface
            : theme.colorScheme.primary,
        foregroundColor: invertedColors
            ? theme.colorScheme.primary
            : theme.colorScheme.onPrimary,
        side: BorderSide(
          color: theme.colorScheme.primary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}