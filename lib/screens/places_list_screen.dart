import 'package:flutter/material.dart';
import 'package:iwanna_go/providers/places_provider.dart';
import 'package:iwanna_go/routes/app_routes.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Lugares'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.PLACE_FORM);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future:
            Provider.of<PlacesProvider>(context, listen: false).loadPlaces(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          return Consumer<PlacesProvider>(
            builder: (context, places, child) {
              return places.itemsCount == 0
                  ? child!
                  : ListView.builder(
                      itemCount: places.itemsCount,
                      itemBuilder: (context, index) {
                        final place = places.getItemByIndex(index);

                        print(place);

                        return ListTile(
                          leading: CircleAvatar(
                              backgroundImage: FileImage(place.file)),
                          title: Text(place.title),
                          onTap: () {},
                        );
                      },
                    );
            },
            child: Center(
              child: Text('Sem lugares'),
            ),
          );
        },
      ),
    );
  }
}
