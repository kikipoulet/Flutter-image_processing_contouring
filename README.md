https://pub.dev/packages/image_processing_contouring

Basic experimentation of an image processing & contouring package in pure dart. And trying to make the usage easy.
The idea is to implement in dart the basics that permits to detect contours in an image and calculate some info about it (Area, Perimeter) and make some basic drawing with it.

<details>
  <summary>More Info / Personal thoughts</summary>
  
- This is an experimentation, I will see if I implement more things if I or someone? need
- Being in pure dart make it really portable and usable on every platform. Only dependency is image dart package.
- I didn't test performance yet. I suppose it won't be incredible because at this point optimisation is not my goal but it seems to run quickly enough for my use case
  
</details>

## Usage

There are not a lot of functionalities yet, it is more like a PoC. Here is what it can do :

```dart
// easily load image from path
im.Image? ima = LoadImageFromPath('/home/user/image.jpg');

// Apply a treshold and detect contours
var contours = ima?.threshold(220).detectContours();

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

So if you run this example on this image :

<img src="https://raw.githubusercontent.com/kikipoulet/Flutter-image_processing_contouring/main/image.jpg"></img>

you will obtain this :

<img src="https://raw.githubusercontent.com/kikipoulet/Flutter-image_processing_contouring/main/result.png"></img>
