class AccountItem {
  String username;
  String email;
  String phonenumber;
  String password;

  AccountItem({
    required this.username,
    required this.email,
    required this.phonenumber,
    required this.password,
  });

  static AccountItem mockdata() {
    return AccountItem(
      email: 'cissi@mail.com',
      username: 'cissi123',
      phonenumber: '0701234567',
      password: '1234',
    );
  }
}
