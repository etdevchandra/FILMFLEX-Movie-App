import 'package:flutter/material.dart';
import 'package:filmflex_movie_application/services/watch_list_service.dart';

class WatchListItem extends StatelessWidget {
  final Map<String, dynamic> item;
  final String posterUrl;
  final VoidCallback onItemRemoved; 

  const WatchListItem({
    Key? key,
    required this.item,
    required this.posterUrl,
    required this.onItemRemoved, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      clipBehavior: Clip.antiAlias, 
      child: Column(
        mainAxisSize: MainAxisSize.min, 
        children: [
          Expanded(
            child: Image.network(
              posterUrl,
              fit: BoxFit.cover, 
              errorBuilder: (context, error, stackTrace) {
                return Center(child: Text('Image not available'));
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.delete, color: Colors.white),
            onPressed: () => _showConfirmationDialog(context, item), 
          ),
        ],
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context, Map<String, dynamic> item) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Remove'),
            content: Text('Are you sure you want to remove this item from your watch list?'),
            actions: <Widget>[
              TextButton(
                child: Text('No'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: Text('Yes'),
                onPressed: () async {
                  int itemId = item['id']; 
                  await WatchListService.removeFromWatchList(itemId);
                  Navigator.of(context).pop();
                  onItemRemoved();
                },
              ),
            ],
          );
        },
      );
  }
}
