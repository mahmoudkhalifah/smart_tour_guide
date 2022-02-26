import 'package:app/shared/components/default_text_field.dart';
import 'package:flutter/material.dart';

class SignupCard extends StatefulWidget {
  const SignupCard({Key? key}) : super(key: key);

  @override
  _SignupCardState createState() => _SignupCardState();
}

class _SignupCardState extends State<SignupCard> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool passwordObsecure = true;
  bool confirmPasswordObsecure = true;


  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
        DefaultTextField(
          label: "email or username",
          prefixIcon: Icons.person,
          controller: emailController
        ),
        DefaultTextField(
          obsecure: passwordObsecure,
          label: "password",
          prefixIcon: Icons.lock,
          suffixIcon: IconButton(
              onPressed: () {
                passwordObsecure = !passwordObsecure;
                setState(() {

                });
              },
              icon: passwordObsecure?const Icon(Icons.visibility):const Icon(Icons.visibility_off),
            ),
          controller: passwordController,
        ),
        DefaultTextField(
          obsecure: confirmPasswordObsecure,
          label: "confirm password",
          prefixIcon: Icons.lock,
          suffixIcon: IconButton(
            onPressed: () {
              confirmPasswordObsecure = !confirmPasswordObsecure;
              setState(() {

              });
            },
            icon: confirmPasswordObsecure?const Icon(Icons.visibility):const Icon(Icons.visibility_off),
          ),
          controller: confirmPasswordController,
        )
      ],
    );
  }
}
