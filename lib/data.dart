

class RestaurantModel {
  List<Restaurant>? restaurants;
  List<String> foodNames;
  final List<String> drinkNames;

  RestaurantModel({
    this.restaurants,
    required this.foodNames,
    required this.drinkNames,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    final restaurantList = json['restaurants'] as List<dynamic>?;
    final restaurants = restaurantList
        ?.map((restaurant) => Restaurant.fromJson(restaurant))
        .toList();
    final foodNames = (json['menus']['foods'] as List)
        .map((food) => food['name'] as String)
        .toList();
    final drinkNames = (json['menus']['drinks'] as List)
        .map((drink) => drink['name'] as String)
        .toList();

    return RestaurantModel(
      restaurants: restaurants,
      foodNames: foodNames,
      drinkNames: drinkNames,
    );
  }
}

class Restaurant {
  String? id;
  String? name;
  String? description;
  String? pictureId;
  String? city;
  double? rating;
  Menus? menus;

  Restaurant({
    this.id,
    this.name,
    this.description,
    this.pictureId,
    this.city,
    this.rating,
    this.menus,
  });

  factory Restaurant.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      // Mengembalikan objek Restaurant default atau mengatasi kasus null dengan sesuai
      return Restaurant();
    }

    return Restaurant(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      pictureId: json['pictureId'] as String?,
      city: json['city'] as String?,
      rating: json['rating']?.toDouble(),
      menus: Menus.fromJson(json['menus'] as Map<String, dynamic>?),
    );
  }
}

class Menus {
  List<Drink>? foods;
  List<Drink>? drinks;

  Menus({
    this.foods,
    this.drinks,
  });

  factory Menus.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      // Mengembalikan objek Menus default atau mengatasi kasus null dengan sesuai
      return Menus();
    }

    final foodsData = json['foods'] as List<dynamic>?;
    final drinksData = json['drinks'] as List<dynamic>?;

    final foods = foodsData?.map((food) => Drink.fromJson(food as Map<String, dynamic>?)).toList() ?? [];
    final drinks = drinksData?.map((drink) => Drink.fromJson(drink as Map<String, dynamic>?)).toList() ?? [];

    return Menus(
      foods: foods,
      drinks: drinks,
    );
  }
}

class Drink {
  String? name;

  Drink({
    this.name,
  });

  factory Drink.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      // Mengembalikan objek Drink default atau mengatasi kasus null dengan sesuai
      return Drink();
    }

    return Drink(
      name: json['name'] as String?,
    );
  }
}
