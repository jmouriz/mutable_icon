## Animate any two icons

mutable_icon is a simplified version of [animate_icons](https://pub.dev/packages/animate_icons "View original Widget"). Watch the demo for more details. It is specifically designed to be included within other widgets that already have their own behavior and only need to animate an icon.

### Demo:

<img src="https://raw.githubusercontent.com/jmouriz/mutable_icon/main/demo/mutable_icon.gif" />


### How to use:

All plugin in your pubspec.yaml 
    
> mutable_icon:

Make the import:

> import 'package:mutable_icon/mutable_icon.dart';

Use the following widget:

```
    MutableIcon(
        startIcon: Icons.add_circle,
        endIcon: Icons.add_circle_outline,
        controller: controller,
        size: 32.0,
        duration: Duration(milliseconds: 400),
        startIconColor: Colors.deepPurple,
        endIconColor: Colors.deepOrange,
        clockwise: false,
        initFrom: InitFrom.end,
    ),
```

# Use MutableIconController
Define MutableIconController to animate b/w start and end icons.

### Define MutableIconController
    
> MutableIconController controller;

### Initialize controller    
    
> controller = MutableIconController();

### Pass controller to widget 
```
MutableIcon(
    startIcon: Icons.add,
    endIcon: Icons.close,
    controller: controller, 
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

### Full example
```
import 'package:flutter/material.dart';

import 'package:mutable_icon/mutable_icon.dart';

void main() => runApp(const Example());

class Example extends StatefulWidget {
  const Example({Key? key}) : super(key: key);

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  bool _submenu = false;
  late final MutableIconController _controller;

  @override
  void initState() {
    _controller = MutableIconController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MutableIcon Example',
      home: Scaffold(
        body: ListView(
          children: [
            ListTile(
              leading: const Icon(
                Icons.wallet,
                color: Colors.black
              ),
              title: const Text('Wallet'),
              trailing: MutableIcon(
                duration: const Duration(milliseconds: 300),
                startIcon: Icons.expand_more,
                endIcon: Icons.expand_less,
                startIconColor: Colors.black,
                endIconColor: Colors.black,
                controller: _controller,
                initFrom: _submenu ? InitFrom.end : InitFrom.start
              ),
              onTap: () {
                setState(() {
                  _submenu = !_submenu;
                  if (_submenu) {
                    _controller.animateToEnd();
                  } else {
                    _controller.animateToStart();
                  }
                });
              },
            ),
            if (_submenu) ListTile(
              contentPadding: const EdgeInsets.only(left: 32),
              leading: const Icon(
                Icons.account_balance,
                color: Colors.black
              ),
              title: const Text('Balance'),
              onTap: () {},
            ),
          ],
        )
      ),
    );
  }
}
```
