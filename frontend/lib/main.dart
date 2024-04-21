import 'package:eatwise/constants/ew_colors.dart';
import 'package:flutter/material.dart';
import 'package:eatwise/pages/login.dart';
import 'package:eatwise/pages/home_page.dart';
import 'package:eatwise/pages/favorites_page.dart';
import 'package:eatwise/pages/shoppingcart_page.dart';
import 'package:eatwise/pages/map_page.dart';
import 'package:eatwise/pages/profile_page.dart';
import 'package:flutter_config/flutter_config.dart';

Future<void> main() async {
 WidgetsFlutterBinding.ensureInitialized();
await FlutterConfig.loadEnvVariables();
runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
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
    Login(),
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
            EWColors.beige,
            EWColors.beige,
            Colors.white,
            Colors.white,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: pages[_currentIndex],
        ),
        bottomNavigationBar: NavigationBar(
          indicatorColor: EWColors.primary,
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
              selectedIcon: Icon(Icons.face, color: EWColors.darkgreen),
              icon: Icon(
                Icons.face,
                color: EWColors.darkgreen,
              ),
              label: 'Logga in',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.home, color: EWColors.darkgreen),
              icon: Icon(
                Icons.home_outlined,
                color: EWColors.darkgreen,
              ),
              label: 'Hem',
            ),
            NavigationDestination(
              selectedIcon: Icon(
                Icons.favorite,
                color: EWColors.darkgreen,
              ),
              icon: Icon(
                Icons.favorite_border_outlined,
                color: EWColors.darkgreen,
              ),
              label: 'Favoriter',
            ),
            NavigationDestination(
              selectedIcon: Icon(
                Icons.shopping_basket,
                color: EWColors.darkgreen,
              ),
              icon: Icon(
                Icons.shopping_basket_outlined,
                color: EWColors.darkgreen,
              ),
              label: 'Kundkorg',
            ),
            NavigationDestination(
              selectedIcon: Icon(
                Icons.map,
                color: EWColors.darkgreen,
              ),
              icon: Icon(
                Icons.map_outlined,
                color: EWColors.darkgreen,
              ),
              label: 'Karta',
            ),
            NavigationDestination(
              selectedIcon: Icon(
                Icons.person,
                color: EWColors.darkgreen,
              ),
              icon: Icon(
                Icons.person_outlined,
                color: EWColors.darkgreen,
              ),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}
