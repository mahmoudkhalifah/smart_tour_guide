import 'package:app/presentation/widgets/default_text_field.dart';
import 'package:flutter/material.dart';

class LoginCard extends StatefulWidget {
  LoginCard({Key? key}) : super(key: key);

  @override
  _LoginCardState createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordObsecure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
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
        TextButton(
            onPressed: () {},
            child: Text(
              "forgot password ?",
              style: TextStyle(
                  color: Colors.grey
              ),
            )
        )
      ],
    );
  }
}
