// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:app/presentation/screens/home/home_screen.dart';
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
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            bottom: MediaQuery.of(context).size.height<700?MediaQuery.of(context).size.height*0.7:MediaQuery.of(context).size.height*0.72,
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
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height<700?MediaQuery.of(context).size.height*0.82:MediaQuery.of(context).size.height*0.55),
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
                    height: 555,
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
                      padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 40),
                      child: Column(
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
                          SizedBox(height: 10,),
                          Form(
                            key: formKey,
                            child:isLogin?LoginCard():SignupCard(),
                          ),
                          Spacer(),
                          DefaultButton(
                            onPressed: (){
                              if(formKey.currentState!.validate()) {

                              }
                            },
                            width: 235,
                            height: 44,
                            child: isLogin?Text("Login"):Text("Signup"),
                          ),
                          SizedBox(height: 10,),
                          DefaultButton(
                            onPressed: (){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                            },
                            width: 235,
                            height: 44,
                            child: Text("Enter as guest"),
                            color: Colors.white,
                            textColor: Theme.of(context).colorScheme.primary,
                            borderColor: Theme.of(context).colorScheme.primary,
                          ),
                          SizedBox(height: 10,),
                          Text(
                            "OR",
                            style: TextStyle(
                                color: Colors.grey
                            ),
                          ),
                          SizedBox(height: 10,),
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