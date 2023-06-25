Basic experimentation of an image processing & contouring package in pure dart. And trying to make the usage easy.
The idea is to implement in dart the basics that permits to detect contours in an image and calculate some info about it (Area, Perimeter) and make some basic drawing with it.

## Usage

There are not a lot of functionalities yet, it is more like a PoC. Here is what it can do :

```dart
// easily load image from path
im.Image? ima = LoadImageFromPath('/home/user/image.jpg');

// Apply a treshold and detect contours
var contours = ima?.threshold(100).detectContours();

// Draw all the contours on the image in red
ima?.drawContours(contours!, im.ColorFloat16.rgb(255,0,0), filled: false);

// Sort all the contours by area and find the biggest one
contours?.sort( (c,b) => (b.getArea() - c.getArea()).toInt());
var biggestcontour = contours?.first;
// Draw the biggest contour in green and filled
ima?.drawContour(biggestcontour!, im.ColorFloat16.rgb(0,255,0),  true);

// Display the widget
ima?.getWidget(BoxFit.contain);
```

