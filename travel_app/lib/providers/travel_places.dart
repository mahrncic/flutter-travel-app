import 'package:flutter/cupertino.dart';
import 'package:flutter_complete_guide/models/place.dart';

class TravelPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }
}
