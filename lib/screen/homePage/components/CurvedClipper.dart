import 'package:flutter/material.dart';

class CurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);

    // 0.925
    Offset curvePoint1 = Offset(0, size.height * 0.925);
    Offset centerPoint = Offset(size.height * 0.925, size.height * 0.925);
    path.quadraticBezierTo(
        curvePoint1.dx, curvePoint1.dy, centerPoint.dx, centerPoint.dy);

    path.lineTo(size.width * 0.75, size.height * 0.925);

    Offset curvePoint2 = Offset(size.width, size.height * 0.925);
    Offset endPoint = Offset(size.width, size.height * 0.650);

    path.quadraticBezierTo(
        curvePoint2.dx, curvePoint2.dy, endPoint.dx, endPoint.dy);

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }

}
