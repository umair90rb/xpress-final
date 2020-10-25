import '../helpers/custom_trace.dart';
import '../models/category.dart';
import '../models/option.dart';
import '../models/option_group.dart';
import '../models/media.dart';
import '../models/nutrition.dart';
import '../models/store.dart';
import '../models/review.dart';

class Product {
  String id;
  String name;
  double price;
  double discountPrice;
  Media image;
  String description;
  String ingredients;
  String weight;
  String unit;
  String packageItemsCount;
  bool featured;
  bool deliverable;
  Store store;
  Category category;
  List<Option> options;
  List<OptionGroup> optionGroups;
  List<Review> productReviews;
  List<Nutrition> nutritions;

  Product();

  Product.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      name = jsonMap['name'];
      price = jsonMap['price'] != null ? jsonMap['price'].toDouble() : 0.0;
      discountPrice = jsonMap['discount_price'] != null ? jsonMap['discount_price'].toDouble() : 0.0;
      price = discountPrice != 0 ? discountPrice : price;
      discountPrice = discountPrice == 0 ? discountPrice : jsonMap['price'] != null ? jsonMap['price'].toDouble() : 0.0;
      description = jsonMap['description'];
      ingredients = jsonMap['ingredients'];
      weight = jsonMap['weight'] != null ? jsonMap['weight'].toString() : '';
      unit = jsonMap['unit'].toString();
      packageItemsCount = jsonMap['package_items_count'].toString();
      featured = jsonMap['featured'] ?? false;
      deliverable = jsonMap['deliverable'] ?? false;
      store = jsonMap['store'] != null ? Store.fromJSON(jsonMap['store']) : new Store();
      category = jsonMap['category'] != null ? Category.fromJSON(jsonMap['category']) : new Category();
      image = jsonMap['media'] != null && (jsonMap['media'] as List).length > 0 ? Media.fromJSON(jsonMap['media'][0]) : new Media();
      options = jsonMap['options'] != null && (jsonMap['options'] as List).length > 0
          ? List.from(jsonMap['options']).map((element) => Option.fromJSON(element)).toSet().toList()
          : [];
      optionGroups = jsonMap['option_groups'] != null && (jsonMap['option_groups'] as List).length > 0
          ? List.from(jsonMap['option_groups']).map((element) => OptionGroup.fromJSON(element)).toSet().toList()
          : [];
      productReviews = jsonMap['product_reviews'] != null && (jsonMap['product_reviews'] as List).length > 0
          ? List.from(jsonMap['product_reviews']).map((element) => Review.fromJSON(element)).toSet().toList()
          : [];
      nutritions = jsonMap['nutrition'] != null && (jsonMap['nutrition'] as List).length > 0
          ? List.from(jsonMap['nutrition']).map((element) => Nutrition.fromJSON(element)).toSet().toList()
          : [];
    } catch (e) {
      id = '';
      name = '';
      price = 0.0;
      discountPrice = 0.0;
      description = '';
      weight = '';
      ingredients = '';
      unit = '';
      packageItemsCount = '';
      featured = false;
      deliverable = false;
      store = new Store();
      category = new Category();
      image = new Media();
      options = [];
      optionGroups = [];
      productReviews = [];
      nutritions = [];
      print(CustomTrace(StackTrace.current, message: e));
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["name"] = name;
    map["price"] = price;
    map["discountPrice"] = discountPrice;
    map["description"] = description;
    map["ingredients"] = ingredients;
    map["weight"] = weight;
    return map;
  }

  @override
  bool operator ==(dynamic other) {
    return other.id == this.id;
  }

  @override
  int get hashCode => this.id.hashCode;
}
