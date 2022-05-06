class Item {
  final int id;
  final String name;
  final String desc;
  final int price;

  Item(
      {required this.id,
      required this.name,
      required this.desc,
      required this.price});

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
        id: map["id"],
        name: map["name"],
        desc: map["desc"],
        price: map["price"]);
  }
}

class Modal {
  static List<Item> items = [];
}
