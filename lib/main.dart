import 'package:flutter/material.dart';
import 'package:restaurant_read_local_data_json/data.dart';
import 'package:restaurant_read_local_data_json/home.dart';
import 'package:restaurant_read_local_data_json/login.dart';
import 'package:restaurant_read_local_data_json/navMenu.dart';
import 'package:restaurant_read_local_data_json/regist.dart';
import 'package:restaurant_read_local_data_json/restaurantDetail.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: Login(), // Set debugShowCheckedModeBanner to false
      initialRoute: '/',
      routes: {
        'daftar': (context) => const MyRegister(),
        'home': (context) => HomePage(),
        'detail': (context) {
          final restaurant =
              ModalRoute.of(context)!.settings.arguments as Restaurant;
          return RestaurantDetail(restaurant: restaurant);
        },
        'menuNavbar': (context) => const MenuNavbar(),
      },
    ),
  );
}
