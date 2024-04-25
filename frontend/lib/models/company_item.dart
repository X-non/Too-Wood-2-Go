class CompanyItem {
  final String img;
  final String icon;
  final String title;
  final String description;
  final String address;
  final String openHours;
  bool favorite;
  bool pickup;
  // int id...

  CompanyItem(
      {required this.img,
      required this.icon,
      required this.favorite,
      required this.description,
      required this.title,
      required this.openHours,
      required this.address,
      required this.pickup});

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
            pickup: false));
  }
}
