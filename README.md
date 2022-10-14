## Animate Any two icons with this plugin

mutable_icon is a simplified version of [animate_icons](https://pub.dev/packages/animate_icons "View original Widget"). Watch the demo for more details. It is specifically designed to be included within other widgets that already have their own behavior and only need to animate an icon.

### Demo:

<img src="https://raw.githubusercontent.com/jmouriz/mutable_icon/main/demo/mutable_icon.gif" />


### How to use:

All plugin in your pubspec.yaml 
    
> mutable_icon:

Make the import:

> import 'package:mutable_icon/mutable_icon.dart';

Use the following widget:

    MutableIcons(
        startIcon: Icons.add_circle,
        endIcon: Icons.add_circle_outline,
        controller: controller,
        size: 60.0,
        duration: Duration(milliseconds: 500),
        startIconColor: Colors.deepPurple,
        endIconColor: Colors.deepOrange,
        clockwise: false,
    ),

# Use MutableIconController
Define MutableIconController to animate b/w start and end icons.

### Define MutableIconController
    
> MutableIconController controller;

### Initialize controller    
    
> controller = MutableIconController();

### Pass controller to widget 
```
AnimateIcons(
    startIcon: Icons.add,
    endIcon: Icons.close,
    controller: controller, 
    size: 60.0,
    duration: Duration(milliseconds: 500),
    startIconColor: Colors.deepPurple,
    endIconColor: Colors.deepOrange,
    clockwise: false,
),
```
### Use controller functions
``` 
if (controller.isStart()) {
    controller.animateToEnd();
} else if (controller.isEnd()) {
    controller.animateToStart();
}
```

