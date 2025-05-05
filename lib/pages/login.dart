import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http; 
import 'dart:developer' as developer;
import 'dart:convert'; 
import 'package:hris_mobile/modals/forgotpassword_modal.dart';
import 'package:hris_mobile/modals/about_modal.dart';
import 'package:hris_mobile/modals/contact_modal.dart';
import 'package:hris_mobile/modals/privacy_modal.dart';
import 'package:hris_mobile/pages/dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false; 
  String _errorMessage = ''; 

  void showModal(BuildContext context, Widget modal) {
    showDialog(
      context: context,
      builder: (BuildContext context) => modal,
    );
  }

  Future<void> _login() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter both username and password.',
            style: GoogleFonts.poppins(),
          ),
          backgroundColor: const Color.fromRGBO(163, 29, 29, 1),
        ),
      );
      return; 
    }

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final response = await http.post(
        Uri.parse('http://localhost:5000/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'password': password,
        }),
      );

      if (!mounted) return;

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        developer.log('Login successful: ${data['user']}');

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
        );
      } else {
        final data = json.decode(response.body);
        setState(() {
          _errorMessage = data['message'];
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _errorMessage,
              style: GoogleFonts.poppins(),
            ),
            backgroundColor: const Color.fromRGBO(163, 29, 29, 1),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'An error occurred. Please try again.';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _errorMessage,
            style: GoogleFonts.poppins(),
          ),
          backgroundColor: const Color.fromRGBO(163, 29, 29, 1),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _forgotPassword() {
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const ForgotPasswordModal();
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(229, 208, 172, 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Image.asset(
                'assets/images/EARIST_Logo.png',
                height: 100,
              ),
              const SizedBox(height: 10),
              Text(
                "H.R.I.S.",
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromRGBO(163, 29, 29, 1),
                ),
              ),
              Stack(
                alignment: Alignment.topCenter,
                clipBehavior: Clip.none,
                children: [
                  Image.asset(
                    'assets/images/EARIST.png',
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 135),
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(254, 249, 225, 1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Log in Account",
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromRGBO(163, 29, 29, 1),
                          ),
                        ),
                        const SizedBox(height: 40),
                        TextField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: "Username",
                            labelStyle: GoogleFonts.poppins(
                              color: const Color.fromRGBO(163, 29, 29, 1),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(163, 29, 29, 1),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _passwordController,
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: "Password",
                            labelStyle: GoogleFonts.poppins(
                              color: const Color.fromRGBO(163, 29, 29, 1),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(163, 29, 29, 1),
                              ),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: const Color.fromRGBO(163, 29, 29, 1),
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: _forgotPassword,
                            child: Text(
                              "Forgot password?",
                              style: GoogleFonts.poppins(
                                color: const Color.fromRGBO(163, 29, 29, 1),
                                fontStyle: FontStyle.italic,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        _isLoading
                            ? const CircularProgressIndicator()
                            : ElevatedButton(
                                onPressed: _login,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromRGBO(163, 29, 29, 1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  side: const BorderSide(
                                    color: Color.fromRGBO(109, 35, 35, 1),
                                    width: 1,
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                                  minimumSize: const Size(double.infinity, 50),
                                ),
                                child: Text(
                                  "Log in",
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    color: const Color.fromRGBO(229, 208, 172, 1),
                                  ),
                                ),
                              ),
                        const SizedBox(height: 100),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () => showModal(context, const AboutModal()),
                              child: Text(
                                "About",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: const Color.fromRGBO(163, 29, 29, 1),
                                ),
                              ),
                            ),
                            Text("|",
                                style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: const Color.fromRGBO(163, 29, 29, 1))),
                            TextButton(
                              onPressed: () => showModal(context, const ContactModal()),
                              child: Text(
                                "Contact",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: const Color.fromRGBO(163, 29, 29, 1),
                                ),
                              ),
                            ),
                            Text("|",
                                style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: const Color.fromRGBO(163, 29, 29, 1))),
                            TextButton(
                              onPressed: () => showModal(context, const PrivacyModal()),
                              child: Text(
                                "Privacy Policy",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: const Color.fromRGBO(163, 29, 29, 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),  
                        Text(
                          "© EARIST Human Resource Information System 2025",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color.fromRGBO(163, 29, 29, 1),
                          ),
                        ),
                      ],
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
}
