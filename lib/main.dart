import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'modals/about_modal.dart';
import 'modals/contact_modal.dart';
import 'modals/privacy_modal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
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

  void showModal(BuildContext context, Widget modal) {
    showDialog(
      context: context,
      builder: (BuildContext context) => modal,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color.fromRGBO(229, 208, 172, 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Image.asset(
                'assets/images/EARIST_Logo.png',
                height: 100,
              ),
              SizedBox(height: 10),
              Text(
                "H.R.I.S.",
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromRGBO(163, 29, 29, 1),
                ),
              ),
              SizedBox(height: 0),

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
                    margin: EdgeInsets.only(top: 135),
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(254, 249, 225, 1),
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
                        SizedBox(height: 40),
                        TextField(
                          decoration: InputDecoration(
                            labelText: "Username",
                            labelStyle: GoogleFonts.poppins(
                              color: const Color.fromRGBO(163, 29, 29, 1),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: const Color.fromRGBO(163, 29, 29, 1),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),

                        TextField(
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            labelText: "Password",
                            labelStyle: GoogleFonts.poppins(
                              color: const Color.fromRGBO(163, 29, 29, 1),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: const Color.fromRGBO(163, 29, 29, 1),
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

                        SizedBox(height: 15),
                        TextButton(
                          onPressed: () {

                          },
                          child: Text(
                            "Forgot password?",
                            style: GoogleFonts.poppins(
                              color: const Color.fromRGBO(163, 29, 29, 1),
                              fontStyle: FontStyle.italic,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {

                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(163, 29, 29, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            side: BorderSide(
                              color: const Color.fromRGBO(109, 35, 35, 1),
                              width: 1,
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                            minimumSize: Size(double.infinity, 50),
                          ),
                          child: Text(
                            "Log in",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: const Color.fromRGBO(229, 208, 172, 1),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        OutlinedButton(
                          onPressed: () {

                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(229, 208, 172, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            side: BorderSide(
                              color: const Color.fromRGBO(163, 29, 29, 1),
                              width: 1,
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                            minimumSize: Size(double.infinity, 50),
                          ),
                          child: Text(
                            "Sign Up",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: const Color.fromRGBO(163, 29, 29, 1),
                            ),
                          ),
                        ),
                        SizedBox(height: 100),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () => showModal(context, AboutModal()),
                              child: Text(
                                "About",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: const Color.fromRGBO(163, 29, 29, 1),
                                ),
                              ),
                            ),
                            Text("|", style: GoogleFonts.poppins(fontSize: 12, color: const Color.fromRGBO(163, 29, 29, 1))),
                            TextButton(
                              onPressed: () => showModal(context, ContactModal()),
                              child: Text(
                                "Contact",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: const Color.fromRGBO(163, 29, 29, 1),
                                ),
                              ),
                            ),
                            Text("|", style: GoogleFonts.poppins(fontSize: 12, color: const Color.fromRGBO(163, 29, 29, 1))),
                            TextButton(
                              onPressed: () => showModal(context, PrivacyModal()),
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

                        SizedBox(height: 20),
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
