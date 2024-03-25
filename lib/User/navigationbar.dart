import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home_outlined,
            size: 30,
          ),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.book_online_rounded,
            color: Colors.black38,
            size: 25,
          ),
          label: "Booking",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.account_balance_wallet_rounded,
            color: Colors.black38,
            size: 30,
          ),
          label: "Balance",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person_outline_rounded,
            color: Colors.black38,
            size: 30,
          ),
          label: "Profile",
        ),
      ],
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color.fromRGBO(3, 100, 176, 65),
    );
  }
}
