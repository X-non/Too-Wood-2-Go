class ProductItem {
  final String img;
  final String name;
  final String priceOld;
  final String priceNew;
  int amount;
  // string category...
  // int id...

  ProductItem(
      {required this.img,
      required this.name,
      required this.priceOld,
      required this.priceNew,
      required this.amount});
}
