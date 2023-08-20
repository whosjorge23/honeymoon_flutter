import 'package:flutter/material.dart';
import 'package:honeymoon_flutter/models/honeymoon_location.dart';
import 'package:honeymoon_flutter/widgets/example_card.dart';

class DetailsView extends StatefulWidget {
  DetailsView({super.key, required this.selectedArray});

  List<HoneymoonLocation> selectedArray;

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List"),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            itemCount: widget.selectedArray.length,
            itemBuilder: (context, index) {
              return ExampleCard(
                name: widget.selectedArray[index].title,
                assetPath: widget.selectedArray[index].imageUrl,
              );
            },
          ),
        ),
      ),
    );
  }
}
