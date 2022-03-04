import 'package:app/presentation/widgets/default_text_field.dart';
import 'package:flutter/material.dart';

class SignupCard extends StatefulWidget {
  SignupCard({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool passwordObsecure = true;
  bool confirmPasswordObsecure = true;

  @override
  _SignupCardState createState() => _SignupCardState();
}

class _SignupCardState extends State<SignupCard> {



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultTextField(
            label: "email or username",
            prefixIcon: Icons.person,
            controller: widget.emailController
        ),
        DefaultTextField(
          obsecure: widget.passwordObsecure,
          label: "password",
          prefixIcon: Icons.lock,
          suffixIcon: IconButton(
            onPressed: () {
              widget.passwordObsecure = !widget.passwordObsecure;
              setState(() {

              });
            },
            icon: widget.passwordObsecure?const Icon(Icons.visibility):const Icon(Icons.visibility_off),
          ),
          controller: widget.passwordController,
        ),
        DefaultTextField(
          obsecure: widget.confirmPasswordObsecure,
          label: "confirm password",
          prefixIcon: Icons.lock,
          suffixIcon: IconButton(
            onPressed: () {
              widget.confirmPasswordObsecure = !widget.confirmPasswordObsecure;
              setState(() {

              });
            },
            icon: widget.confirmPasswordObsecure?const Icon(Icons.visibility):const Icon(Icons.visibility_off),
          ),
          controller: widget.confirmPasswordController,
        )
      ],
    );
  }
}
