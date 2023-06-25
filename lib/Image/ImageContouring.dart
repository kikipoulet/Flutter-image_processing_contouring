library image_processing_contouring;

import 'dart:collection';
import 'dart:typed_data';

import 'package:image/image.dart' ;

import '../Classes/Contour.dart';

extension ImageContouring on Image {
  List<Contour> detectContours() {
    List<Contour> contours = [];
    List<List<bool>> visited = List.generate(width, (_) => List.filled(height, false));

    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        if (!visited[x][y]) {
          Pixel currentPixel = getPixel(x, y);

          if (currentPixel.luminance == 0) {
            List<Point> contourPoints = [];
            _visitPoint(x, y, contourPoints, visited);

            var l = _filterConnectedPoints(contourPoints);

            contours.add(Contour(l));
          }
        }
      }
    }

    return contours;
  }

  List<Point> _filterConnectedPoints(List<Point> points) {
    if (points.isEmpty) {
      return [];
    }

    final filteredPoints = [points.first];
    var lastPoint = points.first;

    while (true) {
      var foundNextPoint = false;

      for (var i = 0; i < points.length; i++) {
        final currentPoint = points[i];

        if (_arePointsAdjacent(lastPoint, currentPoint) || _arePointsDiagonal(lastPoint, currentPoint)) {
          filteredPoints.add(currentPoint);
          lastPoint = currentPoint;
          points.removeAt(i);
          foundNextPoint = true;
          break;
        }
      }

      if (!foundNextPoint) {
        break;
      }
    }

    return filteredPoints;
  }


  bool _arePointsAdjacent(Point p1, Point p2) {
    return (p1.x == p2.x && (p1.y == p2.y - 1 || p1.y == p2.y + 1)) ||
        (p1.y == p2.y && (p1.x == p2.x - 1 || p1.x == p2.x + 1));
  }

  bool _arePointsDiagonal(Point p1, Point p2) {
    return (p1.x == p2.x - 1 || p1.x == p2.x + 1) &&
        (p1.y == p2.y - 1 || p1.y == p2.y + 1);
  }

  void _visitPoint(int startX, int startY, List<Point> contourPoints, List<List<bool>> visited) {
    final stack = Queue<Point>();
    stack.add(Point(startX, startY));

    while (stack.isNotEmpty) {
      final currentPoint = stack.removeFirst();
      int x = currentPoint.x.toInt();
      int y = currentPoint.y.toInt();

      if (x < 0 || x >= width || y < 0 || y >= height) {
        continue;
      }

      if (visited[x][y]) {
        continue;
      }

      visited[x][y] = true;

      Pixel currentPixel = getPixel(x, y);

      if (currentPixel.luminance == 0) {
        bool isBorderPixel = false;

        if (x - 1 >= 0 && getPixel(x - 1, y).luminance > 0) {
          isBorderPixel = true;
        } else if (x + 1 < width && getPixel(x + 1, y).luminance > 0) {
          isBorderPixel = true;
        } else if (y - 1 >= 0 && getPixel(x, y - 1).luminance > 0) {
          isBorderPixel = true;
        } else if (y + 1 < height && getPixel(x, y + 1).luminance > 0) {
          isBorderPixel = true;
        }

        if (isBorderPixel) {
          contourPoints.add(Point(x, y));
        } else {
          visited[x][y] = true;
        }

        stack.add(Point(x - 1, y));
        stack.add(Point(x + 1, y));
        stack.add(Point(x, y - 1));
        stack.add(Point(x, y + 1));
      }
    }
  }


}

