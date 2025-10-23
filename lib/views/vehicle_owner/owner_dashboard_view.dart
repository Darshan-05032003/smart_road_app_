import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VehicleDashboardScreen extends StatefulWidget {
  const VehicleDashboardScreen({super.key});

  @override
  _VehicleDashboardScreenState createState() => _VehicleDashboardScreenState();
}

class _VehicleDashboardScreenState extends State<VehicleDashboardScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  // Enhanced Sample Data
  final List<Map<String, dynamic>> _serviceHistory = [
    {
      'id': '1',
      'service': 'Tire Change',
      'date': '2024-01-15',
      'time': '14:30',
      'cost': '\$50',
      'provider': 'City Garage',
      'status': 'Completed',
      'rating': 4.5,
      'vehicle': 'Toyota Camry',
      'icon': Icons.build_circle,
    },
    {
      'id': '2',
      'service': 'Battery Jump',
      'date': '2024-01-10',
      'time': '09:15',
      'cost': '\$30',
      'provider': 'Quick Fix Auto',
      'status': 'Completed',
      'rating': 4.2,
      'vehicle': 'Toyota Camry',
      'icon': Icons.electric_car,
    },
    {
      'id': '3',
      'service': 'Fuel Delivery',
      'date': '2024-01-05',
      'time': '18:45',
      'cost': '\$25',
      'provider': 'Roadside Pro',
      'status': 'Completed',
      'rating': 4.8,
      'vehicle': 'Toyota Camry',
      'icon': Icons.local_gas_station,
    },
  ];

  final List<Map<String, dynamic>> _nearbyGarages = [
    {
      'name': 'City Garage',
      'rating': 4.5,
      'distance': '2.1 km',
      'services': ['Tire', 'Battery', 'Engine', 'Fuel'],
      'open': true,
      'eta': '15 min',
      'image': '🏢',
      'reviews': 128,
      'color': Colors.purple,
    },
    {
      'name': 'Quick Fix Auto',
      'rating': 4.2,
      'distance': '3.5 km',
      'services': ['Battery', 'Fuel', 'Tire'],
      'open': true,
      'eta': '20 min',
      'image': '🔧',
      'reviews': 89,
      'color': Colors.blue,
    },
    {
      'name': 'Pro Mechanics',
      'rating': 4.8,
      'distance': '5.2 km',
      'services': ['Engine', 'Tire', 'Battery', 'Accident'],
      'open': false,
      'eta': '30 min',
      'image': '🚗',
      'reviews': 256,
      'color': Colors.orange,
    },
  ];

  final List<Map<String, dynamic>> _activePromotions = [
    {
      'title': 'Free Tire Check',
      'description': 'Get free tire inspection this month',
      'validUntil': '2024-02-15',
      'color': Color(0xFF8B5CF6),
      'icon': Icons.build_circle,
    },
    {
      'title': '20% Off Battery',
      'description': 'Special discount on battery services',
      'validUntil': '2024-01-31',
      'color': Color(0xFF7C3AED),
      'icon': Icons.electric_car,
    },
    {
      'title': 'Emergency Service',
      'description': 'Priority service for emergencies',
      'validUntil': '2024-03-01',
      'color': Color(0xFF6D28D9),
      'icon': Icons.emergency,
    },
  ];

  final Map<String, dynamic> _userData = {
    'name': 'John Doe',
    'email': 'john.doe@example.com',
    'vehicle': 'Toyota Camry 2022',
    'plan': 'Gold Plan',
    'memberSince': '2023',
    'points': 450,
    'nextService': '2024-02-20',
    'emergencyContacts': ['+1-234-567-8900', '+1-234-567-8901'],
  };

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildEnhancedAppBar(),
      drawer: _buildEnhancedDrawer(),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: _getCurrentScreen(),
        ),
      ),
      bottomNavigationBar: _buildEnhancedBottomNavigationBar(),
      floatingActionButton: _currentIndex == 0
          ? _buildEnhancedFloatingActions()
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  AppBar _buildEnhancedAppBar() {
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'AutoConnect',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 22,
              color: Colors.white,
            ),
          ),
          Text(
            'Always here to help',
            style: TextStyle(fontSize: 12, color: Colors.white70),
          ),
        ],
      ),
      backgroundColor: Color(0xFF6D28D9),
      foregroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      actions: [
        _buildNotificationBadge(),
        IconButton(
          icon: Icon(Icons.qr_code_scanner_rounded),
          onPressed: _showQRScanner,
          tooltip: 'Scan QR Code',
        ),
      ],
    );
  }

  Widget _buildNotificationBadge() {
    return Stack(
      children: [
        IconButton(
          icon: Icon(Icons.notifications_outlined),
          onPressed: _showNotifications,
        ),
        Positioned(
          right: 8,
          top: 8,
          child: Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(6),
            ),
            constraints: BoxConstraints(minWidth: 14, minHeight: 14),
            child: Text(
              '3',
              style: TextStyle(
                color: Colors.white,
                fontSize: 8,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEnhancedDrawer() {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF6D28D9), Color(0xFF8B5CF6)],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            _buildDrawerHeader(),
            _buildDrawerItem(
              icon: Icons.dashboard_rounded,
              title: 'Dashboard',
              onTap: () => _navigateToIndex(0),
            ),
            _buildDrawerItem(
              icon: Icons.emergency_rounded,
              title: 'Emergency Contacts',
              onTap: _showEmergencyContacts,
            ),
            _buildDrawerItem(
              icon: Icons.history_rounded,
              title: 'Service History',
              onTap: () => _navigateToIndex(2),
            ),
            _buildDrawerItem(
              icon: Icons.payment_rounded,
              title: 'Payment Methods',
              onTap: _showPaymentMethods,
            ),

            Divider(color: Colors.white54, height: 20),
            _buildDrawerItem(
              icon: Icons.settings_rounded,
              title: 'Settings',
              onTap: _showSettings,
            ),
            _buildDrawerItem(
              icon: Icons.help_center_rounded,
              title: 'Help & Support',
              onTap: _showHelp,
            ),
            _buildDrawerItem(
              icon: Icons.logout_rounded,
              title: 'Logout',
              onTap: _logout,
              color: Colors.red[300],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return Container(
      padding: EdgeInsets.only(top: 60, bottom: 20, left: 20, right: 20),
      decoration: BoxDecoration(color: Color(0xFF5B21B6).withOpacity(0.8)),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.person_rounded,
              size: 50,
              color: Color(0xFF6D28D9),
            ),
          ),
          SizedBox(height: 16),
          Text(
            _userData['name'],
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            _userData['email'],
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: color ?? Colors.white70, size: 20),
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
      ),
      onTap: onTap,
      hoverColor: Colors.white.withOpacity(0.1),
    );
  }

  Widget _getCurrentScreen() {
    switch (_currentIndex) {
      case 0:
        return EnhancedHomeScreen(
          userData: _userData,
          promotions: _activePromotions,
          serviceHistory: _serviceHistory,
        );
      case 1:
        return EnhancedRequestScreen(garages: _nearbyGarages);
      case 2:
        return EnhancedHistoryScreen(serviceHistory: _serviceHistory);
      case 3:
        return EnhancedProfileScreen(userData: _userData);
      default:
        return EnhancedHomeScreen(
          userData: _userData,
          promotions: _activePromotions,
          serviceHistory: _serviceHistory,
        );
    }
  }

  Widget _buildEnhancedBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withOpacity(0.1),
            blurRadius: 20,
            offset: Offset(0, -5),
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
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              _animationController.reset();
              _animationController.forward();
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Color(0xFF6D28D9),
          unselectedItemColor: Colors.grey[600],
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
          unselectedLabelStyle: TextStyle(fontSize: 12),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              activeIcon: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xFF6D28D9).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.home_rounded,
                  color: Color.fromRGBO(109, 40, 217, 1),
                ),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.handyman_rounded),
              activeIcon: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xFF6D28D9).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.handyman_rounded,
                  color: Color.fromRGBO(109, 40, 217, 1),
                ),
              ),
              label: 'Services',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history_rounded),
              activeIcon: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xFF6D28D9).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.history_rounded,
                  color: Color.fromRGBO(109, 40, 217, 1),
                ),
              ),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              activeIcon: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xFF6D28D9).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person_rounded,
                  color: Color.fromRGBO(109, 40, 217, 1),
                ),
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEnhancedFloatingActions() {
    return Container(
      height: 80,
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildActionButton(
            icon: Icons.local_shipping_rounded,
            label: 'Tow',
            color: Color(0xFF6D28D9),
            onTap: _showTowRequest,
          ),
          _buildActionButton(
            icon: Icons.handyman_rounded,
            label: 'Mechanic',
            color: Color(0xFFF59E0B),
            onTap: () => _navigateToIndex(1),
          ),
          _buildActionButton(
            icon: Icons.emergency_rounded,
            label: 'SOS',
            color: Color(0xFFEF4444),
            onTap: _showEnhancedSOS,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.2),
              blurRadius: 15,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color, Color.lerp(color, Colors.black, 0.1)!],
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 20),
            ),
            SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
    Navigator.pop(context);
  }

  void _showEnhancedSOS() {
    HapticFeedback.heavyImpact();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          SOSEmergencyScreen(emergencyContacts: _userData['emergencyContacts']),
    );
  }

  void _showTowRequest() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RequestScreen()),
    );
  }

  // Placeholder methods
  void _showEmergencyContacts() => _showComingSoon('Emergency Contacts');
  void _showPaymentMethods() => _showComingSoon('Payment Methods');

  void _showSettings() => _showComingSoon('Settings');
  void _showHelp() => _showComingSoon('Help & Support');
  void _showNotifications() => _showComingSoon('Notifications');
  void _showQRScanner() => _showComingSoon('QR Scanner');
  void _logout() => _showComingSoon('Logout');

  void _showComingSoon(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature - Coming Soon!'),
        backgroundColor: Color.fromRGBO(109, 40, 217, 1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

// Enhanced Home Screen
class EnhancedHomeScreen extends StatelessWidget {
  final Map<String, dynamic> userData;
  final List<Map<String, dynamic>> promotions;
  final List<Map<String, dynamic>> serviceHistory;

  const EnhancedHomeScreen({
    super.key,
    required this.userData,
    required this.promotions,
    required this.serviceHistory,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          _buildWelcomeCard(),
          SizedBox(height: 20),
          _buildQuickActions(),
          SizedBox(height: 20),
          _buildQuickStats(),
          SizedBox(height: 20),
          _buildPromotionsCarousel(),
          SizedBox(height: 20),
          _buildRecentServices(),
        ],
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF6D28D9), Color.fromRGBO(139, 92, 246, 1)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF6D28D9).withOpacity(0.3),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person_rounded,
                  color: Color.fromRGBO(109, 40, 217, 1),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome back, ${userData['name'].split(' ')[0]}! 👋',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Your ${userData['plan']} is active',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Row(
      children: [
        Expanded(
          child: _buildQuickActionItem(
            icon: Icons.location_on_rounded,
            title: 'Track Service',
            color: Colors.blue,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _buildQuickActionItem(
            icon: Icons.schedule_rounded,
            title: 'Schedule',
            color: Colors.green,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _buildQuickActionItem(
            icon: Icons.support_agent_rounded,
            title: 'Support',
            color: Colors.orange,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionItem({
    required IconData icon,
    required String title,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            title: 'Services Used',
            value: '3',
            subtitle: 'This month',
            color: Color.fromRGBO(109, 40, 217, 1),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            title: 'Response Time',
            value: '12 min',
            subtitle: 'Average',
            color: Colors.blue,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            title: 'Savings',
            value: '\$85',
            subtitle: 'Total',
            color: Colors.green,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.trending_up_rounded, color: color, size: 16),
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(title, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        ],
      ),
    );
  }

  Widget _buildPromotionsCarousel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Special Offers 🎁',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'See All',
                style: TextStyle(
                  color: Color.fromRGBO(109, 40, 217, 1),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: promotions.length,
            itemBuilder: (context, index) {
              final promo = promotions[index];
              return Container(
                width: 280,
                margin: EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [promo['color'], Color.fromRGBO(109, 40, 217, 1)],
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: promo['color'].withOpacity(0.3),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -20,
                      top: -20,
                      child: Icon(
                        promo['icon'],
                        size: 80,
                        // ignore: deprecated_member_use
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            promo['title'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            promo['description'],
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              // ignore: deprecated_member_use
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'Valid until ${promo['validUntil']}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRecentServices() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Services',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'View All',
                style: TextStyle(
                  color: Color.from(
                    alpha: 1,
                    red: 0.427,
                    green: 0.157,
                    blue: 0.851,
                  ),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        ...serviceHistory.take(2).map((service) => _buildServiceItem(service)),
      ],
    );
  }

  Widget _buildServiceItem(Map<String, dynamic> service) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(109, 40, 217, 1),
                Color.fromRGBO(139, 92, 246, 1),
              ],
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(service['icon'], color: Colors.white),
        ),
        title: Text(
          service['service'],
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text('${service['date']} • ${service['provider']}'),
            Row(
              children: [
                Icon(Icons.star_rounded, color: Colors.amber, size: 16),
                Text(' ${service['rating']}'),
              ],
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                // ignore: deprecated_member_use
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                service['status'],
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              service['cost'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(109, 40, 217, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// RequestScreen
class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  _RequestScreenState createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  String? _selectedVehicleType;
  String? _selectedIssueType;
  final TextEditingController _descriptionController = TextEditingController();

  final List<String> _vehicleTypes = [
    'Car',
    'Motorcycle',
    'SUV',
    'Truck',
    'Van',
  ];
  final List<String> _issueTypes = [
    'Engine Failure',
    'Flat Tire',
    'Accident',
    'Out of Fuel',
    'Battery Issue',
    'Locked Out',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLocationCard(),
            SizedBox(height: 24),
            _buildVehicleTypeCard(),
            SizedBox(height: 16),
            _buildIssueTypeCard(),
            SizedBox(height: 16),
            _buildDescriptionCard(),
            SizedBox(height: 16),
            _buildPhotoUploadCard(),
            SizedBox(height: 24),
            _buildRequestButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationCard() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.location_on, color: Color(0xFF7E57C2)),
              SizedBox(width: 8),
              Text(
                'Your Location',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF333333),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: Color(0xFFF5F5F7),
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage(
                  'https://via.placeholder.com/400x200?text=Map+View',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.my_location, color: Color(0xFF7E57C2), size: 16),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  '123 Main Street, Downtown, City - 12345',
                  style: TextStyle(color: Color(0xFF666666), fontSize: 14),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Change Location',
                  style: TextStyle(
                    color: Color(0xFF7E57C2),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleTypeCard() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Vehicle Type',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF333333),
            ),
          ),
          SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _vehicleTypes.map((type) {
              final isSelected = _selectedVehicleType == type;
              return ChoiceChip(
                label: Text(type),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    _selectedVehicleType = selected ? type : null;
                  });
                },
                selectedColor: Color(0xFF7E57C2),
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : Color(0xFF666666),
                ),
                backgroundColor: Color(0xFFF5F5F7),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildIssueTypeCard() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Issue Type',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF333333),
            ),
          ),
          SizedBox(height: 12),
          Column(
            children: _issueTypes.map((issue) {
              final isSelected = _selectedIssueType == issue;
              return ListTile(
                leading: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Color(0xFF7E57C2).withOpacity(0.1)
                        : Color(0xFFF5F5F7),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _getIssueIcon(issue),
                    color: isSelected ? Color(0xFF7E57C2) : Color(0xFF666666),
                    size: 16,
                  ),
                ),
                title: Text(
                  issue,
                  style: TextStyle(
                    color: Color(0xFF333333),
                    fontWeight: isSelected
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                ),
                trailing: isSelected
                    ? Icon(Icons.check_circle, color: Color(0xFF7E57C2))
                    : null,
                onTap: () {
                  setState(() {
                    _selectedIssueType = issue;
                  });
                },
                contentPadding: EdgeInsets.zero,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  IconData _getIssueIcon(String issue) {
    switch (issue) {
      case 'Engine Failure':
        return FontAwesomeIcons.nine;
      case 'Flat Tire':
        return FontAwesomeIcons.tired;
      case 'Accident':
        return FontAwesomeIcons.carCrash;
      case 'Out of Fuel':
        return FontAwesomeIcons.gasPump;
      case 'Battery Issue':
        return FontAwesomeIcons.batteryHalf;
      case 'Locked Out':
        return FontAwesomeIcons.lock;
      default:
        return FontAwesomeIcons.questionCircle;
    }
  }

  Widget _buildDescriptionCard() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Additional Details',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF333333),
            ),
          ),
          SizedBox(height: 12),
          TextField(
            controller: _descriptionController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Describe your issue in detail...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xFFE0E0E0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Color(0xFF7E57C2)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoUploadCard() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Upload Photos (Optional)',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF333333),
            ),
          ),
          SizedBox(height: 12),
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: Color(0xFFF5F5F7),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color(0xFFE0E0E0), width: 1),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.camera_alt, color: Color(0xFF7E57C2), size: 32),
                  SizedBox(height: 8),
                  Text(
                    'Tap to add photos',
                    style: TextStyle(color: Color(0xFF666666)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF7E57C2), Color(0xFF5E35B1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF7E57C2).withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            _showConfirmationDialog();
          },
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.local_shipping, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  'Request Tow Service',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.local_shipping, color: Color(0xFF7E57C2)),
            SizedBox(width: 8),
            Text('Confirm Request'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Please confirm your tow service request:'),
            SizedBox(height: 12),
            if (_selectedVehicleType != null)
              Text('Vehicle: $_selectedVehicleType'),
            if (_selectedIssueType != null) Text('Issue: $_selectedIssueType'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF7E57C2)),
            onPressed: () {
              Navigator.pop(context);
              _showSuccessDialog();
            },
            child: Text('Confirm'),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Icon(Icons.check_circle, color: Color(0xFF4CAF50), size: 48),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Request Sent!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            Text(
              'Your tow service request has been sent to nearby providers.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF666666)),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF7E57C2)),
            onPressed: () => Navigator.pop(context),
            child: Text('Track Service'),
          ),
        ],
      ),
    );
  }
}

