import 'dart:io';

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String? address;

  PlaceLocation({
    required this.latitude,
    required this.longitude,
    this.address,
  });
}

class Place {
  final String id;
  final String title;
  final PlaceLocation? location;
  final File file;

  Place({
    required this.id,
    required this.file,
    required this.title,
    this.location,
  });
}
