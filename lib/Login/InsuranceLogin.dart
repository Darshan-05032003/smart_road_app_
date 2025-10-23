

import 'package:firebase_auth/firebase_auth.dart';


import 'package:flutter/material.dart';
import 'package:smart_roadside/Insurance/insurance.dart';
import 'package:smart_roadside/Login/InsuranceRegister.dart';

class InsuranceLoginPage extends StatefulWidget {
  const InsuranceLoginPage({super.key});

  @override
  _InsuranceLoginPageState createState() => _InsuranceLoginPageState();
}

class _InsuranceLoginPageState extends State<InsuranceLoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  bool _isLoading = false;
  bool _obscureText = true;

  void _login() async {
    setState(() {
      _isLoading = true;
    });
    
    await Future.delayed(Duration(seconds: 2));
    
    setState(() {
      _isLoading = false;
    });
    
    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    ).then((userCredential) {
      // Login successful, navigate to dashboard
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>InsuranceDashboard()));
    }).catchError((error) {
      // Handle login error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed. Please check your credentials.')),
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
              height: 300,
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
                      Icons.security,
                      size: 70,
                      color: Colors.white,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Insurance Login',
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Secure your future with us',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Login Form
            Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                children: [
                  // Email Field
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email / Policy Number',
                      prefixIcon: Icon(Icons.person, color: Colors.purple),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Password Field
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock, color: Colors.purple),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText ? Icons.visibility : Icons.visibility_off,
                          color: Colors.purple,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  SizedBox(height: 10),

                  // Forgot Password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.purple),
                      ),
                    ),
                  ),

                  SizedBox(height: 30),

                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: _isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                              'LOGIN',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Register Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>InsuranceRegistrationPage()));
                        },
                        child: Text(
                          'Register',
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