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
            Text(widget.selectedLocation.content),
            Text(
              widget.selectedLocation.content,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            ElevatedButton(
                onPressed: () {
                  //Open a web link to book the honeymoon
                },
                child: Text("Booking Now")),
          ],
        ),
      ),
    );
  }
}
