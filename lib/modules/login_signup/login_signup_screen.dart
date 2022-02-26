// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:app/Modules/login_signup/signup_card.dart';
import 'package:app/modules/login_signup/login_card.dart';
import 'package:app/shared/components/default_button.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Opacity(
          opacity: 0.8,
          child: Container(
              height: 523,
              width: 315,
              decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(34),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(205, 204, 241, .3),
                    blurRadius: 15
                  )
                ]
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 28,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary
                        )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          DefaultButton(
                            onPressed: isLogin?(){}:(){
                              setState(() {
                                isLogin = true;
                              });
                            },
                            width: 112,
                            height: 28,
                            child: Text("Login"),
                            color: isLogin?null:Colors.white,
                            textColor: isLogin?Colors.white:Theme.of(context).colorScheme.primary,
                          ),
                          DefaultButton(
                            onPressed: !isLogin?(){}:(){
                              setState(() {
                                isLogin = false;
                              });
                            },
                            width: 112,
                            height: 28,
                            child: Text("Signup"),
                            color: !isLogin?null:Colors.white,
                            textColor: !isLogin?Colors.white:Theme.of(context).colorScheme.primary,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(20),
                        child: isLogin?LoginCard():SignupCard()
                    ),
                    DefaultButton(
                      onPressed: (){},
                      width: 235,
                      height: 44,
                      child: isLogin?Text("Login"):Text("Signup"),
                    ),
                  ],
                ),
              )
          ),
        ),
      ),
    );
  }
}