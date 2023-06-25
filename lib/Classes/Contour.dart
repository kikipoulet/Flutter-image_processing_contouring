import 'dart:math';

import 'package:image/image.dart';

class Contour {
  List<Point> Points = List.empty();

  Contour(this.Points);

  bool isPointInsideContour(Point point, {bool raycasting = true}) {
    bool inside = false;

    if(!raycasting) {

      int i = 0;
      int j = Points.length - 1;

      for (; i < Points.length; j = i++) {
        final pi = Points[i];
        final pj = Points[j];

        if (((pi.y > point.y) != (pj.y > point.y)) &&
            (point.x <
                (pj.x - pi.x) * (point.y - pi.y) / (pj.y - pi.y) + pi.x)) {
          inside = !inside;
        }
      }

    }else{
      int count = 0;
      final int n = Points.length;

      for (int i = 0, j = n - 1; i < n; j = i++) {
        final pi = Points[i];
        final pj = Points[j];

        if (((pi.y > point.y) != (pj.y > point.y)) &&
            (point.x < (pj.x - pi.x) * (point.y - pi.y) / (pj.y - pi.y) + pi.x)) {
          if (point.y <= pi.y) {
            if (point.y <= pj.y) {
              count++;
            } else {
              final num cross = (pj.x - pi.x) * (point.y - pi.y) - (pj.y - pi.y) * (point.x - pi.x);
              if (cross > 0) {
                count++;
              }
            }
          } else if (point.y <= pj.y) {
            final num cross = (pj.x - pi.x) * (point.y - pi.y) - (pj.y - pi.y) * (point.x - pi.x);
            if (cross < 0) {
              count++;
            }
          }
        }
      }

      if (count % 2 == 1) {
        inside = true;
      }

    }

    return inside;
  }

  double getPerimeter() {
    double perimeter = 0.0;
    final int numPoints = Points.length;

    for (int i = 0; i < numPoints; i++) {
      final Point currentPoint = Points[i];
      final Point nextPoint = Points[(i + 1) % numPoints];

      final double edgeLength = _calculateDistance(currentPoint, nextPoint);
      perimeter += edgeLength;
    }

    return perimeter;
}

  double getArea() {
    double area = 0.0;
    final int numPoints = Points.length;

    for (int i = 0; i < numPoints; i++) {
      final Point currentPoint = Points[i];
      final Point nextPoint = Points[(i + 1) % numPoints];

      final num crossProduct = (nextPoint.x + currentPoint.x) * (nextPoint.y - currentPoint.y);
      area += crossProduct;
    }

    area = area.abs() / 2.0;

    return area;
  }

double _calculateDistance(Point p1, Point p2) {
  final num dx = p2.x - p1.x;
  final num dy = p2.y - p1.y;
  return sqrt(dx * dx + dy * dy);
}
}