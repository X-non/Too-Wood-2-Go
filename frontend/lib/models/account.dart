class AccountItem {
  final String username;
  final String email;
  final String phonenumber;

  AccountItem({
    required this.username,
    required this.email,
    required this.phonenumber,
  });

  static List<AccountItem> mockdata() {
    final List<String> usernames = [
      'cissi1',
      'cissi2',
      'cissi3',
    ];

    final List<String> emails = [
      'cissi1@mail.com',
      'cissi2@mail.com',
      'cissi3@mail.com',
    ];

    final List<String> phonenumbers = [
      '1234',
      '5678',
      '3948',
    ];

    return List<AccountItem>.generate(
        10,
        (index) => AccountItem(
              email: emails[index],
              username: usernames[index],
              phonenumber: phonenumbers[index],
            ));
  }
}
