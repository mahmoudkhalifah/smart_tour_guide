import 'package:app/presentation/widgets/default_text_field.dart';
import 'package:flutter/material.dart';

class ForgotPasswordForm extends StatelessWidget {
  ForgotPasswordForm({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultTextField(
          prefixIcon: Icons.person,
          label: "email or username",
          controller: emailController,
          validator: (value) {
            if(value!.isEmpty) {
              return "this field can't be empty";
            }
          },
        ),
      ],
    );
  }
}
