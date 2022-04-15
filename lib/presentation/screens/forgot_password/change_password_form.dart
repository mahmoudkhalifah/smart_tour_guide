// ignore_for_file: prefer_const_constructors

import 'package:app/localization/app_localizations.dart';
import 'package:app/presentation/widgets/default_text_field.dart';
import 'package:flutter/material.dart';

class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm({Key? key}) : super(key: key);
  
  @override
  _ChangePasswordFormState createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool passwordObsecure = true;
  bool confirmPasswordObsecure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        DefaultTextField(
          obsecure: passwordObsecure,
          label: AppLocalizations.of(context).translate("password"),
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
          validator: (value) {
            if(value!.isEmpty) {
              return AppLocalizations.of(context).translate("password validation");
            }
          },
        ),
        DefaultTextField(
          obsecure: confirmPasswordObsecure,
          label: AppLocalizations.of(context).translate("confirm password"),
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
          validator: (value) {
            if(value!.isEmpty) {
              return AppLocalizations.of(context).translate("confirm password validation");
            }
          },
        ),
      ],
    );
  }
}
