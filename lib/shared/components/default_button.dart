import 'package:flutter/material.dart';

class DefaultButton extends StatefulWidget {
  DefaultButton({
    Key? key,
    required this.height,
    required this.width,
    required this.onPressed,
    required this.child,
    this.color,
    this.textColor,
  }) : super(key: key);

  final double width;
  final double height;
  final Function() onPressed;
  final Widget child;
  final Color? color;
  final Color? textColor;

  @override
  State<DefaultButton> createState() => _DefaultButtonState();
}

class _DefaultButtonState extends State<DefaultButton> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      onPressed: widget.onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
      minWidth: widget.width,
      height: widget.height,
      color: widget.color ?? Theme.of(context).colorScheme.primary,
      child: widget.child,
      textColor: widget.textColor??Colors.white,

    );
  }
}
