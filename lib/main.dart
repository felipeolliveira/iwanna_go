import 'package:flutter/material.dart';
import 'package:iwanna_go/providers/places_provider.dart';
import 'package:iwanna_go/routes/app_routes.dart';
import 'package:iwanna_go/screens/place_form_screen.dart';
import 'package:iwanna_go/screens/places_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _providers = [
    ChangeNotifierProvider(create: (context) => new PlacesProvider()),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: _providers,
      child: MaterialApp(
        title: 'IWannaGo',
        theme: CustomTheme.theme,
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.PLACES_LIST,
        routes: {
          AppRoutes.PLACES_LIST: (context) => PlacesListScreen(),
          AppRoutes.PLACE_FORM: (context) => PlaceFormScreen(),
        },
      ),
    );
  }
}

class CustomTheme {
  static ThemeData get theme {
    return ThemeData(
      primarySwatch: Colors.indigo,
      accentColor: Colors.amber,
      backgroundColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      pageTransitionsTheme: PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }
}
