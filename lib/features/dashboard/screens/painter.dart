import 'dart:ui';

import 'package:flutter/material.dart';

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paint_fill_0 = Paint()
      ..color = const Color.fromARGB(255, 220, 234, 226)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.4912200, size.height * -0.0319200);
    path_0.lineTo(size.width * 0.9292400, size.height * 0.1941000);
    path_0.lineTo(size.width * 0.9296400, size.height * 0.4787600);
    path_0.lineTo(size.width * 0.9272600, size.height * 0.8227000);
    path_0.lineTo(size.width * 0.5059600, size.height * 1.0276200);
    path_0.lineTo(size.width * 0.0786000, size.height * 0.8055200);
    path_0.lineTo(size.width * 0.0786400, size.height * 0.4766600);
    path_0.lineTo(size.width * 0.0827800, size.height * 0.1710200);

    canvas.drawPath(path_0, paint_fill_0);

    // Layer 1

    Paint paint_stroke_0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paint_stroke_0);

    // Layer 1 Copy

    Paint paint_fill_1 = Paint()
      ..color = const Color.fromARGB(255, 60, 65, 222)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.5042800, 0);
    path_1.lineTo(size.width * 0.9059400, size.height * 0.2024800);
    path_1.lineTo(size.width * 0.9041800, size.height * 0.5042600);
    path_1.lineTo(size.width * 0.9060800, size.height * 0.7969000);
    path_1.lineTo(size.width * 0.5082800, size.height * 1.0040000);
    path_1.lineTo(size.width * 0.1044400, size.height * 0.7969200);
    path_1.lineTo(size.width * 0.1023600, size.height * 0.4401600);
    path_1.lineTo(size.width * 0.1043600, size.height * 0.2029400);

    canvas.drawPath(path_1, paint_fill_1);

    // Layer 1 Copy

    Paint paint_stroke_1 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_1, paint_stroke_1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
