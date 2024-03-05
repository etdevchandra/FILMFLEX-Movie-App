import 'package:flutter/material.dart'; 

class WatchLaterScreen extends StatefulWidget {
  const WatchLaterScreen({Key? key}) : super(key: key);

  @override
  State<WatchLaterScreen> createState() => _WatchLaterScreenState();
}

class _WatchLaterScreenState extends State<WatchLaterScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black, 
        title: const Text(
          'TV Shows & Movies',
          style: TextStyle(fontWeight: FontWeight.bold), 
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Number of items per row
          childAspectRatio: 0.6, 
          crossAxisSpacing: 8, // Spacing between items horizontally
          mainAxisSpacing: 8, // Spacing between items vertically
        ),
        itemCount: 30, // Placeholder item count
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white, // Placeholder color
              borderRadius: BorderRadius.circular(8),
            ),
          );
        },
        physics: const BouncingScrollPhysics(), // Adding bouncing scroll physics
      ),
    );
  }
}
