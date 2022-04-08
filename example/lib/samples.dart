import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class Samples extends StatelessWidget {
  const Samples({Key? key}) : super(key: key);

  static Route<dynamic> route() {

    return MaterialPageRoute(builder: (BuildContext context) {
      return const Samples();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('Samples'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20,),
              WidgetAnimator(child: ElevatedButton(onPressed: () {
                Navigator.of(context).push(SamplesIncoming.route());
              }, child: const Text('Incoming animations')), incomingEffect: WidgetTransitionEffects.incomingSlideInFromLeft(delay: const Duration(milliseconds: 300)),),
              WidgetAnimator(child: ElevatedButton(onPressed: () {}, child: const Text('At rest animations')), incomingEffect: WidgetTransitionEffects.incomingSlideInFromLeft(delay: const Duration(milliseconds: 600)),),
              WidgetAnimator(child: ElevatedButton(onPressed: () {
                Navigator.of(context).push(SamplesOutgoing.route());
              }, child: const Text('Outgoing animations')), incomingEffect: WidgetTransitionEffects.incomingSlideInFromLeft(delay: const Duration(milliseconds: 900)),),
            ],
          ),
        ),
      ),
    );
  }
}



class SamplesIncoming extends StatefulWidget {
  const SamplesIncoming({Key? key}) : super(key: key);

  static Route<dynamic> route() {

    return MaterialPageRoute(builder: (BuildContext context) {
      return const SamplesIncoming();
    });
  }

  @override
  State<SamplesIncoming> createState() => _SamplesIncomingState();
}

class _SamplesIncomingState extends State<SamplesIncoming> {

  int currentPage = 0;

