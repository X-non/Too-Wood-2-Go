class CompanyItem {
  final String img;
  final String icon;
  final String title;
  final String description;
  final String address;
  final String openHours;
  final String storeId;
  bool favorite;

  CompanyItem(
      {required this.img,
      required this.icon,
      required this.favorite,
      required this.description,
      required this.title,
      required this.openHours,
      required this.address,
      required this.storeId});

  //   "catagory": "supermarket" | "bakery" | ...,
  // "pretty name": "Ica Supermarket Väst",
  // "store_id": "ica-supermarket-vest"
  // "plats": "kordinater",
  // "address": "Exempelvägen 42, Uppsala",
  // "opening_hours": ...,
  // "thumbnail": "assets/bla.png"
  // "banner_image":"assets/big.png"
  // "favorite": bool

  static fromJson(json) {
    return CompanyItem(
        img: json["banner_image"] ?? "assets/image/Gateau1.jpg",
        icon: json["thumbnail"] ?? "assets/image/icon.jpeg",
        favorite: json["favorite"] ?? false,
        description: json["description"] ?? "Här säljs något gott.",
        title: json["pretty_name"],
        openHours: json["open_hours"] ?? "00:00 - 00:00",
        address: json["address"] ?? "Hugingatan 11, 753 08, Uppsala",
        storeId: json["store_id"] ?? "");
  }

  static List<CompanyItem> mockdata() {
    final List<String> companyNames = [
      'UNO',
      'Gateau',
      'Bröd och Salt',
      'Espresso House',
      'ICA',
      'Güntherska',
      'Landings',
      'Centralbageriet',
      'Forsa',
      'Leijon bageri',
    ];

    final List<String> companyDescription = [
      'Bröd och annat',
      'Torra bullar',
      'Gott gott gott',
      'Espresso House',
      'ICA',
      'Güntherska',
      'Landings',
      'Centralbageriet',
      'Forsa',
      'Leijon bageri',
    ];

    return List<CompanyItem>.generate(
        10,
        (index) => CompanyItem(
            img: 'assets/image/Gateau1.jpg',
            icon: 'assets/image/icon.jpeg',
            favorite: false,
            description: companyDescription[index],
            title: companyNames[index],
            address: 'Östra Ågatan 31, 753 22 Uppsala',
            openHours: '09:00 - 18:00',
            storeId: ''));
  }
}
