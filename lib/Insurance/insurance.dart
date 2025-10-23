import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class InsuranceDashboard extends StatefulWidget {
  const InsuranceDashboard({super.key});

  @override
  _InsuranceDashboardState createState() => _InsuranceDashboardState();
}

class _InsuranceDashboardState extends State<InsuranceDashboard> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late TabController _tabController;
  bool _isAIEnabled = true;
  String _selectedFilter = 'All';
  String _searchQuery = '';
  String _timeRange = 'Monthly';
  bool _darkMode = false;
  
  final List<String> _filters = ['All', 'Pending', 'Approved', 'Rejected', 'High Risk', 'Under Review'];
  final List<String> _timeRanges = ['Daily', 'Weekly', 'Monthly', 'Quarterly', 'Yearly'];
  final List<Claim> _allClaims = [];
  final List<Activity> _activities = [];
  final List<Policy> _policies = [];
  final Map<String, dynamic> _analyticsData = {};
  final List<Map<String, dynamic>> _quickActions = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _loadSampleData();
    _initializeQuickActions();
  }

  void _loadSampleData() {
    // Sample claims data
    _allClaims.addAll([
      Claim(
        id: 'CL-2024-0012',
        customerName: 'Michael Chen',
        vehicle: 'Toyota Camry 2021',
        issue: 'Accident - Front Collision',
        amount: '\$2,450',
        status: 'Pending',
        priority: 'High',
        daysAgo: '2 hours ago',
        statusColor: Colors.orange,
        fraudRisk: 'Low',
        documents: 3,
        messages: 5,
        location: 'Downtown, Manhattan',
        policyNo: 'POL-2024-0456',
      ),
      Claim(
        id: 'CL-2024-0011',
        customerName: 'Emma Rodriguez',
        vehicle: 'Honda Civic 2020',
        issue: 'Theft Recovery',
        amount: '\$8,200',
        status: 'Under Review',
        priority: 'Emergency',
        daysAgo: '5 hours ago',
        statusColor: Colors.blue,
        fraudRisk: 'High',
        documents: 5,
        messages: 12,
        location: 'Highway I-95',
        policyNo: 'POL-2024-0321',
      ),
      Claim(
        id: 'CL-2024-0010',
        customerName: 'James Wilson',
        vehicle: 'Ford F-150',
        issue: 'Engine Failure',
        amount: '\$3,150',
        status: 'Approved',
        priority: 'Medium',
        daysAgo: '1 day ago',
        statusColor: Colors.green,
        fraudRisk: 'Low',
        documents: 4,
        messages: 8,
        location: 'Central Park Area',
        policyNo: 'POL-2024-0789',
      ),
      Claim(
        id: 'CL-2024-0009',
        customerName: 'Lisa Anderson',
        vehicle: 'BMW X5 2022',
        issue: 'Vandalism',
        amount: '\$1,850',
        status: 'Rejected',
        priority: 'Low',
        daysAgo: '2 days ago',
        statusColor: Colors.red,
        fraudRisk: 'Medium',
        documents: 2,
        messages: 3,
        location: 'Business District',
        policyNo: 'POL-2024-0567',
      ),
    ]);

    // Sample activities
    _activities.addAll([
      Activity('Claim Approved', 'CL-2024-0009 approved by Sarah Chen', '2 hours ago', Icons.check_circle, Colors.green),
      Activity('Document Uploaded', 'James Wilson uploaded repair invoice', '4 hours ago', Icons.upload, Colors.blue),
      Activity('New Claim Filed', 'Emma Rodriguez filed theft claim', '6 hours ago', Icons.add_circle, Colors.orange),
      Activity('Payment Processed', '\$3,150 paid to AutoCare Garage', '1 day ago', Icons.payment, Colors.green),
      Activity('Fraud Flagged', 'AI detected suspicious pattern in CL-2024-0011', '1 day ago', Icons.warning, Colors.red),
      Activity('Policy Renewed', 'POL-2024-0456 renewed for Michael Chen', '2 days ago', Icons.autorenew, Colors.purple),
    ]);

    // Sample policies
    _policies.addAll([
      Policy('POL-2024-0456', 'Michael Chen', 'Toyota Camry 2021', 'Comprehensive', '\$1,200/yr', '2024-12-31', true),
      Policy('POL-2024-0321', 'Emma Rodriguez', 'Honda Civic 2020', 'Third Party', '\$850/yr', '2024-11-15', true),
      Policy('POL-2024-0789', 'James Wilson', 'Ford F-150', 'Comprehensive', '\$1,500/yr', '2024-10-20', false),
      Policy('POL-2024-0567', 'Lisa Anderson', 'BMW X5 2022', 'Full Coverage', '\$2,100/yr', '2024-09-30', true),
    ]);

    // Sample analytics data
    _analyticsData.addAll({
      'totalClaims': 156,
      'pendingClaims': 12,
      'approvedClaims': 125,
      'rejectedClaims': 19,
      'totalPayouts': 84200,
      'approvalRate': 92,
      'aiAccuracy': 98,
      'avgProcessingTime': 2.4,
      'customerSatisfaction': 4.8,
      'revenue': 245000,
      'activePolicies': 89,
      'renewalRate': 87,
    });
  }

  void _initializeQuickActions() {
    _quickActions.addAll([
      {'title': 'New Claim', 'icon': Icons.add_circle, 'color': Color.fromRGBO(126, 87, 194, 1), 'action': _createNewClaim},
      {'title': 'Quick Approve', 'icon': Icons.bolt, 'color': Color.fromRGBO(76, 175, 80, 1), 'action': _quickApprove},
      {'title': 'Fraud Scan', 'icon': Icons.security, 'color': Color.fromRGBO(255, 160, 0, 1), 'action': _runFraudScan},
      {'title': 'Export Report', 'icon': Icons.download, 'color': Color.fromRGBO(33, 150, 243, 1), 'action': _exportReport},
      {'title': 'Customer Chat', 'icon': Icons.chat, 'color': Color.fromRGBO(156, 39, 176, 1), 'action': _openCustomerChat},
      {'title': 'Policy Review', 'icon': Icons.policy, 'color': Color.fromRGBO(244, 67, 54, 1), 'action': _reviewPolicies},
    ]);
  }

  List<Claim> get _filteredClaims {
    var filtered = _allClaims;
    
    if (_selectedFilter != 'All') {
      filtered = filtered.where((claim) => 
        claim.status == _selectedFilter || claim.priority == _selectedFilter
      ).toList();
    }
    
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((claim) =>
        claim.id.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        claim.customerName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        claim.vehicle.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        claim.policyNo.toLowerCase().contains(_searchQuery.toLowerCase())
      ).toList();
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.width > 768;
    
    return Scaffold(
      backgroundColor: _darkMode ? Color(0xFF121212) : Color(0xFFF8F9FD),
      appBar: _buildAppBar(isLargeScreen),
      body: _buildCurrentScreen(isLargeScreen),
      bottomNavigationBar: isLargeScreen ? null : _buildBottomNavBar(),
      floatingActionButton: _currentIndex == 1 ? _buildFloatingActionButton() : null,
      drawer: isLargeScreen ? null : _buildDrawer(),
    );
  }

  AppBar _buildAppBar(bool isLargeScreen) {
    return AppBar(
      title: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Color(0xFF7E57C2), Color(0xFF5E35B1)]),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.security, color: Colors.white, size: 20),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Insurance', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 10)),
             // Text('Insurance Dashboard', style: TextStyle(color: Color(0xFF666666), fontSize: 12)),
            ],
          ),
        ],
      ),
      actions: [
        if (isLargeScreen) ..._buildDesktopNavItems(),
        _buildNotificationButton(),
        _buildAIStatusButton(),
        _buildThemeToggle(),
        _buildProfileButton(),
      ],
    );
  }

  List<Widget> _buildDesktopNavItems() {
    return [
      _buildNavItem('Dashboard', 0),
      _buildNavItem('Claims', 1),
      _buildNavItem('Analytics', 2),
      _buildNavItem('Policies', 3),
      _buildNavItem('Settings', 4),
    ];
  }

  Widget _buildNavItem(String title, int index) {
    return TextButton(
      onPressed: () => setState(() => _currentIndex = index),
      child: Text(
        title,
        style: TextStyle(
          color: _currentIndex == index ? Color(0xFF7E57C2) : Color(0xFF666666),
          fontWeight: _currentIndex == index ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildNotificationButton() {
    return Stack(
      children: [
        IconButton(
          icon: Icon(Icons.notifications_none, color: Color(0xFF666666)),
          onPressed: _showNotifications,
        ),
        Positioned(
          right: 8, top: 8,
          child: Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle)),
        ),
      ],
    );
  }

  Widget _buildAIStatusButton() {
    return IconButton(
      icon: Icon(_isAIEnabled ? Icons.auto_awesome : Icons.block, 
                color: _isAIEnabled ? Color(0xFF7E57C2) : Color(0xFF999999)),
      onPressed: _toggleAI,
      tooltip: 'AI Assistant ${_isAIEnabled ? 'Enabled' : 'Disabled'}',
    );
  }

  Widget _buildThemeToggle() {
    return IconButton(
      icon: Icon(_darkMode ? Icons.light_mode : Icons.dark_mode),
      onPressed: _toggleTheme,
      tooltip: 'Toggle Theme',
    );
  }

  Widget _buildProfileButton() {
    return Padding(
      padding: EdgeInsets.only(right: 8),
      child: PopupMenuButton<String>(
        icon: CircleAvatar(
          radius: 16,
          backgroundColor: Color(0xFF7E57C2).withOpacity(0.1),
          child: Icon(Icons.person, color: Color(0xFF7E57C2), size: 16),
        ),
        onSelected: _handleProfileAction,
        itemBuilder: (context) => [
          PopupMenuItem(value: 'profile', child: Text('My Profile')),
          PopupMenuItem(value: 'settings', child: Text('Settings')),
          PopupMenuItem(value: 'logout', child: Text('Logout')),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildDrawerHeader(),
          _buildDrawerItem(Icons.dashboard, 'Dashboard', () => _changeScreen(0)),
          _buildDrawerItem(Icons.assignment, 'Claims Management', () => _changeScreen(1)),
          _buildDrawerItem(Icons.analytics, 'Analytics', () => _changeScreen(2)),
          _buildDrawerItem(Icons.policy, 'Policy Management', () => _changeScreen(3)),
          _buildDrawerItem(Icons.attach_money, 'Financial Reports', _showFinancialReports),
          _buildDrawerItem(Icons.people, 'Customer Portal', _showCustomerPortal),
          _buildDrawerItem(Icons.security, 'Fraud Detection', _showFraudDetection),
          _buildDrawerItem(Icons.settings, 'Settings', () => _changeScreen(4)),
          Divider(),
          _buildDrawerItem(Icons.help, 'Help & Support', _showHelp),
          _buildDrawerItem(Icons.info, 'About', _showAbout),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return DrawerHeader(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Color(0xFF7E57C2), Color(0xFF5E35B1)]),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white.withOpacity(0.2),
            child: Icon(Icons.person, color: Colors.white, size: 30),
          ),
          SizedBox(height: 12),
          Text('Sarah Chen', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
          Text('Senior Claims Agent', style: TextStyle(color: Colors.white70, fontSize: 12)),
          SizedBox(height: 8),
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          //   decoration: BoxDecoration(
          //     color: Colors.white.withOpacity(0.2),
          //     borderRadius: BorderRadius.circular(12),
          //   ),
          //   child: Text('Premium User', style: TextStyle(color: Colors.white, fontSize: 10)),
          // ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Color(0xFF7E57C2)),
      title: Text(title),
      onTap: onTap,
    );
  }

  Widget _buildCurrentScreen(bool isLargeScreen) {
    switch (_currentIndex) {
      case 0: return _buildDashboard(isLargeScreen);
      case 1: return _buildClaimsManagement(isLargeScreen);
      case 2: return _buildAnalytics(isLargeScreen);
      case 3: return _buildPolicies(isLargeScreen);
      case 4: return _buildSettings(isLargeScreen);
      default: return _buildDashboard(isLargeScreen);
    }
  }

  Widget _buildDashboard(bool isLargeScreen) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          _buildWelcomeCard(),
          SizedBox(height: 20),
          _buildQuickStats(isLargeScreen),
          SizedBox(height: 20),
          _buildQuickActionsGrid(),
          SizedBox(height: 20),
          _buildAIInsights(),
          if (isLargeScreen) SizedBox(height: 20),
          if (isLargeScreen) _buildOverviewGrid(),
          SizedBox(height: 20),
          _buildClaimsSection(),
          SizedBox(height: 20),
          _buildRecentActivities(),
        ],
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Color(0xFF7E57C2), Color(0xFF5E35B1)]),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Color(0xFF7E57C2).withOpacity(0.3), blurRadius: 20, offset: Offset(0, 6))],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Welcome back, Sarah!', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600)),
                SizedBox(height: 8),
                Text('You have ${_analyticsData['pendingClaims']} pending claims that need your attention today.', 
                     style: TextStyle(color: Colors.white70, fontSize: 16)),
                SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildMetricChip('AI Active', Icons.auto_awesome),
                    _buildMetricChip('${_analyticsData['aiAccuracy']}% Accuracy', Icons.verified),
                    _buildMetricChip('${_analyticsData['activePolicies']} Policies', Icons.policy),
                    _buildMetricChip('\$${(_analyticsData['revenue']/1000).toStringAsFixed(0)}K Revenue', Icons.attach_money),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: 100, height: 100,
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
            child: Icon(Icons.analytics, color: Colors.white, size: 50),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricChip(String text, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, color: Colors.white, size: 14),
        SizedBox(width: 6),
        Text(text, style: TextStyle(color: Colors.white, fontSize: 12)),
      ]),
    );
  }

  Widget _buildQuickStats(bool isLargeScreen) {
    final crossAxisCount = isLargeScreen ? 4 : 2;
    
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.2,
      children: [
        _buildStatCard('Total Claims', _analyticsData['totalClaims'].toString(), Icons.assignment, Color(0xFF7E57C2), '+12%', _showAllClaims),
        _buildStatCard('Pending', _analyticsData['pendingClaims'].toString(), Icons.pending_actions, Color(0xFFFFA000), '+5%', _showPendingClaims),
        _buildStatCard('Approved', _analyticsData['approvedClaims'].toString(), Icons.thumb_up, Color(0xFF4CAF50), '+8%', _showApprovedClaims),
        _buildStatCard('Revenue', '\$${(_analyticsData['revenue']/1000).toStringAsFixed(0)}K', Icons.attach_money, Color(0xFF9C27B0), '+15%', _showFinancialReport),
        if (isLargeScreen) _buildStatCard('Payouts', '\$${(_analyticsData['totalPayouts']/1000).toStringAsFixed(1)}K', Icons.payment, Color(0xFF2196F3), '-3%', _showPayouts),
        if (isLargeScreen) _buildStatCard('Satisfaction', '${_analyticsData['customerSatisfaction']}/5', Icons.star, Color(0xFFFFC107), '+2%', _showSatisfaction),
        if (isLargeScreen) _buildStatCard('Processing Time', '${_analyticsData['avgProcessingTime']} days', Icons.timer, Color(0xFF00BCD4), '-12%', _showProcessingTime),
        if (isLargeScreen) _buildStatCard('Renewal Rate', '${_analyticsData['renewalRate']}%', Icons.autorenew, Color(0xFFE91E63), '+5%', _showRenewalRate),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color, String change, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 3))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                  child: Icon(icon, color: color, size: 20),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: change.contains('+') ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        change.contains('+') ? Icons.trending_up : Icons.trending_down,
                        size: 12,
                        color: change.contains('+') ? Colors.green : Colors.red,
                      ),
                      SizedBox(width: 2),
                      Text(
                        change,
                        style: TextStyle(
                          color: change.contains('+') ? Colors.green : Colors.red,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF333333))),
                SizedBox(height: 4),
                Text(title, style: TextStyle(color: Color(0xFF666666), fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionsGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Quick Actions', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xFF333333))),
        SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.2,
          children: _quickActions.map((action) => _buildQuickActionItem(action)).toList(),
        ),
      ],
    );
  }

  Widget _buildQuickActionItem(Map<String, dynamic> action) {
    return GestureDetector(
      onTap: action['action'],
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2))],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: action['color'].withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(action['icon'], color: action['color'], size: 24),
            ),
            SizedBox(height: 8),
            Text(
              action['title'],
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFF333333)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAIInsights() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 3))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(Icons.auto_awesome, color: Color(0xFF7E57C2)),
            SizedBox(width: 8),
            Text('AI Insights & Predictions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            Spacer(),
            Switch(value: _isAIEnabled, onChanged: (value) => setState(() => _isAIEnabled = value), activeColor: Color(0xFF7E57C2)),
          ]),
          SizedBox(height: 16),
          _buildAIPredictionItem('Fraud Risk Alert', '3 claims flagged for manual review', Icons.warning, Colors.orange, _reviewFraudCases),
          _buildAIPredictionItem('High Payout Prediction', '2 claims exceeding \$5,000 estimated', Icons.trending_up, Colors.red, _reviewHighPayouts),
          _buildAIPredictionItem('Quick Approvals', '8 claims ready for instant approval', Icons.bolt, Colors.green, _quickApproveAll),
          _buildAIPredictionItem('Policy Renewals', '12 policies expiring this week', Icons.autorenew, Colors.purple, _reviewRenewals),
        ],
      ),
    );
  }

  Widget _buildAIPredictionItem(String title, String subtitle, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Row(children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 16),
          ),
          SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
            Text(subtitle, style: TextStyle(color: Color(0xFF666666), fontSize: 12)),
          ])),
          Icon(Icons.chevron_right, color: Color(0xFF999999)),
        ]),
      ),
    );
  }

  Widget _buildOverviewGrid() {
    return Row(
      children: [
        Expanded(
          child: _buildOverviewCard('Claim Distribution', [
            {'label': 'Auto', 'value': '65%', 'color': Color(0xFFFFA000)},
            {'label': 'Theft', 'value': '25%', 'color': Color(0xFF2196F3)},
            {'label': 'Other', 'value': '10%', 'color': Color(0xFF4CAF50)},
          ], Icons.pie_chart),
        ),
        SizedBox(width: 16),
        Expanded(
          child: _buildOverviewCard('Performance Metrics', [
            {'label': 'Approval Rate', 'value': '92%', 'color': Color(0xFF4CAF50)},
            {'label': 'Avg Processing', 'value': '2.4 days', 'color': Color(0xFF2196F3)},
            {'label': 'Satisfaction', 'value': '4.8/5', 'color': Color(0xFFFFC107)},
          ], Icons.analytics),
        ),
      ],
    );
  }

  Widget _buildOverviewCard(String title, List<Map<String, dynamic>> metrics, IconData icon) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(icon, color: Color(0xFF7E57C2), size: 20),
            SizedBox(width: 8),
            Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
          ]),
          SizedBox(height: 16),
          ...metrics.map((metric) => Padding(
            padding: EdgeInsets.symmetric(vertical: 6),
            child: Row(children: [
              Container(width: 8, height: 8, decoration: BoxDecoration(color: metric['color'], shape: BoxShape.circle)),
              SizedBox(width: 12),
              Expanded(child: Text(metric['label'], style: TextStyle(fontSize: 14))),
              Text(metric['value'], style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
            ]),
          )),
        ],
      ),
    );
  }

  // ... (Previous _buildClaimsSection, _buildClaimCard, and other methods remain similar but enhanced)

  Widget _buildClaimsSection() {
    final recentClaims = _allClaims.take(3).toList();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Recent Claims', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
          PopupMenuButton<String>(
            icon: Icon(Icons.filter_list, color: Color(0xFF7E57C2)),
            onSelected: (value) => setState(() => _selectedFilter = value),
            itemBuilder: (context) => _filters.map((filter) => PopupMenuItem(value: filter, child: Text(filter))).toList(),
          ),
        ]),
        SizedBox(height: 16),
        ...recentClaims.map((claim) => _buildClaimCard(claim)),
        SizedBox(height: 16),
        Center(
          child: TextButton.icon(
            onPressed: _showAllClaims,
            icon: Icon(Icons.list_alt),
            label: Text('View All Claims'),
            style: TextButton.styleFrom(foregroundColor: Color(0xFF7E57C2)),
          ),
        ),
      ],
    );
  }

  Widget _buildClaimCard(Claim claim) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3))],
      ),
      child: Column(children: [
        // Header with fraud risk
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFF7E57C2).withOpacity(0.05),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
          ),
          child: Row(children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(color: Color(0xFF7E57C2).withOpacity(0.1), shape: BoxShape.circle),
              child: Icon(Icons.assignment, color: Color(0xFF7E57C2), size: 16),
            ),
            SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(claim.id, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
              Text(claim.customerName, style: TextStyle(color: Color(0xFF666666), fontSize: 12)),
              SizedBox(height: 4),
              Text(claim.policyNo, style: TextStyle(color: Color(0xFF999999), fontSize: 10)),
            ])),
            if (claim.fraudRisk == 'High') _buildRiskBadge(),
            _buildStatusBadge(claim.status, claim.statusColor),
          ]),
        ),
        
        // Content
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _buildDetailRow(Icons.directions_car, claim.vehicle, true),
            SizedBox(height: 8),
            _buildDetailRow(Icons.build, claim.issue, false),
            SizedBox(height: 8),
            _buildDetailRow(Icons.location_on, claim.location, false),
            SizedBox(height: 12),
            Row(children: [
              _buildDetailChip('${claim.documents} Docs', Icons.description),
              SizedBox(width: 8),
              _buildDetailChip('${claim.messages} Msgs', Icons.chat),
              Spacer(),
              _buildPriorityBadge(claim.priority),
              SizedBox(width: 8),
              Icon(Icons.access_time, size: 12, color: Color(0xFF666666)),
              SizedBox(width: 4),
              Text(claim.daysAgo, style: TextStyle(fontSize: 11, color: Color(0xFF666666))),
            ]),
            SizedBox(height: 16),
            Row(children: [
              _buildActionButton('View Details', Icons.visibility, () => _viewClaimDetails(claim), false),
              SizedBox(width: 8),
              _buildActionButton('Chat', Icons.chat, () => _openChat(claim), false),
              SizedBox(width: 8),
              _buildActionButton('Approve', Icons.thumb_up, () => _approveClaim(claim), true),
            ]),
          ]),
        ),
      ]),
    );
  }

  // ... (Previous helper methods remain the same)

  Widget _buildRiskBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: Colors.red.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
      child: Row(children: [
        Icon(Icons.warning, color: Colors.red, size: 12),
        SizedBox(width: 4),
        Text('High Risk', style: TextStyle(color: Colors.red, fontSize: 10, fontWeight: FontWeight.w500)),
      ]),
    );
  }

  Widget _buildStatusBadge(String status, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
      child: Text(status, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildPriorityBadge(String priority) {
    Color color = priority == 'Emergency' ? Colors.red : 
                 priority == 'High' ? Colors.orange : Colors.blue;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
      child: Text(priority, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildDetailRow(IconData icon, String text, bool isBold) {
    return Row(children: [
      Icon(icon, color: Color(0xFF7E57C2), size: 16),
      SizedBox(width: 8),
      Expanded(child: Text(text, style: TextStyle(fontWeight: isBold ? FontWeight.w500 : FontWeight.normal))),
    ]);
  }

  Widget _buildDetailChip(String text, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: Color(0xFFF5F5F7), borderRadius: BorderRadius.circular(6)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 12, color: Color(0xFF666666)),
        SizedBox(width: 4),
        Text(text, style: TextStyle(fontSize: 10, color: Color(0xFF666666))),
      ]),
    );
  }

  Widget _buildActionButton(String text, IconData icon, VoidCallback onTap, bool isPrimary) {
    return Expanded(
      child: isPrimary 
          ? ElevatedButton.icon(
              icon: Icon(icon, size: 16),
              label: Text(text),
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF7E57C2),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 8),
              ),
            )
          : OutlinedButton.icon(
              icon: Icon(icon, size: 16),
              label: Text(text),
              onPressed: onTap,
              style: OutlinedButton.styleFrom(
                foregroundColor: Color(0xFF7E57C2),
                padding: EdgeInsets.symmetric(vertical: 8),
              ),
            ),
    );
  }

  Widget _buildRecentActivities() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 3))],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Recent Activities', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
          TextButton(onPressed: _showAllActivities, child: Text('View All', style: TextStyle(color: Color(0xFF7E57C2), fontWeight: FontWeight.w500))),
        ]),
        SizedBox(height: 16),
        ..._activities.map((activity) => _buildActivityItem(activity)),
      ]),
    );
  }

  Widget _buildActivityItem(Activity activity) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(color: Color(0xFFF5F5F7), borderRadius: BorderRadius.circular(12)),
      child: Row(children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(color: activity.color.withOpacity(0.1), shape: BoxShape.circle),
          child: Icon(activity.icon, color: activity.color, size: 16),
        ),
        SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(activity.title, style: TextStyle(fontWeight: FontWeight.w500)),
          Text(activity.description, style: TextStyle(color: Color(0xFF666666), fontSize: 12)),
        ])),
        Text(activity.time, style: TextStyle(color: Color(0xFF999999), fontSize: 11)),
      ]),
    );
  }

  Widget _buildClaimsManagement(bool isLargeScreen) {
    return Column(children: [
      _buildClaimsHeader(),
      Expanded(child: _buildClaimsList()),
    ]);
  }

  Widget _buildClaimsHeader() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))]),
      child: Row(children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search claims by ID, customer, vehicle, or policy...',
              prefixIcon: Icon(Icons.search, color: Color(0xFF666666)),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              filled: true,
              fillColor: Color(0xFFF5F5F7),
            ),
            onChanged: (value) => setState(() => _searchQuery = value),
          ),
        ),
        SizedBox(width: 12),
        PopupMenuButton<String>(
          icon: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Color(0xFF7E57C2).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(children: [
              Text(_selectedFilter, style: TextStyle(color: Color(0xFF7E57C2))),
              SizedBox(width: 4),
              Icon(Icons.arrow_drop_down, size: 16, color: Color(0xFF7E57C2)),
            ]),
          ),
          onSelected: (value) => setState(() => _selectedFilter = value),
          itemBuilder: (context) => _filters.map((filter) => PopupMenuItem(value: filter, child: Text(filter))).toList(),
        ),
      ]),
    );
  }

  Widget _buildClaimsList() {
    if (_filteredClaims.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 80, color: Color(0xFFCCCCCC)),
            SizedBox(height: 16),
            Text('No claims found', style: TextStyle(fontSize: 18, color: Color(0xFF666666))),
            SizedBox(height: 8),
            Text('Try adjusting your search or filter criteria', style: TextStyle(color: Color(0xFF999999))),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: _filteredClaims.length,
      itemBuilder: (context, index) => _buildClaimCard(_filteredClaims[index]),
    );
  }

  Widget _buildAnalytics(bool isLargeScreen) {
    return AnalyticsPage(); // Using the separate analytics page
  }

  Widget _buildPolicies(bool isLargeScreen) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Policy Management', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          _buildPoliciesOverview(),
          SizedBox(height: 20),
          ..._policies.map((policy) => _buildPolicyCard(policy)),
        ],
      ),
    );
  }

  Widget _buildPoliciesOverview() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildPolicyStat('Active', '${_analyticsData['activePolicies']}', Icons.check_circle, Colors.green),
          _buildPolicyStat('Expiring', '12', Icons.warning, Colors.orange),
          _buildPolicyStat('Renewal Rate', '${_analyticsData['renewalRate']}%', Icons.autorenew, Colors.purple),
          _buildPolicyStat('Total Revenue', '\$${(_analyticsData['revenue']/1000).toStringAsFixed(0)}K', Icons.attach_money, Colors.blue),
        ],
      ),
    );
  }

  Widget _buildPolicyStat(String title, String value, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
          child: Icon(icon, color: color, size: 24),
        ),
        SizedBox(height: 8),
        Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(title, style: TextStyle(color: Color(0xFF666666), fontSize: 12)),
      ],
    );
  }

  Widget _buildPolicyCard(Policy policy) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Color(0xFF7E57C2).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.policy, color: Color(0xFF7E57C2)),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(policy.policyNo, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text('${policy.customerName} • ${policy.vehicle}', style: TextStyle(color: Color(0xFF666666))),
                SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: policy.isActive ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        policy.isActive ? 'Active' : 'Expired',
                        style: TextStyle(
                          color: policy.isActive ? Colors.green : Colors.red,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(policy.type, style: TextStyle(fontSize: 12, color: Color(0xFF666666))),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(policy.premium, style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF333333))),
              Text('Expires: ${policy.expiryDate}', style: TextStyle(fontSize: 12, color: Color(0xFF666666))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettings(bool isLargeScreen) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Settings', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          _buildSettingsSection('Account Settings', [
            _buildSettingsItem('Profile Information', Icons.person, 'Update your personal details'),
            _buildSettingsItem('Security & Privacy', Icons.security, 'Manage password and privacy settings'),
            _buildSettingsItem('Notification Preferences', Icons.notifications, 'Configure how you receive alerts'),
          ]),
          SizedBox(height: 24),
          _buildSettingsSection('App Settings', [
            _buildSettingsItem('Theme & Appearance', Icons.palette, 'Customize the app look and feel'),
            _buildSettingsItem('Language & Region', Icons.language, 'Set your preferred language'),
            _buildSettingsItem('Data & Storage', Icons.storage, 'Manage cache and data usage'),
          ]),
          SizedBox(height: 24),
          _buildSettingsSection('Preferences', [
            _buildSettingsItem('Workflow Settings', Icons.work, 'Customize your workflow preferences'),
            _buildSettingsItem('Auto-Approval Rules', Icons.auto_awesome, 'Set up automatic claim approval'),
            _buildSettingsItem('Reporting Preferences', Icons.analytics, 'Configure report formats and schedules'),
          ]),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF333333))),
        SizedBox(height: 12),
        ...items,
      ],
    );
  }

  Widget _buildSettingsItem(String title, IconData icon, String subtitle) {
    return Card(
      margin: EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: Color(0xFF7E57C2)),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text(subtitle),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () => _showSettingsDetail(title),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 15, offset: Offset(0, -4))],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Color(0xFF7E57C2),
          unselectedItemColor: Color(0xFF999999),
          selectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          unselectedLabelStyle: TextStyle(fontSize: 12),
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
            BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Claims'),
            BottomNavigationBarItem(icon: Icon(Icons.analytics), label: 'Analytics'),
            BottomNavigationBarItem(icon: Icon(Icons.policy), label: 'Policies'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      backgroundColor: Color(0xFF7E57C2),
      onPressed: _createNewClaim,
      child: Icon(Icons.add, color: Colors.white),
      tooltip: 'Create New Claim',
    );
  }

  // Enhanced functionality methods
  void _showNotifications() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(children: [
          Icon(Icons.notifications, color: Color(0xFF7E57C2)),
          SizedBox(width: 8),
          Text('Notifications'),
        ]),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildNotificationItem('New claim requires review', 'CL-2024-0012', '2 min ago', Icons.assignment, Colors.orange),
            _buildNotificationItem('Payment processed successfully', '\$3,150 to AutoCare', '1 hour ago', Icons.payment, Colors.green),
            _buildNotificationItem('System maintenance scheduled', 'Tonight 2-4 AM', '3 hours ago', Icons.build, Colors.blue),
            _buildNotificationItem('Policy renewal reminder', 'POL-2024-0321 expires soon', '5 hours ago', Icons.autorenew, Colors.purple),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Mark All Read')),
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Close')),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(String title, String subtitle, String time, IconData icon, Color color) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Text(time, style: TextStyle(fontSize: 12, color: Color(0xFF999999))),
      onTap: () {},
    );
  }

  void _toggleAI() {
    setState(() => _isAIEnabled = !_isAIEnabled);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('AI Assistant ${_isAIEnabled ? 'enabled' : 'disabled'}'),
        backgroundColor: _isAIEnabled ? Colors.green : Colors.orange,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _toggleTheme() {
    setState(() => _darkMode = !_darkMode);
  }

  void _handleProfileAction(String value) {
    switch (value) {
      case 'profile': _showProfile(); break;
      case 'settings': _changeScreen(4); break;
      case 'logout': _logout(); break;
    }
  }

  void _viewClaimDetails(Claim claim) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildClaimDetailsSheet(claim),
    );
  }

  Widget _buildClaimDetailsSheet(Claim claim) {
    return Container(
      padding: EdgeInsets.all(24),
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Claim Details', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            IconButton(icon: Icon(Icons.close), onPressed: () => Navigator.pop(context)),
          ]),
          SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                _buildDetailSection('Basic Information', [
                  _buildDetailRow2('Claim ID', claim.id),
                  _buildDetailRow2('Policy Number', claim.policyNo),
                  _buildDetailRow2('Customer', claim.customerName),
                  _buildDetailRow2('Vehicle', claim.vehicle),
                  _buildDetailRow2('Location', claim.location),
                ]),
                SizedBox(height: 20),
                _buildDetailSection('Claim Details', [
                  _buildDetailRow2('Issue', claim.issue),
                  _buildDetailRow2('Amount', claim.amount),
                  _buildDetailRow2('Status', claim.status),
                  _buildDetailRow2('Priority', claim.priority),
                  _buildDetailRow2('Fraud Risk', claim.fraudRisk),
                ]),
                SizedBox(height: 20),
                _buildDetailSection('Documents & Communication', [
                  _buildDetailRow2('Documents', '${claim.documents} files'),
                  _buildDetailRow2('Messages', '${claim.messages} conversations'),
                ]),
                SizedBox(height: 20),
                _buildActionSection(),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF7E57C2))),
        SizedBox(height: 12),
        ...children,
      ],
    );
  }

  Widget _buildDetailRow2(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(children: [
        Expanded(flex: 2, child: Text('$label:', style: TextStyle(fontWeight: FontWeight.w500, color: Color(0xFF666666)))),
        Expanded(flex: 3, child: Text(value, style: TextStyle(color: Color(0xFF333333)))),
      ]),
    );
  }

  Widget _buildActionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF7E57C2))),
        SizedBox(height: 12),
        Row(children: [
          Expanded(
            child: ElevatedButton.icon(
              icon: Icon(Icons.thumb_up),
              label: Text('Approve Claim'),
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: OutlinedButton.icon(
              icon: Icon(Icons.close),
              label: Text('Reject'),
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                padding: EdgeInsets.symmetric(vertical: 12),
                side: BorderSide(color: Colors.red),
              ),
            ),
          ),
        ]),
        SizedBox(height: 8),
        Row(children: [
          Expanded(
            child: OutlinedButton.icon(
              icon: Icon(Icons.chat),
              label: Text('Contact Customer'),
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: Color(0xFF7E57C2),
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: OutlinedButton.icon(
              icon: Icon(Icons.download),
              label: Text('Export'),
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: Color(0xFF7E57C2),
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ]),
      ],
    );
  }

  void _openChat(Claim claim) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening chat with ${claim.customerName}'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _approveClaim(Claim claim) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Approve Claim'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle, size: 48, color: Colors.green),
            SizedBox(height: 16),
            Text('Are you sure you want to approve this claim?', textAlign: TextAlign.center),
            SizedBox(height: 8),
            Text('${claim.id} - ${claim.amount}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                claim.status = 'Approved';
                claim.statusColor = Colors.green;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Claim ${claim.id} approved successfully'),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF7E57C2)),
            child: Text('Approve'),
          ),
        ],
      ),
    );
  }

  void _createNewClaim() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => _buildNewClaimSheet(),
    );
  }

  Widget _buildNewClaimSheet() {
    return Container(
      padding: EdgeInsets.all(24),
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Create New Claim', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            IconButton(icon: Icon(Icons.close), onPressed: () => Navigator.pop(context)),
          ]),
          SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Column(children: [
                _buildFormField('Customer Name', Icons.person),
                _buildFormField('Policy Number', Icons.policy),
                _buildFormField('Vehicle Details', Icons.directions_car),
                _buildFormField('Incident Location', Icons.location_on),
                _buildFormField('Claim Amount', Icons.attach_money),
                _buildFormField('Incident Description', Icons.description, maxLines: 3),
                SizedBox(height: 20),
                _buildFileUpload(),
                SizedBox(height: 20),
                Row(children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('New claim created successfully'), backgroundColor: Colors.green),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF7E57C2),
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text('Create Claim'),
                    ),
                  ),
                ]),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormField(String label, IconData icon, {int maxLines = 1}) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Color(0xFF7E57C2)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Color(0xFFF8F9FD),
        ),
        maxLines: maxLines,
      ),
    );
  }

  Widget _buildFileUpload() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFE0E0E0)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(Icons.cloud_upload, size: 48, color: Color(0xFF7E57C2)),
          SizedBox(height: 8),
          Text('Upload Supporting Documents', style: TextStyle(fontWeight: FontWeight.w500)),
          SizedBox(height: 8),
          Text('Photos, police reports, repair estimates, etc.', style: TextStyle(color: Color(0xFF666666), fontSize: 12)),
          SizedBox(height: 12),
          OutlinedButton.icon(
            icon: Icon(Icons.attach_file),
            label: Text('Choose Files'),
            onPressed: () {},
            style: OutlinedButton.styleFrom(foregroundColor: Color(0xFF7E57C2)),
          ),
        ],
      ),
    );
  }

  // Quick Actions
  void _quickApprove() => _showMessage('Quick Approval Mode Activated');
  void _runFraudScan() => _showMessage('Running Fraud Detection Scan...');
  void _exportReport() => _showMessage('Exporting Report...');
  void _openCustomerChat() => _showMessage('Opening Customer Chat Portal');
  void _reviewPolicies() => _changeScreen(3);
  void _reviewFraudCases() => _showMessage('Reviewing Fraud Cases');
  void _reviewHighPayouts() => _showMessage('Reviewing High Payout Claims');
  void _quickApproveAll() => _showMessage('Quick Approving All Eligible Claims');
  void _reviewRenewals() => _showMessage('Reviewing Policy Renewals');

  void _changeScreen(int index) {
    setState(() => _currentIndex = index);
    if (Navigator.canPop(context)) {
      Navigator.pop(context); // Close drawer if open
    }
  }

  void _showSettingsDetail(String title) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text('Settings for $title will be implemented here.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Close')),
        ],
      ),
    );
  }

  // Placeholder methods
  void _showAllClaims() => _showMessage('Showing all claims');
  void _showPendingClaims() => _showMessage('Showing pending claims');
  void _showApprovedClaims() => _showMessage('Showing approved claims');
  void _showFinancialReport() => _showMessage('Showing financial report');
  void _showPayouts() => _showMessage('Showing payout analytics');
  void _showSatisfaction() => _showMessage('Showing customer satisfaction');
  void _showProcessingTime() => _showMessage('Showing processing time analytics');
  void _showRenewalRate() => _showMessage('Showing renewal rate analytics');
  void _showPolicyManagement() => _changeScreen(3);
  void _showFinancialReports() => _showMessage('Financial Reports');
  void _showCustomerPortal() => _showMessage('Customer Portal');
  void _showFraudDetection() => _showMessage('Fraud Detection');
  void _showHelp() => _showMessage('Help & Support');
  void _showAbout() => _showMessage('About InsurePro');
  void _showProfile() => _showMessage('My Profile');
  void _logout() => _showMessage('Logging out...');
  void _showAllActivities() => _showMessage('Showing all activities');

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

