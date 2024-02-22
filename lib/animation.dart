import 'package:flutter/material.dart';

class GasCylinderIndicator extends StatefulWidget {
  final double gasLevel;

  const GasCylinderIndicator({Key? key, required this.gasLevel})
      : super(key: key);

  @override
  _GasCylinderIndicatorState createState() => _GasCylinderIndicatorState();
}

class _GasCylinderIndicatorState extends State<GasCylinderIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: 0.0, end: widget.gasLevel).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return CustomPaint(
          size: Size(150, 300),
          painter: GasCylinderPainter(_animation.value),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class GasCylinderPainter extends CustomPainter {
  final double gasLevel;

  GasCylinderPainter(this.gasLevel);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final double width = size.width;
    final double height = size.height;

    final double gasHeight = height * gasLevel;

    // Draw the gas cylinder body
    canvas.drawRect(
      Rect.fromLTWH(width / 4, 0, width / 2, height),
      paint,
    );

    // Draw the gas level
    canvas.drawRect(
      Rect.fromLTWH(width / 4, height - gasHeight, width / 2, gasHeight),
      paint..color = Colors.red,
    );
  }

  @override
  bool shouldRepaint(GasCylinderPainter oldDelegate) {
    return oldDelegate.gasLevel != gasLevel;
  }
}
