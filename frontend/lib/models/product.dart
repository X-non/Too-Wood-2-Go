class ProductItem {
  final String img;
  final String name;
  final int priceOld;
  final int priceNew;
  int inCart;
  final String category;
  final int id;
  int amount;

  ProductItem({
    required this.img,
    required this.name,
    required this.priceOld,
    required this.priceNew,
    required this.inCart,
    required this.category,
    required this.id,
    required this.amount,
  });

  static fromJson(json) {
    return ProductItem(
      img: json["thumbnail"] ??
          "https://t4.ftcdn.net/jpg/04/70/29/97/360_F_470299797_UD0eoVMMSUbHCcNJCdv2t8B2g1GVqYgs.jpg",
      name: json["title"] ?? "Varan saknar namn",
      priceOld: json["old_price"],
      priceNew: json["new_price"],
      amount: json["amount"],
      category: json["category"] ?? "Annat",
      id: json["id"],
      inCart: 0,
    );
  }
}
