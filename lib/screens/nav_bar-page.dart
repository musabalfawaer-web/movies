import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../auth_page/sign_in.dart';
import '../screens/favorite_page.dart';
import '../screens/profile_page.dart';
import '../screens/search_page.dart';
import '../views/home/home_page.dart';

class MainScreen extends StatefulWidget {
  final int initialIndex;

  const MainScreen({super.key, this.initialIndex = 0});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int currentIndex;

  final List<Widget> pages = [
    const HomePage(),
    const SearchPage(),
    const FavoritePage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  void changePage(int index) {
    final user = FirebaseAuth.instance.currentUser;

    // Favorites و Profile يحتاجوا تسجيل دخول
    if ((index == 2 || index == 3) && user == null) {
      showDialog(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: const Text(
              'Login Required',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: const Text(
              'Please sign in to use this feature.',
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(dialogContext);

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignInPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Sign In'),
              ),
            ],
          );
        },
      );

      return;
    }

    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: changePage,

        type: BottomNavigationBarType.fixed,

        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.black,

        selectedFontSize: 12,
        unselectedFontSize: 12,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            activeIcon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            activeIcon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
