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
            Image.network(widget.selectedLocation.imageUrl),
            Text(
              widget.selectedLocation.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
            Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
            ElevatedButton(onPressed: () {}, child: Text("Booking Now")),
          ],
        ),
      ),
    );
  }
}
