import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/travel_places.dart';
import 'package:flutter_complete_guide/screens/add_place_screen.dart';
import 'package:flutter_complete_guide/screens/places_list_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: TravelPlaces(),
      child: MaterialApp(
        title: 'Travel!',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
        ),
        home: PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(),
        },
      ),
    );
  }
}
