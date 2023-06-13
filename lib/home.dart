import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:restaurant_read_local_data_json/data.dart';
import 'package:restaurant_read_local_data_json/navMenu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<dynamic> allData = [];

  Future<void> readJson() async {
    final String response = await DefaultAssetBundle.of(context)
        .loadString('assets/restourant.json');
    final data = await json.decode(response);

    setState(() {
      // final model = RestaurantModel.fromJson(data);
      // allData = model.restaurants ?? [];
      allData = data['restaurants'].map((data) {
        var restaurant = Restaurant.fromJson(data);
        restaurant.id = data['id']; // Menambahkan parsing properti "id"
        return restaurant;
      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F7E5),
      drawer: MenuNavbar() ,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Color(0xFF0E8042),
        title: const Text(
          'Kuliner Nusantara',
          style: TextStyle(color: Color(0xFF212121)),
        ),
        actions: <Widget>[
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.search),
                color: const Color(0xFF212121),
                onPressed: () {},
              ),
              Stack(
                children: [
                  IconButton(
                    onPressed: (() {}),
                    icon: const Icon(
                      Icons.shopping_cart,
                      color: Color(0xFF212121),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 3,
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                      child: const Center(
                        child: Text(
                          "2",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: allData.length,
          itemBuilder: (context, index) {
            final restaurant = allData[index];
            return ListRestaurant(restaurant: restaurant);
          },
        ),
      ),,
    );
  }
}