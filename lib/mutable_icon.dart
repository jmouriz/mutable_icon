/// Author: Juan Manuel Mouriz
/// website: tecnologica.com.ar
/// Version: 1.1.0
/// Null-Safety: checked!
/// Prefer Const: checked!

import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Indicates whether to init from the start or from the end.
enum InitFrom {
  /// Init from start to end
  start,

  /// Init from end to start
  end
}

/// Class [MutableIcon]:
///
/// [startIcon]: The IconData that will be visible before animation starts.
///
/// [endIcon]: The IconData that will be visible after animation ends.
///
/// [controller]: MutableIcon controller.
///
/// [startIconColor]: The color to be used for the [startIcon].
///
/// [endIconColor]: The color to be used for the [endIcon].
///
/// [duration]: The duration for which the animation runs.
///
/// [size]: The size of the icon that are to be shown.
///
/// [clockwise]: If the animation runs in the clockwise or anticlockwise
/// direction.
///
/// [initFrom] Used to set initial state. Indicates whether to init from the
/// start or from the end. Default is [initFrom.start].
class MutableIcon extends StatefulWidget {
  /// Creates a [MutableIcon] widget.
  ///
  /// [startIcon]: The IconData that will be visible before animation starts.
  ///
  /// [endIcon]: The IconData that will be visible after animation ends.
  ///
  /// [controller]: MutableIcon controller.
  ///
  /// [startIconColor]: The color to be used for the [startIcon].
  ///
  /// [endIconColor]: The color to be used for the [endIcon].
  ///
  /// [duration]: The duration for which the animation runs.
  ///
  /// [size]: The size of the icon that are to be shown.
  ///
  /// [clockwise]: If the animation runs in the clockwise or anticlockwise
  /// direction.
  ///
  /// [initFrom]: Used to set initial state. Indicates whether to init from the
  /// start or from the end. Default is [initFrom.start].
  const MutableIcon({
    Key? key,

    /// The IconData that will be visible before animation starts
    required this.startIcon,

    /// The IconData that will be visible after animation ends
    required this.endIcon,

    /// MutableIcon controller
    required this.controller,

    /// The color to be used for the [startIcon]
    this.startIconColor,

    /// The color to be used for the [endIcon]
    this.endIconColor,

    /// The duration for which the animation runs
    this.duration = const Duration(milliseconds: 300),

    /// The size of the icon that are to be shown
    this.size = 24.0,

    /// If the animation runs in the clockwise or anticlockwise direction
    this.clockwise = false,

    /// Used to set initial state. Indicates whether to init from the start
    /// or from the end. Default is [initFrom.start]
    this.initFrom = InitFrom.start,
  }) : super(key: key);

  final IconData startIcon, endIcon;
  final MutableIconController controller;
  final Color? startIconColor, endIconColor;
  final Duration duration;
  final double size;
  final bool clockwise;
  final InitFrom initFrom;

  @override
  _MutableIconState createState() => _MutableIconState();
}

class _MutableIconState extends State<MutableIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
      value: widget.initFrom == InitFrom.start ? 0.0 : 1.0,
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
    double start = _controller.value;
    double end = 1.0 - _controller.value;
    double startOpacity = start;
    double endOpacity = end;
    double startAngle = math.pi / 180 * (180 * startOpacity);
    double endAngle = math.pi / 180 * (180 * endOpacity);

    Widget first() {
      final icon = Icon(
        widget.startIcon,
        size: widget.size,
        color: widget.startIconColor ?? Theme.of(context).primaryColor,
      );
      return Transform.rotate(
          angle: widget.clockwise ? startAngle : -startAngle,
          child: Opacity(
            opacity: endOpacity,
            child: icon,
          ));
    }

    Widget second() {
      final icon = Icon(
        widget.endIcon,
        size: widget.size,
        color: widget.endIconColor ?? Theme.of(context).primaryColor,
      );
      return Transform.rotate(
        angle: widget.clockwise ? -endAngle : endAngle,
        child: Opacity(opacity: startOpacity, child: icon),
      );
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        start == 1 && end == 0 ? second() : first(),
        start == 0 && end == 1 ? first() : second(),
      ],
    );
  }
}

class MutableIconController {
  late bool Function() animateToStart = () => false;
  late bool Function() animateToEnd = () => false;
  late bool Function() isStart, isEnd;
}
