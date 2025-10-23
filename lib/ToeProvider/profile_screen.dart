import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreen createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  // Text controllers for editable fields
  final TextEditingController _nameController = TextEditingController(text: 'Michael Smith');
  final TextEditingController _emailController = TextEditingController(text: '+1 (555) 123-4567');
  final TextEditingController _vehicleController = TextEditingController(text: 'Truck Type A');
  final TextEditingController _locationController = TextEditingController(text: 'New York, USA');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Driver Profile'),
        backgroundColor: Color(0xFF7E57C2),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _buildProfileHeader(),
            SizedBox(height: 24),
            _buildStatsSection(),
            SizedBox(height: 24),
            _buildProfileFields(),
            SizedBox(height: 24),
            _buildMenuItems(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 2))],
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
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Driver Name',
                  ),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xFF333333)),
                ),
                SizedBox(height: 4),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Email / Phone',
                  ),
                  style: TextStyle(color: Color(0xFF666666)),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Color(0xFF4CAF50).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Verified User',
                    style: TextStyle(color: Color(0xFF4CAF50), fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    final stats = {
      'Total Services': '12',
      'Avg Rating': '4.8',
      'Avg Response': '15min',
    };

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 2))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: stats.entries.map((e) => _buildStatItem(e.value, e.key)).toList(),
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFF7E57C2))),
        SizedBox(height: 4),
        Text(label, style: TextStyle(color: Color(0xFF666666), fontSize: 12)),
      ],
    );
  }

  Widget _buildProfileFields() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 2))],
      ),
      child: Column(
        children: [
          _buildField('Vehicle Info', _vehicleController, Icons.directions_car_rounded),
          SizedBox(height: 16),
          _buildField('Location', _locationController, Icons.location_on_rounded),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _saveProfile,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF7E57C2),
              minimumSize: Size(double.infinity, 50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text('Save Changes'),
          ),
        ],
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller, IconData icon) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Color(0xFF7E57C2)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0xFF7E57C2)),
        ),
      ),
    );
  }

  Widget _buildMenuItems() {
    final menuItems = [
      _MenuItem(Icons.history, 'Service History', Icons.chevron_right),
      _MenuItem(Icons.notifications, 'Notifications', Icons.chevron_right),
      _MenuItem(Icons.settings, 'Settings', Icons.chevron_right),
      _MenuItem(Icons.logout, 'Logout', Icons.chevron_right, isLogout: true),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 2))],
      ),
      child: Column(children: menuItems.map((item) => _buildMenuTile(item)).toList()),
    );
  }

  Widget _buildMenuTile(_MenuItem item) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: item.isLogout ? Color(0xFFF44336).withOpacity(0.1) : Color(0xFF7E57C2).withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(item.icon, color: item.isLogout ? Color(0xFFF44336) : Color(0xFF7E57C2), size: 20),
      ),
      title: Text(
        item.title,
        style: TextStyle(color: item.isLogout ? Color(0xFFF44336) : Color(0xFF333333), fontWeight: FontWeight.w500),
      ),
      trailing: Icon(item.trailingIcon, color: item.isLogout ? Color(0xFFF44336) : Color(0xFF666666)),
      onTap: () {},
    );
  }

  void _saveProfile() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Profile updated successfully!'), backgroundColor: Colors.green),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _vehicleController.dispose();
    _locationController.dispose();
    super.dispose();
  }
}

class _MenuItem {
  final IconData icon;
  final String title;
  final IconData trailingIcon;
  final bool isLogout;

  _MenuItem(this.icon, this.title, this.trailingIcon, {this.isLogout = false});
}

 