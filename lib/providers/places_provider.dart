import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:iwanna_go/database/localDB.dart';
import 'package:iwanna_go/models/Place.dart';

class PlacesProvider with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Future<void> loadPlaces() async {
    final datalist = await LocalDB.getAllData('places');

    _items = datalist.map((item) {
      print({'load_place_item_from_db': item});

      return Place(
        id: item['id'].toString(),
        file: File(item['image'].toString()),
        title: item['title'].toString(),
      );
    }).toList();

    notifyListeners();
  }

  int get itemsCount {
    return _items.length;
  }

  Place getItemByIndex(int index) {
    return _items[index];
  }

  void addPlace(String title, File image) {
    final newPlace = Place(
      id: Random().nextDouble().toString(),
      file: image,
      title: title,
    );

    _items.add(newPlace);

    print({'add_new_place': newPlace.id});

    LocalDB.insert('places', {
      'id': newPlace.id,
      'image': newPlace.file.path,
      'title': newPlace.title,
    });

    notifyListeners();
  }
}
