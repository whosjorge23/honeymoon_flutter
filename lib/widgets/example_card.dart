import 'package:flutter/material.dart';
import 'package:honeymoon_flutter/widgets/bottom_buttons_row.dart';

class ExampleCard extends StatelessWidget {
  const ExampleCard({
    required this.name,
    required this.assetPath,
    this.isDetailsView = false,
    super.key,
  });

  final String name;
  final String assetPath;
  final bool isDetailsView;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ClipRRect(
      child: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                image: DecorationImage(
                  image: NetworkImage(assetPath),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 2),
                    blurRadius: 26,
                    color: Colors.black.withOpacity(0.08),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(14),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Colors.black12.withOpacity(0),
                    Colors.black12.withOpacity(.4),
                    Colors.black12.withOpacity(.82),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isDetailsView) const SizedBox(height: BottomButtonsRow.height * 1.5),
                Text(
                  name,
                  style: theme.textTheme.headline6!.copyWith(
                    color: Colors.white,
                  ),
                ),
                if (!isDetailsView) const SizedBox(height: BottomButtonsRow.height / 2.5)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
