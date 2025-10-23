import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class InsuranceRegistrationPage extends StatefulWidget {
  const InsuranceRegistrationPage({super.key});

  @override
  _InsuranceRegistrationPageState createState() => _InsuranceRegistrationPageState();
}

class _InsuranceRegistrationPageState extends State<InsuranceRegistrationPage> {
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _companyIdController = TextEditingController();
  TextEditingController password = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactInfoController = TextEditingController();

  bool _isLoading = false;

  void _register() async {
    setState(() {
      _isLoading = true;
    });
    
    await Future.delayed(Duration(seconds: 2));
    
    setState(() {
      _isLoading = false;
    });
    
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: password.text, // In real app, get password from user
      ).then((userCredential) {
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
      }).catchError((error) {
        // Handle registration error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registration Failed: ${error.message}'),
            backgroundColor: Colors.red,
          ),
        );
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            Container(
              height: 250,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple[800]!, Colors.purple[600]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.business,
                      size: 60,
                      color: Colors.white,
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Company Registration',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Join our insurance network',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Registration Form
            Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                children: [
                   TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      prefixIcon: Icon(Icons.email, color: Colors.purple),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),
                   TextField(
                    controller: password,
                    decoration: InputDecoration(
                      labelText: 'enter Password',
                      prefixIcon: Icon(Icons.lock, color: Colors.purple),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Company Name Field
                  TextField(
                    controller: _companyNameController,
                    decoration: InputDecoration(
                      labelText: 'Company Name',
                      prefixIcon: Icon(Icons.business, color: Colors.purple),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Company ID Field
                  TextField(
                    controller: _companyIdController,
                    decoration: InputDecoration(
                      labelText: 'Company ID',
                      prefixIcon: Icon(Icons.badge, color: Colors.purple),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Contact Info Field
                  TextField(
                    controller: _contactInfoController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'Contact Information',
                      prefixIcon: Icon(Icons.contact_phone, color: Colors.purple),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Phone, Email, Address...',
                    ),
                  ),

                  SizedBox(height: 30),

                  // Benefits Card
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.purple[50],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.purple[100]!),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.star, color: Colors.purple, size: 20),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Get access to our partner network and insurance services',
                            style: TextStyle(
                              color: Colors.purple[700],
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 30),

                  // Register Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _register,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: _isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                              'REGISTER COMPANY',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Login Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already registered? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Login here',
                          style: TextStyle(
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
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
      ),
    );
  }
}