// Enhanced Request Screen
class EnhancedRequestScreen extends StatefulWidget {
  final List<Map<String, dynamic>> garages;

  const EnhancedRequestScreen({super.key, required this.garages});

  @override
  _EnhancedRequestScreenState createState() => _EnhancedRequestScreenState();
}

class _EnhancedRequestScreenState extends State<EnhancedRequestScreen> {
  String? _selectedIssue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Request Service'),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(109, 40, 217, 1),
                      Color.fromRGBO(139, 92, 246, 1),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildServiceTypeGrid(),
                    SizedBox(height: 20),
                    _buildNearbyProviders(),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceTypeGrid() {
    final services = [
      {'icon': Icons.electric_car, 'title': 'Battery', 'color': Colors.orange},
      {'icon': Icons.build_circle, 'title': 'Tire', 'color': Colors.blue},
      {'icon': Icons.local_gas_station, 'title': 'Fuel', 'color': Colors.green},
      {'icon': Icons.build_circle, 'title': 'Engine', 'color': Colors.red},
      {'icon': Icons.lock, 'title': 'Lockout', 'color': Colors.purple},
      {'icon': Icons.water_damage, 'title': 'Accident', 'color': Colors.amber},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.9,
      ),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        return _buildServiceTypeCard(service);
      },
    );
  }
  //Build Service Type Card

  Widget _buildServiceTypeCard(Map<String, dynamic> service) {
    return GestureDetector(
      onTap: () {},
      onLongPress: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${service['title']} service selected")),
        );
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: service['color'].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(service['icon'], color: service['color'], size: 24),
              ),
              const SizedBox(height: 8),
              Text(
                service['title'],
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNearbyProviders() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nearby Service Providers',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        ...widget.garages.map((garage) => _buildProviderCard(garage)),
      ],
    );
  }

  Widget _buildProviderCard(Map<String, dynamic> garage) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: garage['color'].withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(garage['image'], style: TextStyle(fontSize: 20)),
          ),
        ),
        title: Row(
          children: [
            Text(garage['name'], style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(width: 8),
            if (!garage['open'])
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Closed',
                  style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                ),
              ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.star_rounded, color: Colors.amber, size: 16),
                SizedBox(width: 4),
                Text('${garage['rating']}'),
                SizedBox(width: 8),
                Icon(Icons.location_on_rounded, color: Colors.grey, size: 14),
                Text(garage['distance']),
              ],
            ),
            SizedBox(height: 4),
            Wrap(
              spacing: 4,
              children: (garage['services'] as List<String>).take(3).map((
                service,
              ) {
                return Chip(
                  label: Text(service),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  labelStyle: TextStyle(fontSize: 10),
                  // ignore: deprecated_member_use
                  backgroundColor: Color(0xFF6D28D9).withOpacity(0.1),
                );
              }).toList(),
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              garage['eta'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(109, 40, 217, 1),
              ),
            ),
            ElevatedButton(
              onPressed: garage['open'] ? () => _requestService(garage) : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(109, 40, 217, 1),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              ),
              child: Text('Book'),
            ),
          ],
        ),
      ),
    );
  }

  void _selectService(String service) {
    setState(() {
      _selectedIssue = service;
    });
  }

  void _requestService(Map<String, dynamic> garage) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Booking'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Provider: ${garage['name']}'),
            Text('ETA: ${garage['eta']}'),
            Text('Rating: ${garage['rating']} ⭐'),
            if (_selectedIssue != null) Text('Service: $_selectedIssue'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Service booked with ${garage['name']}!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromRGBO(109, 40, 217, 1),
            ),
            child: Text('Confirm'),
          ),
        ],
      ),
    );
  }
}

