class ProductItem {
  final String img;
  final String name;
  final String priceOld;
  final String priceNew;
  int amount;
  final String category;
  // int id...

  ProductItem(
      {required this.img,
      required this.name,
      required this.priceOld,
      required this.priceNew,
      required this.amount,
      required this.category});
}

final List<ProductItem> productItems = [
  ProductItem(
      img: 'assets/image/Gateau1.jpg',
      name: 'Vatten',
      priceOld: '100 kr',
      priceNew: '10 kr',
      amount: 0,
      category: 'Annat'),
  ProductItem(
      img: 'assets/image/Gateau1.jpg',
      name: 'Saft',
      priceOld: '100 kr',
      priceNew: '10 kr',
      amount: 0,
      category: 'Annat'),
  ProductItem(
      img: 'assets/image/Gateau1.jpg',
      name: 'Bullar',
      priceOld: '100 kr',
      priceNew: '10 kr',
      amount: 0,
      category: 'Bröd'),
  ProductItem(
      img: 'assets/image/Gateau1.jpg',
      name: 'Kakor',
      priceOld: '100 kr',
      priceNew: '10 kr',
      amount: 0,
      category: 'Konditori'),
];
