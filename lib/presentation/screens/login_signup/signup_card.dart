import 'package:app/localization/app_localizations.dart';
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
          label: AppLocalizations.of(context).translate("email"),
          prefixIcon: Icons.person,
          controller: widget.emailController,
          validator: (value) {
            if(value!.isEmpty) {
              return AppLocalizations.of(context).translate("validation");
            }
          },
        ),
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
          validator: (value) {
            if(value!.isEmpty) {
              // TODO
              return AppLocalizations.of(context).translate("password validation");
            }
          },
          controller: widget.passwordController,
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
          validator: (value) {
            if(value!.isEmpty) {
              // TODO
              return AppLocalizations.of(context).translate("confirm password validation");
            }
          },
          controller: widget.confirmPasswordController,
        )
      ],
    );
  }
}