// Enhanced History Screen
class EnhancedHistoryScreen extends StatelessWidget {
  final List<Map<String, dynamic>> serviceHistory;

  const EnhancedHistoryScreen({super.key, required this.serviceHistory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 100,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Service History'),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(109, 40, 217, 1),
                      Color.fromRGBO(139, 92, 246, 1),
                    ],
                  ),
                ),
              ),
            ),
          ),
          serviceHistory.isEmpty
              ? SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.history_rounded,
                          size: 60,
                          color: Colors.grey[400],
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No service history yet',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final service = serviceHistory[index];
                    return _buildHistoryCard(service, context);
                  }, childCount: serviceHistory.length),
                ),
        ],
      ),
    );
  }

  Widget _buildHistoryCard(Map<String, dynamic> service, BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(109, 40, 217, 1),
                Color.fromRGBO(139, 92, 246, 1),
              ],
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(service['icon'], color: Colors.white),
        ),
        title: Text(
          service['service'],
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text('${service['date']} at ${service['time']}'),
            Text('${service['provider']} • ${service['vehicle']}'),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.star_rounded, color: Colors.amber, size: 16),
                Text(' ${service['rating']}'),
              ],
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _getStatusColor(service['status']),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                service['status'],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              service['cost'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(109, 40, 217, 1),
              ),
            ),
          ],
        ),
        onTap: () => _showServiceDetails(service, context),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Colors.green;
      case 'in progress':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _showServiceDetails(Map<String, dynamic> service, BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => ServiceDetailsBottomSheet(service: service),
    );
  }
}

