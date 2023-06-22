import 'package:e_commerce_app/constants/colors.dart';
import 'package:e_commerce_app/screens/pages/cart_page.dart';
import 'package:e_commerce_app/screens/pages/home_page.dart';
import 'package:e_commerce_app/screens/pages/search_page.dart';
import 'package:e_commerce_app/screens/pages/setting_page.dart';
import 'package:e_commerce_app/screens/pages/user_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppScreen extends StatefulWidget {
  const AppScreen({super.key});

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            border: Border(
              top: BorderSide(
                color: Theme.of(context).colorScheme.secondary,
                width: 1,
              ),
            ),
            activeColor: VLColors.vlMainColor,
            backgroundColor: Colors.white,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.manage_search),
                label: "Search",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.payment_outlined),
                label: "Cart",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "User",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "Setting",
              ),
            ],
          ),
          tabBuilder: (context, index) {
            switch (index) {
              case 0:
                return CupertinoTabView(
                  builder: (context) {
                    return const CupertinoPageScaffold(
                      child: HomePage(),
                    );
                  },
                );
              case 1:
                return CupertinoTabView(
                  builder: (context) {
                    return const CupertinoPageScaffold(
                      child: SearchPage(),
                    );
                  },
                );
              case 2:
                return CupertinoTabView(
                  builder: (context) {
                    return const CupertinoPageScaffold(
                      child: CartPage(),
                    );
                  },
                );
              case 3:
                return CupertinoTabView(
                  builder: (context) {
                    return const CupertinoPageScaffold(
                      child: UserPage(),
                    );
                  },
                );
              case 4:
                return CupertinoTabView(
                  builder: (context) {
                    return const CupertinoPageScaffold(
                      child: SettingPage(),
                    );
                  },
                );
            }
            return Container();
          },
        ),
      ),
    );
  }
}

        // child: TextButton(
        //   child: const Text("LogOut"),
        //   onPressed: () => authEvent.signOutAction(context, mounted),
        // ),
