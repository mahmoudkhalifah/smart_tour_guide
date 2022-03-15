// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../login_signup/login_signup_screen.dart';


class WelcomeModel
{
  late final String image;
  late final String title;

  WelcomeModel({
    required this.image,
    required this.title,
  });
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);


  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override

  var welcomeController = PageController();
  List<WelcomeModel> welcome = [
    WelcomeModel(
        image: 'assets/images/pyramids.jpg',
        title: 'Take photos of monumentes and identify them'
    ),
    WelcomeModel(
        image: 'assets/images/fb.png',
        title: 'Take photos of monumentes and identify them'
    ),
    WelcomeModel(
        image: 'assets/images/go.png',
        title: 'Take photos of monumentes and identify them'
    ),
    WelcomeModel(
        image: 'assets/images/tw.png',
        title: 'Take photos of monumentes and identify them'
    ),
  ];
  bool? isLast = false;


  void navigateTo(context , widget) => Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => widget),
          (route) => false);


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Monuments',
              style: TextStyle(
                color: Color(0xffffb319),
                fontSize: 40.0,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Identifications',
              style: TextStyle(
                color: Color(0xffffb319),
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            //const SizedBox(height: 100),
            Expanded(
              child: PageView.builder(
                controller: welcomeController,
                onPageChanged: (int index){
                  if(index == welcome.length-1 )
                  {
                    setState(() {
                      isLast = true;
                    });
                  } else
                  {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) => buildBoardingItem(welcome[index]),
                itemCount: welcome.length,
                scrollDirection: Axis.horizontal,
              ),
            ),
            //const SizedBox(height: 50),
            Row(
              children:  [
                SmoothPageIndicator(controller: welcomeController, count: welcome.length,effect: const ExpandingDotsEffect(
                    expansionFactor: 2,
                    activeDotColor:Color(0xffffb319)
                ),),
                const Spacer(),
                FloatingActionButton(onPressed: () {
                  if (isLast!)
                  {
                    navigateTo(context, LoginScreen());
                  }
                  else {
                    welcomeController.nextPage(duration: Duration(milliseconds: 1050),
                      curve: Curves.fastLinearToSlowEaseIn,);
                  }
                },
                  child: const Icon(
                    Icons.arrow_forward_ios,
                  ),
                  backgroundColor: Color(0xffffb319),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget buildBoardingItem(WelcomeModel model) =>  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
          image: AssetImage(model.image),
          height: 300,
          width: double.infinity,
        ),
      ),
      const SizedBox(height: 20,),
      Text(
        model.title,
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
    ],
  );
}