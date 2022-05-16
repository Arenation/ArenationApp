import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:arenation_app/models/arenas/modelArena.dart';
import 'package:arenation_app/utils/custom_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:arenation_app/widgets/skeletons.dart';

Widget arenaCarousel(BuildContext context, Arenas arena) {
  return CarouselSlider(
    items: imageSliders(arena.images),
    options: CarouselOptions(
        autoPlay: false, aspectRatio: 2.0, enlargeCenterPage: true),
  );
}

List<Widget> imageSliders(List<String> imgList) {
  return imgList
      .map((item) => Container(
            margin: const EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                child: Stack(
                  children: <Widget>[
                    // Image.network(item, fit: BoxFit.cover, width: 1000.0),
                    CachedNetworkImage(
                      placeholder: ((context, url) =>
                          arenaImageSkeleton(170.0)),
                      imageUrl: item,
                      imageBuilder: (context, imageProvider) => Container(
                        width: double.infinity,
                        height: 170,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                          color: CustomColors.primary100,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ],
                )),
          ))
      .toList();
  ;
}
