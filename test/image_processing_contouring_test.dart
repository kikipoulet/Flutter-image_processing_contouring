import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as im;
import 'package:image_processing_contouring/Image/ImageContouring.dart';
import 'package:image_processing_contouring/Image/ImageDrawing.dart';
import 'package:image_processing_contouring/Image/ImageManipulation.dart';
import 'package:image_processing_contouring/Image/ImageOperation.dart';


void main() {
  test('main test', () {

    // easily load image from path
    im.Image? ima = LoadImageFromPath('/home/user/image.jpg');

    // Apply a treshold and detect contours
    var contours = ima?.threshold(100).detectContours();

    // Draw all the contours on the image in red
    ima?.drawContours(contours!, im.ColorFloat16.rgb(255,0,0), filled: false);

    // Sort all the contours by biggest area and find the biggest one
    contours?.sort( (c,b) => (b.getArea() - c.getArea()).toInt());
    var biggestcontour = contours?.first;
    // Draw the biggest contour in green and filled
    ima?.drawContour(biggestcontour!, im.ColorFloat16.rgb(0,255,0),  true);

    // Display the widget
    ima?.getWidget(BoxFit.contain);
  });
}
