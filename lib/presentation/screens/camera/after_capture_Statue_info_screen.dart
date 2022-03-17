// ignore-for-file: prefer_const_constructors










import 'dart:io';

import 'package:app/presentation/screens/statue_info/voice_player.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:app/presentation/screens/camera/after_capture_Statue_info_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AfterCaptureStatueInfoScreen extends StatefulWidget {
  final File imageFile;
  final List<File> fileList;
  final info;

  const AfterCaptureStatueInfoScreen({
    required this.imageFile,
    required this.fileList,
    required this.info,
  });

  @override
  State<AfterCaptureStatueInfoScreen> createState() => _AfterCaptureStatueInfoScreenState();
}

class _AfterCaptureStatueInfoScreenState extends State<AfterCaptureStatueInfoScreen> {
  int activeIndex = 0;

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
        title: Text(widget.info["name"]),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.only(
            start: 40.0, top: 10, end: 40, bottom: 10),
        child: Column(
          children: [
            // Expanded(
            //   child: Image.file(widget.imageFile),
            // ),
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
            VoicePlayer()
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








