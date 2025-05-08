import 'dart:io';

class Place {
  late final String id;
  late final String title;
  late final PlaceLocation? location;
  late File? image;
  late DateTime pickDateTime;

  Place({
    required this.id,
    required this.title,
    required this.location,
    required this.image,
    required this.pickDateTime,
  });
}

class PlaceLocation{
  late final double latitude;
  late final double longitude;
  late final String address;

  PlaceLocation({
    required this.latitude,
    required this.longitude,
    this.address = ''
  });
}