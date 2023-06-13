import 'package:flutter/material.dart';
import 'package:restaurant_read_local_data_json/data.dart';
import 'dart:convert';

import 'package:restaurant_read_local_data_json/listMenuDrinks.dart';
import 'package:restaurant_read_local_data_json/listMenuFoods.dart';


class RestaurantDetail extends StatefulWidget {
  const RestaurantDetail({super.key, required this.restaurant});

  final Restaurant restaurant;

  @override
  State<RestaurantDetail> createState() => _RestaurantDetailState();
}

class LoveButton extends StatefulWidget {
  const LoveButton({Key? key}) : super(key: key);

  @override
  _LoveButton createState() => _LoveButton();
}

class _LoveButton extends State<LoveButton> {
  bool isLove = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isLove ? Icons.favorite : Icons.favorite_border,
        color: Colors.red,
      ),
      onPressed: () {
        setState(() {
          isLove = !isLove;
        });
      },
    );
  }
}

class _RestaurantDetailState extends State<RestaurantDetail> {
  int count = 1;
  late String id;

  late Restaurant restaurant; // Menambahkan deklarasi variabel Produk

  List<dynamic> allData = [];

  Future<void> readJson() async {
    final String response = await DefaultAssetBundle.of(context)
        .loadString('assets/restourant.json');
    final data = await json.decode(response);

    setState(() {
      // final model = RestaurantModel.fromJson(data);
      // allData = model.restaurants ?? [];
      allData =
          data['restaurants'].map((data) => Restaurant.fromJson(data)).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Mengambil argumen produk dari ModalRoute
    restaurant = ModalRoute.of(context)!.settings.arguments as Restaurant;
    id = restaurant.id!; // Menyimpan nilai id
  }

  void addCount() {
    count = count + 1;
    setState(() {});
  }

  void removeCount() {
    if (count != 0) {
      count = count - 1;
      setState(() {});
    }
  }

  Widget buildRatingStars(double rating) {
    int numberOfStars = rating.round();
    List<Widget> stars = List.generate(
      5,
      (index) => Icon(
        index < numberOfStars ? Icons.star : Icons.star_border,
        color: Colors.yellow,
      ),
    );

    return Row(
      children: stars,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0E8042),
        elevation: 1,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF212121),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Detail Restaurant',
          style: TextStyle(color: Colors.black),
        ),
        actions: const [
          LoveButton(),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: [
                Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: restaurant.pictureId ?? '',
                        child: FractionallySizedBox(
                          widthFactor: 1.0,
                          child: AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      NetworkImage(restaurant.pictureId ?? ''),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(15, 18, 15, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              restaurant.name ?? '',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Icon(Icons.location_on),
                                const SizedBox(width: 5),
                                Text(
                                  restaurant.city ?? '',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  'RATING : ',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                const SizedBox(width: 5),
                                buildRatingStars(restaurant.rating ?? 0),
                              ],
                            ),
                            const SizedBox(height: 25),
                            const Text(
                              'Deskripsi',
                              style: TextStyle(
                                color: Color(0xFF212121),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                restaurant.description ?? '',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.justify,
                                maxLines: 5,
                              ),
                            ),
                            const SizedBox(height: 25),
                            const Text(
                              'Menu',
                              style: TextStyle(
                                color: Color(0xFF212121),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 25),
                            Container(
                              child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(Icons.local_bar_outlined),
                                          SizedBox(width: 10),
                                          Text(
                                            'DRINKS',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 7),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          final restaurant = allData[index];
                                          if (restaurant.id == id) {
                                            // Menampilkan makanan berdasarkan ID restoran
                                            return MenuListDrink(
                                                restaurant: restaurant);
                                          }
                                          return SizedBox
                                              .shrink(); // Menyembunyikan widget jika tidak sesuai dengan ID restoran
                                        },
                                        itemCount: allData.length,
                                      ),
                                      SizedBox(height: 20),
                                      Row(
                                        children: [
                                          Icon(Icons.food_bank_outlined),
                                          SizedBox(width: 10),
                                          Text(
                                            'FOODS',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 7),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          final restaurant = allData[index];
                                          if (restaurant.id == id) {
                                            // Menampilkan makanan berdasarkan ID restoran
                                            return MenuListFood(
                                                restaurant: restaurant);
                                          }
                                          return SizedBox
                                              .shrink(); // Menyembunyikan widget jika tidak sesuai dengan ID restoran
                                        },
                                        itemCount: allData.length,
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 70,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              alignment: Alignment.center,
              color: Color(0xFF0E8042),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    flex: 1,
                    child: IconButton(
                      onPressed: removeCount,
                      icon: const Icon(
                        Icons.remove_circle_outline,
                        color: Color(0xFF212121),
                        size: 30,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Text(
                      count.toString(),
                      style: const TextStyle(
                        color: Color(0xFF212121),
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: IconButton(
                      onPressed: addCount,
                      icon: const Icon(
                        Icons.add_circle_outline,
                        color: Color(0xFF212121),
                        size: 30,
                      ),
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                      color: Color(0xFF212121),
                    ),
                    child: const Center(
                      child: Text(
                        "Pesan",
                        style: TextStyle(
                          color: Color(0xFFFFFDE7),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
