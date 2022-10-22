// ignore_for_file: prefer_const_constructors

import 'package:app/data/models/place.dart';
import 'package:app/localization/app_localizations.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
        title: Text(
          Localizations.localeOf(context).languageCode == "en"
              ? widget.place.name
              : widget.place.arabicName,
        ),
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
                    Localizations.localeOf(context).languageCode == "en"
                        ? widget.place.name
                        : widget.place.arabicName,
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
            Hero(
              tag: widget.place.id,
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
              height: 15,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    MaterialButton(
                      onPressed: () {
                        widget.place
                            .openLocation(widget.place.lat, widget.place.long);
                      },
                      textColor: Theme.of(context).colorScheme.primary,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.location_on),
                          SizedBox(width: 10),
                          Text(
                            AppLocalizations.of(context)
                                .translate("show on map"),
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      Localizations.localeOf(context).languageCode == "en"
                          ? widget.place.description
                          : widget.place.arabicDescription,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
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
