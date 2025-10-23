import 'package:flutter/material.dart';

class MechanicDashboard extends StatefulWidget {
  const MechanicDashboard({super.key});

  @override
  _MechanicDashboardState createState() => _MechanicDashboardState();
}

class _MechanicDashboardState extends State<MechanicDashboard>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late TabController _tabController;

  final List<Widget> _screens = [
    DashboardHome(),
    ActiveJobsScreen(),
    ChatScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: _buildAppBar(),
      body: _screens[_currentIndex],
      bottomNavigationBar: _buildBottomNavBar(),
      floatingActionButton: _currentIndex == 1
          ? _buildFloatingActionButton()
          : null,
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xFF7E57C2).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.build, color: Color(0xFF7E57C2)),
          ),
          SizedBox(width: 12),
          Text(
            'Mechanic Pro',
            style: TextStyle(
              color: Color(0xFF333333),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.notifications_none, color: Color(0xFF666666)),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.offline_bolt, color: Colors.green),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildBottomNavBar() {
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
          selectedItemColor: Color(0xFF7E57C2),
          unselectedItemColor: Color(0xFF999999),
          selectedLabelStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: TextStyle(fontSize: 12),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment),
              label: 'Jobs',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      backgroundColor: Color(0xFF7E57C2),
      onPressed: () {},
      child: Icon(Icons.add, color: Colors.white),
    );
  }
}

class DashboardHome extends StatelessWidget {
  final List<ServiceRequest> incomingRequests = [
    ServiceRequest(
      id: 'REQ-001',
      customerName: 'John Smith',
      vehicleType: 'Toyota Camry 2020',
      issue: 'Flat Tire',
      distance: '2.1 km',
      eta: '8 min',
      status: 'New',
      priority: 'High',
    ),
    ServiceRequest(
      id: 'REQ-002',
      customerName: 'Sarah Johnson',
      vehicleType: 'Honda Civic 2019',
      issue: 'Battery Dead',
      distance: '3.4 km',
      eta: '12 min',
      status: 'New',
      priority: 'Medium',
    ),
    ServiceRequest(
      id: 'REQ-003',
      customerName: 'Mike Davis',
      vehicleType: 'Ford F-150',
      issue: 'Engine Overheating',
      distance: '5.2 km',
      eta: '15 min',
      status: 'New',
      priority: 'Emergency',
    ),
  ];

  final List<ActiveJob> activeJobs = [
    ActiveJob(
      id: 'JOB-045',
      customerName: 'Emma Wilson',
      vehicle: 'BMW X5',
      issue: 'Brake Repair',
      status: 'In Progress',
      timeElapsed: '45 min',
    ),
  ];

  DashboardHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWelcomeCard(),
          SizedBox(height: 24),
          _buildQuickStats(),
          SizedBox(height: 24),
          _buildIncomingRequests(),
          SizedBox(height: 24),
          _buildActiveJobsPreview(),
          SizedBox(height: 24),
          _buildPerformanceMetrics(),
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
          colors: [Color(0xFF7E57C2), Color(0xFF5E35B1)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF7E57C2).withOpacity(0.3),
            blurRadius: 20,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white.withOpacity(0.2),
            child: Icon(Icons.person, color: Colors.white, size: 28),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back, Alex!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Ready for today\'s service calls?',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Online - Accepting Requests',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.verified_user, color: Colors.white, size: 24),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('12', 'Today\'s Jobs', Icons.assignment_turned_in),
          _buildStatItem('\$845', 'Earnings', Icons.attach_money),
          _buildStatItem('4.8', 'Rating', Icons.star),
          _buildStatItem('98%', 'Success', Icons.thumb_up),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, IconData icon) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFF7E57C2).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Color(0xFF7E57C2), size: 20),
        ),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF333333),
          ),
        ),
        Text(label, style: TextStyle(color: Color(0xFF666666), fontSize: 12)),
      ],
    );
  }

  Widget _buildIncomingRequests() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Incoming Requests',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF333333),
              ),
            ),
            Text(
              '${incomingRequests.length} New',
              style: TextStyle(
                color: Color(0xFF7E57C2),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        ...incomingRequests.map((request) => _buildRequestCard(request)),
      ],
    );
  }

  Widget _buildRequestCard(ServiceRequest request) {
    Color priorityColor = request.priority == 'Emergency'
        ? Colors.red
        : request.priority == 'High'
        ? Colors.orange
        : Colors.blue;

    return Container(
      margin: EdgeInsets.only(bottom: 12),
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
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xFF7E57C2).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.person, color: Color(0xFF7E57C2), size: 16),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      request.customerName,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF333333),
                      ),
                    ),
                    Text(
                      request.vehicleType,
                      style: TextStyle(color: Color(0xFF666666), fontSize: 12),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: priorityColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  request.priority,
                  style: TextStyle(
                    color: priorityColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.build, color: Color(0xFF7E57C2), size: 14),
              SizedBox(width: 6),
              Text(request.issue, style: TextStyle(fontSize: 13)),
              Spacer(),
              Icon(Icons.location_on, color: Color(0xFF7E57C2), size: 14),
              SizedBox(width: 4),
              Text(request.distance, style: TextStyle(fontSize: 13)),
              SizedBox(width: 12),
              Icon(Icons.access_time, color: Color(0xFF7E57C2), size: 14),
              SizedBox(width: 4),
              Text(request.eta, style: TextStyle(fontSize: 13)),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  icon: Icon(Icons.close, size: 16),
                  label: Text('Reject'),
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: BorderSide(color: Colors.red),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  icon: Icon(Icons.check, size: 16),
                  label: Text('Accept'),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF7E57C2),
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActiveJobsPreview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Active Jobs',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF333333),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'View All',
                style: TextStyle(
                  color: Color(0xFF7E57C2),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        ...activeJobs.map((job) => _buildActiveJobCard(job)),
      ],
    );
  }

  Widget _buildActiveJobCard(ActiveJob job) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Color(0xFF7E57C2).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.directions_car, color: Color(0xFF7E57C2)),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  job.customerName,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF333333),
                  ),
                ),
                Text(
                  job.vehicle,
                  style: TextStyle(color: Color(0xFF666666), fontSize: 12),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        job.status,
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.access_time, size: 12, color: Color(0xFF666666)),
                    SizedBox(width: 4),
                    Text(
                      job.timeElapsed,
                      style: TextStyle(fontSize: 11, color: Color(0xFF666666)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward, color: Color(0xFF7E57C2)),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceMetrics() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Performance Metrics',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF333333),
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMetricItem('Response Time', '8.2 min', Icons.timer),
              _buildMetricItem('Completion Rate', '96%', Icons.check_circle),
              _buildMetricItem(
                'Customer Satisfaction',
                '4.8/5',
                Icons.sentiment_satisfied,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricItem(String title, String value, IconData icon) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(0xFF7E57C2).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Color(0xFF7E57C2), size: 18),
        ),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Color(0xFF333333),
          ),
        ),
        Text(
          title,
          style: TextStyle(color: Color(0xFF666666), fontSize: 10),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class ActiveJobsScreen extends StatefulWidget {
  const ActiveJobsScreen({super.key});

  @override
  _ActiveJobsScreenState createState() => _ActiveJobsScreenState();
}

class _ActiveJobsScreenState extends State<ActiveJobsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<ActiveJob> activeJobs = [
    ActiveJob(
      id: 'JOB-045',
      customerName: 'Emma Wilson',
      vehicle: 'BMW X5 2021',
      issue: 'Brake System Repair',
      status: 'In Progress',
      timeElapsed: '45 min',
      location: '2.1 km away',
    ),
    ActiveJob(
      id: 'JOB-044',
      customerName: 'Robert Brown',
      vehicle: 'Mercedes C-Class',
      issue: 'Oil Change',
      status: 'En Route',
      timeElapsed: '15 min',
      location: '5 min away',
    ),
  ];

  final List<CompletedJob> completedJobs = [
    CompletedJob(
      id: 'JOB-043',
      customerName: 'Lisa Anderson',
      vehicle: 'Audi Q7',
      issue: 'Tire Replacement',
      completedDate: 'Today, 10:30 AM',
      earnings: '\$120.00',
      rating: 5,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              labelColor: Color(0xFF7E57C2),
              unselectedLabelColor: Color(0xFF666666),
              indicatorColor: Color(0xFF7E57C2),
              tabs: [
                Tab(text: 'Active (2)'),
                Tab(text: 'Completed (24)'),
                Tab(text: 'Schedule (3)'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildActiveJobsTab(),
                _buildCompletedJobsTab(),
                _buildScheduledJobsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveJobsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          ...activeJobs.map((job) => _buildDetailedJobCard(job)),
          SizedBox(height: 16),
          _buildQuickActions(),
        ],
      ),
    );
  }

  Widget _buildDetailedJobCard(ActiveJob job) {
    Color statusColor = job.status == 'In Progress'
        ? Colors.orange
        : job.status == 'En Route'
        ? Colors.blue
        : Colors.green;

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFF7E57C2).withOpacity(0.05),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0xFF7E57C2).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.assignment,
                    color: Color(0xFF7E57C2),
                    size: 16,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job.id,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF333333),
                        ),
                      ),
                      Text(
                        job.customerName,
                        style: TextStyle(
                          color: Color(0xFF666666),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    job.status,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.directions_car,
                      color: Color(0xFF7E57C2),
                      size: 16,
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        job.vehicle,
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.build, color: Color(0xFF7E57C2), size: 16),
                    SizedBox(width: 8),
                    Expanded(child: Text(job.issue)),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.location_on, color: Color(0xFF7E57C2), size: 16),
                    SizedBox(width: 8),
                    Text(job.location!),
                    Spacer(),
                    Icon(Icons.access_time, color: Color(0xFF7E57C2), size: 16),
                    SizedBox(width: 4),
                    Text(job.timeElapsed),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        icon: Icon(Icons.phone, size: 16),
                        label: Text('Call'),
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Color(0xFF7E57C2),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        icon: Icon(Icons.chat, size: 16),
                        label: Text('Message'),
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Color(0xFF7E57C2),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: Icon(Icons.directions, size: 16),
                        label: Text('Navigate'),
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF7E57C2),
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Actions',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Color(0xFF333333),
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildQuickActionButton(
                  'Update Status',
                  Icons.update,
                  Color(0xFF7E57C2),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildQuickActionButton(
                  'Add Photos',
                  Icons.camera_alt,
                  Color(0xFF5E35B1),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildQuickActionButton(
                  'Generate Invoice',
                  Icons.receipt,
                  Color(0xFF9C27B0),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton(String title, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 20),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                color: Color(0xFF333333),
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompletedJobsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [...completedJobs.map((job) => _buildCompletedJobCard(job))],
      ),
    );
  }

  Widget _buildCompletedJobCard(CompletedJob job) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.check_circle, color: Colors.green),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  job.customerName,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF333333),
                  ),
                ),
                Text(
                  job.vehicle,
                  style: TextStyle(color: Color(0xFF666666), fontSize: 12),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.build, size: 12, color: Color(0xFF666666)),
                    SizedBox(width: 4),
                    Text(
                      job.issue,
                      style: TextStyle(fontSize: 11, color: Color(0xFF666666)),
                    ),
                    Spacer(),
                    Icon(Icons.attach_money, size: 12, color: Colors.green),
                    SizedBox(width: 4),
                    Text(
                      job.earnings,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              Row(
                children: List.generate(
                  5,
                  (index) => Icon(
                    Icons.star,
                    size: 12,
                    color: index < job.rating ? Colors.amber : Colors.grey[300],
                  ),
                ),
              ),
              SizedBox(height: 4),
              Text(
                job.completedDate,
                style: TextStyle(fontSize: 10, color: Color(0xFF666666)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScheduledJobsTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.calendar_today,
            size: 64,
            color: Color(0xFF7E57C2).withOpacity(0.3),
          ),
          SizedBox(height: 16),
          Text(
            'Scheduled Jobs',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF333333),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'No upcoming scheduled jobs',
            style: TextStyle(color: Color(0xFF666666)),
          ),
        ],
      ),
    );
  }
}

