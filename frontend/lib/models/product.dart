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
      img:
          'https://outofhome.se/media/catalog/product/cache/30/image/17f82f742ffe127f42dca9de82fb58b1/2/5/25003_ramlosa_citrus_burk.jpg',
      name: 'Vatten',
      priceOld: '100 kr',
      priceNew: '10 kr',
      amount: 0,
      category: 'Annat'),
  ProductItem(
      img:
          'https://scontent-cph2-1.xx.fbcdn.net/v/t39.30808-6/415123805_847106780758079_7732937193029023278_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=5f2048&_nc_ohc=EkFiAMxHXyQQ7kNvgG2Xpp_&_nc_ht=scontent-cph2-1.xx&oh=00_AfAmF8kcbcIQYZvMKNkk7JMxkmU-VqvsGwvr0ZaUaP-wlw&oe=664037C4',
      name: 'Saft',
      priceOld: '100 kr',
      priceNew: '10 kr',
      amount: 0,
      category: 'Annat'),
  ProductItem(
      img:
          'https://images.squarespace-cdn.com/content/v1/5eb1211225719420f0c80392/e1341689-c72e-49ab-a324-8375d4d4b0db/lillebrors-bageri-kardemummabulle',
      name: 'Bullar',
      priceOld: '100 kr',
      priceNew: '10 kr',
      amount: 0,
      category: 'Bröd'),
  ProductItem(
      img:
          'https://scontent-cph2-1.xx.fbcdn.net/v/t39.30808-6/415123805_847106780758079_7732937193029023278_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=5f2048&_nc_ohc=EkFiAMxHXyQQ7kNvgG2Xpp_&_nc_ht=scontent-cph2-1.xx&oh=00_AfAmF8kcbcIQYZvMKNkk7JMxkmU-VqvsGwvr0ZaUaP-wlw&oe=664037C4',
      name: 'Kakor',
      priceOld: '100 kr',
      priceNew: '10 kr',
      amount: 0,
      category: 'Konditori'),
];
