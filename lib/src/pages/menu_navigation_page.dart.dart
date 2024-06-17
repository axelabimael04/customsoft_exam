import 'package:customsoft_exam/src/pages/account/account_page.dart';
import 'package:customsoft_exam/src/pages/favorites/favorites_page.dart';
import 'package:customsoft_exam/src/pages/home/home_page.dart';
import 'package:customsoft_exam/src/pages/search/search_page.dart';
import 'package:customsoft_exam/src/pages/shopping/shopping_page.dart';
import 'package:flutter/material.dart';

class MenuNavigationPage extends StatefulWidget {
  const MenuNavigationPage({
    super.key,
  });

  @override
  State<MenuNavigationPage> createState() => _MenuNavigationPageState();
}

class _MenuNavigationPageState extends State<MenuNavigationPage> {
  int currentNavIndex = 2;

  List<NavigationElementsHandler> navItems = [
    NavigationElementsHandler(
      page: HomePage(),
      navigationBarItem: BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined),
        activeIcon: Icon(Icons.home),
        label: "Inicio",
      ),
    ),
    NavigationElementsHandler(
      page: ShoppingPage(),
      navigationBarItem: BottomNavigationBarItem(
        icon: Icon(Icons.shopping_bag_outlined),
        activeIcon: Icon(Icons.shopping_bag_sharp),
        label: "Tienda",
      ),
    ),
    NavigationElementsHandler(
      page: SearchPage(),
      navigationBarItem: BottomNavigationBarItem(
        icon: Icon(Icons.search),
        label: "Búsqueda",
      ),
    ),
    NavigationElementsHandler(
      page: FavoritesPage(),
      navigationBarItem: BottomNavigationBarItem(
        icon: Icon(Icons.favorite_border),
        activeIcon: (Icon(Icons.favorite)),
        label: "Favoritos",
      ),
    ),
    NavigationElementsHandler(
      page: AccountPage(),
      navigationBarItem: BottomNavigationBarItem(
        icon: Icon(Icons.person_outline),
        activeIcon: Icon(Icons.person),
        label: "Perfil",
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navItems[currentNavIndex].page,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentNavIndex,
        onTap: (value) {
          setState(() {
            currentNavIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: navItems.map((e) => e.navigationBarItem).toList(),
      ),
    );
  }
}

class NavigationElementsHandler {
  final Widget page;
  final BottomNavigationBarItem navigationBarItem;

  NavigationElementsHandler({
    required this.page,
    required this.navigationBarItem,
  });
}
