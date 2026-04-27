
import 'package:flutter/material.dart';
class AppBackgroundWidget extends StatelessWidget {
  const AppBackgroundWidget({super.key});

  static const bgColor = Color(0xFF0D0A1A);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -100,
          left: -80,
          child: Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF6B4FD4).withValues(alpha: 0.08),
            ),
          ),
        ),
        Positioned(
          bottom: -120,
          left: -80,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFE53935).withValues(alpha: 0.06),
            ),
          ),
        ),
      ],
    );
  }
}