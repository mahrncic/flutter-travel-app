import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_complete_guide/helpers/db_helper.dart';
import 'package:flutter_complete_guide/helpers/location_helper.dart';
import 'package:flutter_complete_guide/models/place.dart';
import 'package:flutter_complete_guide/models/place_location.dart';

class TravelPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place findById(String id) {
    return _items.firstWhere((place) => place.id == id);
  }

  Future<void> addPlace(String selectedTitle, File selectedImage,
      PlaceLocation selectedLocation) async {
    final address = await LocationHelper.getPlaceAddress(
        selectedLocation.latitude, selectedLocation.longitude);
    final updatedLocation = PlaceLocation(
      latitude: selectedLocation.latitude,
      longitude: selectedLocation.longitude,
      address: address,
    );

    final newPlace = Place(
      id: DateTime.now().toString(),
      image: selectedImage,
      title: selectedTitle,
      location: updatedLocation,
    );

    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert(
      'places',
      {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image.path,
        'loc_lat': newPlace.location.latitude,
        'loc_lng': newPlace.location.longitude,
        'address': newPlace.location.address,
      },
    );
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('places');
    _items = dataList
        .map((place) => Place(
              id: place['id'],
              title: place['title'],
              image: File(place['image']),
              location: PlaceLocation(
                latitude: place['loc_lat'],
                longitude: place['loc_lng'],
                address: place['address'],
              ),
            ))
        .toList();
    notifyListeners();
  }
}
