import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/src/widget_animator.dart';

class TextAnimator extends StatefulWidget {


  final String text;
  final WidgetTransitionEffects? incomingEffect;
  final WidgetTransitionEffects? outgoingEffect;
  final WidgetRestingEffects? atRestEffect;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextStyle? style;
  final Duration? initialDelay;
  final Duration? characterDelay;
  final Duration? spaceDelay;

  const TextAnimator(this.text, {Key? key, this.incomingEffect, this.outgoingEffect, this.atRestEffect, this.onIncomingAnimationComplete, this.onOutgoingAnimationComplete, this.maxLines, this.textAlign, this.style, this.initialDelay, this.characterDelay, this.spaceDelay}) : super(key: key);

  final Function(Key?)? onIncomingAnimationComplete;
  final Function(Key?)? onOutgoingAnimationComplete;

  @override
  State<TextAnimator> createState() => _TextAnimatorState();
}

class _TextAnimatorState extends State<TextAnimator> {
  final List<String> _words = []; //list for holding all the words in the incoming text, split up
  String _text = '';  //the text from the widget
  bool _outgoing = false;  //is the text currently showing the outgoing animation (this is used to trigger a redraw of the text to get it animating again)
  final List<List<Duration>> _incomingDelays = [];  //the delays of each incoming character broken into words and then characters

  @override
  void initState() {
    super.initState();
    _text = widget.text;
    _initWords();
  }

  void _initWords(){
    //split the text into words
    _words.clear();
    _incomingDelays.clear();
    List<String> temp = [];
    temp = _text.split(' ');
    for (var element in temp) {
      _words.add(element = '$element ');
    }

    //calculate the delays between each incoming character and store
    Duration delay = const Duration(milliseconds: 0);
    for (int i = 0; i < _words.length; i++) {
      List<Duration> wordDelays = [];
      if (i > 0) {
        delay = delay + (widget.spaceDelay ?? const Duration(milliseconds: 80));
      }
      else{
        delay = delay + (widget.initialDelay ?? const Duration(milliseconds: 0));
      }
      for (int j = 0; j < (_words[i]).characters.length; j++) {
        delay = delay + (widget.characterDelay ?? const Duration(milliseconds: 40));
        wordDelays.add(delay);
      }
      _incomingDelays.add(wordDelays);
    }
  }

  void _textChangedOutgoing() async{
    //mark as outgoing, this will force the animation to rebuild and trigger the outgoing text
    _outgoing = true;
    if (mounted) {
      setState(() {});
    }
  }

  void _textChangedReplaced(Key? p1) async{
    //force a redraw and update the words array with the next set of words to use
    _outgoing = false;
    _text = widget.text;
    _initWords();
    if (mounted) {
      setState(() {});
    }



  }

  @override
  Widget build(BuildContext context) {

    //detect text changes
    if (widget.text!=_text){
      _textChangedOutgoing();
    }

    return RichText(
        key: ValueKey(_text),  //needs a key otherwise the old widget will be reused and if the new text is longer than the old text, you get a break in the animation between the two sections
        softWrap: true,
        maxLines: widget.maxLines,
        textAlign: widget.textAlign ?? TextAlign.start,
        text: TextSpan(
          style: widget.style,
          children: [
                for (int i=0; i<_words.length; i++ )
                WidgetSpan(child: Row(mainAxisSize: MainAxisSize.min,
                  children: [
                    for (int j=0; j<(_words[i]).characters.length; j++)
                      WidgetAnimator(
                          incomingEffect: WidgetTransitionEffects.withStyle(
                            opacity: widget.incomingEffect?.opacity,
                            scale: widget.incomingEffect?.scale,
                            offset: widget.incomingEffect?.offset,
                            rotation: widget.incomingEffect?.rotation,
                            blur: widget.incomingEffect?.blur,
                            curve: widget.incomingEffect?.curve,
                            skew: widget.incomingEffect?.skew,
                            duration: widget.incomingEffect?.duration,
                            builder: widget.incomingEffect?.builder,
                            style: widget.incomingEffect?.style ?? WidgetTransitionEffectStyle.none,
                            delay: _incomingDelays[i][j],
                          ),
                          outgoingEffect: widget.outgoingEffect,
                          atRestEffect: widget.atRestEffect,
                          onIncomingAnimationComplete: (_isLastCharacter(i,j)) ? widget.onIncomingAnimationComplete : null,
                          onOutgoingAnimationComplete: (_isLastCharacter(i,j)) ? triggerLastOutgoingAnimation : null,
                          child: Text(
                            _words[i].characters.characterAt(j).string,
                            key: ValueKey('$_text-text$i-$j-$_outgoing'),
                            style: widget.style,
                          ))
                  ],
                )),

          ],
        ));
  }


  _isLastCharacter(int i, int j) {
    //we need to know which is the last character animation to trigger on outgoing events to know when to switch over onto the next text
    return i==_words.length-1&&j==_words[i].characters.length-1;
  }


  triggerLastOutgoingAnimation(Key? p1) {
    //when the last animation character triggers, now it's time to replace the text with the new incoming text
    _textChangedReplaced(p1);
    if  (widget.onOutgoingAnimationComplete!=null){
      widget.onOutgoingAnimationComplete;
    }
  }

}


