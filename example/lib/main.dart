import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import 'samples.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
      primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Widget and text animator'),
    );
  }
}


/// [MyHomePage] is a slightly tacky version of the default template app for flutter with the counter
/// It's a close to the original version as possible, but trying to animate pretty much very bit of text and widget to
/// give a simple example of how basic animations can be added very simply
/// Wouldn't recommend animating everything like this in your app :D
/// [Text] widgets have been replaced with [TextAnimator] widgets
/// Buttons such as the [FloatingActionButton] has been wrapped with a [WidgetAnimator]
/// A "Samples" button has also been added to get through at more examples of the animations possible
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: TextAnimator(widget.title, atRestEffect: WidgetRestingEffects.wave(),),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Expanded(child: SizedBox(),),

            TextAnimator(
              'You have pushed the button this many times:',
              atRestEffect: WidgetRestingEffects.pulse(effectStrength: 0.6),
              style: Theme.of(context).textTheme.headline5,
              incomingEffect: WidgetTransitionEffects.incomingSlideInFromTop(blur: const Offset(0, 20), scale: 2),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            TextAnimator(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
              incomingEffect: WidgetTransitionEffects.incomingSlideInFromBottom(curve: Curves.bounceOut, duration: const Duration(milliseconds: 1500)),
              atRestEffect: WidgetRestingEffects.dangle(),
              outgoingEffect: WidgetTransitionEffects.outgoingSlideOutToRight(),
            ),
            const Expanded(child: SizedBox(),),
            WidgetAnimator(
              incomingEffect: WidgetTransitionEffects(delay: const Duration(milliseconds: 1500), offset: const Offset(0, -30), curve: Curves.bounceOut, duration: const Duration(milliseconds: 900)),
              atRestEffect: WidgetRestingEffects.wave(),
              child: ElevatedButton(child: const Text('Samples'), onPressed: () {
                Navigator.of(context).push(Samples.route());
              }),
            ),
            const SizedBox(height: 20,)
          ],
        ),
      ),
      floatingActionButton: WidgetAnimator(
        atRestEffect: WidgetRestingEffects.size(),
        child: FloatingActionButton(
          isExtended: true,
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
