// ignore_for_file: prefer_const_constructors

import 'package:app/data/models/statue.dart';
import 'package:app/presentation/screens/statue_info/voice_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class StatueInfoScreen extends StatefulWidget {
  final Statue statue;

  const StatueInfoScreen({Key? key, required this.statue}) : super(key: key);
  @override
  State<StatueInfoScreen> createState() => _StatueInfoScreenState();
}

class _StatueInfoScreenState extends State<StatueInfoScreen> {
  int activeIndex = 0;
  late List imagesPath;
  bool isFavourite = false;
  @override
  void initState() {
    imagesPath = widget.statue.images;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.only(
            start: 40.0, top: 10, end: 40, bottom: 10),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Expanded(
                child: Text(
                  Localizations.localeOf(context).languageCode == "en"
                      ? widget.statue.name
                      : widget.statue.arabicName,
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
                    isFavourite = !isFavourite;
                  });
                },
                icon: Icon(
                  Icons.favorite_rounded,
                  color: isFavourite ? Colors.red : Colors.grey,
                ),
              )
            ]),
            Hero(
              tag: widget.statue.id,
              child: CarouselSlider.builder(
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
                  Localizations.localeOf(context).languageCode == "en"
                      ? widget.statue.description
                      : widget.statue.arabicDescription,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            VoicePlayer(
              url: Localizations.localeOf(context).languageCode == "en"
                  ? widget.statue.voiceOver
                  : widget.statue.arabicVoiceOver,
            )
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
      child: CachedNetworkImage(
        imageUrl: imagePath,
        placeholder: (context, url) => Center(
          child: CircularProgressIndicator(),
        ),
        width: 308,
        height: 163,
        fit: BoxFit.cover,
        errorWidget: (context, url, error) => Icon(
          Icons.error,
          color: Colors.red,
        ),
      )

      );

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: imagesPath.length,
        effect: ExpandingDotsEffect(
          activeDotColor: Color(0xffffb319),
        ),
      );
}
