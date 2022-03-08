import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PlaceInfoScreen extends StatefulWidget {

  @override
  State<PlaceInfoScreen> createState() => _PlaceInfoScreenState();
}

class _PlaceInfoScreenState extends State<PlaceInfoScreen> {
  int activeIndex = 0;
  bool favouriteClicked = false;
  bool visitedClicked = false;
  final imagesPath = [
    'assets/images/pyramids.jpg',
    'assets/images/go.png',
    'assets/images/tw.png',

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsetsDirectional.only(start: 40.0,top: 10,end: 40,bottom: 10),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    'Pyramids',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: (){
                      setState(() {
                        visitedClicked =!visitedClicked;
                      });
                    },
                    icon: Icon(
                      Icons.add_task_outlined,
                      color: visitedClicked? Colors.orange : Colors.black,
                    ),
                    iconSize: 24,
                  ),
                  IconButton(
                    onPressed: (){
                      setState(() {
                        favouriteClicked = !favouriteClicked;
                      });
                    },
                    icon: Icon(
                      Icons.favorite_rounded,
                      color: favouriteClicked? Colors.red : Colors.grey,
                    ),
                    iconSize: 24,
                  ),

                ],
              ),
              SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CarouselSlider.builder(options: CarouselOptions(
                    height: 170,
                    viewportFraction: 1.0,
                    enlargeCenterPage: false,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(seconds: 1),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal,
                        onPageChanged: (index , reason) =>
                            setState(()=>activeIndex = index),
                  ),
                    itemCount: (imagesPath.length),
                    itemBuilder: (context , index , realIndex){
                      final imagePath = imagesPath[index];
                      return buildImage(imagePath , index);
                    },
                   ),
                  SizedBox(height: 30,),
                  buildIndicator(),
                  SizedBox(height: 30,),
                  Container(
                    height: 400,
                    child: SingleChildScrollView(
                      child: Column(
                        children: const [
                          Text(
                            "The earliest known Egyptian pyramids are found at Saqqara, northwest of Memphis, although at least one step-pyramid-like structure has been found at Saqqara, dating to the First Dynasty: Mastaba 3808, which has been attributed to the reign of Pharaoh Anedjib, with inscriptions, and other archaeological remains of the period, suggesting there may have been others. [6] The otherwise earliest among these is the Pyramid of Djoser built c. 2630-2610 BCE during the Third Dynasty.[7] This pyramid and its surrounding complex are generally considered to be the world's oldest monumental structures constructed of dressed masonry",
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),


            ],
          ),
        ),
      ) ,
    );
  }

  Widget buildImage(String imagePath, int index) =>
      Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Image.asset(imagePath),
      );
  
  Widget buildIndicator() => AnimatedSmoothIndicator(activeIndex:
  activeIndex, count: imagesPath.length,effect: ExpandingDotsEffect(
    activeDotColor: Color(0xffffb319),
  ),);
}
