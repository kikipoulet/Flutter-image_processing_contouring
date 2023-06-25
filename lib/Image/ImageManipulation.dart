import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'package:image/image.dart' as im;

im.Image? LoadImageFromPath(String path){
  return im.decodeImage(File(path).readAsBytesSync());
}

extension ImageManipulation on im.Image {
  Image getWidget(BoxFit fit){
    return Image.memory(
      Uint8List.fromList(im.encodePng(this))!,
      fit: fit,
    );
  }
}
