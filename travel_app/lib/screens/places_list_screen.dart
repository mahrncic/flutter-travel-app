import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/travel_places.dart';
import 'package:flutter_complete_guide/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                AddPlaceScreen.routeName,
              );
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Consumer<TravelPlaces>(
        child: const Center(
          child: const Text(
            'Got no places yet, start adding some!',
          ),
        ),
        builder: (ctx, travelPlaces, child) => travelPlaces.items.length <= 0
            ? child
            : ListView.builder(
                itemBuilder: (ctx, i) => ListTile(
                  leading: CircleAvatar(
                    backgroundImage: FileImage(travelPlaces.items[i].image),
                  ),
                  title: Text(travelPlaces.items[i].title),
                  onTap: () {
                    // Go to detail page
                  },
                ),
                itemCount: travelPlaces.items.length,
              ),
      ),
    );
  }
}
