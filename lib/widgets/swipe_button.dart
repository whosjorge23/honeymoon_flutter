import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:honeymoon_flutter/models/honeymoon_location.dart';
import 'package:swipable_stack/swipable_stack.dart';

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
