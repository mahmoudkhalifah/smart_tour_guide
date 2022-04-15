import 'package:flutter/material.dart';

class SocialMediaButton extends StatelessWidget {
  const SocialMediaButton({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: name,
      onPressed: () {},
      elevation: 0,
      mini: true,
      child: Image.asset(name),
      backgroundColor: Colors.white,
    );
  }
}
