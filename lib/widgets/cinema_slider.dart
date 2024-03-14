import 'package:flutter/material.dart'; 
import 'package:carousel_slider/carousel_slider.dart';
import '../constants.dart';
import '../services/watch_list_service.dart'; 
import 'dart:convert'; 

class cinemaSlider extends StatelessWidget {
  final AsyncSnapshot snapshot;
  const cinemaSlider({
    super.key, required this.snapshot,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: snapshot.data.length,
        options: CarouselOptions(
          height: 300,
          autoPlay: true,
          viewportFraction: 0.55,
          enlargeCenterPage: true,
          pageSnapping: true,
          autoPlayCurve: Curves.fastOutSlowIn,
          autoPlayAnimationDuration: const Duration(seconds: 1),
        ),
        itemBuilder: (context, itemIndex, pageViewIndex) {
          var movie = snapshot.data[itemIndex];
          return GestureDetector(
            onTap: () async {
              final bool addToWatchList = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Add to Watch List?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text('No'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: Text('Yes'),
                      ),
                    ],
                  );
                },
              ) ?? false;

              if (addToWatchList) {
                await WatchListService.addToWatchList(jsonEncode(movie.toJson()));
                
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                '${Constants.imagePath}${movie.posterPath}',
                filterQuality: FilterQuality.high,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
