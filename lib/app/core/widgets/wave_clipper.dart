import 'package:flutter/material.dart';
import 'dart:math' as math;

class WaveClipper extends CustomClipper<Path> {
  final double animation;
  final double waveHeight;

  WaveClipper(this.animation, {this.waveHeight = 20});

  @override
  Path getClip(Size size) {
    Path path = Path();
    final y = size.height * 0.8;

    path.lineTo(0, y); // Start at the left edge

    // Create a wavy path
    for (var i = 0.0; i < size.width; i++) {
      path.lineTo(
          i,
          y +
              math.sin((i / size.width * 2 * math.pi) +
                      (animation * 2 * math.pi)) *
                  waveHeight);
    }

    // Complete the path
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class AnimatedWave extends StatefulWidget {
  final Color color;
  final double height;

  const AnimatedWave({
    Key? key,
    required this.color,
    this.height = 100,
  }) : super(key: key);

  @override
  State<AnimatedWave> createState() => _AnimatedWaveState();
}

class _AnimatedWaveState extends State<AnimatedWave>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return ClipPath(
          clipper: WaveClipper(_controller.value),
          child: Container(
            height: widget.height,
            color: widget.color,
          ),
        );
      },
    );
  }
}