class ChatScreen extends StatelessWidget {
  final List<ChatMessage> messages = [
    ChatMessage(
      sender: 'Emma Wilson',
      message: 'Hi! How long until you arrive?',
      time: '10:30 AM',
      isMe: false,
    ),
    ChatMessage(
      sender: 'You',
      message: 'I\'ll be there in about 10 minutes. Traffic is light.',
      time: '10:31 AM',
      isMe: true,
    ),
    ChatMessage(
      sender: 'Emma Wilson',
      message: 'Great! I\'ll be waiting. The car is the blue BMW X5.',
      time: '10:32 AM',
      isMe: false,
    ),
  ];

  ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildChatHeader(),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: messages.length,
            itemBuilder: (context, index) {
              return _buildMessageBubble(messages[index]);
            },
          ),
        ),
        _buildMessageInput(),
      ],
    );
  }

  Widget _buildChatHeader() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Color(0xFF7E57C2).withOpacity(0.1),
            child: Icon(Icons.person, color: Color(0xFF7E57C2)),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Emma Wilson',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF333333),
                  ),
                ),
                Text(
                  'BMW X5 • Brake Repair',
                  style: TextStyle(color: Color(0xFF666666), fontSize: 12),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.phone, color: Color(0xFF7E57C2)),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: message.isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (!message.isMe)
            CircleAvatar(radius: 12, child: Icon(Icons.person, size: 12)),
          if (!message.isMe) SizedBox(width: 8),
          Flexible(
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: message.isMe ? Color(0xFF7E57C2) : Color(0xFFF5F5F7),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!message.isMe)
                    Text(
                      message.sender,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF333333),
                        fontSize: 12,
                      ),
                    ),
                  Text(
                    message.message,
                    style: TextStyle(
                      color: message.isMe ? Colors.white : Color(0xFF333333),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    message.time,
                    style: TextStyle(
                      color: message.isMe ? Colors.white70 : Color(0xFF666666),
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (message.isMe) SizedBox(width: 8),
          if (message.isMe)
            CircleAvatar(
              radius: 12,
              backgroundColor: Color(0xFF7E57C2),
              child: Icon(Icons.person, size: 12, color: Colors.white),
            ),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Color(0xFFF5F5F7),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          CircleAvatar(
            backgroundColor: Color(0xFF7E57C2),
            child: IconButton(
              icon: Icon(Icons.send, color: Colors.white, size: 18),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          _buildProfileHeader(),
          SizedBox(height: 24),
          _buildStatsSection(),
          SizedBox(height: 24),
          _buildQuickActions(),
          SizedBox(height: 24),
          _buildMenuItems(),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Color(0xFF7E57C2).withOpacity(0.1),
            child: Icon(Icons.person, size: 40, color: Color(0xFF7E57C2)),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Alex Johnson',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF333333),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Senior Automotive Technician',
                  style: TextStyle(color: Color(0xFF666666)),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 6),
                          Text(
                            'Online',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    SizedBox(width: 4),
                    Text(
                      '4.8/5',
                      style: TextStyle(color: Color(0xFF666666), fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.edit, color: Color(0xFF7E57C2)),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('156', 'Total Jobs', Icons.assignment_turned_in),
          _buildStatItem('\$12.4K', 'Earnings', Icons.attach_money),
          _buildStatItem('96%', 'Success Rate', Icons.thumb_up),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, IconData icon) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFF7E57C2).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Color(0xFF7E57C2), size: 20),
        ),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF333333),
          ),
        ),
        Text(label, style: TextStyle(color: Color(0xFF666666), fontSize: 12)),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF333333),
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildProfileActionButton(
                  'Availability',
                  Icons.toggle_on,
                  Color(0xFF7E57C2),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildProfileActionButton(
                  'Documents',
                  Icons.folder,
                  Color(0xFF5E35B1),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildProfileActionButton(
                  'Settings',
                  Icons.settings,
                  Color(0xFF9C27B0),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileActionButton(String title, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                color: Color(0xFF333333),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItems() {
    final menuItems = [
      _MenuItem(Icons.work, 'My Services', 'Manage your service offerings'),
      _MenuItem(
        Icons.payment,
        'Payment Methods',
        'Bank accounts & payment setup',
      ),
      _MenuItem(Icons.analytics, 'Performance', 'View detailed analytics'),
      _MenuItem(Icons.calendar_today, 'Schedule', 'Manage your working hours'),
      _MenuItem(
        Icons.notifications,
        'Notifications',
        'Configure alert preferences',
      ),
      _MenuItem(Icons.help, 'Help & Support', 'Get assistance and guidance'),
      _MenuItem(
        Icons.security,
        'Privacy & Security',
        'Manage your account security',
      ),
      _MenuItem(
        Icons.logout,
        'Logout',
        'Sign out of your account',
        isLogout: true,
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: menuItems.map((item) => _buildProfileMenuTile(item)).toList(),
      ),
    );
  }

  Widget _buildProfileMenuTile(_MenuItem item) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: item.isLogout
              ? Color(0xFFF44336).withOpacity(0.1)
              : Color(0xFF7E57C2).withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          item.icon,
          color: item.isLogout ? Color(0xFFF44336) : Color(0xFF7E57C2),
          size: 20,
        ),
      ),
      title: Text(
        item.title,
        style: TextStyle(
          color: item.isLogout ? Color(0xFFF44336) : Color(0xFF333333),
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        item.subtitle,
        style: TextStyle(color: Color(0xFF666666), fontSize: 12),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: item.isLogout ? Color(0xFFF44336) : Color(0xFF666666),
      ),
      onTap: () {},
    );
  }
}

