import 'package:eatwise/constants/ew_styles.dart';
import 'package:flutter/material.dart';
import 'package:eatwise/pages/home_page.dart';
import 'package:eatwise/pages/favorites_page.dart';
import 'package:eatwise/pages/shoppingcart_page.dart';
import 'package:eatwise/pages/map_page.dart';
import 'package:eatwise/pages/profile_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MaterialYou(),
    );
  }
}

class MaterialYou extends StatefulWidget {
  const MaterialYou({super.key});

  @override
  State<MaterialYou> createState() => _MaterialYouState();
}

class _MaterialYouState extends State<MaterialYou> {
  int _currentIndex = 0;
  final List<Widget> pages = const [
    HomePage(),
    FavoritesPage(),
    ShoppingCartPage(),
    MapPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(219, 216, 208, 86),
            Colors.white,
            Colors.white,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text(
            'Eatwise',
            style: EWTextStyles.titleBold,
          ),
          backgroundColor: Colors.transparent,
        ),
        body: Center(
          child: pages[_currentIndex],
        ),
        bottomNavigationBar: NavigationBar(
          indicatorColor: const Color.fromRGBO(127, 143, 110, 56),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          selectedIndex: _currentIndex,
          onDestinationSelected: (int newIndex) {
            setState(() {
              _currentIndex = newIndex;
            });
          },
          destinations: const [
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Hem',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.favorite),
              icon: Icon(Icons.favorite_border_outlined),
              label: 'Favoriter',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.shopping_basket),
              icon: Icon(Icons.shopping_basket_outlined),
              label: 'Kundkorg',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.map),
              icon: Icon(Icons.map_outlined),
              label: 'Karta',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.person),
              icon: Icon(Icons.person_outlined),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}
