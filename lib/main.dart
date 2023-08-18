import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:honeymoon_flutter/models/honeymoon_location.dart';
import 'package:honeymoon_flutter/widgets/card_overlay.dart';
import 'package:honeymoon_flutter/widgets/example_card.dart';
import 'package:swipable_stack/swipable_stack.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Honeymoon Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final SwipableStackController _controller;

  bool cardsAreFinished = false;

  void _listenController() => setState(() {});

  List<HoneymoonLocation> _honeymoonLocations = [
    HoneymoonLocation(
        title: "Cape Town 1",
        imageUrl: 'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/14/10/2e/1e/cape-town.jpg?w=2400&h=-1&s=1'),
    HoneymoonLocation(
        title: "Cape Town 2",
        imageUrl:
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/11/30/96/12/cape-to-grape-wine-tours.jpg?w=1200&h=-1&s=1'),
    HoneymoonLocation(
        title: "Cape Town 3",
        imageUrl:
            'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/15/79/ab/1d/saffa-tours.jpg?w=1100&h=-1&s=1'),
  ];

  @override
  void initState() {
    super.initState();
    _controller = SwipableStackController()..addListener(_listenController);
  }

  @override
  void dispose() {
    super.dispose();
    _controller
      ..removeListener(_listenController)
      ..dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 8,
                child: Container(
                  // color: Colors.yellow,
                  child: cardsAreFinished
                      ? Container(
                          color: Colors.white,
                          child: Center(
                            child: Text("NO MORE CARDS TO DISPLAY!"),
                          ),
                        )
                      : SwipableStack(
                          detectableSwipeDirections: cardsAreFinished
                              ? {}
                              : {
                                  SwipeDirection.right,
                                  SwipeDirection.left,
                                },
                          allowVerticalSwipe: false,
                          controller: _controller,
                          swipeAnchor: SwipeAnchor.bottom,
                          stackClipBehaviour: Clip.none,
                          onSwipeCompleted: (index, direction) {
                            if (kDebugMode) {
                              print('$index, $direction');
                            }
                            if (index == _honeymoonLocations.length - 1) {
                              print("finished");
                              cardsAreFinished = true;
                              setState(() {});
                            }
                          },
                          horizontalSwipeThreshold: 0.8,
                          verticalSwipeThreshold: 0.8,
                          builder: (context, properties) {
                            final itemIndex = properties.index % _honeymoonLocations.length;
                            return Stack(
                              children: [
                                ExampleCard(
                                  name: _honeymoonLocations[itemIndex].title,
                                  assetPath: _honeymoonLocations[itemIndex].imageUrl,
                                ),
                                // more custom overlay possible than with overlayBuilder
                                if (properties.stackIndex == 0 && properties.direction != null)
                                  CardOverlay(
                                    swipeProgress: properties.swipeProgress,
                                    direction: properties.direction!,
                                  )
                              ],
                            );
                          },
                        ),
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        // color: Colors.red,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(foregroundColor: Colors.redAccent),
                          onPressed: () {
                            if (!cardsAreFinished) _controller.next(swipeDirection: SwipeDirection.left);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Text("NAY"), SizedBox(width: 5), Icon(Icons.thumb_down_alt_rounded)],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        // color: Colors.green,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(foregroundColor: Colors.green),
                          onPressed: () {
                            if (!cardsAreFinished) _controller.next(swipeDirection: SwipeDirection.right);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Text("YAY"), SizedBox(width: 5), Icon(Icons.thumb_up_alt_rounded)],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
