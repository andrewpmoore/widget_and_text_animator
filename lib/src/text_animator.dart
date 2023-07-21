import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/src/widget_animator.dart';

/// The [TextAnimator] is a direct placement for the standard [Text] widget
/// It makes use of the [WidgetAnimator] class to allow many different transition effects
/// The class allows you to transition in individual characters or words together to create some cool effects
class TextAnimator extends StatefulWidget {
  ///the [String] of text to display
  final String text;

  /// [WidgetTransitionEffects] The incoming effect to show when the text is first shown
  final WidgetTransitionEffects? incomingEffect;

  /// [WidgetTransitionEffects] The outgoing effect to show when the text is about to be replaced
  final WidgetTransitionEffects? outgoingEffect;

  /// [WidgetRestingEffects] The effect to show when the text is not transitioning on or off the screen
  final WidgetRestingEffects? atRestEffect;

  /// [int] the maximum number of lines of text to show within the widget, used in the same way as the standard [Text] widget
  final int? maxLines;

  /// The [TextAlign] of the text, in the same was it's used in the [Text] widget
  final TextAlign? textAlign;

  /// The [TextStyle] of the text, in the same was it's used in the [Text] widget
  final TextStyle? style;

  /// A [Duration] delay before the text initially starts to show
  final Duration? initialDelay;

  /// [Duration] a delay to leave between each character of text to display to create a
  /// staggered text animation effect, if you want words to appear at once, then set a Duration of zero
  final Duration? characterDelay;

  /// [Duration] a delay to leave between each space/word
  /// if set the same as the characterDelay the timing will be consistent for all characters
  /// can be used to drive the timing per word if characterDelay is set to zero
  final Duration? spaceDelay;

  /// Standard constructor for the text animator
  const TextAnimator(this.text,
      {Key? key,
      this.incomingEffect,
      this.outgoingEffect,
      this.atRestEffect,
      this.onIncomingAnimationComplete,
      this.onOutgoingAnimationComplete,
      this.maxLines,
      this.textAlign,
      this.style,
      this.initialDelay,
      this.characterDelay,
      this.spaceDelay})
      : super(key: key);

  /// [Function] will be called when the last incoming animation character has completed its transition
  final Function(Key?)? onIncomingAnimationComplete;

  /// [Function] will be called when the last outgoing animation character has completed its transition
  final Function(Key?)? onOutgoingAnimationComplete;

  @override
  State<TextAnimator> createState() => _TextAnimatorState();
}

class _TextAnimatorState extends State<TextAnimator> {
  ///list for holding all the words in the incoming text, split up
  final List<String> _words = [];

  ///the text from the widget
  String _text = '';

  ///is the text currently showing the outgoing animation (this is used to trigger a redraw of the text to get it animating again)
  bool _outgoing = false;

  ///a list for holding each word and character with the delays before triggering the animation
  final List<List<Duration>> _incomingDelays =
      []; //the delays of each incoming character broken into words and then characters

  @override
  void initState() {
    super.initState();
    _text = widget.text;
    _initWords();
  }

  ///initialise the words in the string by splitting them and calculating the delays for showing them
  void _initWords() {
    ///split the text into words
    _words.clear();
    _incomingDelays.clear();
    List<String> temp = [];
    temp = _text.split(' ');
    for (var element in temp) {
      _words.add(element = '$element ');
    }
    _words.last = _words.last.trim();

    ///calculate the delays between each incoming character and store
    Duration delay = const Duration(milliseconds: 0);
    for (int i = 0; i < _words.length; i++) {
      List<Duration> wordDelays = [];
      if (i > 0) {
        delay = delay + (widget.spaceDelay ?? const Duration(milliseconds: 80));
      } else {
        delay =
            delay + (widget.initialDelay ?? const Duration(milliseconds: 0));
      }
      for (int j = 0; j < (_words[i]).characters.length; j++) {
        delay =
            delay + (widget.characterDelay ?? const Duration(milliseconds: 40));
        wordDelays.add(delay);
      }
      _incomingDelays.add(wordDelays);
    }
  }

  ///mark as outgoing, this will force the animation to rebuild and trigger the outgoing text
  void _textChangedOutgoing() async {
    _outgoing = true;
    if (mounted) {
      setState(() {});
    }
  }

  ///force a redraw and update the words array with the next set of words to use
  void _textChangedReplaced(Key? p1) async {
    _outgoing = false;
    _text = widget.text;
    _initWords();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    ///detect text changes
    if (widget.text != _text) {
      _textChangedOutgoing();
    }

    ///Use [RichText] to display each individual characters with delays as specified in the _incomingDelays
    return RichText(
        key: ValueKey(
            _text), //needs a key otherwise the old widget will be reused and if the new text is longer than the old text, you get a break in the animation between the two sections
        softWrap: true,
        maxLines: widget.maxLines,
        textAlign: widget.textAlign ?? TextAlign.start,
        text: TextSpan(
          style: widget.style,
          children: [
            for (int i = 0; i < _words.length; i++)
              WidgetSpan(
                  child: Wrap(
                children: [
                  for (int j = 0; j < (_words[i]).characters.length; j++)
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
                          style: widget.incomingEffect?.style ??
                              WidgetTransitionEffectStyle.none,
                          delay: _incomingDelays[i][j],
                        ),
                        outgoingEffect: widget.outgoingEffect,
                        atRestEffect: widget.atRestEffect,
                        onIncomingAnimationComplete: (_isLastCharacter(i, j))
                            ? widget.onIncomingAnimationComplete
                            : null,
                        onOutgoingAnimationComplete: (_isLastCharacter(i, j))
                            ? _triggerLastOutgoingAnimation
                            : null,
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

  ///we need to know which is the last character animation to trigger on outgoing events to know when to switch over onto the next text
  _isLastCharacter(int i, int j) {
    return i == _words.length - 1 && j == _words[i].characters.length - 1;
  }

  ///when the last animation character triggers, now it's time to replace the text with the new incoming text
  _triggerLastOutgoingAnimation(Key? p1) {
    _textChangedReplaced(p1);
    if (widget.onOutgoingAnimationComplete != null) {
      widget.onOutgoingAnimationComplete!(p1);
    }
  }
}
