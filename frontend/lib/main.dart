import 'package:eatwise/backend/network.dart';
import 'package:eatwise/constants/ew_colors.dart';
import 'package:eatwise/models/category_notifier.dart';
import 'package:eatwise/models/favorite_notifier.dart';
import 'package:eatwise/models/pickup_notifier.dart';
import 'package:eatwise/models/product_notifier.dart';
import 'package:eatwise/pages/favorites_page.dart';
import 'package:eatwise/pages/home_page.dart';
import 'package:eatwise/pages/map_page.dart';
import 'package:eatwise/pages/profile_page.dart';
import 'package:eatwise/widgets/ew_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoriteItemsNotifier()),
        ChangeNotifierProvider(create: (_) => ProductNotifier()),
        ChangeNotifierProvider(create: (_) => CategoryNotifier()),
        ChangeNotifierProvider(create: (_) => PickUpNotifier())
      ],
      child: const MyApp(), // Ensure MyApp is properly imported
    ),
  );
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
  final List<Widget> pages = [
    const HomePage(),
    const FavoritesPage(),
    const MapPage(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    fetchDadJoke();
    // Provider.of<FavoriteItemsNotifier>(context, listen: false)
    //                         .updateList(fetchFavorites());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return EWScaffold(
      body: pages[_currentIndex],
      navBar: NavigationBar(
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
    );
  }
}