  List<Widget> widgetList = [
    Center(
      key: const ValueKey('1'),
    child: WidgetAnimator(
      incomingEffect: WidgetTransitionEffects.incomingScaleDown(delay: const Duration(milliseconds: 500)),
      child: Container(width: 200, height: 200, color: Colors.red, child: const Center(child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('WidgetTransitionEffects.incomingScaleDown'),
      )), ),
    ),
  ),
    Center(
      key: const ValueKey('2'),
      child: WidgetAnimator(
        incomingEffect: WidgetTransitionEffects.incomingScaleUp(delay: const Duration(milliseconds: 500)),
        child: Container(width: 200, height: 200, color: Colors.blue, child: const Center(child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('WidgetTransitionEffects.incomingScaleUp'),
        )), ),
      ),
    ),
    Center(
      key: const ValueKey('3'),
      child: WidgetAnimator(
        incomingEffect: WidgetTransitionEffects.incomingSlideInFromLeft(delay: const Duration(milliseconds: 500)),
        child: Container(width: 200, height: 200, color: Colors.green, child: const Center(child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('WidgetTransitionEffects.incomingSlideInFromLeft'),
        )), ),
      ),
    ),
    Center(
      key: const ValueKey('4'),
      child: WidgetAnimator(
        incomingEffect: WidgetTransitionEffects.incomingSlideInFromTop(delay: const Duration(milliseconds: 500)),
        child: Container(width: 200, height: 200, color: Colors.cyan, child: const Center(child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('WidgetTransitionEffects.incomingSlideInFromTop'),
        )), ),
      ),
    ),
    Center(
      key: const ValueKey('5'),
      child: WidgetAnimator(
        incomingEffect: WidgetTransitionEffects.incomingSlideInFromRight(delay: const Duration(milliseconds: 500)),
        child: Container(width: 200, height: 200, color: Colors.orange, child: const Center(child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('WidgetTransitionEffects.incomingSlideInFromRight'),
        )), ),
      ),
    ),
    Center(
      key: const ValueKey('6'),
      child: WidgetAnimator(
        incomingEffect: WidgetTransitionEffects.incomingSlideInFromBottom(delay: const Duration(milliseconds: 500)),
        child: Container(width: 200, height: 200, color: Colors.deepPurple, child: const Center(child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('WidgetTransitionEffects.incomingSlideInFromBottom'),
        )), ),
      ),
    ),
    Center(
      key: const ValueKey('6b'),
      child: WidgetAnimator(
        incomingEffect: WidgetTransitionEffects.incomingSlideInFromBottom(delay: const Duration(milliseconds: 500), duration: const Duration(milliseconds: 1000), curve: Curves.bounceOut),
        child: Container(width: 200, height: 200, color: Colors.deepPurple.withOpacity(0.5), child: const Center(child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('WidgetTransitionEffects.incomingSlideInFromBottom with custom curve and slower speed'),
        )), ),
      ),
    ),
    Center(
      key: const ValueKey('7'),
      child: WidgetAnimator(
        incomingEffect: WidgetTransitionEffects(delay: const Duration(milliseconds: 500), duration: const Duration(milliseconds: 1000), blur: const Offset(20, 0)),
        child: Container(width: 200, height: 200, color: Colors.red.withOpacity(0.5), child: const Center(child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Blur X'),
        )), ),
      ),
    ),
    Center(
      key: const ValueKey('8'),
      child: WidgetAnimator(
        incomingEffect: WidgetTransitionEffects(delay: const Duration(milliseconds: 500), duration: const Duration(milliseconds: 1000), blur: const Offset(0, 30)),
        child: Container(width: 200, height: 200, color: Colors.green.withOpacity(0.5), child: const Center(child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Blur Y'),
        )), ),
      ),
    ),
    Center(
      key: const ValueKey('9'),
      child: WidgetAnimator(
        incomingEffect: WidgetTransitionEffects(delay: const Duration(milliseconds: 500), duration: const Duration(milliseconds: 1000), blur: const Offset(1.5, 1.5)),
        child: Container(width: 200, height: 200, color: Colors.blue.withOpacity(0.5), child: const Center(child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Blur X and Y'),
        )), ),
      ),
    ),
    Center(
      key: const ValueKey('10'),
      child: WidgetAnimator(
        incomingEffect: WidgetTransitionEffects(delay: const Duration(milliseconds: 500), duration: const Duration(milliseconds: 1000), skew: const Offset(0.4, 0)),
        child: Container(width: 200, height: 200, color: Colors.green, child: const Center(child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Skew X'),
        )), ),
      ),
    ),
    Center(
      key: const ValueKey('11'),
      child: WidgetAnimator(
        incomingEffect: WidgetTransitionEffects(delay: const Duration(milliseconds: 500), duration: const Duration(milliseconds: 1000), skew: const Offset(0, 0.4)),
        child: Container(width: 200, height: 200, color: Colors.cyan, child: const Center(child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Skew Y'),
        )), ),
      ),
    ),
    Center(
      key: const ValueKey('12'),
      child: WidgetAnimator(
        incomingEffect: WidgetTransitionEffects(delay: const Duration(milliseconds: 500), duration: const Duration(milliseconds: 1000), skew: const Offset(0.4, 0.4)),
        child: Container(width: 200, height: 200, color: Colors.orange, child: const Center(child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Skew X and Y'),
        )), ),
      ),
    ),
    Center(
      key: const ValueKey('13'),
      child: WidgetAnimator(
        incomingEffect: WidgetTransitionEffects(delay: const Duration(milliseconds: 500), duration: const Duration(milliseconds: 1000), rotation: math.pi/4),
        child: Container(width: 200, height: 200, color: Colors.purple, child: const Center(child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Rotate anti-clockwise'),
        )), ),
      ),
    ),
    Center(
      key: const ValueKey('14'),
      child: WidgetAnimator(
        incomingEffect: WidgetTransitionEffects(delay: const Duration(milliseconds: 500), duration: const Duration(milliseconds: 1000), rotation: -math.pi/3),
        child: Container(width: 200, height: 200, color: Colors.red, child: const Center(child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Rotate clockwise'),
        )), ),
      ),
    ),
    Center(
      key: const ValueKey('15'),
      child: WidgetAnimator(
        incomingEffect: WidgetTransitionEffects(delay: const Duration(milliseconds: 500), duration: const Duration(milliseconds: 1000), scale: 0.5, offset: const Offset(150,-130), rotation: -math.pi/6, blur: const Offset(3,3), skew: const Offset(0.3, 0.3), opacity: 0.8),
        child: Container(width: 200, height: 200, color: Colors.blue, child: const Center(child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Combination of scale, blue, offset, rotation and skew'),
        )), ),
      ),
    )

  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('Incoming Samples'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: (){
                setState(() {
                  currentPage==widgetList.length-1 ? currentPage = 0 : currentPage = currentPage + 1;
                });
              },
              child: Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 100),
                  child: widgetList[currentPage]
                ),
              ),
            ),
          ),
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              WidgetAnimator(
                incomingEffect: WidgetTransitionEffects.incomingSlideInFromBottom(delay: const Duration(milliseconds: 600), duration: const Duration(milliseconds: 600),curve: Curves.easeOut),
                child: OutlinedButton(onPressed: (){
                  setState(() {
                    currentPage== 0 ? currentPage = widgetList.length-1 : currentPage = currentPage - 1;
                  });
                }, child: const Text('Previous')),
              ),
              WidgetAnimator(
                incomingEffect: WidgetTransitionEffects.incomingSlideInFromBottom(delay: const Duration(milliseconds: 750), duration: const Duration(milliseconds: 600), curve: Curves.easeOut),
                child: OutlinedButton(onPressed: (){
                  setState(() {
                    currentPage==widgetList.length-1 ? currentPage = 0 : currentPage = currentPage + 1;
                  });
                }, child: const Text('Next')),
              ),
            ],),
          const SizedBox(height: 20,),
        ],
      ),
    );
  }
}




