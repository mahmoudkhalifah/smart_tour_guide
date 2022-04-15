// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PlaceInfoScreen extends StatefulWidget {
  final Map info;
  final String title;

  const PlaceInfoScreen({Key? key, required this.info,required this.title}) : super(key: key);
  @override
  State<PlaceInfoScreen> createState() => _PlaceInfoScreenState();
}

class _PlaceInfoScreenState extends State<PlaceInfoScreen> {
  int activeIndex = 0;
  bool favouriteClicked = false;
  bool visitedClicked = false;
  late List imagesPath;

  @override
  void initState() {
    imagesPath = widget.info["photosURL"];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.only(
            start: 40.0, top: 10, end: 40, bottom: 10),
        child: Column(
          children: [
            Row(
              children: [
                Spacer(),
                IconButton(
                  onPressed: () {
                    setState(() {
                      visitedClicked = !visitedClicked;
                    });
                  },
                  icon: Icon(
                    Icons.add_task_outlined,
                    color: visitedClicked ? Colors.orange : Colors.black,
                  ),
                  iconSize: 24,
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      favouriteClicked = !favouriteClicked;
                    });
                  },
                  icon: Icon(
                    Icons.favorite_rounded,
                    color: favouriteClicked ? Colors.red : Colors.grey,
                  ),
                  iconSize: 24,
                ),
              ],
            ),
            SizedBox(height: 20),
            CarouselSlider.builder(
              options: CarouselOptions(
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
                onPageChanged: (index, reason) =>
                    setState(() => activeIndex = index),
              ),
              itemCount: (imagesPath.length),
              itemBuilder: (context, index, realIndex) {
                final imagePath = imagesPath[index];
                return buildImage(imagePath, index);
              },
            ),
            SizedBox(
              height: 30,
            ),
            buildIndicator(),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  widget.info["description"],
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImage(String imagePath, int index) => Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Image.network(
          imagePath,
          fit: BoxFit.cover,
          width: 300,
        ),
      );

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: imagesPath.length,
        effect: ExpandingDotsEffect(
          activeDotColor: Color(0xffffb319),
        ),
      );
}
