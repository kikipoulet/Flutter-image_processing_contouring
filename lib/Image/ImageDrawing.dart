
import 'package:image/image.dart' ;
import 'dart:math';

import '../Classes/Contour.dart';

extension ImageDrawing on Image {
    Image drawContours_withRandomColor(List<Contour> contours, {bool filled = true}){
      Random random = Random();

      contours.forEach((element) {
          final color =  new ColorFloat16.rgb(random.nextInt(256), random.nextInt(256), random.nextInt(256));

          drawContour(element,color, filled);
      });

      return this;
    }

    Image drawContours(List<Contour> contours,Color color, {bool filled = true}){

      contours.forEach((element) {
        drawContour(element,color, filled);
      });

      return this;
    }

    Image drawContour(Contour contour, Color color, bool filled) {
      if (filled) {
        int minX = contour.Points.first.x.toInt();
        int maxX = contour.Points.first.x.toInt();
        int minY = contour.Points.first.y.toInt();
        int maxY = contour.Points.first.y.toInt();

        for (final point in contour.Points) {
          minX = point.x.toInt() < minX ? point.x.toInt() : minX;
          maxX = point.x.toInt() > maxX ? point.x.toInt() : maxX;
          minY = point.y.toInt() < minY ? point.y.toInt() : minY;
          maxY = point.y.toInt() > maxY ? point.y.toInt() : maxY;
        }

        for (int y = minY; y <= maxY; y++) {
          for (int x = minX; x <= maxX; x++) {
            if (contour.isPointInsideContour(Point(x, y))) {
              setPixel(x, y, color);
            }
          }
        }
      } else {
        for (final point in contour.Points) {
          setPixel(point.x.toInt(), point.y.toInt(), color);
        }
      }

      return this;
    }
}