class SamplesOutgoing extends StatefulWidget {
  const SamplesOutgoing({Key? key}) : super(key: key);

  static Route<dynamic> route() {

    return MaterialPageRoute(builder: (BuildContext context) {
      return const SamplesOutgoing();
    });
  }

  @override
  State<SamplesOutgoing> createState() => _SamplesOutgoingState();
}

class _SamplesOutgoingState extends State<SamplesOutgoing> {


  int currentPage = 0;

  List<Widget> widgetList = [];

  @override
  void initState() {
    super.initState();

    widgetList = const [
      _OutgoingScaleDown(),
      _OutgoingScaleUp(),
      _OutgoingSlideOutLeft(),
      _OutgoingSlideOutRight(),
      _OutgoingSlideOutTop(),
      _OutgoingSlideOutBottom(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Outgoing Samples'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20,),
          const Text('Tap square to start outgoing animation'),
          const Expanded(child: SizedBox(),),
          IndexedStack(
            index: currentPage,
            children: widgetList,
          ),
          const Expanded(child: SizedBox(),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              WidgetAnimator(
                incomingEffect: WidgetTransitionEffects.incomingSlideInFromBottom(duration: const Duration(milliseconds: 600),curve: Curves.easeOut),
                child: OutlinedButton(onPressed: (){
                  setState(() {
                    currentPage== 0 ? currentPage = widgetList.length-1 : currentPage = currentPage - 1;
                  });
                }, child: const Text('Previous')),
              ),
              WidgetAnimator(
                incomingEffect: WidgetTransitionEffects.incomingSlideInFromBottom(delay: const Duration(milliseconds: 150), duration: const Duration(milliseconds: 600),curve: Curves.easeOut),
                child: OutlinedButton(onPressed: (){
                  setState(() {
                    currentPage==widgetList.length-1 ? currentPage = 0 : currentPage = currentPage + 1;
                  });
                }, child: const Text('Next')),
              ),
            ],),
          const SizedBox(height: 20,),
        ],
      ),
    );
  }
}



class _OutgoingScaleDown extends StatefulWidget {
  const _OutgoingScaleDown({Key? key}) : super(key: key);
  @override
  State<_OutgoingScaleDown> createState() => _OutgoingScaleDownState();
}

class _OutgoingScaleDownState extends State<_OutgoingScaleDown> {
  bool pressed = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: (){
      setState(() {
        pressed = true;
      });
    },child: WidgetAnimator(
            outgoingEffect: WidgetTransitionEffects.outgoingScaleDown(),
            onOutgoingAnimationComplete: (_) async{
              await Future.delayed(const Duration(seconds: 1));
              setState(() {
                pressed = false;
              });
            },
            child: pressed ? const SizedBox() : Center(child: Container(height: 200, width: 200, color: Colors.deepPurple, child: const Center(child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('WidgetTransitionEffects.outgoingScaleDown'),
            ))))));
  }
}


class _OutgoingScaleUp extends StatefulWidget {
  const _OutgoingScaleUp({Key? key}) : super(key: key);
  @override
  State<_OutgoingScaleUp> createState() => _OutgoingScaleUpState();
}

