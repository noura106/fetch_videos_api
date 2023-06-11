import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class FullScreenViewer extends StatefulWidget {
  const FullScreenViewer({
    Key? key,
    required this.child,
    required this.tag,
    this.disableSwipeToDismiss = false,
    this.disposeLevel = DisposeLevel.medium,
  }) : super(key: key);

  final Widget child;
  final DisposeLevel? disposeLevel;
  final String tag;
  final bool disableSwipeToDismiss;

  @override
  FullScreenViewerState createState() => FullScreenViewerState();
}

class FullScreenViewerState extends State<FullScreenViewer> {
  double? _initialPositionY = 0;

  double? _currentPositionY = 0;

  double _positionYDelta = 0;

  double _disposeLimit = 150;

  Duration _animationDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    setDisposeLevel();
  }

  setDisposeLevel() {
    if (widget.disposeLevel == DisposeLevel.high) {
      _disposeLimit = 300;
    } else if (widget.disposeLevel == DisposeLevel.medium) {
      _disposeLimit = 200;
    } else {
      _disposeLimit = 100;
    }
  }

  void _dragUpdate(DragUpdateDetails details) {
    setState(() {
      _currentPositionY = details.globalPosition.dy;
      _positionYDelta = _currentPositionY! - _initialPositionY!;
    });
  }

  void _dragStart(DragStartDetails details) {
    setState(() {
      _initialPositionY = details.globalPosition.dy;
    });
  }

  _dragEnd(DragEndDetails details) {
    if (_positionYDelta > _disposeLimit || _positionYDelta < -_disposeLimit) {
      Navigator.of(context).pop();
    } else {
      setState(() {
        _animationDuration = const Duration(milliseconds: 300);
        _positionYDelta = 0;
      });

      Future.delayed(_animationDuration).then((_) {
        setState(() {
          _animationDuration = Duration.zero;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPosition = 0 + max(_positionYDelta, -_positionYDelta) / 15;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        color: Colors.transparent,
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: Stack(
          children: <Widget>[
            AnimatedPositioned(
              duration: _animationDuration,
              curve: Curves.fastOutSlowIn,
              top: 0 + _positionYDelta,
              bottom: 0 - _positionYDelta,
              left: horizontalPosition,
              right: horizontalPosition,
              child: widget.disableSwipeToDismiss
                  ? ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(40),
                ),
                clipBehavior: Clip.hardEdge,
                child: widget.child,
              )
                  : KeymotionGestureDetector(
                onStart: (details) => _dragStart(details),
                onUpdate: (details) => _dragUpdate(details),
                onEnd: (details) => _dragEnd(details),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(40),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: widget.child,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class KeymotionGestureDetector extends StatelessWidget {
  /// @macro
  const KeymotionGestureDetector({
    Key? key,
    required this.child,
    this.onUpdate,
    this.onEnd,
    this.onStart,
  }) : super(key: key);

  final Widget child;
  final GestureDragUpdateCallback? onUpdate;
  final GestureDragEndCallback? onEnd;
  final GestureDragStartCallback? onStart;

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(gestures: <Type, GestureRecognizerFactory>{
      VerticalDragGestureRecognizer:
      GestureRecognizerFactoryWithHandlers<VerticalDragGestureRecognizer>(
            () => VerticalDragGestureRecognizer()
          ..onStart = onStart
          ..onUpdate = onUpdate
          ..onEnd = onEnd,
            (instance) {},
      ),
    }, child: child);
  }
}

enum DisposeLevel { high, medium, low }
