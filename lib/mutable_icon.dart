library mutable_icon;

import 'package:flutter/material.dart';
import 'dart:math' as math;

class MutableIcon extends StatefulWidget {
  const MutableIcon({
    /// The IconData that will be visible before animation Starts
    required this.startIcon,

    /// The IconData that will be visible after animation ends
    required this.endIcon,

    /// AnimateIcons controller
    required this.controller,

    /// The color to be used for the [startIcon]
    this.startIconColor,

    /// The color to be used for the [endIcon]
    this.endIconColor,

    /// The duration for which the animation runs
    this.duration,

    /// The size of the icon that are to be shown.
    this.size,

    /// If the animation runs in the clockwise or anticlockwise direction
    this.clockwise,
  });

  final IconData startIcon, endIcon;
  final MutableIconController controller;
  final Color? startIconColor, endIconColor;
  final Duration? duration;
  final double? size;
  final bool? clockwise;

  @override
  _MutableIconState createState() => _MutableIconState();
}

class _MutableIconState extends State<MutableIcon> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration ?? const Duration(seconds: 1),
      lowerBound: 0.0,
      upperBound: 1.0,
    );
    _controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    initControllerFunctions();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  initControllerFunctions() {
    widget.controller.animateToEnd = () {
      if (mounted) {
        _controller.forward();
        return true;
      } else {
        return false;
      }
    };
    widget.controller.animateToStart = () {
      if (mounted) {
        _controller.reverse();
        return true;
      } else {
        return false;
      }
    };
    widget.controller.isStart = () => _controller.value == 0.0;
    widget.controller.isEnd = () => _controller.value == 1.0;
  }

  @override
  Widget build(BuildContext context) {
    double x = _controller.value;
    double y = 1.0 - _controller.value;
    double angleX = math.pi / 180 * (180 * x);
    double angleY = math.pi / 180 * (180 * y);

    Widget first() {
      final icon = Icon(
        widget.startIcon,
        size: widget.size ?? 24.0,
        color: widget.startIconColor ?? Theme.of(context).primaryColor,
      );
      return Transform.rotate(
        angle: widget.clockwise ?? false ? angleX : -angleX,
        child: Opacity(
          opacity: y,
          child: icon,
        )
      );
    }

    Widget second() {
      final icon = Icon(
        widget.endIcon,
        size: widget.size ?? 24.0,
        color: widget.endIconColor ?? Theme.of(context).primaryColor,
      );
      return Transform.rotate(
        angle: widget.clockwise ?? false ? -angleY : angleY,
        child: Opacity(
          opacity: x,
          child: icon
        ),
      );
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        x == 1 && y == 0 ? second() : first(),
        x == 0 && y == 1 ? first() : second(),
      ],
    );
  }
}

class MutableIconController {
  late bool Function() animateToStart, animateToEnd;
  late bool Function() isStart, isEnd;
}
