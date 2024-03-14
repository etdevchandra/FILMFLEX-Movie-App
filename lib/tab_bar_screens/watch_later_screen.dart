import 'package:flutter/material.dart';
import 'package:filmflex_movie_application/widgets/watch_list_item.dart';
import 'package:filmflex_movie_application/services/watch_list_service.dart';
import 'package:filmflex_movie_application/constants.dart'; 
import 'dart:convert'; 

class WatchLaterScreen extends StatefulWidget {
  const WatchLaterScreen({Key? key}) : super(key: key);

  @override
  State<WatchLaterScreen> createState() => _WatchLaterScreenState();
}

class _WatchLaterScreenState extends State<WatchLaterScreen> {
  bool _isSortedAlphabetically = false;

  void _toggleSort() {
    setState(() {
      _isSortedAlphabetically = !_isSortedAlphabetically;
    });
  }

  List<dynamic> _sortItemsAlphabetically(List<dynamic> items) {
    if (_isSortedAlphabetically) {
      items.sort((a, b) {
        String titleA = a['title'] ?? a['name'] ?? ''; 
        String titleB = b['title'] ?? b['name'] ?? ''; 
        return titleA.compareTo(titleB);
      });
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('TV Shows & Movies', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(_isSortedAlphabetically ? Icons.sort_by_alpha : Icons.sort),
            onPressed: _toggleSort,
            tooltip: 'Sort Alphabetically',
          ),
        ],
      ),
      body: FutureBuilder(
        future: WatchListService.getWatchList(),
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Your watch list is empty."));
          }
          List<dynamic> items = snapshot.data!.map((item) => jsonDecode(item)).toList();

          items = _sortItemsAlphabetically(items);

          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.5,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              Map<String, dynamic> itemData = items[index];
              String posterUrl = itemData['poster_path'] != null ? '${Constants.imagePath}${itemData['poster_path']}' : 'No Image Available';

              return WatchListItem(
                item: itemData,
                posterUrl: posterUrl,
                onItemRemoved: () => setState(() {}),
              );
            },
            physics: const BouncingScrollPhysics(),
          );
        },
      ),
    );
  }
}
