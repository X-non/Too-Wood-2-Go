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
        img: json["thumbnail"] ??
            "https://scontent-cph2-1.xx.fbcdn.net/v/t39.30808-6/415123805_847106780758079_7732937193029023278_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=5f2048&_nc_ohc=EkFiAMxHXyQQ7kNvgG2Xpp_&_nc_ht=scontent-cph2-1.xx&oh=00_AfAmF8kcbcIQYZvMKNkk7JMxkmU-VqvsGwvr0ZaUaP-wlw&oe=664037C4",
        name: json["title"] ?? "Varan saknar namn",
        priceOld: json["old_price"],
        priceNew: json["new_price"],
        avaliable: json["amount"],
        category: json["category"] ?? "Annat",
        id: json["id"],
        amount: 0);
  }
}
