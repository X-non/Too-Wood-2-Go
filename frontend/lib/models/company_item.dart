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

  bool containsInList(List<CompanyItem> list) {
    for (var element in list) {
      if (element.storeId == storeId) return true;
    }
    return false;
  }

  static fromJson(json) {
    return CompanyItem(
        img: json["banner_image"] ??
            'https://cdn.shopify.com/s/files/1/2713/9702/collections/2048x550_GateauFI_banner_konditoria.jpg?v=1682082466',
        icon: json["thumbnail"] ??
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQoFWLS1Nq3gwC-3IgB3LkJBK-pG9X_NnIb6tmJOrtxRQ&s',
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
