import 'package:flutter/material.dart';
import 'package:smart_roadside/views/tow_provider/home_section.dart';
import 'package:smart_roadside/ToeProvider/Requests_screen.dart';
import 'package:smart_roadside/ToeProvider/Track_screen.dart';
import 'package:smart_roadside/ToeProvider/profile_screen.dart';
//import 'package:smart_roadside/ToeProvider/ActiveRequestsScreen.dart';

//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import'package:async/async.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  _MainDashboardState createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    HomeScreenProvider(),
    ActiveRequestsScreen(),
    TowProviderTrackingScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: _currentIndex != 3 ? _buildAppBar(screenWidth) : null,
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 400),
        child: _screens[_currentIndex],
      ),
      bottomNavigationBar: _buildBottomNavBar(screenWidth),
    );
  }

  AppBar _buildAppBar(double screenWidth) {
    return AppBar(
      title: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color.fromRGBO(126, 87, 194, 1).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.local_car_wash,
              color: Theme.of(context).primaryColor,
              size: screenWidth > 600 ? 28 : 24,
            ),
          ),
          SizedBox(width: 12),
          Text(
            'TowAssist Pro',
            style: TextStyle(
              color: Color.fromRGBO(51, 51, 51, 1),
              fontWeight: FontWeight.w700,
              fontSize: screenWidth > 600 ? 22 : 18,
            ),
          ),
        ],
      ),
      actions: [
        _buildAppBarAction(Icons.notifications_none, screenWidth),
        _buildAppBarAction(Icons.history, screenWidth),
        if (screenWidth > 600)
          _buildAppBarAction(Icons.support_agent, screenWidth),
      ],
    );
  }

  Widget _buildAppBarAction(IconData icon, double screenWidth) {
    return IconButton(
      icon: Icon(
        icon,
        color: Color.fromRGBO(102, 102, 102, 1),
        size: screenWidth > 600 ? 28 : 24,
      ),
      onPressed: () {},
    );
  }

  Widget _buildBottomNavBar(double screenWidth) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 15,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Color.fromRGBO(153, 153, 153, 1),
          selectedLabelStyle: TextStyle(
            fontSize: screenWidth > 600 ? 14 : 12,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: screenWidth > 600 ? 14 : 12,
          ),
          iconSize: screenWidth > 600 ? 28 : 24,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              activeIcon: Icon(Icons.add_circle),
              label: 'Request',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on_outlined),
              activeIcon: Icon(Icons.location_on),
              label: 'Track',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