class ServiceDetailsBottomSheet extends StatelessWidget {
  final Map<String, dynamic> service;

  const ServiceDetailsBottomSheet({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Service Details',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          _buildDetailRow('Service Type', service['service']),
          _buildDetailRow('Provider', service['provider']),
          _buildDetailRow(
            'Date & Time',
            '${service['date']} at ${service['time']}',
          ),
          _buildDetailRow('Vehicle', service['vehicle']),
          _buildDetailRow('Cost', service['cost']),
          _buildDetailRow('Status', service['status']),
          _buildDetailRow('Rating', '${service['rating']} ⭐'),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Invoice downloaded successfully!'),
                      ),
                    );
                    Navigator.pop(context);
                  },
                  child: Text('Download Invoice'),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(109, 40, 217, 1),
                  ),
                  child: Text('Close'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            '$label:',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(width: 8),
          Text(value),
        ],
      ),
    );
  }
}

// Enhanced Profile Screen
class EnhancedProfileScreen extends StatefulWidget {
  final Map<String, dynamic> userData;

  const EnhancedProfileScreen({super.key, required this.userData});

  @override
  _EnhancedProfileScreenState createState() => _EnhancedProfileScreenState();
}

class _EnhancedProfileScreenState extends State<EnhancedProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _vehicleController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.userData['name']);
    _emailController = TextEditingController(text: widget.userData['email']);
    _vehicleController = TextEditingController(
      text: widget.userData['vehicle'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 00,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('My Profile'),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(109, 40, 217, 1),
                      Color.fromRGBO(139, 92, 246, 1),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              _buildProfileHeader(),
              _buildEditProfileSection(),
              //_buildAccountInfoSection(),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(109, 40, 217, 1),
                      Color.fromRGBO(139, 92, 246, 1),
                    ],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(109, 40, 217, 1).withOpacity(0.3),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.person_rounded,
                  size: 50,
                  color: Colors.white,
                ),
              ),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.camera_alt_rounded,
                  size: 16,
                  color: Color.fromRGBO(109, 40, 217, 1),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            widget.userData['name'],
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(widget.userData['email']),
        ],
      ),
    );
  }

  Widget _buildEditProfileSection() {
    return Card(
      margin: EdgeInsets.all(16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Edit Profile',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            _buildProfileField(
              'Full Name',
              _nameController,
              Icons.person_rounded,
            ),
            SizedBox(height: 12),
            _buildProfileField('Email', _emailController, Icons.email_rounded),
            SizedBox(height: 12),
            _buildProfileField(
              'Vehicle Info',
              _vehicleController,
              Icons.directions_car_rounded,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _saveProfile();
              }, // ✅ Correct place for callback
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(109, 40, 217, 1),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileField(
    String label,
    TextEditingController controller,
    IconData icon,
  ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Color.fromRGBO(109, 40, 217, 1)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color.fromRGBO(109, 40, 217, 1)),
        ),
      ),
    );
  }

  /*Widget _buildAccountInfoSection() {
    return Card(
      margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Account Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            _buildInfoItem(Icons.people_rounded, 'Member Since', widget.userData['memberSince']),
            _buildInfoItem(Icons.auto_awesome_rounded, 'Reward Points', widget.userData['points'].toString()),
            _buildInfoItem(Icons.calendar_today_rounded, 'Next Service', widget.userData['nextService']),
            _buildInfoItem(Icons.verified_rounded, 'Account Status', 'Verified'),
            _buildInfoItem(Icons.payment_rounded, 'Payment Method', 'Credit Card •••• 1234'),
          ],
        ),
      ),
    );
  }*/

  /* Widget _buildInfoItem(IconData icon, String title, String value) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Color(0xFF6D28D9).withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: Color(0xFF6D28D9), size: 20),
      ),
      title: Text(title, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
      subtitle: Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
    );
  }*/

  void _saveProfile() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Profile updated successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _vehicleController.dispose();
    super.dispose();
  }
}

// SOS Emergency Screen
class SOSEmergencyScreen extends StatelessWidget {
  final List<String> emergencyContacts;

  const SOSEmergencyScreen({super.key, required this.emergencyContacts});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 4,
            margin: EdgeInsets.only(top: 12, bottom: 20),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.emergency_rounded,
                    size: 60,
                    color: Colors.red,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'EMERGENCY SOS',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    'Emergency alert will be sent to nearby service providers and your emergency contacts',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      HapticFeedback.heavyImpact();
                      _sendSOSAlert(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.emergency_rounded),
                        SizedBox(width: 8),
                        Text('SEND ALERT NOW'),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                if (emergencyContacts.isNotEmpty) ...[
                  Text(
                    'Emergency Contacts:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  ...emergencyContacts.map((contact) => Text(contact)),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendSOSAlert(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Emergency SOS alert sent! Help is on the way.'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 5),
      ),
    );
    Navigator.pop(context);
  }
}
