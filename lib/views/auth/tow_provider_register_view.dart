import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TowProviderRegistrationPage extends StatefulWidget {
  const TowProviderRegistrationPage({super.key});

  @override
  _TowProviderRegistrationPageState createState() =>
      _TowProviderRegistrationPageState();
}

class _TowProviderRegistrationPageState
    extends State<TowProviderRegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _driverNameController = TextEditingController();
  TextEditingController password = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _truckNoController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  bool _isLoading = false;
  String? _selectedTruckType;

  final List<String> _truckTypes = [
    'Flatbed Tow Truck',
    'Hook and Chain',
    'Wheel Lift',
    'Integrated Tow Truck',
    'Heavy Duty',
    'Light Duty',
  ];

  void _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      await Future.delayed(Duration(seconds: 2));

      setState(() {
        _isLoading = false;
      });

      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: _emailController.text,
            password: password.text, // In real app, get password from user
          )
          .then((userCredential) {
            // Registration successful, navigate to login or dashboard
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Registration Successful! Please log in.'),
                backgroundColor: Colors.green,
              ),
            );
            _emailController.clear();
            password.clear();
            Navigator.pop(context);
          })
          .catchError((error) {
            // Handle registration error
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Registration Failed: ${error.message}'),
                backgroundColor: Colors.red,
              ),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 40),

              // Header
              _buildHeader(),

              SizedBox(height: 30),

              // Registration Form
              _buildRegistrationForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple[700]!, Colors.purple[500]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.purple.withOpacity(0.3),
                blurRadius: 15,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Icon(Icons.local_shipping, size: 45, color: Colors.white),
        ),
        SizedBox(height: 20),
        Text(
          'Join as Tow Provider',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.purple[800],
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Start providing roadside assistance services',
          style: TextStyle(color: Colors.grey[600], fontSize: 15),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildRegistrationForm() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: EdgeInsets.all(25),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Email Field
              _buildTextField(
                controller: _emailController,
                label: 'Enter Email',
                icon: Icons.email,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              // Tow Truck No. Field
              _buildTextField(
                controller: password,
                label: 'Enter Password',
                icon: Icons.confirmation_number_outlined,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter password';
                  }
                  return null;
                },
              ),
              // Driver Name Field
              _buildTextField(
                controller: _driverNameController,
                label: 'Driver Name',
                icon: Icons.person_outline,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter driver name';
                  }
                  return null;
                },
              ),

              SizedBox(height: 20),

              // Tow Truck No. Field
              _buildTextField(
                controller: _truckNoController,
                label: 'Tow Truck Number',
                icon: Icons.confirmation_number_outlined,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter truck number';
                  }
                  return null;
                },
              ),

              SizedBox(height: 20),

              // Truck Type Dropdown
              _buildTruckTypeDropdown(),

              SizedBox(height: 20),

              // Location Field
              _buildLocationField(),

              SizedBox(height: 30),

              // Features List
              _buildFeaturesList(),

              SizedBox(height: 30),

              // Register Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple[600],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    shadowColor: Colors.purple.withOpacity(0.3),
                  ),
                  child: _isLoading
                      ? SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.local_shipping, size: 20),
                            SizedBox(width: 10),
                            Text(
                              'REGISTER AS TOW PROVIDER',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                ),
              ),

              SizedBox(height: 20),

              // Login Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already registered? ",
                    style: TextStyle(color: Colors.grey[600], fontSize: 15),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Login here',
                      style: TextStyle(
                        color: Colors.purple[600],
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey[600]),
        prefixIcon: Icon(icon, color: Colors.purple[400]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.purple[400]!, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
    );
  }

  Widget _buildTruckTypeDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedTruckType,
      decoration: InputDecoration(
        labelText: 'Truck Type',
        labelStyle: TextStyle(color: Colors.grey[600]),
        prefixIcon: Icon(Icons.build_outlined, color: Colors.purple[400]),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.purple[400]!, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
      items: _truckTypes.map((String type) {
        return DropdownMenuItem<String>(value: type, child: Text(type));
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectedTruckType = newValue;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select truck type';
        }
        return null;
      },
    );
  }

  Widget _buildLocationField() {
    return TextFormField(
      controller: _locationController,
      maxLines: 2,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your location';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'Service Location',
        labelStyle: TextStyle(color: Colors.grey[600]),
        prefixIcon: Icon(Icons.location_on_outlined, color: Colors.purple[400]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.purple[400]!, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey[50],
        hintText: 'Enter your service area or address...',
      ),
    );
  }

  Widget _buildFeaturesList() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.purple[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.purple[100]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.star_outline, color: Colors.purple[600], size: 18),
              SizedBox(width: 8),
              Text(
                'Why Join Us?',
                style: TextStyle(
                  color: Colors.purple[700],
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          _buildFeatureItem('24/7 Emergency Requests'),
          _buildFeatureItem('Real-time Job Notifications'),
          _buildFeatureItem('Competitive Pricing'),
          _buildFeatureItem('GPS Navigation Support'),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.purple[400], size: 16),
          SizedBox(width: 8),
          Text(text, style: TextStyle(color: Colors.purple[700], fontSize: 13)),
        ],
      ),
    );
  }
}
