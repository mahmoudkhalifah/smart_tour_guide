import 'package:flutter/material.dart';

///You MUST specify height and width of the button
///You MUST specify on pressed function
///You MUST Specify child it or tree of children
///You CAN change color of it but it's default color is our primary color
///You CAN change text color but it's default is white

class DefaultButton extends StatefulWidget {
  const DefaultButton({
    Key? key,
    required this.height,
    required this.width,
    required this.onPressed,
    required this.child,
    this.color,
    this.textColor,
    this.borderColor
  }) : super(key: key);

  final double width;
  final double height;
  final Function() onPressed;
  final Widget child;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;

  @override
  State<DefaultButton> createState() => _DefaultButtonState();
}

class _DefaultButtonState extends State<DefaultButton> {
  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      maxWidth: widget.width,
      child: MaterialButton(
        elevation: 0,
        onPressed: widget.onPressed,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
            side: BorderSide(
                color: widget.borderColor ?? Colors.transparent
            )
        ),
        height: widget.height,
        minWidth: widget.width,
        color: widget.color ?? Theme.of(context).colorScheme.primary,
        child: widget.child,
        textColor: widget.textColor??Colors.white,

      ),
    );
  }
}
