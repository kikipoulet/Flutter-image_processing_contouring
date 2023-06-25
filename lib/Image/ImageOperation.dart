import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'package:image/image.dart' as im;

extension ImageOperation on im.Image {

  im.Image threshold(num threshold) {
    final im.Image result = im.Image( width: width, height: height);

    var black = new im.ColorFloat16.rgb(0, 0, 0);
    var white = new im.ColorFloat16.rgb(255,255,255);

    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        im.Pixel pixel = getPixel(x, y);
        var lum =  pixel.luminance ;

        if (lum < threshold) {
          result.setPixel(x, y, black);
        } else {
          result.setPixel(x, y, white);
        }
      }
    }

    return result;
  }


}