// Data Models
class ServiceRequest {
  final String id;
  final String customerName;
  final String vehicleType;
  final String issue;
  final String distance;
  final String eta;
  final String status;
  final String priority;

  ServiceRequest({
    required this.id,
    required this.customerName,
    required this.vehicleType,
    required this.issue,
    required this.distance,
    required this.eta,
    required this.status,
    required this.priority,
  });
}

class ActiveJob {
  final String id;
  final String customerName;
  final String vehicle;
  final String issue;
  final String status;
  final String timeElapsed;
  final String? location;

  ActiveJob({
    required this.id,
    required this.customerName,
    required this.vehicle,
    required this.issue,
    required this.status,
    required this.timeElapsed,
    this.location,
  });
}

class CompletedJob {
  final String id;
  final String customerName;
  final String vehicle;
  final String issue;
  final String completedDate;
  final String earnings;
  final int rating;

  CompletedJob({
    required this.id,
    required this.customerName,
    required this.vehicle,
    required this.issue,
    required this.completedDate,
    required this.earnings,
    required this.rating,
  });
}

class ChatMessage {
  final String sender;
  final String message;
  final String time;
  final bool isMe;

  ChatMessage({
    required this.sender,
    required this.message,
    required this.time,
    required this.isMe,
  });
}

class _MenuItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isLogout;

  _MenuItem(this.icon, this.title, this.subtitle, {this.isLogout = false});
}
