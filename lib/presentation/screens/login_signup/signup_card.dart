import 'package:app/localization/app_localizations.dart';
import 'package:app/presentation/widgets/default_text_field.dart';
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
          label: AppLocalizations.of(context).translate("email"),
          prefixIcon: Icons.person,
          controller: emailController,
          validator: (value) {
            if(value!.isEmpty) {
              return AppLocalizations.of(context).translate("validation");
            }
          },
        ),
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
          validator: (value) {
            if(value!.isEmpty) {
              // TODO
              return AppLocalizations.of(context).translate("password validation");
            }
          },
          controller: passwordController,
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
          validator: (value) {
            if(value!.isEmpty) {
              // TODO
              return AppLocalizations.of(context).translate("confirm password validation");
            }
          },
          controller: confirmPasswordController,
        )
      ],
    );
  }
}
