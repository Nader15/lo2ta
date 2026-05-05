import 'package:flutter/material.dart';
import 'package:lo2ta/core/utils/clip_directions.dart';

class SlantedClipper extends CustomClipper<Path> {
  final ClipDirection direction;
  final double slantHeight;
  final double radius;

  const SlantedClipper({
    this.direction = ClipDirection.left,
    this.slantHeight = 50.0,
    this.radius = 24.0,
  });

  Path _buildLeft(Size size) {
    final r = radius;
    const slantRadius = 20.0;
    final path = Path();

    path.moveTo(0, r);

    // top-left corner
    path.quadraticBezierTo(0, 0, r, 0);

    // top edge to slanted start (with slight rounding)
    path.lineTo(size.width - slantRadius, slantHeight - slantRadius);

    // rounded transition into slanted edge
    path.quadraticBezierTo(
      size.width,
      slantHeight - slantRadius,
      size.width,
      slantHeight,
    );

    // right side down
    path.lineTo(size.width, size.height - r);

    // bottom-right corner
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width - r,
      size.height,
    );

    // bottom edge
    path.lineTo(r, size.height);

    // bottom-left corner
    path.quadraticBezierTo(0, size.height, 0, size.height - r);

    // left side up
    path.lineTo(0, r);

    path.close();

    return path;
  }

  @override
  Path getClip(Size size) {
    final path = _buildLeft(size);
    if (direction == ClipDirection.right) {
      final matrix = Matrix4.identity()
        ..translate(size.width)
        ..scale(-1.0, 1.0);
      return path.transform(matrix.storage);
    }
    return path;
  }

  @override
  bool shouldReclip(SlantedClipper old) {
    return old.direction != direction ||
        old.slantHeight != slantHeight ||
        old.radius != radius;
  }
}