// ignore_for_file: prefer_const_constructors

import 'package:app/localization/app_localizations.dart';
import 'package:app/presentation/widgets/default_text_field.dart';
import 'package:flutter/material.dart';

class ChangePasswordForm extends StatefulWidget {
  ChangePasswordForm({Key? key}) : super(key: key);
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool passwordObsecure = true;
  bool confirmPasswordObsecure = true;
  @override
  _ChangePasswordFormState createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        DefaultTextField(
          obsecure: widget.passwordObsecure,
          label: AppLocalizations.of(context).translate("password"),
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
          validator: (value) {
            if(value!.isEmpty) {
              return AppLocalizations.of(context).translate("password validation");
            }
          },
        ),
        DefaultTextField(
          obsecure: widget.confirmPasswordObsecure,
          label: AppLocalizations.of(context).translate("confirm password"),
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
