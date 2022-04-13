import 'dart:async';
import 'package:flutter/material.dart';

import '../widget_and_text_animator.dart';

class TextAnimatorSequence extends StatefulWidget {
  const TextAnimatorSequence({Key? key, required this.children, this.tapToProceed, this.loop, this.transitionTime, this.onPressed}) : super(key: key);

  final List<TextAnimator> children;
  final bool? tapToProceed;
  final bool? loop;
  final Duration? transitionTime;
  final Function? onPressed;

  @override
  State<TextAnimatorSequence> createState() => _TextAnimatorSequenceState();
}

class _TextAnimatorSequenceState extends State<TextAnimatorSequence> {

  int currentChildToRender = 0;
  late Timer? _timer = Timer(const Duration(seconds: 1), (){});

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    TextAnimator textAnimatorToShow = widget.children[currentChildToRender];

    return GestureDetector(
        onTap: () {
          _timer?.cancel();
          if (widget.tapToProceed??false){
            int nextChild = _getNextChild();
            if (mounted) {
              if (currentChildToRender!=nextChild) {
                setState(() {
                  currentChildToRender = nextChild;
                });
              }
            }
            if (widget.onPressed!=null){
              widget.onPressed;
            }
          }
        },
        child: TextAnimator(
          textAnimatorToShow.text,
          style: textAnimatorToShow.style,
          incomingEffect: textAnimatorToShow.incomingEffect,
          outgoingEffect: textAnimatorToShow.outgoingEffect,
          atRestEffect: textAnimatorToShow.atRestEffect,
          onIncomingAnimationComplete: (_){
            if (textAnimatorToShow.onIncomingAnimationComplete!=null) {
              textAnimatorToShow.onIncomingAnimationComplete;
            }
            if (widget.transitionTime!=null){
              _timer = Timer(widget.transitionTime!, () {
                if (mounted) {
                  int nextChild = _getNextChild();
                  if (currentChildToRender!=nextChild) {
                    setState(() {
                      currentChildToRender = nextChild;
                    });
                  }
                }
              });
            }

          },
          onOutgoingAnimationComplete: textAnimatorToShow.onOutgoingAnimationComplete,
          textAlign: textAnimatorToShow.textAlign,
          characterDelay: textAnimatorToShow.characterDelay,
          spaceDelay: textAnimatorToShow.spaceDelay,
          initialDelay: textAnimatorToShow.initialDelay,
          maxLines: textAnimatorToShow.maxLines,
        ));
  }

  int _getNextChild() {
    int nextChild = currentChildToRender+1;
    if (nextChild>=widget.children.length){
      if ((widget.loop??false)==true) {
        nextChild = 0;
      }
      else{
        nextChild = nextChild - 1;
      }
    }
    return nextChild;
  }
}
