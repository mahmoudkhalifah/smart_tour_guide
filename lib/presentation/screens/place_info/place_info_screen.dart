// ignore_for_file: prefer_const_constructors

import 'package:app/data/models/place.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PlaceInfoScreen extends StatefulWidget {
  final Place place;

  const PlaceInfoScreen({Key? key, required this.place}) : super(key: key);
  @override
  State<PlaceInfoScreen> createState() => _PlaceInfoScreenState();
}

class _PlaceInfoScreenState extends State<PlaceInfoScreen> {
  int activeIndex = 0;
  bool isFavourite = false;
  bool isVisited = false;
  late List imagesPath;

  @override
  void initState() {
    imagesPath = widget.place.images;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(widget.place.name),
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.only(
            start: 40.0, top: 10, end: 40, bottom: 10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.place.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(100, 115, 107, 1),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isVisited = !isVisited;
                    });
                  },
                  icon: Icon(
                    Icons.add_task_outlined,
                    color: isVisited ? Colors.orange : Colors.black,
                  ),
                  iconSize: 24,
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isFavourite = !isFavourite;
                    });
                  },
                  icon: Icon(
                    Icons.favorite_rounded,
                    color: isFavourite ? Colors.red : Colors.grey,
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
                  widget.place.description,
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
      child: FadeInImage.assetNetwork(
        placeholder: "assets/images/loading.gif",
        image: imagePath,
        width: double.infinity,
        fit: BoxFit.cover,
      ));

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: imagesPath.length,
        effect: ExpandingDotsEffect(
          activeDotColor: Color(0xffffb319),
        ),
      );
}