// Data Models
class Claim {
  String id;
  String customerName;
  String vehicle;
  String issue;
  String amount;
  String status;
  String priority;
  String daysAgo;
  Color statusColor;
  String fraudRisk;
  int documents;
  int messages;
  String location;
  String policyNo;

  Claim({
    required this.id,
    required this.customerName,
    required this.vehicle,
    required this.issue,
    required this.amount,
    required this.status,
    required this.priority,
    required this.daysAgo,
    required this.statusColor,
    required this.fraudRisk,
    required this.documents,
    required this.messages,
    required this.location,
    required this.policyNo,
  });
}

class Activity {
  final String title;
  final String description;
  final String time;
  final IconData icon;
  final Color color;

  Activity(this.title, this.description, this.time, this.icon, this.color);
}

class Policy {
  final String policyNo;
  final String customerName;
  final String vehicle;
  final String type;
  final String premium;
  final String expiryDate;
  final bool isActive;

  Policy(this.policyNo, this.customerName, this.vehicle, this.type, this.premium, this.expiryDate, this.isActive);
}

// Analytics Page (simplified version)
class AnalyticsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.analytics, size: 80, color: Color(0xFF7E57C2)),
          SizedBox(height: 16),
          Text('Advanced Analytics', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('Comprehensive insights and performance metrics', style: TextStyle(fontSize: 16, color: Color(0xFF666666))),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {},
            child: Text('Explore Analytics'),
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF7E57C2)),
          ),
        ],
      ),
    );
  }
}