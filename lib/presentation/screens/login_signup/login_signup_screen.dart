// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:app/localization/app_localizations.dart';
import 'package:app/presentation/screens/login_signup/login_card.dart';
import 'package:app/presentation/screens/login_signup/signup_card.dart';
import 'package:app/presentation/screens/login_signup/social_media_button.dart';
import 'package:app/presentation/widgets/default_button.dart';
import 'package:app/strings.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLogin = true;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            bottom: MediaQuery.of(context).size.height < 700
                ? MediaQuery.of(context).size.height * 0.7
                : MediaQuery.of(context).size.height * 0.72,
            right: -MediaQuery.of(context).size.width * 0.5,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              child: Opacity(
                opacity: 0.4,
                child: ClipOval(
                  child: CircleAvatar(
                    radius: MediaQuery.of(context).size.width,
                    child: Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height < 700
                              ? MediaQuery.of(context).size.height * 0.82
                              : MediaQuery.of(context).size.height * 0.55),
                      child: Image.asset(
                        "assets/images/pyramids.jpg",
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Opacity(
                opacity: 0.8,
                child: Container(
                    height: 565,
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 30),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 28,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(22),
                                border: Border.all(
                                    color:
                                        Theme.of(context).colorScheme.primary)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                DefaultButton(
                                  onPressed: isLogin
                                      ? () {}
                                      : () {
                                          setState(() {
                                            isLogin = true;
                                          });
                                        },
                                  width: 112,
                                  height: 28,
                                  child: Text(AppLocalizations.of(context)
                                      .translate("login")),
                                  color: isLogin ? null : Colors.white,
                                  textColor: isLogin
                                      ? Colors.white
                                      : Theme.of(context).colorScheme.primary,
                                ),
                                DefaultButton(
                                  onPressed: !isLogin
                                      ? () {}
                                      : () {
                                          setState(() {
                                            isLogin = false;
                                          });
                                        },
                                  width: 112,
                                  height: 28,
                                  child: Text(AppLocalizations.of(context)
                                      .translate("signup")),
                                  color: !isLogin ? null : Colors.white,
                                  textColor: !isLogin
                                      ? Colors.white
                                      : Theme.of(context).colorScheme.primary,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Form(
                            key: formKey,
                            child: isLogin ? LoginCard() : SignupCard(),
                          ),
                          Spacer(),
                          DefaultButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {}
                            },
                            width: 235,
                            height: 44,
                            child: isLogin
                                ? Text(AppLocalizations.of(context)
                                    .translate("login"))
                                : Text(AppLocalizations.of(context)
                                    .translate("signup")),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          DefaultButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                context,
                                homeViewRoute,
                              );
                            },
                            width: 235,
                            height: 44,
                            child: Text(AppLocalizations.of(context)
                                .translate("guest")),
                            color: Colors.white,
                            textColor: Theme.of(context).colorScheme.primary,
                            borderColor: Theme.of(context).colorScheme.primary,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            AppLocalizations.of(context).translate("or"),
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SocialMediaButton(name: "assets/images/fb.png"),
                              SocialMediaButton(name: "assets/images/tw.png"),
                              SocialMediaButton(name: "assets/images/go.png"),
                            ],
                          )
                        ],
                      ),
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
