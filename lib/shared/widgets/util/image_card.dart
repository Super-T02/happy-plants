import 'package:flutter/material.dart';

class ImageCard extends StatefulWidget {
  const ImageCard({Key? key, required this.url, required this.name}) : super(key: key);
  final String url;
  final String name;

  @override
  State<ImageCard> createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        image: DecorationImage(
          image: AssetImage(widget.url),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
