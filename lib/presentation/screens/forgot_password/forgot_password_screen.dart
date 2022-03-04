// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:app/presentation/screens/forgot_password/forgot_password_form.dart';
import 'package:app/presentation/widgets/default_button.dart';
import 'package:app/presentation/widgets/default_text_field.dart';
import 'package:flutter/material.dart';

import 'change_password_form.dart';

class ForgotPasswordScreen extends StatefulWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);
  bool isEmailFound = false;
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("Forgot password"),
        ),
        body: Center(
            child: SingleChildScrollView(
                child: Opacity(
                    opacity: 0.8,
                    child: Container(
                        width: 315,
                        decoration: BoxDecoration(
                            color: Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(34),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(205, 204, 241, .3),
                                  blurRadius: 15)
                            ]),
                        child: Padding(
                            padding: const EdgeInsets.all(41.5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                !widget.isEmailFound?ForgotPasswordForm():ChangePasswordForm(),
                                SizedBox(height: 15,),
                                DefaultButton(
                                  onPressed: (){
                                    widget.isEmailFound = true;
                                    setState(() {

                                    });
                                  },
                                  width: 235,
                                  height: 44,
                                  child: !widget.isEmailFound?Text("forgot password"):Text("reset password"),
                                ),
                              ],
                            )
                        )
                    )
                )
            )
        )
    );
  }
}
