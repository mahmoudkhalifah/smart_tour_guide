import 'package:app/localization/app_localizations.dart';
import 'package:app/presentation/widgets/default_text_field.dart';
import 'package:app/strings.dart';
import 'package:flutter/material.dart';


class LoginCard extends StatefulWidget {
  const LoginCard({Key? key}) : super(key: key);

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
          label: AppLocalizations.of(context).translate("email"),
          prefixIcon: Icons.person,
          controller: emailController,
          validator: (value) {
            if (value!.isEmpty) {
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
              setState(() {});
            },
            icon: passwordObsecure
                ? const Icon(Icons.visibility)
                : const Icon(Icons.visibility_off),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return AppLocalizations.of(context).translate("validation");
            }
          },
          controller: passwordController,
        ),
        TextButton(
            onPressed: () {
              Navigator.pushNamed(
                  context,
                  forgotPasswordViewRoute,
              );
            },
            child: Text(
              AppLocalizations.of(context).translate("forgot password"),
              style: const TextStyle(color: Colors.grey),
            ))
      ],
    );
  }
}
