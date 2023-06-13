import 'package:flutter/material.dart';
import 'package:restaurant_read_local_data_json/data.dart';


class ListRestaurant extends StatelessWidget {
  const ListRestaurant({Key? key, required this.restaurant}) : super(key: key);
  final Restaurant restaurant;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'detail', arguments: restaurant);
      },
      child: Card(
        child: Column(
          children: [
            Image.network(
              restaurant.pictureId ?? '', // Menggunakan URL gambar dari properti pictureId
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
            ),
            SizedBox(height: 8),
            Text(
              restaurant.name ?? '',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              restaurant.city ?? '',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Rating: ${restaurant.rating != null ? restaurant.rating.toString() : "N/A"}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 8),
            Divider(
              height: 4,
              color: Colors.black,
            ),
            Container(
              padding: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.add_shopping_cart,
                    size: 20,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Text(
                    "Beli",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Icon(
                    Icons.remove_circle_outline,
                    size: 18,
                    color: Colors.black,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      '0',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Icon(
                    Icons.add_circle_outline,
                    size: 18,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

