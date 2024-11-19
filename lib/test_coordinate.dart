import 'package:flutter/material.dart';

class CoordinatesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> coordinates;

  CoordinatesScreen({required this.coordinates});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Coordinates"),
      ),
      body: ListView.builder(
        itemCount: coordinates.length,
        itemBuilder: (context, index) {
          final coord = coordinates[index];
          return Card(
            child: ListTile(
              title:
                  Text("Lat: ${coord['latitude']}, Lng: ${coord['longitude']}"),
              subtitle: Text("Distance: ${coord['distance']} m"),
            ),
          );
        },
      ),
    );
  }
}
