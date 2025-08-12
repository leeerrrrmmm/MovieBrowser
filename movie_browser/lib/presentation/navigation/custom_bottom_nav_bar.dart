import 'package:flutter/material.dart';
import 'package:movie_browser/presentation/favorite/favorite_screen.dart';
import 'package:movie_browser/presentation/main/main_screen.dart';

/// [CustomBottomNavBar]
class CustomBottomNavBar extends StatefulWidget {
  /// Constructor of [CustomBottomNavBar]
  const CustomBottomNavBar({super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int curPage = 0;
  final List<Widget> _pages = const [MainScreen(), FavoriteScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[curPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: curPage,
        onTap: (index) {
          setState(() {
            curPage = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
