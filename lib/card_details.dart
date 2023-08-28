import 'package:flutter/material.dart';
import 'package:honeymoon_flutter/models/honeymoon_location.dart';

class CardDetails extends StatefulWidget {
  CardDetails({super.key, required this.selectedLocation});

  HoneymoonLocation selectedLocation;

  @override
  State<CardDetails> createState() => _CardDetailsState();
}

class _CardDetailsState extends State<CardDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.selectedLocation.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("Image"),
            Text("Title"),
            Text("Information"),
            Text("Booking Button"),
          ],
        ),
      ),
    );
  }
}
