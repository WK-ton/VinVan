import 'package:application/screen/Booking.dart';
import 'package:application/screen/Home.dart';
import 'package:application/screen/Profile.dart';
import 'package:application/screen/Search/Cars.dart';
import 'package:application/screen/Search/Search.dart';
import 'package:application/screen/Seat.dart';
import 'package:application/screen/Ticket.dart';
import 'package:application/screen/vanbook.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomTab extends StatefulWidget {
  final token;
  const BottomTab({@required this.token, super.key});

  @override
  _BottomTabState createState() => _BottomTabState();
}

class _BottomTabState extends State<BottomTab> {
  int _currentIndex = 0;

  void _changePage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: const Color.fromARGB(255, 92, 36, 212),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: GNav(
            backgroundColor: const Color.fromARGB(255, 92, 36, 212),
            color: Colors.white,
            activeColor: const Color.fromARGB(255, 92, 36, 212),
            tabBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
            gap: 8,
            selectedIndex: _currentIndex,
            onTabChange: _changePage,
            padding: const EdgeInsets.all(16),
            tabs: const [
              // GButton(
              //   icon: Icons.home,
              //   text: 'Home',
              // ),
              GButton(
                icon: Icons.home_sharp,
                text: 'Home',
              ),
              GButton(
                icon: Icons.qr_code_2,
                text: 'Ticket',
              ),
              // GButton(
              //   icon: Icons.home_repair_service_sharp,
              //   text: 'Seat',
              // ),
              GButton(
                icon: Icons.supervised_user_circle_sharp,
                text: 'Profile',
              ),
            ],
          ),
        ),
      ),
      body:
          _getPage(_currentIndex), // Add this line to display the current page
    );
  }

  Widget _getPage(int index) {
    // Return the appropriate page widget based on the current index
    switch (index) {
      // case 0:
      //   return const HomeScreen(); // Replace with your home screen widget
      case 0:
        return SearchVan(
          token: widget.token,
        );
      // Replace with your booking screen widget
      case 1:
        return const Ticket();
      // case 2:
      //   return const Cars();
      case 2:
        return Profile(
          token: widget.token,
        ); // Replace with your user screen widget
      default:
        return Container();
    }
  }
}
