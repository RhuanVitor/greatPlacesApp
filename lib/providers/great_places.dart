import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/models/place.dart';
import 'package:great_places/utils/db_utils.dart';
import 'package:great_places/utils/location_util.dart';

class GreatPlaces with ChangeNotifier{
  List<Place> _items = [];

  Future<void> loadPlaces() async{
    final dataList = await DbUtils.getData('places');
    _items = dataList.map(
      (item) => Place(
        id: item['id'].toString(), 
        title: item['title'].toString(), 
        location: PlaceLocation(
          latitude: item['latitude'] as double, 
          longitude: item['longitude'] as double,
          address: item['address'] as String
        ), 
        image: File(item['image'].toString()), 
        pickDateTime: DateTime.now()
      )
    ).toList();
    debugPrint(_items.toString());
    notifyListeners();
  }

  List<Place> get items => [..._items];

  int get itemsCount => _items.length;

  Place itemByIndex(index) => _items[index];

  Future<void> addPlace(String title, File image, LatLng position) async {
    String adress = await LocationUtil.getAdressFrom(position);

    final newPlace = Place(
      id: Random().nextInt(99999).toString(), 
      title: title, 
      location: PlaceLocation(
        latitude: position.latitude, 
        longitude: position.longitude,
        address: adress
      ), 
      image: image,
      pickDateTime: DateTime.now(),
    );

    _items.add(newPlace);
    DbUtils.insert(
      'places', {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image!.path,
        'latitude': position.latitude,
        'longitude': position.longitude,
        'address': adress
      }
    );
    notifyListeners();
  }

  Future<void> deletePlace(placeId) async{
    DbUtils.delete('places', placeId);
    _items.removeWhere((item) => item.id == placeId);
    notifyListeners();
  }
}