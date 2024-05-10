
class ProductItem {
  final String img;
  final String name;
  final int priceOld;
  final int priceNew;
  int amount;
  final String category;
  final int id;
  int avaliable; 

  ProductItem(
      {required this.img,
      required this.name,
      required this.priceOld,
      required this.priceNew,
      required this.amount,
      required this.category,
      required this.id,
      required this.avaliable});

  static fromJson(json) {
    return ProductItem(
        img: json["thumbnail"] ?? "assets/image/Gateau1.jpg",
        name: json["title"] ?? "Varan saknar namn",
        priceOld: json["old_price"],
        priceNew: json["new_price"],
        avaliable: json["available"],
        category: json["category"] ?? "Annat",
        id: json["id"],
        amount: 0);
  }
}

