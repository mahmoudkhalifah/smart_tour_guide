import 'package:app/localization/app_localizations.dart';
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
          label: AppLocalizations.of(context).translate("email"),
          controller: emailController,
          validator: (value) {
            if(value!.isEmpty) {
              return AppLocalizations.of(context).translate("validation");
            }
          },
        ),
      ],
    );
  }
}
