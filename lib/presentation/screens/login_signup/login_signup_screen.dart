// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:app/presentation/screens/login_signup/login_card.dart';
import 'package:app/presentation/screens/login_signup/signup_card.dart';
import 'package:app/presentation/screens/login_signup/social_media_button.dart';
import 'package:app/presentation/widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
      body: Stack(
        children: [
          Positioned(
            bottom: MediaQuery.of(context).size.height*0.65,
            right: -MediaQuery.of(context).size.width*0.5,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              child: Opacity(
                opacity: 0.4,
                child: ClipOval(
                  child: CircleAvatar(
                    radius: MediaQuery.of(context).size.width,
                    child: Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height<700?MediaQuery.of(context).size.height*0.8:MediaQuery.of(context).size.height*0.5),
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
                      padding: const EdgeInsets.symmetric(horizontal: 41.5,vertical: 50),
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
                          Container(
                              height: 180,
                              child:isLogin?LoginCard():SignupCard()
                          ),
                          DefaultButton(
                            onPressed: (){

                            },
                            width: 235,
                            height: 44,
                            child: isLogin?Text("Login"):Text("Signup"),
                          ),
                          Text(
                            "OR",
                            style: TextStyle(
                                color: Colors.grey
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SocialMediaButton(url: "https://icons-for-free.com/iconfiles/png/512/facebook+logo+logo+website+icon-1320190502625926346.png"),
                              SocialMediaButton(url: "https://ra.ac.ae/wp-content/uploads/2020/01/logo-twitter-icon-symbol-0.png"),
                              SocialMediaButton(url: "https://freesvg.org/img/1534129544.png"),
                            ],
                          )
                        ],
                      ),
                    )
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}