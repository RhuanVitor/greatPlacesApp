import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:great_places/models/place.dart';
import 'package:great_places/utils/db_utils.dart';

class GreatPlaces with ChangeNotifier{
  List<Place> _items = [];

  Future<void> loadPlaces() async{
    final dataList = await DbUtils.getData('places');
    _items = dataList.map(
      (item) => Place(
        id: item['id'].toString(), 
        title: item['title'].toString(), 
        location: null, 
        image: File(item['image'].toString()), 
        pickDateTime: DateTime.now()
      )
    ).toList();
  }

  List<Place> get items => [..._items];

  int get itemsCount => _items.length;

  Place itemByIndex(index) => _items[index];

  void addPlace(String title, File image){
    final newPlace = Place(
      id: Random().nextInt(99999).toString(), 
      title: title, 
      location: null, 
      image: image,
      pickDateTime: DateTime.now()
    );

    _items.add(newPlace);
    DbUtils.insert(
      'places', {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image!.path
      }
    );
    notifyListeners();
  }
}