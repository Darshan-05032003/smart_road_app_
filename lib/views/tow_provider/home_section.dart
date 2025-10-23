import 'package:flutter/material.dart';
import 'package:smart_roadside/models/tow_provider_model.dart';

class HomeScreenProvider extends StatelessWidget {
  final List<ProviderServiceHistoryModel> completedServices = [
    ProviderServiceHistoryModel(
      'Michael Smith',
      'Flat Tire Repair',
      'Oct 15, 2024',
      '\$85.00',
    ),
    ProviderServiceHistoryModel(
      'Laura Adams',
      'Battery Jumpstart',
      'Oct 12, 2024',
      '\$45.00',
    ),
    ProviderServiceHistoryModel(
      'John Doe',
      'Engine Trouble',
      'Oct 8, 2024',
      '\$120.00',
    ),
  ];

  HomeScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return SingleChildScrollView(
      padding: EdgeInsets.all(isTablet ? 24 : 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWelcomeCard(isTablet),
          SizedBox(height: isTablet ? 32 : 24),
          _buildQuickActions(isTablet),
          SizedBox(height: isTablet ? 32 : 24),
          _buildActiveRequest(isTablet),
          SizedBox(height: isTablet ? 32 : 24),
          _buildCompletedServices(isTablet),
        ],
      ),
    );
  }

  // ------------------- WELCOME CARD -------------------
  Widget _buildWelcomeCard(bool isTablet) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isTablet ? 28 : 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF7E57C2), Color(0xFF5E35B1)],
        ),
        borderRadius: BorderRadius.circular(isTablet ? 24 : 20),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF7E57C2).withOpacity(0.3),
            blurRadius: 20,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: isTablet ? 32 : 24,
                backgroundColor: Colors.white.withOpacity(0.2),
                child: Icon(
                  Icons.local_shipping,
                  color: Colors.white,
                  size: isTablet ? 28 : 24,
                ),
              ),
              SizedBox(width: isTablet ? 16 : 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome back!',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: isTablet ? 16 : 14,
                      ),
                    ),
                    Text(
                      'City Tow Service',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isTablet ? 22 : 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    SizedBox(width: 4),
                    Text(
                      'Premium Provider',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: isTablet ? 20 : 16),
          Text(
            'Ready to accept tow requests near you',
            style: TextStyle(
              color: Colors.white,
              fontSize: isTablet ? 18 : 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Manage your fleet and respond quickly to customers',
            style: TextStyle(
              color: Colors.white70,
              fontSize: isTablet ? 15 : 14,
            ),
          ),
        ],
      ),
    );
  }

  // ------------------- QUICK ACTIONS -------------------
  Widget _buildQuickActions(bool isTablet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: isTablet ? 22 : 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF333333),
          ),
        ),
        SizedBox(height: isTablet ? 20 : 16),
        Row(
          children: [
            Expanded(
              child: _buildActionButton(
                icon: Icons.assignment_turned_in,
                title: 'Accept Requests',
                subtitle: 'View incoming requests',
                color: Color(0xFF7E57C2),
                isTablet: isTablet,
                onTap: () {},
              ),
            ),
            SizedBox(width: isTablet ? 16 : 12),
            Expanded(
              child: _buildActionButton(
                icon: Icons.car_rental,
                title: 'My Fleet',
                subtitle: 'Manage vehicles',
                color: Color(0xFF5E35B1),
                isTablet: isTablet,
                onTap: () {},
              ),
            ),
          ],
        ),
        SizedBox(height: isTablet ? 16 : 12),
        Row(
          children: [
            Expanded(
              child: _buildActionButton(
                icon: Icons.history,
                title: 'History',
                subtitle: 'Completed services',
                color: Color(0xFF9C27B0),
                isTablet: isTablet,
                onTap: () {},
              ),
            ),
            SizedBox(width: isTablet ? 16 : 12),
            Expanded(
              child: _buildActionButton(
                icon: Icons.help_outline,
                title: 'Support',
                subtitle: 'Customer help',
                color: Color(0xFF673AB7),
                isTablet: isTablet,
                onTap: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required bool isTablet,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(isTablet ? 20 : 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(isTablet ? 20 : 16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(isTablet ? 16 : 12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: isTablet ? 24 : 20),
            ),
            SizedBox(height: isTablet ? 12 : 8),
            Text(
              title,
              style: TextStyle(
                color: Color(0xFF333333),
                fontSize: isTablet ? 16 : 12,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                color: Color(0xFF666666),
                fontSize: isTablet ? 12 : 10,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // ------------------- ACTIVE REQUESTS -------------------
  Widget _buildActiveRequest(bool isTablet) {
    List<ActiveRequestModel> activeRequest = [
      ActiveRequestModel(
        'Michael Smith',
        'Flat Tire',
        '2.4 km',
        '8 min',
        'On the Way',
      ),
      ActiveRequestModel(
        'Laura Adams',
        'Battery Jumpstart',
        '1.8 km',
        '5 min',
        'Pending',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Active Requests',
          style: TextStyle(
            fontSize: isTablet ? 22 : 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF333333),
          ),
        ),
        SizedBox(height: isTablet ? 16 : 12),
        Column(
          children: activeRequest
              .map(
                (req) => Container(
                  margin: EdgeInsets.only(bottom: isTablet ? 16 : 12),
                  padding: EdgeInsets.all(isTablet ? 16 : 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(isTablet ? 16 : 12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.local_shipping,
                        color: Color(0xFF7E57C2),
                        size: isTablet ? 28 : 24,
                      ),
                      SizedBox(width: isTablet ? 16 : 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              req.customerName,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: isTablet ? 16 : 14,
                                color: Color(0xFF333333),
                              ),
                            ),
                            Text(
                              '${req.serviceType} • ${req.distance} • ETA: ${req.eta}',
                              style: TextStyle(
                                fontSize: isTablet ? 14 : 12,
                                color: Color(0xFF7E57C2),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: req.status == 'Pending'
                              ? Color(0xFFFFA000).withOpacity(0.1)
                              : Color(0xFF4CAF50).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          req.status,
                          style: TextStyle(
                            color: req.status == 'Pending'
                                ? Color.fromRGBO(255, 160, 0, 1)
                                : Color.fromRGBO(76, 175, 80, 1),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  // ------------------- COMPLETED SERVICES -------------------
  Widget _buildCompletedServices(bool isTablet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Completed Services',
          style: TextStyle(
            fontSize: isTablet ? 22 : 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF333333),
          ),
        ),
        SizedBox(height: isTablet ? 16 : 12),
        ...completedServices
            .map(
              (service) => Container(
                margin: EdgeInsets.only(bottom: isTablet ? 16 : 12),
                padding: EdgeInsets.all(isTablet ? 16 : 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(isTablet ? 16 : 12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.build,
                      color: Color(0xFF7E57C2),
                      size: isTablet ? 28 : 24,
                    ),
                    SizedBox(width: isTablet ? 16 : 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${service.customerName} - ${service.serviceType}',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: isTablet ? 16 : 14,
                              color: Color(0xFF333333),
                            ),
                          ),
                          Text(
                            service.date,
                            style: TextStyle(
                              fontSize: isTablet ? 14 : 12,
                              color: Color(0xFF666666),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      service.amount,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: isTablet ? 16 : 14,
                        color: Color(0xFF333333),
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ],
    );
  }
}