class _OutgoingScaleUpState extends State<_OutgoingScaleUp> {
  bool pressed = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: (){
      setState(() {
        pressed = true;
      });
    },child: WidgetAnimator(
        outgoingEffect: WidgetTransitionEffects.outgoingScaleUp(),
        onOutgoingAnimationComplete: (_) async{
          await Future.delayed(const Duration(seconds: 1));
          setState(() {
            pressed = false;
          });
        },
        child: pressed ? const SizedBox() : Center(child: Container(height: 200, width: 200, color: Colors.red, child: const Center(child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('WidgetTransitionEffects.outgoingScaleUp'),
        ))))));
  }
}


class _OutgoingSlideOutLeft extends StatefulWidget {
  const _OutgoingSlideOutLeft({Key? key}) : super(key: key);
  @override
  State<_OutgoingSlideOutLeft> createState() => _OutgoingSlideOutLeftState();
}

class _OutgoingSlideOutLeftState extends State<_OutgoingSlideOutLeft> {
  bool pressed = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: (){
      setState(() {
        pressed = true;
      });
    },child: WidgetAnimator(
        outgoingEffect: WidgetTransitionEffects.outgoingSlideOutToLeft(),
        onOutgoingAnimationComplete: (_) async{
          await Future.delayed(const Duration(seconds: 1));
          setState(() {
            pressed = false;
          });
        },
        child: pressed ? const SizedBox() : Center(child: Container(height: 200, width: 200, color: Colors.green, child: const Center(child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('WidgetTransitionEffects.outgoingSlideOutToLeft'),
        ))))));
  }
}


class _OutgoingSlideOutRight extends StatefulWidget {
  const _OutgoingSlideOutRight({Key? key}) : super(key: key);
  @override
  State<_OutgoingSlideOutRight> createState() => _OutgoingSlideOutRightState();
}

class _OutgoingSlideOutRightState extends State<_OutgoingSlideOutRight> {
  bool pressed = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: (){
      setState(() {
        pressed = true;
      });
    },child: WidgetAnimator(
        outgoingEffect: WidgetTransitionEffects.outgoingSlideOutToRight(),
        onOutgoingAnimationComplete: (_) async{
          await Future.delayed(const Duration(seconds: 1));
          setState(() {
            pressed = false;
          });
        },
        child: pressed ? const SizedBox() : Center(child: Container(height: 200, width: 200, color: Colors.blue, child: const Center(child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('WidgetTransitionEffects.outgoingSlideOutToRight'),
        ))))));
  }
}


class _OutgoingSlideOutTop extends StatefulWidget {
  const _OutgoingSlideOutTop({Key? key}) : super(key: key);
  @override
  State<_OutgoingSlideOutTop> createState() => _OutgoingSlideOutTopState();
}

class _OutgoingSlideOutTopState extends State<_OutgoingSlideOutTop> {
  bool pressed = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: (){
      setState(() {
        pressed = true;
      });
    },child: WidgetAnimator(
        outgoingEffect: WidgetTransitionEffects.outgoingSlideOutToTop(),
        onOutgoingAnimationComplete: (_) async{
          await Future.delayed(const Duration(seconds: 1));
          setState(() {
            pressed = false;
          });
        },
        child: pressed ? const SizedBox() : Center(child: Container(height: 200, width: 200, color: Colors.cyan, child: const Center(child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('WidgetTransitionEffects.outgoingSlideOutToTop'),
        ))))));
  }
}



class _OutgoingSlideOutBottom extends StatefulWidget {
  const _OutgoingSlideOutBottom({Key? key}) : super(key: key);
  @override
  State<_OutgoingSlideOutBottom> createState() => _OutgoingSlideOutBottomState();
}

class _OutgoingSlideOutBottomState extends State<_OutgoingSlideOutBottom> {
  bool pressed = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: (){
      setState(() {
        pressed = true;
      });
    },child: WidgetAnimator(
        outgoingEffect: WidgetTransitionEffects.outgoingSlideOutToBottom(),
        onOutgoingAnimationComplete: (_) async{
          await Future.delayed(const Duration(seconds: 1));
          setState(() {
            pressed = false;
          });
        },
        child: pressed ? const SizedBox() : Center(child: Container(height: 200, width: 200, color: Colors.redAccent, child: const Center(child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('WidgetTransitionEffects.outgoingSlideOutToBottom'),
        ))))));
  }
}