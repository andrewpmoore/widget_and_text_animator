import 'dart:async';
import 'package:flutter/material.dart';

import '../widget_and_text_animator.dart';

/// [WidgetAnimatorSequence] allows you to provide a list of [WidgetAnimator] widgets and have them show in sequence
/// The sequence can progress based upon a duration set or by the user tapping on the widget (or both)
class WidgetAnimatorSequence extends StatefulWidget {
  const WidgetAnimatorSequence(
      {Key? key,
      required this.children,
      this.tapToProceed,
      this.loop,
      this.transitionTime,
      this.onPressed})
      : super(key: key);

  ///List of [WidgetAnimator] objects to display in the order you want them displaying
  final List<WidgetAnimator> children;

  /// [bool] do you want the user to be able to tab on the widget to proceed to the next text, default is false
  final bool? tapToProceed;

  /// [bool] once the end of the sequence is reached, does the list loop back ground to the start again, default is false
  final bool? loop;

  /// [Duration] The length of time to wait between changing the widget once in input transition has completed,
  /// not specifying a duration will mean it won't change the sequence automatically
  final Duration? transitionTime;

  /// [Function] callback function to perform if the Widget is pressed on
  final Function? onPressed;

  @override
  State<WidgetAnimatorSequence> createState() => _WidgetAnimatorSequenceState();
}

class _WidgetAnimatorSequenceState extends State<WidgetAnimatorSequence> {
  int currentChildToRender = 0;
  Timer _timer = Timer(const Duration(seconds: 1), () {});

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    WidgetAnimator widgetAnimatorToShow = widget.children[currentChildToRender];

    return GestureDetector(
        onTap: () {
          _timer.cancel();
          if (widget.tapToProceed ?? false) {
            ///move onto the next item in the sequence if clicked on
            int nextChild = _getNextChild();
            if (mounted) {
              if (currentChildToRender != nextChild) {
                setState(() {
                  currentChildToRender = nextChild;
                });
              }
            }
            if (widget.onPressed != null) {
              widget.onPressed!();
            }
          }
        },
        child: WidgetAnimator(
            outgoingEffect: widgetAnimatorToShow.outgoingEffect,
            incomingEffect: widgetAnimatorToShow.incomingEffect,
            atRestEffect: widgetAnimatorToShow.atRestEffect,
            child: Container(
              key: ValueKey('widget$currentChildToRender'),
              child: widgetAnimatorToShow.child,
            ),
            onIncomingAnimationComplete: (key) {
              ///trigger the callback function if specified
              if (widgetAnimatorToShow.onIncomingAnimationComplete != null) {
                widgetAnimatorToShow.onIncomingAnimationComplete!(key);
              }

              ///set a time which once complete will move the text onto the next in the sequence
              if (widget.transitionTime != null) {
                _timer = Timer(widget.transitionTime!, () {
                  if (mounted) {
                    int nextChild = _getNextChild();
                    if (currentChildToRender != nextChild) {
                      setState(() {
                        currentChildToRender = nextChild;
                      });
                    }
                  }
                });
              }
            },
            onOutgoingAnimationComplete:
                widgetAnimatorToShow.onOutgoingAnimationComplete));
  }

  int _getNextChild() {
    int nextChild = currentChildToRender + 1;
    if (nextChild >= widget.children.length) {
      ///loop back around the children if set to loop
      if ((widget.loop ?? false) == true) {
        nextChild = 0;
      } else {
        ///or keep on the same child if not set to loop
        nextChild = nextChild - 1;
      }
    }
    return nextChild;
  }
}
