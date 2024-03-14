import 'package:flutter/material.dart';
import '../constants.dart';
import '../services/watch_list_service.dart'; 
import 'dart:convert'; 

class moviesSlider extends StatelessWidget {
  final AsyncSnapshot snapshot;
  const moviesSlider({
    super.key, required this.snapshot,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: snapshot.data.length,
        itemBuilder: (context, itemIndex) {
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  '${Constants.imagePath}${movie.posterPath}',
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
