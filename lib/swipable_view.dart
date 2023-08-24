import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:honeymoon_flutter/models/honeymoon_location.dart';
import 'package:honeymoon_flutter/widgets/card_overlay.dart';
import 'package:honeymoon_flutter/widgets/example_card.dart';
import 'package:swipable_stack/swipable_stack.dart';

class SwipableView extends StatefulWidget {
  const SwipableView({super.key, required this.title});

  final String title;

  @override
  State<SwipableView> createState() => _SwipableViewState();
}

class _SwipableViewState extends State<SwipableView> {
  late final SwipableStackController _controller;

  bool cardsAreFinished = false;

  void _listenController() => setState(() {});

  List<HoneymoonLocation> _honeymoonLocations = [
    HoneymoonLocation(
      title: "Cape Town 1",
      imageUrl: 'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/14/10/2e/1e/cape-town.jpg?w=2400&h=-1&s=1',
    ),
    HoneymoonLocation(
      title: "Cape Town 2",
      imageUrl:
          'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/11/30/96/12/cape-to-grape-wine-tours.jpg?w=1200&h=-1&s=1',
    ),
    HoneymoonLocation(
      title: "Cape Town 3",
      imageUrl: 'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/15/79/ab/1d/saffa-tours.jpg?w=1100&h=-1&s=1',
    ),
    // HoneymoonLocation(
    //   title: "Athens",
    //   imageUrl: '',
    // ),
    // HoneymoonLocation(
    //   title: "Barcelona",
    //   imageUrl: '',
    // ),
  ];

  List<HoneymoonLocation> yayArray = [];
  List<HoneymoonLocation> nayArray = [];

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
                              print('$index, $direction, ${_honeymoonLocations[index].title}');
                            }
                            if (direction == SwipeDirection.right) {
                              yayArray.add(_honeymoonLocations[index]);
                            } else {
                              nayArray.add(_honeymoonLocations[index]);
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
                    SwipeButton(
                      cardsAreFinished: cardsAreFinished,
                      controller: _controller,
                      sDirection: SwipeDirection.left,
                      array: nayArray,
                      color: Colors.redAccent,
                      icon: Icons.thumb_down_alt_rounded,
                      text: 'NAY',
                    ),
                    SizedBox(width: 10),
                    SwipeButton(
                      cardsAreFinished: cardsAreFinished,
                      controller: _controller,
                      sDirection: SwipeDirection.right,
                      array: yayArray,
                      color: Colors.green,
                      icon: Icons.thumb_up_alt_rounded,
                      text: 'YAY',
                    ),
                    // Expanded(
                    //   child: Container(
                    //     // color: Colors.green,
                    //     child: ElevatedButton(
                    //       style: ElevatedButton.styleFrom(foregroundColor: Colors.green),
                    //       onPressed: () {
                    //         if (!cardsAreFinished) {
                    //           _controller.next(swipeDirection: SwipeDirection.right);
                    //         } else {
                    //           print(yayArray);
                    //           context.go('/detailPage', extra: yayArray);
                    //         }
                    //       },
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [Text("YAY"), SizedBox(width: 5), Icon(Icons.thumb_up_alt_rounded)],
                    //       ),
                    //     ),
                    //   ),
                    // ),
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

class SwipeButton extends StatelessWidget {
  const SwipeButton(
      {super.key,
      required this.cardsAreFinished,
      required SwipableStackController controller,
      required this.array,
      required this.color,
      required this.icon,
      required this.text,
      required this.sDirection})
      : _controller = controller;

  final bool cardsAreFinished;
  final SwipableStackController _controller;
  final List<HoneymoonLocation> array;
  final Color color;
  final IconData icon;
  final String text;
  final SwipeDirection sDirection;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        // color: Colors.red,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(foregroundColor: color),
          onPressed: () {
            if (!cardsAreFinished) {
              _controller.next(swipeDirection: sDirection);
            } else {
              print(array);
              context.go('/detailPage', extra: array);
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text(text), SizedBox(width: 5), Icon(icon)],
          ),
        ),
      ),
    );
  }
}
