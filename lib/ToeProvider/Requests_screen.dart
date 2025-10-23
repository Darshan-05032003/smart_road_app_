import 'package:flutter/material.dart';

// ================== ACTIVE REQUESTS SCREEN ==================
class ActiveRequestsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> requests = [
    {
      'customer': 'Michael Smith',
      'vehicleType': 'Car',
      'issueType': 'Flat Tire',
      'description': 'Front left tire punctured.',
      'location': '123 Main Street, Downtown',
      'eta': '8 min',
      'distance': 2.4,
    },
    {
      'customer': 'Jessica Lee',
      'vehicleType': 'SUV',
      'issueType': 'Battery Issue',
      'description': 'Car won\'t start.',
      'location': '456 Park Avenue',
      'eta': '12 min',
      'distance': 4.1,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Active Requests')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: requests.length,
        itemBuilder: (context, index) {
          final req = requests[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProviderRequestScreen(requestData: req),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.local_shipping, color: Color(0xFF7E57C2), size: 32),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(req['customer'], style: const TextStyle(fontWeight: FontWeight.w600)),
                        const SizedBox(height: 4),
                        Text('${req['vehicleType']} • ${req['issueType']}', style: TextStyle(color: Colors.grey[700])),
                        const SizedBox(height: 2),
                        Text('Distance: ${req['distance']} km • ETA: ${req['eta']}', style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right, color: Colors.grey[400]),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ================== PROVIDER REQUEST SCREEN ==================
class ProviderRequestScreen extends StatefulWidget {
  final Map<String, dynamic> requestData;
  const ProviderRequestScreen({super.key, required this.requestData});

  @override
  _ProviderRequestScreenState createState() => _ProviderRequestScreenState();
}

class _ProviderRequestScreenState extends State<ProviderRequestScreen> {
  bool accepted = false;

  @override
  Widget build(BuildContext context) {
    final req = widget.requestData;

    return Scaffold(
      appBar: AppBar(title: const Text('Incoming Request')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoCard('Customer', req['customer']),
            const SizedBox(height: 12),
            _buildInfoCard('Vehicle Type', req['vehicleType']),
            const SizedBox(height: 12),
            _buildInfoCard('Issue Type', req['issueType']),
            const SizedBox(height: 12),
            _buildInfoCard('Description', req['description']),
            const SizedBox(height: 12),
            _buildInfoCard('Location', req['location']),
            const SizedBox(height: 12),
            _buildInfoCard('ETA', req['eta']),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _buildActionButton('Reject', Colors.red, () => Navigator.pop(context)),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildActionButton('Accept', Colors.green, () {
                    setState(() => accepted = true);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => InProgressScreen(
                          customerName: req['customer'],
                          location: req['location'],
                          eta: req['eta'],
                          distance: req['distance'],
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildActionButton(String text, Color color, VoidCallback onTap) {
    return SizedBox(
      height: 56,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: color),
        onPressed: onTap,
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
      ),
    );
  }
}

// ================== IN PROGRESS SCREEN ==================
class InProgressScreen extends StatefulWidget {
  final String customerName;
  final String location;
  final String eta;
  final double distance;

  const InProgressScreen({
    super.key,
    required this.customerName,
    required this.location,
    required this.eta,
    required this.distance,
  });

  @override
  State<InProgressScreen> createState() => _InProgressScreenState();
}

class _InProgressScreenState extends State<InProgressScreen> {
  bool completed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Service In Progress')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F7),
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  image: NetworkImage('https://via.placeholder.com/400x200?text=Live+Map+Tracking'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.person, color: Color(0xFF7E57C2)),
              title: Text(widget.customerName, style: const TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Text(widget.location),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Distance: ${widget.distance} km', style: const TextStyle(fontSize: 14)),
                Text('ETA: ${widget.eta}', style: const TextStyle(fontSize: 14)),
              ],
            ),
            const SizedBox(height: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.navigation),
                  label: const Text('Navigate to Customer'),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF7E57C2)),
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  icon: const Icon(Icons.check_circle),
                  label: Text(completed ? 'Completed' : 'Mark as Completed'),
                  onPressed: completed ? null : () {
                    setState(() => completed = true);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Service Completed!')),
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: completed ? Colors.grey : const Color(0xFF4CAF50)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
