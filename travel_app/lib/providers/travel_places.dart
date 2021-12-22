import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_complete_guide/helpers/db_helper.dart';
import 'package:flutter_complete_guide/models/place.dart';

class TravelPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String selectedTitle, File selectedImage) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: selectedImage,
      title: selectedTitle,
      location: null,
    );

    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert(
      'places',
      {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image.path,
      },
    );
  }
}
