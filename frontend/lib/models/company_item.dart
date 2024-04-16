class CompanyItem {
  final String img;
  final String title;
  final String description;
  final String address;
  final String openHours;
  bool favorite;
  // String imgIcon...
  // int id...

  CompanyItem(
      {required this.img,
      required this.favorite,
      required this.description,
      required this.title,
      required this.openHours,
      required this.address});

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
            favorite: false,
            description: companyDescription[index],
            title: companyNames[index],
            address: 'Östra Ågatan 31, 753 22 Uppsala',
            openHours: '09:00 - 18:00'));
  }
}
