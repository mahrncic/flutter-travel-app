import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/travel_places.dart';
import 'package:flutter_complete_guide/screens/add_place_screen.dart';
import 'package:flutter_complete_guide/screens/place_detail_screen.dart';
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
      body: FutureBuilder(
        future: Provider.of<TravelPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: const CircularProgressIndicator(),
              )
            : Consumer<TravelPlaces>(
                child: const Center(
                  child: const Text(
                    'Got no places yet, start adding some!',
                  ),
                ),
                builder: (ctx, travelPlaces, child) =>
                    travelPlaces.items.length <= 0
                        ? child
                        : ListView.builder(
                            itemBuilder: (ctx, i) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    FileImage(travelPlaces.items[i].image),
                              ),
                              title: Text(travelPlaces.items[i].title),
                              subtitle:
                                  Text(travelPlaces.items[i].location.address),
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    PlaceDetailScreen.routeName,
                                    arguments: travelPlaces.items[i].id);
                              },
                            ),
                            itemCount: travelPlaces.items.length,
                          ),
              ),
      ),
    );
  }
}
