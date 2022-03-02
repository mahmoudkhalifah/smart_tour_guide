import 'package:flutter/material.dart';

class SocialMediaButton extends StatelessWidget {
  SocialMediaButton({
    Key? key,
    required this.url,
  }) : super(key: key);

  String url;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      elevation: 0,
      mini: true,
      child: Image.network(url),
      backgroundColor: Colors.white,
    );
  }
}
